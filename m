Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVF1GSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVF1GSC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVF1GRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:17:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:38380 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261907AbVF1Fdy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:54 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Make pcibios_fixup_bus() hot-plug safe
In-Reply-To: <11199367711516@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:51 -0700
Message-Id: <11199367713428@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Make pcibios_fixup_bus() hot-plug safe

PCI scan code calls the arch specific pcibios_fixup_bus() each time it scans a
new bridge.  For root bridge hot-plug, the bridge and it's attached devices
may not have been configured properly yet, so it's not safe to claim those
resources at this time.

This code goes away when we clean up the way pci resources are claimed (in
pci_enable_device()), so this is only a stopgap fix.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 71c3511c22e8e0648094672abec898b3bf84c18b
tree e85aa826d22c53f7ecb5c040fc0d242c8576a8a2
parent fab3fb0ac8c83072465b28ca859c420da6c6511c
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:46 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:39 -0700

 arch/ia64/pci/pci.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -373,6 +373,25 @@ void pcibios_bus_to_resource(struct pci_
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
@@ -386,7 +405,8 @@ static void __devinit pcibios_fixup_devi
 		region.start = dev->resource[i].start;
 		region.end = dev->resource[i].end;
 		pcibios_bus_to_resource(dev, &dev->resource[i], &region);
-		pci_claim_resource(dev, i);
+		if ((is_valid_resource(dev, i)))
+			pci_claim_resource(dev, i);
 	}
 }
 

