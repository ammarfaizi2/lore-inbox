Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268331AbTBNJot>; Fri, 14 Feb 2003 04:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268338AbTBNJ1U>; Fri, 14 Feb 2003 04:27:20 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:37715
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268329AbTBNJZX>; Fri, 14 Feb 2003 04:25:23 -0500
Date: Fri, 14 Feb 2003 04:33:43 -0500 (EST)
From: Zwane Mwaikambo <zwane@zwane.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, "" <linux-mips@linux-mips.org>
Subject: [PATCH][2.5][4/14] smp_call_function_on_cpu - MIPS
Message-ID: <Pine.LNX.4.50.0302140356050.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   43 +++++++++++++++++++++++++++++--------------
 1 files changed, 29 insertions(+), 14 deletions(-)

Index: linux-2.5.60/arch/mips/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/mips/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/mips/kernel/smp.c	10 Feb 2003 22:15:04 -0000	1.1.1.1
+++ linux-2.5.60/arch/mips/kernel/smp.c	14 Feb 2003 06:09:00 -0000
@@ -185,22 +185,32 @@
 	smp_call_function(reschedule_this_cpu, NULL, 0, 0);
 }
 
-
 /*
- * The caller of this wants the passed function to run on every cpu.  If wait
- * is set, wait until all cpus have finished the function before returning.
- * The lock is here to protect the call structure.
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int smp_call_function (void (*func) (void *info), void *info, int retry, 
-								int wait)
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+				unsigned long mask)
 {
-	int cpus = smp_num_cpus - 1;
-	int i;
+	int cpu, i, num_cpus;
 
-	if (smp_num_cpus < 2) {
-		return 0;
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight32(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
+		return -EINVAL;
 	}
 
 	spin_lock(&smp_fn_call.lock);
@@ -209,19 +219,24 @@
 	smp_fn_call.fn = func;
 	smp_fn_call.data = info;
 
-	for (i = 0; i < smp_num_cpus; i++) {
-		if (i != smp_processor_id()) {
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
 			/* Call the board specific routine */
 			core_call_function(i);
-		}
 	}
 
 	if (wait) {
-		while(atomic_read(&smp_fn_call.finished) != cpus) {}
+		while(atomic_read(&smp_fn_call.finished) != num_cpus) {}
 	}
 
 	spin_unlock(&smp_fn_call.lock);
+	put_cpu_no_resched();
 	return 0;
+}
+
+int smp_call_function (void (*func) (void *info), void *info, int retry, int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 void synchronize_irq(void)
