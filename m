Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbUKJR3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbUKJR3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUKJR3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:29:05 -0500
Received: from petasus.png.intel.com ([192.198.147.99]:61600 "EHLO
	petasus.png.intel.com") by vger.kernel.org with ESMTP
	id S262018AbUKJR27 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:28:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] pci-mmconfig fix for 2.6.9
Date: Wed, 10 Nov 2004 22:56:45 +0530
Message-ID: <FEB6C4E97F6CAF41978FB2059D545418B6BB6E@bgsmsx402.gar.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] pci-mmconfig fix for 2.6.9
Thread-Index: AcPvkOM4lrT6G+2LT7yQDSd/tSYCcDXrbccw
From: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
To: <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-kernel@vger.kernel.org>
Cc: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Michael Chan" <mchan@broadcom.com>,
       "Goswami, Pranjal" <pranjal.goswami@intel.com>,
       "Greg KH" <greg@kroah.com>, "Andrew Morton" <akpm@zip.com.au>,
       "Matthew Wilcox" <willy@debian.org>
X-OriginalArrivalTime: 10 Nov 2004 17:27:02.0073 (UTC) FILETIME=[7D871A90:01C4C74A]
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

Thanks,
Sundar

diff -Naur linux-2.6.9/arch/i386/pci/mmconfig.c
pcie-fix-linux-2.6.9/arch/i386/pci/mmconfig.c
--- linux-2.6.9/arch/i386/pci/mmconfig.c	2004-10-19
03:24:38.000000000 +0530
+++ pcie-fix-linux-2.6.9/arch/i386/pci/mmconfig.c	2004-11-04
11:35:36.029054848 +0530
@@ -30,7 +30,7 @@
 	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn <<
12);
 	if (dev_base != mmcfg_last_accessed_device) {
 		mmcfg_last_accessed_device = dev_base;
-		set_fixmap(FIX_PCIE_MCFG, dev_base);
+		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
 	}
 }
 
@@ -85,9 +85,6 @@
 		break;
 	}
 
-	/* Dummy read to flush PCI write */
-	readl(mmcfg_virt_addr);
-
 	spin_unlock_irqrestore(&pci_config_lock, flags);
 
 	return 0;
diff -Naur linux-2.6.9/arch/x86_64/pci/mmconfig.c
pcie-fix-linux-2.6.9/arch/x86_64/pci/mmconfig.c
--- linux-2.6.9/arch/x86_64/pci/mmconfig.c	2004-10-19
03:23:41.000000000 +0530
+++ pcie-fix-linux-2.6.9/arch/x86_64/pci/mmconfig.c	2004-11-04
11:39:21.989703608 +0530
@@ -63,9 +63,6 @@
 		break;
 	}
 
-	/* Dummy read to flush PCI write */
-	readl(addr);
-
 	return 0;
 }

