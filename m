Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267442AbUHPFlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267442AbUHPFlY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 01:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUHPFlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 01:41:24 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:48562 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S267442AbUHPFkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 01:40:43 -0400
Date: Sun, 15 Aug 2004 22:40:39 -0700
Message-Id: <200408160540.i7G5edJv005866@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] waitid system call
In-Reply-To: Roland McGrath's message of  Sunday, 15 August 2004 16:03:31 -0700 <200408152303.i7FN3Vc3021030@magilla.sf.frob.com>
X-Fcc: ~/Mail/linus
X-Windows: don't get frustrated without it.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version of the waitid patch that fixes some things that
people pointed out to me.  To do the 64->32 struct rusage field correctly,
I made the static function put_compat_rusage from linux/compat.c global and
swapped its argument order to match the other public functions of that form.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- vanilla-linux-2.6/arch/i386/kernel/entry.S	2004-05-22 22:03:15.000000000 -0700
+++ linux-2.6/arch/i386/kernel/entry.S	2004-07-12 14:03:36.000000000 -0700
@@ -886,5 +886,6 @@ ENTRY(sys_call_table)
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_waitid
 
 syscall_table_size=(.-sys_call_table)
--- vanilla-linux-2.6/arch/x86_64/ia32/ia32_signal.c	2004-07-13 11:02:33.000000000 -0700
+++ linux-2.6/arch/x86_64/ia32/ia32_signal.c	2004-08-15 18:58:27.000000000 -0700
@@ -74,6 +74,8 @@ int ia32_copy_siginfo_to_user(siginfo_t3
 			err |= __put_user(from->si_utime, &to->si_utime);
 			err |= __put_user(from->si_stime, &to->si_stime);
 			err |= __put_user(from->si_status, &to->si_status);
+			err |= put_compat_rusage(&from->si_rusage,
+						 &to->si_rusage);
 		default:
 		case __SI_KILL >> 16:
 			err |= __put_user(from->si_uid, &to->si_uid);
--- vanilla-linux-2.6/arch/x86_64/ia32/ia32entry.S	2004-05-30 11:55:13.000000000 -0700
+++ linux-2.6/arch/x86_64/ia32/ia32entry.S	2004-08-09 23:56:06.000000000 -0700
@@ -589,6 +589,7 @@ ia32_sys_call_table:
 	.quad compat_sys_mq_notify
 	.quad compat_sys_mq_getsetattr
 	.quad quiet_ni_syscall		/* reserved for kexec */
+	.quad sys32_waitid
 	/* don't forget to change IA32_NR_syscalls */
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
--- vanilla-linux-2.6/arch/x86_64/ia32/sys_ia32.c	2004-07-30 22:49:36.000000000 -0700
+++ linux-2.6/arch/x86_64/ia32/sys_ia32.c	2004-08-11 12:01:41.000000000 -0700
@@ -1151,6 +1151,25 @@ asmlinkage long sys32_clone(unsigned int
 		    parent_tid, child_tid);
 }
 
+asmlinkage long sys32_waitid(int which, compat_pid_t pid,
+			     siginfo_t32 __user *uinfo, int options)
+{
+	siginfo_t info;
+	long ret;
+	mm_segment_t old_fs = get_fs();
+
+	info.si_signo = 0;
+	set_fs (KERNEL_DS);
+	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options);
+	set_fs (old_fs);
+
+	if (ret < 0 || info.si_signo == 0)
+		return ret;
+	BUG_ON(info.si_code & __SI_MASK);
+	info.si_code |= __SI_CHLD;
+	return ia32_copy_siginfo_to_user(uinfo, &info);
+}
+
 /*
  * Some system calls that need sign extended arguments. This could be done by a generic wrapper.
  */ 
