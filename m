Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268334AbTBNJ30>; Fri, 14 Feb 2003 04:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268211AbTBNJ2N>; Fri, 14 Feb 2003 04:28:13 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2900
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268334AbTBNJ05>; Fri, 14 Feb 2003 04:26:57 -0500
Date: Fri, 14 Feb 2003 04:35:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@zwane.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, "" <linux-mips@linux-mips.org>
Subject: [PATCH][2.5][5/14] smp_call_function_on_cpu - MIPS64
Message-ID: <Pine.LNX.4.50.0302140358120.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   51 ++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 40 insertions(+), 11 deletions(-)

Index: linux-2.5.60/arch/mips64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/mips64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/mips64/kernel/smp.c	10 Feb 2003 22:15:44 -0000	1.1.1.1
+++ linux-2.5.60/arch/mips64/kernel/smp.c	14 Feb 2003 06:11:21 -0000
@@ -131,16 +131,35 @@
 	int wait;
 } *call_data;
 
-int smp_call_function (void (*func) (void *info), void *info, int retry, 
-								int wait)
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
+int smp_call_function_on_cpu (void (*func) (void *info), void *info,
+				int wait, unsigned long mask)
 {
 	struct call_data_struct data;
-	int i, cpus = smp_num_cpus-1;
+	int i, cpu, num_cpus;
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
 
-	if (cpus == 0)
-		return 0;
-
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight64(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();	
+		return -EINVAL;
+	}
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
@@ -151,20 +170,30 @@
 	spin_lock_bh(&lock);
 	call_data = &data;
 	/* Send a message to all other CPUs and wait for them to respond */
-	for (i = 0; i < smp_num_cpus; i++)
-		if (smp_processor_id() != i)
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+
+		if ((1UL << i) & mask)
 			sendintr(i, DOCALL);
+	}
 
 	/* Wait for response */
-	/* FIXME: lock-up detection, backtrace on lock-up */
-	while (atomic_read(&data.started) != cpus)
+	while (atomic_read(&data.started) != num_cpus)
 		barrier();
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
+		while (atomic_read(&data.finished) != num_cpus)
 			barrier();
 	spin_unlock_bh(&lock);
+	put_cpu_no_resched();
 	return 0;
+}
+
+int smp_call_function (void (*func) (void *info), void *info, int retry, 
+								int wait)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
 }
 
 extern void smp_call_function_interrupt(int irq, void *d, struct pt_regs *r)
