Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbTFFGBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 02:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbTFFGBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 02:01:07 -0400
Received: from dp.samba.org ([66.70.73.150]:35281 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265339AbTFFGBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 02:01:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au, Zwane Mwaikambo <zwane@linuxpower.ca>,
       fleming@austin.ibm.com
Subject: [PATCH] Move cpu notifiers et al to cpu.h
Date: Fri, 06 Jun 2003 15:15:11 +1000
Message-Id: <20030606061436.761DB2C0A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch: when these were introduced cpu.h didn't exist.

Name: Move cpu_up prototype to linux/cpu.h
Author: Rusty Russell
Status: Trivial

D: Now we have linux/cpu.h, the prototypes for registration and
D: cpu_up() belong there.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/fs/buffer.c .14606-linux-2.5.70-bk10.updated/fs/buffer.c
--- .14606-linux-2.5.70-bk10/fs/buffer.c	2003-06-06 09:56:52.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/fs/buffer.c	2003-06-06 15:00:39.000000000 +1000
@@ -36,6 +36,7 @@
 #include <linux/buffer_head.h>
 #include <linux/bio.h>
 #include <linux/notifier.h>
+#include <linux/cpu.h>
 #include <asm/bitops.h>
 
 static void invalidate_bh_lrus(void);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/include/linux/cpu.h .14606-linux-2.5.70-bk10.updated/include/linux/cpu.h
--- .14606-linux-2.5.70-bk10/include/linux/cpu.h	2003-05-27 15:02:21.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/include/linux/cpu.h	2003-06-06 14:52:38.000000000 +1000
@@ -31,6 +31,24 @@ struct cpu {
 extern int register_cpu(struct cpu *, int, struct node *);
 extern struct class cpu_class;
 
+struct notifier_block;
+
+#ifdef CONFIG_SMP
+/* Need to know about CPUs going up/down? */
+extern int register_cpu_notifier(struct notifier_block *nb);
+extern void unregister_cpu_notifier(struct notifier_block *nb);
+
+int cpu_up(unsigned int cpu);
+#else
+static inline int register_cpu_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline void unregister_cpu_notifier(struct notifier_block *nb)
+{
+}
+#endif /* CONFIG_SMP */
+
 /* Stop CPUs going up and down. */
 extern struct semaphore cpucontrol;
 #endif /* _LINUX_CPU_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/include/linux/smp.h .14606-linux-2.5.70-bk10.updated/include/linux/smp.h
--- .14606-linux-2.5.70-bk10/include/linux/smp.h	2003-06-06 09:56:57.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/include/linux/smp.h	2003-06-06 14:52:00.000000000 +1000
@@ -84,14 +84,6 @@ extern int smp_threads_ready;
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
-struct notifier_block;
-
-/* Need to know about CPUs going up/down? */
-extern int register_cpu_notifier(struct notifier_block *nb);
-extern void unregister_cpu_notifier(struct notifier_block *nb);
-
-int cpu_up(unsigned int cpu);
-
 /*
  * Mark the boot cpu "online" so that it can call console drivers in
  * printk() and can access its per-cpu storage.
@@ -117,16 +109,6 @@ static inline void smp_send_reschedule(i
 #define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define smp_prepare_boot_cpu()			do {} while (0)
 
-struct notifier_block;
-
-/* Need to know about CPUs going up/down? */
-static inline int register_cpu_notifier(struct notifier_block *nb)
-{
-	return 0;
-}
-static inline void unregister_cpu_notifier(struct notifier_block *nb)
-{
-}
 #endif /* !SMP */
 
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/init/main.c .14606-linux-2.5.70-bk10.updated/init/main.c
--- .14606-linux-2.5.70-bk10/init/main.c	2003-05-27 15:02:23.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/init/main.c	2003-06-06 14:39:52.000000000 +1000
@@ -37,6 +37,7 @@
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
 #include <linux/writeback.h>
+#include <linux/cpu.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/kernel/cpu.c .14606-linux-2.5.70-bk10.updated/kernel/cpu.c
--- .14606-linux-2.5.70-bk10/kernel/cpu.c	2003-01-02 12:32:49.000000000 +1100
+++ .14606-linux-2.5.70-bk10.updated/kernel/cpu.c	2003-06-06 14:53:12.000000000 +1000
@@ -8,6 +8,7 @@
 #include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/cpu.h>
 #include <asm/semaphore.h>
 
 /* This protects CPUs going up and down... */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/kernel/rcupdate.c .14606-linux-2.5.70-bk10.updated/kernel/rcupdate.c
--- .14606-linux-2.5.70-bk10/kernel/rcupdate.c	2003-05-27 15:02:23.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/kernel/rcupdate.c	2003-06-06 14:53:23.000000000 +1000
@@ -43,6 +43,7 @@
 #include <linux/percpu.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
+#include <linux/cpu.h>
 
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/kernel/sched.c .14606-linux-2.5.70-bk10.updated/kernel/sched.c
--- .14606-linux-2.5.70-bk10/kernel/sched.c	2003-06-06 09:56:58.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/kernel/sched.c	2003-06-06 14:52:50.000000000 +1000
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
+#include <linux/cpu.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/kernel/softirq.c .14606-linux-2.5.70-bk10.updated/kernel/softirq.c
--- .14606-linux-2.5.70-bk10/kernel/softirq.c	2003-04-20 18:05:16.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/kernel/softirq.c	2003-06-06 14:53:03.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/cpu.h>
 
 /*
    - No shared variables, all the data are CPU local.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/kernel/timer.c .14606-linux-2.5.70-bk10.updated/kernel/timer.c
--- .14606-linux-2.5.70-bk10/kernel/timer.c	2003-06-06 09:56:58.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/kernel/timer.c	2003-06-06 14:52:57.000000000 +1000
@@ -29,6 +29,7 @@
 #include <linux/thread_info.h>
 #include <linux/time.h>
 #include <linux/jiffies.h>
+#include <linux/cpu.h>
 
 #include <asm/uaccess.h>
 #include <asm/div64.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/mm/page-writeback.c .14606-linux-2.5.70-bk10.updated/mm/page-writeback.c
--- .14606-linux-2.5.70-bk10/mm/page-writeback.c	2003-06-06 09:56:58.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/mm/page-writeback.c	2003-06-06 14:53:29.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/notifier.h>
 #include <linux/smp.h>
 #include <linux/sysctl.h>
+#include <linux/cpu.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/mm/page_alloc.c .14606-linux-2.5.70-bk10.updated/mm/page_alloc.c
--- .14606-linux-2.5.70-bk10/mm/page_alloc.c	2003-05-27 15:02:24.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/mm/page_alloc.c	2003-06-06 14:54:05.000000000 +1000
@@ -28,6 +28,7 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/notifier.h>
+#include <linux/cpu.h>
 
 #include <asm/topology.h>
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14606-linux-2.5.70-bk10/mm/slab.c .14606-linux-2.5.70-bk10.updated/mm/slab.c
--- .14606-linux-2.5.70-bk10/mm/slab.c	2003-06-06 09:56:58.000000000 +1000
+++ .14606-linux-2.5.70-bk10.updated/mm/slab.c	2003-06-06 14:53:41.000000000 +1000
@@ -84,6 +84,7 @@
 #include	<linux/seq_file.h>
 #include	<linux/notifier.h>
 #include	<linux/kallsyms.h>
+#include	<linux/cpu.h>
 #include	<asm/uaccess.h>
 
 /*

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
