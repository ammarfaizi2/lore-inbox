Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbUKJV5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUKJV5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbUKJV5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:57:20 -0500
Received: from fmr06.intel.com ([134.134.136.7]:14515 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262044AbUKJV5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:57:16 -0500
Date: Wed, 10 Nov 2004 14:20:23 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200411102220.iAAMKNx7030359@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] pci-mmconfig fix for 2.6.9
Cc: ak@suse.de, akpm@osdl.org, greg@kroah.com,
       sundarapandian.durairaj@intel.com, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here I have attached pci mmconfig fix for 2.6.9 kernel. 

This will fix the flush error in pci_mmcfg_write.

When pci_mmcfg_write is used to program the PMCSR in the Power
Management Capability structure of PCI config space in the PCI Express
device to a different power state, the dummy readl to flush the previous
write violates the transition delay specified in the PCI power
management spec. Please see PCI Power Management Spec. 1.2 Table 5-6.
For example, while changing the power state of the device through PMCSR
register, a transition delay of 10msec is required before any access can
be made to the device.

Since the configuration write access for PCI Express is non posted,
flushing is not necessary and  it will be safe to remove the dummy
readl. 

This patch will remove dummy readl function implemented in
"pci_mmcfg_write" and use set_fixmap_nocahe instead of set_fixmap.

Signed-off-by: Sundarapandian Durairaj <sundarapandian.duraijai@intel.com>
Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------------------
diff -urpN linux-2.6.9/arch/i386/pci/mmconfig.c linux-2.6.9-mmconfig-patch/arch/i386/pci/mmconfig.c
--- linux-2.6.9/arch/i386/pci/mmconfig.c	2004-10-18 17:54:38.000000000 -0400
+++ linux-2.6.9-mmconfig-patch/arch/i386/pci/mmconfig.c	2004-11-10 13:36:29.287713784 -0500
@@ -30,7 +30,7 @@ static inline void pci_exp_set_dev_base(
 	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn << 12);
 	if (dev_base != mmcfg_last_accessed_device) {
 		mmcfg_last_accessed_device = dev_base;
-		set_fixmap(FIX_PCIE_MCFG, dev_base);
+		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
 	}
 }
 
@@ -85,9 +85,6 @@ static int pci_mmcfg_write(int seg, int 
 		break;
 	}
 
-	/* Dummy read to flush PCI write */
-	readl(mmcfg_virt_addr);
-
 	spin_unlock_irqrestore(&pci_config_lock, flags);
 
 	return 0;
diff -urpN linux-2.6.9/arch/x86_64/pci/mmconfig.c linux-2.6.9-mmconfig-patch/arch/x86_64/pci/mmconfig.c
--- linux-2.6.9/arch/x86_64/pci/mmconfig.c	2004-10-18 17:53:41.000000000 -0400
+++ linux-2.6.9-mmconfig-patch/arch/x86_64/pci/mmconfig.c	2004-11-10 13:37:49.585506664 -0500
@@ -63,9 +63,6 @@ static int pci_mmcfg_write(int seg, int 
 		break;
 	}
 
-	/* Dummy read to flush PCI write */
-	readl(addr);
-
 	return 0;
 }
 
