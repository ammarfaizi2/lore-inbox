Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbVIAWCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbVIAWCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbVIAWCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:02:32 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:1928 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030431AbVIAWCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:02:31 -0400
Date: Fri, 2 Sep 2005 00:02:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 9/10] change ->thread_info access to ->stack
Message-ID: <Pine.LNX.4.61.0509020001360.11564@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changes direct access to the thread_info field to use the stack field 
instead, whereever it's obvious it actually wants the stack field (all of 
them are also cast to a different type).
Also included are the offsetof() users to use the stack field.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/alpha/kernel/process.c         |    2 +-
 arch/arm/kernel/process.c           |    2 +-
 arch/arm/kernel/ptrace.c            |    2 +-
 arch/arm/kernel/smp.c               |    2 +-
 arch/arm/kernel/traps.c             |    2 +-
 arch/arm26/kernel/traps.c           |    4 ++--
 arch/frv/kernel/process.c           |    2 +-
 arch/h8300/kernel/asm-offsets.c     |    2 +-
 arch/h8300/kernel/process.c         |    2 +-
 arch/i386/kernel/process.c          |    6 +++---
 arch/i386/kernel/smpboot.c          |    2 +-
 arch/m32r/kernel/process.c          |    2 +-
 arch/m32r/kernel/ptrace.c           |    2 +-
 arch/m68k/kernel/process.c          |    4 ++--
 arch/m68knommu/kernel/asm-offsets.c |    2 +-
 arch/m68knommu/kernel/process.c     |    2 +-
 arch/mips/kernel/offset.c           |    2 +-
 arch/mips/kernel/ptrace.c           |    4 ++--
 arch/mips/kernel/ptrace32.c         |    4 ++--
 arch/mips/pmc-sierra/yosemite/smp.c |    2 +-
 arch/mips/sgi-ip27/ip27-smp.c       |    2 +-
 arch/parisc/kernel/asm-offsets.c    |    2 +-
 arch/ppc/kernel/asm-offsets.c       |    2 +-
 arch/ppc/kernel/process.c           |    6 +++---
 arch/ppc64/kernel/process.c         |    6 +++---
 arch/ppc64/kernel/sys_ppc32.c       |    2 +-
 arch/s390/kernel/asm-offsets.c      |    2 +-
 arch/s390/kernel/process.c          |    6 +++---
 arch/s390/kernel/smp.c              |    2 +-
 arch/s390/kernel/traps.c            |    4 ++--
 arch/sh/kernel/process.c            |   14 +++++++-------
 arch/sh/kernel/ptrace.c             |    4 ++--
 arch/sh64/kernel/process.c          |    4 ++--
 arch/sh64/lib/dbg.c                 |    2 +-
 arch/sparc/kernel/asm-offsets.c     |    2 +-
 arch/sparc/kernel/process.c         |    4 ++--
 arch/sparc64/kernel/process.c       |    2 +-
 arch/sparc64/kernel/traps.c         |    2 +-
 arch/um/kernel/tt/process_kern.c    |    2 +-
 arch/v850/kernel/asm-consts.c       |    2 +-
 arch/v850/kernel/process.c          |    2 +-
 arch/x86_64/kernel/process.c        |    6 +++---
 arch/x86_64/kernel/smpboot.c        |    2 +-
 arch/xtensa/kernel/asm-offsets.c    |    2 +-
 arch/xtensa/kernel/process.c        |    4 ++--
 include/asm-alpha/processor.h       |    2 +-
 include/asm-alpha/ptrace.h          |    2 +-
 include/asm-arm/processor.h         |    2 +-
 include/asm-i386/processor.h        |    2 +-
 include/asm-mips/processor.h        |    2 +-
 include/asm-s390/processor.h        |    2 +-
 include/asm-v850/processor.h        |    2 +-
 include/asm-xtensa/ptrace.h         |    2 +-
 53 files changed, 78 insertions(+), 78 deletions(-)

