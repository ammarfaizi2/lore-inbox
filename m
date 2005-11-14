Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVKNVfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVKNVfC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVKNVco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:32:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:30146 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932150AbVKNVcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:32:33 -0500
Message-Id: <20051114212527.584148000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:47 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 06/13] Change pid accesses: kernel/
Content-Disposition: inline; filename=B5-change-pid-tgid-references-kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: kernel/
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses for kernel/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 kernel/acct.c             |    4 ++--
 kernel/auditsc.c          |   14 +++++++-------
 kernel/capability.c       |    8 ++++----
 kernel/cpu.c              |    2 +-
 kernel/cpuset.c           |    2 +-
 kernel/exit.c             |   30 +++++++++++++++---------------
 kernel/fork.c             |   16 ++++++++--------
 kernel/futex.c            |    2 +-
 kernel/kexec.c            |    3 ++-
 kernel/pid.c              |   12 ++++++------
 kernel/posix-cpu-timers.c |   15 ++++++++-------
 kernel/posix-timers.c     |    5 +++--
 kernel/ptrace.c           |    2 +-
 kernel/sched.c            |   15 ++++++++-------
 kernel/signal.c           |   22 +++++++++++-----------
 kernel/stop_machine.c     |    2 +-
 kernel/sys.c              |   10 +++++-----
 kernel/sysctl.c           |    2 +-
 kernel/timer.c            |    8 ++++----
 19 files changed, 89 insertions(+), 85 deletions(-)

