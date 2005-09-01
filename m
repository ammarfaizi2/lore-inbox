Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbVIAWBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbVIAWBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbVIAWBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:01:38 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:136 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030434AbVIAWBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:01:36 -0400
Date: Fri, 2 Sep 2005 00:01:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 8/10] use end_of_stack()
Message-ID: <Pine.LNX.4.61.0509020001210.11560@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert expression of the form (p->thread_info + 1) to use end_of_stack(), 
which makes it also more readable.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/arm/kernel/process.c |    2 +-
 arch/arm/kernel/traps.c   |    4 ++--
 arch/arm26/kernel/traps.c |    4 ++--
 arch/ppc/kernel/process.c |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6-mm/arch/arm/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/process.c	2005-09-01 21:04:49.408429938 +0200
+++ linux-2.6-mm/arch/arm/kernel/process.c	2005-09-01 21:04:54.137617451 +0200
@@ -448,7 +448,7 @@ unsigned long get_wchan(struct task_stru
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	stack_start = (unsigned long)(p->thread_info + 1);
+	stack_start = (unsigned long)end_of_stack(p);
 	stack_end = ((unsigned long)p->thread_info) + THREAD_SIZE;
 
 	fp = thread_saved_fp(p);
Index: linux-2.6-mm/arch/arm/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/traps.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/arm/kernel/traps.c	2005-09-01 21:04:54.169611954 +0200
@@ -165,7 +165,7 @@ static void dump_backtrace(struct pt_reg
 	} else if (verify_stack(fp)) {
 		printk("invalid frame pointer 0x%08x", fp);
 		ok = 0;
-	} else if (fp < (unsigned long)(tsk->thread_info + 1))
+	} else if (fp < (unsigned long)end_of_stack(tsk))
 		printk("frame pointer underflow");
 	printk("\n");
 
@@ -216,7 +216,7 @@ NORET_TYPE void die(const char *str, str
 	print_modules();
 	__show_regs(regs);
 	printk("Process %s (pid: %d, stack limit = 0x%p)\n",
-		tsk->comm, tsk->pid, tsk->thread_info + 1);
+		tsk->comm, tsk->pid, end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem("Stack: ", regs->ARM_sp,
Index: linux-2.6-mm/arch/arm26/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/arm26/kernel/traps.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/arm26/kernel/traps.c	2005-09-01 21:04:54.188608690 +0200
@@ -158,7 +158,7 @@ void dump_backtrace(struct pt_regs *regs
 	} else if (verify_stack(fp)) {
 		printk("invalid frame pointer 0x%08x", fp);
 		ok = 0;
-	} else if (fp < (unsigned long)(tsk->thread_info + 1))
+	} else if (fp < (unsigned long)end_of_stack(tsk))
 		printk("frame pointer underflow");
 	printk("\n");
 
@@ -187,7 +187,7 @@ NORET_TYPE void die(const char *str, str
 	printk("CPU: %d\n", smp_processor_id());
 	show_regs(regs);
 	printk("Process %s (pid: %d, stack limit = 0x%p)\n",
-		current->comm, current->pid, tsk->thread_info + 1);
+		current->comm, current->pid, end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
 		__dump_stack(tsk, (unsigned long)(regs + 1));
Index: linux-2.6-mm/arch/ppc/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/ppc/kernel/process.c	2005-09-01 21:04:54.236600445 +0200
@@ -638,7 +638,7 @@ void show_stack(struct task_struct *tsk,
 			sp = tsk->thread.ksp;
 	}
 
-	prev_sp = (unsigned long) (tsk->thread_info + 1);
+	prev_sp = (unsigned long)end_of_stack(tsk);
 	stack_top = (unsigned long) tsk->thread_info + THREAD_SIZE;
 	while (count < 16 && sp > prev_sp && sp < stack_top && (sp & 3) == 0) {
 		if (count == 0) {
