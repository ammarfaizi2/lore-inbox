Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbSLDSRk>; Wed, 4 Dec 2002 13:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbSLDSRk>; Wed, 4 Dec 2002 13:17:40 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:32190 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP
	id <S267018AbSLDSRi>; Wed, 4 Dec 2002 13:17:38 -0500
Date: Wed, 4 Dec 2002 11:57:03 -0700
From: Matt Porter <porter@cox.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matt Porter <porter@cox.net>, Dave Hansen <haveblue@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64-bit struct resource fields
Message-ID: <20021204115703.A11734@home.com>
References: <3DE2AE04.5030209@us.ibm.com> <20021126094908.A23772@home.com> <m1vg2dxd0k.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1vg2dxd0k.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Dec 01, 2002 at 09:26:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 09:26:03PM -0700, Eric W. Biederman wrote:
> Matt Porter <porter@cox.net> writes:
> 
> > On Mon, Nov 25, 2002 at 03:11:00PM -0800, Dave Hansen wrote:
> > > We need some way to replicate the e820 tables for kexec.  This 
> > > modifies struct resource to use u64's for its start and end fields. 
> > > This way we can export the whole e820 table on PAE machines.
> > > 
> > > resource->flags seems to be used often to mask out things in 
> > > resource->start/end, so I think it needs to be u64 too.  But, Is it 
> > > all right to let things like pcibios_update_resource() truncate the 
> > > resource addresses like they do?
> > > 
> > > With my config, it has no more warnings than it did before.
> > 
> > I could make use of this on my PPC440 systems which have all I/O
> > (onboard and PCIX host bridge) above 4GB.  However, the patch
> > I have been playing with typedefs a phys_addr_t so that only
> > systems which are 32-bit/36-bit+ split like PAE ia32, AUxxxx (MIPS),
> > and PPC440 have to do long long manipulation.  If you explicitly
> > use u64 everywhere it forces all native 32-bit/32-bit systems to
> > do unnecessary long long manipulation.
> 
> Except for the fact that if you have a 32bit pci bus, you can
> plug in cards with 64bit bars.  And they can still legitimately do
> 64bit DAC to other pci cards.  It is a silly configuration, but
> possible.

Erm, ok.  Silly is right, but possible.
  
> > In the past there has been quite a bit of resistance to even
> > introducing a physical address typedef due to some claims of
> > gcc not handling long longs very well [1].  I don't see how
> > having _everybody_ that is 32-bit native handle long longs is
> > going to be more acceptable but I could be surprised.
> 
> The primary concern has been efficiency and I do believe there is
> anywhere the pci resource allocator is on the fast path, so that
> should not be a problem.
> 
> There are some rare bugs with 2.95.2 and kin with handling long longs
> but all it has been possible to reformulate the C code so it works
> in all cases where the bugs have been observed.
> 
> And beyond that it was Linus idea to bring the resource allocator to
> 64bits which tends to help.

Ok, good.  Then that should include bringing all related interfaces
to 64bits as well?  Like remap_page_range(), since we want to handle
this easily on bigphys systems with I/O above 4GB instead of some of
our current hacks.
 
> > That said, I think when we have existence of systems that require
> > long long types and gcc is "buggy" in this respect, then using
> > a phys_addr_t is the lesser of two evils (even though everybody hates
> > typedefs).  We already have this type defined local to PPC because
> > it is necessary to cleanly handle ioremap and local page mapping
> > functionality.  going to u64 or phys_addr_t resources would be a
> > huge improvement on a horribly kludgy hack we use to crate the
> > most significant 32-bits for our 64-bit ioremaps.
> 
> A phys_addr_t may be a sane idea, or in this case it would need to be
> a res_addr_t.

Sounds reasonable, I assume on some architectures that resources don't
map directly to physical addresses as DaveM once explained a resource
to merely be an ioremapable token (alpha?, sparc64?).  We'll need to
define a phys_addr_t to for the arguments to remap_page_range() but
this is a tangential to the original discussion...sounds like we need
both.

> I have written code that trips it up, but I believe the bugs have been
> fixed in recent compilers, and the bugs (not the inefficiencies) may
> be specific to a specific port.

Ok, the past discussions seemed to be implying the existence of horrible
bugs...sounds like gcc 3.x doesn't have these problems.  

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
