Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbWCTGLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWCTGLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWCTGLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:11:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:1424 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751654AbWCTGLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:11:06 -0500
Date: Mon, 20 Mar 2006 11:41:23 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single stepping out-of-line
Message-ID: <20060320061123.GF31091@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320061014.GE31091@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a mechanism for probe handling and
executing the user-specified handlers.

Each userspace probe is uniquely identified by the combination of
inode and offset, hence during registeration the inode and offset
combination is added to uprobes hash table. Initially when
breakpoint instruction is hit, the uprobes hash table is looked up
for matching inode and offset. The pre_handlers are called in
sequence if multiple probes are registered. Similar to kprobes,
uprobes also adopts to single step out-of-line, so that probe miss in
SMP environment can be avoided. But for userspace probes, instruction
copied into kernel address space cannot be single stepped, hence the
instruction must be copied to user address space. The solution is to
find free space in the current process address space and then copy the
original instruction and single step that instruction.

User processes use stack space to store local variables, agruments and
return values. Normally the stack space either below or above the
stack pointer indicates the free stack space.

The instruction to be single stepped can modify the stack space,
hence before using the free stack space, sufficient stack space should
be left. The instruction is copied to the bottom of the page and check
is made such that the copied instruction does not cross the page
boundry. The copied instruction is then single stepped. Several
architectures does not allow the instruction to be executed from the
stack location, since no-exec bit is set for the stack pages. In those
architectures, the page table entry corresponding to the stack page is
identified and the no-exec bit is unset making the instruction on that
stack page to be executed.

There are situations where even the free stack space is not enough for
the user instruction to be copied and single stepped. In such
situations, the virtual memory area(vma) can be expanded beyond the
current stack vma. This expaneded stack can be used to copy the
original instruction and single step out-of-line.

Even if the vma cannot be extended then the instruction much be
executed inline, by replacing the breakpoint instruction with original
instruction.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/i386/kernel/Makefile  |    2 
 arch/i386/kernel/kprobes.c |    4 
 arch/i386/kernel/uprobes.c |  537 +++++++++++++++++++++++++++++++++++++++++++++
 arch/i386/mm/fault.c       |    3 
 include/asm-i386/kprobes.h |   20 +
 include/linux/kprobes.h    |    8 
 6 files changed, 569 insertions(+), 5 deletions(-)

diff -puN include/asm-i386/kprobes.h~kprobes_userspace_probes-ss-out-of-line include/asm-i386/kprobes.h
--- linux-2.6.16-rc6-mm2/include/asm-i386/kprobes.h~kprobes_userspace_probes-ss-out-of-line	2006-03-20 10:49:29.000000000 +0530
+++ linux-2.6.16-rc6-mm2-prasanna/include/asm-i386/kprobes.h	2006-03-20 10:49:29.000000000 +0530
@@ -26,6 +26,7 @@
  */
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <asm/cacheflush.h>
 
 #define  __ARCH_WANT_KPROBES_INSN_SLOT
 
@@ -77,6 +78,19 @@ struct kprobe_ctlblk {
 	struct prev_kprobe prev_kprobe;
 };
 
+/* per user probe control block */
+struct uprobe_ctlblk {
+	unsigned long uprobe_status;
+	unsigned long uprobe_saved_eflags;
+	unsigned long uprobe_old_eflags;
+	unsigned long singlestep_addr;
+	unsigned long flags;
+	struct kprobe *curr_p;
+	pte_t *upte;
+	struct page *upage;
+	struct task_struct *tsk;
+};
+
 /* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
  * if necessary, before executing the original int3/1 (trap) handler.
  */
