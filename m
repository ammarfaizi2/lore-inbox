Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWJQUyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWJQUyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWJQUyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:54:08 -0400
Received: from cap31-3-82-227-199-249.fbx.proxad.net ([82.227.199.249]:44973
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750728AbWJQUxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:53:37 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20061017205308.735650000@localhost.localdomain>
References: <20061017203004.555659000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 17 Oct 2006 22:30:05 +0200
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@openvz.org>, Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch -mm 1/7] add process_session() helper routine
Content-Disposition: inline; filename=add-process_session-helper.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces occurences of task->signal->session by a new 
process_session() helper routine. 

It will be useful for pid namespaces to abstract the session pid
number.

This is a refreshed version for -mm of a patch previously sent

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
---
 arch/mips/kernel/irixelf.c |    2 +-
 drivers/char/mxser.c       |    2 +-
 drivers/char/rocket.c      |    2 +-
 drivers/char/tty_io.c      |   18 +++++++++---------
 fs/binfmt_elf.c            |    4 ++--
 fs/binfmt_elf_fdpic.c      |    4 ++--
 include/linux/sched.h      |    5 +++++
 kernel/exit.c              |   19 ++++++++++---------
 kernel/fork.c              |    4 ++--
 kernel/signal.c            |    2 +-
 kernel/sys.c               |    8 ++++----
 11 files changed, 38 insertions(+), 32 deletions(-)

