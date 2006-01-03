Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWACVIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWACVIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWACVH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37263 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932550AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 24/50] v850: task_stack_page(), task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Qk-Mi@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/v850/kernel/process.c   |    2 +-
 arch/v850/kernel/ptrace.c    |    2 +-
 include/asm-v850/processor.h |    8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

f928f2928325fc0f2442e309c8dba6e6ad96ce6a
diff --git a/arch/v850/kernel/process.c b/arch/v850/kernel/process.c
index 39cf247..86cf333 100644
--- a/arch/v850/kernel/process.c
+++ b/arch/v850/kernel/process.c
@@ -114,7 +114,7 @@ int copy_thread (int nr, unsigned long c
 		 struct task_struct *p, struct pt_regs *regs)
 {
 	/* Start pushing stuff from the top of the child's kernel stack.  */
-	unsigned long orig_ksp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long orig_ksp = task_tos(p);
 	unsigned long ksp = orig_ksp;
 	/* We push two `state save' stack fames (see entry.S) on the new
 	   kernel stack:
diff --git a/arch/v850/kernel/ptrace.c b/arch/v850/kernel/ptrace.c
index 18492d0..67e0575 100644
--- a/arch/v850/kernel/ptrace.c
+++ b/arch/v850/kernel/ptrace.c
@@ -58,7 +58,7 @@ static v850_reg_t *reg_save_addr (unsign
 		regs = thread_saved_regs (t);
 	else
 		/* Register saved during kernel entry (or not available).  */
-		regs = task_regs (t);
+		regs = task_pt_regs (t);
 
 	return (v850_reg_t *)((char *)regs + reg_offs);
 }
diff --git a/include/asm-v850/processor.h b/include/asm-v850/processor.h
index 98f9294..2d31308 100644
--- a/include/asm-v850/processor.h
+++ b/include/asm-v850/processor.h
@@ -98,10 +98,10 @@ unsigned long get_wchan (struct task_str
 
 
 /* Return some info about the user process TASK.  */
-#define task_tos(task)	((unsigned long)(task)->thread_info + THREAD_SIZE)
-#define task_regs(task) ((struct pt_regs *)task_tos (task) - 1)
-#define task_sp(task)	(task_regs (task)->gpr[GPR_SP])
-#define task_pc(task)	(task_regs (task)->pc)
+#define task_tos(task)	((unsigned long)task_stack_page(task) + THREAD_SIZE)
+#define task_pt_regs(task) ((struct pt_regs *)task_tos (task) - 1)
+#define task_sp(task)	(task_pt_regs (task)->gpr[GPR_SP])
+#define task_pc(task)	(task_pt_regs (task)->pc)
 /* Grotty old names for some.  */
 #define KSTK_EIP(task)	task_pc (task)
 #define KSTK_ESP(task)	task_sp (task)
-- 
0.99.9.GIT

