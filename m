Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUJNOmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUJNOmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUJNOmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:42:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59098 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265207AbUJNOjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:39:24 -0400
Date: Thu, 14 Oct 2004 15:39:24 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Introduce PCI <-> CPU address conversion [1/2]
Message-ID: <20041014143924.GP16153@parcelfarce.linux.theplanet.co.uk>
References: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk> <20041014182704.A13971@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014182704.A13971@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 06:27:04PM +0400, Ivan Kokshaysky wrote:
> On Thu, Oct 14, 2004 at 01:47:37PM +0100, Matthew Wilcox wrote:
> > Some machines have a different address space on the PCI bus from the
> > CPU's bus.  This is currently fixed up in pcibios_fixup_bus().  However,
> > this is not called for hotplug devices.  Calling pcibios_fixup_bus() when
> > a device is hotplugged onto a bus is also wrong as it would attempt to
> > fixup devices that have already been fixed up with potentially horrific
> > consequences.
> 
> This logic makes sense only if you have sort of firmware which
> properly initializes the hotplug devices

Yes, this is the case for the ACPI hotplug driver, for example.

> so I think that the fixup
> should belong in that particular hotplug driver (or architecture).

*sigh*.  Greg rejected a patch that did that.  He wanted it fixed
more generally.

> > This patch teaches the generic PCI layer that there may be different
> > address spaces, and converts from bus views to cpu views when reading
> > from BARs.  Some drivers (eg sym2, acpiphp) need to go back the other
> > way, so it also introduces the inverse operation.
> 
> This one already exists - pcibios_resource_to_bus().

I can't use it in the symbios driver because it only exists on alpha,
arm, mips, parisc, ppc, ppc64, sparc64 and v850.  It doesn't exist on
i386, ia64, x86_64, arm26, cris, h8300, m32r, sh, sh64 or sparc.

Perhaps from your point of view this patch makes more sense as a cleanup.
Rather than having all the duplicate code in all the architecture
pcibios_fixup_device and pcibios_resource_to_bus, they can implement
pci_bus_to_phys and pci_phys_to_bus.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
