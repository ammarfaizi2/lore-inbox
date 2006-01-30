Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWA3Jsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWA3Jsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWA3Jsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:48:37 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:43681 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932178AbWA3Jsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:48:36 -0500
Message-ID: <43DDF2FD.DA646A68@tv-sign.ru>
Date: Mon, 30 Jan 2006 14:05:33 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3] pidhash: don't count idle threads
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fork_idle() does unhash_process() just after copy_process().
Contrary, boot_cpu's idle thread explicitely registers itself
for each pid_type with nr = 0.

copy_process() already checks p->pid != 0 before process_counts++,
I think we can just skip attach_pid() calls and job control inits
for idle threads and kill unhash_process().

Note: it is still possible to have PIDTYPE_PGID/PIDTYPE_SID entries
with nr == 0 (forked from init thread, including kernel threads
spawned from init/main.c:init()), this is ok because we never call
free_pidmap() with pid == 0 arg, so it will never be reused.

Question: why does unhash_process() call proc_pid_unhash()? Is not it
a bug to have ->proc_dentry != NULL after fork_idle()->copy_process()?

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/pid.c~NOIPID	2006-01-19 18:13:07.000000000 +0300
+++ RC-1/kernel/pid.c	2006-01-30 14:21:15.000000000 +0300
@@ -277,16 +277,8 @@ void __init pidhash_init(void)
 
 void __init pidmap_init(void)
 {
-	int i;
-
 	pidmap_array->page = (void *)get_zeroed_page(GFP_KERNEL);
+	/* Reserve PID 0 */
 	set_bit(0, pidmap_array->page);
 	atomic_dec(&pidmap_array->nr_free);
-
-	/*
-	 * Allocate PID 0, and hash it via all PID types:
-	 */
-
-	for (i = 0; i < PIDTYPE_MAX; i++)
-		attach_pid(current, i, 0);
 }
--- RC-1/kernel/fork.c~NOIPID	2006-01-19 18:13:07.000000000 +0300
+++ RC-1/kernel/fork.c	2006-01-30 14:17:58.000000000 +0300
@@ -1135,19 +1135,20 @@ static task_t *copy_process(unsigned lon
 	if (unlikely(p->ptrace & PT_PTRACED))
 		__ptrace_link(p, current->parent);
 
-	attach_pid(p, PIDTYPE_PID, p->pid);
-	attach_pid(p, PIDTYPE_TGID, p->tgid);
-	if (thread_group_leader(p)) {
-		p->signal->tty = current->signal->tty;
-		p->signal->pgrp = process_group(current);
-		p->signal->session = current->signal->session;
-		attach_pid(p, PIDTYPE_PGID, process_group(p));
-		attach_pid(p, PIDTYPE_SID, p->signal->session);
-		if (p->pid)
+	if (p->pid) {
+		attach_pid(p, PIDTYPE_PID, p->pid);
+		attach_pid(p, PIDTYPE_TGID, p->tgid);
+		if (thread_group_leader(p)) {
+			p->signal->tty = current->signal->tty;
+			p->signal->pgrp = process_group(current);
+			p->signal->session = current->signal->session;
+			attach_pid(p, PIDTYPE_PGID, process_group(p));
+			attach_pid(p, PIDTYPE_SID, p->signal->session);
 			__get_cpu_var(process_counts)++;
+		}
+		nr_threads++;
 	}
 
-	nr_threads++;
 	total_forks++;
 	write_unlock_irq(&tasklist_lock);
 	proc_fork_connector(p);
@@ -1210,7 +1211,7 @@ task_t * __devinit fork_idle(int cpu)
 	if (!task)
 		return ERR_PTR(-ENOMEM);
 	init_idle(task, cpu);
-	unhash_process(task);
+
 	return task;
 }
 
--- RC-1/include/linux/sched.h~NOIPID	2006-01-19 18:13:07.000000000 +0300
+++ RC-1/include/linux/sched.h	2006-01-29 23:35:44.000000000 +0300
@@ -1217,8 +1217,6 @@ static inline int thread_group_empty(tas
 #define delay_group_leader(p) \
 		(thread_group_leader(p) && !thread_group_empty(p))
 
-extern void unhash_process(struct task_struct *p);
-
 /*
  * Protects ->fs, ->files, ->mm, ->ptrace, ->group_info, ->comm, keyring
  * subscriptions and synchronises with wait4().  Also used in procfs.  Also
--- RC-1/kernel/exit.c~NOIPID	2006-01-19 18:13:07.000000000 +0300
+++ RC-1/kernel/exit.c	2006-01-29 23:30:02.000000000 +0300
@@ -52,8 +52,7 @@ static void __unhash_process(struct task
 	if (thread_group_leader(p)) {
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
-		if (p->pid)
-			__get_cpu_var(process_counts)--;
+		__get_cpu_var(process_counts)--;
 	}
 
 	REMOVE_LINKS(p);
@@ -114,21 +113,6 @@ repeat: 
 		goto repeat;
 }
 
-/* we are using it only for SMP init */
-
-void unhash_process(struct task_struct *p)
-{
-	struct dentry *proc_dentry;
-
-	spin_lock(&p->proc_lock);
-	proc_dentry = proc_pid_unhash(p);
-	write_lock_irq(&tasklist_lock);
-	__unhash_process(p);
-	write_unlock_irq(&tasklist_lock);
-	spin_unlock(&p->proc_lock);
-	proc_pid_flush(proc_dentry);
-}
-
 /*
  * This checks not only the pgrp, but falls back on the pid if no
  * satisfactory pgrp is found. I dunno - gdb doesn't work correctly
--- RC-1/arch/um/kernel/smp.c~NOIPID	2005-03-19 14:16:40.000000000 +0300
+++ RC-1/arch/um/kernel/smp.c	2006-01-29 23:42:32.000000000 +0300
@@ -143,7 +143,6 @@ void smp_prepare_cpus(unsigned int maxcp
 		idle = idle_thread(cpu);
 
 		init_idle(idle, cpu);
-		unhash_process(idle);
 
 		waittime = 200000000;
 		while (waittime-- && !cpu_isset(cpu, cpu_callin_map))
