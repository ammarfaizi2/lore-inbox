Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269773AbUICTdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269773AbUICTdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269792AbUICTdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:33:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269786AbUICTcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:32:07 -0400
Date: Fri, 3 Sep 2004 20:32:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, pcihpd-discuss@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] ia64 misc fixes [2/5]
Message-ID: <20040903193203.GQ642@parcelfarce.linux.theplanet.co.uk>
References: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some miscellaneous fixes:

 - flags can be a simple assignment since the resource is newly created
 - Zero the allocated memory for the PCI windows
 - pcibios_fixup_device_resources is called from pcibios_fixup_bus which
   is __devinit, so it cannot be __init.
 - pci_claim_resource is called from pcibios_fixup_device_resources so must
   also be __devinit.

diff -urpNX build-tools/dontdiff linux-2.6/arch/ia64/pci/pci.c hotplug-2.6/arch/ia64/pci/pci.c
--- linux-2.6/arch/ia64/pci/pci.c	2004-07-20 16:05:26.000000000 -0600
+++ hotplug-2.6/arch/ia64/pci/pci.c	2004-09-02 13:10:03.000000000 -0600
@@ -272,7 +272,7 @@ add_window (struct acpi_resource *res, v
 			return AE_OK;
 
 		window = &info->controller->window[info->controller->windows++];
-		window->resource.flags |= flags;
+		window->resource.flags  = flags;
 		window->resource.start  = addr.min_address_range;
 		window->resource.end    = addr.max_address_range;
 		window->offset		= offset;
@@ -305,6 +305,7 @@ pci_acpi_scan_root (struct acpi_device *
 	controller->window = kmalloc(sizeof(*controller->window) * windows, GFP_KERNEL);
 	if (!controller->window)
 		goto out2;
+	memset(controller->window, 0, sizeof(*controller->window) * windows);
 
 	name = kmalloc(16, GFP_KERNEL);
 	if (!name)
@@ -325,7 +326,7 @@ out1:
 	return NULL;
 }
 
-void __init
+void __devinit
 pcibios_fixup_device_resources (struct pci_dev *dev, struct pci_bus *bus)
 {
 	struct pci_controller *controller = PCI_CONTROLLER(dev);
diff -urpNX build-tools/dontdiff linux-2.6/drivers/pci/setup-res.c hotplug-2.6/drivers/pci/setup-res.c
--- linux-2.6/drivers/pci/setup-res.c	2004-03-20 13:29:41.000000000 -0700
+++ hotplug-2.6/drivers/pci/setup-res.c	2004-09-02 08:07:37.000000000 -0600
@@ -90,7 +90,7 @@ pci_update_resource(struct pci_dev *dev,
 		new & ~PCI_REGION_FLAG_MASK));
 }
 
-int __init
+int __devinit
 pci_claim_resource(struct pci_dev *dev, int resource)
 {
 	struct resource *res = &dev->resource[resource];

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
