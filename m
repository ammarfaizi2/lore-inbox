Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTAaA7Y>; Thu, 30 Jan 2003 19:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267662AbTAaA7Y>; Thu, 30 Jan 2003 19:59:24 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14835 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267659AbTAaA7X>;
	Thu, 30 Jan 2003 19:59:23 -0500
Message-ID: <3E39CC85.D9A339D0@mvista.com>
Date: Thu, 30 Jan 2003 17:08:21 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.4.21-pre4_tsc-lost-tick_A0
References: <1043972238.19049.27.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> 
> All,
>         Occasionally due to hardware or software, its possible to miss multiple
> timer interrupts. This can cause small inconsistencies in time as well
> as time drifting behind other systems.
> 
> This patch checks each timer interrupt, using the TSC, if we have missed
> any ticks. Then if so, compensates jiffies for them. I have already
> submitted a patch for 2.4 which does this for the cyclone-timer based
> code, and I've been testing a version for 2.5 for all time sources (in
> -mm6, I believe).
> 
> Since this code affects more users then the cyclone-based version, I
> want to be more careful and get more testing in the 2.5 tree before I
> submit this. However, just so people wanting it can play with it and
> test it themselves, I wanted to send this out for comments.
> 
> I'm already somewhat cautious that loops_per_jiffy isn't going to cut it
> with this patch (I'm thinking fast_gettimeoffset_quotient would probably
> be better). So please let me know if you find any issues with this
> patch.

I think you are wondering about the "/", as am I.  Possibly
a while loop, or, something like
fast_gettimeoffset_quotient, but scaled to do jiffies
instead of micro seconds.  Still you SHOULD be doing this so
seldom that one wonders if the "/" is all that bad.

Another thing, possibly not so easily fixed given the
division between "arch" code and common code, but I would
like to see jiffies updated in only ONE place.  With this
patch it is updated in .../kernel/timer.c AND in
.../arch/kernel/time.c.  In the high-res-timers patch I made
the jiffies update an inline in an "arch" header file so I
could have the best of both worlds, i.e. update from common
code using arch resources (TSC, etc).

-g
> 
> diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> --- a/arch/i386/kernel/time.c   Thu Jan 30 16:03:19 2003
> +++ b/arch/i386/kernel/time.c   Thu Jan 30 16:03:19 2003
> @@ -657,6 +657,7 @@
>         if(use_cyclone)
>                 mark_timeoffset_cyclone();
>         else if (use_tsc) {
> +               unsigned long delta = last_tsc_low;
>                 /*
>                  * It is important that these two operations happen almost at
>                  * the same time. We do the RDTSC stuff first, since it's
> @@ -700,6 +701,13 @@
>                    momentarily as they flip back to zero */
>                 if (count == LATCH) {
>                         count--;
> +               }
> +
> +               /* lost tick compensation */
> +               delta = last_tsc_low - delta;
> +               if(delta >= 2*loops_per_jiffy){
> +                       delta = (delta/loops_per_jiffy)-1;
> +                       jiffies += delta;
>                 }
> 
>                 count = ((LATCH-1) - count) * TICK_SIZE;
> 

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
