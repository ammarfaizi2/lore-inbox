Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbTAVFHF>; Wed, 22 Jan 2003 00:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTAVFHF>; Wed, 22 Jan 2003 00:07:05 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:46852
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267319AbTAVFGx>; Wed, 22 Jan 2003 00:06:53 -0500
Date: Wed, 22 Jan 2003 00:16:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrea Arcangeli <andrea@suse.de>
Subject: [PATCH][2.5][0/18] smp_call_function_on_cpu - Alpha
Message-ID: <Pine.LNX.4.44.0301220015300.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.59/include/asm-alpha/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/asm-alpha/smp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.h
--- linux-2.5.59/include/asm-alpha/smp.h	17 Jan 2003 11:16:09 -0000	1.1.1.1
+++ linux-2.5.59/include/asm-alpha/smp.h	22 Jan 2003 02:39:13 -0000
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
Index: linux-2.5.59/arch/alpha/kernel/core_marvel.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/alpha/kernel/core_marvel.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 core_marvel.c
--- linux-2.5.59/arch/alpha/kernel/core_marvel.c	17 Jan 2003 11:14:48 -0000	1.1.1.1
+++ linux-2.5.59/arch/alpha/kernel/core_marvel.c	21 Jan 2003 23:33:34 -0000
@@ -800,7 +800,6 @@
 		if (smp_processor_id() != boot_cpuid)
 			smp_call_function_on_cpu(__marvel_access_rtc,
 						 &rtc_access,
-						 1,	/* retry */
 						 1,	/* wait  */
 						 1UL << boot_cpuid);
 		else
Index: linux-2.5.59/arch/alpha/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/alpha/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/alpha/kernel/smp.c	17 Jan 2003 11:14:48 -0000	1.1.1.1
+++ linux-2.5.59/arch/alpha/kernel/smp.c	22 Jan 2003 00:51:29 -0000
@@ -667,38 +667,7 @@
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
@@ -800,7 +769,6 @@
  * Run a function on all other CPUs.
  *  <func>	The function to run. This must be fast and non-blocking.
  *  <info>	An arbitrary pointer to pass to the function.
- *  <retry>	If true, keep retrying until ready.
  *  <wait>	If true, wait until function has completed on other CPUs.
  *  [RETURNS]   0 on success, else a negative status code.
  *
@@ -811,26 +779,27 @@
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
@@ -864,8 +833,8 @@
 
 	/* We either got one or timed out -- clear the lock. */
 	mb();
-	smp_call_function_data = 0;
-
+	smp_call_function_data = NULL;
+	spin_unlock(&call_lock);
 	/* 
 	 * If after both the initial and long timeout periods we still don't
 	 * have a response, something is very wrong...
@@ -878,14 +847,14 @@
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
@@ -898,7 +867,7 @@
 smp_imb(void)
 {
 	/* Must wait other processors to flush their icache before continue. */
-	if (smp_call_function(ipi_imb, NULL, 1, 1))
+	if (smp_call_function(ipi_imb, NULL, 1))
 		printk(KERN_CRIT "smp_imb: timed out\n");
 
 	imb();
@@ -915,7 +884,7 @@
 {
 	/* Although we don't have any data to pass, we do want to
 	   synchronize with the other processors.  */
-	if (smp_call_function(ipi_flush_tlb_all, NULL, 1, 1)) {
+	if (smp_call_function(ipi_flush_tlb_all, NULL, 1)) {
 		printk(KERN_CRIT "flush_tlb_all: timed out\n");
 	}
 
@@ -951,7 +920,7 @@
 		}
 	}
 
-	if (smp_call_function(ipi_flush_tlb_mm, mm, 1, 1)) {
+	if (smp_call_function(ipi_flush_tlb_mm, mm, 1)) {
 		printk(KERN_CRIT "flush_tlb_mm: timed out\n");
 	}
 }
@@ -998,7 +967,7 @@
 	data.mm = mm;
 	data.addr = addr;
 
-	if (smp_call_function(ipi_flush_tlb_page, &data, 1, 1)) {
+	if (smp_call_function(ipi_flush_tlb_page, &data, 1)) {
 		printk(KERN_CRIT "flush_tlb_page: timed out\n");
 	}
 }
@@ -1043,7 +1012,7 @@
 		}
 	}
 
-	if (smp_call_function(ipi_flush_icache_page, mm, 1, 1)) {
+	if (smp_call_function(ipi_flush_icache_page, mm, 1)) {
 		printk(KERN_CRIT "flush_icache_page: timed out\n");
 	}
 }

-- 
function.linuxpower.ca

