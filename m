Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270193AbUJTF4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270193AbUJTF4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 01:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270194AbUJSXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:30:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:13450 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270148AbUJSWqf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:35 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257352301@kroah.com>
Date: Tue, 19 Oct 2004 15:42:16 -0700
Message-Id: <10982257364148@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.30, 2004/10/06 12:51:12-07:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI Hotplug: change bus speed patch

Greg,


Here is a patch (against 2.6.8-rc2) that fixes the following things:
1) adds code to lower bus speed if the adapter card added run at a
lower speed that the current bus speed; 2) checks for any devices on
the same bus - not just those that sit on slots controlled by the same
shpc; 3) cleans up the code in the check bus speed area in board_added()
by creating two functions to handle common code.

Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/shpchp_ctrl.c |  449 +++++++++-----------------------------
 1 files changed, 110 insertions(+), 339 deletions(-)


diff -Nru a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
--- a/drivers/pci/hotplug/shpchp_ctrl.c	2004-10-19 15:25:03 -07:00
+++ b/drivers/pci/hotplug/shpchp_ctrl.c	2004-10-19 15:25:03 -07:00
@@ -1050,7 +1050,64 @@
 /* The following routines constitute the bulk of the 
    hotplug controller logic
  */
+static u32 change_bus_speed(struct controller *ctrl, struct slot *p_slot, enum pci_bus_speed speed)
+{ 
+	u32 rc = 0;
 
+	dbg("%s: change to speed %d\n", __FUNCTION__, speed);
+	down(&ctrl->crit_sect);
+	if ((rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, speed))) {
+		err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
+		up(&ctrl->crit_sect);
+		return WRONG_BUS_FREQUENCY;
+	}
+	wait_for_ctrl_irq (ctrl);
+		
+	if ((rc = p_slot->hpc_ops->check_cmd_status(ctrl))) {
+		err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
+			  __FUNCTION__);
+		err("%s: Error code (%d)\n", __FUNCTION__, rc);
+		up(&ctrl->crit_sect);
+		return WRONG_BUS_FREQUENCY;
+	}
+	up(&ctrl->crit_sect);
+	return rc;
+}
+
+static u32 fix_bus_speed(struct controller *ctrl, struct slot *pslot, u8 flag, 
+enum pci_bus_speed asp, enum pci_bus_speed bsp, enum pci_bus_speed msp)
+{ 
+	u32 rc = 0;
+	
+	if (flag != 0) { /* Other slots on the same bus are occupied */
+		if ( asp < bsp ) {
+			err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bsp, asp);
+			return WRONG_BUS_FREQUENCY;
+		}
+	} else {
+		/* Other slots on the same bus are empty */
+		if (msp == bsp) {
+		/* if adapter_speed >= bus_speed, do nothing */
+			if (asp < bsp) {
+				/* 
+				* Try to lower bus speed to accommodate the adapter if other slots 
+				* on the same controller are empty
+				*/
+				if ((rc = change_bus_speed(ctrl, pslot, asp)))
+					return rc;
+			} 
+		} else {
+			if (asp < msp) {
+				if ((rc = change_bus_speed(ctrl, pslot, asp)))
+					return rc;
+			} else {
+				if ((rc = change_bus_speed(ctrl, pslot, msp)))
+					return rc;
+			}
+		}
+	}
+	return rc;
+}
 
 /**
  * board_added - Called after a board has been added to the system.
@@ -1061,14 +1118,13 @@
  */
 static u32 board_added(struct pci_func * func, struct controller * ctrl)
 {
-	u8 hp_slot, slot;
+	u8 hp_slot;
 	u8 slots_not_empty = 0;
 	int index;
 	u32 temp_register = 0xFFFFFFFF;
 	u32 retval, rc = 0;
 	struct pci_func *new_func = NULL;
-	struct pci_func *t_func = NULL;
-	struct slot *p_slot, *pslot;
+	struct slot *p_slot;
 	struct resource_lists res_lists;
 	enum pci_bus_speed adapter_speed, bus_speed, max_bus_speed;
 	u8 pi, mode;
@@ -1132,258 +1188,72 @@
 	/* Done with exclusive hardware access */
 	up(&ctrl->crit_sect);
 
-	rc  = p_slot->hpc_ops->get_prog_int(p_slot, &pi);
-	if (rc) {
+	if ((rc  = p_slot->hpc_ops->get_prog_int(p_slot, &pi))) {
 		err("%s: Can't get controller programming interface, set it to 1\n", __FUNCTION__);
 		pi = 1;
 	}
+
+	/* Check if there are other slots or devices on the same bus */
+	if (!list_empty(&ctrl->pci_dev->subordinate->devices))
+		slots_not_empty = 1;
+
+	dbg("%s: slots_not_empty %d, pi %d\n", __FUNCTION__, 
+		slots_not_empty, pi);
+	dbg("adapter_speed %d, bus_speed %d, max_bus_speed %d\n", 
+		adapter_speed, bus_speed, max_bus_speed);
+
 	if (pi == 2) {
-		for ( slot = 0; slot < ctrl->num_slots; slot++) {
-			if (slot != hp_slot) {
-				pslot = shpchp_find_slot(ctrl, slot + ctrl->slot_device_offset);
-				t_func = shpchp_slot_find(pslot->bus, pslot->device, 0);
-				slots_not_empty |= t_func->is_a_board;
-			}
+		dbg("%s: In PI = %d\n", __FUNCTION__, pi);
+		if ((rc = p_slot->hpc_ops->get_mode1_ECC_cap(p_slot, &mode))) {
+			err("%s: Can't get Mode1_ECC, set mode to 0\n", __FUNCTION__);
+			mode = 0;
 		}
 
 		switch (adapter_speed) {
-		case PCI_SPEED_133MHz_PCIX_533:	
+		case PCI_SPEED_133MHz_PCIX_533:
 		case PCI_SPEED_133MHz_PCIX_266:
-			if ((( bus_speed < 0xa ) || (bus_speed < 0xd)) && (max_bus_speed > bus_speed) &&
-				((max_bus_speed <= 0xa) || (max_bus_speed <= 0xd)) && (!slots_not_empty)) {
-			
-				/* Wait for exclusive access to hardware */
-				down(&ctrl->crit_sect);
-
-				rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, max_bus_speed);
-				if (rc) {
-					err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);				
-					return WRONG_BUS_FREQUENCY;
-				}
-				
-				/* Wait for the command to complete */
-				wait_for_ctrl_irq (ctrl);
-		
-				rc = p_slot->hpc_ops->check_cmd_status(ctrl);
-				if (rc) {
-					err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
-							  __FUNCTION__);
-					err("%s: Error code (%d)\n", __FUNCTION__, rc);
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);				
-					return WRONG_BUS_FREQUENCY;
-				}
-				/* Done with exclusive hardware access */
-				up(&ctrl->crit_sect);
-			}
-			break;
+			if ((bus_speed != adapter_speed) &&
+			   ((rc = fix_bus_speed(ctrl, p_slot, slots_not_empty, adapter_speed, bus_speed, max_bus_speed)))) 
+				return rc;
+			break;	
 		case PCI_SPEED_133MHz_PCIX_ECC:
 		case PCI_SPEED_133MHz_PCIX:
-
-			rc = p_slot->hpc_ops->get_mode1_ECC_cap(p_slot, &mode);
-
-			if (rc) {
-				err("%s: PI is 1 \n", __FUNCTION__);
-				return WRONG_BUS_FREQUENCY;
-			}
-
 			if (mode) { /* Bus - Mode 1 ECC */
-
-				if (bus_speed > 0x7)  {
-					err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
-					return WRONG_BUS_FREQUENCY;
-				}
-
-				if ((bus_speed < 0x7) && (max_bus_speed <= 0x7) &&
-					(bus_speed < max_bus_speed) && (!slots_not_empty)) {
-
-					/* Wait for exclusive access to hardware */
-					down(&ctrl->crit_sect);
-
-					rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, max_bus_speed);
-					if (rc) {
-						err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
-						/* Done with exclusive hardware access */
-						up(&ctrl->crit_sect);				
-						return WRONG_BUS_FREQUENCY;
-					}
-				
-					/* Wait for the command to complete */
-					wait_for_ctrl_irq (ctrl);
-		
-					rc = p_slot->hpc_ops->check_cmd_status(ctrl);
-					if (rc) {
-						err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
-							  __FUNCTION__);
-						err("%s: Error code (%d)\n", __FUNCTION__, rc);
-						/* Done with exclusive hardware access */
-						up(&ctrl->crit_sect);				
-						return WRONG_BUS_FREQUENCY;
-					}
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);
-				}
+				if ((bus_speed != 0x7) &&
+				   ((rc = fix_bus_speed(ctrl, p_slot, slots_not_empty, adapter_speed, bus_speed, max_bus_speed)))) 
+					return rc;
 			} else {
-				if (bus_speed > 0x4) {
-					err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
-					return WRONG_BUS_FREQUENCY;
-				}
-
-				if ((bus_speed < 0x4) && (max_bus_speed <= 0x4) &&
-					(bus_speed < max_bus_speed) && (!slots_not_empty)) {
-
-					/* Wait for exclusive access to hardware */
-					down(&ctrl->crit_sect);
-
-					rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, max_bus_speed);
-					if (rc) {
-						err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
-						/* Done with exclusive hardware access */
-						up(&ctrl->crit_sect);				
-						return WRONG_BUS_FREQUENCY;
-					}
-				
-					/* Wait for the command to complete */
-					wait_for_ctrl_irq (ctrl);
-		
-					rc = p_slot->hpc_ops->check_cmd_status(ctrl);
-					if (rc) {
-						err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
-							  __FUNCTION__);
-						err("%s: Error code (%d)\n", __FUNCTION__, rc);
-						/* Done with exclusive hardware access */
-						up(&ctrl->crit_sect);				
-						return WRONG_BUS_FREQUENCY;
-					}
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);
-				}
+				if ((bus_speed != 0x4) &&
+				   ((rc = fix_bus_speed(ctrl, p_slot, slots_not_empty, adapter_speed, bus_speed, max_bus_speed)))) 
+					return rc;
 			}
 			break;
 		case PCI_SPEED_66MHz_PCIX_ECC:
 		case PCI_SPEED_66MHz_PCIX:
