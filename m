Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUIJMmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUIJMmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUIJMmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:42:15 -0400
Received: from h217-220-125-206.albacom.net ([217.220.125.206]:47847 "EHLO
	mail.pigrecodata.net") by vger.kernel.org with ESMTP
	id S267176AbUIJMl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:41:59 -0400
Date: Fri, 10 Sep 2004 16:48:40 +0200
From: Federico Gherardini <f.gherardini@pigrecodata.net>
To: linux-kernel@vger.kernel.org
Subject: A question about do_fork and CLONE_VM
Message-Id: <20040910164840.76560350@misha>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to find my way into the kernel code and I have a little question about the implementation of lightweight processes... . copy_mm (invoked by copy_process) actually does

	oldmm = current->mm;
	if (!oldmm)
		return 0;

	if (clone_flags & CLONE_VM) {
		atomic_inc(&oldmm->mm_users);
		mm = oldmm;
		/*
		 * There are cases where the PTL is held to ensure no
		 * new threads start up in user mode using an mm, which
		 * allows optimizing out ipis; the tlb_gather_mmu code
		 * is an example.
		 */
		spin_unlock_wait(&oldmm->page_table_lock);
		goto good_mm;
	}
so the new process receives the memory descriptor of the parent. After that copy_process invokes copy_thread which does 

       childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
        *childregs = *regs;
        childregs->eax = 0;
        childregs->esp = esp;
        p->set_child_tid = p->clear_child_tid = NULL;

        p->thread.esp = (unsigned long) childregs;
        p->thread.esp0 = (unsigned long) (childregs+1);

        p->thread.eip = (unsigned long) ret_from_fork;

this is where the new process receives its esp from the start_stack parameter supplied with clone. What I don't understand is that it seems that no one actually updates the start_stack field of the memory descriptor of the child process which is now  incorrect since we gave it a new stack, but it is still using the same memory descriptor of the parent. Am I missing something? Or maybe that field is not important enough to set up an entirely new memory descriptor for the child? 
Also another general question... Why doesn't the kernel set up a new stack automatically? I'm asking this because I don't see why one would want two threads to share the same stack and if it was allocated by the kernel, one could set the VM_GROWSDOWN flag for the memory region so that do_page_fault() could automatically catch a stack overflow and expand the area associated with the stack.

Thanks in advance for you time,
Cheers,
Federico


