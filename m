Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVF2Pjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVF2Pjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVF2Pjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:39:52 -0400
Received: from mtaout5.barak.net.il ([212.150.49.175]:40503 "EHLO
	mtaout5.barak.net.il") by vger.kernel.org with ESMTP
	id S261358AbVF2PjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:39:08 -0400
Date: Wed, 29 Jun 2005 18:43:47 +0300
From: eliad lubovsky <eliadl@013.net>
Subject: Re: Handle kernel page faults using task gate
In-reply-to: <20050629130901.GA29776@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Message-id: <1120059827.3354.30.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8BIT
References: <1119997135.4074.106.camel@localhost.localdomain>
 <20050629130901.GA29776@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"...The NT flag indicates that the previous task link field of the TSS
has been loaded with a saved TSS segment selector. If software
uses an IRET instruction to suspend the new task, the processor uses the
value in the previous task link field and the NT flag to return to the
previous task; that is, if the NT flag is set, the processor performs a
task switch to the task specified in the previous task link field."

"If the task switch was initiated with an exception, or an interrupt,
the processor sets the NT flag in the EFLAGS image stored in the new
task’s TSS;"

Intel Architecture Software Developer’s Manual Volume 3: System
Programming

Not sure I need to clear the NT flag.

my page fault handler:
static void pagefault_fn(void)
{
  unsigned int address, aligned_page_fault_address;
  struct vm_struct *area;

  /* retrieve the page fault address */ 
  __asm__("movl %%cr2,%0":"=r" (address));

  aligned_page_fault_address = ((address+PAGE_SIZE)&(~(4096-1)));

  area = find_vm_area((void*)(aligned_page_fault_address));

  /* allocate a new physical page, expand the stack size */
  expend_stack_size(area);

 // asm ("pushf; orl  $0x00004000, (%esp); popf; iret"); /* sets NT   */
 // asm ("pushf; andl $0xffffbfff, (%esp); popf; iret"); /* clears NT */
 asm ("iret");
}


On Wed, 2005-06-29 at 16:09, Ingo Molnar wrote:
> * eliad lubovsky <eliadl@013.net> wrote:
> 
> > I am trying to handle page faults exceptions in the kernel using the 
> > task gate mechanism. I succeeded to transfer the execution to my page 
> > fault handler using a new TSS and updates to the GDT and IDT tables 
> > (similar to the double fault mechanism in 2.6). After handling the 
> > fault and allocating the physical page I use the iret instruction to 
> > switch back to the previous task. The problem is that I got a double 
> > fault with the same address that cause the fault (although the 
> > physical page is allocated and mapped). Any clues?
> 
> are you clearing the 'nested task' (NT) flag of the new TSS once you 
> have switched to it?
> 
> 	Ingo

