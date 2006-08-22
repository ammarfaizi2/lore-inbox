Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWHVCnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWHVCnO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 22:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWHVCnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 22:43:14 -0400
Received: from smtp-out.google.com ([216.239.45.12]:3947 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751148AbWHVCnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 22:43:13 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:mime-version:
	content-type:content-disposition:user-agent:sender;
	b=DuMt+RgNLHaN/lmet0jxX1ejZmIpRqFVGofmS9t+0nmJhAlnIidk1mbV2BtCJ7ezi
	tLW4Cub1LCWRfg9jKgRPQ==
Date: Mon, 21 Aug 2006 19:42:37 -0700
From: Tim Hockin <thockin@google.com>
To: matthew@wil.cx, ak@suse.de, greg@kroah.com,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@google.com>
Subject: PCI MMCONFIG aperture size
Message-ID: <20060822024237.GO16573@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure who's responsible for this piece of code, so sorry for the
extra email if it's not you.

I've got a system that has an MMCONFIG region that is 32 MB.  Not the
expected 256 MB.  Careful reading of the PCI firmware spec says:

	"The size of the memory mapped configuration region is indicated
	by the start and end bus number fields in the Memory mapped
	Enhanced configuration space base address allocation
	structure..."
and
	"...configuration access method, the base address of the memory
	mapped configuration space always corresponds to bus number 0
	(regardless of the start bus number decoded by the host
	bridge)..."

This says to me that (as long as the MCFG table has an End Bus Number of
31) a 32 MB decode area (32 MB aligned, too) is valid.

Would something like the below patch be accepted?  It makes my system
work...

Also, why are we forcing 32 bit base addresses?  ACPI defines it to be a
64 bit base...

Tim



--- ./arch/x86_64/pci/mmconfig.c.orig	2006-08-18 15:35:30.000000000 -0700
+++ ./arch/x86_64/pci/mmconfig.c	2006-08-21 19:36:52.000000000 -0700
@@ -13,7 +13,6 @@
 
 #include "pci.h"
 
-#define MMCONFIG_APER_SIZE (256*1024*1024)
 /* Verify the first 16 busses. We assume that systems with more busses
    get MCFG right. */
 #define MAX_CHECK_BUS 16
@@ -164,6 +163,7 @@
 void __init pci_mmcfg_init(void)
 {
 	int i;
+	u32 start;
 
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
@@ -174,8 +174,9 @@
 	    (pci_mmcfg_config[0].base_address == 0))
 		return;
 
-	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
+	start = pci_mmcfg_config[0].base_address;
+	if (!e820_all_mapped(start,
+			start+((pci_mmcfg_config[0].end_bus_number+1)*1024*1024),
 			E820_RESERVED)) {
 		printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
 		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
@@ -190,7 +191,9 @@
 	}
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
 		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
-		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
+		pci_mmcfg_virt[i].virt = ioremap_nocache(
+			pci_mmcfg_config[i].base_address,
+			(pci_mmcfg_config[i].end_bus_number+1)*1024*1024);
 		if (!pci_mmcfg_virt[i].virt) {
 			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);
--- ./arch/i386/pci/mmconfig.c.orig	2006-08-21 19:19:12.000000000 -0700
+++ ./arch/i386/pci/mmconfig.c	2006-08-21 19:35:04.000000000 -0700
@@ -15,8 +15,6 @@
 #include <asm/e820.h>
 #include "pci.h"
 
-#define MMCONFIG_APER_SIZE (256*1024*1024)
-
 /* Assume systems with more busses have correct MCFG */
 #define MAX_CHECK_BUS 16
 
@@ -187,6 +185,8 @@
 
 void __init pci_mmcfg_init(void)
 {
+	u32 start;
+
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
@@ -196,8 +196,9 @@
 	    (pci_mmcfg_config[0].base_address == 0))
 		return;
 
-	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
+	start = pci_mmcfg_config[0].base_address;
+	if (!e820_all_mapped(start
+			start+((pci_mmcfg_config[0].end_bus_number+1)*1024*1024),
 			E820_RESERVED)) {
 		printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
 		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
