Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267343AbTAVFQY>; Wed, 22 Jan 2003 00:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTAVFQY>; Wed, 22 Jan 2003 00:16:24 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:59908
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267356AbTAVFQU>; Wed, 22 Jan 2003 00:16:20 -0500
Date: Wed, 22 Jan 2003 00:25:41 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: [PATCH][2.5][7/18] smp_call_function_on_cpu - mips
Message-ID: <Pine.LNX.4.44.0301220024300.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.59/arch/mips/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/mips/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/mips/kernel/smp.c	17 Jan 2003 11:14:52 -0000	1.1.1.1
+++ linux-2.5.59/arch/mips/kernel/smp.c	22 Jan 2003 00:38:02 -0000
@@ -182,7 +182,7 @@
 
 void FASTCALL(smp_send_reschedule(int cpu))
 {
-	smp_call_function(reschedule_this_cpu, NULL, 0, 0);
+	smp_call_function(reschedule_this_cpu, NULL, 0);
 }
 
 
@@ -193,8 +193,7 @@
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int smp_call_function (void (*func) (void *info), void *info, int retry, 
-								int wait)
+int smp_call_function (void (*func) (void *info), void *info, int wait)
 {
 	int cpus = smp_num_cpus - 1;
 	int i;
@@ -224,6 +223,53 @@
 	return 0;
 }
 
+/*
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
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+				unsigned long mask)
+{
+	int cpu, i, num_cpus = hweight32(mask);
+
+	cpu = get_cpu();
+	if (((1UL << cpu) & mask) || num_cpus == 0) {
+		put_cpu_no_resched();
+		return -EINVAL;
+	}
+
+	spin_lock(&smp_fn_call.lock);
+
+	atomic_set(&smp_fn_call.finished, 0);
+	smp_fn_call.fn = func;
+	smp_fn_call.data = info;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
+			/* Call the board specific routine */
+			core_call_function(i);
+	}
+
+	if (wait) {
+		while(atomic_read(&smp_fn_call.finished) != num_cpus) {}
+	}
+
+	spin_unlock(&smp_fn_call.lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 void synchronize_irq(void)
 {
 	panic("synchronize_irq");
@@ -237,7 +283,7 @@
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
+	smp_call_function(stop_this_cpu, NULL, 0);
 	smp_num_cpus = 1;
 }
 

-- 
function.linuxpower.ca


