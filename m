Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbULNU4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbULNU4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbULNU4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:56:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35727 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261659AbULNU4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:56:30 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ROM enable/disable in r128 and radeon fb drivers
Date: Tue, 14 Dec 2004 12:56:20 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1N1vBT1vb/LsflZ"
Message-Id: <200412141256.21143.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_1N1vBT1vb/LsflZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

My mail to the maintainer bounced, but these should be safe for everybody.  
Both the r128 and radeon fb drivers do bad things with the PCI BAR 
corresponding to their option ROM.  They incorrectly use the host address 
instead of the BAR address to enable the ROM, and then incorrectly lose the 
original value on unmap.  This patch fixes both problems.  Tested on Altix.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_1N1vBT1vb/LsflZ
Content-Type: text/plain;
  charset="us-ascii";
  name="aty-rom-enable-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aty-rom-enable-fixes.patch"

===== drivers/video/aty/aty128fb.c 1.52 vs edited =====
--- 1.52/drivers/video/aty/aty128fb.c	2004-11-12 11:40:39 -08:00
+++ edited/drivers/video/aty/aty128fb.c	2004-12-13 15:13:55 -08:00
@@ -791,6 +791,7 @@
 static void __init aty128_unmap_ROM(struct pci_dev *dev, void __iomem * rom)
 {
 	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
+	u32 val;
 	
 	iounmap(rom);
 	
@@ -801,8 +802,9 @@
 		r->end -= r->start;
 		r->start = 0;
 	}
-	/* This will disable and set address to unassigned */
-	pci_write_config_dword(dev, dev->rom_base_reg, 0);
+	/* This will disable it again */
+	pci_read_config_dword(dev, dev->rom_base_reg, &val);
+	pci_write_config_dword(dev, dev->rom_base_reg, val & ~PCI_ROM_ADDRESS_ENABLE);
 }
 
 
@@ -830,8 +832,10 @@
 	
 	/* enable if needed */
 	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
+		u32 val;
+		pci_read_config_dword(dev, dev->rom_base_reg, &val);
 		pci_write_config_dword(dev, dev->rom_base_reg,
-				       r->start | PCI_ROM_ADDRESS_ENABLE);
+				       val | PCI_ROM_ADDRESS_ENABLE);
 		r->flags |= PCI_ROM_ADDRESS_ENABLE;
 	}
 	
===== drivers/video/aty/radeon_base.c 1.35 vs edited =====
--- 1.35/drivers/video/aty/radeon_base.c	2004-11-11 00:39:04 -08:00
+++ edited/drivers/video/aty/radeon_base.c	2004-12-13 15:11:56 -08:00
@@ -265,6 +265,7 @@
 {
 	// leave it disabled and unassigned
 	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
+	u32 val;
 	
 	if (!rinfo->bios_seg)
 		return;
@@ -277,8 +278,9 @@
 		r->end -= r->start;
 		r->start = 0;
 	}
-	/* This will disable and set address to unassigned */
-	pci_write_config_dword(dev, dev->rom_base_reg, 0);
+	/* This will disable it again */
+	pci_read_config_dword(dev, dev->rom_base_reg, &val);
+	pci_write_config_dword(dev, dev->rom_base_reg, val & ~PCI_ROM_ADDRESS_ENABLE);
 }
 
 static int __devinit radeon_map_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
@@ -310,8 +312,10 @@
 	
 	/* enable if needed */
 	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
+		u32 val;
+		pci_read_config_dword(dev, dev->rom_base_reg, &val);
 		pci_write_config_dword(dev, dev->rom_base_reg,
-				       r->start | PCI_ROM_ADDRESS_ENABLE);
+				       val | PCI_ROM_ADDRESS_ENABLE);
 		r->flags |= PCI_ROM_ADDRESS_ENABLE;
 	}
 	

--Boundary-00=_1N1vBT1vb/LsflZ--
