Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUIPBbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUIPBbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267440AbUIPBbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 21:31:24 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:19385 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S267372AbUIPBap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 21:30:45 -0400
Date: Wed, 15 Sep 2004 18:30:41 -0700
Message-Id: <200409160130.i8G1UftX019096@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: [PATCH] back out siginfo_t.si_rusage from waitid changes
In-Reply-To: Richard Henderson's message of  Tuesday, 14 September 2004 20:39:03 -0700 <20040915033903.GA904@twiddle.net>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I explained in the waitid patches, I added the si_rusage field to
siginfo_t with the idea of having the siginfo_t waitid fills in contain all
the information that wait4 or any such call could ever tell you.  Nowhere
in POSIX nor anywhere else specifies this field in siginfo_t.  

When Ulrich and I hashed out the system call interface we wanted, we looked
at siginfo_t and decided there was plenty of space to throw in si_rusage.
Well, it turns out we didn't check the 64-bit platforms.  There struct
rusage is ridiculously large (lots of longs for things that are never in a
million years going to hit 2^32), and my changes bumped up the size of
siginfo_t.  Changing that size is more trouble than it's worth.

This patch reverts the changes to the siginfo_t structure types,
and no longer provides the rusage details in SIGCHLD signal data.
Instead, I added a fifth argument to the waitid system call to fill in rusage.

waitid is the name of the POSIX function with four arguments.  It might
make sense to rename the system call `waitsys' to follow SGI's system call
with the same arguments, or `wait5' in the mindless tradition.  But, feh.
I just added the argument to sys_waitid, rather than worrying about
changing the name in all the tables (and choosing a new stupid name).


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

