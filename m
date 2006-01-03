Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWACVUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWACVUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWACVRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:17:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:32911 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932549AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 22/50] s390: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Q1-Kk@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/s390/kernel/process.c   |    9 ++++-----
 arch/s390/kernel/smp.c       |    2 +-
 arch/s390/kernel/traps.c     |    4 ++--
 include/asm-s390/processor.h |    2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

c76bf4b7050b630e0ece7a17eb7ce77a46170d8b
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 6997dc5..2c77f60 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -153,7 +153,7 @@ void show_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
 
-        printk("CPU:    %d    %s\n", tsk->thread_info->cpu, print_tainted());
+        printk("CPU:    %d    %s\n", task_thread_info(tsk)->cpu, print_tainted());
         printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
 	       current->comm, current->pid, (void *) tsk,
 	       (void *) tsk->thread.ksp);
@@ -378,11 +378,10 @@ unsigned long get_wchan(struct task_stru
 	unsigned long return_address;
 	int count;
 
-	if (!p || p == current || p->state == TASK_RUNNING || !p->thread_info)
+	if (!p || p == current || p->state == TASK_RUNNING || !task_stack_page(p))
 		return 0;
-	low = (struct stack_frame *) p->thread_info;
-	high = (struct stack_frame *)
-		((unsigned long) p->thread_info + THREAD_SIZE) - 1;
+	low = task_stack_page(p);
+	high = (struct stack_frame *) task_pt_regs(p);
 	sf = (struct stack_frame *) (p->thread.ksp & PSW_ADDR_INSN);
 	if (sf <= low || sf > high)
 		return 0;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 5856b3f..7970b74 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -657,7 +657,7 @@ __cpu_up(unsigned int cpu)
 	idle = current_set[cpu];
         cpu_lowcore = lowcore_ptr[cpu];
 	cpu_lowcore->kernel_stack = (unsigned long)
-		idle->thread_info + (THREAD_SIZE);
+		task_stack_page(idle) + (THREAD_SIZE);
 	sf = (struct stack_frame *) (cpu_lowcore->kernel_stack
 				     - sizeof(struct pt_regs)
 				     - sizeof(struct stack_frame));
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index bcdfd6a..6c7ca16 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -136,8 +136,8 @@ void show_trace(struct task_struct *task
 	sp = __show_trace(sp, S390_lowcore.async_stack - ASYNC_SIZE,
 			  S390_lowcore.async_stack);
 	if (task)
-		__show_trace(sp, (unsigned long) task->thread_info,
-			     (unsigned long) task->thread_info + THREAD_SIZE);
+		__show_trace(sp, (unsigned long) task_stack_page(task),
+			     (unsigned long) task_stack_page(task) + THREAD_SIZE);
 	else
 		__show_trace(sp, S390_lowcore.thread_info,
 			     S390_lowcore.thread_info + THREAD_SIZE);
diff --git a/include/asm-s390/processor.h b/include/asm-s390/processor.h
index 795bfcb..c5cbc4b 100644
--- a/include/asm-s390/processor.h
+++ b/include/asm-s390/processor.h
@@ -192,7 +192,7 @@ extern void show_trace(struct task_struc
 
 unsigned long get_wchan(struct task_struct *p);
 #define task_pt_regs(tsk) ((struct pt_regs *) \
-        ((void *)(tsk)->thread_info + THREAD_SIZE) - 1)
+        (task_stack_page(tsk) + THREAD_SIZE) - 1)
 #define KSTK_EIP(tsk)	(task_pt_regs(tsk)->psw.addr)
 #define KSTK_ESP(tsk)	(task_pt_regs(tsk)->gprs[15])
 
-- 
0.99.9.GIT

