Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWCTLM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWCTLM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWCTLM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:12:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932182AbWCTLM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:12:56 -0500
Date: Mon, 20 Mar 2006 03:09:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: prasanna@in.ibm.com
Cc: ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single stepping
 out-of-line
Message-Id: <20060320030922.4ea9445b.akpm@osdl.org>
In-Reply-To: <20060320061123.GF31091@in.ibm.com>
References: <20060320060745.GC31091@in.ibm.com>
	<20060320060931.GD31091@in.ibm.com>
	<20060320061014.GE31091@in.ibm.com>
	<20060320061123.GF31091@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
>
> This patch provides a mechanism for probe handling and
> executing the user-specified handlers.
> 
> Each userspace probe is uniquely identified by the combination of
> inode and offset, hence during registeration the inode and offset
> combination is added to uprobes hash table. Initially when
> breakpoint instruction is hit, the uprobes hash table is looked up
> for matching inode and offset. The pre_handlers are called in
> sequence if multiple probes are registered. Similar to kprobes,
> uprobes also adopts to single step out-of-line, so that probe miss in
> SMP environment can be avoided. But for userspace probes, instruction
> copied into kernel address space cannot be single stepped, hence the
> instruction must be copied to user address space. The solution is to
> find free space in the current process address space and then copy the
> original instruction and single step that instruction.
> 
> User processes use stack space to store local variables, agruments and
> return values. Normally the stack space either below or above the
> stack pointer indicates the free stack space.
> 
> The instruction to be single stepped can modify the stack space,
> hence before using the free stack space, sufficient stack space should
> be left. The instruction is copied to the bottom of the page and check
> is made such that the copied instruction does not cross the page
> boundry. The copied instruction is then single stepped. Several
> architectures does not allow the instruction to be executed from the
> stack location, since no-exec bit is set for the stack pages. In those
> architectures, the page table entry corresponding to the stack page is
> identified and the no-exec bit is unset making the instruction on that
> stack page to be executed.
> 
> There are situations where even the free stack space is not enough for
> the user instruction to be copied and single stepped. In such
> situations, the virtual memory area(vma) can be expanded beyond the
> current stack vma. This expaneded stack can be used to copy the
> original instruction and single step out-of-line.
> 
> Even if the vma cannot be extended then the instruction much be
> executed inline, by replacing the breakpoint instruction with original
> instruction.
> 
> ...
>
> +
> +/**
> + * This routines get the pte of the page containing the specified address.
> + */
> +static pte_t  __kprobes *get_uprobe_pte(unsigned long address)
> +{
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte = NULL;
> +
> +	pgd = pgd_offset(current->mm, address);
> +	if (!pgd)
> +		goto out;
> +
> +	pud = pud_offset(pgd, address);
> +	if (!pud)
> +		goto out;
> +
> +	pmd = pmd_offset(pud, address);
> +	if (!pmd)
> +		goto out;
> +
> +	pte = pte_alloc_map(current->mm, pmd, address);
> +
> +out:
> +	return pte;
> +}

That's familiar looking code..

I guess this should be given a more generic name then placed in
mm/memory.c, which is where we do pagetable walking.

> +/**
> + *  This routine check for space in the current process's stack
> + *  address space. If enough address space is found, copy the original
> + *  instruction on that page for single stepping out-of-line.
> + */
> +static int __kprobes copy_insn_on_new_page(struct uprobe *uprobe ,
> +			struct pt_regs *regs, struct vm_area_struct *vma)
> +{
> +	unsigned long addr, stack_addr = regs->esp;
> +	int size = MAX_INSN_SIZE * sizeof(kprobe_opcode_t);
> +
> +	if (vma->vm_flags & VM_GROWSDOWN) {
> +		if (((stack_addr - sizeof(long long))) <
> +						(vma->vm_start + size))
> +			return -ENOMEM;
> +		addr = vma->vm_start;
> +	} else if (vma->vm_flags & VM_GROWSUP) {
> +		if ((vma->vm_end - size) < (stack_addr + sizeof(long long)))
> +			return -ENOMEM;
> +		addr = vma->vm_end - size;
> +	} else
> +		return -EFAULT;
> +
> +	vma->vm_flags |= VM_LOCKED;
> +
> +	if (__copy_to_user_inatomic((unsigned long *)addr,
> +				(unsigned long *)uprobe->kp.ainsn.insn, size))
> +		return -EFAULT;
> +
> +	regs->eip = addr;
> +
> +	return 0;
> +}

If we're going to use __copy_to_user_inatomic() then we'll need some nice
comments explaining why this is happening.

