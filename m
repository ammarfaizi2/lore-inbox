Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946640AbWJSW6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946640AbWJSW6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946641AbWJSW6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:58:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64981
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946640AbWJSW6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:58:43 -0400
Date: Thu, 19 Oct 2006 15:58:44 -0700 (PDT)
Message-Id: <20061019.155844.18310932.davem@davemloft.net>
To: jesse.barnes@intel.com
Cc: eiichiro.oiwa.nm@hitachi.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <200610191103.16689.jesse.barnes@intel.com>
References: <20061019.013732.30184567.davem@davemloft.net>
	<XNM1$9$0$4$$3$3$7$A$9002706U45374cd7@hitachi.com>
	<200610191103.16689.jesse.barnes@intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Barnes <jesse.barnes@intel.com>
Date: Thu, 19 Oct 2006 11:03:11 -0700

> On Thursday, October 19, 2006 3:01 am, eiichiro.oiwa.nm@hitachi.com 
> wrote:
> > >> If an expansion ROM exists on ATI Radeon or ATY128 card,
> > >> pci_map_rom returns the expansion ROM base address instead of
> > >> 0xC0000 because fixup_video checks the VGA Enable bit in the
> > >> Bridge Control register.
> > >
> > >It is not valid to expect the bridge control register to return
> > >anything meaningful on PCI "host bridge".  The Radeon card here sits
> > >on the root, just under the PCI Host Controller.  The code in
> > >fixup_video appears to assume that every bus up to the root from
> > >the VGA device is a PCI-PCI bridge, which is not a valid assumption.
> > >There can be a PCI host bridge at the root.
> >
> > Have you ever read the PCI-to-PCI Bridge Architecture Specification?
> > The default of VGA Enable bit is 0. This mean video ROM doesn't
> > forward system RAM at 0xC0000.
> >
> > There is your VGA card under 0001:00:00.0 Host bridge. The VGA Enable
> > bit in this host bridge will return 0 and IORESOURCE_ROM_SHADOW won't
> > set.
> 
> I don't think that applies to host->pci bridges though, all bets are off 
> as to how their bits are defined.

Yep, that's exactly what I was trying to say.

This is also why the rest of the kernel PCI code, and even things
like "lspci" from PCI utils do not print out the bridge control
register for host->pci bridges.  It's contents are %100 undefined
for host->pci bridges, yet this pci_fixup_video() code is testing
those bits without checking what kind of bridge it is looking at.

> One check that might make this feature a bit more robust is to look
> for a real PCI ROM on the device.  If present, we probably don't
> need to bother with the system copy (which probably won't be there
> anyway).
>
> We should probably also check whether the parent bridge of the device to 
> be fixed up is a real pci->pci bridge (if possible).  That would remove 
> some ambiguity that's likely to cause problems with other platforms 
> too.

At the core of this is the "definition" that 0xc0000 is a location in
physical RAM that the video ROM might be stored.  While this might
be a %100 valid definition on IA64, x86 and x86_64, it simply is not
on other platforms such as sparc64.

In fact even the existence of any RAM at all at that address is
not guarenteed.  I have a few systems where physical RAM starts
at some high physical address, such as 0x80000000.

Even if presence were guarenteed, you can't access this memory using
ioremap() and things like readl() and friends, which is exactly what
callers of pci_map_rom() are doing.  Accesses using readl() use
non-cacheable transactions which result in bus errors, and furthermore
the first argument to ioremap() is not a physical address, it's an
architecture-defined "address cookie" that must be setup by platforms
specific code.
