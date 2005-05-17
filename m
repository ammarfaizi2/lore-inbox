Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVEQVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVEQVud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVEQVub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:50:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:63131 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261997AbVEQVo4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:44:56 -0400
Cc: dlsy@snoqualmie.dp.intel.com
Subject: [PATCH] PCI Hotplug: get pciehp to work on the downstream port of a switch
In-Reply-To: <11163663062761@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 17 May 2005 14:45:06 -0700
Message-Id: <11163663062856@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: get pciehp to work on the downstream port of a switch

Here is the updated patch to get pciehp driver to work for downstream
port of a switch and handle the difference in the offset value of PCI
Express capability list item of different ports.

Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8b245e45f34280ec61e3c8d643d4613b9e0eb7a4
tree aefa5d7e3d4689f5f1df21a7820088e8d9c7070b
parent ee17fd93a5892c162b0a02d58cdfdb9c50cf8467
author Dely Sy <dlsy@snoqualmie.dp.intel.com> Fri, 06 May 2005 17:19:09 -0700
committer Greg KH <gregkh@suse.de> Tue, 17 May 2005 14:31:11 -0700

 drivers/pci/hotplug/pciehp.h      |    1 
 drivers/pci/hotplug/pciehp_core.c |    2 
 drivers/pci/hotplug/pciehp_hpc.c  |  156 +++++++++++++++++++-------------------
 drivers/pci/pcie/portdrv_bus.c    |    3 
 4 files changed, 83 insertions(+), 79 deletions(-)

Index: drivers/pci/hotplug/pciehp.h
===================================================================
--- d218eab66a47e883ddf84f5c30e9060cd99394ec/drivers/pci/hotplug/pciehp.h  (mode:100644)
+++ aefa5d7e3d4689f5f1df21a7820088e8d9c7070b/drivers/pci/hotplug/pciehp.h  (mode:100644)
@@ -130,6 +130,7 @@
 	u8 slot_bus;		/* Bus where the slots handled by this controller sit */
 	u8 ctrlcap;
 	u16 vendor_id;
+	u8 cap_base;
 };
 
 struct irq_mapping {
Index: drivers/pci/hotplug/pciehp_core.c
===================================================================
--- d218eab66a47e883ddf84f5c30e9060cd99394ec/drivers/pci/hotplug/pciehp_core.c  (mode:100644)
+++ aefa5d7e3d4689f5f1df21a7820088e8d9c7070b/drivers/pci/hotplug/pciehp_core.c  (mode:100644)
@@ -607,7 +607,7 @@
 static struct pcie_port_service_id port_pci_ids[] = { { 
 	.vendor = PCI_ANY_ID, 
 	.device = PCI_ANY_ID,
-	.port_type = PCIE_RC_PORT, 
+	.port_type = PCIE_ANY_PORT,
 	.service_type = PCIE_PORT_SERVICE_HP,
 	.driver_data =	0, 
 	}, { /* end: all zeroes */ }
Index: drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- d218eab66a47e883ddf84f5c30e9060cd99394ec/drivers/pci/hotplug/pciehp_hpc.c  (mode:100644)
+++ aefa5d7e3d4689f5f1df21a7820088e8d9c7070b/drivers/pci/hotplug/pciehp_hpc.c  (mode:100644)
@@ -109,20 +109,20 @@
 };
 static int pcie_cap_base = 0;		/* Base of the PCI Express capability item structure */ 
 
-#define PCIE_CAP_ID	( pcie_cap_base + PCIECAPID )
-#define NXT_CAP_PTR	( pcie_cap_base + NXTCAPPTR )
-#define CAP_REG		( pcie_cap_base + CAPREG )
-#define DEV_CAP		( pcie_cap_base + DEVCAP )
-#define DEV_CTRL	( pcie_cap_base + DEVCTRL )
-#define DEV_STATUS	( pcie_cap_base + DEVSTATUS )
-#define LNK_CAP		( pcie_cap_base + LNKCAP )
-#define LNK_CTRL	( pcie_cap_base + LNKCTRL )
-#define LNK_STATUS	( pcie_cap_base + LNKSTATUS )
-#define SLOT_CAP	( pcie_cap_base + SLOTCAP )
-#define SLOT_CTRL	( pcie_cap_base + SLOTCTRL )
-#define SLOT_STATUS	( pcie_cap_base + SLOTSTATUS )
-#define ROOT_CTRL	( pcie_cap_base + ROOTCTRL )
-#define ROOT_STATUS	( pcie_cap_base + ROOTSTATUS )
+#define PCIE_CAP_ID(cb)	( cb + PCIECAPID )
+#define NXT_CAP_PTR(cb)	( cb + NXTCAPPTR )
+#define CAP_REG(cb)	( cb + CAPREG )
+#define DEV_CAP(cb)	( cb + DEVCAP )
+#define DEV_CTRL(cb)	( cb + DEVCTRL )
+#define DEV_STATUS(cb)	( cb + DEVSTATUS )
+#define LNK_CAP(cb)	( cb + LNKCAP )
+#define LNK_CTRL(cb)	( cb + LNKCTRL )
+#define LNK_STATUS(cb)	( cb + LNKSTATUS )
+#define SLOT_CAP(cb)	( cb + SLOTCAP )
+#define SLOT_CTRL(cb)	( cb + SLOTCTRL )
+#define SLOT_STATUS(cb)	( cb + SLOTSTATUS )
+#define ROOT_CTRL(cb)	( cb + ROOTCTRL )
+#define ROOT_STATUS(cb)	( cb + ROOTSTATUS )
 
 #define hp_register_read_word(pdev, reg , value)		\
 	pci_read_config_word(pdev, reg, &value)
@@ -303,7 +303,7 @@
 		return -1;
 	}
 
