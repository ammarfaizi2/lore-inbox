Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbSIPKwS>; Mon, 16 Sep 2002 06:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSIPKwR>; Mon, 16 Sep 2002 06:52:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13957 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261342AbSIPKwO>;
	Mon, 16 Sep 2002 06:52:14 -0400
Date: Mon, 16 Sep 2002 13:03:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] thread-exec-fix-2.5.35-A5, BK-curr
Message-ID: <Pine.LNX.4.44.0209161256140.27517-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) fixes a number of sys_execve()  
problems:

 - ptrace of thread groups over exec works again.

 - if the exec() is done in a non-leader thread then we must inherit the
   parent links properly - otherwise the shell will see an early
   child-exit notification.

 - if the exec()-ing thread is detached then make it use SIGCHLD like the
   leader thread.

 - wait for the leader thread to become TASK_ZOMBIE properly -
   wait_task_inactive() alone was not enough. This should be a rare
   codepath.

now sys_execve() from thread groups works as expected in every combination
i could test: standalone, from the leader thread, from one of the child
threads, ptraced, non-ptraced, SMP and UP.

	Ingo

--- linux/fs/exec.c.orig	Mon Sep 16 11:11:34 2002
+++ linux/fs/exec.c	Mon Sep 16 12:53:00 2002
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/namei.h>
 #include <linux/proc_fs.h>
+#include <linux/ptrace.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -577,11 +578,17 @@
 	 * and to assume its PID:
 	 */
 	if (current->pid != current->tgid) {
-		struct task_struct *leader = current->group_leader;
+		struct task_struct *leader = current->group_leader, *parent;
 		struct dentry *proc_dentry1, *proc_dentry2;
-		unsigned long state;
+		unsigned long state, ptrace;
 
-		wait_task_inactive(leader);
+		/*
+		 * Wait for the thread group leader to be a zombie.
+		 * It should already be zombie at this point, most
+		 * of the time.
+		 */
+		while (leader->state != TASK_ZOMBIE)
+			yield();
 
 		write_lock_irq(&tasklist_lock);
 		proc_dentry1 = clean_proc_dentry(current);
@@ -597,10 +604,33 @@
 		 * two threads with a switched PID, and release
 		 * the former thread group leader:
 		 */
+		ptrace = leader->ptrace;
+		parent = leader->parent;
+
+		ptrace_unlink(leader);
+		ptrace_unlink(current);
 		unhash_pid(current);
 		unhash_pid(leader);
+		remove_parent(current);
+		remove_parent(leader);
+		/*
+		 * Split up the last two remaining members of the
+		 * thread group:
+		 */
+		list_del_init(&leader->thread_group);
+
 		leader->pid = leader->tgid = current->pid;
 		current->pid = current->tgid;
+		current->parent = current->real_parent = leader->real_parent;
+		leader->parent = leader->real_parent = child_reaper;
+		current->exit_signal = SIGCHLD;
+
+		add_parent(current, current->parent);
+		add_parent(leader, leader->parent);
+		if (ptrace) {
+			current->ptrace = ptrace;
+			__ptrace_link(current, parent);
+		}
 		hash_pid(current);
 		hash_pid(leader);
 		
@@ -608,8 +638,9 @@
 		state = leader->state;
 		write_unlock_irq(&tasklist_lock);
 
-		if (state == TASK_ZOMBIE)
-			release_task(leader);
+		if (state != TASK_ZOMBIE)
+			BUG();
+		release_task(leader);
 
 		put_proc_dentry(proc_dentry1);
 		put_proc_dentry(proc_dentry2);


