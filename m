Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbUKLXbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbUKLXbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUKLX0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:26:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:37603 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262682AbUKLXWl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:41 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017162896@kroah.com>
Date: Fri, 12 Nov 2004 15:21:56 -0800
Message-Id: <1100301716275@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.55.3, 2004/11/01 15:02:37-08:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI: Updated patch to fix adapter speed mismatch for 2.6 kernel

After doing more testing, I found that I couldn't use quirk to set the flag
to identify the chipset, for there are platforms that have other bridge
chip with PCI-X hotpluggable slots in the same system.  Therefore, I use
the vendor id and device id to identify the bridge chip that needs the
workaround. The code doing the workaround remains unchanged.


Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/shpchp_ctrl.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+)


diff -Nru a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
--- a/drivers/pci/hotplug/shpchp_ctrl.c	2004-11-12 15:13:50 -08:00
+++ b/drivers/pci/hotplug/shpchp_ctrl.c	2004-11-12 15:13:50 -08:00
@@ -1157,6 +1157,40 @@
 		return -1;
 	}
 
+	
+	if ((ctrl->pci_dev->vendor == 0x8086) && (ctrl->pci_dev->device == 0x0332)) {
+		if (slots_not_empty)
+			return WRONG_BUS_FREQUENCY;
+		
+		if ((rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, PCI_SPEED_33MHz))) {
+			err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
+			up(&ctrl->crit_sect);
+			return WRONG_BUS_FREQUENCY;
+		}
+		wait_for_ctrl_irq (ctrl);
+		
+		if ((rc = p_slot->hpc_ops->check_cmd_status(ctrl))) {
+			err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
+				  __FUNCTION__);
+			err("%s: Error code (%d)\n", __FUNCTION__, rc);
+			up(&ctrl->crit_sect);
+			return WRONG_BUS_FREQUENCY;
+		}
+		/* turn on board, blink green LED, turn off Amber LED */
+		if ((rc = p_slot->hpc_ops->slot_enable(p_slot))) {
+			err("%s: Issue of Slot Enable command failed\n", __FUNCTION__);
+			up(&ctrl->crit_sect);
+			return rc;
+		}
+		wait_for_ctrl_irq (ctrl);
+
+		if ((rc = p_slot->hpc_ops->check_cmd_status(ctrl))) {
+			err("%s: Failed to enable slot, error code(%d)\n", __FUNCTION__, rc);
+			up(&ctrl->crit_sect);
+			return rc;  
+		}
+	}
+ 
 	rc = p_slot->hpc_ops->get_adapter_speed(p_slot, &adapter_speed);
 	/* 0 = PCI 33Mhz, 1 = PCI 66 Mhz, 2 = PCI-X 66 PA, 4 = PCI-X 66 ECC, */
 	/* 5 = PCI-X 133 PA, 7 = PCI-X 133 ECC,  0xa = PCI-X 133 Mhz 266, */

