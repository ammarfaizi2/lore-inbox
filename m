Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUGNUJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUGNUJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUGNUJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:09:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:18118 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265545AbUGNUJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:09:41 -0400
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
	posix-timer functions to return higher accuracy)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, ia64 <linux-ia64@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1089835776.1388.216.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Jul 2004 13:09:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 09:41, Christoph Lameter wrote:
> I am working on some timer issues for the IA64 in order to make the timers
> more efficient and return results with a higher accuracy.
> 
> However, in various locations do_gettimeofday is used and then the
> resulting usecs are multiplied by 1000 to obtain nanoseconds. This is in
> particular problematic for the posix timers and especially clock_gettime.
> 
> The following patch introduces a new gettimeofday function using
> struct timespec instead of struct timeval. If a platforms supports time
> interpolation then the new gettimeofday will use that to provide a
> gettimeofday function with higher accuracy and then also clock_gettime
> will return with nanosecond accuracy.

Honestly, I'm not a fan of the patch. It realistically only helps ia64
and and adds more confusing code to the generic time code. If there
isn't an real/immediate need for this, I'd wait to 2.7 for a better
cleanup. 

None the less, I do understand the desire for the change (and am working
to address it in 2.7), so could you at least use a better name then
gettimeofday()? Maybe get_ns_time() or something? Its just too similar
to do_gettimeofday and the syscall gettimeofday(). 

Really, I feel the cleaner method is to fix do_gettimeofday() so it
returns a timespec and then convert it to a timeval in
sys_gettimeofday(). However this would add overhead to the syscall, so I
doubt folks would go for it.

> I would be interested in feedback on this approach. In this context
> the time interpolator patches that are being discussed on linux-ia64
> would also be of interest. Those provide a generic way to utilize
> any memory mapped or CPU counter to do the time interpolations for any
> platforms and would allow an easy way to realize a nanosecond resolution
> for all platforms.

I think the ia64 time interpolation code is a step in the right
direction (def better then the i386 bits), but it still isn't the
cleanest and clearest way. My plan is to select a reliable timesource
for the system, then use a periodic interrupt to accumulate time from
the timesource (in order to avoid overflows). This avoids lost tick
issues and cleanly separates the timer subsystem from the time of day
subsystem.

> The patch is against 2.6.8-rc1
> 
> Index: linux-2.6.7/kernel/time.c
> ===================================================================
> --- linux-2.6.7.orig/kernel/time.c
> +++ linux-2.6.7/kernel/time.c
> @@ -421,6 +421,40 @@
> 
>  EXPORT_SYMBOL(current_kernel_time);
> 
> +#ifdef TIME_INTERPOLATION
> +void gettimeofday (struct timespec *tv)
> +{
> +        unsigned long seq;
> +
> +        do {
> +                seq = read_seqbegin(&xtime_lock);
> +                tv->tv_sec = xtime.tv_sec;
> +                tv->tv_nsec = xtime.tv_nsec+time_interpolator_get_offset();
> +        } while (unlikely(read_seqretry(&xtime_lock, seq)));
> +
> +        while (unlikely(tv->tv_nsec >= NSEC_PER_SEC)) {
> +                tv->tv_nsec -= NSEC_PER_SEC;
> +                ++tv->tv_sec;
> +        }
> +}

You'll need to cap time_interpolator_get_offset() at the maximum NTP
tick size, or else you may have time go backwards right after a timer
interrupt. 

thanks
-john




