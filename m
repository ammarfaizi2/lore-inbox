Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263161AbVGNVtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbVGNVtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbVGNVsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:48:14 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:43440 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263130AbVGNVoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:44:39 -0400
Date: Fri, 15 Jul 2005 01:44:36 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Jon Smirl <jonsmirl@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Message-ID: <20050715014436.A613@den.park.msu.ru>
References: <20050714155344.A27478@jurassic.park.msu.ru> <20050714145327.B7314@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050714145327.B7314@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Jul 14, 2005 at 02:53:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 02:53:27PM +0100, Russell King wrote:
> What happens when there is no firmware?

It shouldn't be a problem. These days we have a lot of arch hooks
in the PCI layer. I'd probably start with the following:

static void __init
pcibios_enable_p2p_vga_fwd(struct pci_dev *dev)
{
	u16 class = dev->class >> 8;
	struct pci_bus *b;

	if (class == PCI_CLASS_DISPLAY_VGA ||
	    class == PCI_CLASS_NOT_DEFINED_VGA) {
		for (b = dev->bus; b->parent; b = b->parent) {
			b->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
		}
	}
}

DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_enable_p2p_vga_fwd);

> I'm sure this code would not have been added had there not been a reason
> for it.  Do we know why it was added?

It was quite a few years ago, so I don't recall all details...
I think some old alphas cannot cope with VGA behind the p2p bridges.
But I also recall that this code was problematic on alpha with multiple
VGA cards.
Note that setup-bus code in 2.4 does more reasonable thing - it
enables VGA port forwarding *only* for the first (by PCI enumeration)
VGA device, and doesn't enable this for others (if any). Unlike 2.6 :-(

Ivan.
