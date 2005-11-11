Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVKKUnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVKKUnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVKKUnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:43:24 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56716 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751185AbVKKUnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:43:23 -0500
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-Id: <20051111204322.11609.61829.sendpatchset@localhost.localdomain>
In-Reply-To: <20051111204312.11609.23222.sendpatchset@localhost.localdomain>
References: <20051111204312.11609.23222.sendpatchset@localhost.localdomain>
Subject: [PATCH 2.6.14-rt11 2/3] Switch to using get_cycles() rather than get_cpu_tick()
Date: Fri, 11 Nov 2005 15:43:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a few different drivers we had what boiled down to a custom
implementation of get_cycles().  On i386 and ppc32 this was the same
code, and I assume similar for ARM and MIPS.  In one case
(kernel/latency.c) it really was get_cycles() in the !i386 case.  Always
using get_cycles() makes new platform bringup easier.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

 drivers/char/blocker.c |   37 +------------------------------------
 drivers/char/lpptest.c |   39 ++-------------------------------------
 kernel/latency.c       |   35 +++++++++++------------------------
 3 files changed, 14 insertions(+), 97 deletions(-)

Index: linux-2.6.14/drivers/char/blocker.c
===================================================================
--- linux-2.6.14.orig/drivers/char/blocker.c
+++ linux-2.6.14/drivers/char/blocker.c
@@ -13,47 +13,12 @@
 
 #define MAX_LOCK_DEPTH		10
 
-/* this needs to be reconciled with driver/char/lpptest.c
- */
-static inline u64 notrace get_cpu_tick(void)
-{
-	u64 tsc;
-#if defined(CONFIG_X86)
-	__asm__ __volatile__("rdtsc" : "=A" (tsc));
-#elif defined(CONFIG_PPC)
-	unsigned long hi, lo;
-
-	do {
-		hi = get_tbu();
-		lo = get_tbl();
-	} while (get_tbu() != hi);
-	tsc = (u64)hi << 32 | lo;
-#elif defined(CONFIG_ARM)
-	tsc = *oscr;
-#elif defined(CONFIG_MIPS)
-#define read_32bit_cp0_register(source)				\
-({ int __res;							\
-	__asm__ __volatile__(					\
-	".set\tpush\n\t"					\
-	".set\treorder\n\t"					\
-	"mfc0\t%0,"STR(source)"\n\t"				\
-	".set\tpop"						\
-	: "=r" (__res));					\
-	__res;})
-
-	tsc = read_32bit_cp0_register(CP0_COUNT);
-#else
-	#error Implement get_cpu_tick()
-#endif
-	return tsc;
-}
-
 void loop(int loops)
 {
 	int i;
 
 	for (i = 0; i < loops; i++)
-		get_cpu_tick();
+		get_cycles();
 }
 
 static spinlock_t blocker_lock[MAX_LOCK_DEPTH];
Index: linux-2.6.14/drivers/char/lpptest.c
===================================================================
--- linux-2.6.14.orig/drivers/char/lpptest.c
+++ linux-2.6.14/drivers/char/lpptest.c
@@ -40,41 +40,6 @@ static char dev_id[] = "lpptest";
 
 static unsigned char out = 0x5a;
 
-/* this needs to be reconciled with driver/char/blocker.c
- */
-static inline u64 notrace get_cpu_tick(void)
-{
-	u64 tsc;
-#if defined(CONFIG_X86)
-	__asm__ __volatile__("rdtsc" : "=A" (tsc));
-#elif defined(CONFIG_PPC)
-	unsigned long hi, lo;
-
-	do {
-		hi = get_tbu();
-		lo = get_tbl();
-	} while (get_tbu() != hi);
-	tsc = (u64)hi << 32 | lo;
-#elif defined(CONFIG_ARM)
-	tsc = *oscr;
-#elif defined(CONFIG_MIPS)
-#define read_32bit_cp0_register(source)				\
-({ int __res;							\
-	__asm__ __volatile__(					\
-	".set\tpush\n\t"					\
-	".set\treorder\n\t"					\
-	"mfc0\t%0,"STR(source)"\n\t"				\
-	".set\tpop"						\
-	: "=r" (__res));					\
-	__res;})
-
-	tsc = read_32bit_cp0_register(CP0_COUNT);
-#else
-	#error Implement get_cpu_tick()
-#endif
-	return tsc;
-}
-
 /**
  * Interrupt handler. Flip a bit in the reply.
  */
@@ -96,7 +61,7 @@ static cycles_t test_response(void)
 	in = inb(0x379);
 	inb(0x378);
 	outb(0x08, 0x378);
-	now = get_cpu_tick();
+	now = get_cycles();
 	while(1) {
     		if (inb(0x379) != in)
 			break;
@@ -107,7 +72,7 @@ static cycles_t test_response(void)
 			return 0;
 		}
 	}
-	end = get_cpu_tick();
+	end = get_cycles();
 	outb(0x00, 0x378);
 	raw_local_irq_enable();
 
