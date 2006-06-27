Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWF0Avs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWF0Avs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWF0Avs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:51:48 -0400
Received: from mga05.intel.com ([192.55.52.89]:36683 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030299AbWF0Avr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:51:47 -0400
X-IronPort-AV: i="4.06,178,1149490800"; 
   d="scan'208"; a="89633058:sNHT42452655"
Message-Id: <20060627004920.477788000@rshah1-sfield.jf.intel.com>
References: <20060627004556.809330000@rshah1-sfield.jf.intel.com>
Date: Mon, 26 Jun 2006 17:45:58 -0700
From: rajesh.shah@intel.com
To: ak@suse.de, gregkh@suse.de, len.brown@intel.com
Cc: akpm@osdl.org, arjan@linux.intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Rajesh Shah <rajesh.shah@intel.com>
Subject: [patch 2/2] x86_64 PCI: improve extended config space verification
Content-Disposition: inline; filename=x86_64-fix-mcfg-check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the verification for PCI-X/PCI-Express extended config
space pointer. This patch checks whether the MCFG address range
is listed as a motherboard resource, per the PCI firmware spec.
The old check only looked in int 15 e820 memory map, causing
several systems to fail the verification and lose extended
config space. x86_64 picks up the verification code from the i386
directory.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

 arch/x86_64/pci/mmconfig.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-2.6.17-mm2/arch/x86_64/pci/mmconfig.c
===================================================================
--- linux-2.6.17-mm2.orig/arch/x86_64/pci/mmconfig.c
+++ linux-2.6.17-mm2/arch/x86_64/pci/mmconfig.c
@@ -16,6 +16,7 @@
 /* aperture is up to 256MB but BIOS may reserve less */
 #define MMCONFIG_APER_MIN	(2 * 1024*1024)
 #define MMCONFIG_APER_MAX	(256 * 1024*1024)
+extern int is_acpi_reserved(unsigned long start, unsigned long end);
 
 /* Verify the first 16 busses. We assume that systems with more busses
    get MCFG right. */
@@ -179,10 +180,15 @@ void __init pci_mmcfg_init(void)
 	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
 			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+		if (!is_acpi_reserved(pci_mmcfg_config[0].base_address,
+					pci_mmcfg_config[0].base_address +
+					MMCONFIG_APER_MIN)) {
+			printk(KERN_ERR
+				"PCI: BIOS Bug: MCFG area at %x is not reserved\n",
 				pci_mmcfg_config[0].base_address);
-		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
-		return;
+			printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
+			return;
+		}
 	}
 
 	/* RED-PEN i386 doesn't do _nocache right now */

--