-	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(slot->ctrl->cap_base), slot_status);
 	if (retval) {
 			err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
 			return retval;
@@ -317,7 +317,7 @@
 	}
 
 	dbg("%s: Before hp_register_write_word SLOT_CTRL %x\n", __FUNCTION__, cmd);
-	retval = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL, cmd | CMD_CMPL_INTR_ENABLE);
+	retval = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), cmd | CMD_CMPL_INTR_ENABLE);
 	if (retval) {
 		err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
 		return retval;
@@ -342,7 +342,7 @@
 		return -1;
 	}
 	
-	retval = hp_register_read_word(php_ctlr->pci_dev, LNK_STATUS, lnk_status);
+	retval = hp_register_read_word(php_ctlr->pci_dev, LNK_STATUS(ctrl->cap_base), lnk_status);
 
 	if (retval) {
 		err("%s : hp_register_read_word LNK_STATUS failed\n", __FUNCTION__);
@@ -376,14 +376,14 @@
 		return -1;
 	}
 
-	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, slot_ctrl);
+	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	if (retval) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
 		return retval;
 	}
 
-	dbg("%s: SLOT_CTRL %x, value read %x\n", __FUNCTION__,SLOT_CTRL, slot_ctrl);
+	dbg("%s: SLOT_CTRL %x, value read %x\n", __FUNCTION__,SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	atten_led_state = (slot_ctrl & ATTN_LED_CTRL) >> 6;
 
@@ -423,13 +423,13 @@
 		return -1;
 	}
 
-	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, slot_ctrl);
+	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	if (retval) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
 		return retval;
 	}
-	dbg("%s: SLOT_CTRL %x value read %x\n", __FUNCTION__, SLOT_CTRL, slot_ctrl);
+	dbg("%s: SLOT_CTRL %x value read %x\n", __FUNCTION__, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	pwr_state = (slot_ctrl & PWR_CTRL) >> 10;
 
@@ -463,7 +463,7 @@
 		return -1;
 	}
 
-	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(slot->ctrl->cap_base), slot_status);
 
 	if (retval) {
 		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
@@ -490,7 +490,7 @@
 		return -1;
 	}
 
-	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(slot->ctrl->cap_base), slot_status);
 
 	if (retval) {
 		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
@@ -518,7 +518,7 @@
 		return -1;
 	}
 
-	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(slot->ctrl->cap_base), slot_status);
 
 	if (retval) {
 		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
@@ -549,7 +549,7 @@
 		err("%s: Invalid HPC slot number!\n", __FUNCTION__);
 		return -1;
 	}
-	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, slot_ctrl);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
@@ -574,7 +574,7 @@
 		slot_cmd = slot_cmd | HP_INTR_ENABLE; 
 
 	pcie_write_cmd(slot, slot_cmd);
