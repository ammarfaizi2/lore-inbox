Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268373AbTBNMjM>; Fri, 14 Feb 2003 07:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268375AbTBNMjM>; Fri, 14 Feb 2003 07:39:12 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:1113
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268373AbTBNMjI>; Fri, 14 Feb 2003 07:39:08 -0500
Date: Fri, 14 Feb 2003 07:47:40 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5][2/14] smp_call_function_on_cpu - i386
In-Reply-To: <Pine.LNX.4.50.0302140348530.3518-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0302140745370.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140348530.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One liner to fix num_cpus == 0 on SMP kernel w/ UP box

Index: linux-2.5.60/arch/i386/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/i386/kernel/smp.c	10 Feb 2003 22:14:16 -0000	1.1.1.1
+++ linux-2.5.60/arch/i386/kernel/smp.c	14 Feb 2003 12:21:33 -0000
@@ -495,31 +495,33 @@
 static struct call_data_struct * call_data;
 
 /*
- * this function sends a 'generic call function' IPI to all other CPUs
- * in the system.
- */
-
-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
-			int wait)
-/*
- * [SUMMARY] Run a function on all other CPUs.
- * <func> The function to run. This must be fast and non-blocking.
- * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
- * <wait> If true, wait (atomically) until function has completed on other CPUs.
- * [RETURNS] 0 on success, else a negative status code. Does not return until
- * remote CPUs are nearly ready to execute <<func>> or are or have executed.
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
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info,
+				int wait, unsigned long mask)
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	int num_cpus, cpu;
 
-	if (!cpus)
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight32(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
 		return 0;
-
+	}
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
@@ -530,19 +532,33 @@
 	spin_lock(&call_lock);
 	call_data = &data;
 	wmb();
-	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+
+	/* Send a message to the CPUs in the mask and wait for them to respond */
+	if (mask == (cpu_online_map & ~(1UL << cpu)))
+		send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	else
+		send_IPI_mask_sequence(mask, CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
-		barrier();
+	while (atomic_read(&data.started) != num_cpus)
+		cpu_relax();
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
-			barrier();
+		while (atomic_read(&data.finished) != num_cpus)
+			cpu_relax();
 	spin_unlock(&call_lock);
-
+	put_cpu_no_resched();
 	return 0;
+}
+
+/*
+ * this function sends a 'generic call function' IPI to all other CPUs
+ * in the system.
+ */
+
+int smp_call_function (void (*func) (void *info), void *info, int nonatomic, int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 static void stop_this_cpu (void * dummy)
Index: linux-2.5.60/arch/i386/mach-voyager/voyager_smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/i386/mach-voyager/voyager_smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 voyager_smp.c
--- linux-2.5.60/arch/i386/mach-voyager/voyager_smp.c	10 Feb 2003 22:14:24 -0000	1.1.1.1
+++ linux-2.5.60/arch/i386/mach-voyager/voyager_smp.c	14 Feb 2003 12:42:43 -0000
@@ -1091,23 +1091,26 @@
 /* Call this function on all CPUs using the function_interrupt above 
     <func> The function to run. This must be fast and non-blocking.
     <info> An arbitrary pointer to pass to the function.
-    <retry> If true, keep retrying until ready.
     <wait> If true, wait until function has completed on other CPUs.
+    <mask> a bitmask of cpus to IPI to, this shouldn't contain the current cpu.
     [RETURNS] 0 on success, else a negative status code. Does not return until
     remote CPUs are nearly ready to execute <<func>> or are or have executed.
 */
+
 int
-smp_call_function (void (*func) (void *info), void *info, int retry,
-		   int wait)
+smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+				unsigned long mask)
 {
 	struct call_data_struct data;
-	__u32 mask = cpu_online_map;
-
-	mask &= ~(1<<smp_processor_id());
+	int cpu, num_cpus;
 
-	if (!mask)
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight32(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
 		return 0;
-
+	}
 	data.func = func;
 	data.info = info;
 	data.started = mask;
@@ -1118,8 +1121,8 @@
 	spin_lock(&call_lock);
 	call_data = &data;
 	wmb();
-	/* Send a message to all other CPUs and wait for them to respond */
-	send_CPI_allbutself(VIC_CALL_FUNCTION_CPI);
+	/* Send a message to CPUs and wait for them to respond */
+	send_CPI(mask, VIC_CALL_FUNCTION_CPI);
 
 	/* Wait for response */
 	while (data.started)
@@ -1130,8 +1133,14 @@
 			barrier();
 
 	spin_unlock(&call_lock);
-
+	put_cpu_no_resched();
 	return 0;
+}
+
+int
+smp_call_function (void (*func) (void *info), void *info, int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 /* Sorry about the name.  In an APIC based system, the APICs