-
-			rc = p_slot->hpc_ops->get_mode1_ECC_cap(p_slot, &mode);
-
-			if (rc) {
-				err("%s: PI is 1 \n", __FUNCTION__);
-				return WRONG_BUS_FREQUENCY;
-			}
-
 			if (mode) { /* Bus - Mode 1 ECC */
-
-				if (bus_speed > 0x5)  {
-					err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
-					return WRONG_BUS_FREQUENCY;
-				}
-
-				if ((bus_speed < 0x5) && (max_bus_speed <= 0x5) &&
-					(bus_speed < max_bus_speed) && (!slots_not_empty)) {
-
-					/* Wait for exclusive access to hardware */
-					down(&ctrl->crit_sect);
-
-					rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, max_bus_speed);
-					if (rc) {
-						err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
-						/* Done with exclusive hardware access */
-						up(&ctrl->crit_sect);				
-						return WRONG_BUS_FREQUENCY;
-					}
-				
-					/* Wait for the command to complete */
-					wait_for_ctrl_irq (ctrl);
-		
-					rc = p_slot->hpc_ops->check_cmd_status(ctrl);
-					if (rc) {
-						err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
-							  __FUNCTION__);
-						err("%s: Error code (%d)\n", __FUNCTION__, rc);
-						/* Done with exclusive hardware access */
-						up(&ctrl->crit_sect);				
-						return WRONG_BUS_FREQUENCY;
-					}
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);
-				}
+				if ((bus_speed != 0x5) &&
+				   ((rc = fix_bus_speed(ctrl, p_slot, slots_not_empty, adapter_speed, bus_speed, max_bus_speed)))) 
+					return rc;
 			} else {
-				if (bus_speed > 0x2) {
-					err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
-					return WRONG_BUS_FREQUENCY;
-				}
-
-				if ((bus_speed < 0x2) && (max_bus_speed <= 0x2) &&
-					(bus_speed < max_bus_speed) && (!slots_not_empty)) {
-
-					/* Wait for exclusive access to hardware */
-					down(&ctrl->crit_sect);
-
-					rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, max_bus_speed);
-					if (rc) {
-						err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
-						/* Done with exclusive hardware access */
-						up(&ctrl->crit_sect);				
-						return WRONG_BUS_FREQUENCY;
-					}
-				
-					/* Wait for the command to complete */
-					wait_for_ctrl_irq (ctrl);
-		
-					rc = p_slot->hpc_ops->check_cmd_status(ctrl);
-					if (rc) {
-						err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
-							  __FUNCTION__);
-						err("%s: Error code (%d)\n", __FUNCTION__, rc);
-						/* Done with exclusive hardware access */
-						up(&ctrl->crit_sect);				
-						return WRONG_BUS_FREQUENCY;
-					}
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);
-				}
+				if ((bus_speed != 0x2) &&
+				   ((rc = fix_bus_speed(ctrl, p_slot, slots_not_empty, adapter_speed, bus_speed, max_bus_speed)))) 
+					return rc;
 			}
 			break;
 		case PCI_SPEED_66MHz:
