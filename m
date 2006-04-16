Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWDPSoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDPSoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 14:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWDPSoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 14:44:11 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:20899 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1750788AbWDPSoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 14:44:09 -0400
From: Wolfgang Hoffmann <woho@woho.de>
Reply-To: woho@woho.de
To: linux-kernel@vger.kernel.org
Subject: [-rt] time-related problems with CPU frequency scaling
Date: Sun, 16 Apr 2006 20:41:10 +0200
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604162041.10844.woho@woho.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all a big thank you for your great work on the -rt patchset.
I'm running 2.6.16-rt16 on a Pentium-M based machine, and basically it runs 
fine, as long as I disable speedstep.

Now with speedstep enabled and CONFIG_HIGH_RES_TIMERS=y, I see some anomalies:
- time-of-day lags gradually behind wallclock time
- if CPU frequency is low when jackd is started, it complains:
    "delay of 2915.000 usecs exceeds estimated spare
    time of 2847.000; restart ..."
  as soon as frequency is scaled up. Seems that jackd gets confused by some
  influence of CPU frequency on timekeeping? No problems as long as CPU
  frequency isn't scaled up, though.
- values in /proc/sys/kernel/preempt_max_latency scales inverse to
    CPU frequency, i.e. 24us with CPU @ 800MHz and 12us with CPU @ 1,6GHz

Are my speedstep-problems known issues? If so, is there work going on to 
address these? Or is it generally not recommended to run -rt with active 
speedstep?

To see if it makes a difference, I tried CONFIG_HIGH_RES_TIMERS=n, but then I 
run into deeper troubles, caused by the softirq-timer/0 kernel thread. If I 
leave it at it's default priority of FIFO 1, high-prio threads don't wake up 
from sleep() as long as mid-prio theads preempt softirq-timer/0. If I boost 
softirq-timer/0 priority (as suggested on various places on the net), I'm 
getting bad latencies (> 40 ms) every 10 minutes due to some routing-related 
action (rt_secret_rebuild) being run by softirq-timer/0.

So I switched back to CONFIG_HIGH_RES_TIMERS=y, since softirq-timer/0 can be 
left at low priority and wakeup from sleep() seems to work fine.

Btw, is there any documentation on what's run in the various kernel threads? 
It would be very helpful for adjusting the priority setup.

Wolfgang
