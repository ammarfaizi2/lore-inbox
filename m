Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWACVSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWACVSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWACVRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:17:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41871 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932552AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 34/50] arm: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008RS-0S@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/arm/kernel/process.c   |    2 +-
 arch/arm/kernel/smp.c       |    4 ++--
 arch/arm/kernel/traps.c     |    2 +-
 include/asm-arm/processor.h |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

00591c95d853894b7020b5d4a67a7a0e2e83eb00
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 8c62909..1be78b0 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -461,7 +461,7 @@ unsigned long get_wchan(struct task_stru
 		return 0;
 
 	stack_start = (unsigned long)end_of_stack(p);
-	stack_end = ((unsigned long)p->thread_info) + THREAD_SIZE;
+	stack_end = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 
 	fp = thread_saved_fp(p);
 	do {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 373c095..7338948 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -114,7 +114,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	 * We need to tell the secondary core where to find
 	 * its stack and the page tables.
 	 */
-	secondary_data.stack = (void *)idle->thread_info + THREAD_START_SP;
+	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
 	secondary_data.pgdir = virt_to_phys(pgd);
 	wmb();
 
@@ -245,7 +245,7 @@ void __cpuexit cpu_die(void)
 	__asm__("mov	sp, %0\n"
 	"	b	secondary_start_kernel"
 		:
-		: "r" ((void *)current->thread_info + THREAD_SIZE - 8));
+		: "r" (task_stack_page(current) + THREAD_SIZE - 8));
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index f7e733c..496bf7c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -211,7 +211,7 @@ static void __die(const char *str, int e
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem("Stack: ", regs->ARM_sp,
-			 THREAD_SIZE + (unsigned long)tsk->thread_info);
+			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
 		dump_backtrace(regs, tsk);
 		dump_instr(regs);
 	}
diff --git a/include/asm-arm/processor.h b/include/asm-arm/processor.h
index fb5877e..3129069 100644
--- a/include/asm-arm/processor.h
+++ b/include/asm-arm/processor.h
@@ -86,7 +86,7 @@ unsigned long get_wchan(struct task_stru
 extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
 #define task_pt_regs(p) \
-	((struct pt_regs *)(THREAD_START_SP + (void *)(p)->thread_info) - 1)
+	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
 
 #define KSTK_EIP(tsk)	task_pt_regs(tsk)->ARM_pc
 #define KSTK_ESP(tsk)	task_pt_regs(tsk)->ARM_sp
-- 
0.99.9.GIT

