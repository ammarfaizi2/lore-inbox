Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268383AbTBNMqR>; Fri, 14 Feb 2003 07:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268378AbTBNMoe>; Fri, 14 Feb 2003 07:44:34 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:13657
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268390AbTBNMoN>; Fri, 14 Feb 2003 07:44:13 -0500
Date: Fri, 14 Feb 2003 07:52:42 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5][10/14] smp_call_function_on_cpu - sparc64
In-Reply-To: <Pine.LNX.4.50.0302140407130.3518-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0302140752220.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140407130.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One liner to fix num_cpus == 0 on SMP kernel w/ UP box

Index: linux-2.5.60/arch/sparc64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/sparc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/sparc64/kernel/smp.c	10 Feb 2003 22:14:11 -0000	1.1.1.1
+++ linux-2.5.60/arch/sparc64/kernel/smp.c	14 Feb 2003 12:23:46 -0000
@@ -487,18 +487,34 @@
 extern unsigned long xcall_call_function;
 
 /*
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
-int smp_call_function(void (*func)(void *info), void *info,
-		      int nonatomic, int wait)
+
+int smp_call_function_on_cpu(void (*func)(void *info), void *info,
+				int wait, unsigned long mask)
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus() - 1;
+	int num_cpus, cpu;
 	long timeout;
 
-	if (!cpus)
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight64(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
 		return 0;
+	}
 
 	data.func = func;
 	data.info = info;
@@ -506,32 +522,34 @@
 	data.wait = wait;
 
 	spin_lock(&call_lock);
-
 	call_data = &data;
-
-	smp_cross_call(&xcall_call_function, 0, 0, 0);
+	smp_cross_call_masked(&xcall_call_function, 0, 0, 0, mask);
 
 	/* 
-	 * Wait for other cpus to complete function or at
+	 * Wait for target cpus to complete function or at
 	 * least snap the call data.
 	 */
 	timeout = 1000000;
-	while (atomic_read(&data.finished) != cpus) {
-		if (--timeout <= 0)
-			goto out_timeout;
+	while (atomic_read(&data.finished) != num_cpus) {
+		if (--timeout <= 0) {
+			printk("XCALL: Remote cpus not responding, ncpus=%d finished=%d\n",
+				num_cpus, atomic_read(&data.finished));
+			goto out;
+		}
 		barrier();
 		udelay(1);
 	}
 
+out:
 	spin_unlock(&call_lock);
-
+	put_cpu_no_resched();
 	return 0;
+}
 
-out_timeout:
-	spin_unlock(&call_lock);
-	printk("XCALL: Remote cpus not responding, ncpus=%d finished=%d\n",
-	       num_online_cpus() - 1, atomic_read(&data.finished));
-	return 0;
+int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
+			int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 void smp_call_function_client(int irq, struct pt_regs *regs)
