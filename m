Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265676AbUFXWLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbUFXWLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbUFXWIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:08:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:41910 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265676AbUFXVrf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:35 -0400
X-Fake: the user-agent is fake
Subject: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <20040624213029.GA2477@kroah.com>
Date: Thu, 24 Jun 2004 14:46:07 -0700
Message-Id: <10881135671308@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.103.1, 2004/06/04 15:01:07-07:00, dlsy@snoqualmie.dp.intel.com

[PATCH] Fixes for hot-plug drivers (updated)

Here is the updated patch (against 2.6.7-rc1) for the shpchp and pciehp
drivers that fixes the following issues:
- proper LED status when latch is open or card is not present while the
  user tries to power up the slot; (reported by D. Keck)
- check if kmalloc() return NULL before proceeding in acpi_get__hpp();
  (provided by L. Capitulino)
- add up(&ctrl->crit_sect) before return in error cases in several
  places;
- proper handling of resources when there are other onboard devices
  behind the p2p bridge that has the hot-plug capabaility;
- need to check negotiated link width in check_lnk_status();
- cleanup board_added() in pciehp


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/pciehp_ctrl.c      |  147 +++++++++++----------------------
 drivers/pci/hotplug/pciehp_hpc.c       |    4 
 drivers/pci/hotplug/pciehprm_acpi.c    |   22 +++-
 drivers/pci/hotplug/pciehprm_nonacpi.c |   18 ++--
 drivers/pci/hotplug/shpchp.h           |    1 
 drivers/pci/hotplug/shpchp_ctrl.c      |   60 +++++--------
 drivers/pci/hotplug/shpchp_pci.c       |    1 
 drivers/pci/hotplug/shpchprm_acpi.c    |   22 +++-
 drivers/pci/hotplug/shpchprm_nonacpi.c |   18 ++--
 9 files changed, 137 insertions(+), 156 deletions(-)


diff -Nru a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
--- a/drivers/pci/hotplug/pciehp_ctrl.c	2004-06-24 13:52:05 -07:00
+++ b/drivers/pci/hotplug/pciehp_ctrl.c	2004-06-24 13:52:05 -07:00
@@ -1058,6 +1058,34 @@
    hotplug controller logic
  */
 
+static void set_slot_off(struct controller *ctrl, struct slot * pslot)
+{
+	/* Wait for exclusive access to hardware */
+	down(&ctrl->crit_sect);
+
+	/* turn off slot, turn on Amber LED, turn off Green LED */
+	if (pslot->hpc_ops->power_off_slot(pslot)) {   
+		err("%s: Issue of Slot Power Off command failed\n", __FUNCTION__);
+		up(&ctrl->crit_sect);
+		return;
+	}
+	wait_for_ctrl_irq (ctrl);
+
+	pslot->hpc_ops->green_led_off(pslot);   
+	
+	wait_for_ctrl_irq (ctrl);
+
+	/* turn on Amber LED */
+	if (pslot->hpc_ops->set_attention_status(pslot, 1)) {   
+		err("%s: Issue of Set Attention Led command failed\n", __FUNCTION__);
+		up(&ctrl->crit_sect);
+		return;
+	}
+	wait_for_ctrl_irq (ctrl);
+
+	/* Done with exclusive hardware access */
+	up(&ctrl->crit_sect);
+}
 
 /**
  * board_added - Called after a board has been added to the system.
@@ -1071,7 +1099,7 @@
 	u8 hp_slot;
 	int index;
 	u32 temp_register = 0xFFFFFFFF;
-	u32 retval, rc = 0;
+	u32 rc = 0;
 	struct pci_func *new_func = NULL;
 	struct slot *p_slot;
 	struct resource_lists res_lists;
@@ -1086,8 +1114,10 @@
 
 	/* Power on slot */
 	rc = p_slot->hpc_ops->power_on_slot(p_slot);
-	if (rc)
+	if (rc) {
+		up(&ctrl->crit_sect);
 		return -1;
+	}
 
 	/* Wait for the command to complete */
 	wait_for_ctrl_irq (ctrl);
@@ -1105,11 +1135,12 @@
 	wait_for_ctrl_irq (ctrl);
 	dbg("%s: afterlong_delay\n", __FUNCTION__);
 
