Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967211AbWLAIJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967211AbWLAIJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 03:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967359AbWLAIJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 03:09:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:10660 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S967211AbWLAIJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 03:09:03 -0500
Date: Fri, 1 Dec 2006 09:08:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rt1: max latencies with jackd
Message-ID: <20061201080826.GA17504@elte.hu>
References: <1164923245.31959.49.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164923245.31959.49.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Hi Ingo, I finally have a rebuilt kernel with latency tracing enabled, 
> a jackd with the proper prctl incantations built in and I'm getting 
> some (hopefully) meaningful data.

ok. I'm first trying to understand what is happening. For example lets 
take the longest latency from the 'idle' collection:

 latency: 801 us, #470/470, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)

tracing starts here:

    japa-27320     0D...   18us : user_trace_start (sys_prctl)

then some 400 usecs later japa-27320 is scheduled away:

    softirq--5     0D..2  445us : thread_return <japa-27320> (161 199)

it has been scheduled away because softirq--5 [softirq-timer/0] has 
SCHED_FIFO 99, which preempts japa-27320 which has SCHED_FIFO 61.

200 usecs later softirq--5 has finished processing and goes to 
posix_cp-3, which too is SCHED_FIFO 99:

    posix_cp-3     0D..2  607us : thread_return <softirq--5> (199 199)

and then 60 usecs later we go back to japa-27320:

    japa-27320     0D..2  663us : thread_return <posix_cp-3> (199 161)

which, 130 usecs later, stops tracing:

    japa-27320     0....  793us : user_trace_stop (sys_prctl)

this particular latency is caused by softirq--5 and posix_cpu_thread 
having SCHED_FIFO 99. Why do they have that high priority?

also, note that there are 465 trace entries in your log, and the 
overhead of pmtimer based trace entries is ~1.5 usecs. So there's an 
artificial +600 usecs latency in this critical path, purely caused by 
tracing.

could you try the patch below? It changes trace entries to be measured 
via get_cycles() again [which should be must faster than pmtimer on your 
CPU], but keeps the latency tracing timestamps (the timestamp of the 
start/end of critical sections) on pmtimer again. This should give us 
accurate latency measurements, but fast trace entries.

you can still revert to the conservative timestamping behavior via:

	echo 0 > /proc/sys/kernel/trace_use_raw_cycles

note: you can probably get a higher quality of 'overview trace' via:

	echo 0 > /proc/sys/kernel/mcount_enabled
	echo 1 > /proc/sys/kernel/stackframe_tracing

the latter should turn such entries:

  trace-it-1967  1...1    7us : trace_special_sym (c0390143 0 0)

into full symbolic backtraces:

  trace-it-2110  0...1    6us : schedule()<-do_nanosleep()<-hrtimer_nanosleep()<-sys_nanosleep()
  trace-it-2110  0...1    6us : syscall_call()<-(-1)()<-(0)()<-(0)()

	Ingo

Index: linux/kernel/latency_trace.c
===================================================================
--- linux.orig/kernel/latency_trace.c
+++ linux/kernel/latency_trace.c
@@ -34,8 +34,36 @@
 # define RAW_SPIN_LOCK_UNLOCKED		SPIN_LOCK_UNLOCKED
 #endif
 
+int trace_use_raw_cycles = 1;
+
+/*
+ * Convert raw cycles to usecs.
+ * Note: this is not the 'clocksource cycles' value, it's the raw
+ * cycle counter cycles. We use GTOD to timestamp latency start/end
+ * points, but the trace entries inbetween are timestamped with
+ * get_cycles().
+ */
+static unsigned long notrace cycles_to_us(cycles_t delta)
+{
+	if (!trace_use_raw_cycles)
+		return cycles_to_usecs(delta);
+#ifdef CONFIG_X86
+	do_div(delta, cpu_khz/1000+1);
+#elif defined(CONFIG_PPC)
+	delta = mulhwu(tb_to_us, delta);
+#elif defined(CONFIG_ARM)
+	delta = mach_cycles_to_usecs(delta);
+#else
+	#error Implement cycles_to_usecs.
+#endif
+
+	return (unsigned long) delta;
+}
+
 static notrace inline cycles_t now(void)
 {
+	if (trace_use_raw_cycles)
+		return get_cycles();
 	return get_monotonic_cycles();
 }
 
