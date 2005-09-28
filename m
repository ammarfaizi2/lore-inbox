Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVI1XQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVI1XQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVI1XQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:16:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:387 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1751229AbVI1XQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:16:04 -0400
Date: Thu, 29 Sep 2005 00:16:02 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: [PATCH] s390 signal annotations
Message-ID: <20050928231602.GH7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-mv64x60/arch/s390/kernel/compat_signal.c RC14-rc2-git6-s390-signal/arch/s390/kernel/compat_signal.c
--- RC14-rc2-git6-mv64x60/arch/s390/kernel/compat_signal.c	2005-09-05 07:05:14.000000000 -0400
+++ RC14-rc2-git6-s390-signal/arch/s390/kernel/compat_signal.c	2005-09-28 13:02:23.000000000 -0400
@@ -143,7 +143,7 @@
 			break;
 		case __SI_FAULT >> 16:
 			err |= __get_user(tmp, &from->si_addr);
-			to->si_addr = (void *)(u64) (tmp & PSW32_ADDR_INSN);
+			to->si_addr = (void __user *)(u64) (tmp & PSW32_ADDR_INSN);
 			break;
 		case __SI_POLL >> 16:
 			err |= __get_user(to->si_band, &from->si_band);
@@ -338,7 +338,7 @@
 		err |= __get_user(kss.ss_flags, &uss->ss_flags);
 		if (err)
 			return -EFAULT;
-		kss.ss_sp = (void *) ss_sp;
+		kss.ss_sp = (void __user *) ss_sp;
 	}
 
 	set_fs (KERNEL_DS);
@@ -461,7 +461,7 @@
 		goto badframe;
 
 	err = __get_user(ss_sp, &frame->uc.uc_stack.ss_sp);
-	st.ss_sp = (void *) A((unsigned long)ss_sp);
+	st.ss_sp = compat_ptr(ss_sp);
 	err |= __get_user(st.ss_size, &frame->uc.uc_stack.ss_size);
 	err |= __get_user(st.ss_flags, &frame->uc.uc_stack.ss_flags);
 	if (err)
diff -urN RC14-rc2-git6-mv64x60/arch/s390/kernel/signal.c RC14-rc2-git6-s390-signal/arch/s390/kernel/signal.c
--- RC14-rc2-git6-mv64x60/arch/s390/kernel/signal.c	2005-09-05 07:05:14.000000000 -0400
+++ RC14-rc2-git6-s390-signal/arch/s390/kernel/signal.c	2005-09-28 13:02:23.000000000 -0400
@@ -376,8 +376,8 @@
 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
-	err |= __put_user(0, &frame->uc.uc_link);
-	err |= __put_user((void *)current->sas_ss_sp, &frame->uc.uc_stack.ss_sp);
+	err |= __put_user(NULL, &frame->uc.uc_link);
+	err |= __put_user((void __user *)current->sas_ss_sp, &frame->uc.uc_stack.ss_sp);
 	err |= __put_user(sas_ss_flags(regs->gprs[15]),
 			  &frame->uc.uc_stack.ss_flags);
 	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
diff -urN RC14-rc2-git6-mv64x60/include/asm-s390/sigcontext.h RC14-rc2-git6-s390-signal/include/asm-s390/sigcontext.h
--- RC14-rc2-git6-mv64x60/include/asm-s390/sigcontext.h	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git6-s390-signal/include/asm-s390/sigcontext.h	2005-09-28 13:02:23.000000000 -0400
@@ -61,7 +61,7 @@
 struct sigcontext
 {
 	unsigned long	oldmask[_SIGCONTEXT_NSIG_WORDS];
-	_sigregs        *sregs;
+	_sigregs        __user *sregs;
 };
 
 
diff -urN RC14-rc2-git6-mv64x60/include/asm-s390/signal.h RC14-rc2-git6-s390-signal/include/asm-s390/signal.h
--- RC14-rc2-git6-mv64x60/include/asm-s390/signal.h	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git6-s390-signal/include/asm-s390/signal.h	2005-09-28 13:02:23.000000000 -0400
@@ -165,7 +165,7 @@
 #endif /* __KERNEL__ */
 
 typedef struct sigaltstack {
-        void *ss_sp;
+        void __user *ss_sp;
         int ss_flags;
         size_t ss_size;
 } stack_t;
