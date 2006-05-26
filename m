Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWEZDRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWEZDRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 23:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWEZDRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 23:17:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:10534 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030261AbWEZDRP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 23:17:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gmUpLbxk/XueHUa0WL+67TzRTGH941QZQYw0z+xEWFQj7jzzusc0sUEXjNKJhltXmzmhlTAl/NPAFOiAeQ9InzUMJWidI8FfLBFypE8ZCJopOklBCo/J10fUriB+8rJP7UHa/y1Iz0OT+EiYwo+gPY1TSTmRCe6gdO/2+730wsw=
Message-ID: <aec7e5c30605252017v1d8269a4jf75f055fe256f966@mail.gmail.com>
Date: Fri, 26 May 2006 12:17:14 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current pgd (V2, x86_64)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m11wuif5zy.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044247.14219.13579.sendpatchset@cherry.local>
	 <m1slmystqa.fsf@ebiederm.dsl.xmission.com>
	 <1148545616.5793.180.camel@localhost>
	 <m11wuif5zy.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
>
> > Let me explain the theory behind my kexec patch:
>
> Please the next time you submit a please try to keep what
> you are changing sufficiently clear that a followup email
> is not needed to explain the code.

Yes, I will try to do that. I guess what I'm doing requires a great
amount of explaining so let's do it bit by bit.

> > During prepare, page_table_a is initialized. For x86_64 page_table_b is
> > also initialized.
> >
> > When it is time for machine_kexec() the following sequence takes place:
> >
> > 1. The C-code in machine_kexec() jumps to the assembly routine.
> > To avoid overwriting the page table and still work with NX bits we jump
> > to the original location of relocate_new_kernel. This is different from
> > the unpatched code which jumps to the physical address (ie the identity
> > mapped location).
> >
> > 2. The assembly code switches to page_table_a.
> > page_table_a has mapped the control page at two virtual addresses:
> > - The same virtual address as relocate_new_kernel is located at.
> >   (This explains the extra aligment in the assembly file)
> > - An identity mapping, ie virtual address == physical address.
> > After the switch the code runs at the same virtual address, but the
> > physical page is now the control page.
>
> Sorry this is broken.  The code location you are running from when you
> perform the switch from one page table to another must be mapped at
> the same location in both page tables.  Otherwise it is undefined what
> the processor will do.

The code is not broken. The code does exactly what you are talking
about. Maybe I was a bit unclear.

"page_table_a" contains two mappings. One which is the same as where
the page is mapped in the kernel (the virtual address where
relocate_new_kernel is located), and one identity mapped. So when the
switch occurs the cpu will continue to run on the same virtual
address.

> So you need at least one additional entry in your page table.
>
> The fact that this bug did not jump out is a clear sign you were
> changing too many things at once, and did not have an adequate
> explanation in your change log.

I will ignore that last part for now. I've tested the code on i386,
i386/pae, x86_64 (both opteron and athlon64) and all the combinations
with and without xen, and all configurations except x86_64 with both
kexec and kdump.

> > 3. Setup idt, gdt, segment registers and stack pointer.
> > The stack pointer should point to the identity mapped page.
> >
> > 4. Jump to the identity mapped address.
> > When the jump is performed we will be running at a virtual address which
> > is the same as the physical address.
>
> After the jump is performed?

Sorry for being unclear. Read it like this instead:

Before jumping we will be running from the virtual address provided by
the non-identity mapped page in page_table_a. This is the same page as
relocate_new_kernel.

After the jump we will be running from the identity mapped address
provided by page_table_a. This is the same address as the physical
address of the control page.

> > 5. Turn off MMU (i386) / switch to page_table_b (x86_64).
> > We are able to turn off the MMU or switch to page_table_b because we are
> > already running at the physical address.
> >
> > 6. Proceed with the page copying business as usual...
> >
> > Ok, so far so good.
> >
> > The fun part begins when we throw in Xen into the mix. Linux under xen
> > runs with pseudophysical addresses, ie what Linux thinks are physical
> > addresses are not physical. Xen use the term machine addresses for
> > addresses that are called physical address under "regular" Linux. On top
> > of that is Xen using a different memory map than Linux.
> >
> > After prepare, all pages in page_table_a are passed to the hypervisor
> > that overwrites the contents filled in by machine_prepare().
> > (this explains the "ridiculous" array of struct page *)
>
> Actually it doesn't really, because I don't have enough information
> to infer which Xen call you are using or why it is sane.  Certainly
> Xen does not need struct page * pointers or Xen is too tightly coupled
> with linux to be sane.

The interface between dom0 and the hypervisor passes machine
addresses. So no struct pages are passed there. I'm not insane.

I actually went with struct page * over unsigned long because that's
the way the current struct kimage refers to the control page. On top
of that I must say that I prefer types over unsigned longs because I
think it leads to better code. But that's another story.

> > A similar two page mapping is used for here too, but in the xen case we
> > use a different virtual address (the non-identity mapped address)
> > compared to "regular" Linux. All to fit the address space used by xen.
> >
> > The xen port which is based on my patches is using a sequence similar to
> > "regular" Linux:
> >
> > 1a. The C-code in xen_machine_kexec() performs a hypercall.
> >
> > 1b. The hypervisor jumps to the assembly code.
> > After prepare we've created a NX-safe mapping for the control page. We
> > jump to that NX-safe address to transfer control to the assembly
> > code.
>
> I assume this is a Xen call with the semantics:
> switch page tables and jump to location X in the new page tables.

We are not switching any page tables more than whatever Xen likes to
do during a hypercall. We simply jump to a NX-safe mapped location
(fixmap) of the already loaded control page. Then the assembly code in
the control page does the same magic as in the Linux case.

> I assume Xen is still running at this point?

If the hypervisor is crashing the loaded kdump kernel will be started.
I guess Xen must be running for us to be able to go from dom0 to the
hypervisor, but it that's not the case there's not much we can do. The
dom0 kernel is not privileged to switch page tables by itself so we
must do it from within the hypervisor.

If you are referring to if kexec works under Xen, then yes:

http://lists.xensource.com/archives/html/xen-devel/2006-05/msg01272.html

> > Goto 2 above.
> >
> > So, to answer your question regarding two page table copies. You may be
> > right that it can be made work with just one page table, but I feel my
> > two table approach is nice because it will always work - regardless of
> > the memory map used.
>
> Except that the memory map in linux is fixed.  The x86_64 kernel will
> run with negative addresses and physical addresses will remain
> positive until a decade or two from now when we get 64bit physical
> addresses.
>
> Unless linux runs with a different memory map when running under Xen.

Xen can be configured in many ways. Different page table modes.

And to be frank, I'm not exactly sure how the memory map differs on
all architectures when various configuration options are varied. And
I'm not that interested in it either because it feels like very
volatile knowledge.

I do however believe that the "page_table_a" approach works regardless
of memory map. Both with and without xen. Regardless of memory split.

Thanks,

/ magnus
