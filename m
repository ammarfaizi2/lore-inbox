Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUBALH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 06:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUBALHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 06:07:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1103 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265267AbUBALHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 06:07:44 -0500
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Feb 2004 04:00:01 -0700
In-Reply-To: <20040201051021.GO18725@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m1brojvzda.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> On Sat, Jan 31, 2004 at 02:57:29PM -0700, Eric W. Biederman wrote:
> > Is it really safe to treat the base address as a u32?  I know
> > if I was doing the BIOS and that address was tied to a 32bit BAR I
> > would be extremely tempted to put those 256M of address space above
> > 4G.  Putting something like that below 4G leads to 1/2 Gig of memory
> > missing. 
> 
> This is actually a Linux limitation -- we're pretty bad at dealing with
> 64-bit BARs on 32-bit architectures.  There's two interfaces to get
> at it -- ioremap() and set_fixmap().  Both of these interfaces take an
> unsigned long to describe a physical address.

Which is another issue besides PCI express.  This 32bit VM on a 64bit
box I find quite annoying.  Now that there are 64bit x86 alternatives
I won't be shy about using 64bit addresses in BARs, if I need them.  
On a box with 4G or more you need PAE anyway...

I'm wondering if ioremap or set_fixmap could be modified to take
a page frame number or possibly a token like the dma mapping functions
so we don't need all of the low bits and can actually solve these
problems on a 32bit architecture.

> > Point being I don't think it is safe to assume the BIOS always puts
> > the extended PCI configuration space below 4G.
> 
> MCFG isn't described in any released version of the ACPI spec, so I
> don't know whether it's even possible for it to be a 64-bit address.
> There's a reserved field that might be used for the upper 32 bits.

The first draft of the patch had a u64 there.  So I think we should
at least check to ensure the high half is zero.  If it the high half
is not zero we can print an annoying error message.  All of the normal
pci capabilities are still limited to being in the first 256 bytes of
the configuration space.  So not a lot is lost if we can't enable the
entire 4K. 

There is also one piece I did not see the PCI Express configuration
space for the root complex.  This is a configuration space with no pci
bus/dev/fn numbers, if my memory serves me correctly.

On the interface side I also have the question how it will be
described when there are multiple memory configuration spaces
corresponding to disjoint pci configuration spaces.  I don't think
we can easily support that in Linux at the moment but there is no
reason why there can't be a table entry for it.

Eric