-	/*  Make this to check for link training status */
+	/*  Check link training status */
 	rc = p_slot->hpc_ops->check_lnk_status(ctrl);  
 	if (rc) {
 		err("%s: Failed to check link status\n", __FUNCTION__);
-		return -1;
+		set_slot_off(ctrl, p_slot);
+		return rc;
 	}
 
 	dbg("%s: func status = %x\n", __FUNCTION__, func->status);
@@ -1159,36 +1190,7 @@
 		pciehp_resource_sort_and_combine(&(ctrl->bus_head));
 
 		if (rc) {
-			/* Wait for exclusive access to hardware */
-			down(&ctrl->crit_sect);
-
-			/* turn off slot, turn on Amber LED, turn off Green LED */
-			retval = p_slot->hpc_ops->power_off_slot(p_slot);   
-			/* In PCI Express, just power off slot */
-			if (retval) {
-				err("%s: Issue of Slot Power Off command failed\n", __FUNCTION__);
-				return retval;
-			}
-			/* Wait for the command to complete */
-			wait_for_ctrl_irq (ctrl);
-
-			p_slot->hpc_ops->green_led_off(p_slot);   
-			
-			/* Wait for the command to complete */
-			wait_for_ctrl_irq (ctrl);
-
-			/* turn on Amber LED */
-			retval = p_slot->hpc_ops->set_attention_status(p_slot, 1);   
-			if (retval) {
-				err("%s: Issue of Set Attention Led command failed\n", __FUNCTION__);
-				return retval;
-			}
-			/* Wait for the command to complete */
-			wait_for_ctrl_irq (ctrl);
-
-			/* Done with exclusive hardware access */
-			up(&ctrl->crit_sect);
-
+			set_slot_off(ctrl, p_slot);
 			return rc;
 		}
 		pciehp_save_slot_config(ctrl, func);
@@ -1223,37 +1225,8 @@
 		up(&ctrl->crit_sect);
 
 	} else {
-		/* Wait for exclusive access to hardware */
-		down(&ctrl->crit_sect);
-
-		/* turn off slot, turn on Amber LED, turn off Green LED */
-		retval = p_slot->hpc_ops->power_off_slot(p_slot);   
-		/* In PCI Express, just power off slot */
-		if (retval) {
-			err("%s: Issue of Slot Power Off command failed\n", __FUNCTION__);
-			return retval;
-		}
-		/* Wait for the command to complete */
-		wait_for_ctrl_irq (ctrl);
-
-		p_slot->hpc_ops->green_led_off(p_slot);   
-		
-		/* Wait for the command to complete */
-		wait_for_ctrl_irq (ctrl);
-
-		/* turn on Amber LED */
-		retval = p_slot->hpc_ops->set_attention_status(p_slot, 1);   
-		if (retval) {
-			err("%s: Issue of Set Attention Led command failed\n", __FUNCTION__);
-			return retval;
-		}
-		/* Wait for the command to complete */
-		wait_for_ctrl_irq (ctrl);
-
-		/* Done with exclusive hardware access */
-		up(&ctrl->crit_sect);
-
-		return rc;
+		set_slot_off(ctrl, p_slot);
+		return -1;
 	}
 	return 0;
 }
@@ -1320,6 +1293,7 @@
 	rc = p_slot->hpc_ops->power_off_slot(p_slot);
 	if (rc) {
 		err("%s: Issue of Slot Disable command failed\n", __FUNCTION__);
+		up(&ctrl->crit_sect);
 		return rc;
 	}
 	/* Wait for the command to complete */
