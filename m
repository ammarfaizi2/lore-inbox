Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268327AbTBNJ1M>; Fri, 14 Feb 2003 04:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbTBNJ1L>; Fri, 14 Feb 2003 04:27:11 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:34387
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268327AbTBNJZC>; Fri, 14 Feb 2003 04:25:02 -0500
Date: Fri, 14 Feb 2003 04:33:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@zwane.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5][3/14] smp_call_function_on_cpu - ia64
Message-ID: <Pine.LNX.4.50.0302140353570.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |  101 ++++++++++++++++++++++++++++--------------------------------------
 1 files changed, 44 insertions(+), 57 deletions(-)

Index: linux-2.5.60/arch/ia64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/ia64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/ia64/kernel/smp.c	10 Feb 2003 22:15:36 -0000	1.1.1.1
+++ linux-2.5.60/arch/ia64/kernel/smp.c	14 Feb 2003 05:52:19 -0000
@@ -230,29 +230,33 @@
 }
 
 /*
- * Run a function on another CPU
- *  <func>	The function to run. This must be fast and non-blocking.
- *  <info>	An arbitrary pointer to pass to the function.
- *  <nonatomic>	Currently unused.
- *  <wait>	If true, wait until function has completed on other CPUs.
- *  [RETURNS]   0 on success, else a negative status code.
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
  *
- * Does not return until the remote CPU is nearly ready to execute <func>
- * or is or has executed.
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask: The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
  */
 
-int
-smp_call_function_single (int cpuid, void (*func) (void *info), void *info, int nonatomic,
-			  int wait)
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+				unsigned long mask)
 {
 	struct call_data_struct data;
-	int cpus = 1;
+	int num_cpus, cpu, i;
 
-	if (cpuid == smp_processor_id()) {
-		printk("%s: trying to call self\n", __FUNCTION__);
-		return -EBUSY;
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight64(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
+		return -EINVAL;
 	}
-
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
@@ -264,73 +268,56 @@
 
 	call_data = &data;
 	mb();	/* ensure store to call_data precedes setting of IPI_CALL_FUNC */
-  	send_IPI_single(cpuid, IPI_CALL_FUNC);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
+			send_IPI_single(i, IPI_CALL_FUNC);
+	}
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
+	while (atomic_read(&data.started) != num_cpus)
 		barrier();
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
+		while (atomic_read(&data.finished) != num_cpus)
 			barrier();
 	call_data = NULL;
 
 	spin_unlock_bh(&call_lock);
+	put_cpu_no_resched();
 	return 0;
 }
 
+/* This is here for API compatibility reasons, please remove in 2.7 */
+int smp_call_function_single (int cpuid, void (*func) (void *info), void *info,
+				int retry, int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, 1UL << cpuid);
+}
+
 /*
  * this function sends a 'generic call function' IPI to all other CPUs
  * in the system.
  */
 
 /*
- *  [SUMMARY]	Run a function on all other CPUs.
- *  <func>	The function to run. This must be fast and non-blocking.
- *  <info>	An arbitrary pointer to pass to the function.
- *  <nonatomic>	currently unused.
- *  <wait>	If true, wait (atomically) until function has completed on other CPUs.
- *  [RETURNS]   0 on success, else a negative status code.
+ * smp_call_function_on_cpu - Runs func on all other processors
  *
- * Does not return until remote CPUs are nearly ready to execute <func> or are or have
- * executed.
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @nonatomic: unused
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
+
 int
 smp_call_function (void (*func) (void *info), void *info, int nonatomic, int wait)
 {
-	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
-
-	if (!cpus)
-		return 0;
-
-	data.func = func;
-	data.info = info;
-	atomic_set(&data.started, 0);
-	data.wait = wait;
-	if (wait)
-		atomic_set(&data.finished, 0);
-
-	spin_lock(&call_lock);
-
-	call_data = &data;
-	mb();	/* ensure store to call_data precedes setting of IPI_CALL_FUNC */
-	send_IPI_allbutself(IPI_CALL_FUNC);
-
-	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
-		barrier();
-
-	if (wait)
-		while (atomic_read(&data.finished) != cpus)
-			barrier();
-	call_data = NULL;
-
-	spin_unlock(&call_lock);
-	return 0;
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 void
