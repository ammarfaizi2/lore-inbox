Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTBIMGC>; Sun, 9 Feb 2003 07:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBIMAC>; Sun, 9 Feb 2003 07:00:02 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:59727
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267228AbTBIL4o>; Sun, 9 Feb 2003 06:56:44 -0500
Date: Sun, 9 Feb 2003 07:05:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][2/15] smp_call_function/_on_cpu - alpha
Message-ID: <Pine.LNX.4.50.0302090546270.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/alpha/kernel/core_marvel.c |    1 
 arch/alpha/kernel/smp.c         |   67 ++++++++++------------------------------
 include/asm-alpha/smp.h         |    7 ----
 3 files changed, 18 insertions(+), 57 deletions(-)

Index: linux-2.5.59-bk/include/asm-alpha/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/include/asm-alpha/smp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.h
--- linux-2.5.59-bk/include/asm-alpha/smp.h	9 Feb 2003 09:09:17 -0000	1.1.1.1
+++ linux-2.5.59-bk/include/asm-alpha/smp.h	9 Feb 2003 09:23:29 -0000
@@ -56,13 +56,6 @@
 {
 	return hweight64(cpu_online_map);
 }
-
-extern int smp_call_function_on_cpu(void (*func) (void *info), void *info,int retry, int wait, unsigned long cpu);
-
-#else /* CONFIG_SMP */
-
-#define smp_call_function_on_cpu(func,info,retry,wait,cpu)    ({ 0; })
-
 #endif /* CONFIG_SMP */
 
 #define NO_PROC_ID	(-1)
Index: linux-2.5.59-bk/arch/alpha/kernel/core_marvel.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/alpha/kernel/core_marvel.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 core_marvel.c
--- linux-2.5.59-bk/arch/alpha/kernel/core_marvel.c	9 Feb 2003 09:08:18 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/alpha/kernel/core_marvel.c	9 Feb 2003 09:23:29 -0000
@@ -785,7 +785,6 @@
 		if (smp_processor_id() != boot_cpuid)
 			smp_call_function_on_cpu(__marvel_access_rtc,
 						 &rtc_access,
-						 1,	/* retry */
 						 1,	/* wait  */
 						 1UL << boot_cpuid);
 		else
Index: linux-2.5.59-bk/arch/alpha/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/alpha/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/alpha/kernel/smp.c	9 Feb 2003 09:08:18 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/alpha/kernel/smp.c	9 Feb 2003 09:23:29 -0000
@@ -668,38 +668,7 @@
 };
 
 static struct smp_call_struct *smp_call_function_data;
-
-/* Atomicly drop data into a shared pointer.  The pointer is free if
-   it is initially locked.  If retry, spin until free.  */
-
-static int
-pointer_lock (void *lock, void *data, int retry)
-{
-	void *old, *tmp;
-
-	mb();
- again:
-	/* Compare and swap with zero.  */
-	asm volatile (
-	"1:	ldq_l	%0,%1\n"
-	"	mov	%3,%2\n"
-	"	bne	%0,2f\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,1b\n"
-	"2:"
-	: "=&r"(old), "=m"(*(void **)lock), "=&r"(tmp)
-	: "r"(data)
-	: "memory");
-
-	if (old == 0)
-		return 0;
-	if (! retry)
-		return -EBUSY;
-
-	while (*(void **)lock)
-		barrier();
-	goto again;
-}
+static spinlock_t call_lock = SPIN_LOCK_UNLOCKED;
 
 void
 handle_ipi(struct pt_regs *regs)
@@ -801,7 +770,6 @@
  * Run a function on all other CPUs.
  *  <func>	The function to run. This must be fast and non-blocking.
  *  <info>	An arbitrary pointer to pass to the function.
- *  <retry>	If true, keep retrying until ready.
  *  <wait>	If true, wait until function has completed on other CPUs.
  *  [RETURNS]   0 on success, else a negative status code.
  *
@@ -812,26 +780,27 @@
  */
 
 int
-smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry,
+smp_call_function_on_cpu (void (*func) (void *info), void *info,
 			  int wait, unsigned long to_whom)
 {
 	struct smp_call_struct data;
 	long timeout;
-	int num_cpus_to_call;
-	
+	int num_cpus_to_call, this_cpu;
+
 	data.func = func;
 	data.info = info;
 	data.wait = wait;
 
-	to_whom &= ~(1L << smp_processor_id());
+	this_cpu = get_cpu();
+	to_whom &= ~(1UL << this_cpu);
 	num_cpus_to_call = hweight64(to_whom);
 
 	atomic_set(&data.unstarted_count, num_cpus_to_call);
 	atomic_set(&data.unfinished_count, num_cpus_to_call);
 
 	/* Acquire the smp_call_function_data mutex.  */
-	if (pointer_lock(&smp_call_function_data, &data, retry))
-		return -EBUSY;
+	spin_lock(&call_lock);
+	smp_call_function_data = data;
 
 	/* Send a message to the requested CPUs.  */
 	send_ipi_message(to_whom, IPI_CALL_FUNC);
@@ -865,8 +834,8 @@
 
 	/* We either got one or timed out -- clear the lock. */
 	mb();
-	smp_call_function_data = 0;
-
+	smp_call_function_data = NULL;
+	spin_unlock(&call_lock);
 	/* 
 	 * If after both the initial and long timeout periods we still don't
 	 * have a response, something is very wrong...
@@ -879,14 +848,14 @@
 			barrier();
 	}
 
+	put_cpu_no_resched();
 	return 0;
 }
 
 int
-smp_call_function (void (*func) (void *info), void *info, int retry, int wait)
+smp_call_function (void (*func) (void *info), void *info, int wait)
 {
-	return smp_call_function_on_cpu (func, info, retry, wait,
-					 cpu_online_map);
+	return smp_call_function_on_cpu (func, info, wait, cpu_online_map);
 }
 
 static void
@@ -899,7 +868,7 @@
 smp_imb(void)
 {
 	/* Must wait other processors to flush their icache before continue. */
-	if (smp_call_function(ipi_imb, NULL, 1, 1))
+	if (smp_call_function(ipi_imb, NULL, 1))
 		printk(KERN_CRIT "smp_imb: timed out\n");
 
 	imb();
@@ -916,7 +885,7 @@
 {
 	/* Although we don't have any data to pass, we do want to
 	   synchronize with the other processors.  */
-	if (smp_call_function(ipi_flush_tlb_all, NULL, 1, 1)) {
+	if (smp_call_function(ipi_flush_tlb_all, NULL, 1)) {
 		printk(KERN_CRIT "flush_tlb_all: timed out\n");
 	}
 
@@ -952,7 +921,7 @@
 		}
 	}
 
-	if (smp_call_function(ipi_flush_tlb_mm, mm, 1, 1)) {
+	if (smp_call_function(ipi_flush_tlb_mm, mm, 1)) {
 		printk(KERN_CRIT "flush_tlb_mm: timed out\n");
 	}
 }
@@ -999,7 +968,7 @@
 	data.mm = mm;
 	data.addr = addr;
 
-	if (smp_call_function(ipi_flush_tlb_page, &data, 1, 1)) {
+	if (smp_call_function(ipi_flush_tlb_page, &data, 1)) {
 		printk(KERN_CRIT "flush_tlb_page: timed out\n");
 	}
 }
@@ -1044,7 +1013,7 @@
 		}
 	}
 
-	if (smp_call_function(ipi_flush_icache_page, mm, 1, 1)) {
+	if (smp_call_function(ipi_flush_icache_page, mm, 1)) {
 		printk(KERN_CRIT "flush_icache_page: timed out\n");
 	}
 }
