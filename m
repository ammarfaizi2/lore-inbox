Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWHPRLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWHPRLl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWHPRLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:11:08 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:37598 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932120AbWHPRKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:10:44 -0400
Subject: [patch 3/5] -fstack-protector feature: Add the canary field to the
	PDA area
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1155746902.3023.63.camel@laptopd505.fenrus.org>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 18:51:24 +0200
Message-Id: <1155747085.3023.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch 3/5] Add the canary field to the PDA area and the task struct
From: Arjan van de Ven <arjan@linux.intel.com>

This patch adds the per thread cookie field to the task struct and the PDA.
Also it makes sure that the PDA value gets the new cookie value at context
switch, and that a new task gets a new cookie at task creation time.

Signed-off-by: Arjan van Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>
---
 arch/x86_64/kernel/process.c |    8 ++++++++
 include/asm-x86_64/pda.h     |    6 +++++-
 include/linux/sched.h        |    5 +++++
 kernel/fork.c                |    5 +++++
 4 files changed, 23 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4-stackprot/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.18-rc4-stackprot.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.18-rc4-stackprot/arch/x86_64/kernel/process.c
@@ -584,6 +584,14 @@ __switch_to(struct task_struct *prev_p, 
 	unlazy_fpu(prev_p);
 	write_pda(kernelstack,
 		  task_stack_page(next_p) + THREAD_SIZE - PDA_STACKOFFSET);
+#ifdef CONFIG_CC_STACKPROTECTOR
+	write_pda(stack_canary, next_p->stack_canary);
+	/*
+	 * Build time only check to make sure the stack_canary is at
+	 * offset 40 in the pda; this is a gcc ABI requirement
+	 */
+	BUILD_BUG_ON(offsetof(struct x8664_pda, stack_canary) != 40);
+#endif
 
 	/*
 	 * Now maybe reload the debug registers
Index: linux-2.6.18-rc4-stackprot/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.18-rc4-stackprot.orig/include/asm-x86_64/pda.h
+++ linux-2.6.18-rc4-stackprot/include/asm-x86_64/pda.h
@@ -14,7 +14,11 @@ struct x8664_pda {
 	unsigned long kernelstack;	/* 16 */  /* top of kernel stack for current */
 	unsigned long oldrsp;		/* 24 */  /* user rsp for system call */
 	unsigned long debugstack;	/* 32 */  /* #DB/#BP stack. */
-	int irqcount;			/* 40 */  /* Irq nesting counter. Starts with -1 */
+#ifdef CONFIG_CC_STACKPROTECTOR
+	unsigned long stack_canary;	/* 40 */  /* stack canary value */
+					/* gcc-ABI: this canary MUST be at offset 40!!! */
+#endif
+	int irqcount;			/* 48 */  /* Irq nesting counter. Starts with -1 */
 	int cpunumber;		    /* Logical CPU number */
 	char *irqstackptr;	/* top of irqstack */
 	int nodenumber;		    /* number of current node */
Index: linux-2.6.18-rc4-stackprot/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc4-stackprot.orig/include/linux/sched.h
+++ linux-2.6.18-rc4-stackprot/include/linux/sched.h
@@ -819,6 +819,11 @@ struct task_struct {
 	unsigned did_exec:1;
 	pid_t pid;
 	pid_t tgid;
+
+#ifdef CONFIG_CC_STACKPROTECTOR
+	/* Canary value for the -fstack-protector gcc feature */
+	unsigned long stack_canary;
+#endif
 	/* 
 	 * pointers to (original) parent process, youngest child, younger sibling,
 	 * older sibling, respectively.  (p->father can be replaced with 
Index: linux-2.6.18-rc4-stackprot/kernel/fork.c
===================================================================
--- linux-2.6.18-rc4-stackprot.orig/kernel/fork.c
+++ linux-2.6.18-rc4-stackprot/kernel/fork.c
@@ -45,6 +45,7 @@
 #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
+#include <linux/random.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -174,6 +175,10 @@ static struct task_struct *dup_task_stru
 	tsk->thread_info = ti;
 	setup_thread_stack(tsk, orig);
 
+#ifdef CONFIG_CC_STACKPROTECTOR
+	tsk->stack_canary = get_random_int();
+#endif
+
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);

