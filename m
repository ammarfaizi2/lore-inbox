Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbUBAVmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbUBAVmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:42:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24912 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265470AbUBAVmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:42:39 -0500
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
	<m1y8rmvell.fsf@ebiederm.dsl.xmission.com>
	<20040201201103.GW18725@parcelfarce.linux.theplanet.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Feb 2004 14:35:02 -0700
In-Reply-To: <20040201201103.GW18725@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m1u12av5yx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> On Sun, Feb 01, 2004 at 11:28:38AM -0700, Eric W. Biederman wrote:
> > I suspect the check for addresses being an address being too big
> > would be useful even on 64bit architectures.  I just looked
> > and ia64 does not have that check and bad BARs could cause
> > interesting problems.  It makes sense to catch illegal bar values
> > earlier, but this whole part of the code is a slow path so putting in
> > a sanity check should not hurt anything.
> 
> Hard to say since ia64 boxes don't usually have BIOSes written by people
> on minimum wage.  It certainly wouldn't hurt to check though.

An uninitialized BAR could have the same effect and it is easier to
trigger.  ia64 boxes get so little volume you can miss things.  I
killed an ia64 box once by changing the serial console baud rate.

I have no problem with firmware it is just that since it must be
written on a per board basis, and firmware is hard to update you
simply can't assume it is correct.  Some little bug may have gotten
through the QA checks.  Hardware has similar pressures except it
is even harder to correct.

So the concern is just healthy programmer paranoia.  If it can
go wrong it will.

> > I think we want an ioremap_pfn instead of an ioremap64.  On 64bit
> > platforms ioremap64 is just ioremap so it is redundant.  On 32bit
> > platforms ioremap64 is really ioremap_pfn with just a different
> > wrapper around it.  While ioremap_pfn makes sense on all
> > architectures.  
> 
> Yeah, but it doesn't make sense to driver writers.  They have a hard
> enough time dealing with scatterlists.  Heck, I don't even know what
> pfn stands for.  So I'm all for having ioremap_pfn() as the base function,
> as long as we still have ioremap(), ioremap64() and map_resource() as
> wrappers around it.

pfn is short for page frame number.  It is the abbreviation that is used
by the kernel vm layer for a page number.  And it is a term that at
least to be used quite a lot in texts explaining virtual memory and
paging.  

If you have a map_resource I don't know why you would need ioremap64.
But I have no problems with wrappers.  The question mostly is which
function is architecture specific and which can be generic.

If I was not in the middle of moving out of my current apartment
hunting I think I would whip up a patch.
 
> > Could the patch be updated to do that please?
> 
> Yup, not hard.  Patch below.

Thanks for the updated patch.
 
> Actually, it's not relevant for ia64 because ia64 accesses PCI config
> space through SAL.  I did a patch for ia64 and posted it to the list
> last week (SAL was revised to allow for the larger address space).
> It's part of the below patch.

Ok it is nice to see the support getting there.

The table entry should be just as relevant on ia64.  It is odd
though that on ia64 the firmware interface is updated and on x86 a
firmware bypass interface is added.

Eric


