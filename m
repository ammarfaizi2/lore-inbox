Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUDORZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUDORYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:24:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:13998 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263095AbUDORYD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:03 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1082049826312@kroah.com>
Date: Thu, 15 Apr 2004 10:23:46 -0700
Message-Id: <10820498261812@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.11, 2004/04/07 16:10:06-07:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI Hotplug: Fix interpretation of 0/1 for MRL in SHPC & PCI-E hot-plug

This patch contains fixes for interpretation of 0/1 for MRL
to match pcihpview, bus speed definition in shpchp_hpc.c etc.


 drivers/pci/hotplug/pci_hotplug.h |    2 +-
 drivers/pci/hotplug/pciehp_ctrl.c |    6 +++---
 drivers/pci/hotplug/shpchp_ctrl.c |   10 +++++-----
 drivers/pci/hotplug/shpchp_hpc.c  |   15 ++++++++-------
 4 files changed, 17 insertions(+), 16 deletions(-)


diff -Nru a/drivers/pci/hotplug/pci_hotplug.h b/drivers/pci/hotplug/pci_hotplug.h
--- a/drivers/pci/hotplug/pci_hotplug.h	Thu Apr 15 10:03:55 2004
+++ b/drivers/pci/hotplug/pci_hotplug.h	Thu Apr 15 10:03:55 2004
@@ -43,7 +43,7 @@
 	PCI_SPEED_100MHz_PCIX_266	= 0x0a,
 	PCI_SPEED_133MHz_PCIX_266	= 0x0b,
 	PCI_SPEED_66MHz_PCIX_533	= 0x11,
-	PCI_SPEED_100MHz_PCIX_533	= 0X12,
+	PCI_SPEED_100MHz_PCIX_533	= 0x12,
 	PCI_SPEED_133MHz_PCIX_533	= 0x13,
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
diff -Nru a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
--- a/drivers/pci/hotplug/pciehp_ctrl.c	Thu Apr 15 10:03:55 2004
+++ b/drivers/pci/hotplug/pciehp_ctrl.c	Thu Apr 15 10:03:55 2004
@@ -135,7 +135,7 @@
 	p_slot->hpc_ops->get_adapter_status(p_slot, &(func->presence_save));
 	p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 
-	if (!getstatus) {
+	if (getstatus) {
 		/*
 		 * Switch opened
 		 */
@@ -1705,7 +1705,7 @@
 	}
 	
 	rc = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
-	if (rc || !getstatus) {
+	if (rc || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
 		return (0);
@@ -1792,7 +1792,7 @@
 	}
 
 	ret = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
-	if (ret || !getstatus) {
+	if (ret || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
 		return (0);
diff -Nru a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
--- a/drivers/pci/hotplug/shpchp_ctrl.c	Thu Apr 15 10:03:55 2004
+++ b/drivers/pci/hotplug/shpchp_ctrl.c	Thu Apr 15 10:03:55 2004
@@ -138,7 +138,7 @@
 	p_slot->hpc_ops->get_adapter_status(p_slot, &(func->presence_save));
 	p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 
-	if (!getstatus) {
+	if (getstatus) {
 		/*
 		 * Switch opened
 		 */
@@ -1219,7 +1219,7 @@
 					up(&ctrl->crit_sect);
 				}
 			} else {
-				if ((bus_speed > 0x4) || (max_bus_speed > 0x4))  {
+				if (bus_speed > 0x4) {
 					err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
 					return WRONG_BUS_FREQUENCY;
 				}
@@ -1302,7 +1302,7 @@
 					up(&ctrl->crit_sect);
 				}
 			} else {
-				if ((bus_speed > 0x2) || (max_bus_speed > 0x2))  {
+				if (bus_speed > 0x2) {
 					err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
 					return WRONG_BUS_FREQUENCY;
 				}
@@ -2107,7 +2107,7 @@
 		return (0);
 	}
 	rc = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
-	if (rc || !getstatus) {
+	if (rc || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
 		return (0);
@@ -2192,7 +2192,7 @@
 		return (0);
 	}
 	ret = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
-	if (ret || !getstatus) {
+	if (ret || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
 		return (0);
diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	Thu Apr 15 10:03:55 2004
+++ b/drivers/pci/hotplug/shpchp_hpc.c	Thu Apr 15 10:03:55 2004
@@ -104,12 +104,12 @@
 #define PCIX_66MHZ_ECC		0x5
 #define PCIX_100MHZ_ECC		0x6
 #define PCIX_133MHZ_ECC		0x7
-#define PCIX_66MHZ_266		0x8
-#define PCIX_100MHZ_266		0x9
-#define PCIX_133MHZ_266		0x0a
-#define PCIX_66MHZ_533		0x0b
-#define PCIX_100MHZ_533		0x0c
-#define PCIX_133MHZ_533		0x0d
+#define PCIX_66MHZ_266		0x9
+#define PCIX_100MHZ_266		0xa
+#define PCIX_133MHZ_266		0xb
+#define PCIX_66MHZ_533		0x11
+#define PCIX_100MHZ_533		0x12
+#define PCIX_133MHZ_533		0x13
 
 /* Slot Configuration */
 #define SLOT_NUM		0x0000001F
@@ -464,7 +464,8 @@
 	slot_reg = readl(php_ctlr->creg + SLOT1 + 4*(slot->hp_slot));
 	slot_status = (u16)slot_reg;
 
-	*status = ((slot_status & 0x0100) == 0) ? 1 : 0;
+	*status = ((slot_status & 0x0100) == 0) ? 0 : 1;   /* 0 -> close; 1 -> open */
+
 
 	DBG_LEAVE_ROUTINE 
 	return 0;

