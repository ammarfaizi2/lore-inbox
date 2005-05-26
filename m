Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVEZJfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVEZJfD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 05:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVEZJfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 05:35:03 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:60871 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261239AbVEZJe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 05:34:58 -0400
Date: Thu, 26 May 2005 13:34:44 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andi Kleen <ak@suse.de>, len.brown@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net, gregkh@suse.de
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Message-ID: <20050526133444.A14184@jurassic.park.msu.ru>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com> <20050524120527.GB15326@wotan.suse.de> <20050524185856.A7639@jurassic.park.msu.ru> <20050524084533.A20567@unix-os.sc.intel.com> <20050524205855.A8367@jurassic.park.msu.ru> <20050524103724.A22049@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050524103724.A22049@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Tue, May 24, 2005 at 10:37:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 10:37:25AM -0700, Rajesh Shah wrote:
> For the transparent p2p bridge problem you mentioned, wouldn't you
> be dealing with p2p bridges, and therefore expect the pci_bus
> resource pointers to point to the corresponding pci_dev resources?

The problem is that for subtractive decode bridges we assume
full "transparency" and completely ignore standard p2p bridge
resources (i.e. windows) just using first 3 parent bus pointers
whatever they are.
This model does work in most cases, but there are potential problems
with peer-to-peer DMA behind such bridges, poor performance for MMIO
ranges outside bridge windows, prefetchable vs. non-prefetchable issues
and so on.

If we had 6 or more resource pointers in struct pci_bus, then the
appended patch would fix that.

> Or are you proposing to decouple pci_bus resource pointers from 
> pci_dev completely?

Actually no. Low-level bridge drivers (p2p, cardbus or particular
host bridge) certainly know about resource layout of the respective
device. But generic resource management code doesn't make any
assumptions about that and looks only at resource types.

> From quick code inspection, that seems to be
> not too much trouble to increase from 4 then.

No trouble at all, I guess.

Ivan.

--- linux/drivers/pci/probe.c.orig	Sat May  7 09:20:31 2005
+++ linux/drivers/pci/probe.c	Wed May 25 18:31:34 2005
@@ -239,9 +239,8 @@ void __devinit pci_read_bridge_bases(str
 
 	if (dev->transparent) {
 		printk(KERN_INFO "PCI: Transparent bridge - %s\n", pci_name(dev));
-		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i];
-		return;
+		for(i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
+			child->resource[i] = child->parent->resource[i - 3];
 	}
 
 	for(i=0; i<3; i++)
