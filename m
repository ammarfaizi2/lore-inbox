Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbUCXLwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 06:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUCXLwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 06:52:38 -0500
Received: from ozlabs.org ([203.10.76.45]:204 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263308AbUCXLwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 06:52:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.30223.416167.317040@cargo.ozlabs.ibm.com>
Date: Wed, 24 Mar 2004 22:50:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, trini@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Threaded core dumps for PPC32
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, ppc32 kernels will oops if a threaded program tries to
dump core.  We call dump_fpu with a NULL regs pointer, which it tries
to dereference.  This patch fixes that by implementing the hooks used
in doing threaded core dumps properly.

Please apply, preferably before 2.6.5 (since it fixes an oops).

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc/kernel/process.c pmac-2.5/arch/ppc/kernel/process.c
--- linux-2.5/arch/ppc/kernel/process.c	2003-10-14 19:41:13.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/process.c	2004-03-24 12:55:33.000000000 +1100
@@ -45,7 +45,6 @@
 #include <asm/prom.h>
 #include <asm/hardirq.h>
 
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs);
 extern unsigned long _get_SP(void);
 
 struct task_struct *last_task_used_math = NULL;
@@ -189,11 +188,11 @@
 }
 
 int
-dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
+dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
 {
-	if (regs->msr & MSR_FP)
-		giveup_fpu(current);
-	memcpy(fpregs, &current->thread.fpr[0], sizeof(*fpregs));
+	if (tsk->thread.regs && tsk->thread.regs->msr & MSR_FP)
+		giveup_fpu(tsk);
+	memcpy(fpregs, &tsk->thread.fpr[0], sizeof(*fpregs));
 	return 1;
 }
 
diff -urN linux-2.5/include/asm-ppc/elf.h pmac-2.5/include/asm-ppc/elf.h
--- linux-2.5/include/asm-ppc/elf.h	2003-05-13 11:47:15.000000000 +1000
+++ pmac-2.5/include/asm-ppc/elf.h	2004-03-24 13:49:17.000000000 +1100
@@ -90,11 +90,17 @@
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE	4096
 
-#define ELF_CORE_COPY_REGS(gregs, regs) \
-	memcpy(gregs, regs, \
-	       sizeof(struct pt_regs) < sizeof(elf_gregset_t)? \
-	       sizeof(struct pt_regs): sizeof(elf_gregset_t));
+#define ELF_CORE_COPY_REGS(gregs, regs)				\
+	memcpy((gregs), (regs), sizeof(struct pt_regs));	\
+	memset((char *)(gregs) + sizeof(struct pt_regs), 0,	\
+	       sizeof(elf_gregset_t) - sizeof(struct pt_regs));
+
+#define ELF_CORE_COPY_TASK_REGS(t, elfregs)			\
+	((t)->thread.regs?					\
+	 ({ ELF_CORE_COPY_REGS((elfregs), (t)->thread.regs); 1; }): 0)
 
+extern int dump_task_fpu(struct task_struct *t, elf_fpregset_t *fpu);
+#define ELF_CORE_COPY_FPREGS(t, fpu)	dump_task_fpu((t), (fpu))
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This could be done in userspace,
