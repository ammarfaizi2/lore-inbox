Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTBIMSv>; Sun, 9 Feb 2003 07:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267308AbTBIMSv>; Sun, 9 Feb 2003 07:18:51 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:6224
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267241AbTBIL6k>; Sun, 9 Feb 2003 06:58:40 -0500
Date: Sun, 9 Feb 2003 07:07:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][12/15] smp_call_function/_on_cpu - sparc64
Message-ID: <Pine.LNX.4.50.0302090654570.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 62 insertions(+), 2 deletions(-)

Index: linux-2.5.59-bk/arch/sparc64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/sparc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/sparc64/kernel/smp.c	9 Feb 2003 09:08:36 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/sparc64/kernel/smp.c	9 Feb 2003 09:23:30 -0000
@@ -490,8 +490,7 @@
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int smp_call_function(void (*func)(void *info), void *info,
-		      int nonatomic, int wait)
+int smp_call_function(void (*func)(void *info), void *info, int wait)
 {
 	struct call_data_struct data;
 	int cpus = num_online_cpus() - 1;
@@ -531,6 +530,67 @@
 	spin_unlock(&call_lock);
 	printk("XCALL: Remote cpus not responding, ncpus=%d finished=%d\n",
 	       num_online_cpus() - 1, atomic_read(&data.finished));
+	return 0;
+}
+
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
+int smp_call_function_on_cpu(void (*func)(void *info), void *info,
+				int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int num_cpus = hweight32(mask), cpu;
+	long timeout;
+
+	cpu = get_cpu();
+	if (((1UL << cpu) & mask) || num_cpus == 0)
+		goto out;
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.finished, 0);
+	data.wait = wait;
+
+	spin_lock(&call_lock);
+
+	call_data = &data;
+
+	smp_cross_call_masked(&xcall_call_function, 0, 0, 0, mask);
+
+	/* 
+	 * Wait for target cpus to complete function or at
+	 * least snap the call data.
+	 */
+	timeout = 1000000;
+	while (atomic_read(&data.finished) != num_cpus) {
+		if (--timeout <= 0)
+			goto out_timeout;
+		barrier();
+		udelay(1);
+	}
+
+	spin_unlock(&call_lock);
+	goto out;
+
+out_timeout:
+	spin_unlock(&call_lock);
+	printk("XCALL: Remote cpus not responding, ncpus=%d finished=%d\n",
+	       num_cpus, atomic_read(&data.finished));
+out:
+	put_cpu_no_resched();
 	return 0;
 }
 
