Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319197AbSIKQKz>; Wed, 11 Sep 2002 12:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSIKQKz>; Wed, 11 Sep 2002 12:10:55 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:17069 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S319197AbSIKQGz> convert rfc822-to-8bit; Wed, 11 Sep 2002 12:06:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.34 s390 fixes (3/10): fpu cleanup.
Date: Wed, 11 Sep 2002 18:08:24 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111801.03600.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
this patch is a cleanup for the fpu loading/storing in the s390 kernels.

blue skies,
  Martin.

diff -urN linux-2.5.34/arch/s390/kernel/Makefile linux-2.5.34-s390/arch/s390/kernel/Makefile
--- linux-2.5.34/arch/s390/kernel/Makefile	Wed Sep 11 13:29:03 2002
+++ linux-2.5.34-s390/arch/s390/kernel/Makefile	Wed Sep 11 13:29:23 2002
@@ -10,7 +10,7 @@
 export-objs	:= debug.o ebcdic.o s390_ext.o smp.o s390_ksyms.o
 obj-y	:= entry.o bitmap.o traps.o time.o process.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-            semaphore.o s390fpu.o reipl.o s390_ext.o debug.o
+            semaphore.o reipl.o s390_ext.o debug.o
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o
 obj-$(CONFIG_SMP)		+= smp.o
