Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWFPDDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWFPDDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 23:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWFPDDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 23:03:42 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:47255 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750833AbWFPDDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 23:03:42 -0400
Date: Thu, 15 Jun 2006 23:00:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-rc6 does not boot on HP dc7600u - MCFG area is not
  E820-reserved
To: Barry Scott <barry.scott@onelan.co.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606152301_MC3-1-C28E-ADE1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44915098.3070404@onelan.co.uk>

On Thu, 15 Jun 2006 13:20:40, Barry Scott wrote:

> I'm trying to boot 2.6.17-rc6 with Mismatched section patches applied.
> 
> On my HP dc7600U the last messages printed are:
> 
> PCI: BUIS Bug: MCFG area is not E820-reserved
> PCI: Not using MMCONFIG

I posted this today.  Please test.  It is less picky and will print
the address of the MMCONFIG area if it fails.

--- 2.6.17-rc6-64.orig/arch/i386/pci/mmconfig.c
+++ 2.6.17-rc6-64/arch/i386/pci/mmconfig.c
@@ -15,7 +15,9 @@
 #include <asm/e820.h>
 #include "pci.h"
 
-#define MMCONFIG_APER_SIZE (256*1024*1024)
+/* aperture is up to 256MB but BIOS may reserve less */
+#define MMCONFIG_APER_MIN	(2 * 1024*1024)
+#define MMCONFIG_APER_MAX	(256 * 1024*1024)
 
 /* Assume systems with more busses have correct MCFG */
 #define MAX_CHECK_BUS 16
@@ -197,9 +199,10 @@ void __init pci_mmcfg_init(void)
 		return;
 
 	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
+			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
+		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+				pci_mmcfg_config[0].base_address);
 		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
 		return;
 	}
--- 2.6.17-rc6-64.orig/arch/x86_64/pci/mmconfig.c
+++ 2.6.17-rc6-64/arch/x86_64/pci/mmconfig.c
@@ -13,7 +13,10 @@
 
 #include "pci.h"
 
-#define MMCONFIG_APER_SIZE (256*1024*1024)
+/* aperture is up to 256MB but BIOS may reserve less */
+#define MMCONFIG_APER_MIN	(2 * 1024*1024)
+#define MMCONFIG_APER_MAX	(256 * 1024*1024)
+
 /* Verify the first 16 busses. We assume that systems with more busses
    get MCFG right. */
 #define MAX_CHECK_BUS 16
@@ -175,9 +178,10 @@ void __init pci_mmcfg_init(void)
 		return;
 
 	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
+			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
+		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+				pci_mmcfg_config[0].base_address);
 		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
 		return;
 	}
@@ -190,7 +194,8 @@ void __init pci_mmcfg_init(void)
 	}
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
 		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
-		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
+		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
+							 MMCONFIG_APER_MAX);
 		if (!pci_mmcfg_virt[i].virt) {
 			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);
-- 
Chuck