-	dbg("%s: SLOT_CTRL %x write cmd %x\n", __FUNCTION__, SLOT_CTRL, slot_cmd);
+	dbg("%s: SLOT_CTRL %x write cmd %x\n", __FUNCTION__, SLOT_CTRL(slot->ctrl->cap_base), slot_cmd);
 	
 	return rc;
 }
@@ -598,7 +598,7 @@
 		return ;
 	}
 
-	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, slot_ctrl);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
@@ -611,7 +611,7 @@
 
 	pcie_write_cmd(slot, slot_cmd);
 
-	dbg("%s: SLOT_CTRL %x write cmd %x\n",__FUNCTION__, SLOT_CTRL, slot_cmd);
+	dbg("%s: SLOT_CTRL %x write cmd %x\n",__FUNCTION__, SLOT_CTRL(slot->ctrl->cap_base), slot_cmd);
 	return;
 }
 
@@ -633,7 +633,7 @@
 		return ;
 	}
 
-	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, slot_ctrl);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
@@ -646,7 +646,7 @@
 	if (!pciehp_poll_mode)
 		slot_cmd = slot_cmd | HP_INTR_ENABLE; 
 	pcie_write_cmd(slot, slot_cmd);
-	dbg("%s: SLOT_CTRL %x write cmd %x\n", __FUNCTION__, SLOT_CTRL, slot_cmd);
+	dbg("%s: SLOT_CTRL %x write cmd %x\n", __FUNCTION__, SLOT_CTRL(slot->ctrl->cap_base), slot_cmd);
 
 	return;
 }
@@ -669,7 +669,7 @@
 		return ;
 	}
 
-	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, slot_ctrl);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
@@ -683,7 +683,7 @@
 		slot_cmd = slot_cmd | HP_INTR_ENABLE; 
 	pcie_write_cmd(slot, slot_cmd);
 
-	dbg("%s: SLOT_CTRL %x write cmd %x\n",__FUNCTION__, SLOT_CTRL, slot_cmd);
+	dbg("%s: SLOT_CTRL %x write cmd %x\n",__FUNCTION__, SLOT_CTRL(slot->ctrl->cap_base), slot_cmd);
 	return;
 }
 
@@ -707,7 +707,7 @@
 	*first_device_num = 0;
 	*num_ctlr_slots = 1; 
 
-	rc = hp_register_read_dword(php_ctlr->pci_dev, SLOT_CAP, slot_cap);
+	rc = hp_register_read_dword(php_ctlr->pci_dev, SLOT_CAP(ctrl->cap_base), slot_cap);
 
 	if (rc) {
 		err("%s : hp_register_read_dword SLOT_CAP failed\n", __FUNCTION__);
@@ -793,13 +793,13 @@
 		return -1;
 	}
 
-	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, slot_ctrl);
+	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	if (retval) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
 		return retval;
 	}
-	dbg("%s: SLOT_CTRL %x, value read %xn", __FUNCTION__, SLOT_CTRL, 
+	dbg("%s: SLOT_CTRL %x, value read %xn", __FUNCTION__, SLOT_CTRL(slot->ctrl->cap_base),
 		slot_ctrl);
 
 	slot_cmd = (slot_ctrl & ~PWR_CTRL) | POWER_ON;
@@ -813,7 +813,7 @@
 		err("%s: Write %x command failed!\n", __FUNCTION__, slot_cmd);
 		return -1;
 	}
-	dbg("%s: SLOT_CTRL %x write cmd %x\n",__FUNCTION__, SLOT_CTRL, slot_cmd);
+	dbg("%s: SLOT_CTRL %x write cmd %x\n",__FUNCTION__, SLOT_CTRL(slot->ctrl->cap_base), slot_cmd);
 
 	DBG_LEAVE_ROUTINE
 
@@ -842,13 +842,13 @@
 		err("%s: Invalid HPC slot number!\n", __FUNCTION__);
 		return -1;
 	}
-	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, slot_ctrl);
+	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	if (retval) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
 		return retval;
 	}
-	dbg("%s: SLOT_CTRL %x, value read %x\n", __FUNCTION__, SLOT_CTRL, 
+	dbg("%s: SLOT_CTRL %x, value read %x\n", __FUNCTION__, SLOT_CTRL(slot->ctrl->cap_base),
 		slot_ctrl);
 
 	slot_cmd = (slot_ctrl & ~PWR_CTRL) | POWER_OFF;
@@ -862,7 +862,7 @@
 		err("%s: Write command failed!\n", __FUNCTION__);
 		return -1;
 	}
