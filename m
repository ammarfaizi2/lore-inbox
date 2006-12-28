Return-Path: <linux-kernel-owner+w=401wt.eu-S1754988AbWL1VGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbWL1VGJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbWL1VGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:06:09 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:51630 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988AbWL1VGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:06:08 -0500
Date: Thu, 28 Dec 2006 13:05:53 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, jgarzik@pobox.com,
       hch@lst.de
Subject: [patch] x86: Fix dev_to_node  for x86 and x86_64
Message-ID: <20061228210553.GA3874@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
dev_to_node() does not work as expected on x86 and x86_64 as pointed out
earlier here:
http://lkml.org/lkml/2006/11/7/10

Following patch fixes it, please apply.  (Note: The fix depends on support
for PCI domains for x86/x86_64)

Thanks,
Kiran


dev_to_node does not work as expected on x86_64 (and i386).  This is because
node value returned by pcibus_to_node is initialized after a struct device
is created with current x86_64 code.

We need the node value initialized before the call to pci_scan_bus_parented,
as the generic devices are allocated and initialized
off pci_scan_child_bus, which gets called from pci_scan_bus_parented
The following patch does that using "pci_sysdata" introduced by the PCI
domain patches in -mm.

Signed-off-by: Alok N Kataria <alok.kataria@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.20-rc1/arch/i386/pci/acpi.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/i386/pci/acpi.c	2006-12-28 11:51:52.542775000 -0800
+++ linux-2.6.20-rc1/arch/i386/pci/acpi.c	2006-12-28 12:01:19.242775000 -0800
@@ -9,6 +9,7 @@ struct pci_bus * __devinit pci_acpi_scan
 {
 	struct pci_bus *bus;
 	struct pci_sysdata *sd;
+	int pxm;
 
 	/* Allocate per-root-bus (not per bus) arch-specific data.
 	 * TODO: leak; this memory is never freed.
@@ -30,15 +31,21 @@ struct pci_bus * __devinit pci_acpi_scan
 	}
 #endif /* CONFIG_PCI_DOMAINS */
 
+	sd->node = -1;
+
+	pxm = acpi_get_pxm(device->handle);
+#ifdef CONFIG_ACPI_NUMA
+	if (pxm >= 0)
+		sd->node = pxm_to_node(pxm);
+#endif
+
 	bus = pci_scan_bus_parented(NULL, busnum, &pci_root_ops, sd);
 	if (!bus)
 		kfree(sd);
 
 #ifdef CONFIG_ACPI_NUMA
 	if (bus != NULL) {
-		int pxm = acpi_get_pxm(device->handle);
 		if (pxm >= 0) {
-			sd->node = pxm_to_node(pxm);
 			printk("bus %d -> pxm %d -> node %d\n",
 				busnum, pxm, sd->node);
 		}
