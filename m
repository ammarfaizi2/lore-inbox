Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262071AbSI3Nu7>; Mon, 30 Sep 2002 09:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262074AbSI3Nt3>; Mon, 30 Sep 2002 09:49:29 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:44494 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262076AbSI3Nnu> convert rfc822-to-8bit; Mon, 30 Sep 2002 09:43:50 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 s390 (16/26): timer interrupts.
Date: Mon, 30 Sep 2002 14:59:56 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301459.56642.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make timer interrupt independent from boot cpu and do several ticks in one
go if a virtual cpu didn't get an interrupt for a period of time > HZ.

diff -urN linux-2.5.39/arch/s390/kernel/setup.c linux-2.5.39-s390/arch/s390/kernel/setup.c
--- linux-2.5.39/arch/s390/kernel/setup.c	Mon Sep 30 13:25:21 2002
+++ linux-2.5.39-s390/arch/s390/kernel/setup.c	Mon Sep 30 13:32:53 2002
@@ -52,7 +52,6 @@
 struct { unsigned long addr, size, type; } memory_chunk[16] = { { 0 } };
 #define CHUNK_READ_WRITE 0
 #define CHUNK_READ_ONLY 1
-__u16 boot_cpu_addr;
 int cpus_initialized = 0;
 unsigned long cpu_initialized = 0;
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
@@ -474,8 +473,7 @@
 	lowcore->jiffy_timer = -1LL;
 	set_prefix((__u32) lowcore);
         cpu_init();
-        boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
-        __cpu_logical_map[0] = boot_cpu_addr;
+        __cpu_logical_map[0] = S390_lowcore.cpu_data.cpu_addr;
 
 	/*
 	 * Create kernel page tables and switch to virtual addressing.
diff -urN linux-2.5.39/arch/s390/kernel/smp.c linux-2.5.39-s390/arch/s390/kernel/smp.c
--- linux-2.5.39/arch/s390/kernel/smp.c	Mon Sep 30 13:25:21 2002
+++ linux-2.5.39-s390/arch/s390/kernel/smp.c	Mon Sep 30 13:32:53 2002
@@ -41,7 +41,6 @@
 /* prototypes */
 extern int cpu_idle(void * unused);
 
-extern __u16 boot_cpu_addr;
 extern volatile int __cpu_logical_map[];
 
 /*
@@ -426,6 +425,7 @@
 void __init smp_check_cpus(unsigned int max_cpus)
 {
         int curr_cpu, num_cpus;
+	__u16 boot_cpu_addr;
 
 	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
         current_thread_info()->cpu = 0;
diff -urN linux-2.5.39/arch/s390/kernel/time.c linux-2.5.39-s390/arch/s390/kernel/time.c
--- linux-2.5.39/arch/s390/kernel/time.c	Mon Sep 30 13:25:21 2002
+++ linux-2.5.39-s390/arch/s390/kernel/time.c	Mon Sep 30 13:32:53 2002
@@ -38,11 +38,18 @@
 #define USECS_PER_JIFFY     ((unsigned long) 1000000/HZ)
 #define CLK_TICKS_PER_JIFFY ((unsigned long) USECS_PER_JIFFY << 12)
 
+/*
+ * Create a small time difference between the timer interrupts
+ * on the different cpus to avoid lock contention.
+ */
+#define CPU_DEVIATION       (smp_processor_id() << 12)
+
 #define TICK_SIZE tick
 
 u64 jiffies_64;
 
 static ext_int_info_t ext_int_info_timer;
+static uint64_t xtime_cc;
 static uint64_t init_timer_cc;
 
 extern rwlock_t xtime_lock;
@@ -118,58 +125,90 @@
 	write_unlock_irq(&xtime_lock);
 }
 
