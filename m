Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268211AbTBNJ30>; Fri, 14 Feb 2003 04:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268201AbTBNJ2L>; Fri, 14 Feb 2003 04:28:11 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2388
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268211AbTBNJ0y>; Fri, 14 Feb 2003 04:26:54 -0500
Date: Fri, 14 Feb 2003 04:34:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@zwane.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5][9/14] smp_call_function_on_cpu - s390x
Message-ID: <Pine.LNX.4.50.0302140406140.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   52 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 34 insertions(+), 18 deletions(-)

Index: linux-2.5.60/arch/s390x/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/s390x/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/s390x/kernel/smp.c	10 Feb 2003 22:15:48 -0000	1.1.1.1
+++ linux-2.5.60/arch/s390x/kernel/smp.c	14 Feb 2003 07:34:43 -0000
@@ -101,28 +101,34 @@
  * in the system.
  */
 
-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
-			int wait)
 /*
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
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+				unsigned long mask)
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
-
-	/* FIXME: get cpu lock -hc */
-	if (cpus <= 0)
-		return 0;
+	int cpu, i, num_cpus;
 
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight64(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
+		return -EINVAL;
+	}
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
@@ -133,18 +139,28 @@
 	spin_lock(&call_lock);
 	call_data = &data;
 	/* Send a message to all other CPUs and wait for them to respond */
-        smp_ext_bitcall_others(ec_call_function);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
+			smp_ext_bitcall(i, ec_call_function);
+	}
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
+	while (atomic_read(&data.started) != num_cpus)
 		barrier();
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
+		while (atomic_read(&data.finished) != num_cpus)
 			barrier();
-	spin_unlock(&call_lock);
 
+	spin_unlock(&call_lock);
+	put_cpu_no_resched();
 	return 0;
+}
+
+int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
+			int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 static inline void do_send_stop(void)
