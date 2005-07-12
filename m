Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVGLNng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVGLNng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVGLNmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:42:09 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:35238 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261444AbVGLNln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:41:43 -0400
Date: Tue, 12 Jul 2005 17:41:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: teanropo@cc.jyu.fi, gregkh@suse.de, jonsmirl@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Re: 2.6.13-rc2 hangs at boot
Message-ID: <20050712174119.A31613@jurassic.park.msu.ru>
References: <200507081354.j68Ds02b020296@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200507081354.j68Ds02b020296@harpo.it.uu.se>; from mikpe@csd.uu.se on Fri, Jul 08, 2005 at 03:54:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 03:54:00PM +0200, Mikael Pettersson wrote:
> Same here: 2.6.13-rc2 vanilla and 2.6.13-rc2 + patch #2 above both hang,
> but 2.6.13-rc2 + patch #1 boots fine.

I suspect that those larger (4K) cardbus IO windows are clashing with
some legacy IO ports. If so, this could be avoided by setting ISAEN
bridge control bit.
It would be interesting to see whether the patch below works or not...

Ivan.

--- 2.6.13-rc2-git4/drivers/pci/setup-bus.c	Tue Jul 12 16:11:19 2005
+++ linux/drivers/pci/setup-bus.c	Tue Jul 12 16:43:33 2005
@@ -88,6 +88,7 @@ pci_setup_cardbus(struct pci_bus *bus)
 {
 	struct pci_dev *bridge = bus->self;
 	struct pci_bus_region region;
+	u16 ctrl;
 
 	printk("PCI: Bus %d, cardbus bridge: %s\n",
 		bus->number, pci_name(bridge));
@@ -135,6 +136,12 @@ pci_setup_cardbus(struct pci_bus *bus)
 		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_1,
 					region.end);
 	}
+
+	/* Disable legacy ISA IO port forwarding, as we do
+	   for PCI-to-PCI bridges. */
+	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
+	ctrl |= PCI_CB_BRIDGE_CTL_ISA;
+	pci_write_config_word(bridge, PCI_CB_BRIDGE_CONTROL, ctrl);
 }
 
 /* Initialize bridges with base/limit values we have collected.
