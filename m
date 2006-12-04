Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937017AbWLDPkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937017AbWLDPkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937022AbWLDPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:40:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55786 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937017AbWLDPkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:40:42 -0500
Date: Mon, 4 Dec 2006 16:39:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in	latency_trace.c (take 3)
Message-ID: <20061204153949.GA9350@elte.hu>
References: <200611132252.58818.sshtylyov@ru.mvista.com> <457326A2.2020402@ru.mvista.com> <20061204095131.GE7872@elte.hu> <4574149B.5070602@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4574149B.5070602@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> >i'd suggest to redo it - but please keep it simple and clean. Those 
> >dozens of casts to u64 are quite ugly.
> 
>    Alas, there's *nothing* I can do about it with 32-bit cycles_t. 
> [...]

there's *always* a way to do such things more cleanly - such as the 
patch below. Could you try to fix it up for 32-bit cycles_t platforms? I 
bet the hackery will be limited to now() and maybe the conversion 
routines, instead of spreading all around latency_trace.c.

	Ingo

Index: linux/kernel/latency_trace.c
===================================================================
--- linux.orig/kernel/latency_trace.c
+++ linux/kernel/latency_trace.c
@@ -18,6 +18,7 @@
 #include <linux/kallsyms.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
+#include <linux/clocksource.h>
 #include <linux/proc_fs.h>
 #include <linux/latency_hist.h>
 #include <linux/utsrelease.h>
@@ -43,7 +44,7 @@ int trace_use_raw_cycles = 1;
  * points, but the trace entries inbetween are timestamped with
  * get_cycles().
  */
-static unsigned long notrace cycles_to_us(cycles_t delta)
+static unsigned long notrace cycles_to_us(cycle_t delta)
 {
 	if (!trace_use_raw_cycles)
 		return cycles_to_usecs(delta);
@@ -60,7 +61,7 @@ static unsigned long notrace cycles_to_u
 	return (unsigned long) delta;
 }
 
