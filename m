Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269155AbRHBVgp>; Thu, 2 Aug 2001 17:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbRHBVgf>; Thu, 2 Aug 2001 17:36:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50934 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S269155AbRHBVgX>; Thu, 2 Aug 2001 17:36:23 -0400
Message-ID: <3B69C394.4A0C20B9@mvista.com>
Date: Thu, 02 Aug 2001 14:18:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Rik van Riel <riel@conectiva.com.br>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <Pine.LNX.4.30.0108021322560.2340-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Thu, 2 Aug 2001, george anzinger wrote:
> 
> > Oliver Xymoron wrote:
> > >
> > > Does the higher timer granularity cause overall throughput to improve, by
> > > any chance?
> > >
> > Good question.  I have not run any tests for this.  You might want to do
> > so.  To do these tests you would want to build the system with the tick
> > less timers only and with the instrumentation turned off.  I would like
> > to hear the results.
> >
> > In the mean time, here is a best guess.  First, due to hardware
> > limitations, the longest time you can program the timer for is ~50ms.
> > This means you are reducing the load by a factor of 5.  Now the load
> > (i.e. timer overhead) is ~0.12%, so it would go to ~0.025%.  This means
> > that you should have about 0.1% more available for thru put.  Even if we
> > take 10 times this to cover the cache disruptions that no longer occur,
> > I would guess a thru put improvement of no more than 1%.  Still,
> > measurements are better that guesses...
> 
> That's not what I'm getting at at all. Simply raising HZ is known to
> improve throughput on many workloads, even with more reschedules: the
> system is able to more finely adapt to changes in available disk and
> memory bandwidth.
> 
> BTW, there are some arguments that tickless is worth doing even on old
> PIC-only systems:
> 
> http://groups.google.com/groups?q=oliver+xymoron+timer&hl=en&group=mlist.linux.kernel&safe=off&rnum=2&selm=linux.kernel.Pine.LNX.4.30.0104111337170.32245-100000%40waste.org
> 
> And I found this while I was looking too:
> 
> http://groups.google.com/groups?q=oliver+xymoron+timer&hl=en&group=mlist.linux.kernel&safe=off&rnum=3&selm=linux.kernel.Pine.LNX.4.10.10010241534110.2957-100000%40waste.org
> 
> ..but no one thought it was interesting at the time.
> 
I guess I am confused.  How is it that raising HZ improves throughput? 
And was that before or after the changes in the time slice routines that
now scale with HZ and before were fixed?  (That happened somewhere
around 2.2.14 or 2.2.16 or so.)  

I am writing a POSIX high-resolution-timers package and hope to have
timers that have resolution at least to 1 micro second, however, this is
independent of ticked or tick less.  

The PIT may be slow to program, but it not that slow.  My timing shows
it to be less than 0.62 micro seconds and this includes the micro second
to PIT count conversion.  At the same time (on an 800 MHz PIII) I see
interrupt overhead (time to execute an int xx to a do nothing interrupt
handler) to be ~6.5 micro seconds.  This turns out, in the tick less
case with a PIT reprogramming, to be more than half of the total average
timer interrupt time. (I.e. the timer interrupt handler + the time list
processing took about 6.1 micro seconds.  To this we add the interrupt
overhead to get 12.6 micro seconds total interrupt time.)

And yes, it is possible to do tick less with out the "tsc".  The KURT
package has the code to do it, along with the note that they don't think
many such machines will ever use their code...  My experiment/ patch
does not do this as it is just an experiment to see if tick less is
worth doing at all.  What I need to see to be convinced is a realistic
load that shows a measurable improvement with the tick less system.  The
system is there (http://sourceforge.net/projects/high-res-timers)
waiting for the load.

George
