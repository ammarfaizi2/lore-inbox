Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTJ1AcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 19:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTJ1AcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 19:32:16 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:685 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263787AbTJ1AcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 19:32:15 -0500
Subject: Re: gettimeofday resolution seriously degraded in test9
From: john stultz <johnstul@us.ibm.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, shemminger@osdl.org
In-Reply-To: <20031027234447.GA7417@rudolph.ccur.com>
References: <20031027234447.GA7417@rudolph.ccur.com>
Content-Type: text/plain
Organization: 
Message-Id: <1067300966.1118.378.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Oct 2003 16:29:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-27 at 15:44, Joe Korty wrote:
> [ 2nd posting, the first seems to have been lost ]
> 
> Linus,
>  This bit of -test9 code reduces the resolution of gettimeofday(2) from
> 1 microsecond to 1 millisecond whenever a negative time adjustment is
> in progress.  This seriously damages efforts to measure time intervals
> accurately with gettimeofday.  Please consider backing it out.
> 
> Joe
> 
> 
> diff -Nura linux-2.6.0-test8/arch/i386/kernel/time.c linux-2.6.0-test9/arch/i386/kernel/time.c
> --- linux-2.6.0-test8/arch/i386/kernel/time.c	2003-10-17 17:43:11.000000000 -0400
> +++ linux-2.6.0-test9/arch/i386/kernel/time.c	2003-10-25 14:43:37.000000000 -0400
> @@ -104,6 +104,15 @@
>  		lost = jiffies - wall_jiffies;
>  		if (lost)
>  			usec += lost * (1000000 / HZ);
> +
> +		/*
> +		 * If time_adjust is negative then NTP is slowing the clock
> +		 * so make sure not to go into next possible interval.
> +		 * Better to lose some accuracy than have time go backwards..
> +		 */
> +		if (unlikely(time_adjust < 0) && usec > tickadj)
> +			usec = tickadj;
> +
>  		sec = xtime.tv_sec;
>  		usec += (xtime.tv_nsec / 1000);
>  	} while (read_seqretry(&xtime_lock, seq));
> 

Hmm. This is the stair-step effect of capping time for NTP adjustments.
The side effect was expected, but I didn't figure it would be so drastic
as NTP adjustments are supposedly limited to 10%. Do you not see time
inconsistencies when running without this patch?

Stephen, any thoughts?  

thanks
-john


