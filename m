Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUBAPSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 10:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbUBAPSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 10:18:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5831 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265325AbUBAPSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 10:18:45 -0500
Date: Sun, 1 Feb 2004 15:18:43 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, Andi Kleen <ak@colin2.muc.de>,
       Andrew Morton <akpm@osdl.org>, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040201151843.GP18725@parcelfarce.linux.theplanet.co.uk>
References: <6B09584CC3D2124DB45C3B592414FA830112C34F@bgsmsx402.gar.corp.intel.com> <20040129150925.GC18725@parcelfarce.linux.theplanet.co.uk> <20040129155911.GD18725@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401290802370.689@home.osdl.org> <20040129164230.GE18725@parcelfarce.linux.theplanet.co.uk> <m1hdybwzli.fsf@ebiederm.dsl.xmission.com> <20040201051021.GO18725@parcelfarce.linux.theplanet.co.uk> <m1brojvzda.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1brojvzda.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 04:00:01AM -0700, Eric W. Biederman wrote:
> Matthew Wilcox <willy@debian.org> writes:
> > This is actually a Linux limitation -- we're pretty bad at dealing with
> > 64-bit BARs on 32-bit architectures.  There's two interfaces to get
> > at it -- ioremap() and set_fixmap().  Both of these interfaces take an
> > unsigned long to describe a physical address.
> 
> Which is another issue besides PCI express.  This 32bit VM on a 64bit
> box I find quite annoying.  Now that there are 64bit x86 alternatives
> I won't be shy about using 64bit addresses in BARs, if I need them.  
> On a box with 4G or more you need PAE anyway...
> 
> I'm wondering if ioremap or set_fixmap could be modified to take
> a page frame number or possibly a token like the dma mapping functions
> so we don't need all of the low bits and can actually solve these
> problems on a 32bit architecture.

The interface I'd actually like to see drivers using is
	unsigned long addr = map_resource(struct resource *res);

which would probably be implemented something like:

static inline unsigned long map_resource(struct resource *res)
{
	ioremap(res->start, res->end - res->start + 1);
}

on 64-bit architectures.  32-bit architectures would need more though.
vm_struct uses 'unsigned long' to represent the phys_addr.  Can we get
away with changing phys_addr to phys_pagenr?  That should allow 32-bit
arches to implement ioremap64().

Note I don't intend to do this work -- 64-bit BARs work fine on ia64 ;-)

> The first draft of the patch had a u64 there.  So I think we should
> at least check to ensure the high half is zero.  If it the high half
> is not zero we can print an annoying error message.  All of the normal
> pci capabilities are still limited to being in the first 256 bytes of
> the configuration space.  So not a lot is lost if we can't enable the
> entire 4K. 

Yes, I think that's a reasonable thing to do until an ioremap64 exists.

> There is also one piece I did not see the PCI Express configuration
> space for the root complex.  This is a configuration space with no pci
> bus/dev/fn numbers, if my memory serves me correctly.

Your memory is correct.  The spec says:

   System firmware communicates the base address of the RCRB for each Root
   Port to the operating system. Multiple Root Ports may be associated
   with the same RCRB. The RCRB memory-mapped registers must not reside
   in the same address space as the memory-mapped configuration space.

(RCRB == Root Complex Register Block)

I don't know how these systems intend to communicate the the base address.
Presumably this will also be part of ACPI 3.0.  Anyway, this is an
orthogonal issue from this patch which only aims to allow use of the
MMCONFIG space.

> On the interface side I also have the question how it will be
> described when there are multiple memory configuration spaces
> corresponding to disjoint pci configuration spaces.  I don't think
> we can easily support that in Linux at the moment but there is no
> reason why there can't be a table entry for it.

i386 doesn't support it but ia64, ppc and sparc do.  I presume each
domain will get its own MCFG space.  It won't be hard to support, but
there's no point in doing it until hardware exists.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
