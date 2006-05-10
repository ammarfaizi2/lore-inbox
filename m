Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWEJOTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWEJOTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWEJOTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:19:49 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:34276 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751443AbWEJOTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:19:48 -0400
In-Reply-To: <44613812.1070100@linux.intel.com>
Subject: Re: [RFC] [PATCH 5/6] Kprobes: Single step the original instruction
 out-of-line
Sensitivity: 
To: "bibo,mao" <bibo_mao@linux.intel.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, prasanna@in.ibm.com, suparna@in.ibm.com,
       systemtap@sources.redhat.com
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OFCEFC2CFF.D08F6752-ON4125716A.004E480A-4125716A.004EAD86@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Wed, 10 May 2006 15:19:22 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 10/05/2006 15:20:38
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






"bibo,mao" <bibo_mao@linux.intel.com> wrote on 10/05/2006 01:47:14:

> Previously when I tested uprobe patch in some specific IA32 machine with
> CONFIG_X86_PAE option on, uprobe can not be activated unless kernel
> option "noexec=off" is added before booting kernel.
> Because without this option user stack is non-executable, copied trap
> instruction is placed in process's stack space. Executing trap
> instrunction in stack will cause page fault of non-execution priviledge.

You won't cause a pagefault. There only privilege checks from page tables
are read-only/read/write and user/system.

The executable attribute is, or was when I last read the processor
reference manual, only present in the descriptor table entry. Violation of
that would cause a general protection fault.

That being said, if we are going to execute code on a stack, we should set
up an alias descriptor for it. We might as well set up a global descriptor
that maps all of user space as executable.

Richard



