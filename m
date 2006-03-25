Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWCYQ01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWCYQ01 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 11:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWCYQ00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 11:26:26 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:8586 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750823AbWCYQ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 11:26:09 -0500
Subject: [patch 3 of 4] MCFG sanity check
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <1143303796.2898.6.camel@laptopd505.fenrus.org>
References: <1143303796.2898.6.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Mar 2006 17:24:58 +0100
Message-Id: <1143303898.2898.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a user for the e820_all_mapped function:

There have been several machines that don't have a working MMCONFIG, often
because of a buggy MCFG table in the ACPI bios. This patch adds a simple
sanity check that detects a whole bunch of these cases, and when it detects
it, linux now boots rather than crash-and-burns. The accuracy of this
detection can in principle be improved if there was a "is this entire range
in e820 with THIS attribute", but no such function exist and the complexity
needed for this is not really worth it; this simple check already catches
most cases anyway.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/pci/mmconfig.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-2.6.16-mmconfig/arch/x86_64/pci/mmconfig.c
===================================================================
--- linux-2.6.16-mmconfig.orig/arch/x86_64/pci/mmconfig.c
+++ linux-2.6.16-mmconfig/arch/x86_64/pci/mmconfig.c
@@ -9,6 +9,8 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <asm/e820.h>
+
 #include "pci.h"
 
 #define MMCONFIG_APER_SIZE (256*1024*1024)
@@ -161,6 +163,14 @@ void __init pci_mmcfg_init(void)
 	    (pci_mmcfg_config[0].base_address == 0))
 		return;
 
+	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
+			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
+			E820_RESERVED)) {
+		printk(KERN_INFO "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
+		printk(KERN_INFO "PCI: Not using MMCONFIG.\n");
+		return;
+	}
+
 	/* RED-PEN i386 doesn't do _nocache right now */
 	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
 	if (pci_mmcfg_virt == NULL) {