@@ -1406,7 +1380,6 @@
 {
 	struct slot *p_slot = (struct slot *) slot;
 	u8 getstatus;
-	int rc;
 	
 	pushbutton_pending = 0;
 
@@ -1420,23 +1393,7 @@
 		p_slot->state = POWEROFF_STATE;
 		dbg("In power_down_board, b:d(%x:%x)\n", p_slot->bus, p_slot->device);
 
-		if (pciehp_disable_slot(p_slot)) {
-			/* Wait for exclusive access to hardware */
-			down(&p_slot->ctrl->crit_sect);
-
-			/* Turn on the Attention LED */
-			rc = p_slot->hpc_ops->set_attention_status(p_slot, 1);
-			if (rc) {
-				err("%s: Issue of Set Atten Indicator On command failed\n", __FUNCTION__);
-				return;
-			}
-	
-			/* Wait for the command to complete */
-			wait_for_ctrl_irq (p_slot->ctrl);
-
-			/* Done with exclusive hardware access */
-			up(&p_slot->ctrl->crit_sect);
-		}
+		pciehp_disable_slot(p_slot);
 		p_slot->state = STATIC_STATE;
 	} else {
 		p_slot->state = POWERON_STATE;
@@ -1446,15 +1403,6 @@
 			/* Wait for exclusive access to hardware */
 			down(&p_slot->ctrl->crit_sect);
 
-			/* Turn off the green LED */
-			rc = p_slot->hpc_ops->set_attention_status(p_slot, 1);
-			if (rc) {
-				err("%s: Issue of Set Atten Indicator On command failed\n", __FUNCTION__);
-				return;
-			}
-			/* Wait for the command to complete */
-			wait_for_ctrl_irq (p_slot->ctrl);
-			
 			p_slot->hpc_ops->green_led_off(p_slot);
 
 			/* Wait for the command to complete */
@@ -1664,7 +1612,10 @@
 					down(&ctrl->crit_sect);
 
 					p_slot->hpc_ops->set_attention_status(p_slot, 1);
+					wait_for_ctrl_irq (ctrl);
+						
 					p_slot->hpc_ops->green_led_off(p_slot);
+					wait_for_ctrl_irq (ctrl);
 
 					/* Done with exclusive hardware access */
 					up(&ctrl->crit_sect);
@@ -1701,21 +1652,21 @@
 	if (rc || !getstatus) {
 		info("%s: no adapter on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 0;
+		return 1;
 	}
 	
 	rc = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 	if (rc || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 0;
+		return 1;
 	}
 	
 	rc = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
 	if (rc || getstatus) {
 		info("%s: already enabled on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 0;
+		return 1;
 	}
 	up(&p_slot->ctrl->crit_sect);
 
@@ -1788,21 +1739,21 @@
 	if (ret || !getstatus) {
 		info("%s: no adapter on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 0;
+		return 1;
 	}
 
 	ret = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 	if (ret || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 0;
+		return 1;
 	}
 
 	ret = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
 	if (ret || !getstatus) {
 		info("%s: already disabled slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return 0;
+		return 1;
 	}
 	up(&p_slot->ctrl->crit_sect);
 
diff -Nru a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
--- a/drivers/pci/hotplug/pciehp_hpc.c	2004-06-24 13:52:05 -07:00
+++ b/drivers/pci/hotplug/pciehp_hpc.c	2004-06-24 13:52:05 -07:00
@@ -349,7 +349,9 @@
 		return retval;
 	}
 
-	if ( (lnk_status & (LNK_TRN | LNK_TRN_ERR)) == 0x0C00) {
+	dbg("%s: lnk_status = %x\n", __FUNCTION__, lnk_status);
+	if ( (lnk_status & LNK_TRN) || (lnk_status & LNK_TRN_ERR) || 
+		!(lnk_status & NEG_LINK_WD)) {
 		err("%s : Link Training Error occurs \n", __FUNCTION__);
 		retval = -1;
 		return retval;
diff -Nru a/drivers/pci/hotplug/pciehprm_acpi.c b/drivers/pci/hotplug/pciehprm_acpi.c
--- a/drivers/pci/hotplug/pciehprm_acpi.c	2004-06-24 13:52:05 -07:00
+++ b/drivers/pci/hotplug/pciehprm_acpi.c	2004-06-24 13:52:05 -07:00
@@ -218,6 +218,10 @@
 	}
 
 	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
+	if (!ab->_hpp) {
+		err ("acpi_pciehprm:%s alloc for _HPP failed\n", path_name);
+		goto free_and_return;
+	}
 	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
 
 	ab->_hpp->cache_line_size	= nui[0];
@@ -1393,7 +1397,7 @@
 
 static int bind_pci_resources_to_slots ( struct controller *ctrl)
 {
-	struct pci_func *func;
+	struct pci_func *func, new_func;
 	int busn = ctrl->slot_bus;
 	int devn, funn;
 	u32	vid;
@@ -1411,11 +1415,19 @@
 			if (vid != 0xFFFFFFFF) {
 				dbg("%s: vid = %x\n", __FUNCTION__, vid);
 				func = pciehp_slot_find(busn, devn, funn);
-				if (!func)
-					continue;
-				configure_existing_function(ctrl, func);
+				if (!func) {
+					memset(&new_func, 0, sizeof(struct pci_func));
+					new_func.bus = busn;
+					new_func.device = devn;
+					new_func.function = funn;
+					new_func.is_a_board = 1;
+					configure_existing_function(ctrl, &new_func);
+					pciehprm_dump_func_res(&new_func);
+				} else {
+					configure_existing_function(ctrl, func);
+					pciehprm_dump_func_res(func);
+				}
 				dbg("aCCF:existing PCI 0x%x Func ResourceDump\n", ctrl->bus);
-				pciehprm_dump_func_res(func);
 			}
 		}
 	}
diff -Nru a/drivers/pci/hotplug/pciehprm_nonacpi.c b/drivers/pci/hotplug/pciehprm_nonacpi.c
--- a/drivers/pci/hotplug/pciehprm_nonacpi.c	2004-06-24 13:52:05 -07:00
+++ b/drivers/pci/hotplug/pciehprm_nonacpi.c	2004-06-24 13:52:05 -07:00
@@ -276,7 +276,7 @@
 
 static int bind_pci_resources_to_slots ( struct controller *ctrl)
 {
-	struct pci_func *func;
+	struct pci_func *func, new_func;
 	int busn = ctrl->slot_bus;
 	int devn, funn;
 	u32	vid;
@@ -297,11 +297,19 @@
 				vid, busn, devn, funn);
 				func = pciehp_slot_find(busn, devn, funn);
 				dbg("%s: func = %p\n", __FUNCTION__,func);
-				if (!func)
-					continue;
-				configure_existing_function(ctrl, func);
+				if (!func) {
+					memset(&new_func, 0, sizeof(struct pci_func));
+					new_func.bus = busn;
+					new_func.device = devn;
+					new_func.function = funn;
+					new_func.is_a_board = 1;
+					configure_existing_function(ctrl, &new_func);
+					phprm_dump_func_res(&new_func);
+				} else {
+					configure_existing_function(ctrl, func);
+					phprm_dump_func_res(func);
+				}
 				dbg("aCCF:existing PCI 0x%x Func ResourceDump\n", ctrl->bus);
-				phprm_dump_func_res(func);
 			}
 		}
 	}
diff -Nru a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
--- a/drivers/pci/hotplug/shpchp.h	2004-06-24 13:52:05 -07:00
+++ b/drivers/pci/hotplug/shpchp.h	2004-06-24 13:52:05 -07:00
@@ -61,6 +61,7 @@
 	u8 configured;
 	u8 switch_save;
 	u8 presence_save;
+	u8 pwr_save;
 	u32 base_length[0x06];
 	u8 base_type[0x06];
 	u16 reserved2;
diff -Nru a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
--- a/drivers/pci/hotplug/shpchp_ctrl.c	2004-06-24 13:52:05 -07:00
+++ b/drivers/pci/hotplug/shpchp_ctrl.c	2004-06-24 13:52:05 -07:00
@@ -137,6 +137,8 @@
 	p_slot = shpchp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
 	p_slot->hpc_ops->get_adapter_status(p_slot, &(func->presence_save));
 	p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
+	dbg("%s: Card present %x Power status %x\n", __FUNCTION__,
+		func->presence_save, func->pwr_save);
 
 	if (getstatus) {
 		/*
@@ -145,6 +147,10 @@
 		info("Latch open on Slot(%d)\n", ctrl->first_slot + hp_slot);
 		func->switch_save = 0;
 		taskInfo->event_type = INT_SWITCH_OPEN;
+		if (func->pwr_save && func->presence_save) {
+			taskInfo->event_type = INT_POWER_FAULT;
+			err("Surprise Removal of card\n");
+		}
 	} else {
 		/*
 		 *  Switch closed
@@ -1427,6 +1433,7 @@
 					rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, adapter_speed);
 					if (rc) {
 						err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
+						up(&ctrl->crit_sect);
 						return WRONG_BUS_FREQUENCY;
 					}
 				
@@ -1438,6 +1445,7 @@
 						err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
 								  __FUNCTION__);
 						err("%s: Error code (%d)\n", __FUNCTION__, rc);
+						up(&ctrl->crit_sect);
 						return WRONG_BUS_FREQUENCY;
 					}
 					/* Done with exclusive hardware access */
@@ -1589,8 +1597,9 @@
 		func->status = 0;
 		func->switch_save = 0x10;
 		func->is_a_board = 0x01;
+		func->pwr_save = 1;
 
-		/* next, we will instantiate the linux pci_dev structures 
+		/* Next, we will instantiate the linux pci_dev structures 
 		 * (with appropriate driver notification, if already present) 
 		 */
 		index = 0;
@@ -1781,6 +1790,7 @@
 		func->function = 0;
 		func->configured = 0;
 		func->switch_save = 0x10;
+		func->pwr_save = 0;
 		func->is_a_board = 0;
 	}
 
@@ -1807,7 +1817,6 @@
 {
 	struct slot *p_slot = (struct slot *) slot;
 	u8 getstatus;
-	int rc;
 	
 	pushbutton_pending = 0;
 
@@ -1821,23 +1830,7 @@
 		p_slot->state = POWEROFF_STATE;
 		dbg("In power_down_board, b:d(%x:%x)\n", p_slot->bus, p_slot->device);
 
-		if (shpchp_disable_slot(p_slot)) {
-			/* Wait for exclusive access to hardware */
-			down(&p_slot->ctrl->crit_sect);
-
-			/* Turn on the Attention LED */
-			rc = p_slot->hpc_ops->set_attention_status(p_slot, 1);
-			if (rc) {
-				err("%s: Issue of Set Atten Indicator On command failed\n", __FUNCTION__);
-				return;
-			}
-	
-			/* Wait for the command to complete */
-			wait_for_ctrl_irq (p_slot->ctrl);
-
-			/* Done with exclusive hardware access */
-			up(&p_slot->ctrl->crit_sect);
-		}
+		shpchp_disable_slot(p_slot);
 		p_slot->state = STATIC_STATE;
 	} else {
 		p_slot->state = POWERON_STATE;
@@ -1847,15 +1840,6 @@
 			/* Wait for exclusive access to hardware */
 			down(&p_slot->ctrl->crit_sect);
 
-			/* Turn off the green LED */
-			rc = p_slot->hpc_ops->set_attention_status(p_slot, 1);
-			if (rc) {
-				err("%s: Issue of Set Atten Indicator On command failed\n", __FUNCTION__);
-				return;
-			}
-			/* Wait for the command to complete */
-			wait_for_ctrl_irq (p_slot->ctrl);
-			
 			p_slot->hpc_ops->green_led_off(p_slot);
 
 			/* Wait for the command to complete */
@@ -2096,7 +2080,7 @@
 	func = shpchp_slot_find(p_slot->bus, p_slot->device, 0);
 	if (!func) {
 		dbg("%s: Error! slot NULL\n", __FUNCTION__);
-		return (1);
+		return 1;
 	}
 
 	/* Check to see if (latch closed, card present, power off) */
@@ -2105,19 +2089,19 @@
 	if (rc || !getstatus) {
 		info("%s: no adapter on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return (0);
+		return 1;
 	}
 	rc = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 	if (rc || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return (0);
+		return 1;
 	}
 	rc = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
 	if (rc || getstatus) {
 		info("%s: already enabled on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return (0);
+		return 1;
 	}
 	up(&p_slot->ctrl->crit_sect);
 
@@ -2125,7 +2109,7 @@
 
 	func = shpchp_slot_create(p_slot->bus);
 	if (func == NULL)
-		return (1);
+		return 1;
 
 	func->bus = p_slot->bus;
 	func->device = p_slot->device;
@@ -2135,6 +2119,8 @@
 
 	/* We have to save the presence info for these slots */
 	p_slot->hpc_ops->get_adapter_status(p_slot, &(func->presence_save));
+	p_slot->hpc_ops->get_power_status(p_slot, &(func->pwr_save));
+	dbg("%s: func->pwr_save %x\n", __FUNCTION__, func->pwr_save);
 	p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 	func->switch_save = !getstatus? 0x10:0;
 
@@ -2181,7 +2167,7 @@
 	struct pci_func *func;
 
 	if (!p_slot->ctrl)
-		return (1);
+		return 1;
 
 	/* Check to see if (latch closed, card present, power on) */
 	down(&p_slot->ctrl->crit_sect);
@@ -2190,19 +2176,19 @@
 	if (ret || !getstatus) {
 		info("%s: no adapter on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return (0);
+		return 1;
 	}
 	ret = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 	if (ret || getstatus) {
 		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return (0);
+		return 1;
 	}
 	ret = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
 	if (ret || !getstatus) {
 		info("%s: already disabled slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
-		return (0);
+		return 1;
 	}
 	up(&p_slot->ctrl->crit_sect);
 
diff -Nru a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
--- a/drivers/pci/hotplug/shpchp_pci.c	2004-06-24 13:52:05 -07:00
+++ b/drivers/pci/hotplug/shpchp_pci.c	2004-06-24 13:52:05 -07:00
@@ -263,6 +263,7 @@
 				new_slot->function = (u8) function;
 				new_slot->is_a_board = 1;
 				new_slot->switch_save = 0x10;
+				new_slot->pwr_save = 1;
 				/* In case of unsupported board */
 				new_slot->status = DevError;
 				new_slot->pci_dev = pci_find_slot(new_slot->bus,
diff -Nru a/drivers/pci/hotplug/shpchprm_acpi.c b/drivers/pci/hotplug/shpchprm_acpi.c
--- a/drivers/pci/hotplug/shpchprm_acpi.c	2004-06-24 13:52:05 -07:00
+++ b/drivers/pci/hotplug/shpchprm_acpi.c	2004-06-24 13:52:05 -07:00
@@ -218,6 +218,10 @@
 	}
 
 	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
+	if (!ab->_hpp) {
+		err ("acpi_shpchprm:%s alloc for _HPP failed\n", path_name);
+		goto free_and_return;
+	}
 	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
 
 	ab->_hpp->cache_line_size	= nui[0];
@@ -1391,7 +1395,7 @@
 
 static int bind_pci_resources_to_slots ( struct controller *ctrl)
 {
-	struct pci_func *func;
+	struct pci_func *func, new_func;
 	int busn = ctrl->bus;
 	int devn, funn;
 	u32	vid;
@@ -1406,11 +1410,19 @@
 
 			if (vid != 0xFFFFFFFF) {
 				func = shpchp_slot_find(busn, devn, funn);
-				if (!func)
-					continue;
-				configure_existing_function(ctrl, func);
+				if (!func) {
+					memset(&new_func, 0, sizeof(struct pci_func));
+					new_func.bus = busn;
+					new_func.device = devn;
+					new_func.function = funn;
+					new_func.is_a_board = 1;
+					configure_existing_function(ctrl, &new_func);
+					shpchprm_dump_func_res(&new_func);
+				} else {
+					configure_existing_function(ctrl, func);
+					shpchprm_dump_func_res(func);
+				}
 				dbg("aCCF:existing PCI 0x%x Func ResourceDump\n", ctrl->bus);
-				shpchprm_dump_func_res(func);
 			}
 		}
 	}
diff -Nru a/drivers/pci/hotplug/shpchprm_nonacpi.c b/drivers/pci/hotplug/shpchprm_nonacpi.c
--- a/drivers/pci/hotplug/shpchprm_nonacpi.c	2004-06-24 13:52:05 -07:00
+++ b/drivers/pci/hotplug/shpchprm_nonacpi.c	2004-06-24 13:52:05 -07:00
@@ -208,7 +208,7 @@
 
 static int bind_pci_resources_to_slots ( struct controller *ctrl)
 {
-	struct pci_func *func;
+	struct pci_func *func, new_func;
 	int busn = ctrl->slot_bus;
 	int devn, funn;
 	u32	vid;
@@ -226,11 +226,19 @@
 
 			if (vid != 0xFFFFFFFF) {
 				func = shpchp_slot_find(busn, devn, funn);
-				if (!func)
-					continue;
-				configure_existing_function(ctrl, func);
+				if (!func) {
+					memset(&new_func, 0, sizeof(struct pci_func));
+					new_func.bus = busn;
+					new_func.device = devn;
+					new_func.function = funn;
+					new_func.is_a_board = 1;
+					configure_existing_function(ctrl, &new_func);
+					phprm_dump_func_res(&new_func);
+				} else {
+					configure_existing_function(ctrl, func);
+					phprm_dump_func_res(func);
+				}
 				dbg("aCCF:existing PCI 0x%x Func ResourceDump\n", ctrl->bus);
-				phprm_dump_func_res(func);
 			}
 		}
 	}

