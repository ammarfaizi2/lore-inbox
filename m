Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVARBzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVARBzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVARByi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:54:38 -0500
Received: from mail.dif.dk ([193.138.115.101]:62135 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262931AbVARBUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:20:19 -0500
Date: Tue, 18 Jan 2005 02:23:08 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 09/11] Get rid of verify_area() - arch/ppc/, arch/ppc64/,
 arch/m68k/, arch/m68knommu/.
Message-ID: <Pine.LNX.4.61.0501180153400.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert a bunch of verify_area()'s to access_ok().
arch/ppc/, arch/ppc64/, arch/m68k/, arch/m68knommu/.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc1-bk4-orig/arch/ppc/kernel/signal.c	2005-01-12 23:26:02.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc/kernel/signal.c	2005-01-16 22:23:08.000000000 +0100
@@ -118,7 +118,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -130,7 +130,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, (act? &new_ka: NULL), (oact? &old_ka: NULL));
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -376,7 +376,7 @@ handle_rt_signal(unsigned long sig, stru
 	/* create a stack frame for the caller of the handler */
 	newsp -= __SIGNAL_FRAMESIZE + 16;
 
-	if (verify_area(VERIFY_WRITE, (void __user *) newsp, origsp - newsp))
+	if (!access_ok(VERIFY_WRITE, (void __user *) newsp, origsp - newsp))
 		goto badframe;
 
 	/* Put the siginfo & fill in most of the ucontext */
@@ -445,7 +445,7 @@ int sys_swapcontext(struct ucontext __us
 		return -EINVAL;
 
 	if (old_ctx != NULL) {
-		if (verify_area(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
+		if (!access_ok(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
 		    || save_user_regs(regs, &old_ctx->uc_mcontext, 0)
 		    || __copy_to_user(&old_ctx->uc_sigmask,
 				      &current->blocked, sizeof(sigset_t))
@@ -454,7 +454,7 @@ int sys_swapcontext(struct ucontext __us
 	}
 	if (new_ctx == NULL)
 		return 0;
-	if (verify_area(VERIFY_READ, new_ctx, sizeof(*new_ctx))
+	if (!access_ok(VERIFY_READ, new_ctx, sizeof(*new_ctx))
 	    || __get_user(tmp, (u8 __user *) new_ctx)
 	    || __get_user(tmp, (u8 __user *) (new_ctx + 1) - 1))
 		return -EFAULT;
@@ -464,7 +464,7 @@ int sys_swapcontext(struct ucontext __us
 	 * image of the user's registers, we can't just return -EFAULT
 	 * because the user's registers will be corrupted.  For instance
 	 * the NIP value may have been updated but not some of the
-	 * other registers.  Given that we have done the verify_area
+	 * other registers.  Given that we have done the access_ok
 	 * and successfully read the first and last bytes of the region
 	 * above, this should only happen in an out-of-memory situation
 	 * or if another thread unmaps the region containing the context.
@@ -487,7 +487,7 @@ int sys_rt_sigreturn(int r3, int r4, int
 
 	rt_sf = (struct rt_sigframe __user *)
 		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
-	if (verify_area(VERIFY_READ, rt_sf, sizeof(struct rt_sigframe)))
+	if (!access_ok(VERIFY_READ, rt_sf, sizeof(struct rt_sigframe)))
 		goto bad;
 	if (do_setcontext(&rt_sf->uc, regs, 1))
 		goto bad;
@@ -572,7 +572,7 @@ int sys_debug_setcontext(struct ucontext
 	 * image of the user's registers, we can't just return -EFAULT
 	 * because the user's registers will be corrupted.  For instance
 	 * the NIP value may have been updated but not some of the
-	 * other registers.  Given that we have done the verify_area
+	 * other registers.  Given that we have done the access_ok
 	 * and successfully read the first and last bytes of the region
 	 * above, this should only happen in an out-of-memory situation
 	 * or if another thread unmaps the region containing the context.
@@ -622,7 +622,7 @@ handle_signal(unsigned long sig, struct 
 	/* create a stack frame for the caller of the handler */
 	newsp -= __SIGNAL_FRAMESIZE;
 
-	if (verify_area(VERIFY_WRITE, (void __user *) newsp, origsp - newsp))
+	if (!access_ok(VERIFY_WRITE, (void __user *) newsp, origsp - newsp))
 		goto badframe;
 
 #if _NSIG != 64
@@ -680,7 +680,7 @@ int sys_sigreturn(int r3, int r4, int r5
 	restore_sigmask(&set);
 
 	sr = (struct mcontext __user *) sigctx.regs;
-	if (verify_area(VERIFY_READ, sr, sizeof(*sr))
+	if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
 	    || restore_user_regs(regs, sr, 1))
 		goto badframe;
 
--- linux-2.6.11-rc1-bk4-orig/arch/ppc/kernel/align.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc/kernel/align.c	2005-01-16 22:26:59.000000000 +0100
@@ -248,7 +248,7 @@ fix_alignment(struct pt_regs *regs)
 		 */
 		p = (long __user *) (regs->dar & -L1_CACHE_BYTES);
 		if (user_mode(regs)
-		    && verify_area(VERIFY_WRITE, p, L1_CACHE_BYTES))
+		    && !access_ok(VERIFY_WRITE, p, L1_CACHE_BYTES))
 			return -EFAULT;
 		for (i = 0; i < L1_CACHE_BYTES / sizeof(long); ++i)
 			if (__put_user(0, p+i))
@@ -328,7 +328,7 @@ fix_alignment(struct pt_regs *regs)
 
 	/* Verify the address of the operand */
 	if (user_mode(regs)) {
-		if (verify_area((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, nb))
+		if (!access_ok((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, nb))
 			return -EFAULT;	/* bad address */
 	}
 
--- linux-2.6.11-rc1-bk4-orig/arch/ppc/kernel/syscalls.c	2004-12-24 22:35:29.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc/kernel/syscalls.c	2005-01-16 22:43:29.000000000 +0100
@@ -77,7 +77,7 @@ sys_ipc (uint call, int first, int secon
 
 		if (!ptr)
 			break;
-		if ((ret = verify_area (VERIFY_READ, ptr, sizeof(long)))
+		if ((ret = access_ok(VERIFY_READ, ptr, sizeof(long)) ? 0 : -EFAULT)
 		    || (ret = get_user(fourth.__pad, (void __user *__user *)ptr)))
 			break;
 		ret = sys_semctl (first, second, third, fourth);
@@ -93,7 +93,7 @@ sys_ipc (uint call, int first, int secon
 
 			if (!ptr)
 				break;
-			if ((ret = verify_area (VERIFY_READ, ptr, sizeof(tmp)))
+			if ((ret = access_ok(VERIFY_READ, ptr, sizeof(tmp)) ? 0 : -EFAULT)
 			    || (ret = copy_from_user(&tmp,
 					(struct ipc_kludge __user *) ptr,
 					sizeof (tmp)) ? -EFAULT : 0))
@@ -117,8 +117,8 @@ sys_ipc (uint call, int first, int secon
 	case SHMAT: {
 		ulong raddr;
 
-		if ((ret = verify_area(VERIFY_WRITE, (ulong __user *) third,
-				       sizeof(ulong))))
+		if ((ret = access_ok(VERIFY_WRITE, (ulong __user *) third,
+				       sizeof(ulong)) ? 0 : -EFAULT))
 			break;
 		ret = do_shmat (first, (char __user *) ptr, second, &raddr);
 		if (ret)
@@ -213,7 +213,7 @@ ppc_select(int n, fd_set __user *inp, fd
 	if ( (unsigned long)n >= 4096 )
 	{
 		unsigned long __user *buffer = (unsigned long __user *)n;
-		if (verify_area(VERIFY_READ, buffer, 5*sizeof(unsigned long))
+		if (!access_ok(VERIFY_READ, buffer, 5*sizeof(unsigned long))
 		    || __get_user(n, buffer)
 		    || __get_user(inp, ((fd_set __user * __user *)(buffer+1)))
 		    || __get_user(outp, ((fd_set  __user * __user *)(buffer+2)))
--- linux-2.6.11-rc1-bk4-orig/arch/m68k/kernel/signal.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/m68k/kernel/signal.c	2005-01-16 22:48:31.000000000 +0100
@@ -130,7 +130,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -142,7 +142,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -510,7 +510,7 @@ asmlinkage int do_sigreturn(unsigned lon
 	sigset_t set;
 	int d0;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.sc_mask) ||
 	    (_NSIG_WORDS > 1 &&
@@ -540,7 +540,7 @@ asmlinkage int do_rt_sigreturn(unsigned 
 	sigset_t set;
 	int d0;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/ppc64/kernel/signal.c	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc64/kernel/signal.c	2005-01-16 22:50:28.000000000 +0100
@@ -313,7 +313,7 @@ int sys_swapcontext(struct ucontext __us
 		return -EINVAL;
 
 	if (old_ctx != NULL) {
-		if (verify_area(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
+		if (!access_ok(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
 		    || setup_sigcontext(&old_ctx->uc_mcontext, regs, 0, NULL, 0)
 		    || __copy_to_user(&old_ctx->uc_sigmask,
 				      &current->blocked, sizeof(sigset_t)))
@@ -321,7 +321,7 @@ int sys_swapcontext(struct ucontext __us
 	}
 	if (new_ctx == NULL)
 		return 0;
-	if (verify_area(VERIFY_READ, new_ctx, sizeof(*new_ctx))
+	if (!access_ok(VERIFY_READ, new_ctx, sizeof(*new_ctx))
 	    || __get_user(tmp, (u8 __user *) new_ctx)
 	    || __get_user(tmp, (u8 __user *) (new_ctx + 1) - 1))
 		return -EFAULT;
@@ -331,7 +331,7 @@ int sys_swapcontext(struct ucontext __us
 	 * image of the user's registers, we can't just return -EFAULT
 	 * because the user's registers will be corrupted.  For instance
 	 * the NIP value may have been updated but not some of the
-	 * other registers.  Given that we have done the verify_area
+	 * other registers.  Given that we have done the access_ok
 	 * and successfully read the first and last bytes of the region
 	 * above, this should only happen in an out-of-memory situation
 	 * or if another thread unmaps the region containing the context.
@@ -363,7 +363,7 @@ int sys_rt_sigreturn(unsigned long r3, u
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
-	if (verify_area(VERIFY_READ, uc, sizeof(*uc)))
+	if (!access_ok(VERIFY_READ, uc, sizeof(*uc)))
 		goto badframe;
 
 	if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
@@ -403,7 +403,7 @@ static int setup_rt_frame(int signr, str
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
 
-	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto badframe;
 
 	err |= __put_user(&frame->info, &frame->pinfo);
--- linux-2.6.11-rc1-bk4-orig/arch/ppc64/kernel/rtasd.c	2005-01-12 23:26:03.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc64/kernel/rtasd.c	2005-01-16 22:52:26.000000000 +0100
@@ -289,8 +289,7 @@ static ssize_t rtas_log_read(struct file
 
 	count = rtas_error_log_buffer_max;
 
-	error = verify_area(VERIFY_WRITE, buf, count);
-	if (error)
+	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
 
 	tmp = kmalloc(count, GFP_KERNEL);
--- linux-2.6.11-rc1-bk4-orig/arch/ppc64/kernel/scanlog.c	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc64/kernel/scanlog.c	2005-01-16 22:53:12.000000000 +0100
@@ -73,7 +73,7 @@ static ssize_t scanlog_read(struct file 
 		return -EINVAL;
 	}
 
-	if (verify_area(VERIFY_WRITE, buf, count))
+	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
 
 	for (;;) {
--- linux-2.6.11-rc1-bk4-orig/arch/ppc64/kernel/sys_ppc32.c	2005-01-12 23:26:03.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc64/kernel/sys_ppc32.c	2005-01-16 22:55:35.000000000 +0100
@@ -241,7 +241,7 @@ int cp_compat_stat(struct kstat *stat, s
 	    !new_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 
-	err  = verify_area(VERIFY_WRITE, statbuf, sizeof(*statbuf));
+	err  = access_ok(VERIFY_WRITE, statbuf, sizeof(*statbuf)) ? 0 : -EFAULT;
 	err |= __put_user(new_encode_dev(stat->dev), &statbuf->st_dev);
 	err |= __put_user(stat->ino, &statbuf->st_ino);
 	err |= __put_user(stat->mode, &statbuf->st_mode);
@@ -1191,7 +1191,7 @@ unsigned long sys32_mmap2(unsigned long 
 
 int get_compat_timeval(struct timeval *tv, struct compat_timeval __user *ctv)
 {
-	return (verify_area(VERIFY_READ, ctv, sizeof(*ctv)) ||
+	return (!access_ok(VERIFY_READ, ctv, sizeof(*ctv)) ||
 		__get_user(tv->tv_sec, &ctv->tv_sec) ||
 		__get_user(tv->tv_usec, &ctv->tv_usec)) ? -EFAULT : 0;
 }
--- linux-2.6.11-rc1-bk4-orig/arch/ppc64/kernel/align.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc64/kernel/align.c	2005-01-16 22:56:29.000000000 +0100
@@ -273,7 +273,7 @@ fix_alignment(struct pt_regs *regs)
 
 	/* Verify the address of the operand */
 	if (user_mode(regs)) {
-		if (verify_area((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, nb))
+		if (!access_ok((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, nb))
 			return -EFAULT;	/* bad address */
 	}
 
--- linux-2.6.11-rc1-bk4-orig/arch/ppc64/kernel/nvram.c	2005-01-12 23:26:03.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc64/kernel/nvram.c	2005-01-16 22:57:14.000000000 +0100
@@ -89,7 +89,7 @@ static ssize_t dev_nvram_read(struct fil
 		return -ENODEV;
 	size = ppc_md.nvram_size();
 
-	if (verify_area(VERIFY_WRITE, buf, count))
+	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
 	if (*ppos >= size)
 		return 0;
@@ -129,7 +129,7 @@ static ssize_t dev_nvram_write(struct fi
 		return -ENODEV;
 	size = ppc_md.nvram_size();
 
-	if (verify_area(VERIFY_READ, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 	if (*ppos >= size)
 		return 0;
--- linux-2.6.11-rc1-bk4-orig/arch/ppc64/kernel/rtas_flash.c	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc64/kernel/rtas_flash.c	2005-01-16 23:02:49.000000000 +0100
@@ -224,7 +224,6 @@ static ssize_t rtas_flash_read(struct fi
 	struct proc_dir_entry *dp = PDE(file->f_dentry->d_inode);
 	struct rtas_update_flash_t *uf;
 	char msg[RTAS_MSG_MAXLEN];
-	int error;
 	int msglen;
 
 	uf = (struct rtas_update_flash_t *) dp->data;
@@ -241,8 +240,7 @@ static ssize_t rtas_flash_read(struct fi
 	if (ppos && *ppos != 0)
 		return 0;	/* be cheap */
 
-	error = verify_area(VERIFY_WRITE, buf, msglen);
-	if (error)
+	if (!access_ok(VERIFY_WRITE, buf, msglen))
 		return -EINVAL;
 
 	if (copy_to_user(buf, msg, msglen))
@@ -365,7 +363,6 @@ static ssize_t manage_flash_read(struct 
 	struct rtas_manage_flash_t *args_buf;
 	char msg[RTAS_MSG_MAXLEN];
 	int msglen;
-	int error;
 
 	args_buf = (struct rtas_manage_flash_t *) dp->data;
 	if (args_buf == NULL)
@@ -378,8 +375,7 @@ static ssize_t manage_flash_read(struct 
 	if (ppos && *ppos != 0)
 		return 0;	/* be cheap */
 
-	error = verify_area(VERIFY_WRITE, buf, msglen);
-	if (error)
+	if (!access_ok(VERIFY_WRITE, buf, msglen))
 		return -EINVAL;
 
 	if (copy_to_user(buf, msg, msglen))
@@ -477,7 +473,6 @@ static ssize_t validate_flash_read(struc
 	struct rtas_validate_flash_t *args_buf;
 	char msg[RTAS_MSG_MAXLEN];
 	int msglen;
-	int error;
 
 	args_buf = (struct rtas_validate_flash_t *) dp->data;
 
@@ -488,8 +483,7 @@ static ssize_t validate_flash_read(struc
 	if (msglen > count)
 		msglen = count;
 
-	error = verify_area(VERIFY_WRITE, buf, msglen);
-	if (error)
+	if (!access_ok(VERIFY_WRITE, buf, msglen))
 		return -EINVAL;
 
 	if (copy_to_user(buf, msg, msglen))
@@ -531,7 +525,7 @@ static ssize_t validate_flash_write(stru
 		args_buf->status = VALIDATE_INCOMPLETE;
 	}
 
-	if (verify_area(VERIFY_READ, buf, count)) {
+	if (!access_ok(VERIFY_READ, buf, count)) {
 		rc = -EFAULT;
 		goto done;
 	}
--- linux-2.6.11-rc1-bk4-orig/arch/ppc64/kernel/signal32.c	2005-01-12 23:26:03.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/ppc64/kernel/signal32.c	2005-01-16 23:09:46.000000000 +0100
@@ -637,7 +637,7 @@ static int handle_rt_signal32(unsigned l
 	/* create a stack frame for the caller of the handler */
 	newsp -= __SIGNAL_FRAMESIZE32 + 16;
 
-	if (verify_area(VERIFY_WRITE, (void __user *)newsp, origsp - newsp))
+	if (!access_ok(VERIFY_WRITE, (void __user *)newsp, origsp - newsp))
 		goto badframe;
 
 	compat_from_sigset(&c_oldset, oldset);
@@ -721,7 +721,7 @@ long sys32_swapcontext(struct ucontext32
 
 	if (old_ctx != NULL) {
 		compat_from_sigset(&c_set, &current->blocked);
-		if (verify_area(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
+		if (!access_ok(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
 		    || save_user_regs(regs, &old_ctx->uc_mcontext, 0)
 		    || __copy_to_user(&old_ctx->uc_sigmask, &c_set, sizeof(c_set))
 		    || __put_user((u32)(u64)&old_ctx->uc_mcontext, &old_ctx->uc_regs))
@@ -729,7 +729,7 @@ long sys32_swapcontext(struct ucontext32
 	}
 	if (new_ctx == NULL)
 		return 0;
-	if (verify_area(VERIFY_READ, new_ctx, sizeof(*new_ctx))
+	if (!access_ok(VERIFY_READ, new_ctx, sizeof(*new_ctx))
 	    || __get_user(tmp, (u8 __user *) new_ctx)
 	    || __get_user(tmp, (u8 __user *) (new_ctx + 1) - 1))
 		return -EFAULT;
@@ -739,7 +739,7 @@ long sys32_swapcontext(struct ucontext32
 	 * image of the user's registers, we can't just return -EFAULT
 	 * because the user's registers will be corrupted.  For instance
 	 * the NIP value may have been updated but not some of the
-	 * other registers.  Given that we have done the verify_area
+	 * other registers.  Given that we have done the access_ok
 	 * and successfully read the first and last bytes of the region
 	 * above, this should only happen in an out-of-memory situation
 	 * or if another thread unmaps the region containing the context.
@@ -763,7 +763,7 @@ long sys32_rt_sigreturn(int r3, int r4, 
 
 	rt_sf = (struct rt_sigframe32 __user *)
 		(regs->gpr[1] + __SIGNAL_FRAMESIZE32 + 16);
-	if (verify_area(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
+	if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
 		goto bad;
 	if (do_setcontext32(&rt_sf->uc, regs, 1))
 		goto bad;
@@ -812,7 +812,7 @@ static int handle_signal32(unsigned long
 	/* create a stack frame for the caller of the handler */
 	newsp -= __SIGNAL_FRAMESIZE32;
 
-	if (verify_area(VERIFY_WRITE, (void __user *) newsp, origsp - newsp))
+	if (!access_ok(VERIFY_WRITE, (void __user *) newsp, origsp - newsp))
 		goto badframe;
 
 #if _NSIG != 64
@@ -879,7 +879,7 @@ long sys32_sigreturn(int r3, int r4, int
 	restore_sigmask(&set);
 
 	sr = (struct mcontext32 __user *)(u64)sigctx.regs;
-	if (verify_area(VERIFY_READ, sr, sizeof(*sr))
+	if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
 	    || restore_user_regs(regs, sr, 1))
 		goto badframe;
 
--- linux-2.6.11-rc1-bk4-orig/arch/m68knommu/kernel/signal.c	2004-12-24 22:35:01.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/m68knommu/kernel/signal.c	2005-01-16 23:14:37.000000000 +0100
@@ -116,7 +116,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -128,7 +128,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -360,7 +360,7 @@ asmlinkage int do_sigreturn(unsigned lon
 	sigset_t set;
 	int d0;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.sc_mask) ||
 	    (_NSIG_WORDS > 1 &&
@@ -392,7 +392,7 @@ asmlinkage int do_rt_sigreturn(unsigned 
 	sigset_t set;
 	int d0;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;



