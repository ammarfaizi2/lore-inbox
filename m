Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWFDCQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWFDCQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 22:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWFDCQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 22:16:35 -0400
Received: from [198.99.130.12] ([198.99.130.12]:42669 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751426AbWFDCQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 22:16:14 -0400
Message-Id: <200606040216.k542GIXw004847@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/6] UML - more __user annotations
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Jun 2006 22:16:18 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fram: Al Viro <viro@zeniv.linux.org.uk>

uml __user annotations
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/sys-i386/syscalls.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/sys-i386/syscalls.c	2006-05-31 12:14:20.000000000 -0400
+++ linux-2.6.17-mm/arch/um/sys-i386/syscalls.c	2006-06-02 18:41:17.000000000 -0400
@@ -99,11 +99,12 @@ long sys_ipc (uint call, int first, int 
 
 	switch (call) {
 	case SEMOP:
-		return sys_semtimedop(first, (struct sembuf *) ptr, second,
-				      NULL);
+		return sys_semtimedop(first, (struct sembuf __user *) ptr,
+				      second, NULL);
 	case SEMTIMEDOP:
-		return sys_semtimedop(first, (struct sembuf *) ptr, second,
-				      (const struct timespec *) fifth);
+		return sys_semtimedop(first, (struct sembuf __user *) ptr,
+				      second,
+				      (const struct timespec __user *) fifth);
 	case SEMGET:
 		return sys_semget (first, second, third);
 	case SEMCTL: {
Index: linux-2.6.17-mm/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/sys-x86_64/signal.c	2006-05-31 12:14:20.000000000 -0400
+++ linux-2.6.17-mm/arch/um/sys-x86_64/signal.c	2006-06-02 18:41:52.000000000 -0400
@@ -21,7 +21,7 @@
 #include "skas.h"
 
 static int copy_sc_from_user_skas(struct pt_regs *regs,
-                                 struct sigcontext *from)
+                                 struct sigcontext __user *from)
 {
        int err = 0;
 
@@ -54,7 +54,8 @@ static int copy_sc_from_user_skas(struct
        return(err);
 }
 
-int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate *to_fp,
+int copy_sc_to_user_skas(struct sigcontext __user *to,
+			 struct _fpstate __user *to_fp,
 			 struct pt_regs *regs, unsigned long mask,
 			 unsigned long sp)
 {
@@ -106,10 +107,11 @@ int copy_sc_to_user_skas(struct sigconte
 #endif
 
 #ifdef CONFIG_MODE_TT
-int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext *from,
+int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext __user *from,
 			 int fpsize)
 {
-	struct _fpstate *to_fp, *from_fp;
+	struct _fpstate *to_fp;
+	struct _fpstate __user *from_fp;
 	unsigned long sigs;
 	int err;
 
@@ -124,13 +126,14 @@ int copy_sc_from_user_tt(struct sigconte
 	return(err);
 }
 
-int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate *fp,
+int copy_sc_to_user_tt(struct sigcontext __user *to, struct _fpstate __user *fp,
 		       struct sigcontext *from, int fpsize, unsigned long sp)
 {
-	struct _fpstate *to_fp, *from_fp;
+	struct _fpstate __user *to_fp;
+	struct _fpstate *from_fp;
 	int err;
 
-	to_fp = (fp ? fp : (struct _fpstate *) (to + 1));
+	to_fp = (fp ? fp : (struct _fpstate __user *) (to + 1));
 	from_fp = from->fpstate;
 	err = copy_to_user(to, from, sizeof(*to));
 	/* The SP in the sigcontext is the updated one for the signal
@@ -158,7 +161,8 @@ static int copy_sc_from_user(struct pt_r
        return(ret);
 }
 
-static int copy_sc_to_user(struct sigcontext *to, struct _fpstate *fp,
+static int copy_sc_to_user(struct sigcontext __user *to,
+			   struct _fpstate __user *fp,
 			   struct pt_regs *from, unsigned long mask,
 			   unsigned long sp)
 {
@@ -169,7 +173,7 @@ static int copy_sc_to_user(struct sigcon
 
 struct rt_sigframe
 {
-       char *pretcode;
+       char __user *pretcode;
        struct ucontext uc;
        struct siginfo info;
 };
@@ -188,7 +192,7 @@ int setup_signal_stack_si(unsigned long 
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-        frame = (struct rt_sigframe *) ((unsigned long) frame - 128);
+        frame = (struct rt_sigframe __user *) ((unsigned long) frame - 128);
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;
Index: linux-2.6.17-mm/include/asm-um/uaccess.h
===================================================================
--- linux-2.6.17-mm.orig/include/asm-um/uaccess.h	2006-05-31 12:14:23.000000000 -0400
+++ linux-2.6.17-mm/include/asm-um/uaccess.h	2006-06-02 18:42:08.000000000 -0400
@@ -41,11 +41,11 @@
 
 #define __get_user(x, ptr) \
 ({ \
-	const __typeof__(ptr) __private_ptr = ptr;	\
+	const __typeof__(*(ptr)) __user *__private_ptr = (ptr);	\
 	__typeof__(x) __private_val;			\
 	int __private_ret = -EFAULT;			\
 	(x) = (__typeof__(*(__private_ptr)))0;				\
-	if (__copy_from_user((void *) &__private_val, (__private_ptr),	\
+	if (__copy_from_user((__force void *)&__private_val, (__private_ptr),\
 			     sizeof(*(__private_ptr))) == 0) {		\
 		(x) = (__typeof__(*(__private_ptr))) __private_val;	\
 		__private_ret = 0;					\
@@ -62,7 +62,7 @@
 
 #define __put_user(x, ptr) \
 ({ \
-        __typeof__(ptr) __private_ptr = ptr; \
+        __typeof__(*(ptr)) __user *__private_ptr = ptr; \
         __typeof__(*(__private_ptr)) __private_val; \
         int __private_ret = -EFAULT; \
         __private_val = (__typeof__(*(__private_ptr))) (x); \