@@ -1294,8 +1322,8 @@ static int notrace l_show_fn(struct seq_
 {
 	unsigned long abs_usecs, rel_usecs;
 
-	abs_usecs = cycles_to_usecs(entry->timestamp - entry0->timestamp);
-	rel_usecs = cycles_to_usecs(next_entry->timestamp - entry->timestamp);
+	abs_usecs = cycles_to_us(entry->timestamp - entry0->timestamp);
+	rel_usecs = cycles_to_us(next_entry->timestamp - entry->timestamp);
 
 	if (trace_verbose) {
 		seq_printf(m, "%16s %5d %d %d %08x %08lx [%016Lx] %ld.%03ldms (+%ld.%03ldms): ",
@@ -1325,8 +1353,8 @@ static int notrace l_show_special(struct
 {
 	unsigned long abs_usecs, rel_usecs;
 
-	abs_usecs = cycles_to_usecs(entry->timestamp - entry0->timestamp);
-	rel_usecs = cycles_to_usecs(next_entry->timestamp - entry->timestamp);
+	abs_usecs = cycles_to_us(entry->timestamp - entry0->timestamp);
+	rel_usecs = cycles_to_us(next_entry->timestamp - entry->timestamp);
 
 	print_generic(m, entry);
 	print_timestamp(m, abs_usecs, rel_usecs);
@@ -1368,8 +1396,8 @@ l_show_special_pid(struct seq_file *m, u
 
 	pid = entry->u.special.v1;
 
-	abs_usecs = cycles_to_usecs(entry->timestamp - entry0->timestamp);
-	rel_usecs = cycles_to_usecs(next_entry->timestamp - entry->timestamp);
+	abs_usecs = cycles_to_us(entry->timestamp - entry0->timestamp);
+	rel_usecs = cycles_to_us(next_entry->timestamp - entry->timestamp);
 
 	print_generic(m, entry);
 	print_timestamp(m, abs_usecs, rel_usecs);
@@ -1391,8 +1419,8 @@ l_show_special_sym(struct seq_file *m, u
 {
 	unsigned long abs_usecs, rel_usecs;
 
-	abs_usecs = cycles_to_usecs(entry->timestamp - entry0->timestamp);
-	rel_usecs = cycles_to_usecs(next_entry->timestamp - entry->timestamp);
+	abs_usecs = cycles_to_us(entry->timestamp - entry0->timestamp);
+	rel_usecs = cycles_to_us(next_entry->timestamp - entry->timestamp);
 
 	print_generic(m, entry);
 	print_timestamp(m, abs_usecs, rel_usecs);
@@ -1422,8 +1450,8 @@ static int notrace l_show_cmdline(struct
 	if (!trace_verbose)
 		return 0;
 
-	abs_usecs = cycles_to_usecs(entry->timestamp - entry0->timestamp);
-	rel_usecs = cycles_to_usecs(next_entry->timestamp - entry->timestamp);
+	abs_usecs = cycles_to_us(entry->timestamp - entry0->timestamp);
+	rel_usecs = cycles_to_us(next_entry->timestamp - entry->timestamp);
 
 	seq_printf(m,
 		"[ => %16s ] %ld.%03ldms (+%ld.%03ldms)\n",
@@ -1448,8 +1476,8 @@ static int notrace l_show_syscall(struct
 	unsigned long abs_usecs, rel_usecs;
 	unsigned long nr;
 
-	abs_usecs = cycles_to_usecs(entry->timestamp - entry0->timestamp);
-	rel_usecs = cycles_to_usecs(next_entry->timestamp - entry->timestamp);
+	abs_usecs = cycles_to_us(entry->timestamp - entry0->timestamp);
+	rel_usecs = cycles_to_us(next_entry->timestamp - entry->timestamp);
 
 	print_generic(m, entry);
 	print_timestamp_short(m, abs_usecs, rel_usecs);
@@ -1487,8 +1515,8 @@ static int notrace l_show_sysret(struct 
 {
 	unsigned long abs_usecs, rel_usecs;
 
-	abs_usecs = cycles_to_usecs(entry->timestamp - entry0->timestamp);
-	rel_usecs = cycles_to_usecs(next_entry->timestamp - entry->timestamp);
+	abs_usecs = cycles_to_us(entry->timestamp - entry0->timestamp);
+	rel_usecs = cycles_to_us(next_entry->timestamp - entry->timestamp);
 
 	print_generic(m, entry);
 	print_timestamp_short(m, abs_usecs, rel_usecs);
@@ -1676,7 +1704,7 @@ check_critical_timing(int cpu, struct cp
 	 * as long as possible:
 	 */
 	T0 = tr->preempt_timestamp;
-	T1 = now();
+	T1 = get_monotonic_cycles();
 	delta = T1-T0;
 
 	local_save_flags(flags);
@@ -1690,7 +1718,7 @@ check_critical_timing(int cpu, struct cp
 	 * might change it (it can only get larger so the latency
 	 * is fair to be reported):
 	 */
-	T2 = now();
+	T2 = get_monotonic_cycles();
 
 	/* check for buggy clocks, handling wrap for 32-bit clocks */
 	if (TYPE_EQUAL(cycles_t, unsigned long)) {
@@ -1748,7 +1776,7 @@ check_critical_timing(int cpu, struct cp
 	printk(" =>   ended at timestamp %lu: ", t1);
 	print_symbol("<%s>\n", tr->critical_end);
 	dump_stack();
-	t1 = cycles_to_usecs(now());
+	t1 = cycles_to_usecs(get_monotonic_cycles());
 	printk(" =>   dump-end timestamp %lu\n\n", t1);
 #endif
 
@@ -1758,7 +1786,7 @@ check_critical_timing(int cpu, struct cp
 
 out:
 	tr->critical_sequence = max_sequence;
-	tr->preempt_timestamp = now();
+	tr->preempt_timestamp = get_monotonic_cycles();
 	tr->early_warning = 0;
 	reset_trace_idx(cpu, tr);
 	_trace_cmdline(cpu, tr);
@@ -1807,7 +1835,7 @@ __start_critical_timing(unsigned long ei
 	atomic_inc(&tr->disabled);
 
 	tr->critical_sequence = max_sequence;
-	tr->preempt_timestamp = now();
+	tr->preempt_timestamp = get_monotonic_cycles();
 	tr->critical_start = eip;
 	atomic_set(&tr->overrun, 0);
 	reset_trace_idx(cpu, tr);
@@ -2082,7 +2110,7 @@ check_wakeup_timing(struct cpu_trace *tr
 		goto out;
 
 	T0 = tr->preempt_timestamp;
-	T1 = now();
+	T1 = get_monotonic_cycles();
 	/*
 	 * Any wraparound or time warp and we are out:
 	 */
@@ -2184,7 +2212,7 @@ void __trace_start_sched_wakeup(struct t
 //	if (!atomic_read(&tr->disabled)) {
 		atomic_inc(&tr->disabled);
 		tr->critical_sequence = max_sequence;
-		tr->preempt_timestamp = now();
+		tr->preempt_timestamp = get_monotonic_cycles();
 		tr->latency_type = WAKEUP_LATENCY;
 		tr->critical_start = CALLER_ADDR0;
 		atomic_set(&tr->overrun, 0);
@@ -2295,7 +2323,7 @@ long user_trace_start(void)
 	reset_trace_idx(cpu, tr);
 
 	tr->critical_sequence = max_sequence;
-	tr->preempt_timestamp = now();
+	tr->preempt_timestamp = get_monotonic_cycles();
 	tr->critical_start = CALLER_ADDR0;
 	atomic_set(&tr->overrun, 0);
 	_trace_cmdline(cpu, tr);
@@ -2347,7 +2375,7 @@ long user_trace_stop(void)
 		unsigned long long tmp0;
 
 		T0 = tr->preempt_timestamp;
-		T1 = now();
+		T1 = get_monotonic_cycles();
 		tmp0 = preempt_max_latency;
 		if (T1 < T0)
 			T0 = T1;
@@ -2416,7 +2444,7 @@ static void print_entry(struct trace_ent
 	unsigned long abs_usecs;
 	int hardirq, softirq;
 
-	abs_usecs = cycles_to_usecs(entry->timestamp - entry0->timestamp);
+	abs_usecs = cycles_to_us(entry->timestamp - entry0->timestamp);
 
 	printk("%-5d ", entry->pid);
 
Index: linux/kernel/sysctl.c
===================================================================
--- linux.orig/kernel/sysctl.c
+++ linux/kernel/sysctl.c
@@ -470,6 +470,14 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_PANIC,
+		.procname	= "trace_use_raw_cycles",
+		.data		= &trace_use_raw_cycles,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #endif
 #ifdef CONFIG_GENERIC_HARDIRQS
 	{
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -239,6 +239,7 @@ extern cpumask_t nohz_cpu_mask;
 
 extern void show_state(void);
 extern void show_regs(struct pt_regs *);
+extern void irq_show_regs_callback(int cpu, struct pt_regs *regs);
 
 /*
  * TASK is a pointer to the task whose backtrace we want to see (or NULL for current
@@ -323,7 +324,7 @@ extern int debug_direct_keyboard;
   extern int mcount_enabled, trace_enabled, trace_user_triggered,
 		trace_user_trigger_irq, trace_freerunning, trace_verbose,
 		trace_print_at_crash, trace_all_cpus, print_functions,
-		syscall_tracing, stackframe_tracing;
+		syscall_tracing, stackframe_tracing, trace_use_raw_cycles;
   extern void notrace trace_special(unsigned long v1, unsigned long v2, unsigned long v3);
   extern void notrace trace_special_pid(int pid, unsigned long v1, unsigned long v2);
   extern void notrace trace_special_u64(unsigned long long v1, unsigned long v2);
