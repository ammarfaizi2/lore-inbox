Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319257AbSIFSRV>; Fri, 6 Sep 2002 14:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSIFSRV>; Fri, 6 Sep 2002 14:17:21 -0400
Received: from crack.them.org ([65.125.64.184]:24584 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S319257AbSIFSRT>;
	Fri, 6 Sep 2002 14:17:19 -0400
Date: Fri, 6 Sep 2002 14:21:57 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [patch] More ptrace fixes for 2.5.33
Message-ID: <20020906182157.GA9330@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Thanks for your collected resync patch this morning.  Here are the changes I
have on top of BK-curr + that patch:

  - Fix some bugs I introduced in zap_thread
  - Improve the check for traced children in sys_wait4
  - Fix parent links when using CLONE_PTRACE

(My thanks to OGAWA Hirofumi for pointing out the first bit.)  Are the wait4
changes about what you had in mind?


The only other issue I know of is something else Hirofumi pointed out
earlier; there are problems when a tracing process dies unexpectedly.  I'll
come back to that later.

diff -up -r /big/kernel/linux-2.5/kernel/exit.c /big/kernel/linux-2.5-fixes/kernel/exit.c
--- linux-2.5/kernel/exit.c	2002-09-06 14:16:06.000000000 -0400
+++ linux-2.5-fixes/kernel/exit.c	2002-09-06 14:14:32.000000000 -0400
@@ -449,15 +449,19 @@ static inline void forget_original_paren
 
 static inline void zap_thread(task_t *p, task_t *father, int traced)
 {
-	/* If we were tracing the thread, release it; otherwise preserve the
-	   ptrace links.  */
+	/* If someone else is tracing this thread, preserve the ptrace links.  */
 	if (unlikely(traced)) {
 		task_t *trace_task = p->parent;
+		int ptrace_flag = p->ptrace;
+		BUG_ON (ptrace_flag == 0);
+
 		__ptrace_unlink(p);
-		p->ptrace = 1;
+		p->ptrace = ptrace_flag;
 		__ptrace_link(p, trace_task);
 	} else {
-		p->ptrace = 0;
+		/* Otherwise, if we were tracing this thread, untrace it.  */
+		ptrace_unlink (p);
+
 		list_del_init(&p->sibling);
 		p->parent = p->real_parent;
 		list_add_tail(&p->sibling, &p->parent->children);
@@ -646,6 +650,41 @@ asmlinkage long sys_exit(int error_code)
 	do_exit((error_code&0xff)<<8);
 }
 
+static inline int eligible_child(pid_t pid, int options, task_t *p)
+{
+	if (pid>0) {
+		if (p->pid != pid)
+			return 0;
+	} else if (!pid) {
+		if (p->pgrp != current->pgrp)
+			return 0;
+	} else if (pid != -1) {
+		if (p->pgrp != -pid)
+			return 0;
+	}
+
+	/*
+	 * Do not consider detached threads that are
+	 * not ptraced:
+	 */
+	if (p->exit_signal == -1 && !p->ptrace)
+		return 0;
+
+	/* Wait for all children (clone and not) if __WALL is set;
+	 * otherwise, wait for clone children *only* if __WCLONE is
+	 * set; otherwise, wait for non-clone children *only*.  (Note:
+	 * A "clone" child here is one that reports to its parent
+	 * using a signal other than SIGCHLD.) */
+	if (((p->exit_signal != SIGCHLD) ^ ((options & __WCLONE) != 0))
+	    && !(options & __WALL))
+		return 0;
+
+	if (security_ops->task_wait(p))
+		return 0;
+
+	return 1;
+}
+
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru)
 {
 	int flag, retval;
@@ -666,34 +705,8 @@ repeat:
 		struct list_head *_p;
 		list_for_each(_p,&tsk->children) {
 			p = list_entry(_p,struct task_struct,sibling);
-			if (pid>0) {
-				if (p->pid != pid)
-					continue;
-			} else if (!pid) {
-				if (p->pgrp != current->pgrp)
-					continue;
-			} else if (pid != -1) {
-				if (p->pgrp != -pid)
-					continue;
-			}
-			/*
-			 * Do not consider detached threads that are
-			 * not ptraced:
-			 */
-			if (p->exit_signal == -1 && !p->ptrace)
-				continue;
-			/* Wait for all children (clone and not) if __WALL is set;
-			 * otherwise, wait for clone children *only* if __WCLONE is
-			 * set; otherwise, wait for non-clone children *only*.  (Note:
-			 * A "clone" child here is one that reports to its parent
-			 * using a signal other than SIGCHLD.) */
-			if (((p->exit_signal != SIGCHLD) ^ ((options & __WCLONE) != 0))
-			    && !(options & __WALL))
+			if (!eligible_child(pid, options, p))
 				continue;
-
-			if (security_ops->task_wait(p))
-				continue;
-
 			flag = 1;
 			switch (p->state) {
 			case TASK_STOPPED:
@@ -738,12 +751,21 @@ repeat:
 				continue;
 			}
 		}
+		if (!flag) {
+			list_for_each (_p,&tsk->ptrace_children) {
+				p = list_entry(_p,struct task_struct,ptrace_list);
+				if (!eligible_child(pid, options, p))
+					continue;
+				flag = 1;
+				break;
+			}
+		}
 		if (options & __WNOTHREAD)
 			break;
 		tsk = next_thread(tsk);
 	} while (tsk != current);
 	read_unlock(&tasklist_lock);
-	if (flag || !list_empty(&current->ptrace_children)) {
+	if (flag) {
 		retval = 0;
 		if (options & WNOHANG)
 			goto end_wait4;
diff -up -r -x setup -x bzImage -x bvmlinux -x '*.bin*' -x '*.a' -x '*.o' -x '.*' -x .config -x .config.old -x vmlinux -x System.map -x BitKeeper -x ChangeSet -x SCCS /big/kernel/linux-2.5/kernel/fork.c /big/kernel/linux-2.5-fixes/kernel/fork.c
--- /big/kernel/linux-2.5/kernel/fork.c	2002-09-05 17:09:41.000000000 -0400
+++ /big/kernel/linux-2.5-fixes/kernel/fork.c	2002-09-06 14:14:32.000000000 -0400
@@ -836,13 +836,11 @@ static struct task_struct *copy_process(
 	write_lock_irq(&tasklist_lock);
 
 	/* CLONE_PARENT re-uses the old parent */
-	p->real_parent = current->real_parent;
-	p->parent = current->parent;
-	if (!(clone_flags & CLONE_PARENT)) {
+	if (clone_flags & CLONE_PARENT)
+		p->real_parent = current->real_parent;
+	else
 		p->real_parent = current;
-		if (!(p->ptrace & PT_PTRACED))
-			p->parent = current;
-	}
+	p->parent = p->real_parent;
 
 	if (clone_flags & CLONE_THREAD) {
 		p->tgid = current->tgid;
@@ -850,7 +848,8 @@ static struct task_struct *copy_process(
 	}
 
 	SET_LINKS(p);
-	ptrace_link(p, p->parent);
+	if (p->ptrace & PT_PTRACED)
+		__ptrace_link(p, current->parent);
 	hash_pid(p);
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