-	dbg("%s: SLOT_CTRL %x write cmd %x\n",__FUNCTION__, SLOT_CTRL, slot_cmd);
+	dbg("%s: SLOT_CTRL %x write cmd %x\n",__FUNCTION__, SLOT_CTRL(slot->ctrl->cap_base), slot_cmd);
 
 	DBG_LEAVE_ROUTINE
 
@@ -900,7 +900,7 @@
 		return IRQ_NONE;
 	}
 
-	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), slot_status);
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
 		return IRQ_NONE;
@@ -918,7 +918,7 @@
 	dbg("%s: intr_loc %x\n", __FUNCTION__, intr_loc);
 	/* Mask Hot-plug Interrupt Enable */
 	if (!pciehp_poll_mode) {
-		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, temp_word);
+		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(ctrl->cap_base), temp_word);
 		if (rc) {
 			err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
 			return IRQ_NONE;
@@ -928,14 +928,14 @@
 		dbg("%s: hp_register_read_word SLOT_CTRL with value %x\n", __FUNCTION__, temp_word);
 		temp_word = (temp_word & ~HP_INTR_ENABLE & ~CMD_CMPL_INTR_ENABLE) | 0x00;
 
-		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL, temp_word);
+		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL(ctrl->cap_base), temp_word);
 		if (rc) {
 			err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
 			return IRQ_NONE;
 		}
 		dbg("%s: hp_register_write_word SLOT_CTRL with value %x\n", __FUNCTION__, temp_word);
 		
-		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), slot_status);
 		if (rc) {
 			err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
 			return IRQ_NONE;
@@ -944,7 +944,7 @@
 		
 		/* Clear command complete interrupt caused by this write */
 		temp_word = 0x1f;
-		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
+		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), temp_word);
 		if (rc) {
 			err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
 			return IRQ_NONE;
@@ -975,14 +975,14 @@
 
 	/* Clear all events after serving them */
 	temp_word = 0x1F;
-	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
+	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
 		return IRQ_NONE;
 	}
 	/* Unmask Hot-plug Interrupt Enable */
 	if (!pciehp_poll_mode) {
-		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, temp_word);
+		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(ctrl->cap_base), temp_word);
 		if (rc) {
 			err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
 			return IRQ_NONE;
@@ -992,14 +992,14 @@
 		dbg("%s: hp_register_read_word SLOT_CTRL with value %x\n", __FUNCTION__, temp_word);
 		temp_word = (temp_word & ~HP_INTR_ENABLE) | HP_INTR_ENABLE;
 
-		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL, temp_word);
+		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL(ctrl->cap_base), temp_word);
 		if (rc) {
 			err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
 			return IRQ_NONE;
 		}
 		dbg("%s: hp_register_write_word SLOT_CTRL with value %x\n", __FUNCTION__, temp_word); 	
 	
-		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), slot_status);
 		if (rc) {
 			err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
 			return IRQ_NONE;
@@ -1008,7 +1008,7 @@
 		
 		/* Clear command complete interrupt caused by this write */
 		temp_word = 0x1F;
-		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
+		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), temp_word);
 		if (rc) {
 			err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
 			return IRQ_NONE;
@@ -1038,7 +1038,7 @@
 		return -1;
 	}
 
-	retval = hp_register_read_dword(php_ctlr->pci_dev, LNK_CAP, lnk_cap);
+	retval = hp_register_read_dword(php_ctlr->pci_dev, LNK_CAP(slot->ctrl->cap_base), lnk_cap);
 
 	if (retval) {
 		err("%s : hp_register_read_dword  LNK_CAP failed\n", __FUNCTION__);
@@ -1079,7 +1079,7 @@
 		return -1;
 	}
 
-	retval = hp_register_read_dword(php_ctlr->pci_dev, LNK_CAP, lnk_cap);
+	retval = hp_register_read_dword(php_ctlr->pci_dev, LNK_CAP(slot->ctrl->cap_base), lnk_cap);
 
 	if (retval) {
 		err("%s : hp_register_read_dword  LNK_CAP failed\n", __FUNCTION__);
@@ -1141,7 +1141,7 @@
 		return -1;
 	}
 
