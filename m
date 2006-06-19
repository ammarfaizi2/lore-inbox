Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWFSFWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWFSFWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 01:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWFSFWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 01:22:21 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:16021 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932148AbWFSFWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 01:22:21 -0400
From: Con Kolivas <kernel@kolivas.org>
To: tglx@timesys.com
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic  HZ
Date: Mon, 19 Jun 2006 15:21:05 +1000
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
References: <1150643426.27073.17.camel@localhost.localdomain>
In-Reply-To: <1150643426.27073.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191521.05508.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 01:10, Thomas Gleixner wrote:
> We are pleased to announce the 2.6.17 based release of our high-res
> timers kernel feature, upon which we based a tickless kernel (dyntick)
> implementation and a 'dynamic HZ' feature as well:
>
> http://www.tglx.de/projects/hrtimers/2.6.17/
>
> The easiest way to try these features is to apply the combo patch to
> vanilla 2.6.17. The patching order is:
>
> http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.bz2
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick1.patch
>
>
> A broken out patch series is available too:
>
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick1.patch
>es.tar.bz2
>
>
> The high-res timers feature (CONFIG_HIGH_RES_TIMERS) enables POSIX
> timers and nanosleep() to be as accurate as the hardware allows (around
> 1usec on typical hardware). This feature is transparent - if enabled it
> just makes these timers much more accurate than the current HZ
> resolution. It is based on the Generic Time Of Day patchset from John
> Stultz and it in essence finishes what we started with the
> kernel/hrtimers.c code in 2.6.16.
>
> The tickless kernel feature (CONFIG_NO_HZ) enables 'on-demand' timer
> interrupts: if there is no timer to be expired for say 1.5 seconds when
> the system goes idle, then the system will stay totally idle for 1.5
> seconds. This should bring cooler CPUs and power savings: on our (x86)
> testboxes we have measured the effective IRQ rate to go from HZ to 1-2
> timer interrupts per second.
>
> This feature is implemented by driving 'low res timer wheel' processing
> via special per-CPU high-res timers, which timers are reprogrammed to
> the next-low-res-timer-expires interval. This tickless-kernel design is
> SMP-safe in a natural way and has been developed on SMP systems from
> the
> beginning.
>
> Note: while our code should be similar in behavior to the existing
> dynticks kernel patch from Con, it is a fundamentally different design
> (being based on the high-res timers support and APIs) and is thus a
> different implementation. We reused one area of dynticks: we integrated
> and improved the 'timer top' profiling tool (CONFIG_TIMER_INFO).
>
> When running the kernel then there's a 'timeout granularity'
> runtime tunable parameter as well, under:
>
>    /proc/sys/kernel/timeout_granularity
>
> it defaults to 1, meaning that CONFIG_HZ is the granularity of timers.
>
> For example, if CONFIG_HZ is 1000 and timeout_granularity is set to 10,
> then low-res timers will be expired every 10 jiffies (every 10 msecs),
> thus the effective granularity of low-res timers is 100 HZ. Thus this
> feature implements nonintrusive dynamic HZ in essence, without touching
> the HZ macro itself.
>
> Supported platforms: high-res timers and tickless works on x86 (x86_64,
> PPC and ARM port are in the works). Other platforms should still work
> fine with the usual HZ frequency timer tick.
>
> Naturally, we'd like these features to be integrated into the upstream
> kernel as well.
>
> Bugreports and suggestions are welcome,
>
> 	Thomas, Ingo

Nice work Thomas and Ingo.

The approach to previous dynticks that I was working on had some nasty issues 
with scalability that were not addressable without a complete rewrite which 
is why I abandoned the previous implementation. Your approach for using the 
hires timer events is ultimately a better solution and the code base is 
cleaner so I'm very pleased to see it.

A couple of comments.

One of the problems we enountered with dynticks was that using the higher 
resolution timers such as TSC and HPET to adjust for timer ticks over longer 
periods when skipping ticks made the overall clock drift when run for many 
days and only the PM Timer was not prone to this happening. ie the timers 
were very accurate for short periods but over days it would drift. It could 
well have been a design flaw in the dynticks I was maintaining rather than 
the timers themselves but have you checked that this isn't a problem?

The other thing I note is that there is a reasonable amount of indirection in 
fairly hot paths. It looks like there is scope for more local variable 
storage of these indirect calls. Also if set_next_event is separated from 
struct clock_event, the whole struct looks like a suitable candidate for 
__read_only.

-- 
-ck