Index: linux-2.6/arch/sparc64/kernel/signal32.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/sparc64/kernel/signal32.c,v
retrieving revision 1.42
diff -B -b -p -u -r1.42 signal32.c
--- linux-2.6/arch/sparc64/kernel/signal32.c 2 Sep 2004 08:19:11 -0000 1.42
+++ linux-2.6/arch/sparc64/kernel/signal32.c 15 Sep 2004 18:38:55 -0000
@@ -122,7 +122,6 @@ struct siginfo32 {
 			int _status;			/* exit code */
 			compat_clock_t _utime;
 			compat_clock_t _stime;
-			struct compat_rusage _rusage;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
@@ -188,8 +187,6 @@ int copy_siginfo_to_user32(struct siginf
 			err |= __put_user(from->si_utime, &to->si_utime);
 			err |= __put_user(from->si_stime, &to->si_stime);
 			err |= __put_user(from->si_status, &to->si_status);
-			err |= put_compat_rusage(&from->si_rusage,
-						 &to->si_rusage);
 		default:
 			err |= __put_user(from->si_pid, &to->si_pid);
 			err |= __put_user(from->si_uid, &to->si_uid);
Index: linux-2.6/arch/x86_64/ia32/ia32_signal.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/x86_64/ia32/ia32_signal.c,v
retrieving revision 1.32
diff -B -b -p -u -r1.32 ia32_signal.c
--- linux-2.6/arch/x86_64/ia32/ia32_signal.c 11 Sep 2004 06:20:19 -0000 1.32
+++ linux-2.6/arch/x86_64/ia32/ia32_signal.c 15 Sep 2004 08:46:29 -0000
@@ -74,8 +74,6 @@ int ia32_copy_siginfo_to_user(siginfo_t3
 			err |= __put_user(from->si_utime, &to->si_utime);
 			err |= __put_user(from->si_stime, &to->si_stime);
 			err |= __put_user(from->si_status, &to->si_status);
-			err |= put_compat_rusage(&from->si_rusage,
-						 &to->si_rusage);
 		default:
 		case __SI_KILL >> 16:
 			err |= __put_user(from->si_uid, &to->si_uid);
Index: linux-2.6/include/asm-generic/siginfo.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/asm-generic/siginfo.h,v
retrieving revision 1.17
diff -B -b -p -u -r1.17 siginfo.h
--- linux-2.6/include/asm-generic/siginfo.h 31 Aug 2004 17:35:25 -0000 1.17
+++ linux-2.6/include/asm-generic/siginfo.h 15 Sep 2004 08:26:58 -0000
@@ -75,7 +75,6 @@ typedef struct siginfo {
 			int _status;		/* exit code */
 			clock_t _utime;
 			clock_t _stime;
-			struct rusage _rusage;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
@@ -107,7 +106,6 @@ typedef struct siginfo {
 #define si_status	_sifields._sigchld._status
 #define si_utime	_sifields._sigchld._utime
 #define si_stime	_sifields._sigchld._stime
-#define si_rusage	_sifields._sigchld._rusage
 #define si_value	_sifields._rt._sigval
 #define si_int		_sifields._rt._sigval.sival_int
 #define si_ptr		_sifields._rt._sigval.sival_ptr
Index: linux-2.6/include/asm-ia64/siginfo.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/asm-ia64/siginfo.h,v
retrieving revision 1.18
diff -B -b -p -u -r1.18 siginfo.h
--- linux-2.6/include/asm-ia64/siginfo.h 31 Aug 2004 17:35:25 -0000 1.18
+++ linux-2.6/include/asm-ia64/siginfo.h 15 Sep 2004 18:38:30 -0000
@@ -56,7 +56,6 @@ typedef struct siginfo {
 			int _status;		/* exit code */
 			clock_t _utime;
 			clock_t _stime;
-			struct rusage _rusage;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
Index: linux-2.6/include/asm-x86_64/ia32.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/asm-x86_64/ia32.h,v
retrieving revision 1.20
diff -B -b -p -u -r1.20 ia32.h
--- linux-2.6/include/asm-x86_64/ia32.h 31 Aug 2004 17:35:25 -0000 1.20
+++ linux-2.6/include/asm-x86_64/ia32.h 15 Sep 2004 18:38:24 -0000
@@ -115,7 +115,6 @@ typedef struct siginfo32 {
 			int _status;		/* exit code */
 			compat_clock_t _utime;
 			compat_clock_t _stime;
-			struct compat_rusage _rusage;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
Index: linux-2.6/kernel/exit.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/exit.c,v
retrieving revision 1.152
diff -B -b -p -u -r1.152 exit.c
--- linux-2.6/kernel/exit.c 8 Sep 2004 14:48:58 -0000 1.152
+++ linux-2.6/kernel/exit.c 15 Sep 2004 08:25:50 -0000
@@ -949,9 +949,10 @@ static int eligible_child(pid_t pid, int
 
 static int wait_noreap_copyout(task_t *p, pid_t pid, uid_t uid,
 			       int why, int status,
-			       struct siginfo __user *infop)
+			       struct siginfo __user *infop,
+			       struct rusage __user *rusagep)
 {
-	int retval = getrusage(p, RUSAGE_BOTH, &infop->si_rusage);
+	int retval = rusagep ? getrusage(p, RUSAGE_BOTH, rusagep) : 0;
 	put_task_struct(p);
 	if (!retval)
 		retval = put_user(SIGCHLD, &infop->si_signo);
@@ -1003,7 +1004,8 @@ static int wait_task_zombie(task_t *p, i
 			why = (exit_code & 0x80) ? CLD_DUMPED : CLD_KILLED;
 			status = exit_code & 0x7f;
 		}
-		return wait_noreap_copyout(p, pid, uid, why, status, infop);
+		return wait_noreap_copyout(p, pid, uid, why,
+					   status, infop, ru);
 	}
 
 	/*
@@ -1161,7 +1163,7 @@ static int wait_task_stopped(task_t *p, 
 			goto bail_ref;
 		return wait_noreap_copyout(p, pid, uid,
 					   why, (exit_code << 8) | 0x7f,
-					   infop);
+					   infop, ru);
 	}
 
 	write_lock_irq(&tasklist_lock);
@@ -1304,7 +1306,7 @@ check_continued:
 					read_unlock(&tasklist_lock);
 					retval = wait_noreap_copyout(p, pid,
 							uid, CLD_CONTINUED,
-							SIGCONT, infop);
+							SIGCONT, infop, ru);
 					BUG_ON(retval == 0);
 					goto end;
 				}
@@ -1371,7 +1373,8 @@ end:
 }
 
 asmlinkage long sys_waitid(int which, pid_t pid,
-			   struct siginfo __user *infop, int options)
+			   struct siginfo __user *infop, int options,
+			   struct rusage __user *ru)
 {
 	if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED))
 		return -EINVAL;
@@ -1395,7 +1398,7 @@ asmlinkage long sys_waitid(int which, pi
 		return -EINVAL;
 	}
 
-	return do_wait(pid, options, infop, NULL, &infop->si_rusage);
+	return do_wait(pid, options, infop, NULL, ru);
 }
 
 asmlinkage long sys_wait4(pid_t pid, unsigned int __user *stat_addr,
Index: linux-2.6/kernel/signal.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/signal.c,v
retrieving revision 1.138
diff -B -b -p -u -r1.138 signal.c
--- linux-2.6/kernel/signal.c 8 Sep 2004 14:48:58 -0000 1.138
+++ linux-2.6/kernel/signal.c 15 Sep 2004 08:26:18 -0000
@@ -1500,7 +1500,6 @@ void do_notify_parent(struct task_struct
 	/* FIXME: find out whether or not this is supposed to be c*time. */
 	info.si_utime = tsk->utime + tsk->signal->utime;
 	info.si_stime = tsk->stime + tsk->signal->stime;
-	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
 	info.si_status = tsk->exit_code & 0x7f;
 	if (tsk->exit_code & 0x80)
@@ -1558,7 +1557,6 @@ do_notify_parent_cldstop(struct task_str
 	/* FIXME: find out whether or not this is supposed to be c*time. */
 	info.si_utime = tsk->utime;
 	info.si_stime = tsk->stime;
-	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
  	info.si_code = why;
  	switch (why) {
@@ -2170,8 +2168,6 @@ int copy_siginfo_to_user(siginfo_t __use
 		err |= __put_user(from->si_status, &to->si_status);
 		err |= __put_user(from->si_utime, &to->si_utime);
 		err |= __put_user(from->si_stime, &to->si_stime);
-		err |= __copy_to_user(&to->si_rusage, &from->si_rusage,
-				      sizeof(to->si_rusage));
 		break;
 	case __SI_RT: /* This is not generated by the kernel as of now. */
 	case __SI_MESGQ: /* But this is */
