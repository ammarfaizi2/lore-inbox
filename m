Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWHXKb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWHXKb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWHXKb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:31:29 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:54196 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751053AbWHXKb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:31:28 -0400
Date: Thu, 24 Aug 2006 16:02:33 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, arjan@intel.linux.com, davej@redhat.com,
       mingo@elte.hu, vatsa@in.ibm.com, dipankar@in.ibm.com,
       ashok.raj@intel.com
Subject: [RFC][PATCH 3/4] (Refcount + Waitqueue) implementation for cpu_hotplug "locking"
Message-ID: <20060824103233.GD2395@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"

--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3of4.patch"

This patch provides the (Refcount + Workqueue) implementation for
cpu_hotplug "locking". It is analogous to a unfair rwsem.

Signed-off-by : Gautham R Shenoy <ego@in.ibm.com>

Index: current/kernel/cpu.c
===================================================================
--- current.orig/kernel/cpu.c	2006-08-06 23:50:11.000000000 +0530
+++ current/kernel/cpu.c	2006-08-24 15:00:04.000000000 +0530
@@ -14,50 +14,172 @@
 #include <linux/kthread.h>
 #include <linux/stop_machine.h>
 #include <linux/mutex.h>
-
-/* This protects CPUs going up and down... */
-static DEFINE_MUTEX(cpu_add_remove_lock);
-static DEFINE_MUTEX(cpu_bitmask_lock);
+#include <asm/percpu.h>
+#include <linux/cpumask.h>
+#include <linux/types.h>
+#include <linux/wait.h>
 
 static __cpuinitdata BLOCKING_NOTIFIER_HEAD(cpu_chain);
 
+/************************************************************************
+ *			A FEW CONTEXT SPECIFIC DEFINITIONS		*
+ * ---------------------------------------------------------------------*
+ * - reader : task which tries to *prevent* a cpu hotplug event.	*
+ *									*
+ * - writer : task which tries to *perform* a cpu hotplug event		*
+ *									*
+ * - write-operation: cpu hotplug operation.				*
+ *									*
+ ************************************************************************/
+
+ /***********************************************************************
+ *			THE PROTOCOL					*
+ *----------------------------------------------------------------------*
+ *- Analogous to RWSEM, only not so fair.				*
+ *									*
+ *- Readers assume control iff:						*
+ *	a) No other reader has a reference and no writer is writing.	*
+ *	OR								*
+ *	b) Atleast one reader has a reference.				*
+ *									*
+ *- In any other case, the reader is blocked.				*
+ *									*
+ *- Writer gets to perform a write iff:					*
+ *	*No* reader has a reference and no writer is writing.		*
+ *									*
+ *- In any other case, the writer is blocked.				*
+ *									*
+ *- Writer, on completion would preferable wake up other waiting	*
+ *  writers over the waiting readers.					*
+ *									*
+ *- The *last* writer wakes up all the waiting readers.			*
+ *									*
+ ************************************************************************/
+
+/************************************************************************
+				USEFUL FLAGS
+*************************************************************************/
+/* System has no writers 	*/
+#define NO_WRITERS		0
+
+/* Some writer is waiting */
+#define WRITER_WAITING		1
+
+/* A Writer is performing cpu hotplug*/
+#define CPU_HOTPLUG_ONGOING	2
+
+/*************************************************************************
+		 ( REFCOUNT + WAITQUEUE ) VARIABLES
+**************************************************************************/
+
+static struct {
+	int reader_count; /* Refcount for the Readers*/
+	int status; /* Status of hotplug operation(none,waiting,ongoing) */
+	spinlock_t lock; /* Serializes access to this struct */
+} cpu_hotplug __cacheline_aligned_in_smp =
+		{0, NO_WRITERS, SPIN_LOCK_UNLOCKED};
+
+/* Waitqueues for readers and writers */
+static __cacheline_aligned_in_smp DECLARE_WAIT_QUEUE_HEAD(read_queue);
+static __cacheline_aligned_in_smp DECLARE_WAIT_QUEUE_HEAD(write_queue);
+
+/********************************************************************
+	MAIN CPU_HOTPLUG (ENABLE/ DISABLE/ BEGIN/ DONE) CODE
+*********************************************************************/
 #ifdef CONFIG_HOTPLUG_CPU
 
