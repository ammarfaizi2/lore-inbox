Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268463AbUIWNll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268463AbUIWNll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUIWNlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:41:40 -0400
Received: from mail.renesas.com ([202.234.163.13]:9370 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268463AbUIWNjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:39:04 -0400
Date: Thu, 23 Sep 2004 22:38:47 +0900 (JST)
Message-Id: <20040923.223847.628201311.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc2-mm2] [m32r] Support PTRACE_GETREGS and
 PTRACE_SETREGS
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to ptrace.c for m32r.
Please apply.

     * arch/m32r/kernel/ptrace.c:
     Add PTRACE_GETREGS and PTRACE_SETREGS functions for the 
     native debugging support of the GNU Project Debugger, GDB.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 ptrace.c |  610 +++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 320 insertions(+), 290 deletions(-)


diff -ruNp a/arch/m32r/kernel/ptrace.c b/arch/m32r/kernel/ptrace.c
--- a/arch/m32r/kernel/ptrace.c	2004-09-23 10:10:53.000000000 +0900
+++ b/arch/m32r/kernel/ptrace.c	2004-09-23 11:55:20.000000000 +0900
@@ -1,7 +1,8 @@
 /*
- * linux/arch/sh/kernel/ptrace.c
+ * linux/arch/m32r/kernel/ptrace.c
  *
  * Copyright (C) 2002  Hirokazu Takata, Takeo Takahashi
+ * Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
  *
  * Original x86 implementation:
  *	By Ross Biro 1/23/92
@@ -9,11 +10,10 @@
  *
  * Some code taken from sh version:
  *   Copyright (C) 1999, 2000  Kaz Kojima & Niibe Yutaka
- *
+ * Some code taken from arm version:
+ *   Copyright (C) 2000 Russell King
  */
 
-/* $Id$ */
-
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -33,60 +33,213 @@
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
 
-#define DEBUG_PTRACE	0
-
 /*
- * does not yet catch signals sent when the child dies.
- * in exit.c or in signal.c.
+ * Get the address of the live pt_regs for the specified task.
+ * These are saved onto the top kernel stack when the process
+ * is not running.
+ *
+ * Note: if a user thread is execve'd from kernel space, the
+ * kernel stack will not be empty on entry to the kernel, so
+ * ptracing these tasks will fail.
  */
+static inline struct pt_regs *
+get_user_regs(struct task_struct *task)
+{
+        return (struct pt_regs *)
+                ((unsigned long)task->thread_info + THREAD_SIZE
+                 - sizeof(struct pt_regs));
+}
 
 /*
  * This routine will get a word off of the process kernel stack.
  */
-static __inline__ unsigned long int get_stack_long(struct task_struct *task,
-	int offset)
+static inline unsigned long int
+get_stack_long(struct task_struct *task, int offset)
 {
+	unsigned long *stack;
 
-	unsigned char *stack;
-
-	stack = (unsigned char *)(task->thread_info) + THREAD_SIZE
-		- sizeof(struct pt_regs);
-	stack += offset;
+	stack = (unsigned long *)get_user_regs(task);
 
-	return *((unsigned long *)stack);
+	return stack[offset];
 }
 
 /*
  * This routine will put a word on the process kernel stack.
  */
-static __inline__ int put_stack_long(struct task_struct *task, int offset,
-	unsigned long data)
+static inline int
+put_stack_long(struct task_struct *task, int offset, unsigned long data)
 {
-	unsigned char *stack;
+	unsigned long *stack;
 
-	stack = (unsigned char *)(task->thread_info) + THREAD_SIZE
-		- sizeof(struct pt_regs);
-	stack += offset;
-	*((unsigned long *)stack) = data;
+	stack = (unsigned long *)get_user_regs(task);
+	stack[offset] = data;
 
 	return 0;
 }
 
 static int reg_offset[] = {
-	(4 * PT_R0), (4 * PT_R1), (4 * PT_R2), (4 * PT_R3),
-	(4 * PT_R4), (4 * PT_R5), (4 * PT_R6), (4 * PT_R7),
-	(4 * PT_R8), (4 * PT_R9), (4 * PT_R10), (4 * PT_R11),
-	(4 * PT_R12), (4 * PT_FP), (4 * PT_LR), (4 * PT_SPU),
+	PT_R0, PT_R1, PT_R2, PT_R3, PT_R4, PT_R5, PT_R6, PT_R7,
+	PT_R8, PT_R9, PT_R10, PT_R11, PT_R12, PT_FP, PT_LR, PT_SPU,
 };
 