+static inline __u32 div64_32(__u64 dividend, __u32 divisor)
+{
+	register_pair rp;
+
+	rp.pair = dividend;
+	asm ("dr %0,%1" : "+d" (rp) : "d" (divisor));
+	return rp.subreg.odd;
+}
+
 /*
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-
-#ifdef CONFIG_SMP
-extern __u16 boot_cpu_addr;
-#endif
-
 static void do_comparator_interrupt(struct pt_regs *regs, __u16 error_code)
 {
 	int cpu = smp_processor_id();
+	__u64 tmp;
+	__u32 ticks;
+
+	/* Calculate how many ticks have passed. */
+	asm volatile ("STCK 0(%0)" : : "a" (&tmp) : "memory", "cc");
+	tmp = tmp - S390_lowcore.jiffy_timer;
+	if (tmp >= 2*CLK_TICKS_PER_JIFFY) {  /* more than one tick ? */
+		ticks = div64_32(tmp >> 1, CLK_TICKS_PER_JIFFY >> 1);
+		S390_lowcore.jiffy_timer +=
+			CLK_TICKS_PER_JIFFY * (__u64) ticks;
+	} else {
+		ticks = 1;
+		S390_lowcore.jiffy_timer += CLK_TICKS_PER_JIFFY;
+	}
+
+	/* set clock comparator for next tick */
+	tmp = S390_lowcore.jiffy_timer + CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
+        asm volatile ("SCKC %0" : : "m" (tmp));
 
 	irq_enter();
 
+#ifdef CONFIG_SMP
 	/*
-	 * set clock comparator for next tick
+	 * Do not rely on the boot cpu to do the calls to do_timer.
+	 * Spread it over all cpus instead.
 	 */
-        S390_lowcore.jiffy_timer += CLK_TICKS_PER_JIFFY;
-        asm volatile ("SCKC %0" : : "m" (S390_lowcore.jiffy_timer));
-
-#ifdef CONFIG_SMP
-	if (S390_lowcore.cpu_data.cpu_addr == boot_cpu_addr)
-		write_lock(&xtime_lock);
-
-	update_process_times(user_mode(regs));
-
-	if (S390_lowcore.cpu_data.cpu_addr == boot_cpu_addr) {
-		do_timer(regs);
-		write_unlock(&xtime_lock);
+	write_lock(&xtime_lock);
+	if (S390_lowcore.jiffy_timer > xtime_cc) {
+		__u32 xticks;
+
+		tmp = S390_lowcore.jiffy_timer - xtime_cc;
+		if (tmp >= 2*CLK_TICKS_PER_JIFFY) {
+			xticks = div64_32(tmp >> 1, CLK_TICKS_PER_JIFFY >> 1);
+			xtime_cc += (__u64) xticks * CLK_TICKS_PER_JIFFY;
+		} else {
+			xticks = 1;
+			xtime_cc += CLK_TICKS_PER_JIFFY;
+		}
+		while (xticks--)
+			do_timer(regs);
 	}
+	write_unlock(&xtime_lock);
+	while (ticks--)
+		update_process_times(user_mode(regs));
 #else
-	do_timer(regs);
+	while (ticks--)
+		do_timer(regs);
 #endif
 
 	irq_exit();
 }
 
 /*
- * Start the clock comparator on the current CPU
+ * Start the clock comparator on the current CPU.
  */
 void init_cpu_timer(void)
 {
 	unsigned long cr0;
+	__u64 timer;
 
         /* allow clock comparator timer interrupt */
         asm volatile ("STCTL 0,0,%0" : "=m" (cr0) : : "memory");
         cr0 |= 0x800;
         asm volatile ("LCTL 0,0,%0" : : "m" (cr0) : "memory");
-	S390_lowcore.jiffy_timer = (__u64) jiffies * CLK_TICKS_PER_JIFFY;
-	S390_lowcore.jiffy_timer += init_timer_cc + CLK_TICKS_PER_JIFFY;
-	asm volatile ("SCKC %0" : : "m" (S390_lowcore.jiffy_timer));
+	timer = init_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
+	S390_lowcore.jiffy_timer = timer;
+	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
+	asm volatile ("SCKC %0" : : "m" (timer));
 }
 
 /*
@@ -178,7 +217,7 @@
  */
 void __init time_init(void)
 {
-        __u64 set_time_cc;
+	__u64 set_time_cc;
 	int cc;
 
         /* kick the TOD clock */
@@ -201,8 +240,9 @@
         }
 
 	/* set xtime */
