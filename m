Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTK1R3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTK1R3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:29:37 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:18597 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262805AbTK1R3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:29:33 -0500
Date: Fri, 28 Nov 2003 18:29:24 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       sisop-iii-l <sisopiii-l@cscience.org>
Subject: [patch] Re: [PATCH] fix #endif misplacement
In-Reply-To: <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0311281826250.9728@gockel.physik3.uni-rostock.de>
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br>
 <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 28 Nov 2003, Ricardo Nabinger Sanchez wrote:
> 
> > This patch fixes an #endif misplacement, which leads to dead code in
> > sched_clock() in arch/i386/kernel/timers/timer_tsc.c, due to a return
> > outside the ifdef/endif.
> 
> No, this is exactly what is intended: don't use the TSC on NUMA, use 
> jiffies instead.
> Look at the comment just above those lines.

HOWEVER, we seem to have some jiffies wrap bugs in this file.

Tim


--- linux-2.6.0-test11/arch/i386/kernel/timers/timer_tsc.c.orig	2003-11-28 17:50:49.000000000 +0100
+++ linux-2.6.0-test11/arch/i386/kernel/timers/timer_tsc.c	2003-11-28 18:18:44.000000000 +0100
@@ -30,7 +30,6 @@
 int tsc_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
-extern volatile unsigned long jiffies;
 
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
@@ -141,7 +140,7 @@
 #ifndef CONFIG_NUMA
 	if (!use_tsc)
 #endif
-		return (unsigned long long)jiffies * (1000000000 / HZ);
+		return (unsigned long long)get_jiffies_64() * (1000000000 / HZ);
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);
@@ -215,7 +214,8 @@
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
 	if (lost >= 2) {
-		jiffies += lost-1;
+		/* only called under xtime_lock */
+		jiffies_64 += lost-1;
 
 		/* sanity check to ensure we're not always losing ticks */
 		if (lost_count++ > 100) {
@@ -241,7 +241,7 @@
 	 * usec delta is > 90% # of usecs/tick)
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
-		jiffies++;
+		jiffies_64++;
 }
 
 static void delay_tsc(unsigned long loops)
@@ -283,7 +283,8 @@
 	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
 	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
 		int lost_ticks = (offset - hpet_last) / hpet_tick;
-		jiffies += lost_ticks;
+		/* only called under xtime_lock */
+		jiffies_64 += lost_ticks;
 	}
 	hpet_last = hpet_current;
 
