Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWIWCSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWIWCSH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 22:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWIWCSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 22:18:07 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:33208 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750706AbWIWCSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 22:18:03 -0400
Date: Sat, 23 Sep 2006 04:17:46 +0200
From: Voluspa <lista1@comhem.se>
To: brugolsky@telemetry-investments.com
Cc: mingo@elte.hu, pavel@suse.cz, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: hires timer patchset [was Re: 2.6.19 -mm merge plans]
Message-ID: <20060923041746.2b9b7e1f@loke.fish.not>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about dropping CC-s. I'm reading archived lkml and can't see them.
Adding the obvious candidates instead (Andrew, you're not obvious, but if
you'll pull in Thomas's stuff, you'll be...)

On 2006-09-22 20:29:40 Bill Rugolsky Jr. wrote:
> On Fri, Sep 22, 2006 at 09:01:06PM +0200, Ingo Molnar wrote:
> > 
> > * Pavel Machek wrote:
> > 
> > > > would be nice to merge the -hrt queue that goes right ontop
[...]
> > note that this is a new implementation of dynticks though, not Con's
> > older stuff which you probably used, right? But it's fairly
> > low-impact (just a few lines ontop of hrtimers, here and there),
> > ontop of the long-existing -hrt queue.
>
> Just a data point, FWIW; I've made no systematic effort to find
> regressions.
>
> We've been running Thomas's (pre-dynticks) 2.6.16-hrt patchset (and
> HZ=1000) without issue as part of my standard kernel build on x86 and
> x86_64 UP/SMP production hosts -- workstations, PostgreSQL (and other)
> servers, and routers --- since I experienced latency/ntp problems with
> an unpatched kernel using sata_nv on Tyan 2895 Nvidia CK804-chipset
> mobo back in March 2006.  I've also been running the (originally
> x86-only) 2.6.17-dynticks patch on a Tyan Athlon SMP workstation mobo,
> and occasionally on my laptop, so far without issue.

Here's another data point: I tried 2.6.18-rt3 today on a x86_64
notebook. I'm on an eternal quest for extended battery time, so
NO_HZ would be perfect. Long story shortened, HIGH_RES_TIMERS
(prerequisite for NO_HZ) caused the CPU to never step down from max
speed (ondemand, powernow_k8) at 2200 MHz.

In addition, something invisible used very frequent bursts of ~30% SYS
CPU. Turning from PREEMPT_RT to PREEMPT_DESKTOP introduced occasional
bursts of ~50% USER CPU (mixed with the SYS). Toggling RCU model
made no difference.

Going from the default HIGH_RES_RESOLUTION=1000 to 10000 and even
100000 had no impact on the level or frequency of the bursts. 

This resulted in the CPU temp never going lower than 53C, and thusly
the fan kept spinning at 'level 2' - it needs 49C to fall back to
normal speed. That sound tend to drive me insane...

Turning off HIGH_RES_TIMER allowed the CPU to enter the lowest 800 MHz
immediately, and fan to slow down after the normal time, post-boot.

I'd be glad to help investigate this issue, but since -rt is completely
new territory I'd need exact instructions about which knobs to turn.
The CPU usage cause _was_ invisible, at least to "top". And I had all
USB stuff unplugged, and no ehci_hcd loaded (that's another story,
written in the bugzilla). Completely plain console, no X, no net, no
nothing.

Here's a snippet from dmesg pertaining to the timers:

ACPI: PM-Timer IO Port: 0x4008
[...]
Event source pit configured with caps set: 07
time.c: Detected 2201.306 MHz processor.
[...]
Calibrating delay using timer specific routine.. 4404.80 BogoMIPS
(lpj=2202402)
[...]
Using local APIC timer interrupts.
result 12507441
Detected 12.507 MHz APIC timer.
lapic max_delta_ns: 670689262
Event source pit new caps set: 03
Event source lapic configured with caps set: 04
[...]
Real Time Clock Driver v1.12ac
[...]
Time: tsc clocksource has been installed.
Event source pit disabled
Event source lapic configured with caps set: 08
hrtimers: Switched to high resolution mode CPU 0

Oh, and here's a compiler warning fix (when PREEMPT_RT is off):

diff -Nurp linux-2.6.18-rt3/kernel/hrtimer.c linux-2.6.18-rt3-db/kernel/hrtimer.c
--- linux-2.6.18-rt3/kernel/hrtimer.c	2006-09-23 01:12:41.000000000 +0200
+++ linux-2.6.18-rt3-db/kernel/hrtimer.c	2006-09-23 02:16:29.000000000 +0200
@@ -786,7 +786,7 @@ static inline void hrtimer_raise_softirq
 	raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
 
-static inline int hrtimer_adjust_softirq_prio(struct hrtimer_cpu_base *base)
+static inline void hrtimer_adjust_softirq_prio(struct hrtimer_cpu_base *base)
 {
 }
 
Mvh
Mats Johannesson