Index: linux-2.6.15-rc1/kernel/acct.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/acct.c
+++ linux-2.6.15-rc1/kernel/acct.c
@@ -485,8 +485,8 @@ static void do_acct_process(long exitcod
 	ac.ac_gid16 = current->gid;
 #endif
 #if ACCT_VERSION==3
-	ac.ac_pid = current->tgid;
-	ac.ac_ppid = current->parent->tgid;
+	ac.ac_pid = task_tgid(current);
+	ac.ac_ppid = task_tgid(current->parent);
 #endif
 
 	read_lock(&tasklist_lock);	/* pin current->signal */
Index: linux-2.6.15-rc1/kernel/auditsc.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/auditsc.c
+++ linux-2.6.15-rc1/kernel/auditsc.c
@@ -401,7 +401,7 @@ static int audit_filter_rules(struct tas
 
 		switch (field) {
 		case AUDIT_PID:
-			result = (tsk->pid == value);
+			result = (task_pid(tsk) == value);
 			break;
 		case AUDIT_UID:
 			result = (tsk->uid == value);
@@ -536,7 +536,7 @@ static enum audit_state audit_filter_sys
 	struct audit_entry *e;
 	enum audit_state state;
 
-	if (audit_pid && tsk->tgid == audit_pid)
+	if (audit_pid && task_tgid(tsk) == audit_pid)
 		return AUDIT_DISABLED;
 
 	rcu_read_lock();
@@ -633,7 +633,7 @@ static inline struct audit_context *audi
 			context->auditable = 1;
 	}
 
-	context->pid = tsk->pid;
+	context->pid = task_pid(tsk);
 	context->uid = tsk->uid;
 	context->gid = tsk->gid;
 	context->euid = tsk->euid;
@@ -975,7 +975,7 @@ void audit_syscall_entry(struct task_str
 		printk(KERN_ERR
 		       "audit(:%d) pid=%d in syscall=%d;"
 		       " entering syscall=%d\n",
-		       context->serial, tsk->pid, context->major, major);
+		       context->serial, task_pid(tsk), context->major, major);
 #endif
 		newctx = audit_alloc_context(context->state);
 		if (newctx) {
@@ -1179,7 +1179,7 @@ int audit_set_loginuid(struct task_struc
 		if (ab) {
 			audit_log_format(ab, "login pid=%d uid=%u "
 				"old auid=%u new auid=%u",
-				task->pid, task->uid, 
+				task_pid(task), task->uid,
 				task->audit_context->loginuid, loginuid);
 			audit_log_end(ab);
 		}
@@ -1284,10 +1284,10 @@ void audit_signal_info(int sig, struct t
 	extern pid_t audit_sig_pid;
 	extern uid_t audit_sig_uid;
 
-	if (unlikely(audit_pid && t->tgid == audit_pid)) {
+	if (unlikely(audit_pid && task_tgid(t) == audit_pid)) {
 		if (sig == SIGTERM || sig == SIGHUP) {
 			struct audit_context *ctx = current->audit_context;
-			audit_sig_pid = current->pid;
+			audit_sig_pid = task_pid(current);
 			if (ctx)
 				audit_sig_uid = ctx->loginuid;
 			else
Index: linux-2.6.15-rc1/kernel/capability.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/capability.c
+++ linux-2.6.15-rc1/kernel/capability.c
@@ -66,7 +66,7 @@ asmlinkage long sys_capget(cap_user_head
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock); 
 
-     if (pid && pid != current->pid) {
+     if (pid && pid != task_pid(current)) {
 	     target = find_task_by_pid(pid);
 	     if (!target) {
 	          ret = -ESRCH;
@@ -132,7 +132,7 @@ static inline int cap_set_all(kernel_cap
      int found = 0;
 
      do_each_thread(g, target) {
-             if (target == current || target->pid == 1)
+             if (target == current || task_pid(target) == 1)
                      continue;
              found = 1;
 	     if (security_capset_check(target, effective, inheritable,
@@ -187,7 +187,7 @@ asmlinkage long sys_capset(cap_user_head
      if (get_user(pid, &header->pid))
 	     return -EFAULT; 
 
-     if (pid && pid != current->pid && !capable(CAP_SETPCAP))
+     if (pid && pid != task_pid(current) && !capable(CAP_SETPCAP))
              return -EPERM;
 
      if (copy_from_user(&effective, &data->effective, sizeof(effective)) ||
@@ -198,7 +198,7 @@ asmlinkage long sys_capset(cap_user_head
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock);
 
-     if (pid > 0 && pid != current->pid) {
+     if (pid > 0 && pid != task_pid(current)) {
           target = find_task_by_pid(pid);
           if (!target) {
                ret = -ESRCH;
Index: linux-2.6.15-rc1/kernel/cpu.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/cpu.c
+++ linux-2.6.15-rc1/kernel/cpu.c
@@ -72,7 +72,7 @@ static inline void check_for_tasks(int c
 		     !cputime_eq(p->stime, cputime_zero)))
 			printk(KERN_WARNING "Task %s (pid = %d) is on cpu %d\
 				(state = %ld, flags = %lx) \n",
-				 p->comm, p->pid, cpu, p->state, p->flags);
+				 p->comm, task_pid(p), cpu, p->state, p->flags);
 	}
 	write_unlock_irq(&tasklist_lock);
 }
Index: linux-2.6.15-rc1/kernel/cpuset.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/cpuset.c
+++ linux-2.6.15-rc1/kernel/cpuset.c
@@ -1261,7 +1261,7 @@ static inline int pid_array_load(pid_t *
 
 	do_each_thread(g, p) {
 		if (p->cpuset == cs) {
-			pidarray[n++] = p->pid;
+			pidarray[n++] = task_pid(p);
 			if (unlikely(n == npids))
 				goto array_full;
 		}
Index: linux-2.6.15-rc1/kernel/exit.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/exit.c
+++ linux-2.6.15-rc1/kernel/exit.c
@@ -50,7 +50,7 @@ static void __unhash_process(struct task
 	if (thread_group_leader(p)) {
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
-		if (p->pid)
+		if (task_pid(p))
 			__get_cpu_var(process_counts)--;
 	}
 
@@ -170,7 +170,7 @@ static int will_become_orphaned_pgrp(int
 	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
 		if (p == ignored_task
 				|| p->exit_state
-				|| p->real_parent->pid == 1)
+				|| task_pid(p->real_parent) == 1)
 			continue;
 		if (process_group(p->real_parent) != pgrp
 			    && p->real_parent->signal->session == p->signal->session) {
@@ -797,9 +797,9 @@ fastcall NORET_TYPE void do_exit(long co
 
 	if (unlikely(in_interrupt()))
 		panic("Aiee, killing interrupt handler!");
-	if (unlikely(!tsk->pid))
+	if (unlikely(!task_pid(tsk)))
 		panic("Attempted to kill the idle task!");
-	if (unlikely(tsk->pid == 1))
+	if (unlikely(task_pid(tsk) == 1))
 		panic("Attempted to kill init!");
 	if (tsk->io_context)
 		exit_io_context();
@@ -832,7 +832,7 @@ fastcall NORET_TYPE void do_exit(long co
 
 	if (unlikely(in_atomic()))
 		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
-				current->comm, current->pid,
+				current->comm, task_pid(current),
 				preempt_count());
 
 	acct_update_integrals(tsk);
@@ -951,7 +951,7 @@ asmlinkage void sys_exit_group(int error
 static int eligible_child(pid_t pid, int options, task_t *p)
 {
 	if (pid > 0) {
-		if (p->pid != pid)
+		if (task_pid(p) != pid)
 			return 0;
 	} else if (!pid) {
 		if (process_group(p) != process_group(current))
@@ -980,7 +980,7 @@ static int eligible_child(pid_t pid, int
 	 * Do not consider thread group leaders that are
 	 * in a non-empty thread group:
 	 */
-	if (current->tgid != p->tgid && delay_group_leader(p))
+	if (task_tgid(current) != task_tgid(p) && delay_group_leader(p))
 		return 2;
 
 	if (security_task_wait(p))
@@ -1028,7 +1028,7 @@ static int wait_task_zombie(task_t *p, i
 	int status;
 
 	if (unlikely(noreap)) {
-		pid_t pid = p->pid;
+		pid_t pid = task_pid(p);
 		uid_t uid = p->uid;
 		int exit_code = p->exit_code;
 		int why, status;
@@ -1135,7 +1135,7 @@ static int wait_task_zombie(task_t *p, i
 			retval = put_user(status, &infop->si_status);
 	}
 	if (!retval && infop)
-		retval = put_user(p->pid, &infop->si_pid);
+		retval = put_user(task_pid(p), &infop->si_pid);
 	if (!retval && infop)
 		retval = put_user(p->uid, &infop->si_uid);
 	if (retval) {
@@ -1143,7 +1143,7 @@ static int wait_task_zombie(task_t *p, i
 		p->exit_state = EXIT_ZOMBIE;
 		return retval;
 	}
-	retval = p->pid;
+	retval = task_pid(p);
 	if (p->real_parent != p->parent) {
 		write_lock_irq(&tasklist_lock);
 		/* Double-check with lock held.  */
@@ -1203,7 +1203,7 @@ static int wait_task_stopped(task_t *p, 
 	read_unlock(&tasklist_lock);
 
 	if (unlikely(noreap)) {
-		pid_t pid = p->pid;
+		pid_t pid = task_pid(p);
 		uid_t uid = p->uid;
 		int why = (p->ptrace & PT_PTRACED) ? CLD_TRAPPED : CLD_STOPPED;
 
@@ -1274,11 +1274,11 @@ bail_ref:
 	if (!retval && infop)
 		retval = put_user(exit_code, &infop->si_status);
 	if (!retval && infop)
-		retval = put_user(p->pid, &infop->si_pid);
+		retval = put_user(task_pid(p), &infop->si_pid);
 	if (!retval && infop)
 		retval = put_user(p->uid, &infop->si_uid);
 	if (!retval)
-		retval = p->pid;
+		retval = task_pid(p);
 	put_task_struct(p);
 
 	BUG_ON(!retval);
@@ -1315,7 +1315,7 @@ static int wait_task_continued(task_t *p
 		p->signal->flags &= ~SIGNAL_STOP_CONTINUED;
 	spin_unlock_irq(&p->sighand->siglock);
 
-	pid = p->pid;
+	pid = task_pid(p);
 	uid = p->uid;
 	get_task_struct(p);
 	read_unlock(&tasklist_lock);
@@ -1326,7 +1326,7 @@ static int wait_task_continued(task_t *p
 		if (!retval && stat_addr)
 			retval = put_user(0xffff, stat_addr);
 		if (!retval)
-			retval = p->pid;
+			retval = task_pid(p);
 	} else {
 		retval = wait_noreap_copyout(p, pid, uid,
 					     CLD_CONTINUED, SIGCONT,
Index: linux-2.6.15-rc1/kernel/fork.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/fork.c
+++ linux-2.6.15-rc1/kernel/fork.c
@@ -850,7 +850,7 @@ asmlinkage long sys_set_tid_address(int 
 {
 	current->clear_child_tid = tidptr;
 
-	return current->pid;
+	return task_pid(current);
 }
 
 /*
@@ -927,10 +927,10 @@ static task_t *copy_process(unsigned lon
 
 	p->did_exec = 0;
 	copy_flags(clone_flags, p);
-	p->pid = pid;
+	p->__pid = pid;
 	retval = -EFAULT;
 	if (clone_flags & CLONE_PARENT_SETTID)
-		if (put_user(p->pid, parent_tidptr))
+		if (put_user(task_pid(p), parent_tidptr))
 			goto bad_fork_cleanup;
 
 	p->proc_dentry = NULL;
@@ -975,9 +975,9 @@ static task_t *copy_process(unsigned lon
  	}
 #endif
 
-	p->tgid = p->pid;
+	p->__tgid = task_pid(p);
 	if (clone_flags & CLONE_THREAD)
-		p->tgid = current->tgid;
+		p->__tgid = task_tgid(current);
 
 	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup_policy;
@@ -1128,12 +1128,12 @@ static task_t *copy_process(unsigned lon
 
 	cpuset_fork(p);
 
-	attach_pid(p, PIDTYPE_PID, p->pid);
-	attach_pid(p, PIDTYPE_TGID, p->tgid);
+	attach_pid(p, PIDTYPE_PID, task_pid(p));
+	attach_pid(p, PIDTYPE_TGID, task_tgid(p));
 	if (thread_group_leader(p)) {
 		attach_pid(p, PIDTYPE_PGID, process_group(p));
 		attach_pid(p, PIDTYPE_SID, p->signal->session);
-		if (p->pid)
+		if (task_pid(p))
 			__get_cpu_var(process_counts)++;
 	}
 
Index: linux-2.6.15-rc1/kernel/futex.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/futex.c
+++ linux-2.6.15-rc1/kernel/futex.c
@@ -789,7 +789,7 @@ static int futex_fd(unsigned long uaddr,
 	filp->f_mapping = filp->f_dentry->d_inode->i_mapping;
 
 	if (signal) {
-		err = f_setown(filp, current->pid, 1);
+		err = f_setown(filp, task_pid(current), 1);
 		if (err < 0) {
 			goto error;
 		}
Index: linux-2.6.15-rc1/kernel/kexec.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/kexec.c
+++ linux-2.6.15-rc1/kernel/kexec.c
@@ -36,7 +36,8 @@ struct resource crashk_res = {
 
 int kexec_should_crash(struct task_struct *p)
 {
-	if (in_interrupt() || !p->pid || p->pid == 1 || panic_on_oops)
+	if (in_interrupt() || !task_pid(p) ||
+	    task_pid(p) == 1 || panic_on_oops)
 		return 1;
 	return 0;
 }
Index: linux-2.6.15-rc1/kernel/pid.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/pid.c
+++ linux-2.6.15-rc1/kernel/pid.c
@@ -232,17 +232,17 @@ void switch_exec_pids(task_t *leader, ta
 	__detach_pid(thread, PIDTYPE_PID);
 	__detach_pid(thread, PIDTYPE_TGID);
 
-	leader->pid = leader->tgid = thread->pid;
-	thread->pid = thread->tgid;
+	leader->__pid = leader->__tgid = thread->__pid;
+	thread->__pid = thread->__tgid;
 
-	attach_pid(thread, PIDTYPE_PID, thread->pid);
-	attach_pid(thread, PIDTYPE_TGID, thread->tgid);
+	attach_pid(thread, PIDTYPE_PID, thread->__pid);
+	attach_pid(thread, PIDTYPE_TGID, thread->__tgid);
 	attach_pid(thread, PIDTYPE_PGID, thread->signal->pgrp);
 	attach_pid(thread, PIDTYPE_SID, thread->signal->session);
 	list_add_tail(&thread->tasks, &init_task.tasks);
 
-	attach_pid(leader, PIDTYPE_PID, leader->pid);
-	attach_pid(leader, PIDTYPE_TGID, leader->tgid);
+	attach_pid(leader, PIDTYPE_PID, leader->__pid);
+	attach_pid(leader, PIDTYPE_TGID, leader->__tgid);
 	attach_pid(leader, PIDTYPE_PGID, leader->signal->pgrp);
 	attach_pid(leader, PIDTYPE_SID, leader->signal->session);
 }
Index: linux-2.6.15-rc1/kernel/posix-cpu-timers.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/posix-cpu-timers.c
+++ linux-2.6.15-rc1/kernel/posix-cpu-timers.c
@@ -22,7 +22,8 @@ static int check_clock(clockid_t which_c
 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
 	if (!p || (CPUCLOCK_PERTHREAD(which_clock) ?
-		   p->tgid != current->tgid : p->tgid != pid)) {
+		   task_tgid(p) != task_tgid(current)
+		   : task_tgid(p) != pid)) {
 		error = -EINVAL;
 	}
 	read_unlock(&tasklist_lock);
@@ -238,7 +239,7 @@ static int cpu_clock_sample_group_locked
 		while ((t = next_thread(t)) != p) {
 			cpu->sched += t->sched_time;
 		}
-		if (p->tgid == current->tgid) {
+		if (task_tgid(p) == task_tgid(current)) {
 			/*
 			 * We're sampling ourselves, so include the
 			 * cycles not yet banked.  We still omit
@@ -306,11 +307,11 @@ int posix_cpu_clock_get(clockid_t which_
 		p = find_task_by_pid(pid);
 		if (p) {
 			if (CPUCLOCK_PERTHREAD(which_clock)) {
-				if (p->tgid == current->tgid) {
+				if (task_tgid(p) == task_tgid(current)) {
 					error = cpu_clock_sample(which_clock,
 								 p, &rtn);
 				}
-			} else if (p->tgid == pid && p->signal) {
+			} else if (task_tgid(p) == pid && p->signal) {
 				error = cpu_clock_sample_group(which_clock,
 							       p, &rtn);
 			}
@@ -348,7 +349,7 @@ int posix_cpu_timer_create(struct k_itim
 			p = current;
 		} else {
 			p = find_task_by_pid(pid);
-			if (p && p->tgid != current->tgid)
+			if (p && task_tgid(p) != task_tgid(current))
 				p = NULL;
 		}
 	} else {
@@ -356,7 +357,7 @@ int posix_cpu_timer_create(struct k_itim
 			p = current->group_leader;
 		} else {
 			p = find_task_by_pid(pid);
-			if (p && p->tgid != pid)
+			if (p && task_tgid(p) != pid)
 				p = NULL;
 		}
 	}
@@ -1423,7 +1424,7 @@ int posix_cpu_nsleep(clockid_t which_clo
 	 */
 	if (CPUCLOCK_PERTHREAD(which_clock) &&
 	    (CPUCLOCK_PID(which_clock) == 0 ||
-	     CPUCLOCK_PID(which_clock) == current->pid))
+	     CPUCLOCK_PID(which_clock) == task_pid(current)))
 		return -EINVAL;
 
 	/*
Index: linux-2.6.15-rc1/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc1/kernel/posix-timers.c
@@ -519,7 +519,7 @@ static inline struct task_struct * good_
 
 	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
 		(!(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
-		 rtn->tgid != current->tgid ||
+		 task_tgid(rtn) != task_tgid(current) ||
 		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
 		return NULL;
 
@@ -747,7 +747,8 @@ static struct k_itimer * lock_timer(time
 		spin_unlock(&idr_lock);
 
 		if ((timr->it_id != timer_id) || !(timr->it_process) ||
-				timr->it_process->tgid != current->tgid) {
+			task_tgid(timr->it_process) !=
+				task_tgid(current)) {
 			unlock_timer(timr, *flags);
 			timr = NULL;
 		}
Index: linux-2.6.15-rc1/kernel/ptrace.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/ptrace.c
+++ linux-2.6.15-rc1/kernel/ptrace.c
@@ -153,7 +153,7 @@ int ptrace_attach(struct task_struct *ta
 	int retval;
 	task_lock(task);
 	retval = -EPERM;
-	if (task->pid <= 1)
+	if (task_pid(task) <= 1)
 		goto bad;
 	if (task->tgid == current->tgid)
 		goto bad;
Index: linux-2.6.15-rc1/kernel/sched.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/sched.c
+++ linux-2.6.15-rc1/kernel/sched.c
@@ -1653,7 +1653,7 @@ asmlinkage void schedule_tail(task_t *pr
 	preempt_enable();
 #endif
 	if (current->set_child_tid)
-		put_user(current->pid, current->set_child_tid);
+		put_user(task_pid(current), current->set_child_tid);
 }
 
 /*
@@ -2961,7 +2961,7 @@ asmlinkage void __sched schedule(void)
 		if (unlikely(in_atomic())) {
 			printk(KERN_ERR "scheduling while atomic: "
 				"%s/0x%08x/%d\n",
-				current->comm, preempt_count(), current->pid);
+				current->comm, preempt_count(), task_pid(current));
 			dump_stack();
 		}
 	}
@@ -4333,17 +4333,18 @@ static void show_task(task_t *p)
 		free = (unsigned long) n - (unsigned long)(p->thread_info+1);
 	}
 #endif
-	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
+	printk("%5lu %5d %6d ", free, task_pid(p),
+				      task_pid(p->parent));
 	if ((relative = eldest_child(p)))
-		printk("%5d ", relative->pid);
+		printk("%5d ", task_pid(relative));
 	else
 		printk("      ");
 	if ((relative = younger_sibling(p)))
-		printk("%7d", relative->pid);
+		printk("%7d", task_pid(relative));
 	else
 		printk("       ");
 	if ((relative = older_sibling(p)))
-		printk(" %5d", relative->pid);
+		printk(" %5d", task_pid(relative));
 	else
 		printk("      ");
 	if (!p->mm)
@@ -4623,7 +4624,7 @@ static void move_task_off_dead_cpu(int d
 		if (tsk->mm && printk_ratelimit())
 			printk(KERN_INFO "process %d (%s) no "
 			       "longer affine to cpu%d\n",
-			       tsk->pid, tsk->comm, dead_cpu);
+			       task_pid(tsk), tsk->comm, dead_cpu);
 	}
 	__migrate_task(tsk, dead_cpu, dest_cpu);
 }
Index: linux-2.6.15-rc1/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/signal.c
+++ linux-2.6.15-rc1/kernel/signal.c
@@ -809,7 +809,7 @@ static int send_signal(int sig, struct s
 			q->info.si_signo = sig;
 			q->info.si_errno = 0;
 			q->info.si_code = SI_USER;
-			q->info.si_pid = current->pid;
+			q->info.si_pid = task_pid(current);
 			q->info.si_uid = current->uid;
 			break;
 		case (unsigned long) SEND_SIG_PRIV:
@@ -946,7 +946,7 @@ __group_complete_signal(int sig, struct 
 		if (t == NULL)
 			/* restart balancing at this thread */
 			t = p->signal->curr_target = p;
-		BUG_ON(t->tgid != p->tgid);
+		BUG_ON(task_tgid(t) != task_tgid(p));
 
 		while (!wants_signal(sig, t)) {
 			t = next_thread(t);
@@ -1208,7 +1208,7 @@ static int kill_something_info(int sig, 
 
 		read_lock(&tasklist_lock);
 		for_each_process(p) {
-			if (p->pid > 1 && p->tgid != current->tgid) {
+			if (task_pid(p) > 1 && task_tgid(p) != task_tgid(current)) {
 				int err = group_send_sig_info(sig, info, p);
 				++count;
 				if (err != -EPERM)
@@ -1478,7 +1478,7 @@ void do_notify_parent(struct task_struct
 
 	info.si_signo = sig;
 	info.si_errno = 0;
-	info.si_pid = tsk->pid;
+	info.si_pid = task_pid(tsk);
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
@@ -1543,7 +1543,7 @@ static void do_notify_parent_cldstop(str
 
 	info.si_signo = SIGCHLD;
 	info.si_errno = 0;
-	info.si_pid = tsk->pid;
+	info.si_pid = task_pid(tsk);
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
@@ -1646,7 +1646,7 @@ void ptrace_notify(int exit_code)
 	memset(&info, 0, sizeof info);
 	info.si_signo = SIGTRAP;
 	info.si_code = exit_code;
-	info.si_pid = current->pid;
+	info.si_pid = task_pid(current);
 	info.si_uid = current->uid;
 
 	/* Let the debugger run.  */
@@ -1871,7 +1871,7 @@ relock:
 				info->si_signo = signr;
 				info->si_errno = 0;
 				info->si_code = SI_USER;
-				info->si_pid = current->parent->pid;
+				info->si_pid = task_pid(current->parent);
 				info->si_uid = current->parent->uid;
 			}
 
@@ -1902,7 +1902,7 @@ relock:
 			continue;
 
 		/* Init gets no signals it doesn't want.  */
-		if (current->pid == 1)
+		if (task_pid(current) == 1)
 			continue;
 
 		if (sig_kernel_stop(signr)) {
@@ -2254,7 +2254,7 @@ sys_kill(int pid, int sig)
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_code = SI_USER;
-	info.si_pid = current->tgid;
+	info.si_pid = task_tgid(current);
 	info.si_uid = current->uid;
 
 	return kill_something_info(sig, &info, pid);
@@ -2270,12 +2270,12 @@ static int do_tkill(int tgid, int pid, i
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_code = SI_TKILL;
-	info.si_pid = current->tgid;
+	info.si_pid = task_tgid(current);
 	info.si_uid = current->uid;
 
 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
-	if (p && (tgid <= 0 || p->tgid == tgid)) {
+	if (p && (tgid <= 0 || task_tgid(p) == tgid)) {
 		error = check_kill_permission(sig, &info, p);
 		/*
 		 * The null signal is a permissions and process existence
Index: linux-2.6.15-rc1/kernel/stop_machine.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/stop_machine.c
+++ linux-2.6.15-rc1/kernel/stop_machine.c
@@ -91,7 +91,7 @@ static int stop_machine(void)
 
 	/* One high-prio thread per cpu.  We'll do this one. */
 	set_fs(KERNEL_DS);
-	sys_sched_setscheduler(current->pid, SCHED_FIFO,
+	sys_sched_setscheduler(task_pid(current), SCHED_FIFO,
 				(struct sched_param __user *)&param);
 	set_fs(old_fs);
 
Index: linux-2.6.15-rc1/kernel/sys.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/sys.c
+++ linux-2.6.15-rc1/kernel/sys.c
@@ -267,7 +267,7 @@ asmlinkage long sys_setpriority(int whic
 	switch (which) {
 		case PRIO_PROCESS:
 			if (!who)
-				who = current->pid;
+				who = task_pid(current);
 			p = find_task_by_pid(who);
 			if (p)
 				error = set_one_prio(p, niceval, error);
@@ -320,7 +320,7 @@ asmlinkage long sys_getpriority(int whic
 	switch (which) {
 		case PRIO_PROCESS:
 			if (!who)
-				who = current->pid;
+				who = task_pid(current);
 			p = find_task_by_pid(who);
 			if (p) {
 				niceval = 20 - task_nice(p);
@@ -1086,7 +1086,7 @@ asmlinkage long sys_setpgid(pid_t pid, p
 	int err = -EINVAL;
 
 	if (!pid)
-		pid = current->pid;
+		pid = task_pid(current);
 	if (!pgid)
 		pgid = pid;
 	if (pgid < 0)
@@ -1216,12 +1216,12 @@ asmlinkage long sys_setsid(void)
 	down(&tty_sem);
 	write_lock_irq(&tasklist_lock);
 
-	pid = find_pid(PIDTYPE_PGID, current->pid);
+	pid = find_pid(PIDTYPE_PGID, task_pid(current));
 	if (pid)
 		goto out;
 
 	current->signal->leader = 1;
-	__set_special_pids(current->pid, current->pid);
+	__set_special_pids(task_pid(current), task_pid(current));
 	current->signal->tty = NULL;
 	current->signal->tty_old_pgrp = 0;
 	err = process_group(current);
Index: linux-2.6.15-rc1/kernel/sysctl.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/sysctl.c
+++ linux-2.6.15-rc1/kernel/sysctl.c
@@ -1764,7 +1764,7 @@ int proc_dointvec_bset(ctl_table *table,
 		return -EPERM;
 	}
 
-	op = (current->pid == 1) ? OP_SET : OP_AND;
+	op = (task_pid(current) == 1) ? OP_SET : OP_AND;
 	return do_proc_dointvec(table,write,filp,buffer,lenp,ppos,
 				do_proc_dointvec_bset_conv,&op);
 }
Index: linux-2.6.15-rc1/kernel/timer.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/timer.c
+++ linux-2.6.15-rc1/kernel/timer.c
@@ -937,11 +937,11 @@ asmlinkage unsigned long sys_alarm(unsig
  * the pid are identical unless CLONE_THREAD was specified on clone() in
  * which case the tgid is the same in all threads of the same group.
  *
- * This is SMP safe as current->tgid does not change.
+ * This is SMP safe as task_tgid(current) does not change.
  */
 asmlinkage long sys_getpid(void)
 {
-	return current->tgid;
+	return task_tgid(current);
 }
 
 /*
@@ -968,7 +968,7 @@ asmlinkage long sys_getppid(void)
 
 	parent = me->group_leader->real_parent;
 	for (;;) {
-		pid = parent->tgid;
+		pid = task_tgid(parent);
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 {
 		struct task_struct *old = parent;
@@ -1115,7 +1115,7 @@ EXPORT_SYMBOL(schedule_timeout_uninterru
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
-	return current->pid;
+	return task_pid(current);
 }
 
 static long __sched nanosleep_restart(struct restart_block *restart)

--

