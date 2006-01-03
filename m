Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWACVPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWACVPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWACVOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:14:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43151 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932567AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 37/50] arm26: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Re-1k@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/arm26/kernel/traps.c       |    8 ++++----
 include/asm-arm26/thread_info.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

bab19fadfa4a61c4ee18235e025af2d2514ca86d
diff --git a/arch/arm26/kernel/traps.c b/arch/arm26/kernel/traps.c
index f64f590..5847ea5 100644
--- a/arch/arm26/kernel/traps.c
+++ b/arch/arm26/kernel/traps.c
@@ -132,7 +132,7 @@ static void dump_instr(struct pt_regs *r
 
 /*static*/ void __dump_stack(struct task_struct *tsk, unsigned long sp)
 {
-	dump_mem("Stack: ", sp, 8192+(unsigned long)tsk->thread_info);
+	dump_mem("Stack: ", sp, 8192+(unsigned long)task_stack_page(tsk));
 }
 
 void dump_stack(void)
@@ -158,7 +158,7 @@ void dump_backtrace(struct pt_regs *regs
 	} else if (verify_stack(fp)) {
 		printk("invalid frame pointer 0x%08x", fp);
 		ok = 0;
-	} else if (fp < (unsigned long)(tsk->thread_info + 1))
+	} else if (fp < (unsigned long)end_of_stack(tsk))
 		printk("frame pointer underflow");
 	printk("\n");
 
@@ -168,7 +168,7 @@ void dump_backtrace(struct pt_regs *regs
 
 /* FIXME - this is probably wrong.. */
 void show_stack(struct task_struct *task, unsigned long *sp) {
-	dump_mem("Stack: ", (unsigned long)sp, 8192+(unsigned long)task->thread_info);
+	dump_mem("Stack: ", (unsigned long)sp, 8192+(unsigned long)task_stack_page(task));
 }
 
 DEFINE_SPINLOCK(die_lock);
@@ -187,7 +187,7 @@ NORET_TYPE void die(const char *str, str
 	printk("CPU: %d\n", smp_processor_id());
 	show_regs(regs);
 	printk("Process %s (pid: %d, stack limit = 0x%p)\n",
-		current->comm, current->pid, tsk->thread_info + 1);
+		current->comm, current->pid, end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
 		__dump_stack(tsk, (unsigned long)(regs + 1));
diff --git a/include/asm-arm26/thread_info.h b/include/asm-arm26/thread_info.h
index f332b40..7a35e7a 100644
--- a/include/asm-arm26/thread_info.h
+++ b/include/asm-arm26/thread_info.h
@@ -82,7 +82,7 @@ static inline struct thread_info *curren
 
 /* FIXME - PAGE_SIZE < 32K */
 #define THREAD_SIZE		(8*32768) // FIXME - this needs attention (see kernel/fork.c which gets a nice div by zero if this is lower than 8*32768
-#define task_pt_regs(task) ((struct pt_regs *)((unsigned long)(task)->thread_info + THREAD_SIZE - 8) - 1)
+#define task_pt_regs(task) ((struct pt_regs *)(task_stack_page(task) + THREAD_SIZE - 8) - 1)
 
 extern struct thread_info *alloc_thread_info(struct task_struct *task);
 extern void free_thread_info(struct thread_info *);
-- 
0.99.9.GIT

