Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268387AbTBNMsr>; Fri, 14 Feb 2003 07:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268394AbTBNMsr>; Fri, 14 Feb 2003 07:48:47 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:30041
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268387AbTBNMsH>; Fri, 14 Feb 2003 07:48:07 -0500
Date: Fri, 14 Feb 2003 07:56:34 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Richard T Henderson <rth@twiddle.net>
Subject: Re: [PATCH][2.5][12/14] smp_call_function_on_cpu locking changes -
 Alpha
In-Reply-To: <Pine.LNX.4.50.0302140332040.3518-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0302140753310.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140332040.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One liner to fix num_cpus == 0 on SMP kernel w/ UP box

Index: linux-2.5.60/include/asm-alpha/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/include/asm-alpha/smp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.h
--- linux-2.5.60/include/asm-alpha/smp.h	10 Feb 2003 22:17:23 -0000	1.1.1.1
+++ linux-2.5.60/include/asm-alpha/smp.h	14 Feb 2003 07:55:55 -0000
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
Index: linux-2.5.60/arch/alpha/kernel/core_marvel.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/alpha/kernel/core_marvel.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 core_marvel.c
--- linux-2.5.60/arch/alpha/kernel/core_marvel.c	10 Feb 2003 22:14:49 -0000	1.1.1.1
+++ linux-2.5.60/arch/alpha/kernel/core_marvel.c	14 Feb 2003 05:37:27 -0000
@@ -785,7 +785,6 @@
 		if (smp_processor_id() != boot_cpuid)
 			smp_call_function_on_cpu(__marvel_access_rtc,
 						 &rtc_access,
-						 1,	/* retry */
 						 1,	/* wait  */
 						 1UL << boot_cpuid);
 		else
Index: linux-2.5.60/arch/alpha/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/alpha/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/alpha/kernel/smp.c	10 Feb 2003 22:14:47 -0000	1.1.1.1
+++ linux-2.5.60/arch/alpha/kernel/smp.c	14 Feb 2003 12:32:03 -0000
@@ -668,38 +667,7 @@
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
@@ -798,43 +766,48 @@
 }
 
 /*
- * Run a function on all other CPUs.
- *  <func>	The function to run. This must be fast and non-blocking.
- *  <info>	An arbitrary pointer to pass to the function.
- *  <retry>	If true, keep retrying until ready.
- *  <wait>	If true, wait until function has completed on other CPUs.
- *  [RETURNS]   0 on success, else a negative status code.
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask: The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
  *
- * Does not return until remote CPUs are nearly ready to execute <func>
- * or are or have executed.
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
 
 int
-smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry,
-			  int wait, unsigned long to_whom)
+smp_call_function_on_cpu (void (*func) (void *info), void *info,
+			  int wait, unsigned long mask)
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
-	num_cpus_to_call = hweight64(to_whom);
-
+	this_cpu = get_cpu();
+	mask &= ~(1UL << this_cpu);
+	num_cpus_to_call = hweight64(mask);
+	if (num_cpus_to_call == 0) {
+		put_cpu_no_resched();
+		return 0;
+	}
 	atomic_set(&data.unstarted_count, num_cpus_to_call);
 	atomic_set(&data.unfinished_count, num_cpus_to_call);
 
 	/* Acquire the smp_call_function_data mutex.  */
-	if (pointer_lock(&smp_call_function_data, &data, retry))
-		return -EBUSY;
+	spin_lock(&call_lock);
+	smp_call_function_data = data;
 
 	/* Send a message to the requested CPUs.  */
-	send_ipi_message(to_whom, IPI_CALL_FUNC);
+	send_ipi_message(mask, IPI_CALL_FUNC);
 
 	/* Wait for a minimal response.  */
 	timeout = jiffies + HZ;
@@ -865,8 +838,8 @@
 
 	/* We either got one or timed out -- clear the lock. */
 	mb();
-	smp_call_function_data = 0;
-
+	smp_call_function_data = NULL;
+	spin_unlock(&call_lock);
 	/* 
 	 * If after both the initial and long timeout periods we still don't
 	 * have a response, something is very wrong...
@@ -879,14 +852,14 @@
 			barrier();
 	}
 
+	put_cpu_no_resched();
 	return 0;
 }
 
 int
 smp_call_function (void (*func) (void *info), void *info, int retry, int wait)
 {
-	return smp_call_function_on_cpu (func, info, retry, wait,
-					 cpu_online_map);
+	return smp_call_function_on_cpu (func, info, wait, cpu_online_map);
 }
 
 static void
