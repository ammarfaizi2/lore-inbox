Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934487AbWLFPSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934487AbWLFPSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935390AbWLFPSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:18:30 -0500
Received: from mout0.freenet.de ([194.97.50.131]:56452 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934487AbWLFPSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:18:23 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH -rt 2/3] Make trace_freerunning work; Take 2: Add atomic_t underrun
Date: Wed, 6 Dec 2006 16:18:50 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061205220257.1AECF3E2420@elvis.elte.hu> <200612061608.24556.fzu@wemgehoertderstaat.de> <200612061612.53254.fzu@wemgehoertderstaat.de>
In-Reply-To: <200612061612.53254.fzu@wemgehoertderstaat.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061618.51150.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add atomic_t underrun to struct cpu_trace.
Increment it only when trace_freerunning is set and an older trace
entry is overwritten.
Modify copy_trace() to reorder entries, if underrun != 0.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


--- rt6-kw/kernel/latency_trace-tk2.1.c	2006-12-06 14:43:52.000000000 +0100
+++ rt6-kw/kernel/latency_trace.c	2006-12-06 14:58:44.000000000 +0100
@@ -228,6 +228,7 @@ struct cpu_trace {
 	cycle_t preempt_timestamp;
 	unsigned long critical_start, critical_end;
 	unsigned long critical_sequence;
+	atomic_t underrun;
 	atomic_t overrun;
 	int early_warning;
 	int latency_type;
@@ -606,16 +607,21 @@ again:
 	idx_next = idx + 1;
 	timestamp = now();
 
-	if (unlikely((trace_freerunning || print_functions) &&
-						(idx_next >= MAX_TRACE)))
+	if (unlikely((trace_freerunning || print_functions || atomic_read(&tr->underrun)) &&
+		     (idx_next >= MAX_TRACE) && !atomic_read(&tr->overrun))) {
+		atomic_inc(&tr->underrun);
 		idx_next = 0;
+	}
 	if (unlikely(idx >= MAX_TRACE)) {
 		atomic_inc(&tr->overrun);
 		goto out;
 	}
 #ifdef __HAVE_ARCH_CMPXCHG
-	if (unlikely(cmpxchg(&tr->trace_idx, idx, idx_next) != idx))
+	if (unlikely(cmpxchg(&tr->trace_idx, idx, idx_next) != idx)) {
+		if (idx_next == 0)
+			atomic_dec(&tr->underrun);
 		goto again;
+	}
 #else
 # ifdef CONFIG_SMP
 #  error CMPXCHG missing
@@ -626,6 +632,9 @@ again:
 	tr->trace_idx = idx_next;
 # endif
 #endif
+	if (unlikely(idx_next != 0 && atomic_read(&tr->underrun)))
+		atomic_inc(&tr->underrun);
+
 	pc = preempt_count();
 
 	if (unlikely(!tr->trace))
@@ -938,13 +947,12 @@ char *pid_to_cmdline(unsigned long pid)
 	return cmdline;
 }
 
