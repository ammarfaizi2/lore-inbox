Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270608AbTGaWq2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270609AbTGaWq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:46:28 -0400
Received: from mail.ccur.com ([208.248.32.212]:21264 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S270608AbTGaWqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:46:14 -0400
Date: Thu, 31 Jul 2003 18:46:05 -0400
From: Joe Korty <joe.korty@ccur.com>
To: torvalds@osdl.org, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] protect migration/%d etc from sched_setaffinity
Message-ID: <20030731224604.GA24887@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lock out users from changing the cpu affinity of those per-cpu system
daemons which cannot survive such a change, such as migration/%d.

Passes basic handtest of sched_setaffinity(2) on various locked and
unlocked processes on a i386, otherwise untested except by eyeball.

Except for one line in i386, no arch needed any changes to support
this patch.

Joe


 arch/i386/kernel/apm.c |    1 +
 include/linux/sched.h  |    1 +
 kernel/fork.c          |    2 +-
 kernel/module.c        |    2 ++
 kernel/sched.c         |    4 ++++
 kernel/softirq.c       |    4 ++--
 kernel/workqueue.c     |    1 +
 mm/vmscan.c            |    5 ++++-
 8 files changed, 16 insertions(+), 4 deletions(-)


diff -Nura linux-2.6.0-test2/arch/i386/kernel/apm.c.orig linux-2.6.0-test2/arch/i386/kernel/apm.c
--- linux-2.6.0-test2/arch/i386/kernel/apm.c.orig	2003-07-31 10:36:23.000000000 -0400
+++ linux-2.6.0-test2/arch/i386/kernel/apm.c	2003-07-31 15:52:25.000000000 -0400
@@ -1705,6 +1705,7 @@
 	 * Method suggested by Ingo Molnar.
 	 */
 	set_cpus_allowed(current, 1UL << 0);
+	current->flags |= PF_CPULOCK;
 	BUG_ON(smp_processor_id() != 0);
 #endif
 
diff -Nura linux-2.6.0-test2/include/linux/sched.h.orig linux-2.6.0-test2/include/linux/sched.h
--- linux-2.6.0-test2/include/linux/sched.h.orig	2003-07-27 12:57:39.000000000 -0400
+++ linux-2.6.0-test2/include/linux/sched.h	2003-07-31 15:52:25.000000000 -0400
@@ -488,6 +488,7 @@
 #define PF_LESS_THROTTLE 0x01000000	/* Throttle me less: I clena memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_READAHEAD	0x00400000	/* I am doing read-ahead */
+#define PF_CPULOCK	0x00800000	/* lock users out from changing cpus_allowed */
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, unsigned long new_mask);
diff -Nura linux-2.6.0-test2/kernel/sched.c.orig linux-2.6.0-test2/kernel/sched.c
--- linux-2.6.0-test2/kernel/sched.c.orig	2003-07-27 13:07:14.000000000 -0400
+++ linux-2.6.0-test2/kernel/sched.c	2003-07-31 18:16:20.000000000 -0400
@@ -1930,6 +1930,9 @@
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
 			!capable(CAP_SYS_NICE))
 		goto out_unlock;
+	if (p->flags & PF_CPULOCK) {
+		goto out_unlock;
+	}
 
 	retval = set_cpus_allowed(p, new_mask);
 
@@ -2380,6 +2383,7 @@
 	 * serially).
 	 */
 	set_cpus_allowed(current, 1UL << cpu);
+	current->flags |= PF_CPULOCK;
 
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
diff -Nura linux-2.6.0-test2/kernel/softirq.c.orig linux-2.6.0-test2/kernel/softirq.c
--- linux-2.6.0-test2/kernel/softirq.c.orig	2003-07-27 12:58:53.000000000 -0400
+++ linux-2.6.0-test2/kernel/softirq.c	2003-07-31 15:52:25.000000000 -0400
@@ -323,8 +323,8 @@
 
 	/* Migrate to the right CPU */
 	set_cpus_allowed(current, 1UL << cpu);
-	if (smp_processor_id() != cpu)
-		BUG();
+	current->flags |= PF_CPULOCK;
+	BUG_ON(smp_processor_id() != cpu);
 
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
diff -Nura linux-2.6.0-test2/kernel/module.c.orig linux-2.6.0-test2/kernel/module.c
--- linux-2.6.0-test2/kernel/module.c.orig	2003-07-27 13:06:11.000000000 -0400
+++ linux-2.6.0-test2/kernel/module.c	2003-07-31 15:52:25.000000000 -0400
@@ -483,6 +483,7 @@
 	setscheduler(current->pid, SCHED_FIFO, &param);
 #endif
 	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
+	current->flags |= PF_CPULOCK;
 
 	/* Ack: we are alive */
 	atomic_inc(&stopref_thread_ack);
@@ -544,6 +545,7 @@
 	/* FIXME: racy with set_cpus_allowed. */
 	old_allowed = current->cpus_allowed;
 	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
+	current->flags |= PF_CPULOCK;
 
 	atomic_set(&stopref_thread_ack, 0);
 	stopref_num_threads = 0;
diff -Nura linux-2.6.0-test2/kernel/fork.c.orig linux-2.6.0-test2/kernel/fork.c
--- linux-2.6.0-test2/kernel/fork.c.orig	2003-07-27 12:57:39.000000000 -0400
+++ linux-2.6.0-test2/kernel/fork.c	2003-07-31 15:52:25.000000000 -0400
@@ -705,7 +705,7 @@
 {
 	unsigned long new_flags = p->flags;
 
-	new_flags &= ~PF_SUPERPRIV;
+	new_flags &= ~(PF_SUPERPRIV | PF_CPULOCK);
 	new_flags |= PF_FORKNOEXEC;
 	if (!(clone_flags & CLONE_PTRACE))
 		p->ptrace = 0;
diff -Nura linux-2.6.0-test2/kernel/workqueue.c.orig linux-2.6.0-test2/kernel/workqueue.c
--- linux-2.6.0-test2/kernel/workqueue.c.orig	2003-07-27 13:11:08.000000000 -0400
+++ linux-2.6.0-test2/kernel/workqueue.c	2003-07-31 15:52:25.000000000 -0400
@@ -177,6 +177,7 @@
 
 	set_user_nice(current, -10);
 	set_cpus_allowed(current, 1UL << cpu);
+	current->flags |= PF_CPULOCK;
 
 	complete(&startup->done);
 
diff -Nura linux-2.6.0-test2/mm/vmscan.c.orig linux-2.6.0-test2/mm/vmscan.c
--- linux-2.6.0-test2/mm/vmscan.c.orig	2003-07-27 12:57:44.000000000 -0400
+++ linux-2.6.0-test2/mm/vmscan.c	2003-07-31 15:52:25.000000000 -0400
@@ -960,8 +960,11 @@
 
 	daemonize("kswapd%d", pgdat->node_id);
 	cpumask = node_to_cpumask(pgdat->node_id);
-	if (cpumask)
+	if (cpumask) {
 		set_cpus_allowed(tsk, cpumask);
+		/* FIXME: a node version of PF_CPULOCK would be cool */
+		current->flags |= PF_CPULOCK;
+	}
 	current->reclaim_state = &reclaim_state;
 
 	/*

