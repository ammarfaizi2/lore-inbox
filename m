Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWACVSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWACVSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWACVRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:17:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28303 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932558AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 09/50] i386: fix task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PU-7F@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

task_pt_regs() needs the same offset-by-8 to match copy_thread()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/i386/kernel/process.c   |   20 ++------------------
 arch/i386/kernel/smpboot.c   |    3 +--
 include/asm-i386/processor.h |   12 +++++++++++-
 3 files changed, 14 insertions(+), 21 deletions(-)

a363a5cdd3f6e20f7166e4b18f9e3b2d0f043461
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
index b48cfe1..7765f3a 100644
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -435,18 +435,7 @@ int copy_thread(int nr, unsigned long cl
 	struct task_struct *tsk;
 	int err;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
-	/*
-	 * The below -8 is to reserve 8 bytes on top of the ring0 stack.
-	 * This is necessary to guarantee that the entire "struct pt_regs"
-	 * is accessable even if the CPU haven't stored the SS/ESP registers
-	 * on the stack (interrupt gate does not save these registers
-	 * when switching to the same priv ring).
-	 * Therefore beware: accessing the xss/esp fields of the
-	 * "struct pt_regs" is possible, but they may contain the
-	 * completely wrong values.
-	 */
-	childregs = (struct pt_regs *) ((unsigned long) childregs - 8);
+	childregs = task_pt_regs(p);
 	*childregs = *regs;
 	childregs->eax = 0;
 	childregs->esp = esp;
@@ -551,12 +540,7 @@ EXPORT_SYMBOL(dump_thread);
  */
 int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
 {
-	struct pt_regs ptregs;
-	
-	ptregs = *(struct pt_regs *)
-		((unsigned long)tsk->thread_info +
-		/* see comments in copy_thread() about -8 */
-		THREAD_SIZE - sizeof(ptregs) - 8);
+	struct pt_regs ptregs = *task_pt_regs(tsk);
 	ptregs.xcs &= 0xffff;
 	ptregs.xds &= 0xffff;
 	ptregs.xes &= 0xffff;
diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
index 9ed449a..b96b29f 100644
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -875,8 +875,7 @@ static inline struct task_struct * alloc
 		/* initialize thread_struct.  we really want to avoid destroy
 		 * idle tread
 		 */
-		idle->thread.esp = (unsigned long)(((struct pt_regs *)
-			(THREAD_SIZE + (unsigned long) idle->thread_info)) - 1);
+		idle->thread.esp = (unsigned long)task_pt_regs(idle);
 		init_idle(idle, cpu);
 		return idle;
 	}
diff --git a/include/asm-i386/processor.h b/include/asm-i386/processor.h
index 5c96cf6..84f2fd1 100644
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -557,10 +557,20 @@ unsigned long get_wchan(struct task_stru
        (unsigned long)(&__ptr[THREAD_SIZE_LONGS]);                     \
 })
 
+/*
+ * The below -8 is to reserve 8 bytes on top of the ring0 stack.
+ * This is necessary to guarantee that the entire "struct pt_regs"
+ * is accessable even if the CPU haven't stored the SS/ESP registers
+ * on the stack (interrupt gate does not save these registers
+ * when switching to the same priv ring).
+ * Therefore beware: accessing the xss/esp fields of the
+ * "struct pt_regs" is possible, but they may contain the
+ * completely wrong values.
+ */
 #define task_pt_regs(task)                                             \
 ({                                                                     \
        struct pt_regs *__regs__;                                       \
-       __regs__ = (struct pt_regs *)KSTK_TOP((task)->thread_info);     \
+       __regs__ = (struct pt_regs *)(KSTK_TOP((task)->thread_info)-8); \
        __regs__ - 1;                                                   \
 })
 
-- 
0.99.9.GIT

