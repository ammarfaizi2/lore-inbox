Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315659AbSEIIqv>; Thu, 9 May 2002 04:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315660AbSEIIqu>; Thu, 9 May 2002 04:46:50 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:51469 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315659AbSEIIqt>; Thu, 9 May 2002 04:46:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug CPU prep III: daemonize idle tasks
Date: Thu, 09 May 2002 18:50:11 +1000
Message-Id: <E175jcp-00022d-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces __daemonize(task), so idle tasks can be detached
after cloning (required for late creation of idle tasks).

This is independent of the last two patches.

Name: Daemonize idle task
Author: Rusty Russell

D: This patch allows daemonize() to be called on another process (if
D: not started yet), and calls it on the idle task.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork+clonepid/include/linux/sched.h tmp/include/linux/sched.h
--- working-2.5.14-dofork+clonepid/include/linux/sched.h	Thu May  9 18:25:21 2002
+++ tmp/include/linux/sched.h	Thu May  9 18:36:17 2002
@@ -654,7 +654,12 @@
 extern void exit_sighand(struct task_struct *);
 
 extern void reparent_to_init(void);
-extern void daemonize(void);
+extern void __daemonize(struct task_struct *);
+static inline void daemonize(void)
+{
+	__daemonize(current);
+}
+
 extern task_t *child_reaper;
 
 extern int do_execve(char *, char **, char **, struct pt_regs *);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork+clonepid/kernel/exit.c tmp/kernel/exit.c
--- working-2.5.14-dofork+clonepid/kernel/exit.c	Mon Apr 29 16:00:29 2002
+++ tmp/kernel/exit.c	Thu May  9 18:36:17 2002
@@ -201,32 +201,30 @@
  *	Put all the gunge required to become a kernel thread without
  *	attached user resources in one place where it belongs.
  */
-
-void daemonize(void)
+void __daemonize(struct task_struct *tsk)
 {
 	struct fs_struct *fs;
 
-
 	/*
 	 * If we were started as result of loading a module, close all of the
 	 * user space pages.  We don't need them, and if we didn't close them
 	 * they would be locked into memory.
 	 */
-	exit_mm(current);
+	exit_mm(tsk);
 
-	current->session = 1;
-	current->pgrp = 1;
-	current->tty = NULL;
+	tsk->session = 1;
+	tsk->pgrp = 1;
+	tsk->tty = NULL;
 
 	/* Become as one with the init task */
 
-	exit_fs(current);	/* current->fs->count--; */
+	exit_fs(tsk);	/* current->fs->count--; */
 	fs = init_task.fs;
-	current->fs = fs;
+	tsk->fs = fs;
 	atomic_inc(&fs->count);
- 	exit_files(current);
-	current->files = init_task.files;
-	atomic_inc(&current->files->count);
+ 	exit_files(tsk);
+	tsk->files = init_task.files;
+	atomic_inc(&tsk->files->count);
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.14-dofork+clonepid/kernel/sched.c tmp/kernel/sched.c
--- working-2.5.14-dofork+clonepid/kernel/sched.c	Wed May  1 15:09:29 2002
+++ tmp/kernel/sched.c	Thu May  9 18:45:17 2002
@@ -1555,6 +1555,8 @@
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(idle->thread_info->cpu);
 	unsigned long flags;
 
+	if (idle != &init_task)
+		__daemonize(idle);
 	__save_flags(flags);
 	__cli();
 	double_rq_lock(idle_rq, rq);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
