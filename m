Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWACV16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWACV16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWACV15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:27:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38543 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932535AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 29/50] parisc: task_stack_page(), task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Qv-Sf@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/parisc/kernel/process.c |    6 +++---
 arch/parisc/kernel/smp.c     |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

4822bcc5fa9991be25482b67fb351f7c3c81ba8c
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index fee4f1f..1273272 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -295,7 +295,7 @@ copy_thread(int nr, unsigned long clone_
 	    struct task_struct * p, struct pt_regs * pregs)
 {
 	struct pt_regs * cregs = &(p->thread.regs);
-	struct thread_info *ti = p->thread_info;
+	void *stack = task_stack_page(p);
 	
 	/* We have to use void * instead of a function pointer, because
 	 * function pointers aren't a pointer to the function on 64-bit.
@@ -322,7 +322,7 @@ copy_thread(int nr, unsigned long clone_
 	 */
 	if (usp == 1) {
 		/* kernel thread */
-		cregs->ksp = (((unsigned long)(ti)) + THREAD_SZ_ALGN);
+		cregs->ksp = (unsigned long)stack + THREAD_SZ_ALGN;
 		/* Must exit via ret_from_kernel_thread in order
 		 * to call schedule_tail()
 		 */
@@ -344,7 +344,7 @@ copy_thread(int nr, unsigned long clone_
 		 */
 
 		/* Use same stack depth as parent */
-		cregs->ksp = ((unsigned long)(ti))
+		cregs->ksp = (unsigned long)stack
 			+ (pregs->gr[21] & (THREAD_SIZE - 1));
 		cregs->gr[30] = usp;
 		if (p->personality == PER_HPUX) {
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index ce89da0..471efad 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -519,7 +519,7 @@ int __init smp_boot_one_cpu(int cpuid)
 	if (IS_ERR(idle))
 		panic("SMP: fork failed for CPU:%d", cpuid);
 
-	idle->thread_info->cpu = cpuid;
+	task_thread_info(idle)->cpu = cpuid;
 
 	/* Let _start know what logical CPU we're booting
 	** (offset into init_tasks[],cpu_data[])
-- 
0.99.9.GIT