>
> Thanks
> bibo,mao
>
> Prasanna S Panchamukhi ??:
> > This patch provides a mechanism for probe handling and
> > executing the user-specified handlers.
> >
> > Each userspace probe is uniquely identified by the combination of
> > inode and offset, hence during registration the inode and offset
> > combination is added to uprobes hash table. Initially when
> > breakpoint instruction is hit, the uprobes hash table is looked up
> > for matching inode and offset. The pre_handlers are called in
> > sequence if multiple probes are registered. Similar to kprobes,
> > uprobes also adopts to single step out-of-line, so that probe miss in
> > SMP environment can be avoided. But for userspace probes, instruction
> > copied into kernel address space cannot be single stepped, hence the
> > instruction must be copied to user address space. The solution is to
> > find free space in the current process address space and then copy the
> > original instruction and single step that instruction.
> >
> > User processes use stack space to store local variables, arguments and
> > return values. Normally the stack space either below or above the
> > stack pointer indicates the free stack space.
> >
> > The instruction to be single stepped can modify the stack space,
> > hence before using the free stack space, sufficient stack space must
> > be left. The instruction is copied to the bottom of the page and check
> > is made such that the copied instruction does not cross the page
> > boundary. The copied instruction is then single stepped. Several
> > architectures does not allow the instruction to be executed from the
> > stack location, since no-exec bit is set for the stack pages. In those
> > architectures, the page table entry corresponding to the stack page is
> > identified and the no-exec bit is unset making the instruction on that
> > stack page to be executed.
> >
> > There are situations where even the free stack space is not enough for
> > the user instruction to be copied and single stepped. In such
> > situations, the virtual memory area(vma) can be expanded beyond the
> > current stack vma. This expanded stack can be used to copy the
> > original instruction and single step out-of-line.
> >
> > Even if the vma cannot be extended, then the instruction much be
> > executed inline, by replacing the breakpoint instruction with the
> > original instruction.
> >
> > Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
> >
> >
> >  arch/i386/kernel/Makefile  |    2
> >  arch/i386/kernel/kprobes.c |    4
> >  arch/i386/kernel/uprobes.c |  472
> +++++++++++++++++++++++++++++++++++++++++++++
> >  arch/i386/mm/fault.c       |    3
> >  include/asm-i386/kprobes.h |   21 ++
> >  5 files changed, 497 insertions(+), 5 deletions(-)
> >
> > diff -puN include/asm-i386/kprobes.h~kprobes_userspace_probes-ss-
> out-of-line include/asm-i386/kprobes.h
> > --- linux-2.6.17-rc3-mm1/include/asm-i386/kprobes.
> h~kprobes_userspace_probes-ss-out-of-line   2006-05-09 12:40:48.
> 000000000 +0530
> > +++ linux-2.6.17-rc3-mm1-prasanna/include/asm-i386/kprobes.h
> 2006-05-09 12:40:48.000000000 +0530
> > @@ -26,6 +26,7 @@
> >   */
> >  #include <linux/types.h>
> >  #include <linux/ptrace.h>
> > +#include <asm/cacheflush.h>
> >
> >  #define  __ARCH_WANT_KPROBES_INSN_SLOT
> >
> > @@ -78,6 +79,19 @@ struct kprobe_ctlblk {
> >     struct prev_kprobe prev_kprobe;
> >  };
> >
> > +/* per user probe control block */
> > +struct uprobe_ctlblk {
> > +   unsigned long uprobe_status;
> > +   unsigned long uprobe_saved_eflags;
> > +   unsigned long uprobe_old_eflags;
> > +   unsigned long singlestep_addr;
> > +   unsigned long flags;
> > +   struct kprobe *curr_p;
> > +   pte_t *upte;
> > +   struct page *upage;
> > +   struct task_struct *tsk;
> > +};
> > +
> >  /* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
> >   * if necessary, before executing the original int3/1 (trap) handler.
> >   */
> > @@ -89,4 +103,11 @@ static inline void restore_interrupts(st
> >
> >  extern int kprobe_exceptions_notify(struct notifier_block *self,
> >                  unsigned long val, void *data);
> > +extern int uprobe_exceptions_notify(struct notifier_block *self,
> > +                  unsigned long val, void *data);
> > +extern unsigned long get_segment_eip(struct pt_regs *regs,
> > +                  unsigned long *eip_limit);
> > +extern int is_IF_modifier(kprobe_opcode_t opcode);
> > +
> > +extern pte_t *get_one_pte(unsigned long address);
> >  #endif            /* _ASM_KPROBES_H */
> > diff -puN arch/i386/kernel/uprobes.c~kprobes_userspace_probes-ss-
> out-of-line arch/i386/kernel/uprobes.c
> > --- linux-2.6.17-rc3-mm1/arch/i386/kernel/uprobes.
> c~kprobes_userspace_probes-ss-out-of-line   2006-05-09 12:40:48.
> 000000000 +0530
> > +++ linux-2.6.17-rc3-mm1-prasanna/arch/i386/kernel/uprobes.c
> 2006-05-09 12:40:48.000000000 +0530
> > @@ -30,6 +30,10 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/kdebug.h>
> >  #include <asm/desc.h>
> > +#include <asm/uaccess.h>
> > +
> > +static struct uprobe_ctlblk uprobe_ctlblk;
> > +struct uprobe *current_uprobe;
> >
> >  int __kprobes arch_alloc_insn(struct kprobe *p)
> >  {
> > @@ -69,3 +73,471 @@ int __kprobes arch_copy_uprobe(struct kp
> >
> >     return ret;
> >  }
> > +
> > +/*
> > + *  This routine check for space in the process's stack address space.
> > + *  If enough address space is found, returns the address of free
stack
> > + *  space.
> > + */
> > +unsigned long __kprobes *find_stack_space_on_next_page(unsigned
> long stack_addr,
> > +         int size, struct vm_area_struct *vma)
> > +{
> > +   unsigned long addr;
> > +   struct page *pg;
> > +   int retval = 0;
> > +
> > +   if (((stack_addr - sizeof(long long))) < (vma->vm_start + size))
> > +      return NULL;
> > +   addr = (stack_addr & PAGE_MASK) + PAGE_SIZE;
> > +
> > +   retval = get_user_pages(current, current->mm,
> > +            (unsigned long )addr, 1, 1, 0, &pg, NULL);
> > +   if (retval)
> > +      return NULL;
> > +
> > +   return (unsigned long *) addr;
> > +}
> > +
> > +/*
> > + * This routine expands the stack beyond the present process address
> > + * space and returns the address of free stack space. This routine
> > + * must be called with mmap_sem held.
> > + */
> > +unsigned long __kprobes *find_stack_space_in_expanded_vma(int size,
> > +                  struct vm_area_struct *vma)
> > +{
> > +   unsigned long addr, vm_addr;
> > +   int retval = 0;
> > +   struct vm_area_struct *new_vma;
> > +   struct mm_struct *mm = current->mm;
> > +   struct page *pg;
> > +
> > +   vm_addr = vma->vm_start - size;
> > +   new_vma = find_extend_vma(mm, vm_addr);
> > +   if (!new_vma)
> > +      return NULL;
> > +
> > +   addr = new_vma->vm_start;
> > +   retval = get_user_pages(current, current->mm,
> > +            (unsigned long )addr, 1, 1, 0, &pg, NULL);
> > +   if (retval)
> > +      return NULL;
> > +
> > +   return (unsigned long *) addr;
> > +}
> > +
> > +/*
> > + * This routine checks for stack free space below the stack pointer in
the
> > + * current stack page. If there is not enough stack space, it returns
NULL.
> > + */
> > +unsigned long __kprobes *find_stack_space_on_curr_page(unsigned
> long stack_addr,
> > +                        int size)
> > +{
> > +   unsigned long page_addr;
> > +
> > +   page_addr = stack_addr & PAGE_MASK;
> > +
> > +   if (((stack_addr - sizeof(long long))) < (page_addr + size))
> > +      return NULL;
> > +
> > +   return (unsigned long *) page_addr;
> > +}
> > +
> > +/*
> > + * This routines finds free stack space for a given size either on the
> > + * current stack page, or on next stack page. If there is no free
stack
> > + * space is availible, then expands the stack and returns the address
of
> > + * free stack space.
> > + */
> > +unsigned long __kprobes *find_stack_space(unsigned long
> stack_addr, int size)
> > +{
> > +   unsigned long *addr;
> > +   struct vm_area_struct *vma = NULL;
> > +
> > +   addr = find_stack_space_on_curr_page(stack_addr, size);
> > +   if (addr)
> > +      return addr;
> > +
> > +   if (!down_read_trylock(&current->mm->mmap_sem))
> > +      down_read(&current->mm->mmap_sem);
> > +
> > +   vma = find_vma(current->mm, (stack_addr & PAGE_MASK));
> > +   if (!vma) {
> > +      up_read(&current->mm->mmap_sem);
> > +      return NULL;
> > +   }
> > +
> > +   addr = find_stack_space_on_next_page(stack_addr, size, vma);
> > +   if (addr) {
> > +      up_read(&current->mm->mmap_sem);
> > +      return addr;
> > +   }
> > +
> > +   addr = find_stack_space_in_expanded_vma(size, vma);
> > +   up_read(&current->mm->mmap_sem);
> > +
> > +   if (!addr)
> > +      return NULL;
> > +
> > +   return addr;
> > +}
> > +
> > +/*
> > + * This routines get the page containing the probe, maps it and
> > + * replaced the instruction at the probed address with specified
> > + * opcode.
> > + */
> > +void __kprobes replace_original_insn(struct uprobe *uprobe,
> > +            struct pt_regs *regs, kprobe_opcode_t opcode)
> > +{
> > +   kprobe_opcode_t *addr;
> > +   struct page *page;
> > +
> > +   page = find_get_page(uprobe->inode->i_mapping,
> > +               uprobe->offset >> PAGE_CACHE_SHIFT);
> > +   BUG_ON(!page);
> > +
> > +   addr = (kprobe_opcode_t *)kmap_atomic(page, KM_USER1);
> > +   addr = (kprobe_opcode_t *)((unsigned long)addr +
> > +             (unsigned long)(uprobe->offset & ~PAGE_MASK));
> > +   *addr = opcode;
> > +   /*TODO: flush vma ? */
> > +   kunmap_atomic(addr, KM_USER1);
> > +
> > +   flush_dcache_page(page);
> > +
> > +   if (page)
> > +      page_cache_release(page);
> > +   regs->eip = (unsigned long)uprobe->kp.addr;
> > +}
> > +
> > +/*
> > + * This routine provides the functionality of single stepping
> > + * out-of-line. If single stepping out-of-line cannot be achieved,
> > + * it replaces with the original instruction allowing it to single
> > + * step inline.
> > + */
> > +static int __kprobes prepare_singlestep_uprobe(struct uprobe *uprobe,
> > +            struct uprobe_ctlblk *ucb, struct pt_regs *regs)
> > +{
> > +   unsigned long *addr = NULL, stack_addr = regs->esp;
> > +   int size = sizeof(kprobe_opcode_t) * MAX_INSN_SIZE;
> > +   unsigned long *source = (unsigned long *)uprobe->kp.ainsn.insn;
> > +
> > +   /*
> > +    * Get free stack space to copy original instruction, so as to
> > +    * single step out-of-line.
> > +    */
> > +   addr = find_stack_space(stack_addr, size);
> > +   if (!addr)
> > +      goto no_stack_space;
> > +
> > +   /*
> > +    * We are in_atomic and preemption is disabled at this point of
> > +    * time. Copy original instruction on this per process stack
> > +    * page so as to single step out-of-line.
> > +    */
> > +   if (__copy_to_user_inatomic((unsigned long *)addr, source, size))
> > +      goto no_stack_space;
> > +
> > +   regs->eip = (unsigned long)addr;
> > +
> > +   regs->eflags |= TF_MASK;
> > +   regs->eflags &= ~IF_MASK;
> > +   ucb->uprobe_status = UPROBE_HIT_SS;
> > +
> > +   ucb->upte = get_one_pte(regs->eip);
> > +   if (!ucb->upte)
> > +      goto no_stack_space;
> > +   ucb->upage = pte_page(*ucb->upte);
> > +   set_pte(ucb->upte, pte_mkdirty(*ucb->upte));
> > +   ucb->singlestep_addr = regs->eip;
> > +
> > +   return 0;
> > +
> > +no_stack_space:
> > +   replace_original_insn(uprobe, regs, uprobe->kp.opcode);
> > +   ucb->uprobe_status = UPROBE_SS_INLINE;
> > +   ucb->singlestep_addr = regs->eip;
> > +
> > +   return 0;
> > +}
> > +
> > +/*
> > + * uprobe_handler() executes the user specified handler and setup for
> > + * single stepping the original instruction either out-of-line or
inline.
> > + */
> > +static int __kprobes uprobe_handler(struct pt_regs *regs)
> > +{
> > +   struct kprobe *p;
> > +   int ret = 0;
> > +   kprobe_opcode_t *addr = NULL;
> > +   struct uprobe_ctlblk *ucb = &uprobe_ctlblk;
> > +   unsigned long limit;
> > +
> > +   spin_lock_irqsave(&uprobe_lock, ucb->flags);
> > +   /* preemption is disabled, remains disabled
> > +    * until we single step on original instruction.
> > +    */
> > +   inc_preempt_count();
> > +
> > +   addr = (kprobe_opcode_t *)(get_segment_eip(regs, &limit) - 1);
> > +
> > +   p = get_uprobe(addr);
> > +   if (!p) {
> > +
> > +      if (*addr != BREAKPOINT_INSTRUCTION) {
> > +         /*
> > +          * The breakpoint instruction was removed right
> > +          * after we hit it.  Another cpu has removed
> > +          * either a probe point or a debugger breakpoint
> > +          * at this address.  In either case, no further
> > +          * handling of this interrupt is appropriate.
> > +          * Back up over the (now missing) int3 and run
> > +          * the original instruction.
> > +          */
> > +         regs->eip -= sizeof(kprobe_opcode_t);
> > +         ret = 1;
> > +      }
> > +      /* Not one of ours: let kernel handle it */
> > +      goto no_uprobe;
> > +   }
> > +
> > +   if (p->opcode == BREAKPOINT_INSTRUCTION) {
> > +      /*
> > +       * Breakpoint was already present even before the probe
> > +       * was inserted, this might break some compatibility with
> > +       * other debuggers like gdb etc. We dont handle such probes.
> > +       */
> > +      current_uprobe = NULL;
> > +      goto no_uprobe;
> > +   }
> > +
> > +   ucb->curr_p = p;
> > +   ucb->tsk = current;
> > +   ucb->uprobe_status = UPROBE_HIT_ACTIVE;
> > +   ucb->uprobe_saved_eflags = (regs->eflags & (TF_MASK | IF_MASK));
> > +   ucb->uprobe_old_eflags = (regs->eflags & (TF_MASK | IF_MASK));
> > +
> > +   if (p->pre_handler && p->pre_handler(p, regs))
> > +      /* handler has already set things up, so skip ss setup */
> > +      return 1;
> > +
> > +   prepare_singlestep_uprobe(current_uprobe, ucb, regs);
> > +   /*
> > +    * Avoid scheduling the current while returning from
> > +    * kernel to user mode.
> > +    */
> > +   clear_need_resched();
> > +   return 1;
> > +
> > +no_uprobe:
> > +   spin_unlock_irqrestore(&uprobe_lock, ucb->flags);
> > +   dec_preempt_count();
> > +
> > +   return ret;
> > +}
> > +
> > +/*
> > + * Called after single-stepping.  p->addr is the address of the
> > + * instruction whose first byte has been replaced by the "int 3"
> > + * instruction.  To avoid the SMP problems that can occur when we
> > + * temporarily put back the original opcode to single-step, we
> > + * single-stepped a copy of the instruction.  The address of this
> > + * copy is p->ainsn.insn.
> > + *
> > + * This function prepares to return from the post-single-step
> > + * interrupt.  We have to fix up the stack as follows:
> > + *
> > + * 0) Typically, the new eip is relative to the copied instruction.
We
> > + * need to make it relative to the original instruction.  Exceptions
are
> > + * return instructions and absolute or indirect jump or call
instructions.
> > + *
> > + * 1) If the single-stepped instruction was pushfl, then the TF and IF
> > + * flags are set in the just-pushed eflags, and may need to be
cleared.
> > + *
> > + * 2) If the single-stepped instruction was a call, the return address
> > + * that is atop the stack is the address following the copied
instruction.
> > + * We need to make it the address following the original instruction.
> > + */
> > +static void __kprobes resume_execution_user(struct kprobe *p,
> > +      struct pt_regs *regs, struct uprobe_ctlblk *ucb)
> > +{
> > +   unsigned long *tos = (unsigned long *)regs->esp;
> > +   unsigned long next_eip = 0;
> > +   unsigned long copy_eip = ucb->singlestep_addr;
> > +   unsigned long orig_eip = (unsigned long)p->addr;
> > +
> > +   switch (p->ainsn.insn[0]) {
> > +   case 0x9c:      /* pushfl */
> > +      *tos &= ~(TF_MASK | IF_MASK);
> > +      *tos |= ucb->uprobe_old_eflags;
> > +      break;
> > +   case 0xc3:      /* ret/lret */
> > +   case 0xcb:
> > +   case 0xc2:
> > +   case 0xca:
> > +      next_eip = regs->eip;
> > +      /* eip is already adjusted, no more changes required*/
> > +      break;
> > +   case 0xe8:      /* call relative - Fix return addr */
> > +      *tos = orig_eip + (*tos - copy_eip);
> > +      break;
> > +   case 0xff:
> > +      if ((p->ainsn.insn[1] & 0x30) == 0x10) {
> > +         /* call absolute, indirect */
> > +         /* Fix return addr; eip is correct. */
> > +         next_eip = regs->eip;
> > +         *tos = orig_eip + (*tos - copy_eip);
> > +      } else if (((p->ainsn.insn[1] & 0x31) == 0x20) ||
> > +            ((p->ainsn.insn[1] & 0x31) == 0x21)) {
> > +         /* jmp near or jmp far  absolute indirect */
> > +         /* eip is correct. */
> > +         next_eip = regs->eip;
> > +      }
> > +      break;
> > +   case 0xea:      /* jmp absolute -- eip is correct */
> > +      next_eip = regs->eip;
> > +      break;
> > +   default:
> > +      break;
> > +   }
> > +
> > +   regs->eflags &= ~TF_MASK;
> > +   if (next_eip)
> > +      regs->eip = next_eip;
> > +   else
> > +      regs->eip = orig_eip + (regs->eip - copy_eip);
> > +}
> > +
> > +/*
> > + * post_uprobe_handler(), executes the user specified handlers and
> > + * resumes with the normal execution.
> > + */
> > +static int __kprobes post_uprobe_handler(struct pt_regs *regs)
> > +{
> > +   struct kprobe *cur;
> > +   struct uprobe_ctlblk *ucb;
> > +
> > +   if (!current_uprobe)
> > +      return 0;
> > +
> > +   ucb = &uprobe_ctlblk;
> > +   cur = ucb->curr_p;
> > +
> > +   if (!cur || ucb->tsk != current)
> > +      return 0;
> > +
> > +   if (cur->post_handler) {
> > +      if (ucb->uprobe_status == UPROBE_SS_INLINE)
> > +         ucb->uprobe_status = UPROBE_SSDONE_INLINE;
> > +      else
> > +         ucb->uprobe_status = UPROBE_HIT_SSDONE;
> > +      cur->post_handler(cur, regs, 0);
> > +   }
> > +
> > +   resume_execution_user(cur, regs, ucb);
> > +   regs->eflags |= ucb->uprobe_saved_eflags;
> > +
> > +   if (ucb->uprobe_status == UPROBE_SSDONE_INLINE)
> > +      replace_original_insn(current_uprobe, regs,
> > +                  BREAKPOINT_INSTRUCTION);
> > +   else
> > +      pte_unmap(ucb->upte);
> > +
> > +   current_uprobe = NULL;
> > +   spin_unlock_irqrestore(&uprobe_lock, ucb->flags);
> > +   dec_preempt_count();
> > +   /*
> > +    * if somebody else is single stepping across a probe point, eflags
> > +    * will have TF set, in which case, continue the remaining
processing
> > +    * of do_debug, as if this is not a probe hit.
> > +    */
> > +   if (regs->eflags & TF_MASK)
> > +      return 0;
> > +
> > +   return 1;
> > +}
> > +
> > +static int __kprobes uprobe_fault_handler(struct pt_regs *regs, int
trapnr)
> > +{
> > +   struct kprobe *cur;
> > +   struct uprobe_ctlblk *ucb;
> > +   int ret = 0;
> > +
> > +   ucb = &uprobe_ctlblk;
> > +   cur = ucb->curr_p;
> > +
> > +   if (ucb->tsk != current || !cur)
> > +      return 0;
> > +
> > +   switch(ucb->uprobe_status) {
> > +   case UPROBE_HIT_SS:
> > +      pte_unmap(ucb->upte);
> > +      /* TODO: All acceptable number of faults before disabling */
> > +      replace_original_insn(current_uprobe, regs, cur->opcode);
> > +      /* Fall through and reset the current probe */
> > +   case UPROBE_SS_INLINE:
> > +      regs->eip = (unsigned long)cur->addr;
> > +      regs->eflags |= ucb->uprobe_old_eflags;
> > +      regs->eflags &= ~TF_MASK;
> > +      current_uprobe = NULL;
> > +      ret = 1;
> > +      spin_unlock_irqrestore(&uprobe_lock, ucb->flags);
> > +      preempt_enable_no_resched();
> > +      break;
> > +   case UPROBE_HIT_ACTIVE:
> > +   case UPROBE_SSDONE_INLINE:
> > +   case UPROBE_HIT_SSDONE:
> > +      if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
> > +         return 1;
> > +
> > +      if (fixup_exception(regs))
> > +         return 1;
> > +      /*
> > +       * We must not allow the system page handler to continue while
> > +       * holding a lock, since page fault handler can sleep and
> > +       * reschedule it on different cpu. Hence return 1.
> > +       */
> > +      return 1;
> > +      break;
> > +   default:
> > +      break;
> > +   }
> > +   return ret;
> > +}
> > +
> > +/*
> > + * Wrapper routine to for handling exceptions.
> > + */
> > +int __kprobes uprobe_exceptions_notify(struct notifier_block *self,
> > +                   unsigned long val, void *data)
> > +{
> > +   struct die_args *args = (struct die_args *)data;
> > +   int ret = NOTIFY_DONE;
> > +
> > +   if (args->regs->eflags & VM_MASK) {
> > +      /* We are in virtual-8086 mode. Return NOTIFY_DONE */
> > +      return ret;
> > +   }
> > +
> > +   switch (val) {
> > +   case DIE_INT3:
> > +      if (uprobe_handler(args->regs))
> > +         ret = NOTIFY_STOP;
> > +      break;
> > +   case DIE_DEBUG:
> > +      if (post_uprobe_handler(args->regs))
> > +         ret = NOTIFY_STOP;
> > +      break;
> > +   case DIE_GPF:
> > +   case DIE_PAGE_FAULT:
> > +      if (current_uprobe &&
> > +          uprobe_fault_handler(args->regs, args->trapnr))
> > +         ret = NOTIFY_STOP;
> > +      break;
> > +   default:
> > +      break;
> > +   }
> > +   return ret;
> > +}
> > diff -puN arch/i386/kernel/kprobes.c~kprobes_userspace_probes-ss-
> out-of-line arch/i386/kernel/kprobes.c
> > --- linux-2.6.17-rc3-mm1/arch/i386/kernel/kprobes.
> c~kprobes_userspace_probes-ss-out-of-line   2006-05-09 12:40:48.
> 000000000 +0530
> > +++ linux-2.6.17-rc3-mm1-prasanna/arch/i386/kernel/kprobes.c
> 2006-05-09 12:40:48.000000000 +0530
> > @@ -139,7 +139,7 @@ retry:
> >  /*
> >   * returns non-zero if opcode modifies the interrupt flag.
> >   */
> > -static int __kprobes is_IF_modifier(kprobe_opcode_t opcode)
> > +int __kprobes is_IF_modifier(kprobe_opcode_t opcode)
> >  {
> >     switch (opcode) {
> >     case 0xfa:      /* cli */
> > @@ -649,7 +649,7 @@ int __kprobes kprobe_exceptions_notify(s
> >     int ret = NOTIFY_DONE;
> >
> >     if (args->regs && user_mode(args->regs))
> > -      return ret;
> > +      return uprobe_exceptions_notify(self, val, data);
> >
> >     switch (val) {
> >     case DIE_INT3:
> > diff -puN arch/i386/mm/fault.c~kprobes_userspace_probes-ss-out-of-
> line arch/i386/mm/fault.c
> > --- linux-2.6.17-rc3-mm1/arch/i386/mm/fault.
> c~kprobes_userspace_probes-ss-out-of-line   2006-05-09 12:40:48.
> 000000000 +0530
> > +++ linux-2.6.17-rc3-mm1-prasanna/arch/i386/mm/fault.c
> 2006-05-09 12:40:48.000000000 +0530
> > @@ -104,8 +104,7 @@ void bust_spinlocks(int yes)
> >   *
> >   * This is slow, but is very rarely executed.
> >   */
> > -static inline unsigned long get_segment_eip(struct pt_regs *regs,
> > -                   unsigned long *eip_limit)
> > +unsigned long get_segment_eip(struct pt_regs *regs, unsigned long
> *eip_limit)
> >  {
> >     unsigned long eip = regs->eip;
> >     unsigned seg = regs->xcs & 0xffff;
> > diff -puN arch/i386/kernel/Makefile~kprobes_userspace_probes-ss-
> out-of-line arch/i386/kernel/Makefile
> > --- linux-2.6.17-rc3-
> mm1/arch/i386/kernel/Makefile~kprobes_userspace_probes-ss-out-of-
> line   2006-05-09 12:40:48.000000000 +0530
> > +++ linux-2.6.17-rc3-mm1-prasanna/arch/i386/kernel/Makefile
> 2006-05-09 12:40:48.000000000 +0530
> > @@ -27,7 +27,7 @@ obj-$(CONFIG_KEXEC)      += machine_kexec.o
> >  obj-$(CONFIG_CRASH_DUMP)   += crash_dump.o
> >  obj-$(CONFIG_X86_NUMAQ)      += numaq.o
> >  obj-$(CONFIG_X86_SUMMIT_NUMA)   += summit.o
> > -obj-$(CONFIG_KPROBES)      += kprobes.o
> > +obj-$(CONFIG_KPROBES)      += kprobes.o uprobes.o
> >  obj-$(CONFIG_MODULES)      += module.o
> >  obj-y            += sysenter.o vsyscall.o
> >  obj-$(CONFIG_ACPI_SRAT)    += srat.o
> >
> > _

