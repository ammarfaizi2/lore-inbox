Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVKADdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVKADdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVKADdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:33:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:58521 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964977AbVKADdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:33:42 -0500
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do
	usb-handoff" breaks my powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200510311909.32694.david-b@pacbell.net>
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com>
	 <200510311741.56638.david-b@pacbell.net>
	 <1130812903.29054.408.camel@gaston>
	 <200510311909.32694.david-b@pacbell.net>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:30:35 +1100
Message-Id: <1130815836.29054.420.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 19:09 -0800, David Brownell wrote:
> On Monday 31 October 2005 6:41 pm, Benjamin Herrenschmidt wrote:
> > 
> > > No PCI quirk code has ever called pci_enable_device() AFAICT.
> > 
> > Most PCI quirks only do config space accesses
> 
> Some do I/O space access.  Few do memory space access (ioremap_nocache).

The IO accesses probably work fine for some legacy stuff where the ISA
space is actually available, but they are broken if they don't check for
availability, same goes for memory space access.

Damn, those quirks should really be either more careful or be made
platform specific if they are x86 junk workarounds.

> > > Of course the _need_ to do such a thing might be another PPC-specific
> > > (or OpenFirmware-specific?) PCI thing ... we've hit other cases where
> > > PPC breaks things that work on other PCI systems (and vice versa).
> > 
> > "ppc" doens't do anything fancy that other archs don't do too, please
> > stop with your "ppc specific" thing all over the place.
> 
> When the only problem reports come from PPC hardware, it sure looks
> PPC-specific to me

Bla bla bla bla... can you stop the crackpipe please ?

>  If such issues get reported on non-PPC hardware
> (with those unique-to-ppc changes to PCI enumeration) then I'll stop
> thinking of it as PPC-specific.  Until then ... ;)

I prefer not replying...

> > It is illegal, whatever the platform is, to tap a PCI device MMIO like
> > that without calling pci_enable_device(), requesting resources etc... or
> > at the very least, testing if MMIO decoding is enabled on the chip.
> > Period. It has nothing to do with PPC and all to do with correctness.
> 
> I could easily believe that all that quirk code has been buggy since
> day one, yes.

Probably. Hopefully, it usually is specifically targeted to chpisets
that often exist only on x86 where they happen to work. Your USB quirk
happen to be broad enough to affect pretty much any platform with USB in
it, and thus the brokenness appears more widely.

>   Certainly it's always had bugs in how it dealt with the
> USB functionality; so why shouldn't it have bugs in how it deals with
> the PCI functionality too?  Even if it was being maintained by the
> PCI maintainers!

More bla bla bla ...

> > What _That_ code is doing in the quirks... shouldn't it be in the
> > {U,O,E}HCI drivers instead ?
> 
> Not for PCI.  Vojtech, this is your cue to explain some of how late handoff
> borks the input layer, as observed by SuSE on way too many BIOS/hardware combos
> for me to remember ... :)

Well, at the _very_ least then read the PCI command register and check
that memory access is enabled before going to your quirk.

> Actually any "sophisticated" boot loader nowadays will know something
> about USB, to handle keyboards, mice, or maybe boot disks.  (Didn't I
> just write that?)  On some platforms, u-Boot understands OHCI ... so that's
> not just x86 BIOS or other closed-source firmware.  (Though to be sure,
> that u-Boot code acts more like Linux 2.4 than anything else; it doesn't
> follow the standard firmare-uses-USB rules.)  And I sure thought some of
> the OpenFirmware systems had USB support too.  (Written in FORTH?)

Yes, it has, and it properly shuts things down before calling the
operating system, thus doesn't require those "handoff" hacks.

Ben.


