Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVARBuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVARBuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVARBuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:50:10 -0500
Received: from mail.dif.dk ([193.138.115.101]:63927 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261162AbVARBUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:20:31 -0500
Date: Tue, 18 Jan 2005 02:23:20 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 10/11] Get rid of verify_area() - the bits for the remaining
 archs.
Message-ID: <Pine.LNX.4.61.0501180154360.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert a bunch of verify_area()'s to access_ok().
The bits for the remaining archs.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc1-bk4-orig/arch/sh/kernel/signal.c	2005-01-16 21:27:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/sh/kernel/signal.c	2005-01-17 00:57:38.000000000 +0100
@@ -100,7 +100,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -112,7 +112,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -239,7 +239,7 @@ asmlinkage int sys_sigreturn(unsigned lo
 	sigset_t set;
 	int r0;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
@@ -273,7 +273,7 @@ asmlinkage int sys_rt_sigreturn(unsigned
 	stack_t st;
 	int r0;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
--- linux-2.6.11-rc1-bk4-orig/arch/um/sys-x86_64/syscalls.c	2005-01-12 23:26:04.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/um/sys-x86_64/syscalls.c	2005-01-17 00:58:03.000000000 +0100
@@ -29,8 +29,8 @@ long sys_modify_ldt_tt(int func, void *p
 	/* XXX This should check VERIFY_WRITE depending on func, check this
 	 * in i386 as well.
 	 */
-	if(verify_area(VERIFY_READ, ptr, bytecount))
-		return(-EFAULT);
+	if (!access_ok(VERIFY_READ, ptr, bytecount))
+		return -EFAULT;
 	return(modify_ldt(func, ptr, bytecount));
 }
 #endif
--- linux-2.6.11-rc1-bk4-orig/arch/um/sys-i386/ldt.c	2005-01-12 23:26:04.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/um/sys-i386/ldt.c	2005-01-17 00:58:52.000000000 +0100
@@ -17,7 +17,7 @@ extern int modify_ldt(int func, void *pt
 
 int sys_modify_ldt_tt(int func, void __user *ptr, unsigned long bytecount)
 {
-	if (verify_area(VERIFY_READ, ptr, bytecount))
+	if (!access_ok(VERIFY_READ, ptr, bytecount))
 		return -EFAULT;
 
 	return modify_ldt(func, ptr, bytecount);
--- linux-2.6.11-rc1-bk4-orig/arch/um/sys-i386/signal.c	2005-01-12 23:26:04.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/um/sys-i386/signal.c	2005-01-17 00:59:30.000000000 +0100
@@ -211,8 +211,8 @@ int setup_signal_stack_sc(unsigned long 
 
 	stack_top &= -8UL;
 	frame = (struct sigframe *) stack_top - 1;
-	if(verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
-		return(1);
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+		return 1;
 
 	restorer = (void *) frame->retcode;
 	if(ka->sa.sa_flags & SA_RESTORER)
@@ -261,8 +261,8 @@ int setup_signal_stack_si(unsigned long 
 
 	stack_top &= -8UL;
 	frame = (struct rt_sigframe *) stack_top - 1;
-	if(verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
-		return(1);
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+		return 1;
 
 	restorer = (void *) frame->retcode;
 	if(ka->sa.sa_flags & SA_RESTORER)
--- linux-2.6.11-rc1-bk4-orig/arch/um/sys-i386/syscalls.c	2005-01-12 23:26:04.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/um/sys-i386/syscalls.c	2005-01-17 00:59:48.000000000 +0100
@@ -175,7 +175,7 @@ long sys_sigaction(int sig, const struct
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -187,7 +187,7 @@ long sys_sigaction(int sig, const struct
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
--- linux-2.6.11-rc1-bk4-orig/arch/um/include/sysdep-i386/checksum.h	2005-01-16 21:27:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/um/include/sysdep-i386/checksum.h	2005-01-17 01:00:12.000000000 +0100
@@ -41,7 +41,7 @@ unsigned int csum_partial_copy_from(cons
  *	passed in an incorrect kernel address to one of these functions.
  *
  *	If you use these functions directly please don't forget the
- *	verify_area().
+ *	access_ok().
  */
 
 static __inline__
--- linux-2.6.11-rc1-bk4-orig/arch/um/include/sysdep-x86_64/checksum.h	2005-01-12 23:26:04.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/um/include/sysdep-x86_64/checksum.h	2005-01-17 01:00:48.000000000 +0100
@@ -19,7 +19,7 @@ extern unsigned csum_partial(const unsig
  *	passed in an incorrect kernel address to one of these functions.
  *
  *	If you use these functions directly please don't forget the
- *	verify_area().
+ *	access_ok().
  */
 
 static __inline__
--- linux-2.6.11-rc1-bk4-orig/arch/arm/kernel/signal.c	2005-01-16 21:27:10.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/arm/kernel/signal.c	2005-01-17 01:01:23.000000000 +0100
@@ -102,7 +102,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -114,7 +114,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -317,7 +317,7 @@ asmlinkage int sys_sigreturn(struct pt_r
 
 	frame = (struct sigframe __user *)regs->ARM_sp;
 
-	if (verify_area(VERIFY_READ, frame, sizeof (*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
 	    || (_NSIG_WORDS > 1
@@ -365,7 +365,7 @@ asmlinkage int sys_rt_sigreturn(struct p
 
 	frame = (struct rt_sigframe __user *)regs->ARM_sp;
 
-	if (verify_area(VERIFY_READ, frame, sizeof (*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/frv/kernel/signal.c	2005-01-12 23:26:01.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/frv/kernel/signal.c	2005-01-17 01:02:04.000000000 +0100
@@ -114,7 +114,7 @@ asmlinkage int sys_sigaction(int sig,
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -126,7 +126,7 @@ asmlinkage int sys_sigaction(int sig,
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -197,7 +197,7 @@ asmlinkage int sys_sigreturn(void)
 	sigset_t set;
 	int gr8;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.sc_oldmask))
 		goto badframe;
@@ -228,7 +228,7 @@ asmlinkage int sys_rt_sigreturn(void)
 	stack_t st;
 	int gr8;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/parisc/kernel/sys_parisc32.c	2005-01-12 23:26:02.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/parisc/kernel/sys_parisc32.c	2005-01-17 01:02:20.000000000 +0100
@@ -428,7 +428,7 @@ get_fd_set32(unsigned long n, u32 *ufdse
 	if (ufdset) {
 		unsigned long odd;
 
-		if (verify_area(VERIFY_WRITE, ufdset, n*sizeof(u32)))
+		if (!access_ok(VERIFY_WRITE, ufdset, n*sizeof(u32)))
 			return -EFAULT;
 
 		odd = n & 1UL;
--- linux-2.6.11-rc1-bk4-orig/arch/cris/arch-v10/drivers/eeprom.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/cris/arch-v10/drivers/eeprom.c	2005-01-17 01:03:11.000000000 +0100
@@ -599,7 +599,7 @@ static ssize_t eeprom_write(struct file 
   int i, written, restart=1;
   unsigned long p;
 
-  if (verify_area(VERIFY_READ, buf, count))
+  if (!access_ok(VERIFY_READ, buf, count))
   {
     return -EFAULT;
   }
--- linux-2.6.11-rc1-bk4-orig/arch/cris/arch-v10/drivers/gpio.c	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/cris/arch-v10/drivers/gpio.c	2005-01-17 01:03:30.000000000 +0100
@@ -355,7 +355,7 @@ static ssize_t gpio_write(struct file * 
 		return -EFAULT;
 	}
     
-	if (verify_area(VERIFY_READ, buf, count)) {
+	if (!access_ok(VERIFY_READ, buf, count)) {
 		return -EFAULT;
 	}
 	clk_mask = priv->clk_mask;
--- linux-2.6.11-rc1-bk4-orig/arch/cris/arch-v10/kernel/signal.c	2004-12-24 22:33:50.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/cris/arch-v10/kernel/signal.c	2005-01-17 01:04:08.000000000 +0100
@@ -125,7 +125,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -137,7 +137,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -231,7 +231,7 @@ asmlinkage int sys_sigreturn(long r10, l
         if (((long)frame) & 3)
                 goto badframe;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
 	    || (_NSIG_WORDS > 1
@@ -273,7 +273,7 @@ asmlinkage int sys_rt_sigreturn(long r10
         if (((long)frame) & 3)
                 goto badframe;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/m32r/kernel/signal.c	2005-01-12 23:26:02.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/m32r/kernel/signal.c	2005-01-17 01:04:22.000000000 +0100
@@ -147,7 +147,7 @@ sys_rt_sigreturn(unsigned long r0, unsig
 	stack_t st;
 	int result;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/m32r/kernel/sys_m32r.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/m32r/kernel/sys_m32r.c	2005-01-17 01:05:21.000000000 +0100
@@ -171,9 +171,9 @@ asmlinkage int sys_ipc(uint call, int fi
 	case SHMAT: {
 		ulong raddr;
 
-		if ((ret = verify_area(VERIFY_WRITE, (ulong __user *) third,
-				      sizeof(ulong))))
-			return ret;
+		if (!access_ok(VERIFY_WRITE, (ulong __user *) third,
+				      sizeof(ulong)))
+			return -EFAULT;
 		ret = do_shmat (first, (char __user *) ptr, second, &raddr);
 		if (ret)
 			return ret;
--- linux-2.6.11-rc1-bk4-orig/arch/s390/kernel/signal.c	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/s390/kernel/signal.c	2005-01-17 20:01:42.000000000 +0100
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
@@ -214,7 +214,7 @@ asmlinkage long sys_sigreturn(struct pt_
 	sigframe __user *frame = (sigframe __user *)regs->gprs[15];
 	sigset_t set;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set.sig, &frame->sc.oldmask, _SIGMASK_COPY_SIZE))
 		goto badframe;
@@ -240,7 +240,7 @@ asmlinkage long sys_rt_sigreturn(struct 
 	rt_sigframe __user *frame = (rt_sigframe __user *)regs->gprs[15];
 	sigset_t set;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set.sig, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/s390/kernel/compat_signal.c	2005-01-12 23:26:03.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/s390/kernel/compat_signal.c	2005-01-17 20:02:38.000000000 +0100
@@ -223,7 +223,7 @@ sys32_sigaction(int sig, const struct ol
 
         if (act) {
 		compat_old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(sa_handler, &act->sa_handler) ||
 		    __get_user(sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -239,7 +239,7 @@ sys32_sigaction(int sig, const struct ol
 	if (!ret && oact) {
 		sa_handler = (unsigned long) old_ka.sa.sa_handler;
 		sa_restorer = (unsigned long) old_ka.sa.sa_restorer;
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(sa_handler, &oact->sa_handler) ||
 		    __put_user(sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -408,7 +408,7 @@ asmlinkage long sys32_sigreturn(struct p
 	sigframe32 __user *frame = (sigframe32 __user *)regs->gprs[15];
 	sigset_t set;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set.sig, &frame->sc.oldmask, _SIGMASK_COPY_SIZE32))
 		goto badframe;
@@ -438,7 +438,7 @@ asmlinkage long sys32_rt_sigreturn(struc
 	int err;
 	mm_segment_t old_fs = get_fs();
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/v850/kernel/signal.c	2004-12-24 22:35:49.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/v850/kernel/signal.c	2005-01-17 20:03:11.000000000 +0100
@@ -102,7 +102,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -114,7 +114,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -178,7 +178,7 @@ asmlinkage int sys_sigreturn(struct pt_r
 	sigset_t set;
 	int rval;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
@@ -209,7 +209,7 @@ asmlinkage int sys_rt_sigreturn(struct p
 	stack_t st;
 	int rval;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
--- linux-2.6.11-rc1-bk4-orig/arch/v850/kernel/syscalls.c	2004-12-24 22:35:00.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/v850/kernel/syscalls.c	2005-01-17 20:05:05.000000000 +0100
@@ -62,7 +62,7 @@ sys_ipc (uint call, int first, int secon
 
 		if (!ptr)
 			break;
-		if ((ret = verify_area (VERIFY_READ, ptr, sizeof(long)))
+		if ((ret = access_ok(VERIFY_READ, ptr, sizeof(long)) ? 0 : -EFAULT)
 		    || (ret = get_user(fourth.__pad, (void **)ptr)))
 			break;
 		ret = sys_semctl (first, second, third, fourth);
@@ -78,7 +78,7 @@ sys_ipc (uint call, int first, int secon
 
 			if (!ptr)
 				break;
-			if ((ret = verify_area (VERIFY_READ, ptr, sizeof(tmp)))
+			if ((ret = access_ok(VERIFY_READ, ptr, sizeof(tmp)) ? 0 : -EFAULT)
 			    || (ret = copy_from_user(&tmp,
 						(struct ipc_kludge *) ptr,
 						sizeof (tmp))))
@@ -104,8 +104,8 @@ sys_ipc (uint call, int first, int secon
 		default: {
 			ulong raddr;
 
-			if ((ret = verify_area(VERIFY_WRITE, (ulong*) third,
-					       sizeof(ulong))))
+			if ((ret = access_ok(VERIFY_WRITE, (ulong*) third,
+					       sizeof(ulong)) ? 0 : -EFAULT))
 				break;
 			ret = do_shmat (first, (char *) ptr, second, &raddr);
 			if (ret)
--- linux-2.6.11-rc1-bk4-orig/arch/sh64/kernel/signal.c	2005-01-16 21:27:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/sh64/kernel/signal.c	2005-01-17 20:05:32.000000000 +0100
@@ -125,7 +125,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -137,7 +137,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -293,7 +293,7 @@ asmlinkage int sys_sigreturn(unsigned lo
 	sigset_t set;
 	long long ret;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
@@ -330,7 +330,7 @@ asmlinkage int sys_rt_sigreturn(unsigned
 	stack_t __user st;
 	long long ret;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
--- linux-2.6.11-rc1-bk4-orig/arch/alpha/kernel/signal.c	2004-12-24 22:34:45.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/alpha/kernel/signal.c	2005-01-17 20:06:20.000000000 +0100
@@ -91,7 +91,7 @@ osf_sigaction(int sig, const struct osf_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_flags, &act->sa_flags))
 			return -EFAULT;
@@ -103,7 +103,7 @@ osf_sigaction(int sig, const struct osf_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags))
 			return -EFAULT;
@@ -298,7 +298,7 @@ do_sigreturn(struct sigcontext __user *s
 	sigset_t set;
 
 	/* Verify that it's a good sigcontext before using it */
-	if (verify_area(VERIFY_READ, sc, sizeof(*sc)))
+	if (!access_ok(VERIFY_READ, sc, sizeof(*sc)))
 		goto give_sigsegv;
 	if (__get_user(set.sig[0], &sc->sc_mask))
 		goto give_sigsegv;
@@ -336,7 +336,7 @@ do_rt_sigreturn(struct rt_sigframe __use
 	sigset_t set;
 
 	/* Verify that it's a good ucontext_t before using it */
-	if (verify_area(VERIFY_READ, &frame->uc, sizeof(frame->uc)))
+	if (!access_ok(VERIFY_READ, &frame->uc, sizeof(frame->uc)))
 		goto give_sigsegv;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto give_sigsegv;
@@ -446,7 +446,7 @@ setup_frame(int sig, struct k_sigaction 
 
 	oldsp = rdusp();
 	frame = get_sigframe(ka, oldsp, sizeof(*frame));
-	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
 
 	err |= setup_sigcontext(&frame->sc, regs, sw, set->sig[0], oldsp);
@@ -497,7 +497,7 @@ setup_rt_frame(int sig, struct k_sigacti
 
 	oldsp = rdusp();
 	frame = get_sigframe(ka, oldsp, sizeof(*frame));
-	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
 
 	err |= copy_siginfo_to_user(&frame->info, info);
--- linux-2.6.11-rc1-bk4-orig/arch/alpha/kernel/osf_sys.c	2004-12-24 22:33:47.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/alpha/kernel/osf_sys.c	2005-01-17 20:08:24.000000000 +0100
@@ -437,11 +437,10 @@ asmlinkage int
 osf_getdomainname(char __user *name, int namelen)
 {
 	unsigned len;
-	int i, error;
+	int i;
 
-	error = verify_area(VERIFY_WRITE, name, namelen);
-	if (error)
-		goto out;
+	if (!access_ok(VERIFY_WRITE, name, namelen))
+		return -EFAULT;
 
 	len = namelen;
 	if (namelen > 32)
@@ -454,8 +453,8 @@ osf_getdomainname(char __user *name, int
 			break;
 	}
 	up_read(&uts_sem);
- out:
-	return error;
+
+	return 0;
 }
 
 asmlinkage long
@@ -996,7 +995,7 @@ osf_select(int n, fd_set __user *inp, fd
 	if (tvp) {
 		time_t sec, usec;
 
-		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
+		if ((ret = access_ok(VERIFY_READ, tvp, sizeof(*tvp)) ? 0 : -EFAULT)
 		    || (ret = __get_user(sec, &tvp->tv_sec))
 		    || (ret = __get_user(usec, &tvp->tv_usec)))
 			goto out_nofds;
--- linux-2.6.11-rc1-bk4-orig/arch/arm26/kernel/signal.c	2004-12-24 22:34:27.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/arm26/kernel/signal.c	2005-01-17 20:08:53.000000000 +0100
@@ -102,7 +102,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -114,7 +114,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -186,7 +186,7 @@ asmlinkage int sys_sigreturn(struct pt_r
 
 	frame = (struct sigframe *)regs->ARM_sp;
 
-	if (verify_area(VERIFY_READ, frame, sizeof (*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
 	    || (_NSIG_WORDS > 1
@@ -231,7 +231,7 @@ asmlinkage int sys_rt_sigreturn(struct p
 
 	frame = (struct rt_sigframe *)regs->ARM_sp;
 
-	if (verify_area(VERIFY_READ, frame, sizeof (*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
--- linux-2.6.11-rc1-bk4-orig/arch/h8300/kernel/signal.c	2004-12-24 22:34:45.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/h8300/kernel/signal.c	2005-01-17 20:09:25.000000000 +0100
@@ -113,7 +113,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -125,7 +125,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -222,7 +222,7 @@ asmlinkage int do_sigreturn(unsigned lon
 	sigset_t set;
 	int er0;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.sc_mask) ||
 	    (_NSIG_WORDS > 1 &&
@@ -253,7 +253,7 @@ asmlinkage int do_rt_sigreturn(unsigned 
 	sigset_t set;
 	int er0;
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;



