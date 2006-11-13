Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbWKMScJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWKMScJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWKMScJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:32:09 -0500
Received: from h155.mvista.com ([63.81.120.155]:53008 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S932685AbWKMScH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:32:07 -0500
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To: mingo@elte.hu
Subject: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in latency_trace.c (take 2)
Date: Mon, 13 Nov 2006 21:33:40 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, dwalker@mvista.com,
       khilman@mvista.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611132133.40091.sshtylyov@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the clock jump-back check being falsely triggered by clock wrap
with 32-bit cycles_t, as noticed by Kevin Hilman, there's another issue: using
%Lx format to print 32-bit values warrants erroneous values on 32-bit machines
like ARM and PPC32...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
PPC32 actually has 64-bit timebase counter, so could provide for 64-bit
cycles_t -- maybe it's worth to rewrite get_cycles() to read both lower and
upper registers?

 kernel/latency_trace.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/kernel/latency_trace.c
===================================================================
--- linux-2.6.orig/kernel/latency_trace.c
+++ linux-2.6/kernel/latency_trace.c
@@ -1623,8 +1623,8 @@ check_critical_timing(int cpu, struct cp
 #ifndef CONFIG_CRITICAL_LATENCY_HIST
 	if (!preempt_thresh && preempt_max_latency > delta) {
 		printk("bug: updating %016Lx > %016Lx?\n",
-			preempt_max_latency, delta);
-		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
+			(u64)preempt_max_latency, (u64)delta);
+		printk("  [%016Lx %016Lx %016Lx]\n", (u64)T0, (u64)T1, (u64)T2);
 	}
 #endif
 
@@ -2006,7 +2006,7 @@ check_wakeup_timing(struct cpu_trace *tr
 	____trace(smp_processor_id(), TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0, *flags);
 	T2 = get_cycles();
 	if (T2 < T1)
-		printk("bug2: %016Lx < %016Lx!\n", T2, T1);
+		printk("bug2: %016Lx < %016Lx!\n", (u64)T2, (u64)T1);
 	delta = T2-T0;
 
 	latency = cycles_to_usecs(delta);
@@ -2023,8 +2023,8 @@ check_wakeup_timing(struct cpu_trace *tr
 #ifndef CONFIG_WAKEUP_LATENCY_HIST
 	if (!preempt_thresh && preempt_max_latency > delta) {
 		printk("bug2: updating %016Lx > %016Lx?\n",
-			preempt_max_latency, delta);
-		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
+			(u64)preempt_max_latency, (u64)delta);
+		printk("  [%016Lx %016Lx %016Lx]\n", (u64)T0, (u64)T1, (u64)T2);
 	}
 #endif
 