-/* Crappy recursive lock-takers in cpufreq! Complain loudly about idiots */
-static struct task_struct *recursive;
-static int recursive_depth;
-
+/** lock_cpu_hotplug : Blocks iff
+	- Hotplug operation is underway.
+*/
 void lock_cpu_hotplug(void)
 {
-	struct task_struct *tsk = current;
-
-	if (tsk == recursive) {
-		static int warnings = 10;
-		if (warnings) {
-			printk(KERN_ERR "Lukewarm IQ detected in hotplug locking\n");
-			WARN_ON(1);
-			warnings--;
-		}
-		recursive_depth++;
+	DECLARE_WAITQUEUE(wait, current);
+	spin_lock(&cpu_hotplug.lock);
+	cpu_hotplug.reader_count++;
+	if (cpu_hotplug.status != CPU_HOTPLUG_ONGOING) {
+		spin_unlock(&cpu_hotplug.lock);
 		return;
 	}
-	mutex_lock(&cpu_bitmask_lock);
-	recursive = tsk;
+	add_wait_queue_exclusive(&read_queue, &wait);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	spin_unlock(&cpu_hotplug.lock);
+	schedule();
+	remove_wait_queue(&read_queue, &wait);
 }
 EXPORT_SYMBOL_GPL(lock_cpu_hotplug);
 
+/** unlock_cpu_hotplug:
+	- Decrements the reader_count.
+	- If no readers are holding reference AND there is a writer
+	waiting, we set the flag to HOTPLUG_ONGOING and wake up
+	one of the waiting writer.
+*/
 void unlock_cpu_hotplug(void)
 {
-	WARN_ON(recursive != current);
-	if (recursive_depth) {
-		recursive_depth--;
-		return;
+	spin_lock(&cpu_hotplug.lock);
+	/* This should not happen, but in case it does... */
+	WARN_ON(!cpu_hotplug.reader_count);
+
+	cpu_hotplug.reader_count--;
+	if (!(cpu_hotplug.reader_count) && \
+			(cpu_hotplug.status == WRITER_WAITING)) {
+		cpu_hotplug.status = CPU_HOTPLUG_ONGOING;
+		wake_up(&write_queue);
 	}
-	mutex_unlock(&cpu_bitmask_lock);
-	recursive = NULL;
+	spin_unlock(&cpu_hotplug.lock);
 }
 EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);
 
+/** cpu_hotplug_begin : Blocks unless
+	No reader has the reference
+	AND
+	Hotplug operation is not ongoing.
+*/
+static void cpu_hotplug_begin(int interruptible)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	spin_lock(&cpu_hotplug.lock);
+	if (!cpu_hotplug.reader_count && \
+			(cpu_hotplug.status != CPU_HOTPLUG_ONGOING)) {
+		cpu_hotplug.status = CPU_HOTPLUG_ONGOING;
+		spin_unlock(&cpu_hotplug.lock);
+		return;
+	}
+	if (cpu_hotplug.status != CPU_HOTPLUG_ONGOING)
+		cpu_hotplug.status = WRITER_WAITING;
+	add_wait_queue_exclusive(&write_queue, &wait);
+	if (interruptible)
+		set_current_state(TASK_INTERRUPTIBLE);
+	else
+		set_current_state(TASK_UNINTERRUPTIBLE);
+	spin_unlock(&cpu_hotplug.lock);
+	schedule();
+	remove_wait_queue(&write_queue, &wait);
+}
+
+/** cpu_hotplug_done : Performs either one of the following:
+	- Wake up the next writer,if any.
+	- reset flag to zero
+	 and wake up all the waiting readers, if any.
+*/
+void cpu_hotplug_done(void)
+{
+	spin_lock(&cpu_hotplug.lock);
+
+	if (!list_empty(&write_queue.task_list))
+		/* Another cpu writer! */
+		wake_up(&write_queue);
+	else {
+		/* This is the last writer. Remove the flag */
+		cpu_hotplug.status = NO_WRITERS;
+
+		if (cpu_hotplug.reader_count)
+			wake_up_all(&read_queue); /* All rise! */
+	}
+
+	spin_unlock(&cpu_hotplug.lock);
+}
+
 #endif	/* CONFIG_HOTPLUG_CPU */
 
 /* Need to know about CPUs going up/down? */
@@ -114,7 +236,7 @@ int cpu_down(unsigned int cpu)
 	struct task_struct *p;
 	cpumask_t old_allowed, tmp;
 
-	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_begin(1);
 	if (num_online_cpus() == 1) {
 		err = -EBUSY;
 		goto out;
@@ -140,9 +262,7 @@ int cpu_down(unsigned int cpu)
 	cpu_clear(cpu, tmp);
 	set_cpus_allowed(current, tmp);
 
-	mutex_lock(&cpu_bitmask_lock);
 	p = __stop_machine_run(take_cpu_down, NULL, cpu);
-	mutex_unlock(&cpu_bitmask_lock);
 
 	if (IS_ERR(p)) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
@@ -180,7 +300,7 @@ out_thread:
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
 out:
-	mutex_unlock(&cpu_add_remove_lock);
+	cpu_hotplug_done();
 	return err;
 }
 #endif /*CONFIG_HOTPLUG_CPU*/
@@ -190,7 +310,7 @@ int __devinit cpu_up(unsigned int cpu)
 	int ret;
 	void *hcpu = (void *)(long)cpu;
 
-	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_begin(1);
 	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;
@@ -205,21 +325,18 @@ int __devinit cpu_up(unsigned int cpu)
 	}
 
 	/* Arch-specific enabling code. */
-	mutex_lock(&cpu_bitmask_lock);
 	ret = __cpu_up(cpu);
-	mutex_unlock(&cpu_bitmask_lock);
 	if (ret != 0)
 		goto out_notify;
 	BUG_ON(!cpu_online(cpu));
 
 	/* Now call notifier in preparation. */
 	blocking_notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
-
 out_notify:
 	if (ret != 0)
 		blocking_notifier_call_chain(&cpu_chain,
 				CPU_UP_CANCELED, hcpu);
 out:
-	mutex_unlock(&cpu_add_remove_lock);
+	cpu_hotplug_done();
 	return ret;
 }

--LwW0XdcUbUexiWVK--
