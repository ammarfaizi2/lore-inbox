Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbSJaTrG>; Thu, 31 Oct 2002 14:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbSJaTrG>; Thu, 31 Oct 2002 14:47:06 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32757 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262908AbSJaTrE>;
	Thu, 31 Oct 2002 14:47:04 -0500
Message-ID: <3DC18A1B.FC7D59D0@mvista.com>
Date: Thu, 31 Oct 2002 11:52:59 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim.houston@attbi.com
CC: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net, jim.houston@ccur.com
Subject: Re: [PATCH] calibrate_tsc should not use HZ
References: <200210311928.g9VJSoY03708@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> 
> Hi Everyone,
> 
> I noticed that the calibration time for calibrate_tsc() is 5 jiffies.
> This means the result with 1000 Hz jiffies may be less accurate
> then it was at 100 Hz.  The attached patch removes this dependency.
> 
> Jim Houston - Concurrent Computer Corp.
> 
> diff -X /usr1/jhouston/dontdiff -ur linux.orig/arch/i386/kernel/timers/timer_tsc.c linux.kdb/arch/i386/kernel/timers/timer_tsc.c
> --- linux.orig/arch/i386/kernel/timers/timer_tsc.c      Wed Oct 23 00:54:19 2002
> +++ linux.kdb/arch/i386/kernel/timers/timer_tsc.c       Thu Oct 31 14:18:21 2002
> @@ -97,8 +97,13 @@
>   * device.
>   */
> 
> -#define CALIBRATE_LATCH        (5 * LATCH)
> -#define CALIBRATE_TIME (5 * 1000020/HZ)
> +/*
> + * Pick the largest possible latch value (it is a 16 bit counter)
> + * and calculate the corresponding time.
> + */
> +#define CALIBRATE_LATCH        (0xffff)
> +#define CALIBRATE_TIME ((int)((1000000LL*CALIBRATE_LATCH + \
> +                               CLOCK_TICK_RATE/2)/CLOCK_TICK_RATE)
> 
>  static unsigned long __init calibrate_tsc(void)
>  {
> 

And one step further, if you tack on a few zeros in the
numerator, you can pick up a couple of more bits of
precision in the tick rate, i.e.:

CLOCK_TICK_RATE is derived from 14.3181818Mhz/12 =
1.19318181667 so:
#define CALIBRATE_LATCH_1000 1193181817
#define CALIBRATE_TIME ((int)((1000000000LL*CALIBRATE_LATCH
+ \
                              
CLOCK_TICK_RATE_1000/2)/CLOCK_TICK_RATE_1000)
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
