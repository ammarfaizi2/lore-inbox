Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbSLEHlC>; Thu, 5 Dec 2002 02:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSLEHlC>; Thu, 5 Dec 2002 02:41:02 -0500
Received: from holomorphy.com ([66.224.33.161]:53896 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267246AbSLEHlA>;
	Thu, 5 Dec 2002 02:41:00 -0500
Date: Wed, 04 Dec 2002 23:48:27 -0800
From: wli@holomorphy.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [pidhash] [3/4] eliminate proc_fill_super() tasklist iteration
Message-ID: <0212042348.Lc~dAa2dkcWdYdAaHamaUdNaHbxbwdzb15950@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212042348.YbGc0avcIbVdPbDdOcLb4dba4d.aQaVd15950@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a per-cpu counter for the number of processes on the system,
and use that to set ->i_nlink in proc_fill_super() in constant time.

 fs/proc/inode.c       |    6 +-----
 include/linux/sched.h |    3 +++
 kernel/exit.c         |    2 ++
 kernel/fork.c         |   14 ++++++++++++++
 4 files changed, 20 insertions(+), 5 deletions(-)


diff -urpN mm1-2.5.50-2/fs/proc/inode.c wli-2.5.50-3/fs/proc/inode.c
--- mm1-2.5.50-2/fs/proc/inode.c	2002-11-27 14:36:19.000000000 -0800
+++ wli-2.5.50-3/fs/proc/inode.c	2002-12-04 18:40:59.000000000 -0800
@@ -234,11 +234,7 @@ int proc_fill_super(struct super_block *
 	/*
 	 * Fixup the root inode's nlink value
 	 */
-	read_lock(&tasklist_lock);
-	for_each_process(p)
-		if (p->pid)
-			root_inode->i_nlink++;
-	read_unlock(&tasklist_lock);
+	root_inode->i_nlink += nr_processes();
 	s->s_root = d_alloc_root(root_inode);
 	if (!s->s_root)
 		goto out_no_root;
diff -urpN mm1-2.5.50-2/include/linux/sched.h wli-2.5.50-3/include/linux/sched.h
--- mm1-2.5.50-2/include/linux/sched.h	2002-12-04 12:49:47.000000000 -0800
+++ wli-2.5.50-3/include/linux/sched.h	2002-12-04 18:42:39.000000000 -0800
@@ -27,6 +27,7 @@
 #include <linux/compiler.h>
 #include <linux/completion.h>
 #include <linux/pid.h>
+#include <linux/percpu.h>
 
 struct exec_domain;
 
@@ -87,6 +88,8 @@ extern unsigned long avenrun[];		/* Load
 
 extern int nr_threads;
 extern int last_pid;
+DECLARE_PER_CPU(unsigned long, process_counts);
+extern int nr_processes(void);
 extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
 extern unsigned long nr_iowait(void);
diff -urpN mm1-2.5.50-2/kernel/exit.c wli-2.5.50-3/kernel/exit.c
--- mm1-2.5.50-2/kernel/exit.c	2002-12-04 12:49:47.000000000 -0800
+++ wli-2.5.50-3/kernel/exit.c	2002-12-04 18:57:08.000000000 -0800
@@ -41,6 +41,8 @@ static struct dentry * __unhash_process(
 	if (thread_group_leader(p)) {
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
+		if (p->pid)
+			per_cpu(process_counts, smp_processor_id())--;
 	}
 
 	REMOVE_LINKS(p);
diff -urpN mm1-2.5.50-2/kernel/fork.c wli-2.5.50-3/kernel/fork.c
--- mm1-2.5.50-2/kernel/fork.c	2002-12-04 12:49:47.000000000 -0800
+++ wli-2.5.50-3/kernel/fork.c	2002-12-04 18:56:55.000000000 -0800
@@ -48,6 +48,8 @@ int nr_threads;
 int max_threads;
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 
+DEFINE_PER_CPU(unsigned long, process_counts);
+
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
 /*
@@ -57,6 +59,16 @@ rwlock_t tasklist_lock __cacheline_align
  */
 static task_t *task_cache[NR_CPUS] __cacheline_aligned;
 
+int nr_processes(void)
+{
+	int cpu;
+	unsigned long total = 0;
+
+	for (cpu = 0; cpu < NR_CPUS; ++cpu)
+		total += per_cpu(process_counts, cpu);
+	return (int)total;
+}
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	if (tsk != current) {
@@ -934,6 +946,8 @@ static struct task_struct *copy_process(
 		attach_pid(p, PIDTYPE_TGID, p->tgid);
 		attach_pid(p, PIDTYPE_PGID, p->pgrp);
 		attach_pid(p, PIDTYPE_SID, p->session);
+		if (p->pid)
+			per_cpu(process_counts, smp_processor_id())++;
 	} else
 		link_pid(p, p->pids + PIDTYPE_TGID, &p->group_leader->pids[PIDTYPE_TGID].pid);
 