Index: linux-2.6-mm/arch/alpha/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/alpha/kernel/process.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/alpha/kernel/process.c	2005-09-01 21:04:56.337239556 +0200
@@ -487,7 +487,7 @@ out:
 unsigned long
 thread_saved_pc(task_t *t)
 {
-	unsigned long base = (unsigned long)t->thread_info;
+	unsigned long base = (unsigned long)t->stack;
 	unsigned long fp, sp = t->thread_info->pcb.ksp;
 
 	if (sp > base && sp+6*8 < base + 16*1024) {
Index: linux-2.6-mm/arch/arm/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/process.c	2005-09-01 21:04:54.137617451 +0200
+++ linux-2.6-mm/arch/arm/kernel/process.c	2005-09-01 21:04:56.337239556 +0200
@@ -449,7 +449,7 @@ unsigned long get_wchan(struct task_stru
 		return 0;
 
 	stack_start = (unsigned long)end_of_stack(p);
-	stack_end = ((unsigned long)p->thread_info) + THREAD_SIZE;
+	stack_end = (unsigned long)p->stack + THREAD_SIZE;
 
 	fp = thread_saved_fp(p);
 	do {
Index: linux-2.6-mm/arch/arm/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/ptrace.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/arm/kernel/ptrace.c	2005-09-01 21:04:56.354236636 +0200
@@ -67,7 +67,7 @@ static inline struct pt_regs *
 get_user_regs(struct task_struct *task)
 {
 	return (struct pt_regs *)
-		((unsigned long)task->thread_info + THREAD_SIZE -
+		((unsigned long)task->stack + THREAD_SIZE -
 				 8 - sizeof(struct pt_regs));
 }
 
Index: linux-2.6-mm/arch/arm/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/traps.c	2005-09-01 21:04:54.169611954 +0200
+++ linux-2.6-mm/arch/arm/kernel/traps.c	2005-09-01 21:04:56.355236465 +0200
@@ -220,7 +220,7 @@ NORET_TYPE void die(const char *str, str
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem("Stack: ", regs->ARM_sp,
-			 THREAD_SIZE + (unsigned long)tsk->thread_info);
+			 THREAD_SIZE + (unsigned long)tsk->stack);
 		dump_backtrace(regs, tsk);
 		dump_instr(regs);
 	}
Index: linux-2.6-mm/arch/arm26/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/arm26/kernel/traps.c	2005-09-01 21:04:54.188608690 +0200
+++ linux-2.6-mm/arch/arm26/kernel/traps.c	2005-09-01 21:04:56.355236465 +0200
@@ -132,7 +132,7 @@ static void dump_instr(struct pt_regs *r
 
 /*static*/ void __dump_stack(struct task_struct *tsk, unsigned long sp)
 {
-	dump_mem("Stack: ", sp, 8192+(unsigned long)tsk->thread_info);
+	dump_mem("Stack: ", sp, 8192+(unsigned long)tsk->stack);
 }
 
 void dump_stack(void)
@@ -168,7 +168,7 @@ void dump_backtrace(struct pt_regs *regs
 
 /* FIXME - this is probably wrong.. */
 void show_stack(struct task_struct *task, unsigned long *sp) {
-	dump_mem("Stack: ", (unsigned long)sp, 8192+(unsigned long)task->thread_info);
+	dump_mem("Stack: ", (unsigned long)sp, 8192+(unsigned long)task->stack);
 }
 
 DEFINE_SPINLOCK(die_lock);
Index: linux-2.6-mm/arch/frv/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/frv/kernel/process.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/frv/kernel/process.c	2005-09-01 21:04:56.398229079 +0200
@@ -200,7 +200,7 @@ int copy_thread(int nr, unsigned long cl
 
 	regs0 = __kernel_frame0_ptr;
 	childregs0 = (struct pt_regs *)
-		((unsigned long) p->thread_info + THREAD_SIZE - USER_CONTEXT_SIZE);
+		((unsigned long)p->stack + THREAD_SIZE - USER_CONTEXT_SIZE);
 	childregs = childregs0;
 
 	/* set up the userspace frame (the only place that the USP is stored) */
Index: linux-2.6-mm/arch/h8300/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/h8300/kernel/process.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/h8300/kernel/process.c	2005-09-01 21:04:56.454219459 +0200
@@ -193,7 +193,7 @@ int copy_thread(int nr, unsigned long cl
 {
 	struct pt_regs * childregs;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long)p->stack)) - 1;
 
 	*childregs = *regs;
 	childregs->retpc = (unsigned long) ret_from_fork;
Index: linux-2.6-mm/arch/i386/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/i386/kernel/process.c	2005-09-01 21:04:56.524207436 +0200
@@ -442,7 +442,7 @@ int copy_thread(int nr, unsigned long cl
 	struct task_struct *tsk;
 	int err;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long)p->stack)) - 1;
 	/*
 	 * The below -8 is to reserve 8 bytes on top of the ring0 stack.
 	 * This is necessary to guarantee that the entire "struct pt_regs"
@@ -563,7 +563,7 @@ int dump_task_regs(struct task_struct *t
 	struct pt_regs ptregs;
 	
 	ptregs = *(struct pt_regs *)
-		((unsigned long)tsk->thread_info+THREAD_SIZE - sizeof(ptregs));
+		((unsigned long)tsk->stack+THREAD_SIZE - sizeof(ptregs));
 	ptregs.xcs &= 0xffff;
 	ptregs.xds &= 0xffff;
 	ptregs.xes &= 0xffff;
@@ -806,7 +806,7 @@ unsigned long get_wchan(struct task_stru
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
-	stack_page = (unsigned long)p->thread_info;
+	stack_page = (unsigned long)p->stack;
 	esp = p->thread.esp;
 	if (!stack_page || esp < stack_page || esp > top_esp+stack_page)
 		return 0;
Index: linux-2.6-mm/arch/m32r/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/m32r/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/m32r/kernel/process.c	2005-09-01 21:04:56.593195584 +0200
@@ -237,7 +237,7 @@ int copy_thread(int nr, unsigned long cl
 	unsigned long unused, struct task_struct *tsk, struct pt_regs *regs)
 {
 	struct pt_regs *childregs;
-	unsigned long sp = (unsigned long)tsk->thread_info + THREAD_SIZE;
+	unsigned long sp = (unsigned long)tsk->stack + THREAD_SIZE;
 	extern void ret_from_fork(void);
 
 	/* Copy registers */
Index: linux-2.6-mm/arch/m32r/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/m32r/kernel/ptrace.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/m32r/kernel/ptrace.c	2005-09-01 21:04:56.614191976 +0200
@@ -47,7 +47,7 @@ static inline struct pt_regs *
 get_user_regs(struct task_struct *task)
 {
         return (struct pt_regs *)
-                ((unsigned long)task->thread_info + THREAD_SIZE
+                ((unsigned long)task->stack + THREAD_SIZE
                  - sizeof(struct pt_regs));
 }
 
Index: linux-2.6-mm/arch/m68k/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/m68k/kernel/process.c	2005-09-01 21:04:56.634188541 +0200
@@ -239,7 +239,7 @@ int copy_thread(int nr, unsigned long cl
 	unsigned long stack_offset, *retp;
 
 	stack_offset = THREAD_SIZE - sizeof(struct pt_regs);
-	childregs = (struct pt_regs *) ((unsigned long) (p->thread_info) + stack_offset);
+	childregs = (struct pt_regs *) ((unsigned long)p->stack + stack_offset);
 
 	*childregs = *regs;
 	childregs->d0 = 0;
@@ -384,7 +384,7 @@ unsigned long get_wchan(struct task_stru
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	stack_page = (unsigned long)(p->thread_info);
+	stack_page = (unsigned long)p->stack;
 	fp = ((struct switch_stack *)p->thread.ksp)->a6;
 	do {
 		if (fp < stack_page+sizeof(struct thread_info) ||
Index: linux-2.6-mm/arch/m68knommu/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/m68knommu/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/m68knommu/kernel/process.c	2005-09-01 21:04:56.676181327 +0200
@@ -201,7 +201,7 @@ int copy_thread(int nr, unsigned long cl
 	unsigned long stack_offset, *retp;
 
 	stack_offset = THREAD_SIZE - sizeof(struct pt_regs);
-	childregs = (struct pt_regs *) ((unsigned long) p->thread_info + stack_offset);
+	childregs = (struct pt_regs *) ((unsigned long)p->stack + stack_offset);
 
 	*childregs = *regs;
 	childregs->d0 = 0;
Index: linux-2.6-mm/arch/mips/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/kernel/ptrace.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/mips/kernel/ptrace.c	2005-09-01 21:04:56.742169990 +0200
@@ -112,7 +112,7 @@ asmlinkage int sys_ptrace(long request, 
 		struct pt_regs *regs;
 		unsigned long tmp = 0;
 
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+		regs = (struct pt_regs *) ((unsigned long)child->stack +
 		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
 		ret = 0;  /* Default return value. */
 
@@ -197,7 +197,7 @@ asmlinkage int sys_ptrace(long request, 
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
 		ret = 0;
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+		regs = (struct pt_regs *) ((unsigned long)child->stack +
 		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
 
 		switch (addr) {
Index: linux-2.6-mm/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/kernel/ptrace32.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/mips/kernel/ptrace32.c	2005-09-01 21:04:56.760166898 +0200
@@ -104,7 +104,7 @@ asmlinkage int sys32_ptrace(int request,
 		struct pt_regs *regs;
 		unsigned int tmp;
 
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+		regs = (struct pt_regs *) ((unsigned long)child->stack +
 		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
 		ret = 0;  /* Default return value. */
 
@@ -184,7 +184,7 @@ asmlinkage int sys32_ptrace(int request,
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
 		ret = 0;
-		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+		regs = (struct pt_regs *) ((unsigned long)child->stack +
 		       THREAD_SIZE - 32 - sizeof(struct pt_regs));
 
 		switch (addr) {
Index: linux-2.6-mm/arch/mips/pmc-sierra/yosemite/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/pmc-sierra/yosemite/smp.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/mips/pmc-sierra/yosemite/smp.c	2005-09-01 21:04:56.805159169 +0200
@@ -93,7 +93,7 @@ void __init prom_prepare_cpus(unsigned i
  */
 void prom_boot_secondary(int cpu, struct task_struct *idle)
 {
-	unsigned long gp = (unsigned long) idle->thread_info;
+	unsigned long gp = (unsigned long)idle->stack;
 	unsigned long sp = gp + THREAD_SIZE - 32;
 
 	secondary_sp = sp;
Index: linux-2.6-mm/arch/mips/sgi-ip27/ip27-smp.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/sgi-ip27/ip27-smp.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/mips/sgi-ip27/ip27-smp.c	2005-09-01 21:04:56.847151954 +0200
@@ -177,7 +177,7 @@ void __init prom_prepare_cpus(unsigned i
  */
 void __init prom_boot_secondary(int cpu, struct task_struct *idle)
 {
-	unsigned long gp = (unsigned long) idle->thread_info;
+	unsigned long gp = (unsigned long)idle->stack;
 	unsigned long sp = gp + THREAD_SIZE - 32;
 
 	LAUNCH_SLAVE(cputonasid(cpu),cputoslice(cpu),
Index: linux-2.6-mm/arch/ppc/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc/kernel/process.c	2005-09-01 21:04:54.236600445 +0200
+++ linux-2.6-mm/arch/ppc/kernel/process.c	2005-09-01 21:04:56.868148347 +0200
@@ -420,7 +420,7 @@ copy_thread(int nr, unsigned long clone_
 {
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
-	unsigned long sp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long sp = (unsigned long)p->stack + THREAD_SIZE;
 	unsigned long childframe;
 
 	CHECK_FULL_REGS(regs);
@@ -639,7 +639,7 @@ void show_stack(struct task_struct *tsk,
 	}
 
 	prev_sp = (unsigned long)end_of_stack(tsk);
-	stack_top = (unsigned long) tsk->thread_info + THREAD_SIZE;
+	stack_top = (unsigned long)tsk->stack + THREAD_SIZE;
 	while (count < 16 && sp > prev_sp && sp < stack_top && (sp & 3) == 0) {
 		if (count == 0) {
 			printk("Call trace:");
@@ -768,7 +768,7 @@ void __init ll_puts(const char *s)
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
-	unsigned long stack_page = (unsigned long) p->thread_info;
+	unsigned long stack_page = (unsigned long)p->stack;
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
Index: linux-2.6-mm/arch/ppc64/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc64/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/ppc64/kernel/process.c	2005-09-01 21:04:56.905141992 +0200
@@ -365,7 +365,7 @@ copy_thread(int nr, unsigned long clone_
 {
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
-	unsigned long sp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long sp = (unsigned long)p->stack + THREAD_SIZE;
 
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
@@ -454,7 +454,7 @@ void start_thread(struct pt_regs *regs, 
 	 * set. Do it now.
 	 */
 	if (!current->thread.regs) {
-		unsigned long childregs = (unsigned long)current->thread_info +
+		unsigned long childregs = (unsigned long)current->stack +
 						THREAD_SIZE;
 		childregs -= sizeof(struct pt_regs);
 		current->thread.regs = (struct pt_regs *)childregs;
@@ -578,7 +578,7 @@ static int kstack_depth_to_print = 64;
 static int validate_sp(unsigned long sp, struct task_struct *p,
 		       unsigned long nbytes)
 {
-	unsigned long stack_page = (unsigned long)p->thread_info;
+	unsigned long stack_page = (unsigned long)p->stack;
 
 	if (sp >= stack_page + sizeof(struct thread_struct)
 	    && sp <= stack_page + THREAD_SIZE - nbytes)
Index: linux-2.6-mm/arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc64/kernel/sys_ppc32.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/ppc64/kernel/sys_ppc32.c	2005-09-01 21:04:56.917139930 +0200
@@ -620,7 +620,7 @@ void start_thread32(struct pt_regs* regs
 	 * set. Do it now.
 	 */
 	if (!current->thread.regs) {
-		unsigned long childregs = (unsigned long)current->thread_info +
+		unsigned long childregs = (unsigned long)current->stack +
 						THREAD_SIZE;
 		childregs -= sizeof(struct pt_regs);
 		current->thread.regs = (struct pt_regs *)childregs;
Index: linux-2.6-mm/arch/s390/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/s390/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/s390/kernel/process.c	2005-09-01 21:04:56.977129624 +0200
@@ -212,7 +212,7 @@ int copy_thread(int nr, unsigned long cl
           } *frame;
 
         frame = ((struct fake_frame *)
-		 (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+		 (THREAD_SIZE + (unsigned long)p->stack)) - 1;
         p->thread.ksp = (unsigned long) frame;
 	/* Store access registers to kernel stack of new process. */
         frame->childregs = *regs;
@@ -375,9 +375,9 @@ unsigned long get_wchan(struct task_stru
 
 	if (!p || p == current || p->state == TASK_RUNNING || !p->thread_info)
 		return 0;
-	low = (struct stack_frame *) p->thread_info;
+	low = (struct stack_frame *)p->stack;
 	high = (struct stack_frame *)
-		((unsigned long) p->thread_info + THREAD_SIZE) - 1;
+		((unsigned long)p->stack + THREAD_SIZE) - 1;
 	sf = (struct stack_frame *) (p->thread.ksp & PSW_ADDR_INSN);
 	if (sf <= low || sf > high)
 		return 0;
Index: linux-2.6-mm/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/s390/kernel/smp.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/s390/kernel/smp.c	2005-09-01 21:04:57.001125502 +0200
@@ -653,7 +653,7 @@ __cpu_up(unsigned int cpu)
 	idle = current_set[cpu];
         cpu_lowcore = lowcore_ptr[cpu];
 	cpu_lowcore->kernel_stack = (unsigned long)
-		idle->thread_info + (THREAD_SIZE);
+		idle->stack + THREAD_SIZE;
 	sf = (struct stack_frame *) (cpu_lowcore->kernel_stack
 				     - sizeof(struct pt_regs)
 				     - sizeof(struct stack_frame));
Index: linux-2.6-mm/arch/s390/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/s390/kernel/traps.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/s390/kernel/traps.c	2005-09-01 21:04:57.002125330 +0200
@@ -137,8 +137,8 @@ void show_trace(struct task_struct *task
 	sp = __show_trace(sp, S390_lowcore.async_stack - ASYNC_SIZE,
 			  S390_lowcore.async_stack);
 	if (task)
-		__show_trace(sp, (unsigned long) task->thread_info,
-			     (unsigned long) task->thread_info + THREAD_SIZE);
+		__show_trace(sp, (unsigned long)task->stack,
+			     (unsigned long)task->stack + THREAD_SIZE);
 	else
 		__show_trace(sp, S390_lowcore.thread_info,
 			     S390_lowcore.thread_info + THREAD_SIZE);
Index: linux-2.6-mm/arch/sh/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sh/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sh/kernel/process.c	2005-09-01 21:04:57.041118631 +0200
@@ -196,7 +196,7 @@ void flush_thread(void)
 #if defined(CONFIG_SH_FPU)
 	struct task_struct *tsk = current;
 	struct pt_regs *regs = (struct pt_regs *)
-				((unsigned long)tsk->thread_info
+				((unsigned long)tsk->stack
 				 + THREAD_SIZE - sizeof(struct pt_regs)
 				 - sizeof(unsigned long));
 
@@ -237,7 +237,7 @@ int dump_task_regs(struct task_struct *t
 	struct pt_regs ptregs;
 	
 	ptregs = *(struct pt_regs *)
-		((unsigned long)tsk->thread_info + THREAD_SIZE
+		((unsigned long)tsk->stack + THREAD_SIZE
 		 - sizeof(struct pt_regs)
 #ifdef CONFIG_SH_DSP
 		 - sizeof(struct pt_dspregs)
@@ -257,7 +257,7 @@ dump_task_fpu (struct task_struct *tsk, 
 	fpvalid = !!tsk_used_math(tsk);
 	if (fpvalid) {
 		struct pt_regs *regs = (struct pt_regs *)
-					((unsigned long)tsk->thread_info
+					((unsigned long)tsk->stack
 					 + THREAD_SIZE - sizeof(struct pt_regs)
 					 - sizeof(unsigned long));
 		unlazy_fpu(tsk, regs);
@@ -284,7 +284,7 @@ int copy_thread(int nr, unsigned long cl
 #endif
 
 	childregs = ((struct pt_regs *)
-		(THREAD_SIZE + (unsigned long) p->thread_info)
+		(THREAD_SIZE + (unsigned long)p->stack)
 #ifdef CONFIG_SH_DSP
 		- sizeof(struct pt_dspregs)
 #endif
@@ -294,7 +294,7 @@ int copy_thread(int nr, unsigned long cl
 	if (user_mode(regs)) {
 		childregs->regs[15] = usp;
 	} else {
-		childregs->regs[15] = (unsigned long)p->thread_info + THREAD_SIZE;
+		childregs->regs[15] = (unsigned long)p->stack + THREAD_SIZE;
 	}
         if (clone_flags & CLONE_SETTLS) {
 		childregs->gbr = childregs->regs[0];
@@ -358,7 +358,7 @@ struct task_struct *__switch_to(struct t
 {
 #if defined(CONFIG_SH_FPU)
 	struct pt_regs *regs = (struct pt_regs *)
-				((unsigned long)prev->thread_info
+				((unsigned long)prev->stack
 				 + THREAD_SIZE - sizeof(struct pt_regs)
 				 - sizeof(unsigned long));
 	unlazy_fpu(prev, regs);
@@ -371,7 +371,7 @@ struct task_struct *__switch_to(struct t
 
 		local_irq_save(flags);
 		regs = (struct pt_regs *)
-			((unsigned long)prev->thread_info
+			((unsigned long)prev->stack
 			 + THREAD_SIZE - sizeof(struct pt_regs)
 #ifdef CONFIG_SH_DSP
 			 - sizeof(struct pt_dspregs)
Index: linux-2.6-mm/arch/sh/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/sh/kernel/ptrace.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sh/kernel/ptrace.c	2005-09-01 21:04:57.051116913 +0200
@@ -42,7 +42,7 @@ static inline int get_stack_long(struct 
 	unsigned char *stack;
 
 	stack = (unsigned char *)
-		task->thread_info + THREAD_SIZE	- sizeof(struct pt_regs)
+		task->stack + THREAD_SIZE - sizeof(struct pt_regs)
 #ifdef CONFIG_SH_DSP
 		- sizeof(struct pt_dspregs)
 #endif
@@ -60,7 +60,7 @@ static inline int put_stack_long(struct 
 	unsigned char *stack;
 
 	stack = (unsigned char *)
-		task->thread_info + THREAD_SIZE - sizeof(struct pt_regs)
+		task->stack + THREAD_SIZE - sizeof(struct pt_regs)
 #ifdef CONFIG_SH_DSP
 		- sizeof(struct pt_dspregs)
 #endif
Index: linux-2.6-mm/arch/sh64/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sh64/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sh64/kernel/process.c	2005-09-01 21:04:57.087110730 +0200
@@ -750,7 +750,7 @@ int copy_thread(int nr, unsigned long cl
 	}
 #endif
 	/* Copy from sh version */
-	childregs = ((struct pt_regs *)(THREAD_SIZE + (unsigned long) p->thread_info )) - 1;
+	childregs = ((struct pt_regs *)(THREAD_SIZE + (unsigned long)p->stack)) - 1;
 
 	*childregs = *regs;
 
@@ -758,7 +758,7 @@ int copy_thread(int nr, unsigned long cl
 		childregs->regs[15] = usp;
 		p->thread.uregs = childregs;
 	} else {
-		childregs->regs[15] = (unsigned long)p->thread_info + THREAD_SIZE;
+		childregs->regs[15] = (unsigned long)p->stack + THREAD_SIZE;
 	}
 
 	childregs->regs[9] = 0; /* Set return value for child */
Index: linux-2.6-mm/arch/sh64/lib/dbg.c
===================================================================
--- linux-2.6-mm.orig/arch/sh64/lib/dbg.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sh64/lib/dbg.c	2005-09-01 21:04:57.113106264 +0200
@@ -174,7 +174,7 @@ void evt_debug(int evt, int ret_addr, in
 	struct ring_node *rr;
 
 	pid = current->pid;
-	stack_bottom = (unsigned long) current->thread_info;
+	stack_bottom = (unsigned long)current->stack;
 	asm volatile("ori r15, 0, %0" : "=r" (sp));
 	rr = event_ring + event_ptr;
 	rr->evt = evt;
Index: linux-2.6-mm/arch/sparc/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sparc/kernel/process.c	2005-09-01 21:04:57.151099737 +0200
@@ -303,7 +303,7 @@ void show_stack(struct task_struct *tsk,
 	int count = 0;
 
 	if (tsk != NULL)
-		task_base = (unsigned long) tsk->thread_info;
+		task_base = (unsigned long)tsk->stack;
 	else
 		task_base = (unsigned long) current_thread_info();
 
@@ -393,7 +393,7 @@ void flush_thread(void)
 		/* We must fixup kregs as well. */
 		/* XXX This was not fixed for ti for a while, worked. Unused? */
 		current->thread.kregs = (struct pt_regs *)
-		    ((char *)current->thread_info + (THREAD_SIZE - TRACEREG_SZ));
+		    ((char *)current->stack + (THREAD_SIZE - TRACEREG_SZ));
 	}
 }
 
Index: linux-2.6-mm/arch/sparc64/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/process.c	2005-09-01 21:04:57.208089946 +0200
@@ -833,7 +833,7 @@ unsigned long get_wchan(struct task_stru
             task->state == TASK_RUNNING)
 		goto out;
 
-	thread_info_base = (unsigned long) task->thread_info;
+	thread_info_base = (unsigned long)task->stack;
 	bias = STACK_BIAS;
 	fp = task->thread_info->ksp + bias;
 
Index: linux-2.6-mm/arch/sparc64/kernel/traps.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc64/kernel/traps.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sparc64/kernel/traps.c	2005-09-01 21:04:57.240084449 +0200
@@ -1868,7 +1868,7 @@ static inline int is_kernel_stack(struct
 			return 0;
 	}
 
-	thread_base = (unsigned long) task->thread_info;
+	thread_base = (unsigned long)task->stack;
 	thread_end = thread_base + sizeof(union thread_union);
 	if (rw_addr >= thread_base &&
 	    rw_addr < thread_end &&
Index: linux-2.6-mm/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6-mm.orig/arch/um/kernel/tt/process_kern.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/um/kernel/tt/process_kern.c	2005-09-01 21:04:57.309072597 +0200
@@ -430,7 +430,7 @@ int start_uml_tt(void)
 	int pages;
 
 	pages = (1 << CONFIG_KERNEL_STACK_ORDER);
-	sp = (void *) ((unsigned long) init_task.thread_info) +
+	sp = (void *) ((unsigned long) init_task.stack) +
 		pages * PAGE_SIZE - sizeof(unsigned long);
 	return(tracer(start_kernel_proc, sp));
 }
Index: linux-2.6-mm/arch/v850/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/v850/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/v850/kernel/process.c	2005-09-01 21:04:57.365062978 +0200
@@ -110,7 +110,7 @@ int copy_thread (int nr, unsigned long c
 		 struct task_struct *p, struct pt_regs *regs)
 {
 	/* Start pushing stuff from the top of the child's kernel stack.  */
-	unsigned long orig_ksp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long orig_ksp = (unsigned long)p->stack + THREAD_SIZE;
 	unsigned long ksp = orig_ksp;
 	/* We push two `state save' stack fames (see entry.S) on the new
 	   kernel stack:
Index: linux-2.6-mm/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/process.c	2005-09-01 21:04:57.427052328 +0200
@@ -429,7 +429,7 @@ int copy_thread(int nr, unsigned long cl
 	struct pt_regs * childregs;
 	struct task_struct *me = current;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long)p->stack)) - 1;
 
 	*childregs = *regs;
 
@@ -596,7 +596,7 @@ struct task_struct *__switch_to(struct t
 	prev->userrsp = read_pda(oldrsp); 
 	write_pda(oldrsp, next->userrsp); 
 	write_pda(pcurrent, next_p); 
-	write_pda(kernelstack, (unsigned long)next_p->thread_info + THREAD_SIZE - PDA_STACKOFFSET);
+	write_pda(kernelstack, (unsigned long)next_p->stack + THREAD_SIZE - PDA_STACKOFFSET);
 
 	/*
 	 * Now maybe reload the debug registers
@@ -712,7 +712,7 @@ unsigned long get_wchan(struct task_stru
 
 	if (!p || p == current || p->state==TASK_RUNNING)
 		return 0; 
-	stack = (unsigned long)p->thread_info; 
+	stack = (unsigned long)p->stack;
 	if (p->thread.rsp < stack || p->thread.rsp > stack+THREAD_SIZE)
 		return 0;
 	fp = *(u64 *)(p->thread.rsp);
Index: linux-2.6-mm/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/kernel/smpboot.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/x86_64/kernel/smpboot.c	2005-09-01 21:04:57.442049752 +0200
@@ -719,7 +719,7 @@ static int __cpuinit do_boot_cpu(int cpu
 
 	if (c_idle.idle) {
 		c_idle.idle->thread.rsp = (unsigned long) (((struct pt_regs *)
-			(THREAD_SIZE + (unsigned long) c_idle.idle->thread_info)) - 1);
+			(THREAD_SIZE + (unsigned long)c_idle.idle->stack)) - 1);
 		init_idle(c_idle.idle, cpu);
 		goto do_rest;
 	}
Index: linux-2.6-mm/include/asm-alpha/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/processor.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-alpha/processor.h	2005-09-01 21:04:57.446049065 +0200
@@ -61,7 +61,7 @@ unsigned long get_wchan(struct task_stru
   + offsetof(struct switch_stack, reg))
 
 #define KSTK_EIP(tsk) \
-  (*(unsigned long *)(PT_REG(pc) + (unsigned long) ((tsk)->thread_info)))
+  (*(unsigned long *)(PT_REG(pc) + (unsigned long)((tsk)->stack)))
 
 #define KSTK_ESP(tsk) \
   ((tsk) == current ? rdusp() : (tsk)->thread_info->pcb.usp)
Index: linux-2.6-mm/include/asm-alpha/ptrace.h
===================================================================
--- linux-2.6-mm.orig/include/asm-alpha/ptrace.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-alpha/ptrace.h	2005-09-01 21:04:57.447048893 +0200
@@ -73,7 +73,7 @@ struct switch_stack {
 extern void show_regs(struct pt_regs *);
 
 #define alpha_task_regs(task) \
-  ((struct pt_regs *) ((long) (task)->thread_info + 2*PAGE_SIZE) - 1)
+  ((struct pt_regs *) ((long) (task)->stack + 2*PAGE_SIZE) - 1)
 
 #define force_successful_syscall_return() (alpha_task_regs(current)->r0 = 0)
 
Index: linux-2.6-mm/include/asm-arm/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-arm/processor.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-arm/processor.h	2005-09-01 21:04:57.451048206 +0200
@@ -85,7 +85,7 @@ unsigned long get_wchan(struct task_stru
  */
 extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-#define KSTK_REGS(tsk)	(((struct pt_regs *)(THREAD_START_SP + (unsigned long)(tsk)->thread_info)) - 1)
+#define KSTK_REGS(tsk)	(((struct pt_regs *)(THREAD_START_SP + (unsigned long)(tsk)->stack)) - 1)
 #define KSTK_EIP(tsk)	KSTK_REGS(tsk)->ARM_pc
 #define KSTK_ESP(tsk)	KSTK_REGS(tsk)->ARM_sp
 
Index: linux-2.6-mm/include/asm-i386/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/processor.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-i386/processor.h	2005-09-01 21:04:57.469045114 +0200
@@ -427,7 +427,7 @@ unsigned long get_wchan(struct task_stru
 #define task_pt_regs(task)                                             \
 ({                                                                     \
        struct pt_regs *__regs__;                                       \
-       __regs__ = (struct pt_regs *)KSTK_TOP((task)->thread_info);     \
+       __regs__ = (struct pt_regs *)KSTK_TOP((task)->stack);           \
        __regs__ - 1;                                                   \
 })
 
Index: linux-2.6-mm/include/asm-mips/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-mips/processor.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-mips/processor.h	2005-09-01 21:04:57.486042194 +0200
@@ -180,7 +180,7 @@ extern void start_thread(struct pt_regs 
 unsigned long get_wchan(struct task_struct *p);
 
 #define __PT_REG(reg) ((long)&((struct pt_regs *)0)->reg - sizeof(struct pt_regs))
-#define __KSTK_TOS(tsk) ((unsigned long)(tsk->thread_info) + THREAD_SIZE - 32)
+#define __KSTK_TOS(tsk) ((unsigned long)(tsk)->stack + THREAD_SIZE - 32)
 #define KSTK_EIP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_epc)))
 #define KSTK_ESP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(regs[29])))
 #define KSTK_STATUS(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_status)))
Index: linux-2.6-mm/include/asm-s390/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-s390/processor.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-s390/processor.h	2005-09-01 21:04:57.501039618 +0200
@@ -192,7 +192,7 @@ extern void show_trace(struct task_struc
 
 unsigned long get_wchan(struct task_struct *p);
 #define __KSTK_PTREGS(tsk) ((struct pt_regs *) \
-        ((unsigned long) tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs)))
+        ((unsigned long)(tsk)->stack + THREAD_SIZE - sizeof(struct pt_regs)))
 #define KSTK_EIP(tsk)	(__KSTK_PTREGS(tsk)->psw.addr)
 #define KSTK_ESP(tsk)	(__KSTK_PTREGS(tsk)->gprs[15])
 
Index: linux-2.6-mm/include/asm-v850/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-v850/processor.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-v850/processor.h	2005-09-01 21:04:57.512037728 +0200
@@ -98,7 +98,7 @@ unsigned long get_wchan (struct task_str
 
 
 /* Return some info about the user process TASK.  */
-#define task_tos(task)	((unsigned long)(task)->thread_info + THREAD_SIZE)
+#define task_tos(task)	((unsigned long)(task)->stack + THREAD_SIZE)
 #define task_regs(task) ((struct pt_regs *)task_tos (task) - 1)
 #define task_sp(task)	(task_regs (task)->gpr[GPR_SP])
 #define task_pc(task)	(task_regs (task)->pc)
Index: linux-2.6-mm/arch/xtensa/kernel/process.c
===================================================================
--- linux-2.6-mm.orig/arch/xtensa/kernel/process.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/xtensa/kernel/process.c	2005-09-01 21:04:57.566028453 +0200
@@ -144,7 +144,7 @@ int copy_thread(int nr, unsigned long cl
 	int user_mode = user_mode(regs);
 
 	/* Set up new TSS. */
-	tos = (unsigned long)p->thread_info + THREAD_SIZE;
+	tos = (unsigned long)p->stack + THREAD_SIZE;
 	if (user_mode)
 		childregs = (struct pt_regs*)(tos - PT_USER_SIZE);
 	else
@@ -216,7 +216,7 @@ int kernel_thread(int (*fn)(void *), voi
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long sp, pc;
-	unsigned long stack_page = (unsigned long) p->thread_info;
+	unsigned long stack_page = (unsigned long)p->stack;
 	int count = 0;
 
 	if (!p || p == current || p->state == TASK_RUNNING)
Index: linux-2.6-mm/include/asm-xtensa/ptrace.h
===================================================================
--- linux-2.6-mm.orig/include/asm-xtensa/ptrace.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/asm-xtensa/ptrace.h	2005-09-01 21:04:57.598022956 +0200
@@ -114,7 +114,7 @@ struct pt_regs {
 
 #ifdef __KERNEL__
 # define xtensa_pt_regs(tsk) ((struct pt_regs*) \
-  (((long)(tsk)->thread_info + KERNEL_STACK_SIZE - (XCHAL_NUM_AREGS-16)*4)) - 1)
+  (((long)(tsk)->stack + KERNEL_STACK_SIZE - (XCHAL_NUM_AREGS-16)*4)) - 1)
 # define user_mode(regs) (((regs)->ps & 0x00000020)!=0)
 # define instruction_pointer(regs) ((regs)->pc)
 extern void show_regs(struct pt_regs *);
Index: linux-2.6-mm/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/smpboot.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/i386/kernel/smpboot.c	2005-09-01 21:04:57.632017116 +0200
@@ -847,7 +847,7 @@ static inline struct task_struct * alloc
 		 * idle tread
 		 */
 		idle->thread.esp = (unsigned long)(((struct pt_regs *)
-			(THREAD_SIZE + (unsigned long) idle->thread_info)) - 1);
+			(THREAD_SIZE + (unsigned long)idle->stack)) - 1);
 		init_idle(idle, cpu);
 		return idle;
 	}
Index: linux-2.6-mm/arch/arm/kernel/smp.c
===================================================================
--- linux-2.6-mm.orig/arch/arm/kernel/smp.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/arm/kernel/smp.c	2005-09-01 21:04:57.657012822 +0200
@@ -110,7 +110,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	 * We need to tell the secondary core where to find
 	 * its stack and the page tables.
 	 */
-	secondary_data.stack = (void *)idle->thread_info + THREAD_SIZE - 8;
+	secondary_data.stack = idle->stack + THREAD_SIZE - 8;
 	secondary_data.pgdir = virt_to_phys(pgd);
 	wmb();
 
Index: linux-2.6-mm/arch/h8300/kernel/asm-offsets.c
===================================================================
--- linux-2.6-mm.orig/arch/h8300/kernel/asm-offsets.c	2005-09-01 13:21:49.000000000 +0200
+++ linux-2.6-mm/arch/h8300/kernel/asm-offsets.c	2005-09-01 21:04:57.672010245 +0200
@@ -30,7 +30,7 @@ int main(void)
 	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
 	DEFINE(TASK_BLOCKED, offsetof(struct task_struct, blocked));
 	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
-	DEFINE(TASK_THREAD_INFO, offsetof(struct task_struct, thread_info));
+	DEFINE(TASK_THREAD_INFO, offsetof(struct task_struct, stack));
 	DEFINE(TASK_MM, offsetof(struct task_struct, mm));
 	DEFINE(TASK_ACTIVE_MM, offsetof(struct task_struct, active_mm));
 
Index: linux-2.6-mm/arch/m68knommu/kernel/asm-offsets.c
===================================================================
--- linux-2.6-mm.orig/arch/m68knommu/kernel/asm-offsets.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/m68knommu/kernel/asm-offsets.c	2005-09-01 21:04:57.683008356 +0200
@@ -30,7 +30,7 @@ int main(void)
 	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
 	DEFINE(TASK_BLOCKED, offsetof(struct task_struct, blocked));
 	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
-	DEFINE(TASK_THREAD_INFO, offsetof(struct task_struct, thread_info));
+	DEFINE(TASK_THREAD_INFO, offsetof(struct task_struct, stack));
 	DEFINE(TASK_MM, offsetof(struct task_struct, mm));
 	DEFINE(TASK_ACTIVE_MM, offsetof(struct task_struct, active_mm));
 
Index: linux-2.6-mm/arch/mips/kernel/offset.c
===================================================================
--- linux-2.6-mm.orig/arch/mips/kernel/offset.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/mips/kernel/offset.c	2005-09-01 21:04:57.694006466 +0200
@@ -77,7 +77,7 @@ void output_task_defines(void)
 {
 	text("/* MIPS task_struct offsets. */");
 	offset("#define TASK_STATE         ", struct task_struct, state);
-	offset("#define TASK_THREAD_INFO   ", struct task_struct, thread_info);
+	offset("#define TASK_THREAD_INFO   ", struct task_struct, stack);
 	offset("#define TASK_FLAGS         ", struct task_struct, flags);
 	offset("#define TASK_MM            ", struct task_struct, mm);
 	offset("#define TASK_PID           ", struct task_struct, pid);
Index: linux-2.6-mm/arch/parisc/kernel/asm-offsets.c
===================================================================
--- linux-2.6-mm.orig/arch/parisc/kernel/asm-offsets.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/parisc/kernel/asm-offsets.c	2005-09-01 21:04:57.739998565 +0200
@@ -55,7 +55,7 @@
 
 int main(void)
 {
-	DEFINE(TASK_THREAD_INFO, offsetof(struct task_struct, thread_info));
+	DEFINE(TASK_THREAD_INFO, offsetof(struct task_struct, stack));
 	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
 	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
 	DEFINE(TASK_SIGPENDING, offsetof(struct task_struct, pending));
Index: linux-2.6-mm/arch/ppc/kernel/asm-offsets.c
===================================================================
--- linux-2.6-mm.orig/arch/ppc/kernel/asm-offsets.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/ppc/kernel/asm-offsets.c	2005-09-01 21:04:57.767993755 +0200
@@ -35,7 +35,7 @@ int
 main(void)
 {
 	DEFINE(THREAD, offsetof(struct task_struct, thread));
-	DEFINE(THREAD_INFO, offsetof(struct task_struct, thread_info));
+	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
 	DEFINE(MM, offsetof(struct task_struct, mm));
 	DEFINE(PTRACE, offsetof(struct task_struct, ptrace));
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
Index: linux-2.6-mm/arch/s390/kernel/asm-offsets.c
===================================================================
--- linux-2.6-mm.orig/arch/s390/kernel/asm-offsets.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/s390/kernel/asm-offsets.c	2005-09-01 21:04:57.792989461 +0200
@@ -16,7 +16,7 @@
 
 int main(void)
 {
-	DEFINE(__THREAD_info, offsetof(struct task_struct, thread_info),);
+	DEFINE(__THREAD_info, offsetof(struct task_struct, stack),);
 	DEFINE(__THREAD_ksp, offsetof(struct task_struct, thread.ksp),);
 	DEFINE(__THREAD_per, offsetof(struct task_struct, thread.per_info),);
 	DEFINE(__THREAD_mm_segment,
Index: linux-2.6-mm/arch/sparc/kernel/asm-offsets.c
===================================================================
--- linux-2.6-mm.orig/arch/sparc/kernel/asm-offsets.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/sparc/kernel/asm-offsets.c	2005-09-01 21:04:57.810986369 +0200
@@ -29,7 +29,7 @@ int foo(void)
 	DEFINE(AOFF_task_gid, offsetof(struct task_struct, gid));
 	DEFINE(AOFF_task_euid, offsetof(struct task_struct, euid));
 	DEFINE(AOFF_task_egid, offsetof(struct task_struct, egid));
-	/* DEFINE(THREAD_INFO, offsetof(struct task_struct, thread_info)); */
+	/* DEFINE(THREAD_INFO, offsetof(struct task_struct, stack)); */
 	DEFINE(ASIZ_task_uid,	sizeof(current->uid));
 	DEFINE(ASIZ_task_gid,	sizeof(current->gid));
 	DEFINE(ASIZ_task_euid,	sizeof(current->euid));
Index: linux-2.6-mm/arch/v850/kernel/asm-consts.c
===================================================================
--- linux-2.6-mm.orig/arch/v850/kernel/asm-consts.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/v850/kernel/asm-consts.c	2005-09-01 21:04:57.831982762 +0200
@@ -29,7 +29,7 @@ int main (void)
 	DEFINE (TASK_PTRACE, offsetof (struct task_struct, ptrace));
 	DEFINE (TASK_BLOCKED, offsetof (struct task_struct, blocked));
 	DEFINE (TASK_THREAD, offsetof (struct task_struct, thread));
-	DEFINE (TASK_THREAD_INFO, offsetof (struct task_struct, thread_info));
+	DEFINE (TASK_THREAD_INFO, offsetof (struct task_struct, stack));
 	DEFINE (TASK_MM, offsetof (struct task_struct, mm));
 	DEFINE (TASK_ACTIVE_MM, offsetof (struct task_struct, active_mm));
 	DEFINE (TASK_PID, offsetof (struct task_struct, pid));
Index: linux-2.6-mm/arch/xtensa/kernel/asm-offsets.c
===================================================================
--- linux-2.6-mm.orig/arch/xtensa/kernel/asm-offsets.c	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/xtensa/kernel/asm-offsets.c	2005-09-01 21:04:57.831982762 +0200
@@ -70,7 +70,7 @@ int main(void)
 	DEFINE(TASK_ACTIVE_MM, offsetof (struct task_struct, active_mm));
 	DEFINE(TASK_PID, offsetof (struct task_struct, pid));
 	DEFINE(TASK_THREAD, offsetof (struct task_struct, thread));
-	DEFINE(TASK_THREAD_INFO, offsetof (struct task_struct, thread_info));
+	DEFINE(TASK_THREAD_INFO, offsetof (struct task_struct, stack));
 	DEFINE(TASK_STRUCT_SIZE, sizeof (struct task_struct));
 	BLANK();
 
