Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVARB6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVARB6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVARB4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:56:43 -0500
Received: from mail.dif.dk ([193.138.115.101]:60855 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262915AbVARBUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:20:10 -0500
Date: Tue, 18 Jan 2005 02:22:58 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 08/11] Get rid of verify_area() - arch/x86_64/ and arch/ia64/.
Message-ID: <Pine.LNX.4.61.0501180152420.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert a bunch of verify_area()'s to access_ok().
arch/x86_64/ and arch/ia64/.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc1-bk4-orig/arch/x86_64/ia32/sys_ia32.c	2005-01-12 23:26:04.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/x86_64/ia32/sys_ia32.c	2005-01-16 23:19:02.000000000 +0100
@@ -88,7 +88,7 @@ int cp_compat_stat(struct kstat *kbuf, s
 		return -EOVERFLOW;
 	if (kbuf->size >= 0x7fffffff)
 		return -EOVERFLOW;
-	if (verify_area(VERIFY_WRITE, ubuf, sizeof(struct compat_stat)) ||
+	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(struct compat_stat)) ||
 	    __put_user (old_encode_dev(kbuf->dev), &ubuf->st_dev) ||
 	    __put_user (kbuf->ino, &ubuf->st_ino) ||
 	    __put_user (kbuf->mode, &ubuf->st_mode) ||
@@ -131,7 +131,7 @@ cp_stat64(struct stat64 __user *ubuf, st
 	typeof(ubuf->st_gid) gid = 0;
 	SET_UID(uid, stat->uid);
 	SET_GID(gid, stat->gid);
-	if (verify_area(VERIFY_WRITE, ubuf, sizeof(struct stat64)) ||
+	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(struct stat64)) ||
 	    __put_user(huge_encode_dev(stat->dev), &ubuf->st_dev) ||
 	    __put_user (stat->ino, &ubuf->__st_ino) ||
 	    __put_user (stat->ino, &ubuf->st_ino) ||
@@ -265,7 +265,7 @@ sys32_rt_sigaction(int sig, struct sigac
 	if (act) {
 		compat_uptr_t handler, restorer;
 
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
 		    __get_user(restorer, &act->sa_restorer)||
@@ -304,7 +304,7 @@ sys32_rt_sigaction(int sig, struct sigac
 			set32.sig[1] = (old_ka.sa.sa_mask.sig[0] >> 32);
 			set32.sig[0] = old_ka.sa.sa_mask.sig[0];
 		}
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user((long)old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user((long)old_ka.sa.sa_restorer, &oact->sa_restorer) ||
 		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
@@ -325,7 +325,7 @@ sys32_sigaction (int sig, struct old_sig
 		compat_old_sigset_t mask;
 		compat_uptr_t handler, restorer;
 
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
 		    __get_user(restorer, &act->sa_restorer) ||
@@ -341,7 +341,7 @@ sys32_sigaction (int sig, struct old_sig
         ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user((long)old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user((long)old_ka.sa.sa_restorer, &oact->sa_restorer) ||
 		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
@@ -570,7 +570,7 @@ sys32_sysinfo(struct sysinfo32 __user *i
 		s.freehigh >>= bitcount;
 	}
 
-	if (verify_area(VERIFY_WRITE, info, sizeof(struct sysinfo32)) ||
+	if (!access_ok(VERIFY_WRITE, info, sizeof(struct sysinfo32)) ||
 	    __put_user (s.uptime, &info->uptime) ||
 	    __put_user (s.loads[0], &info->loads[0]) ||
 	    __put_user (s.loads[1], &info->loads[1]) ||
@@ -787,7 +787,7 @@ sys32_adjtimex(struct timex32 __user *ut
 
 	memset(&txc, 0, sizeof(struct timex));
 
-	if(verify_area(VERIFY_READ, utp, sizeof(struct timex32)) ||
+	if (!access_ok(VERIFY_READ, utp, sizeof(struct timex32)) ||
 	   __get_user(txc.modes, &utp->modes) ||
 	   __get_user(txc.offset, &utp->offset) ||
 	   __get_user(txc.freq, &utp->freq) ||
--- linux-2.6.11-rc1-bk4-orig/arch/x86_64/ia32/ia32_signal.c	2005-01-12 23:26:04.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/x86_64/ia32/ia32_signal.c	2005-01-16 23:21:55.000000000 +0100
@@ -258,7 +258,7 @@ ia32_restore_sigcontext(struct pt_regs *
 		err |= __get_user(tmp, &sc->fpstate);
 		buf = compat_ptr(tmp);
 		if (buf) {
-			if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
+			if (!access_ok(VERIFY_READ, buf, sizeof(*buf)))
 				goto badframe;
 			err |= restore_i387_ia32(current, buf, 0);
 		} else {
@@ -287,7 +287,7 @@ asmlinkage long sys32_sigreturn(struct p
 	sigset_t set;
 	unsigned int eax;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
 	    || (_COMPAT_NSIG_WORDS > 1
@@ -319,7 +319,7 @@ asmlinkage long sys32_rt_sigreturn(struc
 
 	frame = (struct rt_sigframe __user *)(regs->rsp - 4);
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/x86_64/ia32/ia32_aout.c	2005-01-16 21:27:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/x86_64/ia32/ia32_aout.c	2005-01-16 23:23:32.000000000 +0100
@@ -182,9 +182,9 @@ static int aout_core_dump(long signr, st
 
 /* make sure we actually have a data and stack area to dump */
 	set_fs(USER_DS);
-	if (verify_area(VERIFY_READ, (void *) (unsigned long)START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
+	if (!access_ok(VERIFY_READ, (void *) (unsigned long)START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
 		dump.u_dsize = 0;
-	if (verify_area(VERIFY_READ, (void *) (unsigned long)START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
+	if (!access_ok(VERIFY_READ, (void *) (unsigned long)START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
 		dump.u_ssize = 0;
 
 	set_fs(KERNEL_DS);
--- linux-2.6.11-rc1-bk4-orig/arch/x86_64/kernel/signal.c	2005-01-16 21:27:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/x86_64/kernel/signal.c	2005-01-16 23:24:38.000000000 +0100
@@ -121,7 +121,7 @@ restore_sigcontext(struct pt_regs *regs,
 		err |= __get_user(buf, &sc->fpstate);
 
 		if (buf) {
-			if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
+			if (!access_ok(VERIFY_READ, buf, sizeof(*buf)))
 				goto badframe;
 			err |= restore_i387(buf);
 		} else {
@@ -147,7 +147,7 @@ asmlinkage long sys_rt_sigreturn(struct 
 	unsigned long eax;
 
 	frame = (struct rt_sigframe __user *)(regs->rsp - 8);
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame))) { 
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame))) { 
 		goto badframe;
 	} 
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set))) { 
--- linux-2.6.11-rc1-bk4-orig/arch/ia64/ia32/sys_ia32.c	2005-01-16 21:27:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ia64/ia32/sys_ia32.c	2005-01-16 23:28:09.000000000 +0100
@@ -2413,12 +2413,11 @@ sys32_epoll_ctl(int epfd, int op, int fd
 {
 	mm_segment_t old_fs = get_fs();
 	struct epoll_event event64;
-	int error = -EFAULT;
+	int error;
 	u32 data_halfword;
 
-	if ((error = verify_area(VERIFY_READ, event,
-				 sizeof(struct epoll_event32))))
-		return error;
+	if (!access_ok(VERIFY_READ, event, sizeof(struct epoll_event32)))
+		return -EFAULT;
 
 	__get_user(event64.events, &event->events);
 	__get_user(data_halfword, &event->data[0]);
@@ -2448,9 +2447,8 @@ sys32_epoll_wait(int epfd, struct epoll_
 	}
 
 	/* Verify that the area passed by the user is writeable */
-	if ((error = verify_area(VERIFY_WRITE, events,
-				 maxevents * sizeof(struct epoll_event32))))
-		return error;
+	if (!access_ok(VERIFY_WRITE, events, maxevents * sizeof(struct epoll_event32)))
+		return -EFAULT;
 
 	/*
  	 * Allocate space for the intermediate copy.  If the space needed
--- linux-2.6.11-rc1-bk4-orig/arch/ia64/ia32/ia32_signal.c	2005-01-12 23:26:02.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ia64/ia32/ia32_signal.c	2005-01-16 23:29:25.000000000 +0100
@@ -778,7 +778,7 @@ restore_sigcontext_ia32 (struct pt_regs 
 		struct _fpstate * buf;
 		err |= __get_user(buf, &sc->fpstate);
 		if (buf) {
-			if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
+			if (!access_ok(VERIFY_READ, buf, sizeof(*buf)))
 				goto badframe;
 			err |= restore_i387(buf);
 		}
@@ -979,7 +979,7 @@ sys32_sigreturn (int arg0, int arg1, int
 	sigset_t set;
 	int eax;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
@@ -1012,7 +1012,7 @@ sys32_rt_sigreturn (int arg0, int arg1, 
 	sigset_t set;
 	int eax;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/ia64/kernel/ptrace.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ia64/kernel/ptrace.c	2005-01-16 23:37:04.000000000 +0100
@@ -991,14 +991,12 @@ ptrace_getregs (struct task_struct *chil
 	struct ia64_fpreg fpval;
 	struct switch_stack *sw;
 	struct pt_regs *pt;
-	long ret, retval;
+	long ret, retval = 0;
 	char nat = 0;
 	int i;
 
-	retval = verify_area(VERIFY_WRITE, ppr, sizeof(struct pt_all_user_regs));
-	if (retval != 0) {
+	if (!access_ok(VERIFY_WRITE, ppr, sizeof(struct pt_all_user_regs)))
 		return -EIO;
-	}
 
 	pt = ia64_task_regs(child);
 	sw = (struct switch_stack *) (child->thread.ksp + 16);
@@ -1021,8 +1019,6 @@ ptrace_getregs (struct task_struct *chil
 	    || access_uarea(child, PT_NAT_BITS, &nat_bits, 0))
 		return -EIO;
 
-	retval = 0;
-
 	/* control regs */
 
 	retval |= __put_user(pt->cr_iip, &ppr->cr_iip);
@@ -1136,15 +1132,13 @@ ptrace_setregs (struct task_struct *chil
 	struct switch_stack *sw;
 	struct ia64_fpreg fpval;
 	struct pt_regs *pt;
-	long ret, retval;
+	long ret, retval = 0;
 	int i;
 
 	memset(&fpval, 0, sizeof(fpval));
 
-	retval = verify_area(VERIFY_READ, ppr, sizeof(struct pt_all_user_regs));
-	if (retval != 0) {
+	if (!access_ok(VERIFY_READ, ppr, sizeof(struct pt_all_user_regs)))
 		return -EIO;
-	}
 
 	pt = ia64_task_regs(child);
 	sw = (struct switch_stack *) (child->thread.ksp + 16);
@@ -1158,8 +1152,6 @@ ptrace_setregs (struct task_struct *chil
 		return -EIO;
 	}
 
-	retval = 0;
-
 	/* control regs */
 
 	retval |= __get_user(pt->cr_iip, &ppr->cr_iip);



