Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbUBASgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 13:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbUBASgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 13:36:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48975 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265393AbUBASgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 13:36:19 -0500
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Andi Kleen <ak@colin2.muc.de>,
       Andrew Morton <akpm@osdl.org>, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com>
	<20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk>
	<20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0401290802370.689@home.osdl.org>
	<20040129164230.GE18725@parcelfarce.linux.theplanet.co.uk>
	<m1hdybwzli.fsf@ebiederm.dsl.xmission.com>
	<20040201051021.GO18725@parcelfarce.linux.theplanet.co.uk>
	<m1brojvzda.fsf@ebiederm.dsl.xmission.com>
	<20040201151843.GP18725@parcelfarce.linux.theplanet.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Feb 2004 11:28:38 -0700
In-Reply-To: <20040201151843.GP18725@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m1y8rmvell.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To the Intel guess working out the ACPI 3.0 interfaces.  

1) How do we find the Root Complex Register Block?
2) How does ACPI describe multiple MMCONFIG spaces?

Matthew Wilcox <willy@debian.org> writes:

> On Sun, Feb 01, 2004 at 04:00:01AM -0700, Eric W. Biederman wrote:
>
> > I'm wondering if ioremap or set_fixmap could be modified to take
> > a page frame number or possibly a token like the dma mapping functions
> > so we don't need all of the low bits and can actually solve these
> > problems on a 32bit architecture.
> 
> The interface I'd actually like to see drivers using is
> 	unsigned long addr = map_resource(struct resource *res);
> 
> which would probably be implemented something like:
> 
> static inline unsigned long map_resource(struct resource *res)
> {
> 	ioremap(res->start, res->end - res->start + 1);
> }

On 32bit arches I think it would look like:

static void *map_resource(struct resource *res)
{
        void *addr;
        unsigned long first_pfn, last_pfn, pages;
        unsigned long offset;
        if (res->end >= too_big) {
        	return NULL;
        }
        offset = res->start & ~PAGE_MASK;
        first_pfn = res->start >> PAGE_SHIFT;
        last_pfn  = res->end   >> PAGE_SHIFT;
        pages = last_pfn - first_pfn + 1;
        addr = ioremap_pfn(first_pfn, pages);
        if (addr) {
		addr = (void *)(offset + (char *)addr);
        }
        return addr;
}

I suspect the check for addresses being an address being too big
would be useful even on 64bit architectures.  I just looked
and ia64 does not have that check and bad BARs could cause
interesting problems.  It makes sense to catch illegal bar values
earlier, but this whole part of the code is a slow path so putting in
a sanity check should not hurt anything.

I think we want an ioremap_pfn instead of an ioremap64.  On 64bit
platforms ioremap64 is just ioremap so it is redundant.  On 32bit
platforms ioremap64 is really ioremap_pfn with just a different
wrapper around it.  While ioremap_pfn makes sense on all
architectures.  

ioremap_pfn has the added plus that on 32bit arches it will
usually have a 32bit pfn as well.

> on 64-bit architectures.  32-bit architectures would need more though.
> vm_struct uses 'unsigned long' to represent the phys_addr.  Can we get
> away with changing phys_addr to phys_pagenr?  That should allow 32-bit
> arches to implement ioremap64().

I don't see why not.  vm_struct is only used with vmalloc data,
and phys_addr is only used by a handful of architecture specific
files.  Everything else is in terms of page frame numbers already.

> Note I don't intend to do this work -- 64-bit BARs work fine on ia64 ;-)

Ah yes the architecture on the end of the hardware update list.

The real problem is that struct resource needs to be expanded on 32bit
architectures.  I'm not certain how much changing that will affect.  I
know it has been looked at a time or two before, and there some
problems that were noted on 32bit architectures.  This may be a 2.7
issue.

> > The first draft of the patch had a u64 there.  So I think we should
> > at least check to ensure the high half is zero.  If it the high half
> > is not zero we can print an annoying error message.  All of the normal
> > pci capabilities are still limited to being in the first 256 bytes of
> > the configuration space.  So not a lot is lost if we can't enable the
> > entire 4K. 
> 
> Yes, I think that's a reasonable thing to do until an ioremap64
> exists.

Could the patch be updated to do that please?

> > There is also one piece I did not see the PCI Express configuration
> > space for the root complex.  This is a configuration space with no pci
> > bus/dev/fn numbers, if my memory serves me correctly.
> 
> Your memory is correct.  The spec says:
> 
>    System firmware communicates the base address of the RCRB for each Root
>    Port to the operating system. Multiple Root Ports may be associated
>    with the same RCRB. The RCRB memory-mapped registers must not reside
>    in the same address space as the memory-mapped configuration space.
> 
> (RCRB == Root Complex Register Block)
> 
> I don't know how these systems intend to communicate the the base address.
> Presumably this will also be part of ACPI 3.0.  Anyway, this is an
> orthogonal issue from this patch which only aims to allow use of the
> MMCONFIG space.

It is an orthogonal issue of everything except that Intel appears to
be testing out the new table interface on the Linux community.  So
this is a reasonable time to provide feedback.

> > On the interface side I also have the question how it will be
> > described when there are multiple memory configuration spaces
> > corresponding to disjoint pci configuration spaces.  I don't think
> > we can easily support that in Linux at the moment but there is no
> > reason why there can't be a table entry for it.
> 
> i386 doesn't support it but ia64, ppc and sparc do.  I presume each
> domain will get its own MCFG space.  It won't be hard to support, but
> there's no point in doing it until hardware exists.

Ok, I guess that did get implemented then.  Especially for the ia64
case it is a significant question what does the acpi table need to
look like for multiple MCFG spaces.  We should implement this properly
if we can.  This is another issue that is relevant because the
interfaces are still being defined.

Eric
