Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269101AbRHBQiL>; Thu, 2 Aug 2001 12:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267985AbRHBQiC>; Thu, 2 Aug 2001 12:38:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4341 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S269090AbRHBQht>; Thu, 2 Aug 2001 12:37:49 -0400
Message-ID: <3B698177.C12183CF@mvista.com>
Date: Thu, 02 Aug 2001 09:36:07 -0700
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
In-Reply-To: <Pine.LNX.4.30.0108020928230.2340-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Wed, 1 Aug 2001, george anzinger wrote:
> 
> > > Never set the next hit of the timer to (now + MIN_INTERVAL).
> >
> > The overhead under load is _not_ the timer interrupt, it is the context
> > switch that needs to set up a "slice" timer, most of which never
> > expire.  During a kernel compile on an 800MHZ PIII I am seeing ~300
> > context switches per second (i.e. about every 3 ms.)   Clearly the
> > switching is being caused by task blocking.  With the ticked system the
> > "slice" timer overhead is constant.
> 
> Can you instead just not set up a reschedule timer if the timer at the
> head of the list is less than MIN_INTERVAL?
> 
> if(slice_timer_needed)
> {
>         if(time_until(next_timer)>TASK_SLICE)
>         {
>                 next_timer=jiffies()+TASK_SLICE;
>                 add_timer(TASK_SLICE);
>         }
>         slice_timer_needed=0;
> }
> 
Ok, but then what?  The head timer expires.  Now what?  Since we are not
clocking the slice we don't know when it started.  Seems to me we are
just shifting the overhead to a different place and adding additional
tests and code to do it.  The add_timer() code is fast.  The timing
tests (800MHZ PIII) show the whole setup taking an average of about 1.16
micro seconds.  the problem is that this happens, under kernel compile,
~300 times per second, so the numbers add up.  Note that the ticked
system timer overhead (interrupts, time keeping, timers, the works) is
about 0.12% of the available cpu.  Under heavy load this raises to about
0.24% according to my measurments.  The tick less system overhead under
the same kernel compile load is about 0.12%.  No load is about 0.012%,
but heavy load can take it to 12% or more, most of this comming from the
accounting overhead in schedule().  Is it worth it?

George