-			if (bus_speed > 0x1) {
-				err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
-				return WRONG_BUS_FREQUENCY;
-			}
-			if (bus_speed == 0x1)
-				;
-			if ((bus_speed == 0x0) && ( max_bus_speed == 0x1))  {
-				/* Wait for exclusive access to hardware */
-				down(&ctrl->crit_sect);
-
-				rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, max_bus_speed);
-				if (rc) {
-					err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);				
-					return WRONG_BUS_FREQUENCY;
-				}
-				
-				/* Wait for the command to complete */
-				wait_for_ctrl_irq (ctrl);
-		
-				rc = p_slot->hpc_ops->check_cmd_status(ctrl);
-				if (rc) {
-					err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
-							  __FUNCTION__);
-					err("%s: Error code (%d)\n", __FUNCTION__, rc);
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);				
-					return WRONG_BUS_FREQUENCY;
-				}
-				/* Done with exclusive hardware access */
-				up(&ctrl->crit_sect);
-			}
+			if ((bus_speed != 0x1) &&
+			   ((rc = fix_bus_speed(ctrl, p_slot, slots_not_empty, adapter_speed, bus_speed, max_bus_speed)))) 
+				return rc;
 			break;	
 		case PCI_SPEED_33MHz:
 			if (bus_speed > 0x0) {
-				err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
-				return WRONG_BUS_FREQUENCY;
+				if (slots_not_empty == 0) {
+					if ((rc = change_bus_speed(ctrl, p_slot, adapter_speed)))
+						return rc;
+				} else {
+					err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
+					return WRONG_BUS_FREQUENCY;
+				}
 			}
 			break;
 		default:
