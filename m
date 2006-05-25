Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWEYQCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWEYQCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWEYQCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:02:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62366 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030238AbWEYQCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:02:48 -0400
To: Magnus Damm <magnus@valinux.co.jp>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current
 pgd (V2, x86_64)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524044247.14219.13579.sendpatchset@cherry.local>
	<m1slmystqa.fsf@ebiederm.dsl.xmission.com>
	<1148545616.5793.180.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 25 May 2006 10:01:37 -0600
In-Reply-To: <1148545616.5793.180.camel@localhost> (Magnus Damm's message of
 "Thu, 25 May 2006 17:26:56 +0900")
Message-ID: <m11wuif5zy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> Let me explain the theory behind my kexec patch:

Please the next time you submit a please try to keep what
you are changing sufficiently clear that a followup email
is not needed to explain the code.

> During prepare, page_table_a is initialized. For x86_64 page_table_b is
> also initialized.
>
> When it is time for machine_kexec() the following sequence takes place:
>
> 1. The C-code in machine_kexec() jumps to the assembly routine.
> To avoid overwriting the page table and still work with NX bits we jump
> to the original location of relocate_new_kernel. This is different from
> the unpatched code which jumps to the physical address (ie the identity
> mapped location).
>
> 2. The assembly code switches to page_table_a.
> page_table_a has mapped the control page at two virtual addresses:
> - The same virtual address as relocate_new_kernel is located at.
>   (This explains the extra aligment in the assembly file)
> - An identity mapping, ie virtual address == physical address.
> After the switch the code runs at the same virtual address, but the
> physical page is now the control page.

Sorry this is broken.  The code location you are running from when you
perform the switch from one page table to another must be mapped at
the same location in both page tables.  Otherwise it is undefined what
the processor will do.

So you need at least one additional entry in your page table.

The fact that this bug did not jump out is a clear sign you were
changing too many things at once, and did not have an adequate
explanation in your change log.

> 3. Setup idt, gdt, segment registers and stack pointer.
> The stack pointer should point to the identity mapped page.
>
> 4. Jump to the identity mapped address.
> When the jump is performed we will be running at a virtual address which
> is the same as the physical address.

After the jump is performed?

> 5. Turn off MMU (i386) / switch to page_table_b (x86_64).
> We are able to turn off the MMU or switch to page_table_b because we are
> already running at the physical address.
>
> 6. Proceed with the page copying business as usual...
>
> Ok, so far so good.
>
> The fun part begins when we throw in Xen into the mix. Linux under xen
> runs with pseudophysical addresses, ie what Linux thinks are physical
> addresses are not physical. Xen use the term machine addresses for
> addresses that are called physical address under "regular" Linux. On top
> of that is Xen using a different memory map than Linux.
>
> After prepare, all pages in page_table_a are passed to the hypervisor
> that overwrites the contents filled in by machine_prepare(). 
> (this explains the "ridiculous" array of struct page *)

Actually it doesn't really, because I don't have enough information
to infer which Xen call you are using or why it is sane.  Certainly
Xen does not need struct page * pointers or Xen is too tightly coupled
with linux to be sane.

> A similar two page mapping is used for here too, but in the xen case we
> use a different virtual address (the non-identity mapped address)
> compared to "regular" Linux. All to fit the address space used by xen.
>
> The xen port which is based on my patches is using a sequence similar to
> "regular" Linux:
>
> 1a. The C-code in xen_machine_kexec() performs a hypercall.
>
> 1b. The hypervisor jumps to the assembly code.
> After prepare we've created a NX-safe mapping for the control page. We
> jump to that NX-safe address to transfer control to the assembly
> code.

I assume this is a Xen call with the semantics: 
switch page tables and jump to location X in the new page tables.

I assume Xen is still running at this point?

> Goto 2 above.
>
> So, to answer your question regarding two page table copies. You may be
> right that it can be made work with just one page table, but I feel my
> two table approach is nice because it will always work - regardless of
> the memory map used.

Except that the memory map in linux is fixed.  The x86_64 kernel will
run with negative addresses and physical addresses will remain
positive until a decade or two from now when we get 64bit physical
addresses.

Unless linux runs with a different memory map when running under Xen.

Eric

