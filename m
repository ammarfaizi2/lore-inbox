Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVCRWDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVCRWDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCRWDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:03:44 -0500
Received: from fmr24.intel.com ([143.183.121.16]:7831 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261911AbVCRWCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:02:46 -0500
Date: Fri, 18 Mar 2005 14:02:27 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [patch 03/12] Make pcibios_fixup_bus() hot-plug safe
Message-ID: <20050318140227.C1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI scan code calls the arch specific pcibios_fixup_bus() each
time it scans a new bridge. For root bridge hot-plug, the bridge
and it's attached devices may not have been configured properly
yet, so it's not safe to claim those resources at this time.

This code goes away when we clean up the way pci resources are
claimed (in pci_enable_device()), so this is only a stopgap fix.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/arch/ia64/pci/pci.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletion(-)

diff -puN arch/ia64/pci/pci.c~ia64-pcibios_fixup_bus-hotplug-safe arch/ia64/pci/pci.c
--- linux-2.6.11-mm4-iohp/arch/ia64/pci/pci.c~ia64-pcibios_fixup_bus-hotplug-safe	2005-03-16 13:07:06.343101214 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/arch/ia64/pci/pci.c	2005-03-16 13:07:06.450523088 -0800
@@ -391,6 +391,25 @@ void pcibios_bus_to_resource(struct pci_
 	res->end = region->end + offset;
 }
 
+static int __devinit is_valid_resource(struct pci_dev *dev, int idx)
+{
+	unsigned int i, type_mask = IORESOURCE_IO | IORESOURCE_MEM;
+	struct resource *devr = &dev->resource[idx];
+
+	if (!dev->bus)
+		return 0;
+	for (i=0; i<PCI_BUS_NUM_RESOURCES; i++) {
+		struct resource *busr = dev->bus->resource[i];
+
+		if (!busr || ((busr->flags ^ devr->flags) & type_mask))
+			continue;
+		if ((devr->start) && (devr->start >= busr->start) &&
+				(devr->end <= busr->end))
+			return 1;
+	}
+	return 0;
+}
+
 static void __devinit pcibios_fixup_device_resources(struct pci_dev *dev)
 {
 	struct pci_bus_region region;
@@ -404,7 +423,8 @@ static void __devinit pcibios_fixup_devi
 		region.start = dev->resource[i].start;
 		region.end = dev->resource[i].end;
 		pcibios_bus_to_resource(dev, &dev->resource[i], &region);
-		pci_claim_resource(dev, i);
+		if ((is_valid_resource(dev, i)))
+			pci_claim_resource(dev, i);
 	}
 }
 
_