-static notrace inline cycles_t now(void)
+static notrace inline cycle_t now(void)
 {
 	if (trace_use_raw_cycles)
 		return get_cycles();
@@ -150,17 +151,17 @@ enum trace_flag_type
  * we clear it after bootup.
  */
 #ifdef CONFIG_LATENCY_HIST
-static cycles_t preempt_max_latency = (cycles_t)0UL;
+static cycle_t preempt_max_latency = (cycle_t)0UL;
 #else
-static cycles_t preempt_max_latency = (cycles_t)ULONG_MAX;
+static cycle_t preempt_max_latency = (cycle_t)ULONG_MAX;
 #endif
 
-static cycles_t preempt_thresh;
+static cycle_t preempt_thresh;
 
 /*
  * Should this new latency be reported/recorded?
  */
-static int report_latency(cycles_t delta)
+static int report_latency(cycle_t delta)
 {
 	if (latency_hist_flag && !trace_user_triggered)
 		return 1;
@@ -193,7 +194,7 @@ struct trace_entry {
 	char flags;
 	char preempt_count; // assumes PREEMPT_MASK is 8 bits or less
 	int pid;
-	cycles_t timestamp;
+	cycle_t timestamp;
 	union {
 		struct {
 			unsigned long eip;
@@ -224,7 +225,7 @@ struct trace_entry {
 struct cpu_trace {
 	atomic_t disabled;
 	unsigned long trace_idx;
-	cycles_t preempt_timestamp;
+	cycle_t preempt_timestamp;
 	unsigned long critical_start, critical_end;
 	unsigned long critical_sequence;
 	atomic_t overrun;
@@ -274,7 +275,7 @@ int trace_user_trigger_irq = -1;
 
 struct saved_trace_struct {
 	int cpu;
-	cycles_t first_timestamp, last_timestamp;
+	cycle_t first_timestamp, last_timestamp;
 	struct cpu_trace traces[NR_CPUS];
 } ____cacheline_aligned_in_smp;
 
@@ -586,7 +587,7 @@ ____trace(int cpu, enum trace_type type,
 {
 	struct trace_entry *entry;
 	unsigned long idx, idx_next;
-	cycles_t timestamp;
+	cycle_t timestamp;
 	u32 pc;
 
 #ifdef CONFIG_DEBUG_PREEMPT
@@ -972,7 +973,7 @@ struct block_idx {
  */
 static int min_idx(struct block_idx *bidx)
 {
-	cycles_t min_stamp = (cycles_t) -1;
+	cycle_t min_stamp = (cycle_t) -1;
 	struct trace_entry *entry;
 	int cpu, min_cpu = -1, idx;
 
@@ -1006,7 +1007,7 @@ static int min_idx(struct block_idx *bid
 static void update_out_trace(void)
 {
 	struct trace_entry *out_entry, *entry, *tmp;
-	cycles_t stamp, first_stamp, last_stamp;
+	cycle_t stamp, first_stamp, last_stamp;
 	struct block_idx bidx = { { 0, }, };
 	struct cpu_trace *tmp_max, *tmp_out;
 	int cpu, sum, entries, overrun_sum;
@@ -1694,7 +1695,7 @@ static void notrace
 check_critical_timing(int cpu, struct cpu_trace *tr, unsigned long parent_eip)
 {
 	unsigned long latency, t0, t1;
-	cycles_t T0, T1, T2, delta;
+	cycle_t T0, T1, T2, delta;
 	unsigned long flags;
 
 	if (trace_user_triggered)
@@ -1721,7 +1722,7 @@ check_critical_timing(int cpu, struct cp
 	T2 = get_monotonic_cycles();
 
 	/* check for buggy clocks, handling wrap for 32-bit clocks */
-	if (TYPE_EQUAL(cycles_t, unsigned long)) {
+	if (TYPE_EQUAL(cycle_t, unsigned long)) {
 		if (time_after((unsigned long)T1, (unsigned long)T2))
 			printk("bug: %08lx < %08lx!\n",
 				(unsigned long)T2, (unsigned long)T1);
@@ -2100,7 +2101,7 @@ check_wakeup_timing(struct cpu_trace *tr
 {
 	int cpu = raw_smp_processor_id();
 	unsigned long latency, t0, t1;
-	cycles_t T0, T1, delta;
+	cycle_t T0, T1, delta;
 
 	if (trace_user_triggered)
 		return;
@@ -2293,7 +2294,7 @@ long user_trace_start(void)
 	 * bootup then we assume that this was the intention
 	 * (we wont get any tracing done otherwise):
 	 */
-	if (preempt_max_latency == (cycles_t)ULONG_MAX)
+	if (preempt_max_latency == (cycle_t)ULONG_MAX)
 		preempt_max_latency = 0;
 
 	/*
@@ -2343,7 +2344,7 @@ long user_trace_stop(void)
 {
 	unsigned long latency, flags;
 	struct cpu_trace *tr;
-	cycles_t delta;
+	cycle_t delta;
 
 	if (!trace_user_triggered || trace_print_at_crash || print_functions)
 		return -EINVAL;
@@ -2371,7 +2372,7 @@ long user_trace_stop(void)
 
 	atomic_inc(&tr->disabled);
 	if (tr->preempt_timestamp) {
-		cycles_t T0, T1;
+		cycle_t T0, T1;
 		unsigned long long tmp0;
 
 		T0 = tr->preempt_timestamp;
@@ -2633,7 +2634,7 @@ void print_traces(struct task_struct *ta
 static int preempt_read_proc(char *page, char **start, off_t off,
 			     int count, int *eof, void *data)
 {
-	cycles_t *max = data;
+	cycle_t *max = data;
 
 	return sprintf(page, "%ld\n", cycles_to_usecs(*max));
 }
@@ -2642,7 +2643,7 @@ static int preempt_write_proc(struct fil
 			      unsigned long count, void *data)
 {
 	unsigned int c, done = 0, val, sum = 0;
-	cycles_t *max = data;
+	cycle_t *max = data;
 
 	while (count) {
 		if (get_user(c, buffer))
Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c
+++ linux/kernel/timer.c
@@ -889,7 +889,7 @@ static inline s64 __get_nsec_offset(void
 	return ns_offset;
 }
 
-cycles_t notrace get_monotonic_cycles(void)
+cycle_t notrace get_monotonic_cycles(void)
 {
 	cycle_t cycle_now, cycle_delta;
 
@@ -902,7 +902,7 @@ cycles_t notrace get_monotonic_cycles(vo
 	return clock->cycle_last + cycle_delta;
 }
 
-unsigned long notrace cycles_to_usecs(cycles_t cycles)
+unsigned long notrace cycles_to_usecs(cycle_t cycles)
 {
 	u64 ret = cyc2ns(clock, cycles);
 
@@ -911,7 +911,7 @@ unsigned long notrace cycles_to_usecs(cy
 	return ret;
 }
 
-cycles_t notrace usecs_to_cycles(unsigned long usecs)
+cycle_t notrace usecs_to_cycles(unsigned long usecs)
 {
 	return ns2cyc(clock, (u64)usecs * 1000);
 }
