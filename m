Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbVKDAv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbVKDAv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbVKDAv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:51:26 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:61331
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161026AbVKDAvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:51:17 -0500
Date: Thu, 3 Nov 2005 18:51:03 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 18/42]: ppc64: bugfix: crash on dlpar slot add, remove
Message-ID: <20051104005103.GA26983@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

18-crash-on-pci-slot-add.patch

This patch fixes a bugs related to dlpar slot add.

-- Crash is due to the fact the some children 
   of pci nodes are not pci nodes themselves, and thus do not 
   have pci_dn structures.  For example:
        /pci@800000020000002/pci@2,3/usb@1/hub@1
        /pci@800000020000002/pci@2,3/usb@1,1/hub@1

   A typical stack trace:
        Vector: 300 (Data Access) at [c0000000555637d0]
         pc: c000000000202a50: .dlpar_add_slot+0x108/0x410
             c000000000202e78 .add_slot_store+0x7c/0xac
             c000000000202da0 .dlpar_attr_store+0x48/0x64
             c0000000000f8ee4 .sysfs_write_file+0x100/0x1a0

   A similar stack trace is involved for the slot remove.

This code survived testing, of adding and removing different slots,
23 times each, so far, as of this writing.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


emailed to 
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, johnrose@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ppc64: Crash in DLPAR code on remove operation

on 4 October 2005

Index: linux-2.6.14-git6/arch/ppc64/kernel/pci_dn.c
===================================================================
--- linux-2.6.14-git6.orig/arch/ppc64/kernel/pci_dn.c	2005-11-03 14:15:40.520737607 -0600
+++ linux-2.6.14-git6/arch/ppc64/kernel/pci_dn.c	2005-11-03 14:15:45.182083115 -0600
@@ -194,7 +194,10 @@
 
 	switch (action) {
 	case PSERIES_RECONFIG_ADD:
-		pci = np->parent->data;
+		pci = PCI_DN(np->parent);
+		if (!pci)
+			return NOTIFY_OK;
+
 		update_dn_pci_info(np, pci->phb);
 		break;
 	default:
Index: linux-2.6.14-git6/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.14-git6.orig/arch/powerpc/platforms/pseries/iommu.c	2005-11-03 14:14:32.131340002 -0600
+++ linux-2.6.14-git6/arch/powerpc/platforms/pseries/iommu.c	2005-11-03 14:49:42.621970876 -0600
@@ -494,10 +494,13 @@
 {
 	int err = NOTIFY_OK;
 	struct device_node *np = node;
-	struct pci_dn *pci = np->data;
+	struct pci_dn *pci;
 
 	switch (action) {
 	case PSERIES_RECONFIG_REMOVE:
+		pci = PCI_DN(np);
+		if (!pci)
+			return NOTIFY_OK;
 		if (pci->iommu_table &&
 		    get_property(np, "ibm,dma-window", NULL))
 			iommu_free_table(np);
