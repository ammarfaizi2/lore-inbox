Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVCGTK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVCGTK4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVCGTJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:09:37 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:3590 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261247AbVCGTHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:07:40 -0500
Message-Id: <200503072037.j27Kbjbc003962@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/16] UML - Fix some usercopy confusion
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:37:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a couple of copy-user problems spotted by Al Viro.  
copy_sc_from_user_tt was doing a copy_from_user to do an in-kernel 
assignment.  I commented this, at the request of Chris Wedgewood.
sys_ipc had a void *__user ptr which should have been void __user *ptr.
Finally, there were a couple of bogus __user annotations on unsigned longs, 
which were never going to be passed into copy_user.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/signal.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/sys-i386/signal.c	2005-03-05 12:10:27.000000000 -0500
@@ -108,6 +108,15 @@
 #endif
 
 #ifdef CONFIG_MODE_TT
+
+/* These copy a sigcontext to/from userspace.  They copy the fpstate pointer,
+ * blowing away the old, good one.  So, that value is saved, and then restored
+ * after the sigcontext copy.  In copy_from, the variable holding the saved
+ * fpstate pointer, and the sigcontext that it should be restored to are both
+ * in the kernel, so we can just restore using an assignment.  In copy_to, the
+ * saved pointer is in the kernel, but the sigcontext is in userspace, so we
+ * copy_to_user it.
+ */
 int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext *from,
 			 int fpsize)
 {
@@ -120,11 +129,9 @@
 	sigs = to->oldmask;
 	err = copy_from_user(to, from, sizeof(*to));
 	to->oldmask = sigs;
-	if(to_fp != NULL){
-		err |= copy_from_user(&to->fpstate, &to_fp,
-				      sizeof(to->fpstate));
+	to->fpstate = to_fp;
+	if(to_fp != NULL)
 		err |= copy_from_user(to_fp, from_fp, fpsize);
-	}
 	return(err);
 }
 
@@ -138,8 +145,7 @@
 	from_fp = from->fpstate;
 	err = copy_to_user(to, from, sizeof(*to));
 	if(from_fp != NULL){
-		err |= copy_to_user(&to->fpstate, &to_fp,
-					 sizeof(to->fpstate));
+		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));
 		err |= copy_to_user(to_fp, from_fp, fpsize);
 	}
 	return(err);
@@ -303,7 +309,7 @@
 
 long sys_sigreturn(struct pt_regs regs)
 {
-	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
+	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct sigframe __user *frame = (struct sigframe *)(sp - 8);
 	sigset_t set;
 	struct sigcontext __user *sc = &frame->sc;
Index: linux-2.6.11/arch/um/sys-i386/syscalls.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/syscalls.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/sys-i386/syscalls.c	2005-03-05 12:10:27.000000000 -0500
@@ -88,7 +88,7 @@
  * This is really horribly ugly.
  */
 long sys_ipc (uint call, int first, int second,
-	     int third, void *__user ptr, long fifth)
+	     int third, void __user *ptr, long fifth)
 {
 	int version, ret;
 
Index: linux-2.6.11/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-x86_64/signal.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/sys-x86_64/signal.c	2005-03-05 12:10:27.000000000 -0500
@@ -237,7 +237,7 @@
 
 long sys_rt_sigreturn(struct pt_regs *regs)
 {
-	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
+	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct rt_sigframe __user *frame =
 		(struct rt_sigframe __user *)(sp - 8);
 	struct ucontext __user *uc = &frame->uc;

