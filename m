Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135180AbRDLNEY>; Thu, 12 Apr 2001 09:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbRDLNEP>; Thu, 12 Apr 2001 09:04:15 -0400
Received: from nl-mail-dmz.cmg-gecis.nl ([195.109.155.100]:54793 "EHLO
	nl-irelay.cmg.nl") by vger.kernel.org with ESMTP id <S135180AbRDLNDy>;
	Thu, 12 Apr 2001 09:03:54 -0400
Message-ID: <B569A4D2254ED2119FE500104BC1D5CD01294157@NL-EIN-MAIL01>
From: Remko van der Vossen <remko.van.der.vossen@cmg.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'npunmia@hss.hns.com'" <npunmia@hss.hns.com>
Subject: RE: RTC !!
Date: Thu, 12 Apr 2001 15:05:50 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

I made some errors in my last code here's the correction

Niraj wrote:
> The RTC interrupt  is programmable from 2 Hz to 8192 Hz, in 
> powers of 2. So the interrupts that you could get are one
> of the following:      0.122ms, .244ms, .488ms, .977ms,
> 1.953ms, 3.906ms, 7.813ms, and so on.    Is there any  
> workaround , so that i can use RTC for meeting my
> requirement of an interrupt every 1.666..ms!!  
> ( I know that i can use UTIME or #define HZ 600, but i want
> to know if i can use RTC for this purpose )

It's pretty simple actually, the finest granularity of the 
RTC interrupt is 0.122 ms, so if you want to use a 600 Hz 
timer you'd just have to see if that fits...
1.666/0.122 = 13.656 so it doesn't fit, the best you can do 
is 1000/(0.122*14) = 585.48 Hz you could implement this 
pretty simple, just make a counter, and increment this 
counter every time you receive an interrupt, afther 
incrementing the counter you simply check to see if it is 14, 
if so reset it to 0 and call the real interrupt handler... 
That's the best you can do with a granularity of 0.122 ms, as 
simple as that...
Ofcourse this timer would operate at an increasing time 
difference if you really need a 600Hz timer so it wouldn't be 
much good...
The thing you could do is use a timer operating at a 
frequency of half the allowed tolerance, ie in you case that 
would be a timer of max 0.4ms (half the frequency is twice 
the period) so we'd have to use the 0.244 timer here. Now 
every time you get this interrupt you request the actual time 
from the RTC and if this time is withing half the duration of 
your period (0.122 ms in this case) from your targetted time 
then you call the actual interrupt... You could optimize this 
just a bit by adding a counter so you don't have to call on 
the RTC at every interrupt, I think it'd be a bit to costly...

So, after this whole probably terribly confusing story I 
think I'll give a scenario...

here's how it should go:

inttime expect  diff     action
t0.000  t0.000  t 0.000  ==> interrupt call
t0.244  t1.666  t-1.422
t0.488  t1.666  t-1.178
t0.732  t1.666  t-0.934
t0.976  t1.666  t-0.690
t1.220  t1.666  t-0.446
t1.464  t1.666  t-0.202
t1.708  t1.666  t 0.042  ==> interrupt call
t1.952  t3.333  t-1.381
t2.196  t3.333  t-1.137
t2.440  t3.333  t-0.893
t2.684  t3.333  t-0.649
t2.928  t3.333  t-0.405
t3.172  t3.333  t-0.161
t3.416  t3.333  t 0.083  ==> interrupt call
t3.660  t5.000  t-1.340
t3.904  t5.000  t-1.096
t4.148  t5.000  t-0.852
t4.392  t5.000  t-0.608
t4.636  t5.000  t-0.364
t4.880  t5.000  t-0.120  ==> interrupt call
t5.124  t6.666  t-1.542

you can see that the difference at the point of interrupt 
trigger slightly increases every interrupt, at a certain 
point this difference will be more than 0.122 ms and then the 
interrupt before that one will be actually triggering the 
interrupt as that one is then closer to the targetted 
interrupt time, this way you are ensured that the maximum 
difference between interrupt trigger time and actual time is 
no more than 0.122 ms. The drawback in a straigtforward 
implementation of this is that the RTC is accessed every time 
an interrupt occurs, this can be optimized by adding a timer. 
I'll demonstrate in the following (pseudo) code:


assumptions:
  -gettime returns the current time in microseconds
  -there are bound te be errors in this code as I wrote it off
   the top of my head

typedef void (*tcb)( void );  //Timer callback function prototype

int32 ttime; //targetted time  (microseconds)
int32 tfreq; //timer freq      (microseconds)
int32 ttol;  //timer tolerance (microseconds)
int32 httf;  //half timer tick frequency (microseconds)
int32 mtick; //minimum RTC ticks to next timer event
int32 etick; //elapsed RTC ticks since last timer event
tcb   tmrcb; //Timer callback function

void rtcinthandler( void ) {
  //increase etick and check if a possible timer event should
  //be investigated
  if (++etick >= mtick) {
    int32 ctime = gettime();
    //check for a timer event
    if ((ctime - ttime + httf) < (httf * 2)) {
      //We've got a winner, reinit variable and call
      //callback handler
      etick = 0;
      //We recalculate ttime to prevent increasing rounding errors
      ttime = (ctime * tfreq / 1000000 + 1) * 1000000 / tfreq;
      tmrcb();
    }
  }
}

void inittimer(tcb acallback, int32 atfreq, int32 attol) {
  int32 tempval;
  int32 prevttime; //previous targetted time
  int32 ctime = gettime(); //current time

  /*todo: disable the timer if it was already running*/
  tfreq = atfreq;
  ttol = attol;
  tmrcb = acallback;
  //this is probably a very difficult way to calculate the
  //httf, but at the moment I can't come up with anything
  //better
  httf = 0;
  tempval = ttol / 112;
  while (tempval / 2)
    httf++;
  httf *= 112;
  //calculate the targetted time of the next tick..
  //the next statements may seem weird but if we require
  //the integer rounding to get the right times...
  prevttime = ctime * tfreq / 1000000 * 1000000 / tfreq;
  ttime = (ctime * tfreq / 1000000 + 1) * 1000000 / tfreq;
  //calculate the elapsed ticks since last ttime
  etick = (ctime - prevttime + httf) / (httf * 2);
  //calculate the minimum ticks between timer events
  mtick = 1000000 / (tfreq * httf * 2) - 1;
  /*todo: start the actual timer*/
}

Bye,

Remko van der Vossen
CMG Eindhoven
Remko.van.der.Vossen@cmg.nl
