Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbTBIMIS>; Sun, 9 Feb 2003 07:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbTBIL7A>; Sun, 9 Feb 2003 06:59:00 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2128
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267238AbTBIL5x>; Sun, 9 Feb 2003 06:57:53 -0500
Date: Sun, 9 Feb 2003 07:06:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][7/15] smp_call_function/_on_cpu - parisc
Message-ID: <Pine.LNX.4.50.0302090647210.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/parisc/kernel/cache.c      |    2 
 arch/parisc/kernel/irq.c        |    6 +-
 arch/parisc/kernel/smp.c        |   91 +++++++++++++++++++++++++++++++++++-----
 arch/parisc/mm/init.c           |    2 
 include/asm-parisc/cacheflush.h |    7 ---
 5 files changed, 86 insertions(+), 22 deletions(-)

Index: linux-2.5.59-bk/include/asm-parisc/cacheflush.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/include/asm-parisc/cacheflush.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cacheflush.h
--- linux-2.5.59-bk/include/asm-parisc/cacheflush.h	9 Feb 2003 09:09:24 -0000	1.1.1.1
+++ linux-2.5.59-bk/include/asm-parisc/cacheflush.h	9 Feb 2003 09:23:30 -0000
@@ -25,16 +25,11 @@
 
 extern void flush_cache_all_local(void);
 
-#ifdef CONFIG_SMP
 static inline void flush_cache_all(void)
 {
-	smp_call_function((void (*)(void *))flush_cache_all_local, NULL, 1, 1);
+	smp_call_function((void (*)(void *))flush_cache_all_local, NULL, 1);
 	flush_cache_all_local();
 }
-#else
-#define flush_cache_all flush_cache_all_local
-#endif
-
 
 /* The following value needs to be tuned and probably scaled with the
  * cache size.
Index: linux-2.5.59-bk/arch/parisc/kernel/cache.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/parisc/kernel/cache.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cache.c
--- linux-2.5.59-bk/arch/parisc/kernel/cache.c	9 Feb 2003 09:08:30 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/parisc/kernel/cache.c	9 Feb 2003 09:23:30 -0000
@@ -39,7 +39,7 @@
 void
 flush_data_cache(void)
 {
-	smp_call_function((void (*)(void *))flush_data_cache_local, NULL, 1, 1);
+	smp_call_function((void (*)(void *))flush_data_cache_local, NULL, 1);
 	flush_data_cache_local();
 }
 #endif
Index: linux-2.5.59-bk/arch/parisc/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/parisc/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.59-bk/arch/parisc/kernel/irq.c	9 Feb 2003 09:08:30 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/parisc/kernel/irq.c	9 Feb 2003 09:23:30 -0000
@@ -74,7 +74,7 @@
 
 	cpu_eiem &= ~eirr_bit;
 	set_eiem(cpu_eiem);
-        smp_call_function(cpu_set_eiem, (void *) cpu_eiem, 1, 1);
+        smp_call_function(cpu_set_eiem, (void *) cpu_eiem, 1);
 }
 
 static void enable_cpu_irq(void *unused, int irq)
@@ -83,7 +83,7 @@
 
 	mtctl(eirr_bit, 23);	/* clear EIRR bit before unmasking */
 	cpu_eiem |= eirr_bit;
-        smp_call_function(cpu_set_eiem, (void *) cpu_eiem, 1, 1);
+        smp_call_function(cpu_set_eiem, (void *) cpu_eiem, 1);
 	set_eiem(cpu_eiem);
 }
 
@@ -100,7 +100,7 @@
 	** handle *any* unmasked pending interrupts.
 	** ie We don't need to check for pending interrupts here.
 	*/
-        smp_call_function(cpu_set_eiem, (void *) cpu_eiem, 1, 1);
+        smp_call_function(cpu_set_eiem, (void *) cpu_eiem, 1);
 	set_eiem(cpu_eiem);
 }
 
Index: linux-2.5.59-bk/arch/parisc/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/parisc/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/parisc/kernel/smp.c	9 Feb 2003 09:08:30 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/parisc/kernel/smp.c	9 Feb 2003 09:23:30 -0000
@@ -309,7 +309,6 @@
  * Run a function on all other CPUs.
  *  <func>	The function to run. This must be fast and non-blocking.
  *  <info>	An arbitrary pointer to pass to the function.
- *  <retry>	If true, keep retrying until ready.
  *  <wait>	If true, wait until function has completed on other CPUs.
  *  [RETURNS]   0 on success, else a negative status code.
  *
@@ -318,8 +317,9 @@
  */
 
 int
-smp_call_function (void (*func) (void *info), void *info, int retry, int wait)
+smp_call_function (void (*func) (void *info), void *info, int wait)
 {
+	int this_cpu;
 	struct smp_call_struct data;
 	long timeout;
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
@@ -330,6 +330,70 @@
 	atomic_set(&data.unstarted_count, smp_num_cpus - 1);
 	atomic_set(&data.unfinished_count, smp_num_cpus - 1);
 
+	this_cpu = get_cpu();
+	spin_lock(&lock);
+	smp_call_function_data = &data;
+	
+	/*  Send a message to all other CPUs and wait for them to respond  */
+	send_IPI_allbutself(IPI_CALL_FUNC);
+
+	/*  Wait for response  */
+	timeout = jiffies + HZ;
+	while ( (atomic_read (&data.unstarted_count) > 0) &&
+		time_before (jiffies, timeout) )
+		barrier ();
+
+	/* We either got one or timed out. Release the lock */
+
+	mb();
+	smp_call_function_data = NULL;
+	spin_unlock(&lock);
+	if (atomic_read (&data.unstarted_count) > 0) {
+		printk(KERN_CRIT "SMP CALL FUNCTION TIMED OUT! (cpu=%d)\n", this_cpu);
+		put_cpu_no_reched();
+		return -ETIMEDOUT;
+	}
+
+	while (wait && atomic_read (&data.unfinished_count) > 0)
+			barrier ();
+	put_cpu_no_resched();
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
+ */
+
+int
+smp_call_function_on_cpu (void (*func) (void *info), void *info, int wait,
+			  unsigned long mask)
+{
+	struct smp_call_struct data;
+	long timeout;
+	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	int num_cpus = hweight64(mask), cpu, i, ret;
+	
+	cpu = get_cpu();
+	if (((1UL << cpu) & mask) || num_cpus == 0) {
+		ret = -EINVAL
+		goto out;
+	}
+
+	data.func = func;
+	data.info = info;
+	data.wait = wait;
+	atomic_set(&data.unstarted_count, num_cpus);
+	atomic_set(&data.unfinished_count, num_cpus);
+
 	if (retry) {
 		spin_lock (&lock);
 		while (smp_call_function_data != 0)
@@ -339,15 +403,19 @@
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
@@ -361,17 +429,18 @@
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
-
 
 /*
  *	Setup routine for controlling SMP activation
Index: linux-2.5.59-bk/arch/parisc/mm/init.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/parisc/mm/init.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 init.c
--- linux-2.5.59-bk/arch/parisc/mm/init.c	9 Feb 2003 09:08:30 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/parisc/mm/init.c	9 Feb 2003 09:23:30 -0000
@@ -974,7 +974,7 @@
 	    do_recycle++;
 	}
 	spin_unlock(&sid_lock);
-	smp_call_function((void (*)(void *))flush_tlb_all_local, NULL, 1, 1);
+	smp_call_function((void (*)(void *))flush_tlb_all_local, NULL, 1);
 	flush_tlb_all_local();
 	if (do_recycle) {
 	    spin_lock(&sid_lock);
