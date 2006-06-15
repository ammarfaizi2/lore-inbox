Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWFOIpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWFOIpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 04:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWFOIpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 04:45:22 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:13774 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751328AbWFOIpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 04:45:22 -0400
Date: Thu, 15 Jun 2006 04:41:52 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled
  because of e820
To: Andi Kleen <ak@suse.de>
Cc: Brice Goglin <brice@myri.com>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Message-ID: <200606150443_MC3-1-C283-D4F7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <p73ac8fqjix.fsf@verdi.suse.de>

On 15 Jun 2006 03:45:10 +0200, Andi Kleen wrote:

> Anyways I would say that if the BIOS can't get MCFG right then 
> it's likely not been validated on that board and shouldn't be used.

According to Petr Vandrovec:

 ... "What is important (and checked) is address of MMCONFIG reported by MCFG
 table...  Unfortunately code does not bother with printing that address :-(
 
 "Another problem is that code has hardcoded that MMCONFIG area is 256MB large. 
 Unfortunately for the code PCI specification allows any power of two between 2MB 
 and 256MB if vendor knows that such amount of busses (from 2 to 128) will be 
 sufficient for system.  With notebook it is quite possible that not full 8 bits 
 are implemented for MMCONFIG bus number."


So here is a patch.  Unfortunately my system still fails the test because
it doesn't reserve any part of the MMCONFIG area, but this may fix others.

Booted on x86_64, only compiled on i386.  x86_64 still remaps the max area
(256MB) even though only 2MB is checked... but 2.6.16 had no check at all
so it is still better.


PCI: reduce size of x86 MMCONFIG reserved area check

1.  Print the address of the MMCONFIG area when the test for that area
    being reserved fails.

2.  Only check if the first 2MB is reserved, as that is the minimum.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/i386/pci/mmconfig.c   |    9 ++++++---
 arch/x86_64/pci/mmconfig.c |   13 +++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

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
