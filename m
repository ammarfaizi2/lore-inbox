Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWACVYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWACVYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWACVX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:23:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:29583 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932559AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 12/50] sparc64: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Pc-9H@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sparc64/kernel/process.c |    6 +++---
 arch/sparc64/kernel/traps.c   |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

7fb2d76daf5bcc4a9c73f2f6a5b27902aa80e3df
diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index 1bc7724..1dc3650 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -616,11 +616,11 @@ int copy_thread(int nr, unsigned long cl
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
 {
-	struct thread_info *t = p->thread_info;
+	struct thread_info *t = task_thread_info(p);
 	char *child_trap_frame;
 
 	/* Calculate offset to stack_frame & pt_regs */
-	child_trap_frame = ((char *)t) + (THREAD_SIZE - (TRACEREG_SZ+STACKFRAME_SZ));
+	child_trap_frame = task_stack_page(p) + (THREAD_SIZE - (TRACEREG_SZ+STACKFRAME_SZ));
 	memcpy(child_trap_frame, (((struct sparc_stackf *)regs)-1), (TRACEREG_SZ+STACKFRAME_SZ));
 
 	t->flags = (t->flags & ~((0xffUL << TI_FLAG_CWP_SHIFT) | (0xffUL << TI_FLAG_CURRENT_DS_SHIFT))) |
@@ -845,7 +845,7 @@ unsigned long get_wchan(struct task_stru
             task->state == TASK_RUNNING)
 		goto out;
 
-	thread_info_base = (unsigned long) task->thread_info;
+	thread_info_base = (unsigned long) task_stack_page(task);
 	bias = STACK_BIAS;
 	fp = task_thread_info(task)->ksp + bias;
 
diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
index 5570e7b..8d44ae5 100644
--- a/arch/sparc64/kernel/traps.c
+++ b/arch/sparc64/kernel/traps.c
@@ -1808,7 +1808,7 @@ static void user_instruction_dump (unsig
 void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 {
 	unsigned long pc, fp, thread_base, ksp;
-	struct thread_info *tp = tsk->thread_info;
+	void *tp = task_stack_page(tsk);
 	struct reg_window *rw;
 	int count = 0;
 
@@ -1862,7 +1862,7 @@ static inline int is_kernel_stack(struct
 			return 0;
 	}
 
-	thread_base = (unsigned long) task->thread_info;
+	thread_base = (unsigned long) task_stack_page(task);
 	thread_end = thread_base + sizeof(union thread_union);
 	if (rw_addr >= thread_base &&
 	    rw_addr < thread_end &&
-- 
0.99.9.GIT

