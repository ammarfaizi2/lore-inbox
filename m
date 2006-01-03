Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWACVOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWACVOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWACVN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:13:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48783 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932541AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 47/50] mips: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Se-Dn@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/mips/kernel/process.c   |    4 +---
 arch/mips/kernel/ptrace.c    |   12 ++++--------
 arch/mips/kernel/ptrace32.c  |    6 ++----
 include/asm-mips/processor.h |    8 ++++----
 include/asm-mips/system.h    |    2 +-
 5 files changed, 12 insertions(+), 20 deletions(-)

e99ce9bd9ac8e3f78fd46fbbede5d803c073f9c5
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 0476a4d..aca56f4 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -229,9 +229,7 @@ void elf_dump_regs(elf_greg_t *gp, struc
 
 int dump_task_regs (struct task_struct *tsk, elf_gregset_t *regs)
 {
-	struct thread_info *ti = tsk->thread_info;
-	long ksp = (unsigned long)ti + THREAD_SIZE - 32;
-	elf_dump_regs(&(*regs)[0], (struct pt_regs *) ksp - 1);
+	elf_dump_regs(*regs, task_pt_regs(tsk));
 	return 1;
 }
 
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 510da5f..506fef3 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -64,8 +64,7 @@ int ptrace_getregs (struct task_struct *
 	if (!access_ok(VERIFY_WRITE, data, 38 * 8))
 		return -EIO;
 
-	regs = (struct pt_regs *) ((unsigned long) child->thread_info +
-	       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+	regs = task_pt_regs(child);
 
 	for (i = 0; i < 32; i++)
 		__put_user (regs->regs[i], data + i);
@@ -92,8 +91,7 @@ int ptrace_setregs (struct task_struct *
 	if (!access_ok(VERIFY_READ, data, 38 * 8))
 		return -EIO;
 
-	regs = (struct pt_regs *) ((unsigned long) child->thread_info +
-	       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+	regs = task_pt_regs(child);
 
 	for (i = 0; i < 32; i++)
 		__get_user (regs->regs[i], data + i);
@@ -198,8 +196,7 @@ long arch_ptrace(struct task_struct *chi
 		struct pt_regs *regs;
 		unsigned long tmp = 0;
 
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
-		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+		regs = task_pt_regs(child);
 		ret = 0;  /* Default return value. */
 
 		switch (addr) {
@@ -318,8 +315,7 @@ long arch_ptrace(struct task_struct *chi
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
 		ret = 0;
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
-		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+		regs = task_pt_regs(child);
 
 		switch (addr) {
 		case 0 ... 31:
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 9a9b049..5d022b0 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -140,8 +140,7 @@ asmlinkage int sys32_ptrace(int request,
 		struct pt_regs *regs;
 		unsigned int tmp;
 
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
-		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+		regs = task_pt_regs(child);
 		ret = 0;  /* Default return value. */
 
 		switch (addr) {
@@ -277,8 +276,7 @@ asmlinkage int sys32_ptrace(int request,
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
 		ret = 0;
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
-		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+		regs = task_pt_regs(child);
 
 		switch (addr) {
 		case 0 ... 31:
diff --git a/include/asm-mips/processor.h b/include/asm-mips/processor.h
index f1980c6..2bbbf87 100644
--- a/include/asm-mips/processor.h
+++ b/include/asm-mips/processor.h
@@ -201,11 +201,11 @@ extern void start_thread(struct pt_regs 
 
 unsigned long get_wchan(struct task_struct *p);
 
-#define __PT_REG(reg) ((long)&((struct pt_regs *)0)->reg - sizeof(struct pt_regs))
 #define __KSTK_TOS(tsk) ((unsigned long)(tsk->thread_info) + THREAD_SIZE - 32)
-#define KSTK_EIP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_epc)))
-#define KSTK_ESP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(regs[29])))
-#define KSTK_STATUS(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_status)))
+#define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk) - 1)
+#define KSTK_EIP(tsk) (task_pt_regs(tsk)->cp0_epc)
+#define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
+#define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
 
 #define cpu_relax()	barrier()
 
diff --git a/include/asm-mips/system.h b/include/asm-mips/system.h
index 330c4e4..f78af75 100644
--- a/include/asm-mips/system.h
+++ b/include/asm-mips/system.h
@@ -159,7 +159,7 @@ struct task_struct;
 do {									\
 	if (cpu_has_dsp)						\
 		__save_dsp(prev);					\
-	(last) = resume(prev, next, next->thread_info);			\
+	(last) = resume(prev, next, task_thread_info(next));		\
 	if (cpu_has_dsp)						\
 		__restore_dsp(current);					\
 } while(0)
-- 
0.99.9.GIT