Index: linux-2.6.14/kernel/latency.c
===================================================================
--- linux-2.6.14.orig/kernel/latency.c
+++ linux-2.6.14/kernel/latency.c
@@ -33,19 +33,6 @@
 # endif
 #endif
 
-#ifdef __i386__
-static inline cycles_t cycles(void)
-{
-	unsigned long long ret;
-
-	rdtscll(ret);
-
-	return ret;
-}
-#else
-# define cycles() get_cycles()
-#endif
-
 #ifdef CONFIG_WAKEUP_TIMING
 struct sch_struct {
 	raw_spinlock_t trace_lock;
@@ -525,7 +512,7 @@ ____trace(int cpu, enum trace_type type,
 again:
 	idx = tr->trace_idx;
 	idx_next = idx + 1;
-	timestamp = cycles();
+	timestamp = get_cycles();
 
 	if (unlikely(trace_freerunning && (idx_next >= MAX_TRACE)))
 		idx_next = 0;
@@ -1470,7 +1457,7 @@ check_critical_timing(int cpu, struct cp
 	 * as long as possible:
 	 */
 	T0 = tr->preempt_timestamp;
-	T1 = cycles();
+	T1 = get_cycles();
 	delta = T1-T0;
 
 	raw_local_save_flags(flags);
@@ -1484,7 +1471,7 @@ check_critical_timing(int cpu, struct cp
 	 * might change it (it can only get larger so the latency
 	 * is fair to be reported):
 	 */
-	T2 = cycles();
+	T2 = get_cycles();
 	if (T2 < T1)
 		printk("bug: %016Lx < %016Lx!\n", T2, T1);
 	delta = T2-T0;
@@ -1535,7 +1522,7 @@ check_critical_timing(int cpu, struct cp
 	printk(" =>   ended at timestamp %lu: ", t1);
 	print_symbol("<%s>\n", tr->critical_end);
 	dump_stack();
-	t1 = cycles_to_usecs(cycles());
+	t1 = cycles_to_usecs(get_cycles());
 	printk(" =>   dump-end timestamp %lu\n\n", t1);
 #endif
 
@@ -1545,7 +1532,7 @@ check_critical_timing(int cpu, struct cp
 
 out:
 	tr->critical_sequence = max_sequence;
-	tr->preempt_timestamp = cycles();
+	tr->preempt_timestamp = get_cycles();
 	tr->early_warning = 0;
 	reset_trace_idx(cpu, tr);
 	_trace_cmdline(cpu, tr);
@@ -1593,7 +1580,7 @@ __start_critical_timing(unsigned long ei
 	atomic_inc(&tr->disabled);
 
 	tr->critical_sequence = max_sequence;
-	tr->preempt_timestamp = cycles();
+	tr->preempt_timestamp = get_cycles();
 	tr->critical_start = eip;
 	atomic_set(&tr->overrun, 0);
 	reset_trace_idx(cpu, tr);
@@ -1843,7 +1830,7 @@ check_wakeup_timing(struct cpu_trace *tr
 		goto out;
 
 	T0 = tr->preempt_timestamp;
-	T1 = cycles();
+	T1 = get_cycles();
 	/*
 	 * maybe preempt_timestamp originated on another CPU,
 	 * with a TSC drift:
@@ -1857,7 +1844,7 @@ check_wakeup_timing(struct cpu_trace *tr
 
 	raw_local_save_flags(flags);
 	____trace(smp_processor_id(), TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0, flags);
-	T2 = cycles();
+	T2 = get_cycles();
 	if (T2 < T1)
 		printk("bug2: %016Lx < %016Lx!\n", T2, T1);
 	delta = T2-T0;
@@ -1943,7 +1930,7 @@ void __trace_start_sched_wakeup(struct t
 //	if (!atomic_read(&tr->disabled)) {
 		atomic_inc(&tr->disabled);
 		tr->critical_sequence = max_sequence;
-		tr->preempt_timestamp = cycles();
+		tr->preempt_timestamp = get_cycles();
 		tr->latency_type = WAKEUP_LATENCY;
 		tr->critical_start = CALLER_ADDR0;
 		atomic_set(&tr->overrun, 0);
@@ -2053,7 +2040,7 @@ long user_trace_start(void)
 	reset_trace_idx(cpu, tr);
 
 	tr->critical_sequence = max_sequence;
-	tr->preempt_timestamp = cycles();
+	tr->preempt_timestamp = get_cycles();
 	tr->critical_start = CALLER_ADDR0;
 	atomic_set(&tr->overrun, 0);
 	_trace_cmdline(cpu, tr);
@@ -2106,7 +2093,7 @@ long user_trace_stop(void)
 		unsigned long long tmp0;
 
 		T0 = tr->preempt_timestamp;
-		T1 = cycles();
+		T1 = get_cycles();
 		tmp0 = preempt_max_latency;
 		if (T1 < T0)
 			T0 = T1;

-- 
Tom
