//+------------------------------------------------------------------+
//|                                               TestMarketBook.mq5 |
//|                                                             yyd0 |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "yyd0"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Canvas\Charts\HistogramChart.mqh>
CHistogramChart chart;
int OnInit()
  {
   if(!chart.CreateBitmapLabel("HistogramChart",20,20,200,300))
     {
      Print("Error creating histogram chart: ",GetLastError());
      return(-1);
     }


   double arr[2];

   chart.VScaleParams(300,0,20);
   chart.ShowValue(false);
   chart.ShowScaleTop(false);
   chart.ShowScaleBottom(false);
   chart.ShowScaleRight(false);

   chart.ShowLegend();

   arr[0] = 0;
   arr[1] = 0;
   chart.SeriesAdd(arr,"Item1",clrGreen);
   Print("MarketBookAdd ", MarketBookAdd(_Symbol));
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   chart.Destroy();
   Print("MarketBookRelease ",MarketBookRelease(_Symbol));
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
   MqlBookInfo priceArray[];
   bool getBook=MarketBookGet(_Symbol,priceArray);
   if(getBook)
     {
      int size=ArraySize(priceArray);
      long volumeBuy=0;
      long volumeSell=0;
      for(int i=0; i<size; i++)
        {
         if(priceArray[i].type==BOOK_TYPE_SELL)
           {
            volumeSell+=priceArray[i].volume;
            //Print(" BOOK_TYPE_SELL i = ",i, " volume = ", priceArray[i].volume);
           }
         else
            if(priceArray[i].type==BOOK_TYPE_BUY)
              {
               volumeBuy+=priceArray[i].volume;
               //Print(" BOOK_TYPE_BUY i = ",i, " volume = ", priceArray[i].volume);
              }

        }
      //double a = pow(10,_Digits);

      //chart.ValueUpdate(0,0,volumeBuy/1000000);
      //chart.ValueUpdate(0,1,volumeSell/1000000);
      Print(" volumeBuy = ",volumeBuy, " volumeSell = ", volumeSell, " volumeDistance = ", volumeBuy-volumeSell);
      long k1 = volumeBuy/100000;
      long k2 = volumeSell/100000;
      chart.ValueUpdate(0,0,k1);
      chart.ValueUpdate(0,1,k2);
      Print(" k1 = ",k1, " k2 = ", k2);
     }

  }

//+------------------------------------------------------------------+
