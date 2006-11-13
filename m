Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755249AbWKMTvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbWKMTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755250AbWKMTvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:51:24 -0500
Received: from h155.mvista.com ([63.81.120.155]:1298 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1755249AbWKMTvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:51:24 -0500
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To: mingo@elte.hu
Subject: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in latency_trace.c (take 3)
Date: Mon, 13 Nov 2006 22:52:58 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, dwalker@mvista.com,
       khilman@mvista.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611132252.58818.sshtylyov@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the clock jump-back check being falsely triggered by clock wrap
with 32-bit cycles_t, as noticed by Kevin Hilman, there's another issue: using
%Lx format to print 32-bit values warrants erroneous values on 32-bit machines
like ARM and PPC32...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
There's a lot more of this cr*p with CONFIG_LATENCY_TRACE enabled, hence is
take 3 on this patch...

 kernel/latency_trace.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

Index: linux-2.6/kernel/latency_trace.c
===================================================================
--- linux-2.6.orig/kernel/latency_trace.c
+++ linux-2.6/kernel/latency_trace.c
@@ -989,30 +989,30 @@ static void update_out_trace(void)
 			tmp_max = max_tr.traces + cpu;
 			entries = min(tmp_max->trace_idx, MAX_TRACE-1);
 			printk("CPU%d: %016Lx (%016Lx) ... #%d (%016Lx) %016Lx\n", cpu,
-				tmp_max->trace[0].timestamp,
-				tmp_max->trace[1].timestamp,
+				(u64)tmp_max->trace[0].timestamp,
+				(u64)tmp_max->trace[1].timestamp,
 				entries,
-				tmp_max->trace[entries-2].timestamp,
-				tmp_max->trace[entries-1].timestamp);
+				(u64)tmp_max->trace[entries-2].timestamp,
+				(u64)tmp_max->trace[entries-1].timestamp);
 		}
 		tmp_max = max_tr.traces + max_tr.cpu;
 		entries = min(tmp_max->trace_idx, MAX_TRACE-1);
 
 		printk("CPU%d entries: %d\n", max_tr.cpu, entries);
-		printk("first stamp: %016Lx\n", first_stamp);
-		printk(" last stamp: %016Lx\n", first_stamp);
+		printk("first stamp: %016Lx\n", (u64)first_stamp);
+		printk(" last stamp: %016Lx\n", (u64)first_stamp);
 	}
 
 #if 0
-	printk("first_stamp: %Ld [%016Lx]\n", first_stamp, first_stamp);
-	printk(" last_stamp: %Ld [%016Lx]\n", last_stamp, last_stamp);
+	printk("first_stamp: %Ld [%016Lx]\n", (u64)first_stamp, (u64)first_stamp);
+	printk(" last_stamp: %Ld [%016Lx]\n", (u64)last_stamp, (u64)last_stamp);
 	printk("   +1 stamp: %Ld [%016Lx]\n",
-		tmp_max->trace[entries].timestamp,
-		tmp_max->trace[entries].timestamp);
+		(u64)tmp_max->trace[entries].timestamp,
+		(u64)tmp_max->trace[entries].timestamp);
 	printk("   +2 stamp: %Ld [%016Lx]\n",
-		tmp_max->trace[entries+1].timestamp,
-		tmp_max->trace[entries+1].timestamp);
-	printk("      delta: %Ld\n", last_stamp-first_stamp);
+		(u64)tmp_max->trace[entries+1].timestamp,
+		(u64)tmp_max->trace[entries+1].timestamp);
+	printk("      delta: %Ld\n", (u64)(last_stamp-first_stamp));
 	printk("    entries: %d\n", entries);
 #endif
 
@@ -1240,7 +1240,7 @@ static int notrace l_show_fn(struct seq_
 			pid_to_cmdline(entry->pid),
 			entry->pid, entry->cpu, entry->flags,
 			entry->preempt_count, trace_idx,
-			entry->timestamp, abs_usecs/1000,
+			(u64)entry->timestamp, abs_usecs/1000,
 			abs_usecs % 1000, rel_usecs/1000, rel_usecs % 1000);
 		print_name_offset(m, entry->u.fn.eip);
 		seq_puts(m, " (");
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
 
@@ -2273,8 +2273,8 @@ long user_trace_stop(void)
 		if (!preempt_thresh && preempt_max_latency > delta) {
 			local_irq_restore(flags);
 			printk("bug3: updating %016Lx > %016Lx [%016Lx]?\n",
-				preempt_max_latency, delta, tmp0);
-			printk("  [%016Lx %016Lx]\n", T0, T1);
+				(u64)preempt_max_latency, (u64)delta, tmp0);
+			printk("  [%016Lx %016Lx]\n", (u64)T0, (u64)T1);
 			local_irq_save(flags);
 		}
 

