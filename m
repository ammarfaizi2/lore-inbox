Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268354AbTBNJhf>; Fri, 14 Feb 2003 04:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268333AbTBNJ2A>; Fri, 14 Feb 2003 04:28:00 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:61011
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268161AbTBNJ0o>; Fri, 14 Feb 2003 04:26:44 -0500
Date: Fri, 14 Feb 2003 04:35:13 -0500 (EST)
From: Zwane Mwaikambo <zwane@zwane.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5][7/14] smp_call_function_on_cpu - PPC64
Message-ID: <Pine.LNX.4.50.0302140404300.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   60 ++++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 40 insertions(+), 20 deletions(-)

Index: linux-2.5.60/arch/ppc64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/ppc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/ppc64/kernel/smp.c	10 Feb 2003 22:15:14 -0000	1.1.1.1
+++ linux-2.5.60/arch/ppc64/kernel/smp.c	14 Feb 2003 07:03:47 -0000
@@ -452,29 +452,34 @@
 #define SMP_CALL_TIMEOUT (1UL << (30 + 3))
 
 /*
- * This function sends a 'generic call function' IPI to all other CPUs
- * in the system.
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
  *
- * [SUMMARY] Run a function on all other CPUs.
- * <func> The function to run. This must be fast and non-blocking.
- * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
- * <wait> If true, wait (atomically) until function has completed on other CPUs.
- * [RETURNS] 0 on success, else a negative status code. Does not return until
- * remote CPUs are nearly ready to execute <<func>> or are or have executed.
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
-		       int wait)
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+				unsigned long mask)
 { 
 	struct call_data_struct data;
-	int ret = -1, cpus = num_online_cpus()-1;
+	int ret, cpu, i, num_cpus;
 	unsigned long timeout;
 
-	if (!cpus)
-		return 0;
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight64(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
+		return -EINVAL;
+	}
 
 	data.func = func;
 	data.info = info;
@@ -487,11 +492,18 @@
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
-	smp_message_pass(MSG_ALL_BUT_SELF, PPC_MSG_CALL_FUNCTION, 0, 0);
+	if (mask == (cpu_online_map & ~(1UL << cpu))) {
+		smp_message_pass(MSG_ALL_BUT_SELF, PPC_MSG_CALL_FUNCTION, 0, 0);
+	} else {
+		for (i = 0; i < NR_CPUS; i++) {
+			if (cpu_online(i) && ((1UL << i) & mask))
+				smp_message_pass(i, PPC_MSG_CALL_FUNCTION, 0, 0);
+		}
+	}
 
 	/* Wait for response */
 	timeout = SMP_CALL_TIMEOUT;
-	while (atomic_read(&data.started) != cpus) {
+	while (atomic_read(&data.started) != num_cpus) {
 		HMT_low();
 		if (--timeout == 0) {
 #ifdef CONFIG_DEBUG_KERNEL
@@ -499,15 +511,16 @@
 				debugger(0);
 #endif
 			printk("smp_call_function on cpu %d: other cpus not "
-			       "responding (%d)\n", smp_processor_id(),
+			       "responding (%d)\n", cpu,
 			       atomic_read(&data.started));
+			ret = -EIO;
 			goto out;
 		}
 	}
 
 	if (wait) {
 		timeout = SMP_CALL_TIMEOUT;
-		while (atomic_read(&data.finished) != cpus) {
+		while (atomic_read(&data.finished) != num_cpus) {
 			HMT_low();
 			if (--timeout == 0) {
 #ifdef CONFIG_DEBUG_KERNEL
@@ -516,20 +529,27 @@
 #endif
 				printk("smp_call_function on cpu %d: other "
 				       "cpus not finishing (%d/%d)\n",
-				       smp_processor_id(),
+				       cpu,
 				       atomic_read(&data.finished),
 				       atomic_read(&data.started));
+				ret = -EIO;
 				goto out;
 			}
 		}
 	}
 
 	ret = 0;
-
 out:
 	HMT_medium();
 	spin_unlock(&call_lock);
+	put_cpu_no_resched();
 	return ret;
+}
+
+int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
+			int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 void smp_call_function_interrupt(void)
