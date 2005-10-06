Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVJFXkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVJFXkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVJFXkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:40:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26307 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932081AbVJFXkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:40:46 -0400
Date: Thu, 6 Oct 2005 18:40:44 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 12/22] ppc64: RPA PHP cleanup
Message-ID: <20051006234044.GM29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


12-rpaphp-cleanup.patch

This patch cleans up some rpa dlpar code. Basically, 
the rpaphp_config_pci_adapter() was a wrapper routine, which
made two calls, and wrapped a bunch of verbose no-op code
around it.  This was consolidated wih the routine it called.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/pci/hotplug/rpaphp_pci.c	2005-10-06 17:53:52.477544359 -0500
+++ linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_pci.c	2005-10-06 17:53:55.542114371 -0500
@@ -219,18 +219,21 @@
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
@@ -241,15 +244,23 @@
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
@@ -266,30 +277,6 @@
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
