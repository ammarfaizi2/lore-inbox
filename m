Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVJEABT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVJEABT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 20:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVJEABS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 20:01:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:24966 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965044AbVJEABS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 20:01:18 -0400
Date: Tue, 4 Oct 2005 19:01:16 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ppc64: Crash in DLPAR code on remove operation
Message-ID: <20051005000116.GX29826@austin.ibm.com>
References: <20051003185739.GR29826@austin.ibm.com> <20051004203019.GV29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004203019.GV29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes two bugs related to dlpar slot removal and add.

-- Both crashes are due to the fact the some children 
   of pci nodes are not pci nodes themselves, and thus do not 
   have pci_dn structures.  For example:
        /pci@800000020000002/pci@2,3/usb@1/hub@1
        /pci@800000020000002/pci@2,3/usb@1,1/hub@1

   Strangely, though, sometimes the following appears, 
   and I don't quite understand why.
        /interrupt-controller@3fe0000a400

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


Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pSeries_iommu.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pSeries_iommu.c	2005-10-04 16:47:09.175705100 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pSeries_iommu.c	2005-10-04 17:12:54.123928903 -0500
@@ -478,10 +478,13 @@
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
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dn.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pci_dn.c	2005-10-04 15:37:49.761245845 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dn.c	2005-10-04 17:58:47.344628793 -0500
@@ -195,7 +195,10 @@
 
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
