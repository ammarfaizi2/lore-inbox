Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268386AbTBNMoX>; Fri, 14 Feb 2003 07:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268392AbTBNMoB>; Fri, 14 Feb 2003 07:44:01 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:7513
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268386AbTBNMmh>; Fri, 14 Feb 2003 07:42:37 -0500
Date: Fri, 14 Feb 2003 07:50:59 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5][6/14] smp_call_function_on_cpu - PPC32
In-Reply-To: <Pine.LNX.4.50.0302140402190.3518-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0302140750311.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140402190.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One liner to fix num_cpus == 0 on SMP kernel w/ UP box

Index: linux-2.5.60/arch/ppc/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/ppc/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/ppc/kernel/smp.c	10 Feb 2003 22:14:40 -0000	1.1.1.1
+++ linux-2.5.60/arch/ppc/kernel/smp.c	14 Feb 2003 12:22:34 -0000
@@ -65,8 +65,6 @@
 int start_secondary(void *);
 extern int cpu_idle(void *unused);
 void smp_call_function_interrupt(void);
-static int __smp_call_function(void (*func) (void *info), void *info,
-			       int wait, int target);
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  * 
@@ -188,40 +186,35 @@
  * in the system.
  */
 
-int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
-		      int wait)
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
-{
-	/* FIXME: get cpu lock with hotplug cpus, or change this to
-           bitmask. --RR */
-	if (num_online_cpus() <= 1)
-		return 0;
-	return __smp_call_function(func, info, wait, MSG_ALL_BUT_SELF);
-}
 
-static int __smp_call_function(void (*func) (void *info), void *info,
-			       int wait, int target)
+static int smp_call_function_on_cpu(void (*func) (void *info), void *info,
+					int wait, unsigned long mask)
 {
 	struct call_data_struct data;
 	int ret = -1;
 	int timeout;
-	int ncpus = 1;
+	int i, cpu, num_cpus;
 
-	if (target == MSG_ALL_BUT_SELF)
-		ncpus = num_online_cpus() - 1;
-	else if (target == MSG_ALL)
-		ncpus = num_online_cpus();
+	cpu = get_cpu();
+	num_cpus = hweight32(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
+		return 0;
+	}
 
 	data.func = func;
 	data.info = info;
@@ -233,14 +226,23 @@
 	spin_lock(&call_lock);
 	call_data = &data;
 	/* Send a message to all other CPUs and wait for them to respond */
-	smp_message_pass(target, PPC_MSG_CALL_FUNCTION, 0, 0);
+	if (mask == cpu_online_map) {
+		smp_message_pass(MSG_ALL, PPC_MSG_CALL_FUNCTION, 0, 0);
+	} else if (mask == (cpu_online_map & ~(1UL <<  cpu))) {
+		smp_message_pass(MSG_ALL_BUT_SELF, PPC_MSG_CALL_FUNCTION, 0, 0);
+	} else {
+		for (i = 0; i < NR_CPUS; i++) {
+			if (cpu_online(i) && ((1UL << i) & mask))
+				smp_message_pass(i, PPC_MSG_CALL_FUNCTION, 0, 0);
+		}
+	}
 
 	/* Wait for response */
 	timeout = 1000000;
-	while (atomic_read(&data.started) != ncpus) {
+	while (atomic_read(&data.started) != num_cpus) {
 		if (--timeout == 0) {
 			printk("smp_call_function on cpu %d: other cpus not responding (%d)\n",
-			       smp_processor_id(), atomic_read(&data.started));
+			       cpu, atomic_read(&data.started));
 			goto out;
 		}
 		barrier();
@@ -249,10 +251,10 @@
 
 	if (wait) {
 		timeout = 1000000;
-		while (atomic_read(&data.finished) != ncpus) {
+		while (atomic_read(&data.finished) != num_cpus) {
 			if (--timeout == 0) {
 				printk("smp_call_function on cpu %d: other cpus not finishing (%d/%d)\n",
-				       smp_processor_id(), atomic_read(&data.finished), atomic_read(&data.started));
+				       cpu, atomic_read(&data.finished), atomic_read(&data.started));
 				goto out;
 			}
 			barrier();
@@ -263,7 +265,26 @@
 
  out:
 	spin_unlock(&call_lock);
+	pu_cpu_no_resched();
 	return ret;
+}
+
+/*
+ * [SUMMARY] Run a function on all other CPUs.
+ * <func> The function to run. This must be fast and non-blocking.
+ * <info> An arbitrary pointer to pass to the function.
+ * <retry> unused
+ * <wait> If true, wait (atomically) until function has completed on other CPUs.
+ * [RETURNS] 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute <<func>> or are or have executed.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function(void (*func) (void *info), void *info, int retry, int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 void smp_call_function_interrupt(void)