-	retval = hp_register_read_word(php_ctlr->pci_dev, LNK_STATUS, lnk_status);
+	retval = hp_register_read_word(php_ctlr->pci_dev, LNK_STATUS(slot->ctrl->cap_base), lnk_status);
 
 	if (retval) {
 		err("%s : hp_register_read_word LNK_STATUS failed\n", __FUNCTION__);
@@ -1182,7 +1182,7 @@
 		return -1;
 	}
 
-	retval = hp_register_read_word(php_ctlr->pci_dev, LNK_STATUS, lnk_status);
+	retval = hp_register_read_word(php_ctlr->pci_dev, LNK_STATUS(slot->ctrl->cap_base), lnk_status);
 
 	if (retval) {
 		err("%s : hp_register_read_word LNK_STATUS failed\n", __FUNCTION__);
@@ -1292,47 +1292,48 @@
 		goto abort_free_ctlr;
 	}
 
-	pcie_cap_base = cap_base;
+	ctrl->cap_base = cap_base;
 
 	dbg("%s: pcie_cap_base %x\n", __FUNCTION__, pcie_cap_base);
 
-	rc = hp_register_read_word(pdev, CAP_REG, cap_reg);
+	rc = hp_register_read_word(pdev, CAP_REG(ctrl->cap_base), cap_reg);
 	if (rc) {
 		err("%s : hp_register_read_word CAP_REG failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
-	dbg("%s: CAP_REG offset %x cap_reg %x\n", __FUNCTION__, CAP_REG, cap_reg);
+	dbg("%s: CAP_REG offset %x cap_reg %x\n", __FUNCTION__, CAP_REG(ctrl->cap_base), cap_reg);
 
-	if (((cap_reg & SLOT_IMPL) == 0) || ((cap_reg & DEV_PORT_TYPE) != 0x0040)){
+	if (((cap_reg & SLOT_IMPL) == 0) || (((cap_reg & DEV_PORT_TYPE) != 0x0040)
+		&& ((cap_reg & DEV_PORT_TYPE) != 0x0060))) {
 		dbg("%s : This is not a root port or the port is not connected to a slot\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
 
-	rc = hp_register_read_dword(php_ctlr->pci_dev, SLOT_CAP, slot_cap);
+	rc = hp_register_read_dword(php_ctlr->pci_dev, SLOT_CAP(ctrl->cap_base), slot_cap);
 	if (rc) {
 		err("%s : hp_register_read_word CAP_REG failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
-	dbg("%s: SLOT_CAP offset %x slot_cap %x\n", __FUNCTION__, SLOT_CAP, slot_cap);
+	dbg("%s: SLOT_CAP offset %x slot_cap %x\n", __FUNCTION__, SLOT_CAP(ctrl->cap_base), slot_cap);
 
 	if (!(slot_cap & HP_CAP)) {
 		dbg("%s : This slot is not hot-plug capable\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
 	/* For debugging purpose */
-	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), slot_status);
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
-	dbg("%s: SLOT_STATUS offset %x slot_status %x\n", __FUNCTION__, SLOT_STATUS, slot_status);
+	dbg("%s: SLOT_STATUS offset %x slot_status %x\n", __FUNCTION__, SLOT_STATUS(ctrl->cap_base), slot_status);
 
-	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL, slot_ctrl);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(ctrl->cap_base), slot_ctrl);
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
-	dbg("%s: SLOT_CTRL offset %x slot_ctrl %x\n", __FUNCTION__, SLOT_CTRL, slot_ctrl);
+	dbg("%s: SLOT_CTRL offset %x slot_ctrl %x\n", __FUNCTION__, SLOT_CTRL(ctrl->cap_base), slot_ctrl);
 
 	if (first) {
 		spin_lock_init(&hpc_event_lock);
@@ -1372,36 +1373,37 @@
 	php_ctlr->num_slots = 1;
 
 	/* Mask Hot-plug Interrupt Enable */
-	rc = hp_register_read_word(pdev, SLOT_CTRL, temp_word);
+	rc = hp_register_read_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
 
-	dbg("%s: SLOT_CTRL %x value read %x\n", __FUNCTION__, SLOT_CTRL, temp_word);
+	dbg("%s: SLOT_CTRL %x value read %x\n", __FUNCTION__, SLOT_CTRL(ctrl->cap_base), temp_word);
 	temp_word = (temp_word & ~HP_INTR_ENABLE & ~CMD_CMPL_INTR_ENABLE) | 0x00;
 
-	rc = hp_register_write_word(pdev, SLOT_CTRL, temp_word);
+	rc = hp_register_write_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
 	dbg("%s : Mask HPIE hp_register_write_word SLOT_CTRL %x\n", __FUNCTION__, temp_word);
 
-	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), slot_status);
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
-	dbg("%s: Mask HPIE SLOT_STATUS offset %x reads slot_status %x\n", __FUNCTION__, SLOT_STATUS, slot_status);
+	dbg("%s: Mask HPIE SLOT_STATUS offset %x reads slot_status %x\n", __FUNCTION__, SLOT_STATUS(ctrl->cap_base)
+		, slot_status);
 
 	temp_word = 0x1F; /* Clear all events */
-	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
+	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
-	dbg("%s: SLOT_STATUS offset %x writes slot_status %x\n", __FUNCTION__, SLOT_STATUS, temp_word);
+	dbg("%s: SLOT_STATUS offset %x writes slot_status %x\n", __FUNCTION__, SLOT_STATUS(ctrl->cap_base), temp_word);
 
 	if (pciehp_poll_mode)  {/* Install interrupt polling code */
 		/* Install and start the interrupt polling timer */
@@ -1417,12 +1419,12 @@
 		}
 	}
 
-	rc = hp_register_read_word(pdev, SLOT_CTRL, temp_word);
+	rc = hp_register_read_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
-	dbg("%s: SLOT_CTRL %x value read %x\n", __FUNCTION__, SLOT_CTRL, temp_word);
+	dbg("%s: SLOT_CTRL %x value read %x\n", __FUNCTION__, SLOT_CTRL(ctrl->cap_base), temp_word);
 	dbg("%s: slot_cap %x\n", __FUNCTION__, slot_cap);
 
 	intr_enable = intr_enable | PRSN_DETECT_ENABLE;
@@ -1446,27 +1448,27 @@
 	dbg("%s: temp_word %x\n", __FUNCTION__, temp_word);
 
 	/* Unmask Hot-plug Interrupt Enable for the interrupt notification mechanism case */
-	rc = hp_register_write_word(pdev, SLOT_CTRL, temp_word);
+	rc = hp_register_write_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
 	dbg("%s : Unmask HPIE hp_register_write_word SLOT_CTRL with %x\n", __FUNCTION__, temp_word);
-	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), slot_status);
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
 	dbg("%s: Unmask HPIE SLOT_STATUS offset %x reads slot_status %x\n", __FUNCTION__, 
-		SLOT_STATUS, slot_status);
+		SLOT_STATUS(ctrl->cap_base), slot_status);
 	
 	temp_word =  0x1F; /* Clear all events */
