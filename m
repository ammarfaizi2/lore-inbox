Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbULJAVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbULJAVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 19:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbULJAVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 19:21:11 -0500
Received: from alg145.algor.co.uk ([62.254.210.145]:34566 "EHLO
	dmz.algor.co.uk") by vger.kernel.org with ESMTP id S261568AbULJAVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 19:21:02 -0500
Date: Fri, 10 Dec 2004 00:20:40 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Greg Kroah-Hartman <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, Chris Dearman <chris@mips.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] Don't touch BARs of host bridges
Message-ID: <Pine.LNX.4.61.0412092349560.6535@perivale.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.748,
	required 4, AWL, BAYES_00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 BARs of host bridges often have special meaning and AFAIK are best left 
to be setup by the firmware or system-specific startup code and kept 
intact by the generic resource handler.  For example a couple of host 
bridges used for MIPS processors interpret BARs as target-mode decoders 
for accessing host memory by PCI masters (which is quite reasonable).  
For them it's desirable to keep their decoded address range overlapping 
with the host RAM for simplicity if nothing else (I can imagine running 
out of address space with lots of memory and 32-bit PCI with no DAC 
support in the participating devices).

 This is already the case with the i386 and ppc platform-specific PCI 
resource allocators.  Please consider the following change for the generic 
allocator.  Currently we have a pile of hacks implemented for host bridges 
to be left untouched and I'd be pleased to remove them.

  Maciej

patch-mips-2.6.10-rc2-20041124-pci-hb-0
diff -up --recursive --new-file linux-mips-2.6.10-rc2-20041124.macro/drivers/pci/setup-bus.c linux-mips-2.6.10-rc2-20041124/drivers/pci/setup-bus.c
--- linux-mips-2.6.10-rc2-20041124.macro/drivers/pci/setup-bus.c	2004-11-12 13:12:47.000000000 +0000
+++ linux-mips-2.6.10-rc2-20041124/drivers/pci/setup-bus.c	2004-12-08 13:32:06.000000000 +0000
@@ -57,8 +57,13 @@ pbus_assign_resources_sorted(struct pci_
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
 
-		if (class == PCI_CLASS_DISPLAY_VGA
-				|| class == PCI_CLASS_NOT_DEFINED_VGA)
+		/* Don't touch classless devices and host bridges.  */
+		if (class == PCI_CLASS_NOT_DEFINED ||
+		    class == PCI_CLASS_BRIDGE_HOST)
+			continue;
+
+		if (class == PCI_CLASS_DISPLAY_VGA ||
+		    class == PCI_CLASS_NOT_DEFINED_VGA)
 			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
 
 		pdev_sort_resources(dev, &head);
