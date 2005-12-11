Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVLKVLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVLKVLv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 16:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVLKVLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 16:11:50 -0500
Received: from takamine.ncl.cs.columbia.edu ([128.59.18.70]:10414 "EHLO
	takamine.ncl.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S1750708AbVLKVLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 16:11:50 -0500
Date: Sun, 11 Dec 2005 16:14:01 -0500 (EST)
From: Oren Laadan <orenl@cs.columbia.edu>
X-X-Sender: orenl@takamine.ncl.cs.columbia.edu
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: akpm@osdl.org, roland@redhat.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH ? 2/2] setpgid: should work for sub-threads
In-Reply-To: <439C605F.BA7C1D5B@tv-sign.ru>
Message-ID: <Pine.LNX.4.63.0512111605430.31447@takamine.ncl.cs.columbia.edu>
References: <200512110523.jBB5NVEr002551@shell0.pdx.osdl.net>
 <439C605F.BA7C1D5B@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH 1/1] setsid: should work for sub-threads

setsid() does not work unless the calling process is a 
thread_group_leader().

'man setpgid' does not tell anything about that, so I consider
this behaviour is a bug.

Signed-off-by: Oren Laadan <orenl@cs.columbia.edu>

---

(see similar patch for setpgid by Oleg Nesterov). This one also required 
modifying kernel/exit.c:__set_special_pids() (and it's prototype in 
sched.h).

Please review...

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b0ad6f3..9ff6e79 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1003,7 +1003,7 @@ extern struct   mm_struct init_mm;
  #define find_task_by_pid(nr)	find_task_by_pid_type(PIDTYPE_PID, nr)
  extern struct task_struct *find_task_by_pid_type(int type, int pid);
  extern void set_special_pids(pid_t session, pid_t pgrp);
-extern void __set_special_pids(pid_t session, pid_t pgrp);
+extern void __set_special_pids(struct task_struct *tsk, pid_t session, pid_t pgrp);

  /* per-UID process charging. */
  extern struct user_struct * alloc_uid(uid_t);
diff --git a/kernel/exit.c b/kernel/exit.c
index ee51568..d47931f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -256,26 +256,24 @@ static inline void reparent_to_init(void
  	switch_uid(INIT_USER);
  }

-void __set_special_pids(pid_t session, pid_t pgrp)
+void __set_special_pids(struct task_struct *tsk, pid_t session, pid_t pgrp)
  {
-	struct task_struct *curr = current;
-
-	if (curr->signal->session != session) {
-		detach_pid(curr, PIDTYPE_SID);
-		curr->signal->session = session;
-		attach_pid(curr, PIDTYPE_SID, session);
-	}
-	if (process_group(curr) != pgrp) {
-		detach_pid(curr, PIDTYPE_PGID);
-		curr->signal->pgrp = pgrp;
-		attach_pid(curr, PIDTYPE_PGID, pgrp);
+	if (tsk->signal->session != session) {
+		detach_pid(tsk, PIDTYPE_SID);
+		tsk->signal->session = session;
+		attach_pid(tsk, PIDTYPE_SID, session);
+	}
+	if (process_group(tsk) != pgrp) {
+		detach_pid(tsk, PIDTYPE_PGID);
+		tsk->signal->pgrp = pgrp;
+		attach_pid(tsk, PIDTYPE_PGID, pgrp);
  	}
  }

  void set_special_pids(pid_t session, pid_t pgrp)
  {
  	write_lock_irq(&tasklist_lock);
-	__set_special_pids(session, pgrp);
+	__set_special_pids(current, session, pgrp);
  	write_unlock_irq(&tasklist_lock);
  }

diff --git a/kernel/sys.c b/kernel/sys.c
index bce933e..c907f88 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1207,24 +1207,22 @@ asmlinkage long sys_getsid(pid_t pid)

  asmlinkage long sys_setsid(void)
  {
+	struct task_struct *leader = current->group_leader;
  	struct pid *pid;
  	int err = -EPERM;

-	if (!thread_group_leader(current))
-		return -EINVAL;
-
  	down(&tty_sem);
  	write_lock_irq(&tasklist_lock);

-	pid = find_pid(PIDTYPE_PGID, current->pid);
+	pid = find_pid(PIDTYPE_PGID, leader->pid);
  	if (pid)
  		goto out;

-	current->signal->leader = 1;
-	__set_special_pids(current->pid, current->pid);
-	current->signal->tty = NULL;
-	current->signal->tty_old_pgrp = 0;
-	err = process_group(current);
+	leader->signal->leader = 1;
+	__set_special_pids(leader, leader->pid, leader->pid);
+	leader->signal->tty = NULL;
+	leader->signal->tty_old_pgrp = 0;
+	err = process_group(leader);
  out:
  	write_unlock_irq(&tasklist_lock);
  	up(&tty_sem);



