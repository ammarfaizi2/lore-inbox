Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268332AbTBNJhg>; Fri, 14 Feb 2003 04:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268340AbTBNJ1y>; Fri, 14 Feb 2003 04:27:54 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:53843
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268333AbTBNJ0E>; Fri, 14 Feb 2003 04:26:04 -0500
Date: Fri, 14 Feb 2003 04:34:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@zwane.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Matthew Wilcox <willy@debian.org>
Subject: [PATCH][2.5][11/14] smp_call_function_on_cpu - PARISC
Message-ID: <Pine.LNX.4.50.0302140400540.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   63 ++++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 42 insertions(+), 21 deletions(-)

Index: linux-2.5.60/arch/parisc/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/parisc/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/parisc/kernel/smp.c	10 Feb 2003 22:15:32 -0000	1.1.1.1
+++ linux-2.5.60/arch/parisc/kernel/smp.c	14 Feb 2003 06:21:59 -0000
@@ -304,31 +304,40 @@
 void 
 smp_send_reschedule(int cpu) { send_IPI_single(cpu, IPI_RESCHEDULE); }
 
-
-/**
- * Run a function on all other CPUs.
- *  <func>	The function to run. This must be fast and non-blocking.
- *  <info>	An arbitrary pointer to pass to the function.
- *  <retry>	If true, keep retrying until ready.
- *  <wait>	If true, wait until function has completed on other CPUs.
- *  [RETURNS]   0 on success, else a negative status code.
+/*
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
- * Does not return until remote CPUs are nearly ready to execute <func>
- * or have executed.
  */
 
 int
-smp_call_function (void (*func) (void *info), void *info, int retry, int wait)
+smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+			  unsigned long mask)
 {
 	struct smp_call_struct data;
 	long timeout;
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	int num_cpus, cpu, i, ret;
 	
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight64(mask);
+	if (num_cpus == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
 	data.func = func;
 	data.info = info;
 	data.wait = wait;
-	atomic_set(&data.unstarted_count, smp_num_cpus - 1);
-	atomic_set(&data.unfinished_count, smp_num_cpus - 1);
+	atomic_set(&data.unstarted_count, num_cpus);
+	atomic_set(&data.unfinished_count, num_cpus);
 
 	if (retry) {
 		spin_lock (&lock);
@@ -339,15 +348,19 @@
 		spin_lock (&lock);
 		if (smp_call_function_data) {
 			spin_unlock (&lock);
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out;
 		}
 	}
 
 	smp_call_function_data = &data;
 	spin_unlock (&lock);
 	
-	/*  Send a message to all other CPUs and wait for them to respond  */
-	send_IPI_allbutself(IPI_CALL_FUNC);
+	/*  Send a message to the target CPUs and wait */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && (mask & (1UL << i)))
+			send_IPI_single(i, IPI_CALL_FUNC);
+	}
 
 	/*  Wait for response  */
 	timeout = jiffies + HZ;
@@ -361,17 +374,25 @@
 	smp_call_function_data = NULL;
 	if (atomic_read (&data.unstarted_count) > 0) {
 		printk(KERN_CRIT "SMP CALL FUNCTION TIMED OUT! (cpu=%d)\n",
-		      smp_processor_id());
-		return -ETIMEDOUT;
+		      cpu);
+		ret = -ETIMEDOUT;
+		goto out;
 	}
 
 	while (wait && atomic_read (&data.unfinished_count) > 0)
 			barrier ();
-
-	return 0;
+	ret = 0;
+out:
+	put_cpu_no_resched();
+	return ret;
 }
 
-
+int
+smp_call_function (void (*func) (void *info), void *info, int nonatomic, int wait,
+			  unsigned long mask)
+{
+	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
+}
 
 /*
  *	Setup routine for controlling SMP activation