-        set_time_cc = init_timer_cc - 0x8126d60e46000000LL +
-                      (0x3c26700LL*1000000*4096);
+	xtime_cc = init_timer_cc;
+	set_time_cc = init_timer_cc - 0x8126d60e46000000LL +
+		(0x3c26700LL*1000000*4096);
         tod_to_timeval(set_time_cc, &xtime);
 
         /* request the 0x1004 external interrupt */
diff -urN linux-2.5.39/arch/s390x/kernel/setup.c linux-2.5.39-s390/arch/s390x/kernel/setup.c
--- linux-2.5.39/arch/s390x/kernel/setup.c	Mon Sep 30 13:25:21 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/setup.c	Mon Sep 30 13:32:53 2002
@@ -52,7 +52,6 @@
 struct { unsigned long addr, size, type; } memory_chunk[16] = { { 0 } };
 #define CHUNK_READ_WRITE 0
 #define CHUNK_READ_ONLY 1
-__u16 boot_cpu_addr;
 int cpus_initialized = 0;
 unsigned long cpu_initialized = 0;
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
@@ -464,8 +463,7 @@
 	lowcore->jiffy_timer = -1LL;
 	set_prefix((__u32)(__u64) lowcore);
         cpu_init();
-        boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
-        __cpu_logical_map[0] = boot_cpu_addr;
+        __cpu_logical_map[0] = S390_lowcore.cpu_data.cpu_addr;
 
 	/*
 	 * Create kernel page tables and switch to virtual addressing.
diff -urN linux-2.5.39/arch/s390x/kernel/smp.c linux-2.5.39-s390/arch/s390x/kernel/smp.c
--- linux-2.5.39/arch/s390x/kernel/smp.c	Mon Sep 30 13:25:21 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/smp.c	Mon Sep 30 13:32:53 2002
@@ -40,7 +40,6 @@
 /* prototypes */
 extern int cpu_idle(void * unused);
 
-extern __u16 boot_cpu_addr;
 extern volatile int __cpu_logical_map[];
 
 /*
@@ -407,6 +406,7 @@
 void __init smp_check_cpus(unsigned int max_cpus)
 {
         int curr_cpu, num_cpus;
+	__u16 boot_cpu_addr;
 
 	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
         current_thread_info()->cpu = 0;
diff -urN linux-2.5.39/arch/s390x/kernel/time.c linux-2.5.39-s390/arch/s390x/kernel/time.c
--- linux-2.5.39/arch/s390x/kernel/time.c	Mon Sep 30 13:25:21 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/time.c	Mon Sep 30 13:32:53 2002
@@ -37,11 +37,18 @@
 #define USECS_PER_JIFFY     ((unsigned long) 1000000/HZ)
 #define CLK_TICKS_PER_JIFFY ((unsigned long) USECS_PER_JIFFY << 12)
 
+/*
+ * Create a small time difference between the timer interrupts
+ * on the different cpus to avoid lock contention.
+ */
+#define CPU_DEVIATION       (smp_processor_id() << 12)
+
 #define TICK_SIZE tick
 
 u64 jiffies_64;
 
 static ext_int_info_t ext_int_info_timer;
+static uint64_t xtime_cc;
 static uint64_t init_timer_cc;
 
 extern rwlock_t xtime_lock;
