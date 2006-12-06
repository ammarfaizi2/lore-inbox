Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934264AbWLFPM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934264AbWLFPM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934422AbWLFPM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:12:26 -0500
Received: from mout0.freenet.de ([194.97.50.131]:54407 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934264AbWLFPMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:12:25 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH -rt 1/3] Make trace_freerunning work; Take 2: Off by 1 tweaks
Date: Wed, 6 Dec 2006 16:12:53 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061205220257.1AECF3E2420@elvis.elte.hu> <20061205221046.GB20587@elte.hu> <200612061608.24556.fzu@wemgehoertderstaat.de>
In-Reply-To: <200612061608.24556.fzu@wemgehoertderstaat.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061612.53254.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Needed to make last trace entry appear when trace_freerunning is 1.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


--- rt6/kernel/latency_trace.c	2006-12-06 00:36:49.000000000 +0100
+++ rt6-kw/kernel/latency_trace.c	2006-12-06 14:43:52.000000000 +0100
@@ -181,7 +181,7 @@ static int report_latency(cycle_t delta)
 /*
  * Number of per-CPU trace entries:
  */
-#define MAX_TRACE (131072UL-1)
+#define MAX_TRACE 131072UL
 
 #define CMDLINE_BYTES 16
 
@@ -609,7 +609,7 @@ again:
 	if (unlikely((trace_freerunning || print_functions) &&
 						(idx_next >= MAX_TRACE)))
 		idx_next = 0;
-	if (unlikely(idx_next >= MAX_TRACE)) {
+	if (unlikely(idx >= MAX_TRACE)) {
 		atomic_inc(&tr->overrun);
 		goto out;
 	}
@@ -899,7 +899,7 @@ static void construct_pid_to_cmdline(str
 	if (!tr->trace)
 		return;
 
-	entries = min(tr->trace_idx, MAX_TRACE-1);
+	entries = min(tr->trace_idx, MAX_TRACE);
 
 	for (i = 0; i < entries; i++) {
 		struct trace_entry *entry = tr->trace + i;
@@ -951,12 +951,12 @@ static void copy_trace(struct cpu_trace 
 			idx = (idx0 + i) % MAX_TRACE;
 			save->trace[i] = tr->trace[idx];
 		}
-		save->trace_idx = MAX_TRACE-1;
+		save->trace_idx = MAX_TRACE;
 	} else {
 		save->trace_idx = tr->trace_idx;
 
 		memcpy(save->trace, tr->trace,
-			min(save->trace_idx + 1, MAX_TRACE-1) *
+			min(save->trace_idx, MAX_TRACE) *
 					sizeof(struct trace_entry));
 	}
 	save->overrun = tr->overrun;
@@ -979,7 +979,7 @@ static int min_idx(struct block_idx *bid
 
 	for_each_online_cpu(cpu) {
 		idx = bidx->idx[cpu];
-		if (idx >= min(max_tr.traces[cpu].trace_idx, MAX_TRACE-1))
+		if (idx >= min(max_tr.traces[cpu].trace_idx, MAX_TRACE))
 			continue;
 		if (idx >= MAX_TRACE*NR_CPUS) {
 			printk("huh: idx (%d) > %ld*%d!\n", idx, MAX_TRACE, NR_CPUS);
@@ -1036,7 +1036,7 @@ static void update_out_trace(void)
 	out_entry = tmp_out->trace + 0;
 
 	if (!trace_all_cpus) {
-		entries = min(tmp_out->trace_idx, MAX_TRACE-1);
+		entries = min(tmp_out->trace_idx, MAX_TRACE);
 		if (!entries)
 			return;
 		out_tr.first_timestamp = tmp_out->trace[0].timestamp;
@@ -1059,7 +1059,7 @@ static void update_out_trace(void)
 	 * Save the timestamp range:
 	 */
 	tmp_max = max_tr.traces + max_tr.cpu;
-	entries = min(tmp_max->trace_idx, MAX_TRACE-1);
+	entries = min(tmp_max->trace_idx, MAX_TRACE);
 	/*
 	 * No saved trace yet?
 	 */
@@ -1075,7 +1075,7 @@ static void update_out_trace(void)
 
 		for_each_online_cpu(cpu) {
 			tmp_max = max_tr.traces + cpu;
-			entries = min(tmp_max->trace_idx, MAX_TRACE-1);
+			entries = min(tmp_max->trace_idx, MAX_TRACE);
 			printk("CPU%d: %016Lx (%016Lx) ... #%d (%016Lx) %016Lx\n", cpu,
 				tmp_max->trace[0].timestamp,
 				tmp_max->trace[1].timestamp,
@@ -1084,7 +1084,7 @@ static void update_out_trace(void)
 				tmp_max->trace[entries-1].timestamp);
 		}
 		tmp_max = max_tr.traces + max_tr.cpu;
-		entries = min(tmp_max->trace_idx, MAX_TRACE-1);
+		entries = min(tmp_max->trace_idx, MAX_TRACE);
 
 		printk("CPU%d entries: %d\n", max_tr.cpu, entries);
 		printk("first stamp: %016Lx\n", first_stamp);
@@ -1179,7 +1179,7 @@ static void * notrace l_start(struct seq
 #endif
 		construct_pid_to_cmdline(tr);
 	}
-	entries = min(tr->trace_idx, MAX_TRACE-1);
+	entries = min(tr->trace_idx, MAX_TRACE);
 
 	if (!n) {
 		seq_printf(m, "preemption latency trace v1.1.5 on %s\n", UTS_RELEASE);
@@ -1241,7 +1241,7 @@ static void * notrace l_start(struct seq
 static void * notrace l_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	struct cpu_trace *tr = out_tr.traces;
-	unsigned long entries = min(tr->trace_idx, MAX_TRACE-1);
+	unsigned long entries = min(tr->trace_idx, MAX_TRACE);
 
 	WARN_ON(!tr->trace);
 
@@ -2431,8 +2431,7 @@ void notrace stop_trace(void)
 
 EXPORT_SYMBOL(stop_trace);
 
-static void print_entry(struct trace_entry *entry, struct trace_entry *entry0,
-			struct trace_entry *next_entry)
+static void print_entry(struct trace_entry *entry, struct trace_entry *entry0)
 {
 	unsigned long abs_usecs;
 	int hardirq, softirq;
@@ -2499,7 +2498,7 @@ void print_last_trace(void)
 {
 	unsigned int idx0, idx, i, cpu;
 	struct cpu_trace *tr;
-	struct trace_entry *entry0, *entry, *next_entry;
+	struct trace_entry *entry0, *entry;
 
 	preempt_disable();
 	cpu = smp_processor_id();
@@ -2521,12 +2520,11 @@ void print_last_trace(void)
 	idx0 = tr->trace_idx;
 	printk("curr idx: %d\n", idx0);
 	if (idx0 >= MAX_TRACE)
-		idx0 = MAX_TRACE-1;
+		idx0 = 0;
 	idx = idx0;
 	entry0 = tr->trace + idx0;
 
 	for (i = 0; i < MAX_TRACE; i++) {
-		next_entry = tr->trace + idx;
 		if (idx == 0)
 			idx = MAX_TRACE-1;
 		else
@@ -2536,7 +2534,7 @@ void print_last_trace(void)
 		case TRACE_FN:
 		case TRACE_SPECIAL:
 		case TRACE_SPECIAL_U64:
-			print_entry(entry, entry0, next_entry);
+			print_entry(entry, entry0);
 			break;
 		}
 	}
