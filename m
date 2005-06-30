Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbVF3RAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbVF3RAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 13:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVF3Q64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:58:56 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:27816 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S263006AbVF3Q4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:56:41 -0400
Date: Thu, 30 Jun 2005 12:53:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Handle kernel page faults using task gate
To: eliad lubovsky <eliadl@013.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200506301256_MC3-1-A31A-143@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005 at 18:43:47 +0300, eliad lubovsky wrote:

> my page fault handler:
> static void pagefault_fn(void)
> {
>   unsigned int address, aligned_page_fault_address;
>   struct vm_struct *area;
> 
>   /* retrieve the page fault address */ 
>   __asm__("movl %%cr2,%0":"=r" (address));
> 
>   aligned_page_fault_address = ((address+PAGE_SIZE)&(~(4096-1)));
> 
>   area = find_vm_area((void*)(aligned_page_fault_address));
> 
>   /* allocate a new physical page, expand the stack size */
>   expend_stack_size(area);
> 
>  // asm ("pushf; orl  $0x00004000, (%esp); popf; iret"); /* sets NT   */
>  // asm ("pushf; andl $0xffffbfff, (%esp); popf; iret"); /* clears NT */
>  asm ("iret");
> }


 That will work exactly once. :(

 On the next fault, control wil be transferred to the instruction after
the iret.  It needs to be like this:

======================

static void pagefault_fn(void) {
        unsigned int address, aligned_page_fault_address;
        struct vm_struct *area;

        /* put one-time initialization code here */

        goto handle_fault;

return_from_fault:
        asm("iret");

handle_fault:
        aligned_page_fault_address = ((address+PAGE_SIZE)&(~(4096-1)));
        area = find_vm_area((void*)(aligned_page_fault_address));

        /* allocate a new physical page, expand the stack size */
        expend_stack_size(area);

        goto return_from_fault;
}

======================

 (You also need a private stack to hold the local vars for each TSS.)

--
Chuck
