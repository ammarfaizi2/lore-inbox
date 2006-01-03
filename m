Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWACVXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWACVXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWACVWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:22:44 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48527 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932542AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 49/50] mips: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Sn-Hv@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/mips/kernel/process.c   |    6 +++---
 include/asm-mips/processor.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

339018b3d533fd4f589eca296752154f82ecfa8d
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index aca56f4..fa98f10 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -140,12 +140,12 @@ void flush_thread(void)
 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
 	unsigned long unused, struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *ti = p->thread_info;
+	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
 	long childksp;
 	p->set_child_tid = p->clear_child_tid = NULL;
 
-	childksp = (unsigned long)ti + THREAD_SIZE - 32;
+	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
 
 	preempt_disable();
 
@@ -407,7 +407,7 @@ unsigned long get_wchan(struct task_stru
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	stack_page = (unsigned long)p->thread_info;
+	stack_page = (unsigned long)task_stack_page(p);
 	if (!stack_page || !mips_frame_info_initialized)
 		return 0;
 
diff --git a/include/asm-mips/processor.h b/include/asm-mips/processor.h
index 2bbbf87..90370a4 100644
--- a/include/asm-mips/processor.h
+++ b/include/asm-mips/processor.h
@@ -201,7 +201,7 @@ extern void start_thread(struct pt_regs 
 
 unsigned long get_wchan(struct task_struct *p);
 
-#define __KSTK_TOS(tsk) ((unsigned long)(tsk->thread_info) + THREAD_SIZE - 32)
+#define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + THREAD_SIZE - 32)
 #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk) - 1)
 #define KSTK_EIP(tsk) (task_pt_regs(tsk)->cp0_epc)
 #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
-- 
0.99.9.GIT

