Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbTBIMD7>; Sun, 9 Feb 2003 07:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTBIMAM>; Sun, 9 Feb 2003 07:00:12 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2896
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267243AbTBIL6D>; Sun, 9 Feb 2003 06:58:03 -0500
Date: Sun, 9 Feb 2003 07:06:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][8/15] smp_call_function/_on_cpu - ppc
Message-ID: <Pine.LNX.4.50.0302090651000.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 82 insertions(+), 4 deletions(-)

Index: linux-2.5.59-bk/arch/ppc/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/ppc/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/ppc/kernel/smp.c	9 Feb 2003 09:08:32 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/ppc/kernel/smp.c	9 Feb 2003 09:23:30 -0000
@@ -165,7 +165,7 @@
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
+	smp_call_function(stop_this_cpu, NULL, 0);
 }
 
 /*
@@ -188,13 +188,10 @@
  * in the system.
  */
 
-int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
-		      int wait)
 /*
  * [SUMMARY] Run a function on all other CPUs.
  * <func> The function to run. This must be fast and non-blocking.
  * <info> An arbitrary pointer to pass to the function.
- * <nonatomic> currently unused.
  * <wait> If true, wait (atomically) until function has completed on other CPUs.
  * [RETURNS] 0 on success, else a negative status code. Does not return until
  * remote CPUs are nearly ready to execute <<func>> or are or have executed.
@@ -202,6 +199,8 @@
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
+
+int smp_call_function(void (*func) (void *info), void *info, int wait)
 {
 	/* FIXME: get cpu lock with hotplug cpus, or change this to
            bitmask. --RR */
@@ -263,6 +262,85 @@
 
  out:
 	spin_unlock(&call_lock);
+	return ret;
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
+static int smp_call_function_on_cpu(void (*func) (void *info), void *info,
+					int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int ret = -1;
+	int timeout;
+	int i, cpu, num_cpus = hweight32(mask);
+
+	if (num_cpus == 0)
+		return -EINVAL;
+
+	cpu = get_cpu();
+	if ((1UL << cpu) & mask) {
+		put_cpu_no_resched();
+		return -EINVAL;
+	}
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
+	/* Send a message to all other CPUs and wait for them to respond */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << i) & mask))
+			smp_message_pass(i, PPC_MSG_CALL_FUNCTION, 0, 0);
+	}
+
+	/* Wait for response */
+	timeout = 1000000;
+	while (atomic_read(&data.started) != num_cpus) {
+		if (--timeout == 0) {
+			printk("smp_call_function on cpu %d: other cpus not responding (%d)\n",
+			       cpu, atomic_read(&data.started));
+			goto out;
+		}
+		barrier();
+		udelay(1);
+	}
+
+	if (wait) {
+		timeout = 1000000;
+		while (atomic_read(&data.finished) != num_cpus) {
+			if (--timeout == 0) {
+				printk("smp_call_function on cpu %d: other cpus not finishing (%d/%d)\n",
+				       cpu, atomic_read(&data.finished), atomic_read(&data.started));
+				goto out;
+			}
+			barrier();
+			udelay(1);
+		}
+	}
+	ret = 0;
+
+ out:
+	spin_unlock(&call_lock);
+	pu_cpu_no_resched();
 	return ret;
 }
 