@@ -1391,133 +1261,34 @@
 			return WRONG_BUS_FREQUENCY;
 		}
 	} else {
-		/* if adpater_speed == bus_speed, nothing to do here */
-		if (adapter_speed != bus_speed) {
-			for ( slot = 0; slot < ctrl->num_slots; slot++) {
-				if (slot != hp_slot) {
-					pslot = shpchp_find_slot(ctrl, slot + ctrl->slot_device_offset);
-					t_func = shpchp_slot_find(pslot->bus, pslot->device, 0);
-					slots_not_empty |= t_func->is_a_board;
-				}
-			}
-
-			if (slots_not_empty != 0) { /* Other slots on the same bus are occupied */
-				if ( adapter_speed < bus_speed ) {
-					err("%s: speed of bus %x and adapter %x mismatch\n", __FUNCTION__, bus_speed, adapter_speed);
-					return WRONG_BUS_FREQUENCY;
-				}
-				/* Do nothing if adapter_speed >= bus_speed */
-			}
-		}
-			
-		if ((adapter_speed != bus_speed) && (slots_not_empty == 0))  {
-			/* Other slots on the same bus are empty */
-			
-			rc = p_slot->hpc_ops->get_max_bus_speed(p_slot, &max_bus_speed);
-			if (rc || max_bus_speed == PCI_SPEED_UNKNOWN) {
-				err("%s: Can't get max bus operation speed\n", __FUNCTION__);
-				max_bus_speed = bus_speed;
-			}
-
-			if (max_bus_speed == bus_speed) {
-				/* if adapter_speed >= bus_speed, do nothing */
-				if (adapter_speed < bus_speed) {
-				/* 
-				 * Try to lower bus speed to accommodate the adapter if other slots 
-				 * on the same controller are empty
-				 */
-					
-					/* Wait for exclusive access to hardware */
-					down(&ctrl->crit_sect);
-
-					rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, adapter_speed);
-					if (rc) {
-						err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
-						up(&ctrl->crit_sect);
-						return WRONG_BUS_FREQUENCY;
-					}
-				
-					/* Wait for the command to complete */
-					wait_for_ctrl_irq (ctrl);
-		
-					rc = p_slot->hpc_ops->check_cmd_status(ctrl);
-					if (rc) {
-						err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n",
-								  __FUNCTION__);
-						err("%s: Error code (%d)\n", __FUNCTION__, rc);
-						up(&ctrl->crit_sect);
-						return WRONG_BUS_FREQUENCY;
-					}
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);
-
-				} 
-			} else {
-				/* Wait for exclusive access to hardware */
-				down(&ctrl->crit_sect);
-
-				/* max_bus_speed != bus_speed. Note: max_bus_speed should be > than bus_speed */
-				if (adapter_speed < max_bus_speed) 
-					rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, adapter_speed);
-				else  
-					rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, max_bus_speed);
-				
-				if (rc) {
-					err("%s: Issue of set bus speed mode command failed\n", __FUNCTION__);
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);
-					return WRONG_BUS_FREQUENCY;
-				}
-				
-				/* Wait for the command to complete */
-				wait_for_ctrl_irq (ctrl);
-		
-				rc = p_slot->hpc_ops->check_cmd_status(ctrl);
-				if (rc) {
-					err("%s: Can't set bus speed/mode in the case of adapter & bus mismatch\n", 
-						__FUNCTION__);
-					err("%s: Error code (%d)\n", __FUNCTION__, rc);
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);
-					return WRONG_BUS_FREQUENCY;
-				}
-				/* Done with exclusive hardware access */
-				up(&ctrl->crit_sect);
-
-			}
-		}
+		/* If adpater_speed == bus_speed, nothing to do here */
+		dbg("%s: In PI = %d\n", __FUNCTION__, pi);
+		if ((adapter_speed != bus_speed) &&
+		   ((rc = fix_bus_speed(ctrl, p_slot, slots_not_empty, adapter_speed, bus_speed, max_bus_speed))))
+				return rc;
 	}
 