-static void copy_trace(struct cpu_trace *save, struct cpu_trace *tr)
+static void copy_trace(struct cpu_trace *save, struct cpu_trace *tr, int reorder)
 {
 	if (!save->trace || !tr->trace)
 		return;
 	/* free-running needs reordering */
-	/* FIXME: what if we just switched back from freerunning mode? */
-	if (trace_freerunning) {
+	if (reorder && atomic_read(&tr->underrun)) {
 		int i, idx, idx0 = tr->trace_idx;
 
 		for (i = 0; i < MAX_TRACE; i++) {
@@ -959,6 +967,7 @@ static void copy_trace(struct cpu_trace 
 			min(save->trace_idx, MAX_TRACE) *
 					sizeof(struct trace_entry));
 	}
+	save->underrun = tr->underrun;
 	save->overrun = tr->overrun;
 }
 
@@ -1010,7 +1019,7 @@ static void update_out_trace(void)
 	cycle_t stamp, first_stamp, last_stamp;
 	struct block_idx bidx = { { 0, }, };
 	struct cpu_trace *tmp_max, *tmp_out;
-	int cpu, sum, entries, overrun_sum;
+	int cpu, sum, entries, underrun_sum, overrun_sum;
 
 	/*
 	 * For out_tr we only have the first array's trace entries
@@ -1023,7 +1032,7 @@ static void update_out_trace(void)
 	 * Easier to copy this way. Note: the trace buffer is private
 	 * to the output buffer, so preserve it:
 	 */
-	copy_trace(tmp_out, tmp_max);
+	copy_trace(tmp_out, tmp_max, 0);
 	tmp = tmp_out->trace;
 	*tmp_out = *tmp_max;
 	tmp_out->trace = tmp;
@@ -1134,12 +1143,15 @@ static void update_out_trace(void)
 	}
 
 	sum = 0;
+	underrun_sum = 0;
 	overrun_sum = 0;
 	for_each_online_cpu(cpu) {
 		sum += max_tr.traces[cpu].trace_idx;
+		underrun_sum += atomic_read(&max_tr.traces[cpu].underrun);
 		overrun_sum += atomic_read(&max_tr.traces[cpu].overrun);
 	}
 	tmp_out->trace_idx = sum;
+	atomic_set(&tmp_out->underrun, underrun_sum);
 	atomic_set(&tmp_out->overrun, overrun_sum);
 }
 
@@ -1186,7 +1198,7 @@ static void * notrace l_start(struct seq
 		seq_puts(m, "--------------------------------------------------------------------\n");
 		seq_printf(m, " latency: %lu us, #%lu/%lu, CPU#%d | (M:%s VP:%d, KP:%d, SP:%d HP:%d",
 			cycles_to_usecs(tr->saved_latency),
-			entries, entries + atomic_read(&tr->overrun),
+			entries, entries + atomic_read(&tr->underrun) + atomic_read(&tr->overrun),
 			out_tr.cpu,
 #if defined(CONFIG_PREEMPT_NONE)
 			"server",
@@ -1629,11 +1641,11 @@ static void update_max_tr(struct cpu_tra
 
 	if (all_cpus) {
 		for_each_online_cpu(cpu) {
-			copy_trace(max_tr.traces + cpu, cpu_traces + cpu);
+			copy_trace(max_tr.traces + cpu, cpu_traces + cpu, 1);
 			atomic_dec(&cpu_traces[cpu].disabled);
 		}
 	} else
-		copy_trace(save, tr);
+		copy_trace(save, tr, 1);
 }
 
 #else /* !EVENT_TRACE */
@@ -1830,6 +1842,7 @@ __start_critical_timing(unsigned long ei
 	tr->critical_sequence = max_sequence;
 	tr->preempt_timestamp = get_monotonic_cycles();
 	tr->critical_start = eip;
+	atomic_set(&tr->underrun, 0);
 	atomic_set(&tr->overrun, 0);
 	reset_trace_idx(cpu, tr);
 	tr->latency_type = latency_type;
@@ -2208,6 +2221,7 @@ void __trace_start_sched_wakeup(struct t
 		tr->preempt_timestamp = get_monotonic_cycles();
 		tr->latency_type = WAKEUP_LATENCY;
 		tr->critical_start = CALLER_ADDR0;
+		atomic_set(&tr->underrun, 0);
 		atomic_set(&tr->overrun, 0);
 		_trace_cmdline(raw_smp_processor_id(), tr);
 		atomic_dec(&tr->disabled);
@@ -2318,6 +2332,7 @@ long user_trace_start(void)
 	tr->critical_sequence = max_sequence;
 	tr->preempt_timestamp = get_monotonic_cycles();
 	tr->critical_start = CALLER_ADDR0;
+	atomic_set(&tr->underrun, 0);
 	atomic_set(&tr->overrun, 0);
 	_trace_cmdline(cpu, tr);
 	mcount();