-	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
+	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
-	dbg("%s: SLOT_STATUS offset %x writes slot_status %x\n", __FUNCTION__, SLOT_STATUS, temp_word);
+	dbg("%s: SLOT_STATUS offset %x writes slot_status %x\n", __FUNCTION__, SLOT_STATUS(ctrl->cap_base), temp_word);
 	
 	/*  Add this HPC instance into the HPC list */
 	spin_lock(&list_lock);
Index: drivers/pci/pcie/portdrv_bus.c
===================================================================
--- d218eab66a47e883ddf84f5c30e9060cd99394ec/drivers/pci/pcie/portdrv_bus.c  (mode:100644)
+++ aefa5d7e3d4689f5f1df21a7820088e8d9c7070b/drivers/pci/pcie/portdrv_bus.c  (mode:100644)
@@ -39,7 +39,8 @@
 		driver->id_table->vendor != pciedev->id.vendor) ||
 	       (driver->id_table->device != PCI_ANY_ID &&
 		driver->id_table->device != pciedev->id.device) ||	
-		driver->id_table->port_type != pciedev->id.port_type ||
+	       (driver->id_table->port_type != PCIE_ANY_PORT &&
+		driver->id_table->port_type != pciedev->id.port_type) ||
 		driver->id_table->service_type != pciedev->id.service_type )
 		return 0;
 