And we'll need to actually *be* in-atomic.  That means we need an
open-coded inc_preempt_count() and dec_preempt_count() in there and I don't
see them.


> +/**
> + * This routine expands the stack beyond the present process address
> + * space and copies the instruction to that location, so that
> + * processor can single step out-of-line.
> + */
> +static int __kprobes copy_insn_onexpstack(struct uprobe *uprobe,
> +			struct pt_regs *regs, struct vm_area_struct *vma)
> +{
> +	unsigned long addr, vm_addr;
> +	int size = MAX_INSN_SIZE * sizeof(kprobe_opcode_t);
> +	struct vm_area_struct *new_vma;
> +	struct mm_struct *mm = current->mm;
> +
> +
> +	 if (!down_read_trylock(&current->mm->mmap_sem))
> +		 return -ENOMEM;
> +
> +	if (vma->vm_flags & VM_GROWSDOWN)
> +		vm_addr = vma->vm_start - size;
> +	else if (vma->vm_flags & VM_GROWSUP)
> +		vm_addr = vma->vm_end + size;
> +	else {
> +		up_read(&current->mm->mmap_sem);
> +		return -EFAULT;
> +	}
> +
> +	new_vma = find_extend_vma(mm, vm_addr);
> +	if (!new_vma) {
> +		up_read(&current->mm->mmap_sem);
> +		return -ENOMEM;
> +	}
> +
> +	if (new_vma->vm_flags & VM_GROWSDOWN)
> +		addr = new_vma->vm_start;
> +	else
> +		addr = new_vma->vm_end - size;
> +
> +	new_vma->vm_flags |= VM_LOCKED;
> +	up_read(&current->mm->mmap_sem);
> +
> +	if (__copy_to_user_inatomic((unsigned long *)addr,
> +				(unsigned long *)uprobe->kp.ainsn.insn, size))
> +		return -EFAULT;
> +
> +	regs->eip = addr;
> +
> +	return  0;
> +}

Why is VM_LOCKED being set? (It needs a comment).

Where does it get unset?

> +
> +		if (__copy_to_user_inatomic((unsigned long *)page_addr,
> +								source, size))
> +		if (__copy_to_user_inatomic(
> +			(unsigned long *)(page_addr - size), source, size))

See above.

> +
> +/**
> + * This routines get the page containing the probe, maps it and
> + * replaced the instruction at the probed address with specified
> + * opcode.
> + */
> +void __kprobes replace_original_insn(struct uprobe *uprobe,
> +				struct pt_regs *regs, kprobe_opcode_t opcode)
> +{
> +	kprobe_opcode_t *addr;
> +	struct page *page;
> +
> +	page = find_get_page(uprobe->inode->i_mapping,
> +					uprobe->offset >> PAGE_CACHE_SHIFT);
> +	BUG_ON(!page);
> +
> +	__lock_page(page);

Whoa.  Why is __lock_page() being used here?  It looks like a bug is being
covered up.

> +	addr = (kprobe_opcode_t *)kmap_atomic(page, KM_USER1);
> +	addr = (kprobe_opcode_t *)((unsigned long)addr +
> +				 (unsigned long)(uprobe->offset & ~PAGE_MASK));
> +	*addr = opcode;
> +	/*TODO: flush vma ? */

flush_dcache_page() would be needed.

But then, what happens if the page is shared by other processes?  Do they
all start taking debug traps?

> +	kunmap_atomic(addr, KM_USER1);
> +
> +	unlock_page(page);
> +
> +	if (page)
> +		page_cache_release(page);
> +	regs->eip = (unsigned long)uprobe->kp.addr;
> +}
> +
> +/**
> + * This routine provides the functionality of single stepping
> + * out-of-line. If single stepping out-of-line cannot be achieved,
> + * it replaces with the original instruction allowing it to single
> + * step inline.
> + */
> +static inline int prepare_singlestep_uprobe(struct uprobe *uprobe,
> +				struct uprobe_ctlblk *ucb, struct pt_regs *regs)
> +{
> +	unsigned long stack_addr = regs->esp, flags;
> +	struct vm_area_struct *vma = NULL;
> +	int err = 0;
> +
> +	vma = find_vma(current->mm, (stack_addr & PAGE_MASK));

I don't think mmap_sem is held here?

> +static inline int uprobe_fault_handler(struct pt_regs *regs, int trapnr)

If, for some reason, the compiler decides to not inline this function then
you have a hunk of code which isn't marked __kprobes, but it should be.

I'd suggest that you remove all inlining from this code and add the
appropriate section markers.

Or I guess you could use __always_inline, but I'm not sure that it's really
worth the fuss and obscurity of doing that.

All kprobes-related code should be audited for this problem.

