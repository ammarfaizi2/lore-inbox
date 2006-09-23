Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWIWTdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWIWTdX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 15:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWIWTdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 15:33:22 -0400
Received: from homer.mvista.com ([63.81.120.158]:11505 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751491AbWIWTdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 15:33:22 -0400
Message-Id: <20060923193217.579194000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sat, 23 Sep 2006 12:32:17 -0700
From: dwalker@mvista.com
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -hrt] fix soft lockup detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this in 2.6.18-dyntick1

BUG: soft lockup detected on CPU#0!
[<c002a1e0>] (dump_stack+0x0/0x14) from [<c0065630>] (softlockup_tick+0xa0/0xfc)
[<c0065590>] (softlockup_tick+0x0/0xfc) from [<c004bba8>] (run_local_timers+0x44/0x54)
 r7 = 20000013  r6 = 00000E92  r5 = 00000000  r4 = C023ABD8
[<c004bb64>] (run_local_timers+0x0/0x54) from [<c004c108>] (update_process_times+0x34/0x70)
[<c004c0d4>] (update_process_times+0x0/0x70) from [<c005c124>] (hrtimer_restart_sched_tick+0x7c/0x104)
 r5 = 043E6345  r4 = C0232000
[<c005c0a8>] (hrtimer_restart_sched_tick+0x0/0x104) from [<c0027194>] (cpu_idle+0x2c/0x98)
[<c0027168>] (cpu_idle+0x0/0x98) from [<c0025310>] (rest_init+0x48/0x50)
 r6 = C023B884  r5 = C028347C  r4 = C0232000
[<c00252c8>] (rest_init+0x0/0x50) from [<c00088b0>] (start_kernel+0x1dc/0x284)
 r4 = C02964A4
[<c00086d4>] (start_kernel+0x0/0x284) from [<10008030>] (0x10008030)

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/hrtimer.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-omap-2.6/kernel/hrtimer.c
===================================================================
--- linux-omap-2.6.orig/kernel/hrtimer.c
+++ linux-omap-2.6/kernel/hrtimer.c
@@ -571,6 +571,13 @@ void hrtimer_restart_sched_tick(void)
 	update_jiffies64(now);
 
 	/*
+	 * Since we just woke up, and updated jiffies
+	 * the softlockup timer will be stale. So update
+	 * it now.
+	 */
+	touch_softlockup_watchdog();
+
+	/*
 	 * Update process times would randomly account the time we slept to
 	 * whatever the context of the next sched tick is.  Enforce that this
 	 * is accounted to idle !
--
