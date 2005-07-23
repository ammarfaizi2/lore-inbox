Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVGWULk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVGWULk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 16:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVGWULk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 16:11:40 -0400
Received: from isilmar.linta.de ([213.239.214.66]:44524 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261652AbVGWULj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 16:11:39 -0400
Date: Sat, 23 Jul 2005 21:54:11 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: akpm@osdl.org, greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pcibios_bus_to_resource for parisc [Was: Re: [PATCH 8/8] pci and yenta: pcibios_bus_to_resource]
Message-ID: <20050723195411.GC11065@dominikbrodowski.de>
Mail-Followup-To: Grant Grundler <grundler@parisc-linux.org>,
	akpm@osdl.org, greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20050711222138.GH30827@isilmar.linta.de> <20050718194216.GC11016@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050718194216.GC11016@colo.lackof.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2005 at 01:42:16PM -0600, Grant Grundler wrote:
> On Tue, Jul 12, 2005 at 12:21:38AM +0200, Dominik Brodowski wrote:
> > In yenta_socket, we default to using the resource setting of the CardBus
> > bridge. However, this is a PCI-bus-centric view of resources and thus
> > needs to be converted to generic resources first. Therefore, add a call
> > to pcibios_bus_to_resource() call in between. This function is a mere
> > wrapper on x86 and friends, however on some others it already exists, is
> > added in this patch (alpha, arm, ppc, ppc64) or still needs to be 
> > provided (parisc -- where is its pcibios_resource_to_bus() ?).
> 
> in arch/parisc/kernel/pci.c?
> At least, it seems to be present in the 2.6.13-rc1 tree
> on cvs.parisc-linux.org tree.

Oh, yes, I seem to have missed it. Sorry. Does this patch look good?


Add pcibios_bus_to_resource for parisc.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: 2.6.13-rc3-git2/arch/parisc/kernel/pci.c
===================================================================
--- 2.6.13-rc3-git2.orig/arch/parisc/kernel/pci.c
+++ 2.6.13-rc3-git2/arch/parisc/kernel/pci.c
@@ -255,8 +255,26 @@ void __devinit pcibios_resource_to_bus(s
 	pcibios_link_hba_resources(&hba->lmmio_space, bus->resource[1]);
 }
 
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			      struct pci_bus_region *region)
+{
+	struct pci_bus *bus = dev->bus;
+	struct pci_hba_data *hba = HBA_DATA(bus->bridge->platform_data);
+
+	if (res->flags & IORESOURCE_MEM) {
+		res->start = PCI_HOST_ADDR(hba, region->start);
+		res->end = PCI_HOST_ADDR(hba, region->end);
+	}
+
+	if (res->flags & IORESOURCE_IO) {
+		res->start = region->start;
+		res->end = region->end;
+	}
+}
+
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pcibios_resource_to_bus);
+EXPORT_SYMBOL(pcibios_bus_to_resource);
 #endif
 
 /*
