Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWEYIYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWEYIYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 04:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWEYIYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 04:24:54 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:40075 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S965087AbWEYIYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 04:24:53 -0400
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current
	pgd (V2, x86_64)
From: Magnus Damm <magnus@valinux.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <m1slmystqa.fsf@ebiederm.dsl.xmission.com>
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044247.14219.13579.sendpatchset@cherry.local>
	 <m1slmystqa.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 17:26:56 +0900
Message-Id: <1148545616.5793.180.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 20:50 -0600, Eric W. Biederman wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
> 
> > --===============37282618571824511==
> >
> > kexec: Avoid overwriting the current pgd (V2, x86_64)
> >
> > This patch upgrades the x86_64-specific kexec code to avoid overwriting the
> > current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
> > to start a secondary kernel that dumps the memory of the previous kernel.
> >
> > The code introduces a new set of page tables called "page_table_a". These
> > tables are used to provide an executable identity mapping without overwriting
> > the current pgd. The already existing page table is renamed to "page_table_b".
> 
> As I mentioned earlier you don't need two page tables, because
> it is easy to guarantee that the identity mapping and the virtual mapping
> will not intersect on x86_64.  Until we have as many physical address bits
> as virtual address bits (which requires page table modifications) it
> is nonsense to have 2 page tables here.

Let me explain the theory behind my kexec patch:

During prepare, page_table_a is initialized. For x86_64 page_table_b is
also initialized.

When it is time for machine_kexec() the following sequence takes place:

1. The C-code in machine_kexec() jumps to the assembly routine.
To avoid overwriting the page table and still work with NX bits we jump
to the original location of relocate_new_kernel. This is different from
the unpatched code which jumps to the physical address (ie the identity
mapped location).

2. The assembly code switches to page_table_a.
page_table_a has mapped the control page at two virtual addresses:
- The same virtual address as relocate_new_kernel is located at.
  (This explains the extra aligment in the assembly file)
- An identity mapping, ie virtual address == physical address.
After the switch the code runs at the same virtual address, but the
physical page is now the control page.

3. Setup idt, gdt, segment registers and stack pointer.
The stack pointer should point to the identity mapped page.

4. Jump to the identity mapped address.
When the jump is performed we will be running at a virtual address which
is the same as the physical address.

5. Turn off MMU (i386) / switch to page_table_b (x86_64).
We are able to turn off the MMU or switch to page_table_b because we are
already running at the physical address.

6. Proceed with the page copying business as usual...

Ok, so far so good.

The fun part begins when we throw in Xen into the mix. Linux under xen
runs with pseudophysical addresses, ie what Linux thinks are physical
addresses are not physical. Xen use the term machine addresses for
addresses that are called physical address under "regular" Linux. On top
of that is Xen using a different memory map than Linux.

After prepare, all pages in page_table_a are passed to the hypervisor
that overwrites the contents filled in by machine_prepare(). 
(this explains the "ridiculous" array of struct page *)

A similar two page mapping is used for here too, but in the xen case we
use a different virtual address (the non-identity mapped address)
compared to "regular" Linux. All to fit the address space used by xen.

The xen port which is based on my patches is using a sequence similar to
"regular" Linux:

1a. The C-code in xen_machine_kexec() performs a hypercall.

1b. The hypervisor jumps to the assembly code.
After prepare we've created a NX-safe mapping for the control page. We
jump to that NX-safe address to transfer control to the assembly code.

Goto 2 above.

So, to answer your question regarding two page table copies. You may be
right that it can be made work with just one page table, but I feel my
two table approach is nice because it will always work - regardless of
the memory map used.

Thanks,

/ magnus

