Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWCQQSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWCQQSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWCQQRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:17:42 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:50318 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030205AbWCQQRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:17:32 -0500
Subject: [Patch 4 of 8] Add the cookie field
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 17:14:02 +0100
Message-Id: <1142612042.3033.108.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the per thread cookie field to the task struct and the PDA.
Also it makes sure that the PDA value gets the new cookie value at context
switch, and that a new task gets a new cookie at task creation time

Signed-off-by: Arjan van Ven <arjan@linux.intel.com>

---
 arch/x86_64/kernel/process.c |    3 +++
 include/asm-x86_64/pda.h     |    6 +++++-
 include/linux/sched.h        |    5 +++++
 kernel/fork.c                |    4 ++++
 4 files changed, 17 insertions(+), 1 deletion(-)

Index: linux-2.6.16-rc6-stack-protector/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.16-rc6-stack-protector/arch/x86_64/kernel/process.c
@@ -593,6 +593,9 @@ __switch_to(struct task_struct *prev_p, 
 	write_pda(pcurrent, next_p); 
 	write_pda(kernelstack,
 		  task_stack_page(next_p) + THREAD_SIZE - PDA_STACKOFFSET);
+#ifdef CONFIG_STACK_PROTECTOR
+	write_pda(stack_canary, next_p->stack_canary);
+#endif
 
 	/*
 	 * Now maybe reload the debug registers
Index: linux-2.6.16-rc6-stack-protector/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/include/asm-x86_64/pda.h
+++ linux-2.6.16-rc6-stack-protector/include/asm-x86_64/pda.h
@@ -14,7 +14,11 @@ struct x8664_pda {
 	unsigned long kernelstack;	/* 16 */  /* top of kernel stack for current */
 	unsigned long oldrsp;		/* 24 */  /* user rsp for system call */
 	unsigned long debugstack;	/* 32 */  /* #DB/#BP stack. */
-	int irqcount;			/* 40 */  /* Irq nesting counter. Starts with -1 */
+#ifdef CONFIG_STACK_PROTECTOR
+	unsigned long stack_canary;	/* 40 */  /* stack canary value */
+					/* Note: this canary MUST be at offset 40!!! */
+#endif
+	int irqcount;			/* 48 */  /* Irq nesting counter. Starts with -1 */
 	int cpunumber;		    /* Logical CPU number */
 	char *irqstackptr;	/* top of irqstack */
 	int nodenumber;		    /* number of current node */
Index: linux-2.6.16-rc6-stack-protector/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/include/linux/sched.h
+++ linux-2.6.16-rc6-stack-protector/include/linux/sched.h
@@ -740,6 +740,11 @@ struct task_struct {
 	unsigned did_exec:1;
 	pid_t pid;
 	pid_t tgid;
+
+#ifdef CONFIG_STACK_PROTECTOR
+	/* Canary value for the -fstack-protector gcc feature */
+	unsigned long stack_canary;
+#endif
 	/* 
 	 * pointers to (original) parent process, youngest child, younger sibling,
 	 * older sibling, respectively.  (p->father can be replaced with 
Index: linux-2.6.16-rc6-stack-protector/kernel/fork.c
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/kernel/fork.c
+++ linux-2.6.16-rc6-stack-protector/kernel/fork.c
@@ -178,6 +178,10 @@ static struct task_struct *dup_task_stru
 	tsk->thread_info = ti;
 	setup_thread_stack(tsk, orig);
 
+#ifdef CONFIG_STACK_PROTECTOR
+	tsk->stack_canary = get_random_int();
+#endif
+
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);