diff -urN linux-2.5.34/arch/s390/kernel/s390fpu.c linux-2.5.34-s390/arch/s390/kernel/s390fpu.c
--- linux-2.5.34/arch/s390/kernel/s390fpu.c	Mon Sep  9 19:35:02 2002
+++ linux-2.5.34-s390/arch/s390/kernel/s390fpu.c	Thu Jan  1 01:00:00 1970
@@ -1,138 +0,0 @@
-/*
- *  arch/s390/kernel/s390fpu.c
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
- *
- *  s390fpu.h functions for saving & restoring the fpu state.
- *
- *  I couldn't inline these as linux/sched.h included half the world
- *  & was required to at the task structure.
- *  & the functions were too complex to make macros from.
- *  ( & as usual I didn't feel like debugging inline code ).
- */
-
-#include <linux/config.h>
-#include <linux/sched.h>
-
-int save_fp_regs1(s390_fp_regs *fpregs)
-{
-	int has_ieee=MACHINE_HAS_IEEE;
-/*
-  I don't think we can use STE here as this would load
-  fp registers 0 & 2 into memory locations 0 & 1 etc. 
- */	
-	asm volatile ("STD   0,8(%0)\n\t"
-		      "STD   2,24(%0)\n\t"
-		      "STD   4,40(%0)\n\t"
-		      "STD   6,56(%0)"
-                      : 
-		      : "a" (fpregs)
-		      : "memory"
-		);
-	if(has_ieee)
-	{
-		asm volatile ("STFPC 0(%0)\n\t"
-			      "STD   1,16(%0)\n\t"
-			      "STD   3,32(%0)\n\t"
-			      "STD   5,48(%0)\n\t"
-			      "STD   7,64(%0)\n\t"
-			      "STD   8,72(%0)\n\t"
-			      "STD   9,80(%0)\n\t"
-			      "STD   10,88(%0)\n\t"
-			      "STD   11,96(%0)\n\t"
-			      "STD   12,104(%0)\n\t"
-			      "STD   13,112(%0)\n\t"
-			      "STD   14,120(%0)\n\t"
-			      "STD   15,128(%0)\n\t"
-			      : 
-			      : "a" (fpregs)
-			      : "memory"
-			);
-	}
-	return(has_ieee);
-}
-
-
-void save_fp_regs(s390_fp_regs *fpregs)
-{
-#if CONFIG_MATHEMU
-	s390_fp_regs *currentfprs;
-
-	if(!save_fp_regs1(fpregs))
-	{
-		currentfprs=&current->thread.fp_regs;
-		fpregs->fpc=currentfprs->fpc;
-		fpregs->fprs[1].d=currentfprs->fprs[1].d;
-		fpregs->fprs[3].d=currentfprs->fprs[3].d;
-		fpregs->fprs[5].d=currentfprs->fprs[5].d;
-		fpregs->fprs[7].d=currentfprs->fprs[7].d;
-		memcpy(&fpregs->fprs[8].d,&currentfprs->fprs[8].d,sizeof(freg_t)*8);
-	}
-#else
-	save_fp_regs1(fpregs);
-#endif
-}
-
-
-int restore_fp_regs1(s390_fp_regs *fpregs)
-{
-	int has_ieee=MACHINE_HAS_IEEE;
-
-	/* If we don't mask with the FPC_VALID_MASK here
-	 * we've got a very quick shutdown -h now command
-         * via a kernel specification exception.
-	 */
-	fpregs->fpc&=FPC_VALID_MASK;
-	asm volatile ("LD   0,8(%0)\n\t"
-		      "LD   2,24(%0)\n\t"
-		      "LD   4,40(%0)\n\t"
-		      "LD   6,56(%0)"
-                      : 
-		      : "a" (fpregs)
-		      : "memory"
-		);
-	if(has_ieee)
-	{
-		asm volatile ("LFPC 0(%0)\n\t"
-			      "LD   1,16(%0)\n\t"
-			      "LD   3,32(%0)\n\t"
-			      "LD   5,48(%0)\n\t"
-			      "LD   7,64(%0)\n\t"
-			      "LD   8,72(%0)\n\t"
-			      "LD   9,80(%0)\n\t"
-			      "LD   10,88(%0)\n\t"
-			      "LD   11,96(%0)\n\t"
-			      "LD   12,104(%0)\n\t"
-			      "LD   13,112(%0)\n\t"
-			      "LD   14,120(%0)\n\t"
-			      "LD   15,128(%0)\n\t"
-			      : 
-			      : "a" (fpregs)
-			      : "memory"
-			);
-	}
-	return(has_ieee);
-}
-
-void restore_fp_regs(s390_fp_regs *fpregs)
-{
-#if CONFIG_MATHEMU
-	s390_fp_regs *currentfprs;
-
-	if(!restore_fp_regs1(fpregs))
-	{
-		currentfprs=&current->thread.fp_regs;
-		currentfprs->fpc=fpregs->fpc;
-		currentfprs->fprs[1].d=fpregs->fprs[1].d;
-		currentfprs->fprs[3].d=fpregs->fprs[3].d;
-		currentfprs->fprs[5].d=fpregs->fprs[5].d;
-		currentfprs->fprs[7].d=fpregs->fprs[7].d;
-		memcpy(&currentfprs->fprs[8].d,&fpregs->fprs[8].d,sizeof(freg_t)*8);
-	}
-#else
-	restore_fp_regs1(fpregs);
-#endif
-}
-
diff -urN linux-2.5.34/arch/s390/kernel/signal.c linux-2.5.34-s390/arch/s390/kernel/signal.c
--- linux-2.5.34/arch/s390/kernel/signal.c	Mon Sep  9 19:35:05 2002
+++ linux-2.5.34-s390/arch/s390/kernel/signal.c	Wed Sep 11 13:29:13 2002
@@ -49,13 +49,14 @@
 	struct ucontext uc;
 } rt_sigframe;
 
-asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
+int do_signal(struct pt_regs *regs, sigset_t *oldset);
 
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
 asmlinkage int
