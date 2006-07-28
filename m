Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161165AbWG1QHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbWG1QHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbWG1QGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:06:47 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:30648 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1752026AbWG1QGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:06:44 -0400
Subject: [patch 3/5] Add the canary field to the PDA area and the task
	struct
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1154102546.6416.9.camel@laptopd505.fenrus.org>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 18:04:32 +0200
Message-Id: <1154102672.6416.15.camel@laptopd505.fenrus.org>
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
 arch/x86_64/kernel/process.c |    3 +++
 include/asm-x86_64/pda.h     |    6 +++++-
 include/linux/sched.h        |    5 +++++
 kernel/fork.c                |    4 ++++
 4 files changed, 17 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc2-git5-stackprot/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.18-rc2-git5-stackprot.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.18-rc2-git5-stackprot/arch/x86_64/kernel/process.c
@@ -584,6 +584,9 @@ __switch_to(struct task_struct *prev_p, 
 	unlazy_fpu(prev_p);
 	write_pda(kernelstack,
 		  task_stack_page(next_p) + THREAD_SIZE - PDA_STACKOFFSET);
+#ifdef CONFIG_CC_STACKPROTECTOR
+	write_pda(stack_canary, next_p->stack_canary);
+#endif
 
 	/*
 	 * Now maybe reload the debug registers
Index: linux-2.6.18-rc2-git5-stackprot/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.18-rc2-git5-stackprot.orig/include/asm-x86_64/pda.h
+++ linux-2.6.18-rc2-git5-stackprot/include/asm-x86_64/pda.h
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
Index: linux-2.6.18-rc2-git5-stackprot/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc2-git5-stackprot.orig/include/linux/sched.h
+++ linux-2.6.18-rc2-git5-stackprot/include/linux/sched.h
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
Index: linux-2.6.18-rc2-git5-stackprot/kernel/fork.c
===================================================================
--- linux-2.6.18-rc2-git5-stackprot.orig/kernel/fork.c
+++ linux-2.6.18-rc2-git5-stackprot/kernel/fork.c
@@ -174,6 +174,10 @@ static struct task_struct *dup_task_stru
 	tsk->thread_info = ti;
 	setup_thread_stack(tsk, orig);
 
+#ifdef CONFIG_CC_STACKPROTECTOR
+	tsk->stack_canary = get_random_int();
+#endif
+
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);

