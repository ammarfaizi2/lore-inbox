Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267378AbTAQFJi>; Fri, 17 Jan 2003 00:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267381AbTAQFJi>; Fri, 17 Jan 2003 00:09:38 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:38155
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267378AbTAQFJg>; Fri, 17 Jan 2003 00:09:36 -0500
Date: Fri, 17 Jan 2003 00:18:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5] smp_call_function_mask
Message-ID: <Pine.LNX.4.44.0301170014230.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a smp_call_function which also accepts a cpu mask which is 
needed for targetting specific or groups of cpus.

Index: linux-2.5.58-cpu_hotplug/arch/i386/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.58/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- linux-2.5.58-cpu_hotplug/arch/i386/kernel/smp.c	14 Jan 2003 06:59:22 -0000	1.1.1.1
+++ linux-2.5.58-cpu_hotplug/arch/i386/kernel/smp.c	15 Jan 2003 07:59:32 -0000	1.2
@@ -544,6 +544,57 @@
 	return 0;
 }
 
+int smp_call_function_mask (void (*func) (void *info), void *info, int nonatomic,
+			int wait, unsigned long mask)
+/*
+ * [SUMMARY] Run a function on specific CPUs, save self.
+ * <func> The function to run. This must be fast and non-blocking.
+ * <info> An arbitrary pointer to pass to the function.
+ * <nonatomic> currently unused.
+ * <wait> If true, wait (atomically) until function has completed on other CPUs.
+ * <mask> The bitmask of CPUs to call the function
+ * [RETURNS] 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute <<func>> or are or have executed.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+{
+	struct call_data_struct data;
+	int num_cpus = hweight32(mask);
+
+	if (num_cpus == 0)
+		return -EINVAL;
+
+	if ((1UL << smp_processor_id()) & mask)
+		return -EINVAL;
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock(&call_lock);
+	call_data = &data;
+	wmb();
+
+	/* Send a message to the CPUs in the mask and wait for them to respond */
+	send_IPI_mask_sequence(mask, CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != num_cpus)
+		barrier();
+
+	if (wait)
+		while (atomic_read(&data.finished) != num_cpus)
+			barrier();
+	spin_unlock(&call_lock);
+
+	return 0;
+}
+
 static void stop_this_cpu (void * dummy)
 {
 	/*
Index: linux-2.5.58-cpu_hotplug/include/linux/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.58/include/linux/smp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.h
--- linux-2.5.58-cpu_hotplug/include/linux/smp.h	14 Jan 2003 07:02:19 -0000	1.1.1.1
+++ linux-2.5.58-cpu_hotplug/include/linux/smp.h	15 Jan 2003 08:13:35 -0000
@@ -53,6 +53,9 @@
 extern int smp_call_function (void (*func) (void *info), void *info,
 			      int retry, int wait);
 
+extern int smp_call_function_mask (void (*func) (void *info), void *info,
+				int retry, int wait, unsigned long mask);
+
 /*
  * True once the per process idle is forked
  */
@@ -96,6 +99,7 @@
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
 #define smp_call_function(func,info,retry,wait)	({ 0; })
+#define smp_call_function_mask(func,info,retry,wait,mask) ({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map				1

-- 
function.linuxpower.ca

