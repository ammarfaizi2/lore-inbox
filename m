Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUDCESl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 23:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUDCESl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 23:18:41 -0500
Received: from waste.org ([209.173.204.2]:9197 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261582AbUDCESX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 23:18:23 -0500
Date: Fri, 2 Apr 2004 22:18:19 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] eliminate nswap and cnswap
Message-ID: <20040403041819.GV6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nswap and cnswap variables counters have never been incremented as
Linux doesn't do task swapping.

 tiny-mpm/arch/alpha/kernel/osf_sys.c |    3 ---
 tiny-mpm/fs/proc/array.c             |    4 ++--
 tiny-mpm/include/linux/sched.h       |    2 +-
 tiny-mpm/kernel/acct.c               |    2 +-
 tiny-mpm/kernel/exit.c               |    1 -
 tiny-mpm/kernel/fork.c               |    1 -
 tiny-mpm/kernel/sys.c                |    3 ---
 7 files changed, 4 insertions(+), 12 deletions(-)

diff -puN arch/alpha/kernel/osf_sys.c~kill-nswap arch/alpha/kernel/osf_sys.c
--- tiny/arch/alpha/kernel/osf_sys.c~kill-nswap	2004-03-20 12:14:34.000000000 -0600
+++ tiny-mpm/arch/alpha/kernel/osf_sys.c	2004-03-20 12:14:34.000000000 -0600
@@ -1095,14 +1095,12 @@ osf_getrusage(int who, struct rusage32 *
 		jiffies_to_timeval32(current->stime, &r.ru_stime);
 		r.ru_minflt = current->min_flt;
 		r.ru_majflt = current->maj_flt;
-		r.ru_nswap = current->nswap;
 		break;
 	case RUSAGE_CHILDREN:
 		jiffies_to_timeval32(current->cutime, &r.ru_utime);
 		jiffies_to_timeval32(current->cstime, &r.ru_stime);
 		r.ru_minflt = current->cmin_flt;
 		r.ru_majflt = current->cmaj_flt;
-		r.ru_nswap = current->cnswap;
 		break;
 	default:
 		jiffies_to_timeval32(current->utime + current->cutime,
@@ -1111,7 +1109,6 @@ osf_getrusage(int who, struct rusage32 *
 				   &r.ru_stime);
 		r.ru_minflt = current->min_flt + current->cmin_flt;
 		r.ru_majflt = current->maj_flt + current->cmaj_flt;
-		r.ru_nswap = current->nswap + current->cnswap;
 		break;
 	}
 
diff -puN fs/proc/array.c~kill-nswap fs/proc/array.c
--- tiny/fs/proc/array.c~kill-nswap	2004-03-20 12:14:34.000000000 -0600
+++ tiny-mpm/fs/proc/array.c	2004-03-20 12:14:34.000000000 -0600
@@ -388,8 +388,8 @@ int proc_pid_stat(struct task_struct *ta
 		sigign      .sig[0] & 0x7fffffffUL,
 		sigcatch    .sig[0] & 0x7fffffffUL,
 		wchan,
-		task->nswap,
-		task->cnswap,
+		0UL,
+		0UL,
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
diff -puN include/linux/sched.h~kill-nswap include/linux/sched.h
--- tiny/include/linux/sched.h~kill-nswap	2004-03-20 12:14:34.000000000 -0600
+++ tiny-mpm/include/linux/sched.h	2004-03-20 12:14:34.000000000 -0600
@@ -428,7 +428,7 @@ struct task_struct {
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
 	u64 start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
-	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
+	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
 /* process credentials */
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
diff -puN kernel/acct.c~kill-nswap kernel/acct.c
--- tiny/kernel/acct.c~kill-nswap	2004-03-20 12:14:34.000000000 -0600
+++ tiny-mpm/kernel/acct.c	2004-03-20 12:14:34.000000000 -0600
@@ -376,7 +376,7 @@ static void do_acct_process(long exitcod
 	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
 	ac.ac_minflt = encode_comp_t(current->min_flt);
 	ac.ac_majflt = encode_comp_t(current->maj_flt);
-	ac.ac_swaps = encode_comp_t(current->nswap);
+	ac.ac_swaps = encode_comp_t(0);
 	ac.ac_exitcode = exitcode;
 
 	/*
diff -puN kernel/exit.c~kill-nswap kernel/exit.c
--- tiny/kernel/exit.c~kill-nswap	2004-03-20 12:14:34.000000000 -0600
+++ tiny-mpm/kernel/exit.c	2004-03-20 12:14:34.000000000 -0600
@@ -92,7 +92,6 @@ repeat: 
 	p->parent->cstime += p->stime + p->cstime;
 	p->parent->cmin_flt += p->min_flt + p->cmin_flt;
 	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
-	p->parent->cnswap += p->nswap + p->cnswap;
 	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
 	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
 	sched_exit(p);
diff -puN kernel/fork.c~kill-nswap kernel/fork.c
--- tiny/kernel/fork.c~kill-nswap	2004-03-20 12:14:34.000000000 -0600
+++ tiny-mpm/kernel/fork.c	2004-03-20 12:14:34.000000000 -0600
@@ -512,7 +512,6 @@ static int copy_mm(unsigned long clone_f
 
 	tsk->min_flt = tsk->maj_flt = 0;
 	tsk->cmin_flt = tsk->cmaj_flt = 0;
-	tsk->nswap = tsk->cnswap = 0;
 	tsk->nvcsw = tsk->nivcsw = tsk->cnvcsw = tsk->cnivcsw = 0;
 
 	tsk->mm = NULL;
diff -puN kernel/sys.c~kill-nswap kernel/sys.c
--- tiny/kernel/sys.c~kill-nswap	2004-03-20 12:14:34.000000000 -0600
+++ tiny-mpm/kernel/sys.c	2004-03-20 12:14:34.000000000 -0600
@@ -1521,7 +1521,6 @@ int getrusage(struct task_struct *p, int
 			r.ru_nivcsw = p->nivcsw;
 			r.ru_minflt = p->min_flt;
 			r.ru_majflt = p->maj_flt;
-			r.ru_nswap = p->nswap;
 			break;
 		case RUSAGE_CHILDREN:
 			jiffies_to_timeval(p->cutime, &r.ru_utime);
@@ -1530,7 +1529,6 @@ int getrusage(struct task_struct *p, int
 			r.ru_nivcsw = p->cnivcsw;
 			r.ru_minflt = p->cmin_flt;
 			r.ru_majflt = p->cmaj_flt;
-			r.ru_nswap = p->cnswap;
 			break;
 		default:
 			jiffies_to_timeval(p->utime + p->cutime, &r.ru_utime);
@@ -1539,7 +1537,6 @@ int getrusage(struct task_struct *p, int
 			r.ru_nivcsw = p->nivcsw + p->cnivcsw;
 			r.ru_minflt = p->min_flt + p->cmin_flt;
 			r.ru_majflt = p->maj_flt + p->cmaj_flt;
-			r.ru_nswap = p->nswap + p->cnswap;
 			break;
 	}
 	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;

_

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
