Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWFRPJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWFRPJN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWFRPJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:09:13 -0400
Received: from mail.timesys.com ([65.117.135.102]:43950 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S932231AbWFRPJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:09:12 -0400
Subject: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic
	HZ
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 17:10:26 +0200
Message-Id: <1150643426.27073.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are pleased to announce the 2.6.17 based release of our high-res 
timers kernel feature, upon which we based a tickless kernel (dyntick) 
implementation and a 'dynamic HZ' feature as well:

http://www.tglx.de/projects/hrtimers/2.6.17/

The easiest way to try these features is to apply the combo patch to 
vanilla 2.6.17. The patching order is:

http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.bz2
http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick1.patch


A broken out patch series is available too:

http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick1.patches.tar.bz2


The high-res timers feature (CONFIG_HIGH_RES_TIMERS) enables POSIX 
timers and nanosleep() to be as accurate as the hardware allows (around 
1usec on typical hardware). This feature is transparent - if enabled it 
just makes these timers much more accurate than the current HZ 
resolution. It is based on the Generic Time Of Day patchset from John 
Stultz and it in essence finishes what we started with the 
kernel/hrtimers.c code in 2.6.16.
 
The tickless kernel feature (CONFIG_NO_HZ) enables 'on-demand' timer 
interrupts: if there is no timer to be expired for say 1.5 seconds when 
the system goes idle, then the system will stay totally idle for 1.5 
seconds. This should bring cooler CPUs and power savings: on our (x86) 
testboxes we have measured the effective IRQ rate to go from HZ to 1-2 
timer interrupts per second.

This feature is implemented by driving 'low res timer wheel' processing 
via special per-CPU high-res timers, which timers are reprogrammed to 
the next-low-res-timer-expires interval. This tickless-kernel design is 
SMP-safe in a natural way and has been developed on SMP systems from
the 
beginning.

Note: while our code should be similar in behavior to the existing 
dynticks kernel patch from Con, it is a fundamentally different design 
(being based on the high-res timers support and APIs) and is thus a 
different implementation. We reused one area of dynticks: we integrated 
and improved the 'timer top' profiling tool (CONFIG_TIMER_INFO).

When running the kernel then there's a 'timeout granularity' 
runtime tunable parameter as well, under:

   /proc/sys/kernel/timeout_granularity

it defaults to 1, meaning that CONFIG_HZ is the granularity of timers. 

For example, if CONFIG_HZ is 1000 and timeout_granularity is set to 10, 
then low-res timers will be expired every 10 jiffies (every 10 msecs), 
thus the effective granularity of low-res timers is 100 HZ. Thus this 
feature implements nonintrusive dynamic HZ in essence, without touching 
the HZ macro itself.

Supported platforms: high-res timers and tickless works on x86 (x86_64,
PPC and ARM port are in the works). Other platforms should still work
fine with the usual HZ frequency timer tick.

Naturally, we'd like these features to be integrated into the upstream 
kernel as well.

Bugreports and suggestions are welcome,
 
	Thomas, Ingo