-sys_sigsuspend(struct pt_regs * regs,int history0, int history1, old_sigset_t mask)
+sys_sigsuspend(struct pt_regs * regs, int history0, int history1,
+	       old_sigset_t mask)
 {
 	sigset_t saveset;
 
@@ -147,37 +148,39 @@
 static int save_sigregs(struct pt_regs *regs,_sigregs *sregs)
 {
 	int err;
-	s390_fp_regs fpregs;
   
-	err = __copy_to_user(&sregs->regs,regs,sizeof(_s390_regs_common));
-	if(!err)
-	{
-		save_fp_regs(&fpregs);
-		err=__copy_to_user(&sregs->fpregs,&fpregs,sizeof(fpregs));
-	}
-	return(err);
-	
+	err = __copy_to_user(&sregs->regs, regs, sizeof(_s390_regs_common));
+	if (err != 0)
+		return err;
+	/* 
+	 * We have to store the fp registers to current->thread.fp_regs
+	 * to merge them with the emulated registers.
+	 */
+	save_fp_regs(&current->thread.fp_regs);
+	return __copy_to_user(&sregs->fpregs, &current->thread.fp_regs, 
+			      sizeof(s390_fp_regs));
 }
 
 /* Returns positive number on error */
 static int restore_sigregs(struct pt_regs *regs,_sigregs *sregs)
 {
 	int err;
-	s390_fp_regs fpregs;
-	psw_t saved_psw=regs->psw;
-	err=__copy_from_user(regs,&sregs->regs,sizeof(_s390_regs_common));
-	if(!err)
-	{
-		regs->trap = -1;		/* disable syscall checks */
-		regs->psw.mask=(saved_psw.mask&~PSW_MASK_DEBUGCHANGE)|
-		(regs->psw.mask&PSW_MASK_DEBUGCHANGE);
-		regs->psw.addr=(saved_psw.addr&~PSW_ADDR_DEBUGCHANGE)|
-		(regs->psw.addr&PSW_ADDR_DEBUGCHANGE);
-		err=__copy_from_user(&fpregs,&sregs->fpregs,sizeof(fpregs));
-		if(!err)
-			restore_fp_regs(&fpregs);
-	}
-	return(err);
+
+	err = __copy_from_user(regs, &sregs->regs, sizeof(_s390_regs_common));
+	regs->psw.mask = _USER_PSW_MASK | (regs->psw.mask & PSW_MASK_DEBUGCHANGE);
+	regs->psw.addr |= _ADDR_31;
+	if (err)
+		return err;
+
+	err = __copy_from_user(&current->thread.fp_regs, &sregs->fpregs,
+			       sizeof(s390_fp_regs));
+	current->thread.fp_regs.fpc &= FPC_VALID_MASK;
+	if (err)
+		return err;
+
+	restore_fp_regs(&current->thread.fp_regs);
+	regs->trap = -1;	/* disable syscall checks */
+	return 0;
 }
 
 asmlinkage long sys_sigreturn(struct pt_regs *regs)
diff -urN linux-2.5.34/arch/s390x/kernel/Makefile linux-2.5.34-s390/arch/s390x/kernel/Makefile
--- linux-2.5.34/arch/s390x/kernel/Makefile	Wed Sep 11 13:29:03 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/Makefile	Wed Sep 11 13:29:29 2002
@@ -12,7 +12,7 @@
 
 obj-y		:= entry.o bitmap.o traps.o time.o process.o \
 		   setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-		   semaphore.o s390fpu.o reipl.o s390_ext.o debug.o
+		   semaphore.o reipl.o s390_ext.o debug.o
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o
 obj-$(CONFIG_SMP)		+= smp.o
diff -urN linux-2.5.34/arch/s390x/kernel/s390fpu.c linux-2.5.34-s390/arch/s390x/kernel/s390fpu.c
--- linux-2.5.34/arch/s390x/kernel/s390fpu.c	Mon Sep  9 19:35:26 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/s390fpu.c	Thu Jan  1 01:00:00 1970
@@ -1,87 +0,0 @@
-/*
- *  arch/s390/kernel/s390fpu.c
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
- *
- *  s390fpu.h functions for saving & restoring the fpu state.
- *
- *  I couldn't inline these as linux/sched.h included half the world
- *  & was required to at the task structure.
- *  & the functions were too complex to make macros from.
- *  ( & as usual I didn't feel like debugging inline code ).
- */
-
-#include <linux/sched.h>
-
-void save_fp_regs(s390_fp_regs *fpregs)
-{
-/*
- * I don't think we can use STE here as this would load
- * fp registers 0 & 2 into memory locations 0 & 1 etc. 
- */	
-	asm volatile ("STFPC 0(%0)\n\t"
-		      "STD   0,8(%0)\n\t"
-		      "STD   1,16(%0)\n\t"
-		      "STD   2,24(%0)\n\t"
-		      "STD   3,32(%0)\n\t"
-		      "STD   4,40(%0)\n\t"
-		      "STD   5,48(%0)\n\t"
-		      "STD   6,56(%0)\n\t"
-		      "STD   7,64(%0)\n\t"
-		      "STD   8,72(%0)\n\t"
-		      "STD   9,80(%0)\n\t"
-		      "STD   10,88(%0)\n\t"
-		      "STD   11,96(%0)\n\t"
-		      "STD   12,104(%0)\n\t"
-		      "STD   13,112(%0)\n\t"
-		      "STD   14,120(%0)\n\t"
-		      "STD   15,128(%0)\n\t"
-                      : 
-		      : "a" (fpregs)
-		      : "memory"
-		);
-}
-
-void restore_fp_regs(s390_fp_regs *fpregs)
-{
-	/* If we don't mask with the FPC_VALID_MASK here
-	 * we've got a very quick shutdown -h now command
-         * via a kernel specification exception.
-	 */
-	fpregs->fpc&=FPC_VALID_MASK;
-	asm volatile ("LFPC 0(%0)\n\t"
-		      "LD   0,8(%0)\n\t"
-		      "LD   1,16(%0)\n\t"
-		      "LD   2,24(%0)\n\t"
-		      "LD   3,32(%0)\n\t"
-		      "LD   4,40(%0)\n\t"
-		      "LD   5,48(%0)\n\t"
-		      "LD   6,56(%0)\n\t"
-		      "LD   7,64(%0)\n\t"
-		      "LD   8,72(%0)\n\t"
-		      "LD   9,80(%0)\n\t"
-		      "LD   10,88(%0)\n\t"
-		      "LD   11,96(%0)\n\t"
-		      "LD   12,104(%0)\n\t"
-		      "LD   13,112(%0)\n\t"
-		      "LD   14,120(%0)\n\t"
-		      "LD   15,128(%0)\n\t"
-                      : 
-		      : "a" (fpregs)
-		      : "memory"
-		);
-}
-
-
-
-
-
-
-
-
-
-
-
-
diff -urN linux-2.5.34/arch/s390x/kernel/signal.c linux-2.5.34-s390/arch/s390x/kernel/signal.c
--- linux-2.5.34/arch/s390x/kernel/signal.c	Mon Sep  9 19:35:02 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/signal.c	Wed Sep 11 13:29:13 2002
@@ -144,40 +144,37 @@
 
 
 /* Returns non-zero on fault */
-static int save_sigregs(struct pt_regs *regs,_sigregs *sregs)
+static int save_sigregs(struct pt_regs *regs, _sigregs *sregs)
 {
 	int err;
-	s390_fp_regs fpregs;
   
-	err = __copy_to_user(&sregs->regs,regs,sizeof(_s390_regs_common));
-	if(!err)
-	{
-		save_fp_regs(&fpregs);
-		err=__copy_to_user(&sregs->fpregs,&fpregs,sizeof(fpregs));
-	}
-	return(err);
-	
+	err = __copy_to_user(&sregs->regs, regs, sizeof(_s390_regs_common));
+	if (err != 0)
+		return err;
+	save_fp_regs(&current->thread.fp_regs);
+	return __copy_to_user(&sregs->fpregs, &current->thread.fp_regs,
+			      sizeof(s390_fp_regs));
 }
 
 /* Returns positive number on error */
-static int restore_sigregs(struct pt_regs *regs,_sigregs *sregs)
+static int restore_sigregs(struct pt_regs *regs, _sigregs *sregs)
 {
 	int err;
-	s390_fp_regs fpregs;
-	psw_t saved_psw=regs->psw;
-	err=__copy_from_user(regs,&sregs->regs,sizeof(_s390_regs_common));
-	if(!err)
-	{
-		regs->trap = -1;		/* disable syscall checks */
-		regs->psw.mask=(saved_psw.mask&~PSW_MASK_DEBUGCHANGE)|
-		(regs->psw.mask&PSW_MASK_DEBUGCHANGE);
-		regs->psw.addr=(saved_psw.addr&~PSW_ADDR_DEBUGCHANGE)|
-		(regs->psw.addr&PSW_ADDR_DEBUGCHANGE);
-		err=__copy_from_user(&fpregs,&sregs->fpregs,sizeof(fpregs));
-		if(!err)
-			restore_fp_regs(&fpregs);
-	}
-	return(err);
+
+	err = __copy_from_user(regs, &sregs->regs, sizeof(_s390_regs_common));
+	regs->psw.mask = _USER_PSW_MASK | (regs->psw.mask & PSW_MASK_DEBUGCHANGE);
+	if (err)
+		return err;
+
+	err = __copy_from_user(&current->thread.fp_regs, &sregs->fpregs,
+			       sizeof(s390_fp_regs));
+	current->thread.fp_regs.fpc &= FPC_VALID_MASK;
+	if (err)
+		return err;
+
+	restore_fp_regs(&current->thread.fp_regs);
+	regs->trap = -1;	/* disable syscall checks */
+	return 0;
 }
 
 asmlinkage long sys_sigreturn(struct pt_regs *regs)
diff -urN linux-2.5.34/arch/s390x/kernel/signal32.c linux-2.5.34-s390/arch/s390x/kernel/signal32.c
--- linux-2.5.34/arch/s390x/kernel/signal32.c	Mon Sep  9 19:35:11 2002
+++ linux-2.5.34-s390/arch/s390x/kernel/signal32.c	Wed Sep 11 13:29:13 2002
@@ -32,7 +32,11 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
+#define _ADDR_31 0x80000000
+#define _USER_PSW_MASK_EMU32 0x070DC000
 #define _USER_PSW_MASK32 0x0705C00080000000
+#define PSW_MASK_DEBUGCHANGE32 0x00003000UL
+#define PSW_ADDR_DEBUGCHANGE32 0x7FFFFFFFUL
 
 typedef struct 
 {
@@ -290,55 +294,48 @@
 
 static int save_sigregs32(struct pt_regs *regs,_sigregs32 *sregs)
 {
-	int err = 0;
-	s390_fp_regs fpregs;
-	int i;
-
-	for(i=0; i<NUM_GPRS; i++) 
-		err |= __put_user(regs->gprs[i], &sregs->regs.gprs[i]);  
-	for(i=0; i<NUM_ACRS; i++)
-		err |= __put_user(regs->acrs[i], &sregs->regs.acrs[i]);  
-	err |= __copy_to_user(&sregs->regs.psw.mask, &regs->psw.mask, 4);
-	err |= __copy_to_user(&sregs->regs.psw.addr, ((char*)&regs->psw.addr)+4, 4);
-	if(!err)
-	{
-		save_fp_regs(&fpregs);
-		__put_user(fpregs.fpc, &sregs->fpregs.fpc);
-		for(i=0; i<NUM_FPRS; i++)
-			err |= __put_user(fpregs.fprs[i].d, &sregs->fpregs.fprs[i].d);  
-	}
-	return(err);
-	
+	_s390_regs_common32 regs32;
+	int err, i;
+
+	regs32.psw.mask = _USER_PSW_MASK_EMU32 |
+		(__u32)((regs->psw.mask & PSW_MASK_DEBUGCHANGE) >> 32);
+	regs32.psw.addr = _ADDR_31 | (__u32) regs->psw.addr;
+	for (i = 0; i < NUM_GPRS; i++)
+		regs32.gprs[i] = (__u32) regs->gprs[i];
+	memcpy(regs32.acrs, regs->acrs, sizeof(regs32.acrs));
+	err = __copy_to_user(&sregs->regs, &regs32, sizeof(regs32));
+	if (err)
+		return err;
+	save_fp_regs(&current->thread.fp_regs);
+	/* s390_fp_regs and _s390_fp_regs32 are the same ! */
+	return __copy_to_user(&sregs->fpregs, &current->thread.fp_regs,
+			      sizeof(_s390_fp_regs32));
 }
 
 static int restore_sigregs32(struct pt_regs *regs,_sigregs32 *sregs)
 {
-	int err = 0;
-	s390_fp_regs fpregs;
-	psw_t saved_psw=regs->psw;
-	int i;
-
-	for(i=0; i<NUM_GPRS; i++)
-		err |= __get_user(regs->gprs[i], &sregs->regs.gprs[i]);  
-	for(i=0; i<NUM_ACRS; i++)
-		err |= __get_user(regs->acrs[i], &sregs->regs.acrs[i]);  
-	err |= __copy_from_user(&regs->psw.mask, &sregs->regs.psw.mask, 4);
-	err |= __copy_from_user(((char*)&regs->psw.addr)+4, &sregs->regs.psw.addr, 4);
-
-	if(!err)
-	{
-		regs->trap = -1;		/* disable syscall checks */
-		regs->psw.mask=(saved_psw.mask&~PSW_MASK_DEBUGCHANGE)|
-		(regs->psw.mask&PSW_MASK_DEBUGCHANGE);
-		regs->psw.addr=(saved_psw.addr&~PSW_ADDR_DEBUGCHANGE)|
-		(regs->psw.addr&PSW_ADDR_DEBUGCHANGE);
-		__get_user(fpregs.fpc, &sregs->fpregs.fpc);
-                for(i=0; i<NUM_FPRS; i++)
-                        err |= __get_user(fpregs.fprs[i].d, &sregs->fpregs.fprs[i].d);              
-		if(!err)
-			restore_fp_regs(&fpregs);
-	}
-	return(err);
+	_s390_regs_common32 regs32;
+	int err, i;
+
+	err = __copy_from_user(&regs32, &sregs->regs, sizeof(regs32));
+	if (err)
+		return err;
+	regs->psw.mask = _USER_PSW_MASK32 |
+		(__u64)(regs32.psw.mask & PSW_MASK_DEBUGCHANGE32) << 32;
+	regs->psw.addr = (__u64)(regs32.psw.addr & PSW_ADDR_DEBUGCHANGE32);
+	for (i = 0; i < NUM_GPRS; i++)
+		regs->gprs[i] = (__u64) regs32.gprs[i];
+	memcpy(regs->acrs, regs32.acrs, sizeof(regs32.acrs));
+
+	err = __copy_from_user(&current->thread.fp_regs, &sregs->fpregs,
+			       sizeof(_s390_fp_regs32));
+	current->thread.fp_regs.fpc &= FPC_VALID_MASK;
+	if (err)
+		return err;
+
+	restore_fp_regs(&current->thread.fp_regs);
+	regs->trap = -1;	/* disable syscall checks */
+	return 0;
 }
 
 asmlinkage long sys32_sigreturn(struct pt_regs *regs)
diff -urN linux-2.5.34/include/asm-s390/system.h linux-2.5.34-s390/include/asm-s390/system.h
--- linux-2.5.34/include/asm-s390/system.h	Wed Sep 11 13:29:03 2002
+++ linux-2.5.34-s390/include/asm-s390/system.h	Wed Sep 11 13:29:13 2002
@@ -12,21 +12,78 @@
 #define __ASM_SYSTEM_H
 
 #include <linux/config.h>
+#include <linux/kernel.h>
 #include <asm/types.h>
+#include <asm/ptrace.h>
+#include <asm/setup.h>
+
 #ifdef __KERNEL__
-#include <asm/lowcore.h>
-#endif
-#include <linux/kernel.h>
+
+struct task_struct;
+
+extern struct task_struct *resume(void *, void *);
+
+static inline void save_fp_regs(s390_fp_regs *fpregs)
+{
+	asm volatile (
+		"   std   0,8(%0)\n"
+		"   std   2,24(%0)\n"
+		"   std   4,40(%0)\n"
+		"   std   6,56(%0)"
+		: : "a" (fpregs) : "memory" );
+	if (!MACHINE_HAS_IEEE)
+		return;
+	asm volatile(
+		"   stfpc 0(%0)\n"
+		"   std   1,16(%0)\n"
+		"   std   3,32(%0)\n"
+		"   std   5,48(%0)\n"
+		"   std   7,64(%0)\n"
+		"   std   8,72(%0)\n"
+		"   std   9,80(%0)\n"
+		"   std   10,88(%0)\n"
+		"   std   11,96(%0)\n"
+		"   std   12,104(%0)\n"
+		"   std   13,112(%0)\n"
+		"   std   14,120(%0)\n"
+		"   std   15,128(%0)\n"
+		: : "a" (fpregs) : "memory" );
+}
+
+static inline void restore_fp_regs(s390_fp_regs *fpregs)
+{
+	asm volatile (
+		"   ld    0,8(%0)\n"
+		"   ld    2,24(%0)\n"
+		"   ld    4,40(%0)\n"
+		"   ld    6,56(%0)"
+		: : "a" (fpregs));
+	if (!MACHINE_HAS_IEEE)
+		return;
+	asm volatile(
+		"   lfpc  0(%0)\n"
+		"   ld    1,16(%0)\n"
+		"   ld    3,32(%0)\n"
+		"   ld    5,48(%0)\n"
+		"   ld    7,64(%0)\n"
+		"   ld    8,72(%0)\n"
+		"   ld    9,80(%0)\n"
+		"   ld    10,88(%0)\n"
+		"   ld    11,96(%0)\n"
+		"   ld    12,104(%0)\n"
+		"   ld    13,112(%0)\n"
+		"   ld    14,120(%0)\n"
+		"   ld    15,128(%0)\n"
+		: : "a" (fpregs));
+}
 
 #define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
-	save_fp_regs1(&prev->thread.fp_regs);				     \
-	restore_fp_regs1(&next->thread.fp_regs);			     \
+	save_fp_regs(&prev->thread.fp_regs);				     \
+	restore_fp_regs(&next->thread.fp_regs);				     \
 	resume(prev,next);						     \
 } while (0)
-
-struct task_struct;
 
 #define nop() __asm__ __volatile__ ("nop")
 
diff -urN linux-2.5.34/include/asm-s390x/system.h linux-2.5.34-s390/include/asm-s390x/system.h
--- linux-2.5.34/include/asm-s390x/system.h	Wed Sep 11 13:29:03 2002
+++ linux-2.5.34-s390/include/asm-s390x/system.h	Wed Sep 11 13:29:13 2002
@@ -12,21 +12,70 @@
 #define __ASM_SYSTEM_H
 
 #include <linux/config.h>
+#include <linux/kernel.h>
 #include <asm/types.h>
+#include <asm/ptrace.h>
+#include <asm/setup.h>
+
 #ifdef __KERNEL__
-#include <asm/lowcore.h>
-#endif
-#include <linux/kernel.h>
 
-#define switch_to(prev,next),last do {					     \
+struct task_struct;
+
+extern struct task_struct *resume(void *, void *);
+
+static inline void save_fp_regs(s390_fp_regs *fpregs)
+{
+	asm volatile (
+		"   stfpc 0(%0)\n"
+		"   std   0,8(%0)\n"
+		"   std   1,16(%0)\n"
+		"   std   2,24(%0)\n"
+		"   std   3,32(%0)\n"
+		"   std   4,40(%0)\n"
+		"   std   5,48(%0)\n"
+		"   std   6,56(%0)\n"
+		"   std   7,64(%0)\n"
+		"   std   8,72(%0)\n"
+		"   std   9,80(%0)\n"
+		"   std   10,88(%0)\n"
+		"   std   11,96(%0)\n"
+		"   std   12,104(%0)\n"
+		"   std   13,112(%0)\n"
+		"   std   14,120(%0)\n"
+		"   std   15,128(%0)\n"
+		: : "a" (fpregs) : "memory" );
+}
+
+static inline void restore_fp_regs(s390_fp_regs *fpregs)
+{
+	asm volatile (
+		"   lfpc  0(%0)\n"
+		"   ld    0,8(%0)\n"
+		"   ld    1,16(%0)\n"
+		"   ld    2,24(%0)\n"
+		"   ld    3,32(%0)\n"
+		"   ld    4,40(%0)\n"
+		"   ld    5,48(%0)\n"
+		"   ld    6,56(%0)\n"
+		"   ld    7,64(%0)\n"
+		"   ld    8,72(%0)\n"
+		"   ld    9,80(%0)\n"
+		"   ld    10,88(%0)\n"
+		"   ld    11,96(%0)\n"
+		"   ld    12,104(%0)\n"
+		"   ld    13,112(%0)\n"
+		"   ld    14,120(%0)\n"
+		"   ld    15,128(%0)\n"
+		: : "a" (fpregs));
+}
+
+#define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
 	resume(prev,next);						     \
 } while (0)
-
-struct task_struct;
 
 #define nop() __asm__ __volatile__ ("nop")
 