Index: 2.6.19-rc2-mm1/arch/mips/kernel/irixelf.c
===================================================================
--- 2.6.19-rc2-mm1.orig/arch/mips/kernel/irixelf.c
+++ 2.6.19-rc2-mm1/arch/mips/kernel/irixelf.c
@@ -1149,7 +1149,7 @@ static int irix_core_dump(long signr, st
 	psinfo.pr_pid = prstatus.pr_pid = current->pid;
 	psinfo.pr_ppid = prstatus.pr_ppid = current->parent->pid;
 	psinfo.pr_pgrp = prstatus.pr_pgrp = process_group(current);
-	psinfo.pr_sid = prstatus.pr_sid = current->signal->session;
+	psinfo.pr_sid = prstatus.pr_sid = process_session(current);
 	if (current->pid == current->tgid) {
 		/*
 		 * This is the record for the group leader.  Add in the
Index: 2.6.19-rc2-mm1/drivers/char/mxser.c
===================================================================
--- 2.6.19-rc2-mm1.orig/drivers/char/mxser.c
+++ 2.6.19-rc2-mm1/drivers/char/mxser.c
@@ -997,7 +997,7 @@ static int mxser_open(struct tty_struct 
 		mxser_change_speed(info, NULL);
 	}
 
-	info->session = current->signal->session;
+	info->session = process_session(current);
 	info->pgrp = process_group(current);
 
 	/*
Index: 2.6.19-rc2-mm1/drivers/char/rocket.c
===================================================================
--- 2.6.19-rc2-mm1.orig/drivers/char/rocket.c
+++ 2.6.19-rc2-mm1/drivers/char/rocket.c
@@ -1017,7 +1017,7 @@ static int rp_open(struct tty_struct *tt
 	/*
 	 * Info->count is now 1; so it's safe to sleep now.
 	 */
-	info->session = current->signal->session;
+	info->session = process_session(current);
 	info->pgrp = process_group(current);
 
 	if ((info->flags & ROCKET_INITIALIZED) == 0) {
Index: 2.6.19-rc2-mm1/drivers/char/tty_io.c
===================================================================
--- 2.6.19-rc2-mm1.orig/drivers/char/tty_io.c
+++ 2.6.19-rc2-mm1/drivers/char/tty_io.c
@@ -1512,9 +1512,9 @@ void disassociate_ctty(int on_exit)
 
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
-	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
+	do_each_task_pid(process_session(current), PIDTYPE_SID, p) {
 		p->signal->tty = NULL;
-	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
+	} while_each_task_pid(process_session(current), PIDTYPE_SID, p);
 	read_unlock(&tasklist_lock);
 	mutex_unlock(&tty_mutex);
 	unlock_kernel();
@@ -2554,7 +2554,7 @@ got_driver:
 		current->signal->tty = tty;
 		task_unlock(current);
 		current->signal->tty_old_pgrp = 0;
-		tty->session = current->signal->session;
+		tty->session = process_session(current);
 		tty->pgrp = process_group(current);
 	}
 	return 0;
@@ -2890,7 +2890,7 @@ static int tiocsctty(struct tty_struct *
 	struct task_struct *p;
 
 	if (current->signal->leader &&
-	    (current->signal->session == tty->session))
+	    (process_session(current) == tty->session))
 		return 0;
 	/*
 	 * The process must be a session leader and
@@ -2922,7 +2922,7 @@ static int tiocsctty(struct tty_struct *
 	task_unlock(current);
 	mutex_unlock(&tty_mutex);
 	current->signal->tty_old_pgrp = 0;
-	tty->session = current->signal->session;
+	tty->session = process_session(current);
 	tty->pgrp = process_group(current);
 	return 0;
 }
@@ -2973,13 +2973,13 @@ static int tiocspgrp(struct tty_struct *
 		return retval;
 	if (!current->signal->tty ||
 	    (current->signal->tty != real_tty) ||
-	    (real_tty->session != current->signal->session))
+	    (real_tty->session != process_session(current)))
 		return -ENOTTY;
 	if (get_user(pgrp, p))
 		return -EFAULT;
 	if (pgrp < 0)
 		return -EINVAL;
-	if (session_of_pgrp(pgrp) != current->signal->session)
+	if (session_of_pgrp(pgrp) != process_session(current))
 		return -EPERM;
 	real_tty->pgrp = pgrp;
 	return 0;
@@ -3334,7 +3334,7 @@ static void __do_SAK(void *arg)
 	/* Kill the entire session */
 	do_each_task_pid(session, PIDTYPE_SID, p) {
 		printk(KERN_NOTICE "SAK: killed process %d"
-			" (%s): p->signal->session==tty->session\n",
+			" (%s): process_session(p)==tty->session\n",
 			p->pid, p->comm);
 		send_sig(SIGKILL, p, 1);
 	} while_each_task_pid(session, PIDTYPE_SID, p);
@@ -3344,7 +3344,7 @@ static void __do_SAK(void *arg)
 	do_each_thread(g, p) {
 		if (p->signal->tty == tty) {
 			printk(KERN_NOTICE "SAK: killed process %d"
-			    " (%s): p->signal->session==tty->session\n",
+			    " (%s): process_session(p)==tty->session\n",
 			    p->pid, p->comm);
 			send_sig(SIGKILL, p, 1);
 			continue;
Index: 2.6.19-rc2-mm1/fs/binfmt_elf.c
===================================================================
--- 2.6.19-rc2-mm1.orig/fs/binfmt_elf.c
+++ 2.6.19-rc2-mm1/fs/binfmt_elf.c
@@ -1313,7 +1313,7 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_pid = p->pid;
 	prstatus->pr_ppid = p->parent->pid;
 	prstatus->pr_pgrp = process_group(p);
-	prstatus->pr_sid = p->signal->session;
+	prstatus->pr_sid = process_session(p);
 	if (thread_group_leader(p)) {
 		/*
 		 * This is the record for the group leader.  Add in the
@@ -1359,7 +1359,7 @@ static int fill_psinfo(struct elf_prpsin
 	psinfo->pr_pid = p->pid;
 	psinfo->pr_ppid = p->parent->pid;
 	psinfo->pr_pgrp = process_group(p);
-	psinfo->pr_sid = p->signal->session;
+	psinfo->pr_sid = process_session(p);
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
 	psinfo->pr_state = i;
Index: 2.6.19-rc2-mm1/fs/binfmt_elf_fdpic.c
===================================================================
--- 2.6.19-rc2-mm1.orig/fs/binfmt_elf_fdpic.c
+++ 2.6.19-rc2-mm1/fs/binfmt_elf_fdpic.c
@@ -1325,7 +1325,7 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_pid = p->pid;
 	prstatus->pr_ppid = p->parent->pid;
 	prstatus->pr_pgrp = process_group(p);
-	prstatus->pr_sid = p->signal->session;
+	prstatus->pr_sid = process_session(p);
 	if (thread_group_leader(p)) {
 		/*
 		 * This is the record for the group leader.  Add in the
@@ -1374,7 +1374,7 @@ static int fill_psinfo(struct elf_prpsin
 	psinfo->pr_pid = p->pid;
 	psinfo->pr_ppid = p->parent->pid;
 	psinfo->pr_pgrp = process_group(p);
-	psinfo->pr_sid = p->signal->session;
+	psinfo->pr_sid = process_session(p);
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
 	psinfo->pr_state = i;
Index: 2.6.19-rc2-mm1/include/linux/sched.h
===================================================================
--- 2.6.19-rc2-mm1.orig/include/linux/sched.h
+++ 2.6.19-rc2-mm1/include/linux/sched.h
@@ -1067,6 +1067,11 @@ static inline pid_t process_group(struct
 	return tsk->signal->pgrp;
 }
 
+static inline pid_t process_session(struct task_struct *tsk)
+{
+	return tsk->signal->session;
+}
+
 static inline struct pid *task_pid(struct task_struct *task)
 {
 	return task->pids[PIDTYPE_PID].pid;
Index: 2.6.19-rc2-mm1/kernel/exit.c
===================================================================
--- 2.6.19-rc2-mm1.orig/kernel/exit.c
+++ 2.6.19-rc2-mm1/kernel/exit.c
@@ -192,14 +192,14 @@ int session_of_pgrp(int pgrp)
 
 	read_lock(&tasklist_lock);
 	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
-		if (p->signal->session > 0) {
-			sid = p->signal->session;
+		if (process_session(p) > 0) {
+			sid = process_session(p);
 			goto out;
 		}
 	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
 	p = find_task_by_pid(pgrp);
 	if (p)
-		sid = p->signal->session;
+		sid = process_session(p);
 out:
 	read_unlock(&tasklist_lock);
 	
@@ -224,8 +224,8 @@ static int will_become_orphaned_pgrp(int
 				|| p->exit_state
 				|| is_init(p->real_parent))
 			continue;
-		if (process_group(p->real_parent) != pgrp
-			    && p->real_parent->signal->session == p->signal->session) {
+		if (process_group(p->real_parent) != pgrp &&
+		    process_session(p->real_parent) == process_session(p)) {
 			ret = 0;
 			break;
 		}
@@ -301,7 +301,7 @@ void __set_special_pids(pid_t session, p
 {
 	struct task_struct *curr = current->group_leader;
 
-	if (curr->signal->session != session) {
+	if (process_session(curr) != session) {
 		detach_pid(curr, PIDTYPE_SID);
 		curr->signal->session = session;
 		attach_pid(curr, PIDTYPE_SID, session);
@@ -646,10 +646,11 @@ reparent_thread(struct task_struct *p, s
 	 * outside, so the child pgrp is now orphaned.
 	 */
 	if ((process_group(p) != process_group(father)) &&
-	    (p->signal->session == father->signal->session)) {
+	    (process_session(p) == process_session(father))) {
 		int pgrp = process_group(p);
 
-		if (will_become_orphaned_pgrp(pgrp, NULL) && has_stopped_jobs(pgrp)) {
+		if (will_become_orphaned_pgrp(pgrp, NULL) &&
+		    has_stopped_jobs(pgrp)) {
 			__kill_pg_info(SIGHUP, SEND_SIG_PRIV, pgrp);
 			__kill_pg_info(SIGCONT, SEND_SIG_PRIV, pgrp);
 		}
@@ -783,7 +784,7 @@ static void exit_notify(struct task_stru
 	t = tsk->real_parent;
 	
 	if ((process_group(t) != process_group(tsk)) &&
-	    (t->signal->session == tsk->signal->session) &&
+	    (process_session(t) == process_session(tsk)) &&
 	    will_become_orphaned_pgrp(process_group(tsk), tsk) &&
 	    has_stopped_jobs(process_group(tsk))) {
 		__kill_pg_info(SIGHUP, SEND_SIG_PRIV, process_group(tsk));
Index: 2.6.19-rc2-mm1/kernel/fork.c
===================================================================
--- 2.6.19-rc2-mm1.orig/kernel/fork.c
+++ 2.6.19-rc2-mm1/kernel/fork.c
@@ -1236,9 +1236,9 @@ static struct task_struct *copy_process(
 		if (thread_group_leader(p)) {
 			p->signal->tty = current->signal->tty;
 			p->signal->pgrp = process_group(current);
-			p->signal->session = current->signal->session;
+			p->signal->session = process_session(current);
 			attach_pid(p, PIDTYPE_PGID, process_group(p));
-			attach_pid(p, PIDTYPE_SID, p->signal->session);
+			attach_pid(p, PIDTYPE_SID, process_session(p));
 
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			__get_cpu_var(process_counts)++;
Index: 2.6.19-rc2-mm1/kernel/signal.c
===================================================================
--- 2.6.19-rc2-mm1.orig/kernel/signal.c
+++ 2.6.19-rc2-mm1/kernel/signal.c
@@ -576,7 +576,7 @@ static int check_kill_permission(int sig
 	error = -EPERM;
 	if ((info == SEND_SIG_NOINFO || (!is_si_special(info) && SI_FROMUSER(info)))
 	    && ((sig != SIGCONT) ||
-		(current->signal->session != t->signal->session))
+		(process_session(current) != process_session(t)))
 	    && (current->euid ^ t->suid) && (current->euid ^ t->uid)
 	    && (current->uid ^ t->suid) && (current->uid ^ t->uid)
 	    && !capable(CAP_KILL))
Index: 2.6.19-rc2-mm1/kernel/sys.c
===================================================================
--- 2.6.19-rc2-mm1.orig/kernel/sys.c
+++ 2.6.19-rc2-mm1/kernel/sys.c
@@ -1381,7 +1381,7 @@ asmlinkage long sys_setpgid(pid_t pid, p
 
 	if (p->real_parent == group_leader) {
 		err = -EPERM;
-		if (p->signal->session != group_leader->signal->session)
+		if (process_session(p) != process_session(group_leader))
 			goto out;
 		err = -EACCES;
 		if (p->did_exec)
@@ -1400,7 +1400,7 @@ asmlinkage long sys_setpgid(pid_t pid, p
 		struct task_struct *p;
 
 		do_each_task_pid(pgid, PIDTYPE_PGID, p) {
-			if (p->signal->session == group_leader->signal->session)
+			if (process_session(p) == process_session(group_leader))
 				goto ok_pgid;
 		} while_each_task_pid(pgid, PIDTYPE_PGID, p);
 		goto out;
@@ -1459,7 +1459,7 @@ asmlinkage long sys_getpgrp(void)
 asmlinkage long sys_getsid(pid_t pid)
 {
 	if (!pid)
-		return current->signal->session;
+		return process_session(current);
 	else {
 		int retval;
 		struct task_struct *p;
@@ -1471,7 +1471,7 @@ asmlinkage long sys_getsid(pid_t pid)
 		if (p) {
 			retval = security_task_getsid(p);
 			if (!retval)
-				retval = p->signal->session;
+				retval = process_session(p);
 		}
 		read_unlock(&tasklist_lock);
 		return retval;

--