-static __inline__ int
+/*
+ * Read the word at offset "off" into the "struct user".  We
+ * actually access the pt_regs stored on the kernel stack.
+ */
+static int ptrace_read_user(struct task_struct *tsk, unsigned long off,
+			    unsigned long __user *data)
+{
+	unsigned long tmp;
+#ifndef NO_FPU
+	struct user * dummy = NULL;
+#endif
+
+	if ((off & 3) || (off < 0) || (off > sizeof(struct user) - 3))
+		return -EIO;
+
+	off >>= 2;
+	switch (off) {
+	case PT_EVB:
+		__asm__ __volatile__ (
+			"mvfc	%0, cr5 \n\t"
+	 		: "=r" (tmp)
+		);
+		break;
+	case PT_CBR: {
+			unsigned long psw;
+			psw = get_stack_long(tsk, PT_PSW);
+			tmp = ((psw >> 8) & 1);
+		}
+		break;
+	case PT_PSW: {
+			unsigned long psw, bbpsw;
+			psw = get_stack_long(tsk, PT_PSW);
+			bbpsw = get_stack_long(tsk, PT_BBPSW);
+			tmp = ((psw >> 8) & 0xff) | ((bbpsw & 0xff) << 8);
+		}
+		break;
+	case PT_PC:
+		tmp = get_stack_long(tsk, PT_BPC);
+		break;
+	case PT_BPC:
+		off = PT_BBPC;
+		/* fall through */
+	default: 
+		if (off < (sizeof(struct pt_regs) >> 2))
+			tmp = get_stack_long(tsk, off);
+#ifndef NO_FPU
+		else if (off >= (long)(&dummy->fpu >> 2) &&
+			 off < (long)(&dummy->u_fpvalid >> 2)) {
+			if (!tsk->used_math) {
+				if (off == (long)(&dummy->fpu.fpscr >> 2))
+					tmp = FPSCR_INIT;
+				else
+					tmp = 0;
+			} else
+				tmp = ((long *)(&tsk->thread.fpu >> 2))
+					[off - (long)&dummy->fpu];
+		} else if (off == (long)(&dummy->u_fpvalid >> 2))
+			tmp = tsk->used_math;
+#endif /* not NO_FPU */
+		else
+			tmp = 0;
+	}
+
+	return put_user(tmp, data);
+}
+
+static int ptrace_write_user(struct task_struct *tsk, unsigned long off,
+			     unsigned long data)
+{
+	int ret = -EIO;
+#ifndef NO_FPU
+	struct user * dummy = NULL;
+#endif
+
+	if ((off & 3) || off < 0 ||
+	    off > sizeof(struct user) - 3)
+		return -EIO;
+
+	off >>= 2;
+	switch (off) {
+	case PT_EVB:
+	case PT_BPC:
+	case PT_SPI:
+		/* We don't allow to modify evb. */
+		ret = 0;
+		break;
+	case PT_PSW:
+	case PT_CBR: {
+			/* We allow to modify only cbr in psw */
+			unsigned long psw;
+			psw = get_stack_long(tsk, PT_PSW);
+			psw = (psw & ~0x100) | ((data & 1) << 8);
+			ret = put_stack_long(tsk, PT_PSW, psw);
+		}
+		break;
+	case PT_PC:
+		off = PT_BPC;
+		data &= ~1;
+		/* fall through */
+	default:
+		if (off < (sizeof(struct pt_regs) >> 2))
+			ret = put_stack_long(tsk, off, data);
+#ifndef NO_FPU
+		else if (off >= (long)(&dummy->fpu >> 2) &&
+			 off < (long)(&dummy->u_fpvalid >> 2)) {
+			tsk->used_math = 1;
+			((long *)&tsk->thread.fpu)
+				[off - (long)&dummy->fpu] = data;
+			ret = 0;
+		} else if (off == (long)(&dummy->u_fpvalid >> 2)) {
+			tsk->used_math = data ? 1 : 0;
+			ret = 0;
+		}
+#endif /* not NO_FPU */
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Get all user integer registers.
+ */
+static int ptrace_getregs(struct task_struct *tsk, void __user *uregs)
+{
+	struct pt_regs *regs = get_user_regs(tsk);
+
+	return copy_to_user(uregs, regs, sizeof(struct pt_regs)) ? -EFAULT : 0;
+}
+
+/*
+ * Set all user integer registers.
+ */
+static int ptrace_setregs(struct task_struct *tsk, void __user *uregs)
+{
+	struct pt_regs newregs;
+	int ret;
+
+	ret = -EFAULT;
+	if (copy_from_user(&newregs, uregs, sizeof(struct pt_regs)) == 0) {
+		struct pt_regs *regs = get_user_regs(tsk);
+		*regs = newregs;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+
+static inline int
 check_condition_bit(struct task_struct *child)
 {
-	return (int)((get_stack_long(child, (4 * PT_PSW)) >> 8) & 1);
+	return (int)((get_stack_long(child, PT_PSW) >> 8) & 1);
 }
 
 static int
-check_condition_src(unsigned long op, unsigned long regno1, unsigned long regno2, struct task_struct *child)
+check_condition_src(unsigned long op, unsigned long regno1, 
+		    unsigned long regno2, struct task_struct *child)
 {
 	unsigned long reg1, reg2;
 
@@ -119,7 +272,8 @@ check_condition_src(unsigned long op, un
 
 static void
 compute_next_pc_for_16bit_insn(unsigned long insn, unsigned long pc,
-	unsigned long *next_pc, struct task_struct *child)
+			       unsigned long *next_pc,
+			       struct task_struct *child)
 {
 	unsigned long op, op2, op3;
 	unsigned long disp;
@@ -182,21 +336,23 @@ compute_next_pc_for_16bit_insn(unsigned 
 				return;
 #endif
 			} else if (op3 == 0xd) { /* RTE */
-				*next_pc = get_stack_long(child, (4 * PT_BPC));
+				*next_pc = get_stack_long(child, PT_BPC);
 				return;
 			}
 			break;
 		case 0xc: /* JC */
 			if (op3 == 0xc && check_condition_bit(child)) {
 				regno = insn & 0xf;
-				*next_pc = get_stack_long(child, reg_offset[regno]);
+				*next_pc = get_stack_long(child,
+							  reg_offset[regno]);
 				return;
 			}
 			break;
 		case 0xd: /* JNC */
 			if (op3 == 0xc && !check_condition_bit(child)) {
 				regno = insn & 0xf;
-				*next_pc = get_stack_long(child, reg_offset[regno]);
+				*next_pc = get_stack_long(child,
+							  reg_offset[regno]);
 				return;
 			}
 			break;
@@ -204,7 +360,8 @@ compute_next_pc_for_16bit_insn(unsigned 
 		case 0xf: /* JMP */
 			if (op3 == 0xc) { /* JMP */
 				regno = insn & 0xf;
-				*next_pc = get_stack_long(child, reg_offset[regno]);
+				*next_pc = get_stack_long(child,
+							  reg_offset[regno]);
 				return;
 			}
 			break;
@@ -218,7 +375,8 @@ compute_next_pc_for_16bit_insn(unsigned 
 
 static void
 compute_next_pc_for_32bit_insn(unsigned long insn, unsigned long pc,
-	unsigned long *next_pc, struct task_struct *child)
+			       unsigned long *next_pc,
+			       struct task_struct *child)
 {
 	unsigned long op;
 	unsigned long op2;
@@ -275,9 +433,9 @@ compute_next_pc_for_32bit_insn(unsigned 
 	*next_pc = pc + 4;
 }
 
-static __inline__ void
+static inline void
 compute_next_pc(unsigned long insn, unsigned long pc,
-	unsigned long *next_pc, struct task_struct *child)
+		unsigned long *next_pc, struct task_struct *child)
 {
 	if (insn & 0x80000000)
 		compute_next_pc_for_32bit_insn(insn, pc, next_pc, child);
@@ -330,7 +488,8 @@ int withdraw_debug_trap_for_signal(struc
 }
 
 static int
-unregister_debug_trap(struct task_struct *child, unsigned long addr, unsigned long *code)
+unregister_debug_trap(struct task_struct *child, unsigned long addr,
+		      unsigned long *code)
 {
 	struct debug_trap *p = &child->thread.debug_trap;
 
@@ -360,7 +519,7 @@ unregister_all_debug_traps(struct task_s
 	}
 }
 
-static void
+static inline void
 invalidate_cache(void)
 {
 #if defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_OPSP)
@@ -423,22 +582,22 @@ embed_debug_trap_for_signal(struct task_
 	unsigned long pc, insn;
 	int ret;
 
-	pc = get_stack_long(child, (4 * PT_BPC));
+	pc = get_stack_long(child, PT_BPC);
 	ret = access_process_vm(child, pc&~3, &insn, sizeof(insn), 0);
 	if (ret != sizeof(insn)) {
 		printk("kernel BUG at %s %d: access_process_vm returns %d\n",
-					__FILE__, __LINE__, ret);
+		       __FILE__, __LINE__, ret);
 		return;
 	}
 	compute_next_pc(insn, pc, &next_pc, child);
 	if (next_pc & 0x80000000) {
 		printk("kernel BUG at %s %d: next_pc = 0x%08x\n",
-				__FILE__, __LINE__, (int)next_pc);
+		       __FILE__, __LINE__, (int)next_pc);
 		return;
 	}
 	if (embed_debug_trap(child, next_pc)) {
 		printk("kernel BUG at %s %d: embed_debug_trap error\n",
-					__FILE__, __LINE__);
+		       __FILE__, __LINE__);
 		return;
 	}
 	invalidate_cache();
@@ -458,6 +617,15 @@ withdraw_debug_trap(struct pt_regs *regs
 	}
 }
 
+static void
+init_debug_traps(struct task_struct *child)
+{
+	struct debug_trap *p = &child->thread.debug_trap;
+	p->nr_trap = 0;
+	p->addr = 0;
+	p->insn = 0;
+}
+
 
 /*
  * Called by kernel/ptrace.c when detaching..
@@ -469,228 +637,61 @@ void ptrace_disable(struct task_struct *
 	/* nothing to do.. */
 }
 
-static void
-init_debug_traps(struct task_struct *child)
-{
-	struct debug_trap *p = &child->thread.debug_trap;
-	p->nr_trap = 0;
-	p->addr = 0;
-	p->insn = 0;
-}
-
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+static int
+do_ptrace(long request, struct task_struct *child, long addr, long data)
 {
-	struct task_struct *child;
+	unsigned long tmp;
 	int ret;
-#ifndef NO_FPU
-	struct user * dummy = NULL;
-#endif
-
-	lock_kernel();
-	ret = -EPERM;
-	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
-		goto out;
-	}
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out;
-
-	if (request == PTRACE_ATTACH) {
-#if (DEBUG_PTRACE > 1)
-printk("ptrace: PTRACE_ATTACH: child:%08lx\n", (unsigned long)child);
-#endif
-		ret = ptrace_attach(child);
-		if (ret == 0)
-			init_debug_traps(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
 
 	switch (request) {
-	/* when I and D space are separate, these will need to be fixed. */
-	case PTRACE_PEEKTEXT: /* read word at location addr. */
-	case PTRACE_PEEKDATA: {
-		unsigned long tmp;
-		int copied;
-
-#if (DEBUG_PTRACE > 1)
-printk("ptrace: PTRACE_PEEKTEXT/PEEKDATA: child:%08lx, addr:%08lx\n",
-	(unsigned long)child, addr);
-#endif
-		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
-		ret = -EIO;
-		if (copied != sizeof(tmp))
-			break;
-		ret = put_user(tmp,(unsigned long __user *) data);
-		break;
-	}
-
-	/* read the word at location addr in the USER area. */
-	case PTRACE_PEEKUSR: {
-		unsigned long tmp;
-
-#if DEBUG_PTRACE
-printk("ptrace: PTRACE_PEEKUSER: child:%08lx, addr:%08lx\n",
-	(unsigned long)child, addr);
-#endif
-		ret = -EIO;
-		if ((addr & 3) || addr < 0 ||
-		    addr > sizeof(struct user) - 3)
-			break;
-
-		switch (addr) {
-		case (4 * PT_BPC):
-			addr = (4 * PT_BBPC);
-			break;
-		case (4 * PT_EVB):
-			__asm__ __volatile__ (
-				"mvfc %0, cr5\n"
-		 		:"=r"(tmp)
-		 		:
-			);
-			ret = put_user(tmp, (unsigned long __user *)data);
-			goto out_tsk;
-			break;
-		case (4 * PT_CBR): {
-				unsigned long psw;
-				psw = get_stack_long(child, (4 * PT_PSW));
-				tmp = ((psw >> 8) & 1);
-				ret = put_user(tmp, (unsigned long __user *)data);
-				goto out_tsk;
-			}
-			break;
-		case (4 * PT_PSW): {
-				unsigned long psw, bbpsw;
-				psw = get_stack_long(child, (4 * PT_PSW));
-				bbpsw = get_stack_long(child, (4 * PT_BBPSW));
-				tmp = ((psw >> 8) & 0xff) | ((bbpsw & 0xff) << 8);
-				ret = put_user(tmp, (unsigned long __user *)data);
-				goto out_tsk;
-			}
-			break;
-		case (4 * PT_PC): {
-				unsigned long pc;
-				pc = get_stack_long(child, (4 * PT_BPC));
-				ret = put_user(pc, (unsigned long __user *)data);
-				goto out_tsk;
-			}
-			break;
-		}
-
-		if (addr < sizeof(struct pt_regs))
-			tmp = get_stack_long(child, addr);
-#ifndef NO_FPU
-		else if (addr >= (long) &dummy->fpu &&
-			 addr < (long) &dummy->u_fpvalid) {
-			if (!child->used_math) {
-				if (addr == (long)&dummy->fpu.fpscr)
-					tmp = FPSCR_INIT;
-				else
-					tmp = 0;
-			} else
-				tmp = ((long *)&child->thread.fpu)
-					[(addr - (long)&dummy->fpu) >> 2];
-		} else if (addr == (long) &dummy->u_fpvalid)
-			tmp = child->used_math;
-#endif /* not NO_FPU */
+	/*
+	 * read word at location "addr" in the child process.
+	 */
+	case PTRACE_PEEKTEXT:
+	case PTRACE_PEEKDATA:
+		ret = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+		if (ret == sizeof(tmp))
+			ret = put_user(tmp,(unsigned long __user *) data);
 		else
-			tmp = 0;
-		ret = put_user(tmp, (unsigned long __user *)data);
+			ret = -EIO;
 		break;
-	}
 
-	/* when I and D space are separate, this will have to be fixed. */
-	case PTRACE_POKETEXT: /* write the word at location addr. */
-	case PTRACE_POKEDATA:
-#if DEBUG_PTRACE
-printk("ptrace: PTRACE_POKETEXT/POKEDATA: child:%08lx, addr:%08lx, data:%08lx\n",
-	(unsigned long)child, addr, data);
-#endif
-		ret = -EIO;
-		if (access_process_vm(child, addr, &data, sizeof(data), 1)
-		    != sizeof(data)) {
-			break;
-		}
-		ret = 0;
-		if (request == PTRACE_POKETEXT) {
-			invalidate_cache();
-		}
+	/*
+	 * read the word at location addr in the USER area.
+	 */
+	case PTRACE_PEEKUSR:
+		ret = ptrace_read_user(child, addr, 
+				       (unsigned long __user *)data);
 		break;
 
-	case PTRACE_POKEUSR: /* write the word at location addr in the USER area */
-#if DEBUG_PTRACE
-printk("ptrace: PTRACE_POKEUSR: child:%08lx, addr:%08lx, data:%08lx\n",
-	(unsigned long)child, addr, data);
-#endif
-		ret = -EIO;
-		if ((addr & 3) || addr < 0 ||
-		    addr > sizeof(struct user) - 3)
-			break;
-
-		switch (addr) {
-		case (4 * PT_EVB):
-		case (4 * PT_BPC):
-		case (4 * PT_SPI):
-			/* We don't allow to modify evb. */
+	/*
+	 * write the word at location addr.
+	 */
+	case PTRACE_POKETEXT:
+	case PTRACE_POKEDATA:
+		ret = access_process_vm(child, addr, &data, sizeof(data), 1);
+		if (ret == sizeof(data)) {
 			ret = 0;
-			goto out_tsk;
-			break;
-		case (4 * PT_PSW):
-		case (4 * PT_CBR): {
-			/* We allow to modify only cbr in psw */
-			unsigned long psw;
-			psw = get_stack_long(child, (4 * PT_PSW));
-			psw = (psw & ~0x100) | ((data & 1) << 8);
-			ret = put_stack_long(child, (4 * PT_PSW), psw);
-			goto out_tsk;
+			if (request == PTRACE_POKETEXT) {
+				invalidate_cache();
 			}
-			break;
-		case (4 * PT_PC):
-			addr = (4 * PT_BPC);
-			data &= ~1;
-			break;
+		} else {
+			ret = -EIO;
 		}
+		break;
 
-		if (addr < sizeof(struct pt_regs))
-			ret = put_stack_long(child, addr, data);
-#ifndef NO_FPU
-		else if (addr >= (long) &dummy->fpu &&
-			 addr < (long) &dummy->u_fpvalid) {
-			child->used_math = 1;
-			((long *)&child->thread.fpu)
-				[(addr - (long)&dummy->fpu) >> 2] = data;
-			ret = 0;
-		} else if (addr == (long) &dummy->u_fpvalid) {
-			child->used_math = data?1:0;
-			ret = 0;
-		}
-#endif /* not NO_FPU */
+	/*
+	 * write the word at location addr in the USER area.
+	 */
+	case PTRACE_POKEUSR:
+		ret = ptrace_write_user(child, addr, data);
 		break;
 
-	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
-	case PTRACE_CONT: { /* restart after signal. */
-#if DEBUG_PTRACE
-printk("ptrace: PTRACE_SYSCALL/CONT: child:%08lx, data:%08lx\n",
-	(unsigned long)child, data);
-#endif
+	/*
+	 * continue/restart and stop at next (return from) syscall
+	 */
+	case PTRACE_SYSCALL:
+	case PTRACE_CONT: 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
@@ -702,17 +703,13 @@ printk("ptrace: PTRACE_SYSCALL/CONT: chi
 		wake_up_process(child);
 		ret = 0;
 		break;
-	}
 
-/*
- * make the child exit.  Best I can do is send it a sigkill.
- * perhaps it should be put in the status that it wants to
- * exit.
- */
+	/*
+	 * make the child exit.  Best I can do is send it a sigkill.
+	 * perhaps it should be put in the status that it wants to
+	 * exit.
+	 */
 	case PTRACE_KILL: {
-#if DEBUG_PTRACE
-printk("ptrace: PTRACE_KILL: child:%08lx\n", (unsigned long)child);
-#endif
 		ret = 0;
 		unregister_all_debug_traps(child);
 		invalidate_cache();
@@ -723,7 +720,10 @@ printk("ptrace: PTRACE_KILL: child:%08lx
 		break;
 	}
 
-	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
+	/*
+	 * execute single instruction.
+	 */
+	case PTRACE_SINGLESTEP: {
 		unsigned long next_pc;
 		unsigned long pc, insn;
 
@@ -737,23 +737,13 @@ printk("ptrace: PTRACE_KILL: child:%08lx
 		}
 
 		/* Compute next pc.  */
-		pc = get_stack_long(child, (4 * PT_BPC));
+		pc = get_stack_long(child, PT_BPC);
 
-#if DEBUG_PTRACE
-printk("ptrace: PTRACE_SINGLESTEP: child:%08lx, pc:%08lx, ",
-	(unsigned long)child, pc);
-#endif
-		if (access_process_vm(child, pc&~3, &insn, sizeof(insn), 0) != sizeof(insn))
+		if (access_process_vm(child, pc&~3, &insn, sizeof(insn), 0)
+		    != sizeof(insn))
 			break;
 
-#if DEBUG_PTRACE
-printk("(pc&~3):%08lx, insn:%08lx, ", (pc & ~3), insn);
-#endif
-
 		compute_next_pc(insn, pc, &next_pc, child);
-#if DEBUG_PTRACE
-printk("nextpc:%08lx\n", next_pc);
-#endif
 		if (next_pc & 0x80000000)
 			break;
 
@@ -762,37 +752,77 @@ printk("nextpc:%08lx\n", next_pc);
 
 		invalidate_cache();
 		child->exit_code = data;
+
 		/* give it a chance to run. */
 		wake_up_process(child);
 		ret = 0;
 		break;
 	}
 
-	case PTRACE_DETACH: /* detach a process that was attached. */
-#if DEBUG_PTRACE
-printk("ptrace: PTRACE_DETACH: child:%08lx, data:%08lx\n",
-	(unsigned long)child, data);
-#endif
+	/*
+	 * detach a process that was attached.
+	 */
+	case PTRACE_DETACH:
 		ret = 0;
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_SETOPTIONS: {
-#if DEBUG_PTRACE
-printk("ptrace: PTRACE_SETOPTIONS:\n");
-#endif
-		if (data & PTRACE_O_TRACESYSGOOD)
-			child->ptrace |= PT_TRACESYSGOOD;
-		else
-			child->ptrace &= ~PT_TRACESYSGOOD;
-		ret = 0;
+	case PTRACE_GETREGS:
+		ret = ptrace_getregs(child, (void __user *)data);
+		break;
+
+	case PTRACE_SETREGS:
+		ret = ptrace_setregs(child, (void __user *)data);
 		break;
-	}
 
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
+
+	return ret;
+}
+
+asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+{
+	struct task_struct *child;
+	int ret;
+
+	lock_kernel();
+	ret = -EPERM;
+	if (request == PTRACE_TRACEME) {
+		/* are we already being traced? */
+		if (current->ptrace & PT_PTRACED)
+			goto out;
+		/* set the ptrace bit in the process flags. */
+		current->ptrace |= PT_PTRACED;
+		ret = 0;
+		goto out;
+	}
+	ret = -ESRCH;
+	read_lock(&tasklist_lock);
+	child = find_task_by_pid(pid);
+	if (child)
+		get_task_struct(child);
+	read_unlock(&tasklist_lock);
+	if (!child)
+		goto out;
+
+	ret = -EPERM;
+	if (pid == 1)		/* you may not mess with init */
+		goto out;
+
+	if (request == PTRACE_ATTACH) {
+		ret = ptrace_attach(child);
+		if (ret == 0)
+			init_debug_traps(child);
+		goto out_tsk;
+	}
+
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret == 0)
+		ret = do_ptrace(request, child, addr, data);
+
 out_tsk:
 	put_task_struct(child);
 out:

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
