Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268375AbTBNMkW>; Fri, 14 Feb 2003 07:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268376AbTBNMkW>; Fri, 14 Feb 2003 07:40:22 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2905
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268375AbTBNMkK>; Fri, 14 Feb 2003 07:40:10 -0500
Date: Fri, 14 Feb 2003 07:48:34 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
In-Reply-To: <Pine.LNX.4.50.0302140405170.3518-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0302140747500.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140405170.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One liner to fix num_cpus == 0 on SMP kernel w/ UP box

Index: linux-2.5.60/arch/s390/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/s390/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/s390/kernel/smp.c	10 Feb 2003 22:15:54 -0000	1.1.1.1
+++ linux-2.5.60/arch/s390/kernel/smp.c	14 Feb 2003 12:23:17 -0000
@@ -102,27 +102,34 @@
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
+	int i, cpu, num_cpus;
 
-	/* FIXME: get cpu lock -hc */
-	if (cpus <= 0)
+	cpu = get_cpu();
+	mask &= (1UL << cpu);
+	num_cpus = hweight32(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
 		return 0;
+	}
 
 	data.func = func;
 	data.info = info;
@@ -134,18 +141,26 @@
 	spin_lock(&call_lock);
 	call_data = &data;
 	/* Send a message to all other CPUs and wait for them to respond */
-        smp_ext_bitcall_others(ec_call_function);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && ((1UL << cpu) && mask))
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
 	spin_unlock(&call_lock);
-
+	put_cpu_no_resched();
 	return 0;
+}
+
+int smp_call_function (void (*func) (void *info), void *info, int nonatomic, int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 static inline void do_send_stop(void)
