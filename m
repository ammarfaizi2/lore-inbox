Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVEQWBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVEQWBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEQWAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:00:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:156 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262002AbVEQVo6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:44:58 -0400
Cc: dlsy@snoqualmie.dp.intel.com
Subject: [PATCH] PCI Hotplug: Fix echoing 1 to power file of enabled slot problem with SHPC driver
In-Reply-To: <20050517214413.GA28629@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 17 May 2005 14:45:05 -0700
Message-Id: <11163663054163@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: Fix echoing 1 to power file of enabled slot problem with SHPC driver

Here is a patch to fix the problem of echoing 1 to "power" file
to enabled slot causing the slot to power down, and echoing 0
to disabled slot causing shpchp_disabled_slot() to be called
twice. This problem was reported by kenji Kaneshige.

Thanks,
Dely

Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ee17fd93a5892c162b0a02d58cdfdb9c50cf8467
tree d218eab66a47e883ddf84f5c30e9060cd99394ec
parent ff0d2f90fdc4b564d47a7c26b16de81a16cfa28e
author Dely Sy <dlsy@snoqualmie.dp.intel.com> Thu, 05 May 2005 11:57:25 -0700
committer Greg KH <gregkh@suse.de> Tue, 17 May 2005 14:31:10 -0700

 drivers/pci/hotplug/shpchp_core.c |    2 +-
 drivers/pci/hotplug/shpchp_ctrl.c |   30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

Index: drivers/pci/hotplug/shpchp_core.c
===================================================================
--- 6bb5a1cf91bbda8308ec7e6d900cb89071907dcd/drivers/pci/hotplug/shpchp_core.c  (mode:100644)
+++ d218eab66a47e883ddf84f5c30e9060cd99394ec/drivers/pci/hotplug/shpchp_core.c  (mode:100644)
@@ -95,7 +95,7 @@
  */
 static void release_slot(struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = (struct slot *)hotplug_slot->private;
+	struct slot *slot = hotplug_slot->private;
 
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
Index: drivers/pci/hotplug/shpchp_ctrl.c
===================================================================
--- 6bb5a1cf91bbda8308ec7e6d900cb89071907dcd/drivers/pci/hotplug/shpchp_ctrl.c  (mode:100644)
+++ d218eab66a47e883ddf84f5c30e9060cd99394ec/drivers/pci/hotplug/shpchp_ctrl.c  (mode:100644)
@@ -1885,7 +1885,7 @@
 	func = shpchp_slot_find(p_slot->bus, p_slot->device, 0);
 	if (!func) {
 		dbg("%s: Error! slot NULL\n", __FUNCTION__);
-		return 1;
+		return -ENODEV;
 	}
 
 	/* Check to see if (latch closed, card present, power off) */
@@ -1894,19 +1894,19 @@
 	if (rc || !getstatus) {
 		info("%s: no adapter on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 1;
+		return -ENODEV;
 	}
 	rc = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 	if (rc || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 1;
+		return -ENODEV;
 	}
 	rc = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
 	if (rc || getstatus) {
 		info("%s: already enabled on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 1;
+		return -ENODEV;
 	}
 	up(&p_slot->ctrl->crit_sect);
 
@@ -1914,7 +1914,7 @@
 
 	func = shpchp_slot_create(p_slot->bus);
 	if (func == NULL)
-		return 1;
+		return -ENOMEM;
 
 	func->bus = p_slot->bus;
 	func->device = p_slot->device;
@@ -1939,7 +1939,7 @@
 		/* Setup slot structure with entry for empty slot */
 		func = shpchp_slot_create(p_slot->bus);
 		if (func == NULL)
-			return (1);	/* Out of memory */
+			return -ENOMEM;	/* Out of memory */
 
 		func->bus = p_slot->bus;
 		func->device = p_slot->device;
@@ -1972,7 +1972,7 @@
 	struct pci_func *func;
 
 	if (!p_slot->ctrl)
-		return 1;
+		return -ENODEV;
 
 	pci_bus = p_slot->ctrl->pci_dev->subordinate;
 
@@ -1983,19 +1983,19 @@
 	if (ret || !getstatus) {
 		info("%s: no adapter on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 1;
+		return -ENODEV;
 	}
 	ret = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 	if (ret || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 1;
+		return -ENODEV;
 	}
 	ret = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
 	if (ret || !getstatus) {
 		info("%s: already disabled slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 1;
+		return -ENODEV;
 	}
 	up(&p_slot->ctrl->crit_sect);
 
@@ -2011,7 +2011,7 @@
 		/* Check the Class Code */
 		rc = pci_bus_read_config_byte (pci_bus, devfn, 0x0B, &class_code);
 		if (rc)
-			return rc;
+			return -ENODEV;
 
 		if (class_code == PCI_BASE_CLASS_DISPLAY) {
 			/* Display/Video adapter (not supported) */
@@ -2020,13 +2020,13 @@
 			/* See if it's a bridge */
 			rc = pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
 			if (rc)
-				return rc;
+				return -ENODEV;
 
 			/* If it's a bridge, check the VGA Enable bit */
 			if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
 				rc = pci_bus_read_config_byte (pci_bus, devfn, PCI_BRIDGE_CONTROL, &BCR);
 				if (rc)
-					return rc;
+					return -ENODEV;
 
 				/* If the VGA Enable bit is set, remove isn't supported */
 				if (BCR & PCI_BRIDGE_CTL_VGA) {
@@ -2042,12 +2042,12 @@
 	if ((func != NULL) && !rc) {
 		rc = remove_board(func, p_slot->ctrl);
 	} else if (!rc)
-		rc = 1;
+		rc = -ENODEV;
 
 	if (p_slot)
 		update_slot_info(p_slot);
 
-	return(rc);
+	return rc;
 }
 
 