-	/* Wait for exclusive access to hardware */
 	down(&ctrl->crit_sect);
-
 	/* turn on board, blink green LED, turn off Amber LED */
-	rc = p_slot->hpc_ops->slot_enable(p_slot);
-	
-	if (rc) {
+	if ((rc = p_slot->hpc_ops->slot_enable(p_slot))) {
 		err("%s: Issue of Slot Enable command failed\n", __FUNCTION__);
-		/* Done with exclusive hardware access */
 		up(&ctrl->crit_sect);
 		return rc;
 	}
-	/* Wait for the command to complete */
 	wait_for_ctrl_irq (ctrl);
 
-	rc = p_slot->hpc_ops->check_cmd_status(ctrl);
-	if (rc) {
+	if ((rc = p_slot->hpc_ops->check_cmd_status(ctrl))) {
 		err("%s: Failed to enable slot, error code(%d)\n", __FUNCTION__, rc);
-		/* Done with exclusive hardware access */
 		up(&ctrl->crit_sect);
 		return rc;  
 	}
 
-	/* Done with exclusive hardware access */
 	up(&ctrl->crit_sect);
 
 	/* Wait for ~1 second */
 	dbg("%s: before long_delay\n", __FUNCTION__);
 	wait_for_ctrl_irq (ctrl);
-	dbg("%s: afterlong_delay\n", __FUNCTION__);
+	dbg("%s: after long_delay\n", __FUNCTION__);
 
 	dbg("%s: func status = %x\n", __FUNCTION__, func->status);
 	/* Check for a power fault */
@@ -1890,7 +1661,7 @@
 	event_finished=0;
 
 	init_MUTEX_LOCKED(&event_semaphore);
-	pid = kernel_thread(event_thread, NULL, 0);
+	pid = kernel_thread(event_thread, 0, 0);
 
 	if (pid < 0) {
 		err ("Can't start up our event thread\n");

