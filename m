Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbVKWXtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbVKWXtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVKWXri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:32450 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751334AbVKWXqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:34 -0500
Date: Wed, 23 Nov 2005 15:44:54 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       rajesh.shah@intel.com
Subject: [patch 10/22] PCI Express Hotplug: clear sticky power-fault bit
Message-ID: <20051123234454.GK527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-express-hotplug-clear-sticky-power-fault-bit.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajesh Shah <rajesh.shah@intel.com>


Per the PCI Express spec, the power-fault-detected bit in the
slot status register can be set anytime hardware detects a power
fault, regardless of whether the slot has a device populated in
it or not. This bit is sticky and must be explicitly cleared.
This patch is needed to allow hot-add after such a power fault
has been detected.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/hotplug/pciehp.h      |    1 -
 drivers/pci/hotplug/pciehp_ctrl.c |   15 ++-------------
 drivers/pci/hotplug/pciehp_hpc.c  |   10 +++++++++-
 3 files changed, 11 insertions(+), 15 deletions(-)

--- usb-2.6.orig/drivers/pci/hotplug/pciehp.h
+++ usb-2.6/drivers/pci/hotplug/pciehp.h
@@ -59,7 +59,6 @@ struct slot {
 	struct slot *next;
 	u8 bus;
 	u8 device;
-	u16 status;
 	u32 number;
 	u8 state;
 	struct timer_list task_event;
--- usb-2.6.orig/drivers/pci/hotplug/pciehp_ctrl.c
+++ usb-2.6/drivers/pci/hotplug/pciehp_ctrl.c
@@ -207,7 +207,6 @@ u8 pciehp_handle_power_fault(u8 hp_slot,
 		 * power fault Cleared
 		 */
 		info("Power fault cleared on Slot(%d)\n", ctrl->first_slot + hp_slot);
-		p_slot->status = 0x00;
 		taskInfo->event_type = INT_POWER_FAULT_CLEAR;
 	} else {
 		/*
@@ -215,8 +214,6 @@ u8 pciehp_handle_power_fault(u8 hp_slot,
 		 */
 		info("Power fault on Slot(%d)\n", ctrl->first_slot + hp_slot);
 		taskInfo->event_type = INT_POWER_FAULT;
-		/* set power fault status for this board */
-		p_slot->status = 0xFF;
 		info("power fault bit %x set\n", hp_slot);
 	}
 	if (rc)
@@ -317,13 +314,10 @@ static int board_added(struct slot *p_sl
 		return rc;
 	}
 
-	dbg("%s: slot status = %x\n", __FUNCTION__, p_slot->status);
-
 	/* Check for a power fault */
-	if (p_slot->status == 0xFF) {
-		/* power fault occurred, but it was benign */
+	if (p_slot->hpc_ops->query_power_fault(p_slot)) {
+		dbg("%s: power fault detected\n", __FUNCTION__);
 		rc = POWER_FAILURE;
-		p_slot->status = 0;
 		goto err_exit;
 	}
 
@@ -334,8 +328,6 @@ static int board_added(struct slot *p_sl
 		goto err_exit;
 	}
 
-	p_slot->status = 0;
-
 	/*
 	 * Some PCI Express root ports require fixup after hot-plug operation.
 	 */
@@ -382,9 +374,6 @@ static int remove_board(struct slot *p_s
 
 	dbg("In %s, hp_slot = %d\n", __FUNCTION__, hp_slot);
 
-	/* Change status to shutdown */
-	p_slot->status = 0x01;
-
 	/* Wait for exclusive access to hardware */
 	down(&ctrl->crit_sect);
 
--- usb-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ usb-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -750,7 +750,7 @@ static int hpc_power_on_slot(struct slot
 {
 	struct php_ctlr_state_s *php_ctlr = slot->ctrl->hpc_ctlr_handle;
 	u16 slot_cmd;
-	u16 slot_ctrl;
+	u16 slot_ctrl, slot_status;
 
 	int retval = 0;
 
@@ -767,6 +767,14 @@ static int hpc_power_on_slot(struct slot
 		return -1;
 	}
 
+	/* Clear sticky power-fault bit from previous power failures */
+	hp_register_read_word(php_ctlr->pci_dev,
+			SLOT_STATUS(slot->ctrl->cap_base), slot_status);
+	slot_status &= PWR_FAULT_DETECTED;
+	if (slot_status)
+		hp_register_write_word(php_ctlr->pci_dev,
+			SLOT_STATUS(slot->ctrl->cap_base), slot_status);
+
 	retval = hp_register_read_word(php_ctlr->pci_dev, SLOT_CTRL(slot->ctrl->cap_base), slot_ctrl);
 
 	if (retval) {

--
