Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268391AbTBNMoW>; Fri, 14 Feb 2003 07:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268386AbTBNMoK>; Fri, 14 Feb 2003 07:44:10 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:12377
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268391AbTBNMno>; Fri, 14 Feb 2003 07:43:44 -0500
Date: Fri, 14 Feb 2003 07:52:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH][2.5][14/14] smp_call_function_on_cpu - x86_64
In-Reply-To: <Pine.LNX.4.50.0302140412190.3518-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0302140751530.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140412190.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One liner to fix num_cpus == 0 on SMP kernel w/ UP box

Index: linux-2.5.60/arch/x86_64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/x86_64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/x86_64/kernel/smp.c	10 Feb 2003 22:15:09 -0000	1.1.1.1
+++ linux-2.5.60/arch/x86_64/kernel/smp.c	14 Feb 2003 12:17:24 -0000
@@ -385,26 +385,35 @@
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
+
 
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
@@ -416,19 +425,26 @@
 	spin_lock(&call_lock);
 	call_data = &data;
 	wmb();
+
 	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 
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
+int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
+			int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 static void stop_this_cpu (void * dummy)
