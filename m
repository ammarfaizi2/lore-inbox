Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWACVUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWACVUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWACVUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:20:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35471 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932548AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 21/50] s390: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Pz-K3@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/s390/kernel/binfmt_elf32.c |    2 +-
 arch/s390/kernel/process.c      |    3 +--
 arch/s390/kernel/ptrace.c       |   26 +++++++++++++-------------
 arch/s390/kernel/time.c         |    2 +-
 arch/s390/kernel/traps.c        |    2 +-
 include/asm-s390/elf.h          |    2 +-
 include/asm-s390/processor.h    |    8 ++++----
 7 files changed, 22 insertions(+), 23 deletions(-)

2f208594c40468ffa71336bd9fbab0435aea8ae7
diff --git a/arch/s390/kernel/binfmt_elf32.c b/arch/s390/kernel/binfmt_elf32.c
index 03ba589..1f451c2 100644
--- a/arch/s390/kernel/binfmt_elf32.c
+++ b/arch/s390/kernel/binfmt_elf32.c
@@ -112,7 +112,7 @@ static inline int dump_regs32(struct pt_
 
 static inline int dump_task_regs32(struct task_struct *tsk, elf_gregset_t *regs)
 {
-	struct pt_regs *ptregs = __KSTK_PTREGS(tsk);
+	struct pt_regs *ptregs = task_pt_regs(tsk);
 	int i;
 
 	memcpy(&regs->psw.mask, &ptregs->psw.mask, 4);
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 78b64fe..6997dc5 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -217,8 +217,7 @@ int copy_thread(int nr, unsigned long cl
             struct pt_regs childregs;
           } *frame;
 
-        frame = ((struct fake_frame *)
-		 (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+        frame = container_of(task_pt_regs(p), struct fake_frame, childregs);
         p->thread.ksp = (unsigned long) frame;
 	/* Store access registers to kernel stack of new process. */
         frame->childregs = *regs;
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 06afa31..353dbe9 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -52,7 +52,7 @@ FixPerRegisters(struct task_struct *task
 	struct pt_regs *regs;
 	per_struct *per_info;
 
-	regs = __KSTK_PTREGS(task);
+	regs = task_pt_regs(task);
 	per_info = (per_struct *) &task->thread.per_info;
 	per_info->control_regs.bits.em_instruction_fetch =
 		per_info->single_step | per_info->instruction_fetch;
@@ -150,7 +150,7 @@ peek_user(struct task_struct *child, add
 		/*
 		 * psw and gprs are stored on the stack
 		 */
-		tmp = *(addr_t *)((addr_t) &__KSTK_PTREGS(child)->psw + addr);
+		tmp = *(addr_t *)((addr_t) &task_pt_regs(child)->psw + addr);
 		if (addr == (addr_t) &dummy->regs.psw.mask)
 			/* Remove per bit from user psw. */
 			tmp &= ~PSW_MASK_PER;
@@ -176,7 +176,7 @@ peek_user(struct task_struct *child, add
 		/*
 		 * orig_gpr2 is stored on the kernel stack
 		 */
-		tmp = (addr_t) __KSTK_PTREGS(child)->orig_gpr2;
+		tmp = (addr_t) task_pt_regs(child)->orig_gpr2;
 
 	} else if (addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
 		/* 
@@ -243,7 +243,7 @@ poke_user(struct task_struct *child, add
 			   high order bit but older gdb's rely on it */
 			data |= PSW_ADDR_AMODE;
 #endif
-		*(addr_t *)((addr_t) &__KSTK_PTREGS(child)->psw + addr) = data;
+		*(addr_t *)((addr_t) &task_pt_regs(child)->psw + addr) = data;
 
 	} else if (addr < (addr_t) (&dummy->regs.orig_gpr2)) {
 		/*
@@ -267,7 +267,7 @@ poke_user(struct task_struct *child, add
 		/*
 		 * orig_gpr2 is stored on the kernel stack
 		 */
-		__KSTK_PTREGS(child)->orig_gpr2 = data;
+		task_pt_regs(child)->orig_gpr2 = data;
 
 	} else if (addr < (addr_t) (&dummy->regs.fp_regs + 1)) {
 		/*
@@ -393,15 +393,15 @@ peek_user_emu31(struct task_struct *chil
 		 */
 		if (addr == (addr_t) &dummy32->regs.psw.mask) {
 			/* Fake a 31 bit psw mask. */
-			tmp = (__u32)(__KSTK_PTREGS(child)->psw.mask >> 32);
+			tmp = (__u32)(task_pt_regs(child)->psw.mask >> 32);
 			tmp = PSW32_MASK_MERGE(PSW32_USER_BITS, tmp);
 		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
 			/* Fake a 31 bit psw address. */
-			tmp = (__u32) __KSTK_PTREGS(child)->psw.addr |
+			tmp = (__u32) task_pt_regs(child)->psw.addr |
 				PSW32_ADDR_AMODE31;
 		} else {
 			/* gpr 0-15 */
-			tmp = *(__u32 *)((addr_t) &__KSTK_PTREGS(child)->psw +
+			tmp = *(__u32 *)((addr_t) &task_pt_regs(child)->psw +
 					 addr*2 + 4);
 		}
 	} else if (addr < (addr_t) (&dummy32->regs.orig_gpr2)) {
@@ -415,7 +415,7 @@ peek_user_emu31(struct task_struct *chil
 		/*
 		 * orig_gpr2 is stored on the kernel stack
 		 */
-		tmp = *(__u32*)((addr_t) &__KSTK_PTREGS(child)->orig_gpr2 + 4);
+		tmp = *(__u32*)((addr_t) &task_pt_regs(child)->orig_gpr2 + 4);
 
 	} else if (addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
@@ -472,15 +472,15 @@ poke_user_emu31(struct task_struct *chil
 			if (tmp != PSW32_MASK_MERGE(PSW32_USER_BITS, tmp))
 				/* Invalid psw mask. */
 				return -EINVAL;
-			__KSTK_PTREGS(child)->psw.mask =
+			task_pt_regs(child)->psw.mask =
 				PSW_MASK_MERGE(PSW_USER32_BITS, (__u64) tmp << 32);
 		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
 			/* Build a 64 bit psw address from 31 bit address. */
-			__KSTK_PTREGS(child)->psw.addr = 
+			task_pt_regs(child)->psw.addr = 
 				(__u64) tmp & PSW32_ADDR_INSN;
 		} else {
 			/* gpr 0-15 */
-			*(__u32*)((addr_t) &__KSTK_PTREGS(child)->psw
+			*(__u32*)((addr_t) &task_pt_regs(child)->psw
 				  + addr*2 + 4) = tmp;
 		}
 	} else if (addr < (addr_t) (&dummy32->regs.orig_gpr2)) {
@@ -494,7 +494,7 @@ poke_user_emu31(struct task_struct *chil
 		/*
 		 * orig_gpr2 is stored on the kernel stack
 		 */
-		*(__u32*)((addr_t) &__KSTK_PTREGS(child)->orig_gpr2 + 4) = tmp;
+		*(__u32*)((addr_t) &task_pt_regs(child)->orig_gpr2 + 4) = tmp;
 
 	} else if (addr < (addr_t) (&dummy32->regs.fp_regs + 1)) {
 		/*
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index c36353e..b0d8ca8 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -282,7 +282,7 @@ static inline void start_hz_timer(void)
 {
 	if (!cpu_isset(smp_processor_id(), nohz_cpu_mask))
 		return;
-	account_ticks(__KSTK_PTREGS(current));
+	account_ticks(task_pt_regs(current));
 	cpu_clear(smp_processor_id(), nohz_cpu_mask);
 }
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index c5bd36f..bcdfd6a 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -240,7 +240,7 @@ char *task_show_regs(struct task_struct 
 {
 	struct pt_regs *regs;
 
-	regs = __KSTK_PTREGS(task);
+	regs = task_pt_regs(task);
 	buffer += sprintf(buffer, "task: %p, ksp: %p\n",
 		       task, (void *)task->thread.ksp);
 	buffer += sprintf(buffer, "User PSW : %p %p\n",
diff --git a/include/asm-s390/elf.h b/include/asm-s390/elf.h
index 372d51c..710646e 100644
--- a/include/asm-s390/elf.h
+++ b/include/asm-s390/elf.h
@@ -163,7 +163,7 @@ static inline int dump_regs(struct pt_re
 
 static inline int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
 {
-	struct pt_regs *ptregs = __KSTK_PTREGS(tsk);
+	struct pt_regs *ptregs = task_pt_regs(tsk);
 	memcpy(&regs->psw, &ptregs->psw, sizeof(regs->psw)+sizeof(regs->gprs));
 	memcpy(regs->acrs, tsk->thread.acrs, sizeof(regs->acrs));
 	regs->orig_gpr2 = ptregs->orig_gpr2;
diff --git a/include/asm-s390/processor.h b/include/asm-s390/processor.h
index 4ec652e..795bfcb 100644
--- a/include/asm-s390/processor.h
+++ b/include/asm-s390/processor.h
@@ -191,10 +191,10 @@ extern void show_registers(struct pt_reg
 extern void show_trace(struct task_struct *task, unsigned long *sp);
 
 unsigned long get_wchan(struct task_struct *p);
-#define __KSTK_PTREGS(tsk) ((struct pt_regs *) \
-        ((unsigned long) tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs)))
-#define KSTK_EIP(tsk)	(__KSTK_PTREGS(tsk)->psw.addr)
-#define KSTK_ESP(tsk)	(__KSTK_PTREGS(tsk)->gprs[15])
+#define task_pt_regs(tsk) ((struct pt_regs *) \
+        ((void *)(tsk)->thread_info + THREAD_SIZE) - 1)
+#define KSTK_EIP(tsk)	(task_pt_regs(tsk)->psw.addr)
+#define KSTK_ESP(tsk)	(task_pt_regs(tsk)->gprs[15])
 
 /*
  * Give up the time slice of the virtual PU.
-- 
0.99.9.GIT