@@ -117,54 +124,77 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-
-#ifdef CONFIG_SMP
-extern __u16 boot_cpu_addr;
-#endif
-
 static void do_comparator_interrupt(struct pt_regs *regs, __u16 error_code)
 {
 	int cpu = smp_processor_id();
+	__u64 tmp;
+	__u32 ticks;
+
+	/* Calculate how many ticks have passed. */
+	asm volatile ("STCK 0(%0)" : : "a" (&tmp) : "memory", "cc");
+	tmp = tmp - S390_lowcore.jiffy_timer;
+	if (tmp >= 2*CLK_TICKS_PER_JIFFY) {  /* more than one tick ? */
+		ticks = tmp / CLK_TICKS_PER_JIFFY;
+		S390_lowcore.jiffy_timer +=
+			CLK_TICKS_PER_JIFFY * (__u64) ticks;
+	} else {
+		ticks = 1;
+		S390_lowcore.jiffy_timer += CLK_TICKS_PER_JIFFY;
+	}
+
+	/* set clock comparator for next tick */
+	tmp = S390_lowcore.jiffy_timer + CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
+        asm volatile ("SCKC %0" : : "m" (tmp));
 
 	irq_enter();
 
+#ifdef CONFIG_SMP
 	/*
-	 * set clock comparator for next tick
+	 * Do not rely on the boot cpu to do the calls to do_timer.
+	 * Spread it over all cpus instead.
 	 */
-        S390_lowcore.jiffy_timer += CLK_TICKS_PER_JIFFY;
-        asm volatile ("SCKC %0" : : "m" (S390_lowcore.jiffy_timer));
-
-#ifdef CONFIG_SMP
-	if (S390_lowcore.cpu_data.cpu_addr == boot_cpu_addr)
-		write_lock(&xtime_lock);
-
-	update_process_times(user_mode(regs));
-
-	if (S390_lowcore.cpu_data.cpu_addr == boot_cpu_addr) {
-		do_timer(regs);
-		write_unlock(&xtime_lock);
+	write_lock(&xtime_lock);
+	if (S390_lowcore.jiffy_timer > xtime_cc) {
+		__u32 xticks;
+
+		tmp = S390_lowcore.jiffy_timer - xtime_cc;
+		if (tmp >= 2*CLK_TICKS_PER_JIFFY) {
+			xticks = tmp / CLK_TICKS_PER_JIFFY;
+			xtime_cc += (__u64) xticks * CLK_TICKS_PER_JIFFY;
+		} else {
+			xticks = 1;
+			xtime_cc += CLK_TICKS_PER_JIFFY;
+		}
+		while (xticks--)
+			do_timer(regs);
 	}
+	write_unlock(&xtime_lock);
+	while (ticks--)
+		update_process_times(user_mode(regs));
 #else
-	do_timer(regs);
+	while (ticks--)
+		do_timer(regs);
 #endif
 
 	irq_exit();
 }
 
 /*
- * Start the clock comparator on the current CPU
+ * Start the clock comparator on the current CPU.
  */
 void init_cpu_timer(void)
 {
 	unsigned long cr0;
+	__u64 timer;
 
         /* allow clock comparator timer interrupt */
         asm volatile ("STCTG 0,0,%0" : "=m" (cr0) : : "memory");
         cr0 |= 0x800;
         asm volatile ("LCTLG 0,0,%0" : : "m" (cr0) : "memory");
-	S390_lowcore.jiffy_timer = (__u64) jiffies * CLK_TICKS_PER_JIFFY;
-	S390_lowcore.jiffy_timer += init_timer_cc + CLK_TICKS_PER_JIFFY;
-	asm volatile ("SCKC %0" : : "m" (S390_lowcore.jiffy_timer));
+	timer = init_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
+	S390_lowcore.jiffy_timer = timer;
+	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
+	asm volatile ("SCKC %0" : : "m" (timer));
 }
 
 /*
@@ -173,7 +203,7 @@
  */
 void __init time_init(void)
 {
-        __u64 set_time_cc;
+	__u64 set_time_cc;
 	int cc;
 
         /* kick the TOD clock */
@@ -196,8 +226,9 @@
         }
 
 	/* set xtime */
-        set_time_cc = init_timer_cc - 0x8126d60e46000000LL +
-                      (0x3c26700LL*1000000*4096);
+	xtime_cc = init_timer_cc;
+	set_time_cc = init_timer_cc - 0x8126d60e46000000LL +
+		(0x3c26700LL*1000000*4096);
         tod_to_timeval(set_time_cc, &xtime);
 
         /* request the 0x1004 external interrupt */

