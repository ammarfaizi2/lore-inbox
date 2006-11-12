Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753196AbWKLVVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbWKLVVm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 16:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbWKLVVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 16:21:42 -0500
Received: from gateway-1237.mvista.com ([63.81.120.155]:8947 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1753196AbWKLVVl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 16:21:41 -0500
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To: mingo@elte.hu
Subject: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in latency_trace.c
Date: Mon, 13 Nov 2006 00:23:12 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@linux-mips.org,
       dwalker@mvista.com, khilman@mvista.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611130023.12126.sshtylyov@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to clock wrap check being falsely triggered with 32-bit cycles_t,
as noticed to Kevin Hilman, there's another issue: using %Lx format to print
32-bit values warrants erroneous values on 32-bit machines like ARM and PPC32.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
PPC32 actually has 64-bit timebase counter, so could provide for 64-bit
cycles_t -- maybe it's worth to rewrite get_cycles() to read both lower and
upper registers?

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
 