@@ -88,4 +102,10 @@ static inline void restore_interrupts(st
 
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
+extern int uprobe_exceptions_notify(struct notifier_block *self,
+						unsigned long val, void *data);
+extern unsigned long get_segment_eip(struct pt_regs *regs,
+						unsigned long *eip_limit);
+extern int is_IF_modifier(kprobe_opcode_t opcode);
+
 #endif				/* _ASM_KPROBES_H */
diff -puN arch/i386/kernel/uprobes.c~kprobes_userspace_probes-ss-out-of-line arch/i386/kernel/uprobes.c
--- linux-2.6.16-rc6-mm2/arch/i386/kernel/uprobes.c~kprobes_userspace_probes-ss-out-of-line	2006-03-20 10:49:29.000000000 +0530
+++ linux-2.6.16-rc6-mm2-prasanna/arch/i386/kernel/uprobes.c	2006-03-20 10:56:23.000000000 +0530
@@ -30,6 +30,10 @@
 #include <asm/cacheflush.h>
 #include <asm/kdebug.h>
 #include <asm/desc.h>
+#include <asm/uaccess.h>
+
+static struct uprobe_ctlblk uprobe_ctlblk;
+struct uprobe *current_uprobe;
 
 int __kprobes arch_alloc_insn(struct kprobe *p)
 {
@@ -69,3 +73,536 @@ int __kprobes arch_copy_uprobe(struct kp
 
 	return ret;
 }
+
+/**
+ * This routines get the pte of the page containing the specified address.
+ */
+static pte_t  __kprobes *get_uprobe_pte(unsigned long address)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte = NULL;
+
+	pgd = pgd_offset(current->mm, address);
+	if (!pgd)
+		goto out;
+
+	pud = pud_offset(pgd, address);
+	if (!pud)
+		goto out;
+
+	pmd = pmd_offset(pud, address);
+	if (!pmd)
+		goto out;
+
+	pte = pte_alloc_map(current->mm, pmd, address);
+
+out:
+	return pte;
+}
+
+/**
+ *  This routine check for space in the current process's stack
+ *  address space. If enough address space is found, copy the original
+ *  instruction on that page for single stepping out-of-line.
+ */
+static int __kprobes copy_insn_on_new_page(struct uprobe *uprobe ,
+			struct pt_regs *regs, struct vm_area_struct *vma)
+{
+	unsigned long addr, stack_addr = regs->esp;
+	int size = MAX_INSN_SIZE * sizeof(kprobe_opcode_t);
+
+	if (vma->vm_flags & VM_GROWSDOWN) {
+		if (((stack_addr - sizeof(long long))) <
+						(vma->vm_start + size))
+			return -ENOMEM;
+		addr = vma->vm_start;
+	} else if (vma->vm_flags & VM_GROWSUP) {
+		if ((vma->vm_end - size) < (stack_addr + sizeof(long long)))
+			return -ENOMEM;
+		addr = vma->vm_end - size;
+	} else
+		return -EFAULT;
+
+	vma->vm_flags |= VM_LOCKED;
+
+	if (__copy_to_user_inatomic((unsigned long *)addr,
+				(unsigned long *)uprobe->kp.ainsn.insn, size))
+		return -EFAULT;
+
+	regs->eip = addr;
+
+	return 0;
+}
+
+/**
+ * This routine expands the stack beyond the present process address
+ * space and copies the instruction to that location, so that
+ * processor can single step out-of-line.
+ */
+static int __kprobes copy_insn_onexpstack(struct uprobe *uprobe,
+			struct pt_regs *regs, struct vm_area_struct *vma)
+{
+	unsigned long addr, vm_addr;
+	int size = MAX_INSN_SIZE * sizeof(kprobe_opcode_t);
+	struct vm_area_struct *new_vma;
+	struct mm_struct *mm = current->mm;
+
+
+	 if (!down_read_trylock(&current->mm->mmap_sem))
+		 return -ENOMEM;
+
+	if (vma->vm_flags & VM_GROWSDOWN)
+		vm_addr = vma->vm_start - size;
+	else if (vma->vm_flags & VM_GROWSUP)
+		vm_addr = vma->vm_end + size;
+	else {
+		up_read(&current->mm->mmap_sem);
+		return -EFAULT;
+	}
+
+	new_vma = find_extend_vma(mm, vm_addr);
+	if (!new_vma) {
+		up_read(&current->mm->mmap_sem);
+		return -ENOMEM;
+	}
+
+	if (new_vma->vm_flags & VM_GROWSDOWN)
+		addr = new_vma->vm_start;
+	else
+		addr = new_vma->vm_end - size;
+
+	new_vma->vm_flags |= VM_LOCKED;
+	up_read(&current->mm->mmap_sem);
+
+	if (__copy_to_user_inatomic((unsigned long *)addr,
+				(unsigned long *)uprobe->kp.ainsn.insn, size))
+		return -EFAULT;
+
+	regs->eip = addr;
+
+	return  0;
+}
+
+/**
+ * This routine checks for stack free space below the stack pointer
+ * and then copies the instructions at that location so that the
+ * processor can single step out-of-line. If there is not enough stack
+ * space or if copy_to_user fails or if the vma is invalid, it returns
+ * error.
+ */
+static int __kprobes copy_insn_onstack(struct uprobe *uprobe,
+			struct pt_regs *regs, unsigned long flags)
+{
+	unsigned long page_addr, stack_addr = regs->esp;
+	int  size = MAX_INSN_SIZE * sizeof(kprobe_opcode_t);
+	unsigned long *source = (unsigned long *)uprobe->kp.ainsn.insn;
+
+	if (flags & VM_GROWSDOWN) {
+		page_addr = stack_addr & PAGE_MASK;
+
+		if (((stack_addr - sizeof(long long))) < (page_addr + size))
+			return -ENOMEM;
+
+		if (__copy_to_user_inatomic((unsigned long *)page_addr,
+								source, size))
+			return -EFAULT;
+
+		regs->eip = page_addr;
+	} else if (flags & VM_GROWSUP) {
+		page_addr = stack_addr & PAGE_MASK;
+
+		if (page_addr == stack_addr)
+			return -ENOMEM;
+		else
+			page_addr += PAGE_SIZE;
+
+		if ((page_addr - size) < (stack_addr + sizeof(long long)))
+			return -ENOMEM;
+
+		if (__copy_to_user_inatomic(
+			(unsigned long *)(page_addr - size), source, size))
+			return -EFAULT;
+
+		regs->eip = page_addr - size;
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * This routines get the page containing the probe, maps it and
+ * replaced the instruction at the probed address with specified
+ * opcode.
+ */
+void __kprobes replace_original_insn(struct uprobe *uprobe,
+				struct pt_regs *regs, kprobe_opcode_t opcode)
+{
+	kprobe_opcode_t *addr;
+	struct page *page;
+
+	page = find_get_page(uprobe->inode->i_mapping,
+					uprobe->offset >> PAGE_CACHE_SHIFT);
+	BUG_ON(!page);
+
+	__lock_page(page);
+
+	addr = (kprobe_opcode_t *)kmap_atomic(page, KM_USER1);
+	addr = (kprobe_opcode_t *)((unsigned long)addr +
+				 (unsigned long)(uprobe->offset & ~PAGE_MASK));
+	*addr = opcode;
+	/*TODO: flush vma ? */
+	kunmap_atomic(addr, KM_USER1);
+
+	unlock_page(page);
+
+	if (page)
+		page_cache_release(page);
+	regs->eip = (unsigned long)uprobe->kp.addr;
+}
+
+/**
+ * This routine provides the functionality of single stepping
+ * out-of-line. If single stepping out-of-line cannot be achieved,
+ * it replaces with the original instruction allowing it to single
+ * step inline.
+ */
+static inline int prepare_singlestep_uprobe(struct uprobe *uprobe,
+				struct uprobe_ctlblk *ucb, struct pt_regs *regs)
+{
+	unsigned long stack_addr = regs->esp, flags;
+	struct vm_area_struct *vma = NULL;
+	int err = 0;
+
+	vma = find_vma(current->mm, (stack_addr & PAGE_MASK));
+	if (!vma) {
+		/* TODO: Need better error reporting? */
+		goto no_vma;
+	}
+	flags = vma->vm_flags;
+
+	regs->eflags |= TF_MASK;
+	regs->eflags &= ~IF_MASK;
+
+	/*
+	 * Copy_insn_on_stack tries to find some room for the instruction slot
+	 * in the same page as the current esp.
+	 */
+	err = copy_insn_onstack(uprobe, regs, flags);
+
+	/*
+	 * If copy_insn_on_stack() fails, copy_insn_on_new_page() is called to
+	 * try to find some room in the next pages below the current esp;
+	 */
+	if (err)
+		err = copy_insn_on_new_page(uprobe, regs, vma);
+	/*
+	 * If copy_insn_on_new_pagek() fails, copy_insn_on_expstack() is called to
+	 * try to grow the stack's VM area by one page.
+	 */
+	if (err)
+		err = copy_insn_onexpstack(uprobe, regs, vma);
+
+	ucb->uprobe_status = UPROBE_HIT_SS;
+
+	if (!err) {
+		ucb->upte = get_uprobe_pte(regs->eip);
+		if (!ucb->upte)
+			goto no_vma;
+		ucb->upage = pte_page(*ucb->upte);
+		__lock_page(ucb->upage);
+	}
+no_vma:
+	if (err) {
+		replace_original_insn(uprobe, regs, uprobe->kp.opcode);
+		ucb->uprobe_status = UPROBE_SS_INLINE;
+	}
+
+	ucb->singlestep_addr = regs->eip;
+
+	return 0;
+}
+
+/*
+ * uprobe_handler() executes the user specified handler and setup for
+ * single stepping the original instruction either out-of-line or inline.
+ */
+static int __kprobes uprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *p;
+	int ret = 0;
+	kprobe_opcode_t *addr = NULL;
+	struct uprobe_ctlblk *ucb = &uprobe_ctlblk;
+	unsigned long limit;
+
+	spin_lock_irqsave(&uprobe_lock, ucb->flags);
+	/* preemption is disabled, remains disabled
+	 * until we single step on original instruction.
+	 */
+	preempt_disable();
+
+	addr = (kprobe_opcode_t *)(get_segment_eip(regs, &limit) - 1);
+
+	p = get_uprobe(addr);
+	if (!p) {
+
+		if (*addr != BREAKPOINT_INSTRUCTION) {
+			/*
+			 * The breakpoint instruction was removed right
+			 * after we hit it.  Another cpu has removed
+			 * either a probepoint or a debugger breakpoint
+			 * at this address.  In either case, no further
+			 * handling of this interrupt is appropriate.
+			 * Back up over the (now missing) int3 and run
+			 * the original instruction.
+			 */
+			regs->eip -= sizeof(kprobe_opcode_t);
+			ret = 1;
+		}
+		/* Not one of ours: let kernel handle it */
+		goto no_uprobe;
+	}
+
+	if (p->opcode == BREAKPOINT_INSTRUCTION) {
+		/*
+		 * Breakpoint was already present even before the probe
+		 * was inserted, this might break some compatability with
+		 * other debuggers like gdb etc. We dont handle such probes.
+		 */
+		current_uprobe = NULL;
+		goto no_uprobe;
+	}
+
+	ucb->curr_p = p;
+	ucb->tsk = current;
+	ucb->uprobe_status = UPROBE_HIT_ACTIVE;
+	ucb->uprobe_saved_eflags = (regs->eflags & (TF_MASK | IF_MASK));
+	ucb->uprobe_old_eflags = (regs->eflags & (TF_MASK | IF_MASK));
+
+	if (p->pre_handler && p->pre_handler(p, regs))
+		/* handler has already set things up, so skip ss setup */
+		return 1;
+
+	prepare_singlestep_uprobe(current_uprobe, ucb, regs);
+	/*
+	 * Avoid scheduling the current while returning from
+	 * kernel to user mode.
+	 */
+	clear_need_resched();
+	return 1;
+
+no_uprobe:
+	spin_unlock_irqrestore(&uprobe_lock, ucb->flags);
+	preempt_enable_no_resched();
+
+	return ret;
+}
+
+/*
+ * Called after single-stepping.  p->addr is the address of the
+ * instruction whose first byte has been replaced by the "int 3"
+ * instruction.  To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.  The address of this
+ * copy is p->ainsn.insn.
+ *
+ * This function prepares to return from the post-single-step
+ * interrupt.  We have to fix up the stack as follows:
+ *
+ * 0) Typically, the new eip is relative to the copied instruction.  We
+ * need to make it relative to the original instruction.  Exceptions are
+ * return instructions and absolute or indirect jump or call instructions.
+ *
+ * 1) If the single-stepped instruction was pushfl, then the TF and IF
+ * flags are set in the just-pushed eflags, and may need to be cleared.
+ *
+ * 2) If the single-stepped instruction was a call, the return address
+ * that is atop the stack is the address following the copied instruction.
+ * We need to make it the address following the original instruction.
+ */
+static void __kprobes resume_execution_user(struct kprobe *p,
+		struct pt_regs *regs, struct uprobe_ctlblk *ucb)
+{
+	unsigned long *tos = (unsigned long *)regs->esp;
+	unsigned long next_eip = 0;
+	unsigned long copy_eip = ucb->singlestep_addr;
+	unsigned long orig_eip = (unsigned long)p->addr;
+
+	switch (p->ainsn.insn[0]) {
+	case 0x9c:		/* pushfl */
+		*tos &= ~(TF_MASK | IF_MASK);
+		*tos |= ucb->uprobe_old_eflags;
+		break;
+	case 0xc3:		/* ret/lret */
+	case 0xcb:
+	case 0xc2:
+	case 0xca:
+		next_eip = regs->eip;
+		/* eip is already adjusted, no more changes required*/
+		return;
+		break;
+	case 0xe8:		/* call relative - Fix return addr */
+		*tos = orig_eip + (*tos - copy_eip);
+		break;
+	case 0xff:
+		if ((p->ainsn.insn[1] & 0x30) == 0x10) {
+			/* call absolute, indirect */
+			/* Fix return addr; eip is correct. */
+			next_eip = regs->eip;
+			*tos = orig_eip + (*tos - copy_eip);
+		} else if (((p->ainsn.insn[1] & 0x31) == 0x20) ||
+			   ((p->ainsn.insn[1] & 0x31) == 0x21)) {
+			/* jmp near or jmp far  absolute indirect */
+			/* eip is correct. */
+			next_eip = regs->eip;
+		}
+		break;
+	case 0xea:		/* jmp absolute -- eip is correct */
+		next_eip = regs->eip;
+		break;
+	default:
+		break;
+	}
+
+	regs->eflags &= ~TF_MASK;
+	if (next_eip)
+		regs->eip = next_eip;
+	else
+		regs->eip = orig_eip + (regs->eip - copy_eip);
+}
+
+/*
+ * post_uprobe_handler(), executes the user specified handlers and
+ * resumes with the normal execution.
+ */
+static inline int post_uprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *cur;
+	struct uprobe_ctlblk *ucb;
+
+	if (!current_uprobe)
+		return 0;
+
+	ucb = &uprobe_ctlblk;
+	cur = ucb->curr_p;
+
+	if (!cur || ucb->tsk != current)
+		return 0;
+
+	if (cur->post_handler) {
+		if (ucb->uprobe_status == UPROBE_SS_INLINE)
+			ucb->uprobe_status = UPROBE_SSDONE_INLINE;
+		else
+			ucb->uprobe_status = UPROBE_HIT_SSDONE;
+		cur->post_handler(cur, regs, 0);
+	}
+
+	resume_execution_user(cur, regs, ucb);
+	regs->eflags |= ucb->uprobe_saved_eflags;
+
+	if (ucb->uprobe_status == UPROBE_SSDONE_INLINE)
+		replace_original_insn(current_uprobe, regs,
+						BREAKPOINT_INSTRUCTION);
+	else {
+		unlock_page(ucb->upage);
+		pte_unmap(ucb->upte);
+	}
+	current_uprobe = NULL;
+	spin_unlock_irqrestore(&uprobe_lock, ucb->flags);
+	preempt_enable_no_resched();
+	/*
+	 * if somebody else is singlestepping across a probe point, eflags
+	 * will have TF set, in which case, continue the remaining processing
+	 * of do_debug, as if this is not a probe hit.
+	 */
+	if (regs->eflags & TF_MASK)
+		return 0;
+
+	return 1;
+}
+
+static inline int uprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	struct kprobe *cur;
+	struct uprobe_ctlblk *ucb;
+	int ret = 0;
+
+	ucb = &uprobe_ctlblk;
+	cur = ucb->curr_p;
+
+	if (ucb->tsk != current || !cur)
+		return 0;
+
+	switch(ucb->uprobe_status) {
+	case UPROBE_HIT_SS:
+		unlock_page(ucb->upage);
+		pte_unmap(ucb->upte);
+		/* TODO: All acceptable number of faults before disabling */
+		replace_original_insn(current_uprobe, regs, cur->opcode);
+		/* Fall through and reset the current probe */
+	case UPROBE_SS_INLINE:
+		regs->eip = (unsigned long)cur->addr;
+		regs->eflags |= ucb->uprobe_old_eflags;
+		regs->eflags &= ~TF_MASK;
+		current_uprobe = NULL;
+		ret = 1;
+		spin_unlock_irqrestore(&uprobe_lock, ucb->flags);
+		preempt_enable_no_resched();
+		break;
+	case UPROBE_HIT_ACTIVE:
+	case UPROBE_SSDONE_INLINE:
+	case UPROBE_HIT_SSDONE:
+		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
+			return 1;
+
+		if (fixup_exception(regs))
+			return 1;
+		/*
+		 * We must not allow the system page handler to continue while
+		 * holding a lock, since page fault handler can sleep and
+		 * reschedule it on different cpu. Hence return 1.
+		 */
+		return 1;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+/*
+ * Wrapper routine to for handling exceptions.
+ */
+int __kprobes uprobe_exceptions_notify(struct notifier_block *self,
+				       unsigned long val, void *data)
+{
+	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+
+	if (args->regs->eflags & VM_MASK) {
+		/* We are in virtual-8086 mode. Return NOTIFY_DONE */
+		return ret;
+	}
+
+	switch (val) {
+	case DIE_INT3:
+		if (uprobe_handler(args->regs))
+			ret = NOTIFY_STOP;
+		break;
+	case DIE_DEBUG:
+		if (post_uprobe_handler(args->regs))
+			ret = NOTIFY_STOP;
+		break;
+	case DIE_GPF:
+	case DIE_PAGE_FAULT:
+		if (current_uprobe &&
+		    uprobe_fault_handler(args->regs, args->trapnr))
+			ret = NOTIFY_STOP;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
diff -puN include/linux/kprobes.h~kprobes_userspace_probes-ss-out-of-line include/linux/kprobes.h
--- linux-2.6.16-rc6-mm2/include/linux/kprobes.h~kprobes_userspace_probes-ss-out-of-line	2006-03-20 10:49:29.000000000 +0530
+++ linux-2.6.16-rc6-mm2-prasanna/include/linux/kprobes.h	2006-03-20 10:49:29.000000000 +0530
@@ -51,6 +51,13 @@
 #define KPROBE_REENTER		0x00000004
 #define KPROBE_HIT_SSDONE	0x00000008
 
+/* uprobe_status settings */
+#define UPROBE_HIT_ACTIVE	0x00000001
+#define UPROBE_HIT_SS		0x00000002
+#define UPROBE_HIT_SSDONE	0x00000004
+#define UPROBE_SS_INLINE	0x00000008
+#define UPROBE_SSDONE_INLINE	0x00000010
+
 /* Attach to insert probes on any functions which should be ignored*/
 #define __kprobes	__attribute__((__section__(".kprobes.text")))
 
@@ -183,6 +190,7 @@ struct kretprobe_instance {
 	struct task_struct *task;
 };
 
+extern spinlock_t uprobe_lock;
 extern spinlock_t kretprobe_lock;
 extern struct mutex kprobe_mutex;
 extern int arch_prepare_kprobe(struct kprobe *p);
diff -puN arch/i386/kernel/kprobes.c~kprobes_userspace_probes-ss-out-of-line arch/i386/kernel/kprobes.c
--- linux-2.6.16-rc6-mm2/arch/i386/kernel/kprobes.c~kprobes_userspace_probes-ss-out-of-line	2006-03-20 10:49:29.000000000 +0530
+++ linux-2.6.16-rc6-mm2-prasanna/arch/i386/kernel/kprobes.c	2006-03-20 10:49:29.000000000 +0530
@@ -88,7 +88,7 @@ static inline int can_boost(kprobe_opcod
 /*
  * returns non-zero if opcode modifies the interrupt flag.
  */
-static inline int is_IF_modifier(kprobe_opcode_t opcode)
+int is_IF_modifier(kprobe_opcode_t opcode)
 {
 	switch (opcode) {
 	case 0xfa:		/* cli */
@@ -610,7 +610,7 @@ int __kprobes kprobe_exceptions_notify(s
 	int ret = NOTIFY_DONE;
 
 	if (args->regs && user_mode(args->regs))
-		return ret;
+		return uprobe_exceptions_notify(self, val, data);
 
 	switch (val) {
 	case DIE_INT3:
diff -puN arch/i386/mm/fault.c~kprobes_userspace_probes-ss-out-of-line arch/i386/mm/fault.c
--- linux-2.6.16-rc6-mm2/arch/i386/mm/fault.c~kprobes_userspace_probes-ss-out-of-line	2006-03-20 10:49:29.000000000 +0530
+++ linux-2.6.16-rc6-mm2-prasanna/arch/i386/mm/fault.c	2006-03-20 10:49:29.000000000 +0530
@@ -71,8 +71,7 @@ void bust_spinlocks(int yes)
  * 
  * This is slow, but is very rarely executed.
  */
-static inline unsigned long get_segment_eip(struct pt_regs *regs,
-					    unsigned long *eip_limit)
+unsigned long get_segment_eip(struct pt_regs *regs, unsigned long *eip_limit)
 {
 	unsigned long eip = regs->eip;
 	unsigned seg = regs->xcs & 0xffff;
diff -puN arch/i386/kernel/Makefile~kprobes_userspace_probes-ss-out-of-line arch/i386/kernel/Makefile
--- linux-2.6.16-rc6-mm2/arch/i386/kernel/Makefile~kprobes_userspace_probes-ss-out-of-line	2006-03-20 10:49:29.000000000 +0530
+++ linux-2.6.16-rc6-mm2-prasanna/arch/i386/kernel/Makefile	2006-03-20 10:49:29.000000000 +0530
@@ -29,7 +29,7 @@ obj-$(CONFIG_KEXEC)		+= machine_kexec.o 
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
-obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o uprobes.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
