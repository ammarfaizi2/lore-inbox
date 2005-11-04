Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030554AbVKDAxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554AbVKDAxD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030579AbVKDAwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:52:43 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:1684 "EHLO
	mail.gnucash.org") by vger.kernel.org with ESMTP id S1030554AbVKDAwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:52:01 -0500
Date: Thu, 3 Nov 2005 18:51:46 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 21/42]: PCI: cleanup/simplify ppc64 PCI hotplug code
Message-ID: <20051104005146.GA27008@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

21-rpaphp-eeh-cleanup.patch

This patch cleans up some rpa dlpar code. Basically, 
the rpaphp_config_pci_adapter() was a wrapper routine, which
made two calls, and wrapped a bunch of verbose no-op code
around it.  This was consolidated wih the routine it called.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-git3/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/pci/hotplug/rpaphp_pci.c	2005-11-02 14:36:41.271315241 -0600
+++ linux-2.6.14-git3/drivers/pci/hotplug/rpaphp_pci.c	2005-11-02 14:36:48.081360405 -0600
@@ -221,18 +221,21 @@
  rpaphp_pci_config_slot() will  configure all devices under the
  given slot->dn and return the the first pci_dev.
  *****************************************************************************/
-static struct pci_dev *
-rpaphp_pci_config_slot(struct pci_bus *bus)
+int
+rpaphp_config_pci_adapter(struct pci_bus *bus)
 {
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 	struct pci_dev *dev = NULL;
+	int rc = -ENODEV;
 	int slotno;
 	int num;
 
 	dbg("Enter %s: dn=%s bus=%s\n", __FUNCTION__, dn->full_name, bus->name);
 	if (!dn || !dn->child)
-		return NULL;
+		goto exit;
 
+	eeh_add_device_tree_early(dn);
+	
 	slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
 
 	/* pci_scan_slot should find all children */
@@ -243,15 +246,23 @@
 	}
 	if (list_empty(&bus->devices)) {
 		err("%s: No new device found\n", __FUNCTION__);
-		return NULL;
+		goto exit;
 	}
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 			rpaphp_pci_config_bridge(dev);
 	}
 
-	return dev;
+	dbg("%s: pci_devs of slot[%s]\n", __FUNCTION__, dn->full_name);
+	list_for_each_entry (dev, &bus->devices, bus_list)
+		dbg("\t%s\n", pci_name(dev));
+
+	rc = 0;
+exit:
+	dbg("Exit %s:  rc=%d\n", __FUNCTION__, rc);
+	return rc;
 }
+EXPORT_SYMBOL_GPL(rpaphp_config_pci_adapter);
 
 static void print_slot_pci_funcs(struct pci_bus *bus)
 {
@@ -268,30 +279,6 @@
 	return;
 }
 
-int rpaphp_config_pci_adapter(struct pci_bus *bus)
-{
-	struct device_node *dn = pci_bus_to_OF_node(bus);
-	struct pci_dev *dev;
-	int rc = -ENODEV;
-
-	dbg("Entry %s: slot[%s]\n", __FUNCTION__, dn->full_name);
-	if (!dn)
-		goto exit;
-
-	eeh_add_device_tree_early(dn);
-	dev = rpaphp_pci_config_slot(bus);
-	if (!dev) {
-		err("%s: can't find any devices.\n", __FUNCTION__);
-		goto exit;
-	}
-	print_slot_pci_funcs(bus);
-	rc = 0;
-exit:
-	dbg("Exit %s:  rc=%d\n", __FUNCTION__, rc);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(rpaphp_config_pci_adapter);
-
 int rpaphp_unconfig_pci_adapter(struct pci_bus *bus)
 {
 	struct pci_dev *dev, *tmp;