--- vanilla-linux-2.6/include/asm-generic/siginfo.h	2004-07-13 11:02:33.000000000 -0700
+++ linux-2.6/include/asm-generic/siginfo.h	2004-07-15 14:20:56.000000000 -0700
@@ -3,6 +3,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/resource.h>
 
 typedef union sigval {
 	int sival_int;
@@ -74,6 +75,7 @@ typedef struct siginfo {
 			int _status;		/* exit code */
 			clock_t _utime;
 			clock_t _stime;
+			struct rusage _rusage;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
@@ -105,6 +107,7 @@ typedef struct siginfo {
 #define si_status	_sifields._sigchld._status
 #define si_utime	_sifields._sigchld._utime
 #define si_stime	_sifields._sigchld._stime
+#define si_rusage	_sifields._sigchld._rusage
 #define si_value	_sifields._rt._sigval
 #define si_int		_sifields._rt._sigval.sival_int
 #define si_ptr		_sifields._rt._sigval.sival_ptr
--- vanilla-linux-2.6/include/asm-i386/unistd.h	2004-08-02 10:14:04.000000000 -0700
+++ linux-2.6/include/asm-i386/unistd.h	2004-08-04 00:18:53.000000000 -0700
@@ -289,8 +289,9 @@
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
+#define __NR_waitid		284
 
-#define NR_syscalls 284
+#define NR_syscalls 285
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
--- vanilla-linux-2.6/include/asm-x86_64/ia32.h	2004-05-30 20:07:42.000000000 -0700
+++ linux-2.6/include/asm-x86_64/ia32.h	2004-08-09 21:13:30.000000000 -0700
@@ -121,6 +121,7 @@ typedef struct siginfo32 {
 			int _status;		/* exit code */
 			compat_clock_t _utime;
 			compat_clock_t _stime;
+			struct compat_rusage _rusage;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
--- vanilla-linux-2.6/include/asm-x86_64/ia32_unistd.h	2004-05-30 11:55:13.000000000 -0700
+++ linux-2.6/include/asm-x86_64/ia32_unistd.h	2004-07-26 17:59:32.000000000 -0700
@@ -289,6 +289,7 @@
 #define __NR_ia32_mq_notify		(__NR_ia32_mq_open+4)
 #define __NR_ia32_mq_getsetattr	(__NR_ia32_mq_open+5)
 #define __NR_ia32_kexec		283
+#define __NR_ia32_waitid	284
 
 #define IA32_NR_syscalls 287	/* must be > than biggest syscall! */
 
--- vanilla-linux-2.6/include/asm-x86_64/unistd.h	2004-06-09 08:17:36.000000000 -0700
+++ linux-2.6/include/asm-x86_64/unistd.h	2004-07-26 15:44:13.000000000 -0700
@@ -554,8 +554,10 @@ __SYSCALL(__NR_mq_notify, sys_mq_notify)
 __SYSCALL(__NR_mq_getsetattr, sys_mq_getsetattr)
 #define __NR_kexec_load 	246
 __SYSCALL(__NR_kexec_load, sys_ni_syscall)
+#define __NR_waitid	 	247
+__SYSCALL(__NR_waitid, sys_waitid)
 
-#define __NR_syscall_max __NR_kexec_load
+#define __NR_syscall_max __NR_waitid
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
--- vanilla-linux-2.6/include/linux/compat.h	2004-05-29 11:15:01.000000000 -0700
+++ linux-2.6/include/linux/compat.h	2004-08-15 21:15:59.791627829 -0700
@@ -79,6 +79,8 @@ struct compat_rusage {
 	compat_long_t	ru_nivcsw;
 };
 
+extern int put_compat_rusage(const struct rusage *, struct compat_rusage __user *);
+
 struct compat_dirent {
 	u32		d_ino;
 	compat_off_t	d_off;
--- vanilla-linux-2.6/include/linux/sched.h	2004-07-28 23:13:51.000000000 -0700
+++ linux-2.6/include/linux/sched.h	2004-08-05 13:46:40.000000000 -0700
@@ -268,6 +268,8 @@ struct signal_struct {
 
 	/* thread group stop support, overloads group_exit_code too */
 	int			group_stop_count;
+	/* 1 if group stopped since last SIGCONT, -1 if SIGCONT since report */
+  	int			stop_state;
 
 	/* POSIX.1b Interval Timers */
 	struct list_head posix_timers;
--- vanilla-linux-2.6/include/linux/syscalls.h	2004-06-22 08:27:43.000000000 -0700
+++ linux-2.6/include/linux/syscalls.h	2004-08-09 23:44:22.000000000 -0700
@@ -162,6 +162,8 @@ asmlinkage long sys_exit(int error_code)
 asmlinkage void sys_exit_group(int error_code);
 asmlinkage long sys_wait4(pid_t pid, unsigned int __user *stat_addr,
 				int options, struct rusage __user *ru);
+asmlinkage long sys_waitid(int which, pid_t pid,
+			   	struct siginfo __user *infop, int options);
 asmlinkage long sys_waitpid(pid_t pid, unsigned int __user *stat_addr, int options);
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
--- vanilla-linux-2.6/include/linux/wait.h	2004-06-24 08:54:26.000000000 -0700
+++ linux-2.6/include/linux/wait.h	2004-07-01 22:56:27.000000000 -0700
@@ -3,11 +3,20 @@
 
 #define WNOHANG		0x00000001
 #define WUNTRACED	0x00000002
+#define WSTOPPED	WUNTRACED
+#define WEXITED		0x00000004
+#define WCONTINUED	0x00000008
+#define WNOWAIT		0x01000000	/* Don't reap, just poll status.  */
 
 #define __WNOTHREAD	0x20000000	/* Don't wait on children of other threads in this group */
 #define __WALL		0x40000000	/* Wait on all children, regardless of type */
 #define __WCLONE	0x80000000	/* Wait only on non-SIGCHLD children */
 
+/* First argument to waitid: */
+#define P_ALL		0
+#define P_PID		1
+#define P_PGID		2
+
 #ifdef __KERNEL__
 
 #include <linux/config.h>
--- vanilla-linux-2.6/kernel/compat.c	2004-07-28 22:57:26.000000000 -0700
+++ linux-2.6/kernel/compat.c	2004-08-15 19:13:15.000000000 -0700
@@ -310,7 +310,7 @@ asmlinkage long compat_sys_getrlimit (un
 	return ret;
 }
 
-static long put_compat_rusage(struct compat_rusage __user *ru, struct rusage *r)
+int put_compat_rusage(const struct rusage *r, struct compat_rusage __user *ru)
 {
 	if (!access_ok(VERIFY_WRITE, ru, sizeof(*ru)) ||
 	    __put_user(r->ru_utime.tv_sec, &ru->ru_utime.tv_sec) ||
@@ -348,7 +348,7 @@ asmlinkage long compat_sys_getrusage(int
 	if (ret)
 		return ret;
 
-	if (put_compat_rusage(ru, &r))
+	if (put_compat_rusage(&r, ru))
 		return -EFAULT;
 
 	return 0;
@@ -374,7 +374,7 @@ compat_sys_wait4(compat_pid_t pid, compa
 		set_fs (old_fs);
 
 		if (ret > 0) {
-			if (put_compat_rusage(ru, &r)) 
+			if (put_compat_rusage(&r, ru))
 				return -EFAULT;
 			if (stat_addr && put_user(status, stat_addr))
 				return -EFAULT;
--- vanilla-linux-2.6/kernel/exit.c	2004-07-17 21:51:57.000000000 -0700
+++ linux-2.6/kernel/exit.c	2004-08-15 19:13:54.000000000 -0700
@@ -967,16 +967,64 @@ static int eligible_child(pid_t pid, int
 	return 1;
 }
 
+static int wait_noreap_copyout(task_t *p, pid_t pid, uid_t uid,
+			       int why, int status,
+			       struct siginfo __user *infop)
+{
+	int retval = getrusage(p, RUSAGE_BOTH, &infop->si_rusage);
+	put_task_struct(p);
+	if (!retval)
+		retval = put_user(SIGCHLD, &infop->si_signo);
+	if (!retval)
+		retval = put_user(0, &infop->si_errno);
+	if (!retval)
+		retval = put_user((short)why, &infop->si_code);
+	if (!retval)
+		retval = put_user(pid, &infop->si_pid);
+	if (!retval)
+		retval = put_user(uid, &infop->si_uid);
+	if (!retval)
+		retval = put_user(status, &infop->si_status);
+	if (!retval)
+		retval = pid;
+	return retval;
+}
+
 /*
  * Handle sys_wait4 work for one task in state TASK_ZOMBIE.  We hold
  * read_lock(&tasklist_lock) on entry.  If we return zero, we still hold
  * the lock and this task is uninteresting.  If we return nonzero, we have
  * released the lock and the system call should return.
  */
-static int wait_task_zombie(task_t *p, unsigned int __user *stat_addr, struct rusage __user *ru)
+static int wait_task_zombie(task_t *p, int noreap,
+			    struct siginfo __user *infop,
+			    int __user *stat_addr, struct rusage __user *ru)
 {
 	unsigned long state;
 	int retval;
+	int status;
+
+	if (unlikely(noreap)) {
+		pid_t pid = p->pid;
+		uid_t uid = p->uid;
+		int exit_code = p->exit_code;
+		int why, status;
+		if (unlikely(p->state != TASK_ZOMBIE))
+			return 0;
+		if (unlikely(p->exit_signal == -1 && p->ptrace == 0))
+			return 0;
+		get_task_struct(p);
+		read_unlock(&tasklist_lock);
+		if ((exit_code & 0x7f) == 0) {
+			why = CLD_EXITED;
+			status = exit_code >> 8;
+		}
+		else {
+			why = (exit_code & 0x80) ? CLD_DUMPED : CLD_KILLED;
+			status = exit_code & 0x7f;
+		}
+		return wait_noreap_copyout(p, pid, uid, why, status, infop);
+	}
 
 	/*
 	 * Try to move the task's state to DEAD
@@ -1001,12 +1049,32 @@ static int wait_task_zombie(task_t *p, u
 	read_unlock(&tasklist_lock);
 
 	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
-	if (!retval && stat_addr) {
-		if (p->signal->group_exit)
-			retval = put_user(p->signal->group_exit_code, stat_addr);
-		else
-			retval = put_user(p->exit_code, stat_addr);
-	}
+	status = p->signal->group_exit
+		? p->signal->group_exit_code : p->exit_code;
+	if (!retval && stat_addr)
+		retval = put_user(status, stat_addr);
+	if (!retval && infop)
+		retval = put_user(SIGCHLD, &infop->si_signo);
+	if (!retval && infop)
+		retval = put_user(0, &infop->si_errno);
+	if (!retval && infop) {
+		int why;
+		if ((status & 0x7f) == 0) {
+			why = CLD_EXITED;
+			status >>= 8;
+		}
+		else {
+			why = (status & 0x80) ? CLD_DUMPED : CLD_KILLED;
+			status &= 0x7f;
+		}
+		retval = put_user((short)why, &infop->si_code);
+		if (!retval)
+			retval = put_user(status, &infop->si_status);
+	}
+	if (!retval && infop)
+		retval = put_user(p->pid, &infop->si_pid);
+	if (!retval && infop)
+		retval = put_user(p->uid, &infop->si_uid);
 	if (retval) {
 		p->state = TASK_ZOMBIE;
 		return retval;
@@ -1042,9 +1110,9 @@ static int wait_task_zombie(task_t *p, u
  * the lock and this task is uninteresting.  If we return nonzero, we have
  * released the lock and the system call should return.
  */
-static int wait_task_stopped(task_t *p, int delayed_group_leader,
-			     unsigned int __user *stat_addr,
-			     struct rusage __user *ru)
+static int wait_task_stopped(task_t *p, int delayed_group_leader, int noreap,
+			     struct siginfo __user *infop,
+			     int __user *stat_addr, struct rusage __user *ru)
 {
 	int retval, exit_code;
 
@@ -1067,6 +1135,20 @@ static int wait_task_stopped(task_t *p, 
 	 */
 	get_task_struct(p);
 	read_unlock(&tasklist_lock);
+
+	if (unlikely(noreap)) {
+		pid_t pid = p->pid;
+		uid_t uid = p->uid;
+		int why = (p->ptrace & PT_PTRACED) ? CLD_TRAPPED : CLD_STOPPED;
+		exit_code = p->exit_code;
+		if (unlikely(!exit_code) ||
+		    unlikely(p->state > TASK_STOPPED))
+			goto bail_ref;
+		return wait_noreap_copyout(p, pid, uid,
+					   why, (exit_code << 8) | 0x7f,
+					   infop);
+	}
+
 	write_lock_irq(&tasklist_lock);
 
 	/*
@@ -1092,6 +1174,7 @@ static int wait_task_stopped(task_t *p, 
 		 * resumed, or it resumed and then died.
 		 */
 		write_unlock_irq(&tasklist_lock);
+	bail_ref:
 		put_task_struct(p);
 		read_lock(&tasklist_lock);
 		return 0;
@@ -1106,6 +1189,20 @@ static int wait_task_stopped(task_t *p, 
 	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
 	if (!retval && stat_addr)
 		retval = put_user((exit_code << 8) | 0x7f, stat_addr);
+	if (!retval && infop)
+		retval = put_user(SIGCHLD, &infop->si_signo);
+	if (!retval && infop)
+		retval = put_user(0, &infop->si_errno);
+	if (!retval && infop)
+		retval = put_user((short)((p->ptrace & PT_PTRACED)
+					  ? CLD_TRAPPED : CLD_STOPPED),
+				  &infop->si_code);
+	if (!retval && infop)
+		retval = put_user(exit_code, &infop->si_status);
+	if (!retval && infop)
+		retval = put_user(p->pid, &infop->si_pid);
+	if (!retval && infop)
+		retval = put_user(p->uid, &infop->si_uid);
 	if (!retval)
 		retval = p->pid;
 	put_task_struct(p);
@@ -1114,15 +1211,13 @@ static int wait_task_stopped(task_t *p, 
 	return retval;
 }
 
-asmlinkage long sys_wait4(pid_t pid,unsigned int __user *stat_addr, int options, struct rusage __user *ru)
+static long do_wait(pid_t pid, int options, struct siginfo __user *infop,
+		    int __user *stat_addr, struct rusage __user *ru)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct task_struct *tsk;
 	int flag, retval;
 
-	if (options & ~(WNOHANG|WUNTRACED|__WNOTHREAD|__WCLONE|__WALL))
-		return -EINVAL;
-
 	add_wait_queue(&current->wait_chldexit,&wait);
 repeat:
 	flag = 0;
@@ -1148,19 +1243,52 @@ repeat:
 				    !(p->ptrace & PT_PTRACED))
 					continue;
 				retval = wait_task_stopped(p, ret == 2,
+							   (options & WNOWAIT),
+							   infop,
 							   stat_addr, ru);
 				if (retval != 0) /* He released the lock.  */
-					goto end_wait4;
+					goto end;
 				break;
 			case TASK_ZOMBIE:
 				/*
 				 * Eligible but we cannot release it yet:
 				 */
 				if (ret == 2)
+					goto check_continued;
+				if (!likely(options & WEXITED))
 					continue;
-				retval = wait_task_zombie(p, stat_addr, ru);
+				retval = wait_task_zombie(
+					p, (options & WNOWAIT),
+					infop, stat_addr, ru);
 				if (retval != 0) /* He released the lock.  */
-					goto end_wait4;
+					goto end;
+				break;
+			case TASK_DEAD:
+				continue;
+			default:
+			check_continued:
+				if (!unlikely(options & WCONTINUED))
+					continue;
+				if (unlikely(!p->signal))
+					continue;
+				spin_lock_irq(&p->sighand->siglock);
+				if (p->signal->stop_state < 0) {
+					pid_t pid;
+					uid_t uid;
+					if (!(options & WNOWAIT))
+						p->signal->stop_state = 0;
+					spin_unlock_irq(&p->sighand->siglock);
+					pid = p->pid;
+					uid = p->uid;
+					get_task_struct(p);
+					read_unlock(&tasklist_lock);
+					retval = wait_noreap_copyout(
+						p, pid, uid,
+						CLD_CONTINUED, SIGCONT, infop);
+					BUG_ON(retval == 0);
+					goto end;
+				}
+				spin_unlock_irq(&p->sighand->siglock);
 				break;
 			}
 		}
@@ -1183,20 +1311,57 @@ repeat:
 	if (flag) {
 		retval = 0;
 		if (options & WNOHANG)
-			goto end_wait4;
+			goto end;
 		retval = -ERESTARTSYS;
 		if (signal_pending(current))
-			goto end_wait4;
+			goto end;
 		schedule();
 		goto repeat;
 	}
 	retval = -ECHILD;
-end_wait4:
+ end:
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&current->wait_chldexit,&wait);
+	if (infop && retval > 0)
+		retval = 0;
 	return retval;
 }
 
+asmlinkage long sys_waitid(int which, pid_t pid,
+			   struct siginfo __user *infop, int options)
+{
+	if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED))
+		return -EINVAL;
+	if (!(options & (WEXITED|WSTOPPED|WCONTINUED)))
+		return -EINVAL;
+
+	switch (which) {
+	case P_ALL:
+		pid = -1;
+		break;
+	case P_PID:
+		if (pid <= 0)
+			return -EINVAL;
+		break;
+	case P_PGID:
+		if (pid <= 0)
+			return -EINVAL;
+		pid = -pid;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return do_wait(pid, options, infop, NULL, &infop->si_rusage);
+}
+
+asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru)
+{
+	if (options & ~(WNOHANG|WUNTRACED|__WNOTHREAD|__WCLONE|__WALL))
+		return -EINVAL;
+	return do_wait(pid, options | WEXITED, NULL, stat_addr, ru);
+}
+
 #ifdef __ARCH_WANT_SYS_WAITPID
 
 /*
--- vanilla-linux-2.6/kernel/signal.c	2004-07-06 23:25:36.000000000 -0700
+++ linux-2.6/kernel/signal.c	2004-08-05 14:49:46.000000000 -0700
@@ -26,6 +26,8 @@
 #include <asm/unistd.h>
 #include <asm/siginfo.h>
 
+extern void k_getrusage(struct task_struct *, int, struct rusage *);
+
 /*
  * SLAB caches for signal bits.
  */
@@ -660,6 +662,7 @@ static void handle_stop_signal(int sig, 
 			 * the SIGCHLD was pending on entry to this kill.
 			 */
 			p->signal->group_stop_count = 0;
+			p->signal->stop_state = 1;
 			if (p->ptrace & PT_PTRACED)
 				do_notify_parent_cldstop(p, p->parent);
 			else
@@ -696,6 +699,21 @@ static void handle_stop_signal(int sig, 
 
 			t = next_thread(t);
 		} while (t != p);
+
+		if (p->signal->stop_state > 0) {
+			/*
+			 * We were in fact stopped, and are now continued.
+			 * Notify the parent with CLD_CONTINUED.
+			 */
+			p->signal->stop_state = -1;
+			p->signal->group_exit_code = 0;
+			if (p->ptrace & PT_PTRACED)
+				do_notify_parent_cldstop(p, p->parent);
+			else
+				do_notify_parent_cldstop(
+					p->group_leader,
+					p->group_leader->real_parent);
+		}
 	}
 }
 
@@ -1447,6 +1465,7 @@ void do_notify_parent(struct task_struct
 	/* FIXME: find out whether or not this is supposed to be c*time. */
 	info.si_utime = tsk->utime;
 	info.si_stime = tsk->stime;
+	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
 	status = tsk->exit_code & 0x7f;
 	why = SI_KERNEL;	/* shouldn't happen */
@@ -1536,9 +1555,16 @@ do_notify_parent_cldstop(struct task_str
 	/* FIXME: find out whether or not this is supposed to be c*time. */
 	info.si_utime = tsk->utime;
 	info.si_stime = tsk->stime;
+	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
-	info.si_status = tsk->exit_code & 0x7f;
-	info.si_code = CLD_STOPPED;
+	info.si_status = (tsk->signal ? tsk->signal->group_exit_code :
+			  tsk->exit_code) & 0x7f;
+	if (info.si_status == 0) {
+		info.si_status = SIGCONT;
+		info.si_code = CLD_CONTINUED;
+	}
+	else
+		info.si_code = CLD_STOPPED;
 
 	sighand = parent->sighand;
 	spin_lock_irqsave(&sighand->siglock, flags);
@@ -1604,14 +1630,17 @@ do_signal_stop(int signr)
 		stop_count = --sig->group_stop_count;
 		current->exit_code = signr;
 		set_current_state(TASK_STOPPED);
+		if (stop_count == 0)
+			sig->stop_state = 1;
 		spin_unlock_irq(&sighand->siglock);
 	}
 	else if (thread_group_empty(current)) {
 		/*
 		 * Lock must be held through transition to stopped state.
 		 */
-		current->exit_code = signr;
+		current->exit_code = current->signal->group_exit_code = signr;
 		set_current_state(TASK_STOPPED);
+		sig->stop_state = 1;
 		spin_unlock_irq(&sighand->siglock);
 	}
 	else {
@@ -1677,6 +1706,8 @@ do_signal_stop(int signr)
 
 		current->exit_code = signr;
 		set_current_state(TASK_STOPPED);
+		if (stop_count == 0)
+			sig->stop_state = 1;
 
 		spin_unlock_irq(&sighand->siglock);
 		read_unlock(&tasklist_lock);
@@ -1717,6 +1748,8 @@ static inline int handle_group_stop(void
 	 * without any associated signal being in our queue.
 	 */
 	stop_count = --current->signal->group_stop_count;
+	if (stop_count == 0)
+		current->signal->stop_state = 1;
 	current->exit_code = current->signal->group_exit_code;
 	set_current_state(TASK_STOPPED);
 	spin_unlock_irq(&current->sighand->siglock);
@@ -2071,6 +2104,8 @@ int copy_siginfo_to_user(siginfo_t __use
 		err |= __put_user(from->si_status, &to->si_status);
 		err |= __put_user(from->si_utime, &to->si_utime);
 		err |= __put_user(from->si_stime, &to->si_stime);
+		err |= __copy_to_user(&to->si_rusage, &from->si_rusage,
+				      sizeof(to->si_rusage));
 		break;
 	case __SI_RT: /* This is not generated by the kernel as of now. */
 	case __SI_MESGQ: /* But this is */
--- vanilla-linux-2.6/kernel/sys.c	2004-06-01 08:35:45.000000000 -0700
+++ linux-2.6/kernel/sys.c	2004-08-04 01:10:51.000000000 -0700
@@ -1540,37 +1540,43 @@ asmlinkage long sys_setrlimit(unsigned i
  * reaped till shortly after the call to getrusage(), in both cases the
  * task being examined is in a frozen state so the counters won't change.
  */
-int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
-{
-	struct rusage r;
 
-	memset((char *) &r, 0, sizeof(r));
+
+void k_getrusage(struct task_struct *p, int who, struct rusage *r)
+{
+	memset((char *) r, 0, sizeof *r);
 	switch (who) {
 		case RUSAGE_SELF:
-			jiffies_to_timeval(p->utime, &r.ru_utime);
-			jiffies_to_timeval(p->stime, &r.ru_stime);
-			r.ru_nvcsw = p->nvcsw;
-			r.ru_nivcsw = p->nivcsw;
-			r.ru_minflt = p->min_flt;
-			r.ru_majflt = p->maj_flt;
+			jiffies_to_timeval(p->utime, &r->ru_utime);
+			jiffies_to_timeval(p->stime, &r->ru_stime);
+			r->ru_nvcsw = p->nvcsw;
+			r->ru_nivcsw = p->nivcsw;
+			r->ru_minflt = p->min_flt;
+			r->ru_majflt = p->maj_flt;
 			break;
 		case RUSAGE_CHILDREN:
-			jiffies_to_timeval(p->cutime, &r.ru_utime);
-			jiffies_to_timeval(p->cstime, &r.ru_stime);
-			r.ru_nvcsw = p->cnvcsw;
-			r.ru_nivcsw = p->cnivcsw;
-			r.ru_minflt = p->cmin_flt;
-			r.ru_majflt = p->cmaj_flt;
+			jiffies_to_timeval(p->cutime, &r->ru_utime);
+			jiffies_to_timeval(p->cstime, &r->ru_stime);
+			r->ru_nvcsw = p->cnvcsw;
+			r->ru_nivcsw = p->cnivcsw;
+			r->ru_minflt = p->cmin_flt;
+			r->ru_majflt = p->cmaj_flt;
 			break;
 		default:
-			jiffies_to_timeval(p->utime + p->cutime, &r.ru_utime);
-			jiffies_to_timeval(p->stime + p->cstime, &r.ru_stime);
-			r.ru_nvcsw = p->nvcsw + p->cnvcsw;
-			r.ru_nivcsw = p->nivcsw + p->cnivcsw;
-			r.ru_minflt = p->min_flt + p->cmin_flt;
-			r.ru_majflt = p->maj_flt + p->cmaj_flt;
+			jiffies_to_timeval(p->utime + p->cutime, &r->ru_utime);
+			jiffies_to_timeval(p->stime + p->cstime, &r->ru_stime);
+			r->ru_nvcsw = p->nvcsw + p->cnvcsw;
+			r->ru_nivcsw = p->nivcsw + p->cnivcsw;
+			r->ru_minflt = p->min_flt + p->cmin_flt;
+			r->ru_majflt = p->maj_flt + p->cmaj_flt;
 			break;
 	}
+}
+
+int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
+{
+	struct rusage r;
+	k_getrusage(p, who, &r);
 	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 }
