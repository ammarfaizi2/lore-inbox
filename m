Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbUKLXlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbUKLXlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbUKLXjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:39:36 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27277 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262671AbUKLXWf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:35 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017152328@kroah.com>
Date: Fri, 12 Nov 2004 15:21:56 -0800
Message-Id: <11003017162896@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.55.2, 2004/11/01 14:51:06-08:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI: Updated patch to add ExpressCard support

This patch adds ExpressCard support to pciehp driver.  It also includes
the code that implements _OSC method call in driver/pci/pci-acpi.c for
use by the drivers.


Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/Makefile                |    5 
 drivers/pci/hotplug/pciehp.h        |   21 +
 drivers/pci/hotplug/pciehp_core.c   |   18 -
 drivers/pci/hotplug/pciehp_ctrl.c   |  382 ++++++++++++++++++++++--------------
 drivers/pci/hotplug/pciehp_hpc.c    |   30 +-
 drivers/pci/hotplug/pciehprm_acpi.c |   43 +++-
 drivers/pci/pci-acpi.c              |  209 +++++++++++++++++++
 include/linux/pci-acpi.h            |   61 +++++
 8 files changed, 601 insertions(+), 168 deletions(-)


diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	2004-11-12 15:13:59 -08:00
+++ b/drivers/pci/Makefile	2004-11-12 15:13:59 -08:00
@@ -28,6 +28,11 @@
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
 obj-$(CONFIG_PCI_MSI) += msi.o
 
+#
+# ACPI Related PCI FW Functions
+#
+obj-$(CONFIG_ACPI)    += pci-acpi.o
+
 # Cardbus & CompactPCI use setup-bus
 obj-$(CONFIG_HOTPLUG) += setup-bus.o
 
diff -Nru a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
--- a/drivers/pci/hotplug/pciehp.h	2004-11-12 15:13:59 -08:00
+++ b/drivers/pci/hotplug/pciehp.h	2004-11-12 15:13:59 -08:00
@@ -127,8 +127,7 @@
 	enum pci_bus_speed speed;
 	u32 first_slot;		/* First physical slot number */  /* PCIE only has 1 slot */
 	u8 slot_bus;		/* Bus where the slots handled by this controller sit */
-	u8 push_flag;
-	u16 ctlrcap;
+	u8 ctrlcap;
 	u16 vendor_id;
 };
 
@@ -180,6 +179,21 @@
 
 #define DISABLE_CARD			1
 
+/* Field definitions in Slot Capabilities Register */
+#define ATTN_BUTTN_PRSN	0x00000001
+#define	PWR_CTRL_PRSN	0x00000002
+#define MRL_SENS_PRSN	0x00000004
+#define ATTN_LED_PRSN	0x00000008
+#define PWR_LED_PRSN	0x00000010
+#define HP_SUPR_RM_SUP	0x00000020
+
+#define ATTN_BUTTN(cap)		(cap & ATTN_BUTTN_PRSN)
+#define POWER_CTRL(cap)		(cap & PWR_CTRL_PRSN)
+#define MRL_SENS(cap)		(cap & MRL_SENS_PRSN)
+#define ATTN_LED(cap)		(cap & ATTN_LED_PRSN)
+#define PWR_LED(cap)		(cap & PWR_LED_PRSN) 
+#define HP_SUPR_RM(cap)		(cap & HP_SUPR_RM_SUP)
+
 /*
  * error Messages
  */
@@ -312,8 +326,7 @@
 		int *num_ctlr_slots,
 		int *first_device_num,
 		int *physical_slot_num,
-		int *updown,
-		int *flags);
+		u8 *ctrlcap);
 
 struct hpc_ops {
 	int	(*power_on_slot)	(struct slot *slot);
diff -Nru a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
--- a/drivers/pci/hotplug/pciehp_core.c	2004-11-12 15:13:59 -08:00
+++ b/drivers/pci/hotplug/pciehp_core.c	2004-11-12 15:13:59 -08:00
@@ -204,11 +204,10 @@
 	int num_ctlr_slots;		/* Not needed; PCI Express has 1 slot per port*/
 	int first_device_num;		/* Not needed */
 	int physical_slot_num;
-	int updown;			/* Not needed */
+	u8 ctrlcap;			
 	int rc;
-	int flags;			/* Not needed */
 
-	rc = pcie_get_ctlr_slot_config(ctrl, &num_ctlr_slots, &first_device_num, &physical_slot_num, &updown, &flags);
+	rc = pcie_get_ctlr_slot_config(ctrl, &num_ctlr_slots, &first_device_num, &physical_slot_num, &ctrlcap);
 	if (rc) {
 		err("%s: get_ctlr_slot_config fail for b:d (%x:%x)\n", __FUNCTION__, ctrl->bus, ctrl->device);
 		return (-1);
@@ -217,10 +216,10 @@
 	ctrl->num_slots = num_ctlr_slots;	/* PCI Express has 1 slot per port */
 	ctrl->slot_device_offset = first_device_num;
 	ctrl->first_slot = physical_slot_num;
-	ctrl->slot_num_inc = updown; 	/* Not needed */		/* either -1 or 1 */
+	ctrl->ctrlcap = ctrlcap; 	
 
-	dbg("%s: bus(0x%x) num_slot(0x%x) 1st_dev(0x%x) psn(0x%x) updown(%d) for b:d (%x:%x)\n",
-		__FUNCTION__, ctrl->slot_bus, num_ctlr_slots, first_device_num, physical_slot_num, updown, 
+	dbg("%s: bus(0x%x) num_slot(0x%x) 1st_dev(0x%x) psn(0x%x) ctrlcap(%x) for b:d (%x:%x)\n",
+		__FUNCTION__, ctrl->slot_bus, num_ctlr_slots, first_device_num, physical_slot_num, ctrlcap, 
 		ctrl->bus, ctrl->device);
 
 	return (0);
@@ -237,7 +236,9 @@
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	hotplug_slot->info->attention_status = status;
-	slot->hpc_ops->set_attention_status(slot, status);
+	
+	if (ATTN_LED(slot->ctrl->ctrlcap)) 
+		slot->hpc_ops->set_attention_status(slot, status);
 
 	return 0;
 }
@@ -451,7 +452,8 @@
 
 	t_slot->hpc_ops->get_adapter_status(t_slot, &value); /* Check if slot is occupied */
 	dbg("%s: adpater value %x\n", __FUNCTION__, value);
-	if (!value) {
+	
+	if ((POWER_CTRL(ctrl->ctrlcap)) && !value) {
 		rc = t_slot->hpc_ops->power_off_slot(t_slot); /* Power off slot if not occupied*/
 		if (rc) {
 			/* Done with exclusive hardware access */
diff -Nru a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
--- a/drivers/pci/hotplug/pciehp_ctrl.c	2004-11-12 15:13:59 -08:00
+++ b/drivers/pci/hotplug/pciehp_ctrl.c	2004-11-12 15:13:59 -08:00
@@ -51,6 +51,7 @@
 static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */
+static unsigned long surprise_rm_pending;	/* = 0 */
 
 u8 pciehp_handle_attention_button(u8 hp_slot, void *inst_id)
 {
@@ -1063,25 +1064,29 @@
 	/* Wait for exclusive access to hardware */
 	down(&ctrl->crit_sect);
 
-	/* turn off slot, turn on Amber LED, turn off Green LED */
-	if (pslot->hpc_ops->power_off_slot(pslot)) {   
-		err("%s: Issue of Slot Power Off command failed\n", __FUNCTION__);
-		up(&ctrl->crit_sect);
-		return;
+	/* turn off slot, turn on Amber LED, turn off Green LED if supported*/
+	if (POWER_CTRL(ctrl->ctrlcap)) {
+		if (pslot->hpc_ops->power_off_slot(pslot)) {   
+			err("%s: Issue of Slot Power Off command failed\n", __FUNCTION__);
+			up(&ctrl->crit_sect);
+			return;
+		}
+		wait_for_ctrl_irq (ctrl);
 	}
-	wait_for_ctrl_irq (ctrl);
 
-	pslot->hpc_ops->green_led_off(pslot);   
-	
-	wait_for_ctrl_irq (ctrl);
+	if (PWR_LED(ctrl->ctrlcap)) {
+		pslot->hpc_ops->green_led_off(pslot);   
+		wait_for_ctrl_irq (ctrl);
+	}
 
-	/* turn on Amber LED */
-	if (pslot->hpc_ops->set_attention_status(pslot, 1)) {   
-		err("%s: Issue of Set Attention Led command failed\n", __FUNCTION__);
-		up(&ctrl->crit_sect);
-		return;
+	if (ATTN_LED(ctrl->ctrlcap)) { 
+		if (pslot->hpc_ops->set_attention_status(pslot, 1)) {   
+			err("%s: Issue of Set Attention Led command failed\n", __FUNCTION__);
+			up(&ctrl->crit_sect);
+			return;
+		}
+		wait_for_ctrl_irq (ctrl);
 	}
-	wait_for_ctrl_irq (ctrl);
 
 	/* Done with exclusive hardware access */
 	up(&ctrl->crit_sect);
@@ -1112,20 +1117,24 @@
 	/* Wait for exclusive access to hardware */
 	down(&ctrl->crit_sect);
 
-	/* Power on slot */
-	rc = p_slot->hpc_ops->power_on_slot(p_slot);
-	if (rc) {
-		up(&ctrl->crit_sect);
-		return -1;
-	}
+	if (POWER_CTRL(ctrl->ctrlcap)) {
+		/* Power on slot */
+		rc = p_slot->hpc_ops->power_on_slot(p_slot);
+		if (rc) {
+			up(&ctrl->crit_sect);
+			return -1;
+		}
 
-	/* Wait for the command to complete */
-	wait_for_ctrl_irq (ctrl);
+		/* Wait for the command to complete */
+		wait_for_ctrl_irq (ctrl);
+	}
 	
-	p_slot->hpc_ops->green_led_blink(p_slot);
+	if (PWR_LED(ctrl->ctrlcap)) {
+		p_slot->hpc_ops->green_led_blink(p_slot);
 			
-	/* Wait for the command to complete */
-	wait_for_ctrl_irq (ctrl);
+		/* Wait for the command to complete */
+		wait_for_ctrl_irq (ctrl);
+	}
 
 	/* Done with exclusive hardware access */
 	up(&ctrl->crit_sect);
@@ -1211,19 +1220,19 @@
 				pciehp_configure_device(ctrl, new_func);
 			}
 		} while (new_func);
-
-		/* Wait for exclusive access to hardware */
-		down(&ctrl->crit_sect);
-
-		p_slot->hpc_ops->green_led_on(p_slot);
-
-		/* Wait for the command to complete */
-		wait_for_ctrl_irq (ctrl);
-
-
-		/* Done with exclusive hardware access */
-		up(&ctrl->crit_sect);
-
+  		
+  		if (PWR_LED(ctrl->ctrlcap)) {
+  			/* Wait for exclusive access to hardware */
+  			down(&ctrl->crit_sect);
+   
+  			p_slot->hpc_ops->green_led_on(p_slot);
+  
+  			/* Wait for the command to complete */
+  			wait_for_ctrl_irq (ctrl);
+  	
+  			/* Done with exclusive hardware access */
+  			up(&ctrl->crit_sect);
+  		}
 	} else {
 		set_slot_off(ctrl, p_slot);
 		return -1;
@@ -1289,21 +1298,25 @@
 	/* Wait for exclusive access to hardware */
 	down(&ctrl->crit_sect);
 
-	/* power off slot */
-	rc = p_slot->hpc_ops->power_off_slot(p_slot);
-	if (rc) {
-		err("%s: Issue of Slot Disable command failed\n", __FUNCTION__);
-		up(&ctrl->crit_sect);
-		return rc;
+	if (POWER_CTRL(ctrl->ctrlcap)) {
+		/* power off slot */
+		rc = p_slot->hpc_ops->power_off_slot(p_slot);
+		if (rc) {
+			err("%s: Issue of Slot Disable command failed\n", __FUNCTION__);
+			up(&ctrl->crit_sect);
+			return rc;
+		}
+		/* Wait for the command to complete */
+		wait_for_ctrl_irq (ctrl);
 	}
-	/* Wait for the command to complete */
-	wait_for_ctrl_irq (ctrl);
 
-	/* turn off Green LED */
-	p_slot->hpc_ops->green_led_off(p_slot);
+	if (PWR_LED(ctrl->ctrlcap)) {
+		/* turn off Green LED */
+		p_slot->hpc_ops->green_led_off(p_slot);
 	
-	/* Wait for the command to complete */
-	wait_for_ctrl_irq (ctrl);
+		/* Wait for the command to complete */
+		wait_for_ctrl_irq (ctrl);
+	}
 
 	/* Done with exclusive hardware access */
 	up(&ctrl->crit_sect);
@@ -1368,7 +1381,6 @@
 	up(&event_semaphore);
 }
 
-
 /**
  * pciehp_pushbutton_thread
  *
@@ -1399,7 +1411,55 @@
 		p_slot->state = POWERON_STATE;
 		dbg("In add_board, b:d(%x:%x)\n", p_slot->bus, p_slot->device);
 
-		if (pciehp_enable_slot(p_slot)) {
+		if (pciehp_enable_slot(p_slot) && PWR_LED(p_slot->ctrl->ctrlcap)) {
+			/* Wait for exclusive access to hardware */
+			down(&p_slot->ctrl->crit_sect);
+
+			p_slot->hpc_ops->green_led_off(p_slot);
+
+			/* Wait for the command to complete */
+			wait_for_ctrl_irq (p_slot->ctrl);
+
+			/* Done with exclusive hardware access */
+			up(&p_slot->ctrl->crit_sect);
+		}
+		p_slot->state = STATIC_STATE;
+	}
+
+	return;
+}
+
+/**
+ * pciehp_surprise_rm_thread
+ *
+ * Scheduled procedure to handle blocking stuff for the surprise removal
+ * Handles all pending events and exits.
+ *
+ */
+static void pciehp_surprise_rm_thread(unsigned long slot)
+{
+	struct slot *p_slot = (struct slot *) slot;
+	u8 getstatus;
+	
+	surprise_rm_pending = 0;
+
+	if (!p_slot) {
+		dbg("%s: Error! slot NULL\n", __FUNCTION__);
+		return;
+	}
+
+	p_slot->hpc_ops->get_adapter_status(p_slot, &getstatus);
+	if (!getstatus) {
+		p_slot->state = POWEROFF_STATE;
+		dbg("In removing board, b:d(%x:%x)\n", p_slot->bus, p_slot->device);
+
+		pciehp_disable_slot(p_slot);
+		p_slot->state = STATIC_STATE;
+	} else {
+		p_slot->state = POWERON_STATE;
+		dbg("In add_board, b:d(%x:%x)\n", p_slot->bus, p_slot->device);
+
+		if (pciehp_enable_slot(p_slot) && PWR_LED(p_slot->ctrl->ctrlcap)) {
 			/* Wait for exclusive access to hardware */
 			down(&p_slot->ctrl->crit_sect);
 
@@ -1418,6 +1478,7 @@
 }
 
 
+
 /* this is the main worker thread */
 static int event_thread(void* data)
 {
@@ -1436,6 +1497,8 @@
 		/* Do stuff here */
 		if (pushbutton_pending)
 			pciehp_pushbutton_thread(pushbutton_pending);
+		else if (surprise_rm_pending)
+			pciehp_surprise_rm_thread(surprise_rm_pending);
 		else
 			for (ctrl = pciehp_ctrl_list; ctrl; ctrl=ctrl->next)
 				interrupt_event_handler(ctrl);
@@ -1528,16 +1591,18 @@
 					case BLINKINGOFF_STATE:
 						/* Wait for exclusive access to hardware */
 						down(&ctrl->crit_sect);
-
-						p_slot->hpc_ops->green_led_on(p_slot);
-						/* Wait for the command to complete */
-						wait_for_ctrl_irq (ctrl);
-
-						p_slot->hpc_ops->set_attention_status(p_slot, 0);
-
-						/* Wait for the command to complete */
-						wait_for_ctrl_irq (ctrl);
-
+						
+						if (PWR_LED(ctrl->ctrlcap)) {
+							p_slot->hpc_ops->green_led_on(p_slot);
+							/* Wait for the command to complete */
+							wait_for_ctrl_irq (ctrl);
+						}
+						if (ATTN_LED(ctrl->ctrlcap)) {
+							p_slot->hpc_ops->set_attention_status(p_slot, 0);
+
+							/* Wait for the command to complete */
+							wait_for_ctrl_irq (ctrl);
+						}
 						/* Done with exclusive hardware access */
 						up(&ctrl->crit_sect);
 						break;
@@ -1545,14 +1610,16 @@
 						/* Wait for exclusive access to hardware */
 						down(&ctrl->crit_sect);
 
-						p_slot->hpc_ops->green_led_off(p_slot);
-						/* Wait for the command to complete */
-						wait_for_ctrl_irq (ctrl);
-
-						p_slot->hpc_ops->set_attention_status(p_slot, 0);
-						/* Wait for the command to complete */
-						wait_for_ctrl_irq (ctrl);
-
+						if (PWR_LED(ctrl->ctrlcap)) {
+							p_slot->hpc_ops->green_led_off(p_slot);
+							/* Wait for the command to complete */
+							wait_for_ctrl_irq (ctrl);
+						}
+						if (ATTN_LED(ctrl->ctrlcap)){
+							p_slot->hpc_ops->set_attention_status(p_slot, 0);
+							/* Wait for the command to complete */
+							wait_for_ctrl_irq (ctrl);
+						}
 						/* Done with exclusive hardware access */
 						up(&ctrl->crit_sect);
 
@@ -1566,59 +1633,83 @@
 				}
 				/* ***********Button Pressed (No action on 1st press...) */
 				else if (ctrl->event_queue[loop].event_type == INT_BUTTON_PRESS) {
-					dbg("Button pressed\n");
-
-					p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
-					if (getstatus) {
-						/* slot is on */
-						dbg("slot is on\n");
-						p_slot->state = BLINKINGOFF_STATE;
-						info(msg_button_off, p_slot->number);
-					} else {
-						/* slot is off */
-						dbg("slot is off\n");
-						p_slot->state = BLINKINGON_STATE;
-						info(msg_button_on, p_slot->number);
-					}
-
-					/* Wait for exclusive access to hardware */
-					down(&ctrl->crit_sect);
-
-					/* blink green LED and turn off amber */
-					p_slot->hpc_ops->green_led_blink(p_slot);
-					/* Wait for the command to complete */
-					wait_for_ctrl_irq (ctrl);
 					
-					p_slot->hpc_ops->set_attention_status(p_slot, 0);
+					if (ATTN_BUTTN(ctrl->ctrlcap)) {
+						dbg("Button pressed\n");
+						p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
+						if (getstatus) {
+							/* slot is on */
+							dbg("slot is on\n");
+							p_slot->state = BLINKINGOFF_STATE;
+							info(msg_button_off, p_slot->number);
+						} else {
+							/* slot is off */
+							dbg("slot is off\n");
+							p_slot->state = BLINKINGON_STATE;
+							info(msg_button_on, p_slot->number);
+						}
 
-					/* Wait for the command to complete */
-					wait_for_ctrl_irq (ctrl);
+						/* Wait for exclusive access to hardware */
+						down(&ctrl->crit_sect);
 
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);
+						/* blink green LED and turn off amber */
+						if (PWR_LED(ctrl->ctrlcap)) {
+							p_slot->hpc_ops->green_led_blink(p_slot);
+							/* Wait for the command to complete */
+							wait_for_ctrl_irq (ctrl);
+						}
+
+						if (ATTN_LED(ctrl->ctrlcap)) {
+							p_slot->hpc_ops->set_attention_status(p_slot, 0);
+
+							/* Wait for the command to complete */
+							wait_for_ctrl_irq (ctrl);
+						}
+
+						/* Done with exclusive hardware access */
+						up(&ctrl->crit_sect);
 
-					init_timer(&p_slot->task_event);
-					p_slot->task_event.expires = jiffies + 5 * HZ;   /* 5 second delay */
-					p_slot->task_event.function = (void (*)(unsigned long)) pushbutton_helper_thread;
-					p_slot->task_event.data = (unsigned long) p_slot;
+						init_timer(&p_slot->task_event);
+						p_slot->task_event.expires = jiffies + 5 * HZ;   /* 5 second delay */
+						p_slot->task_event.function = (void (*)(unsigned long)) pushbutton_helper_thread;
+						p_slot->task_event.data = (unsigned long) p_slot;
 
-					dbg("add_timer p_slot = %p\n", (void *) p_slot);
-					add_timer(&p_slot->task_event);
+						dbg("add_timer p_slot = %p\n", (void *) p_slot);
+						add_timer(&p_slot->task_event);
+					}
 				}
 				/***********POWER FAULT********************/
 				else if (ctrl->event_queue[loop].event_type == INT_POWER_FAULT) {
-					dbg("power fault\n");
-					/* Wait for exclusive access to hardware */
-					down(&ctrl->crit_sect);
+					if (POWER_CTRL(ctrl->ctrlcap)) {
+						dbg("power fault\n");
+						/* Wait for exclusive access to hardware */
+						down(&ctrl->crit_sect);
 
-					p_slot->hpc_ops->set_attention_status(p_slot, 1);
-					wait_for_ctrl_irq (ctrl);
-						
-					p_slot->hpc_ops->green_led_off(p_slot);
-					wait_for_ctrl_irq (ctrl);
+						if (ATTN_LED(ctrl->ctrlcap)) {
+							p_slot->hpc_ops->set_attention_status(p_slot, 1);
+							wait_for_ctrl_irq (ctrl);
+						}
+
+						if (PWR_LED(ctrl->ctrlcap)) {
+							p_slot->hpc_ops->green_led_off(p_slot);
+							wait_for_ctrl_irq (ctrl);
+						}
 
-					/* Done with exclusive hardware access */
-					up(&ctrl->crit_sect);
+						/* Done with exclusive hardware access */
+						up(&ctrl->crit_sect);
+					}
+				}
+				/***********SURPRISE REMOVAL********************/
+				else if ((ctrl->event_queue[loop].event_type == INT_PRESENCE_ON) || 
+					(ctrl->event_queue[loop].event_type == INT_PRESENCE_OFF)) {
+					if (HP_SUPR_RM(ctrl->ctrlcap)) {
+						dbg("Surprise Removal\n");
+						if (p_slot) {
+							surprise_rm_pending = (unsigned long) p_slot;
+							up(&event_semaphore);
+							update_slot_info(p_slot);
+						}
+					}
 				} else {
 					/* refresh notification */
 					if (p_slot)
@@ -1648,25 +1739,29 @@
 
 	/* Check to see if (latch closed, card present, power off) */
 	down(&p_slot->ctrl->crit_sect);
+
 	rc = p_slot->hpc_ops->get_adapter_status(p_slot, &getstatus);
 	if (rc || !getstatus) {
 		info("%s: no adapter on slot(%x)\n", __FUNCTION__, p_slot->number);
 		up(&p_slot->ctrl->crit_sect);
 		return 1;
 	}
-	
-	rc = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
-	if (rc || getstatus) {
-		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
-		up(&p_slot->ctrl->crit_sect);
-		return 1;
+	if (MRL_SENS(p_slot->ctrl->ctrlcap)) {	
+		rc = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
+		if (rc || getstatus) {
+			info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
+			up(&p_slot->ctrl->crit_sect);
+			return 1;
+		}
 	}
 	
-	rc = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
-	if (rc || getstatus) {
-		info("%s: already enabled on slot(%x)\n", __FUNCTION__, p_slot->number);
-		up(&p_slot->ctrl->crit_sect);
-		return 1;
+	if (POWER_CTRL(p_slot->ctrl->ctrlcap)) {	
+		rc = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
+		if (rc || getstatus) {
+			info("%s: already enabled on slot(%x)\n", __FUNCTION__, p_slot->number);
+			up(&p_slot->ctrl->crit_sect);
+			return 1;
+		}
 	}
 	up(&p_slot->ctrl->crit_sect);
 
@@ -1735,26 +1830,33 @@
 	/* Check to see if (latch closed, card present, power on) */
 	down(&p_slot->ctrl->crit_sect);
 
-	ret = p_slot->hpc_ops->get_adapter_status(p_slot, &getstatus);
-	if (ret || !getstatus) {
-		info("%s: no adapter on slot(%x)\n", __FUNCTION__, p_slot->number);
-		up(&p_slot->ctrl->crit_sect);
-		return 1;
+	if (!HP_SUPR_RM(p_slot->ctrl->ctrlcap)) {	
+		ret = p_slot->hpc_ops->get_adapter_status(p_slot, &getstatus);
+		if (ret || !getstatus) {
+			info("%s: no adapter on slot(%x)\n", __FUNCTION__, p_slot->number);
+			up(&p_slot->ctrl->crit_sect);
+			return 1;
+		}
 	}
 
-	ret = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
-	if (ret || getstatus) {
-		info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
-		up(&p_slot->ctrl->crit_sect);
-		return 1;
+	if (MRL_SENS(p_slot->ctrl->ctrlcap)) {	
+		ret = p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
+		if (ret || getstatus) {
+			info("%s: latch open on slot(%x)\n", __FUNCTION__, p_slot->number);
+			up(&p_slot->ctrl->crit_sect);
+			return 1;
+		}
 	}
 
-	ret = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
-	if (ret || !getstatus) {
-		info("%s: already disabled slot(%x)\n", __FUNCTION__, p_slot->number);
-		up(&p_slot->ctrl->crit_sect);
-		return 1;
+	if (POWER_CTRL(p_slot->ctrl->ctrlcap)) {	
+		ret = p_slot->hpc_ops->get_power_status(p_slot, &getstatus);
+		if (ret || !getstatus) {
+			info("%s: already disabled slot(%x)\n", __FUNCTION__, p_slot->number);
+			up(&p_slot->ctrl->crit_sect);
+			return 1;
+		}
 	}
+
 	up(&p_slot->ctrl->crit_sect);
 
 	func = pciehp_slot_find(p_slot->bus, p_slot->device, index++);
diff -Nru a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
--- a/drivers/pci/hotplug/pciehp_hpc.c	2004-11-12 15:13:59 -08:00
+++ b/drivers/pci/hotplug/pciehp_hpc.c	2004-11-12 15:13:59 -08:00
@@ -182,7 +182,7 @@
 #define MRL_SENS_PRSN	0x00000004
 #define ATTN_LED_PRSN	0x00000008
 #define PWR_LED_PRSN	0x00000010
-#define HP_SUPR_RM	0x00000020
+#define HP_SUPR_RM_SUP	0x00000020
 #define HP_CAP		0x00000040
 #define SLOT_PWR_VALUE	0x000003F8
 #define SLOT_PWR_LIMIT	0x00000C00
@@ -237,8 +237,8 @@
 static spinlock_t hpc_event_lock;
 
 DEFINE_DBG_BUFFER		/* Debug string buffer for entire HPC defined here */
-static struct php_ctlr_state_s *php_ctlr_list_head;	/* HPC state linked list */
-static int ctlr_seq_num;	/* Controller sequence # */
+static struct php_ctlr_state_s *php_ctlr_list_head = 0;	/* HPC state linked list */
+static int ctlr_seq_num = 0;	/* Controller sequence # */
 static spinlock_t list_lock;
 
 static irqreturn_t pcie_isr(int IRQ, void *dev_id, struct pt_regs *regs);
@@ -691,8 +691,7 @@
 	int *num_ctlr_slots,	/* number of slots in this HPC; only 1 in PCIE  */	
 	int *first_device_num,	/* PCI dev num of the first slot in this PCIE	*/
 	int *physical_slot_num,	/* phy slot num of the first slot in this PCIE	*/
-	int *updown,		/* physical_slot_num increament: 1 or -1	*/
-	int *flags)
+	u8 *ctrlcap)
 {
 	struct php_ctlr_state_s *php_ctlr = ctrl->hpc_ctlr_handle;
 	u32 slot_cap;
@@ -716,8 +715,9 @@
 	}
 	
 	*physical_slot_num = slot_cap >> 19;
-
-	*updown = -1;
+	dbg("%s: PSN %d \n", __FUNCTION__, *physical_slot_num);
+	
+	*ctrlcap = slot_cap & 0x0000007f;
 
 	DBG_LEAVE_ROUTINE 
 	return 0;
@@ -1259,7 +1259,7 @@
 	static int first = 1;
 	u16 temp_word;
 	u16 cap_reg;
-	u16 intr_enable;
+	u16 intr_enable = 0;
 	u32 slot_cap;
 	int cap_base, saved_cap_base;
 	u16 slot_status, slot_ctrl;
@@ -1412,6 +1412,7 @@
 			} else 
 				php_ctlr->irq = pdev->irq;
 		}
+
 		rc = request_irq(php_ctlr->irq, pcie_isr, SA_SHIRQ, MY_NAME, (void *) ctrl);
 		dbg("%s: request_irq %d for hpc%d (returns %d)\n", __FUNCTION__, php_ctlr->irq, ctlr_seq_num, rc);
 		if (rc) {
@@ -1426,9 +1427,18 @@
 		goto abort_free_ctlr;
 	}
 	dbg("%s: SLOT_CTRL %x value read %x\n", __FUNCTION__, SLOT_CTRL, temp_word);
+	dbg("%s: slot_cap %x\n", __FUNCTION__, slot_cap);
 
-	intr_enable = ATTN_BUTTN_ENABLE | PWR_FAULT_DETECT_ENABLE | MRL_DETECT_ENABLE |
-					PRSN_DETECT_ENABLE;
+	intr_enable = intr_enable | PRSN_DETECT_ENABLE;
+
+	if (ATTN_BUTTN(slot_cap))
+		intr_enable = intr_enable | ATTN_BUTTN_ENABLE;
+	
+	if (POWER_CTRL(slot_cap))
+		intr_enable = intr_enable | PWR_FAULT_DETECT_ENABLE;
+	
+	if (MRL_SENS(slot_cap))
+		intr_enable = intr_enable | MRL_DETECT_ENABLE;
 
 	temp_word = (temp_word & ~intr_enable) | intr_enable; 
 
diff -Nru a/drivers/pci/hotplug/pciehprm_acpi.c b/drivers/pci/hotplug/pciehprm_acpi.c
--- a/drivers/pci/hotplug/pciehprm_acpi.c	2004-11-12 15:13:59 -08:00
+++ b/drivers/pci/hotplug/pciehprm_acpi.c	2004-11-12 15:13:59 -08:00
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
+#include <linux/pci-acpi.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #ifdef	CONFIG_IA64
@@ -50,6 +51,14 @@
 #define	METHOD_NAME__HPP	"_HPP"
 #define	METHOD_NAME_OSHP	"OSHP"
 
+/* Status code for running acpi method to gain native control */
+#define NC_NOT_RUN	0
+#define OSC_NOT_EXIST	1
+#define OSC_RUN_FAILED	2
+#define OSHP_NOT_EXIST	3
+#define OSHP_RUN_FAILED	4
+#define NC_RUN_SUCCESS	5
+
 #define	PHP_RES_BUS		0xA0
 #define	PHP_RES_IO		0xA1
 #define	PHP_RES_MEM		0xA2
@@ -125,7 +134,9 @@
 }
 
 static void acpi_get__hpp ( struct acpi_bridge	*ab);
-static void acpi_run_oshp ( struct acpi_bridge	*ab);
+static int acpi_run_oshp ( struct acpi_bridge	*ab);
+static int osc_run_status = NC_NOT_RUN;
+static int oshp_run_status = NC_NOT_RUN;
 
 static int acpi_add_slot_to_php_slots(
 	struct acpi_bridge	*ab,
@@ -158,8 +169,9 @@
 	ab->scanned += 1;
 	if (!ab->_hpp)
 		acpi_get__hpp(ab);
-
-	acpi_run_oshp(ab);
+	
+	if (osc_run_status == OSC_NOT_EXIST)
+		oshp_run_status = acpi_run_oshp(ab);
 
 	if (sun != samesun) {
 		info("acpi_pciehprm:   Slot sun(%x) at s:b:d:f=0x%02x:%02x:%02x:%02x\n", 
@@ -238,7 +250,7 @@
 	kfree(ret_buf.pointer);
 }
 
-static void acpi_run_oshp ( struct acpi_bridge	*ab)
+static int acpi_run_oshp ( struct acpi_bridge	*ab)
 {
 	acpi_status		status;
 	u8			*path_name = acpi_path_name(ab->handle);
@@ -248,9 +260,13 @@
 	status = acpi_evaluate_object(ab->handle, METHOD_NAME_OSHP, NULL, &ret_buf);
 	if (ACPI_FAILURE(status)) {
 		err("acpi_pciehprm:%s OSHP fails=0x%x\n", path_name, status);
-	} else
+		oshp_run_status = (status == AE_NOT_FOUND) ? OSHP_NOT_EXIST : OSHP_RUN_FAILED;
+	} else {
+		oshp_run_status = NC_RUN_SUCCESS;
 		dbg("acpi_pciehprm:%s OSHP passes =0x%x\n", path_name, status);
-	return;
+		dbg("acpi_pciehprm:%s oshp_run_status =0x%x\n", path_name, oshp_run_status);
+	}
+	return oshp_run_status;
 }
 
 static acpi_status acpi_evaluate_crs(
@@ -1056,6 +1072,16 @@
 		kfree(ab);
 		return NULL;
 	}
+
+	status = pci_osc_control_set (OSC_PCI_EXPRESS_NATIVE_HP_CONTROL); 
+	if (ACPI_FAILURE(status)) {
+		err("%s: status %x\n", __FUNCTION__, status);
+		osc_run_status = (status == AE_NOT_FOUND) ? OSC_NOT_EXIST : OSC_RUN_FAILED;
+	} else {
+		osc_run_status = NC_RUN_SUCCESS;
+	}	
+	dbg("%s: osc_run_status %x\n", __FUNCTION__, osc_run_status);
+	
 	build_a_bridge(ab, ab);
 
 	return ab;
@@ -1140,6 +1166,11 @@
 	rc = pciehprm_acpi_scan_pci();
 	if (rc)
 		return rc;
+
+	if ((oshp_run_status != NC_RUN_SUCCESS) && (osc_run_status != NC_RUN_SUCCESS)) {
+		err("Fails to gain control of native hot-plug\n");
+		rc = -ENODEV;
+	}
 
 	dbg("pciehprm ACPI init %s\n", (rc)?"fail":"success");
 	return rc;
diff -Nru a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/pci/pci-acpi.c	2004-11-12 15:13:59 -08:00
@@ -0,0 +1,209 @@
+/*
+ * File:	pci-acpi.c
+ * Purpose:	Provide PCI supports in ACPI
+ *
+ * Copyright (C) 2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <acpi/acpi.h>
+#include <acpi/acnamesp.h>
+#include <acpi/acresrc.h>
+#include <acpi/acpi_bus.h>
+
+#include <linux/pci-acpi.h>
+
+static u32 ctrlset_buf[3] = {0, 0, 0};
+static u32 global_ctrlsets = 0;
+u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
+
+static acpi_status  
+acpi_query_osc (
+	acpi_handle	handle,
+	u32		level,
+	void		*context,
+	void		**retval )
+{
+	acpi_status		status;
+	struct acpi_object_list	input;
+	union acpi_object 	in_params[4];
+	struct acpi_buffer	output;
+	union acpi_object 	out_obj;	
+	u32			osc_dw0;
+
+	/* Setting up output buffer */
+	output.length = sizeof(out_obj) + 3*sizeof(u32);  
+	output.pointer = &out_obj;
+	
+	/* Setting up input parameters */
+	input.count = 4;
+	input.pointer = in_params;
+	in_params[0].type 		= ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length 	= 16;
+	in_params[0].buffer.pointer	= OSC_UUID;
+	in_params[1].type 		= ACPI_TYPE_INTEGER;
+	in_params[1].integer.value 	= 1;
+	in_params[2].type 		= ACPI_TYPE_INTEGER;
+	in_params[2].integer.value	= 3;
+	in_params[3].type		= ACPI_TYPE_BUFFER;
+	in_params[3].buffer.length 	= 12;
+	in_params[3].buffer.pointer 	= (u8 *)context;
+
+	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
+	if (ACPI_FAILURE (status)) {
+		printk(KERN_DEBUG  
+			"Evaluate _OSC Set fails. Status = 0x%04x\n", status);
+		return status;
+	}
+	if (out_obj.type != ACPI_TYPE_BUFFER) {
+		printk(KERN_DEBUG  
+			"Evaluate _OSC returns wrong type\n");
+		return AE_TYPE;
+	}
+	osc_dw0 = *((u32 *) out_obj.buffer.pointer);
+	if (osc_dw0) {
+		if (osc_dw0 & OSC_REQUEST_ERROR)
+			printk(KERN_DEBUG "_OSC request fails\n"); 
+		if (osc_dw0 & OSC_INVALID_UUID_ERROR)
+			printk(KERN_DEBUG "_OSC invalid UUID\n"); 
+		if (osc_dw0 & OSC_INVALID_REVISION_ERROR)
+			printk(KERN_DEBUG "_OSC invalid revision\n"); 
+		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
+			/* Update Global Control Set */
+			global_ctrlsets = *((u32 *)(out_obj.buffer.pointer+8));
+			return AE_OK;
+		}
+		return AE_ERROR;
+	}
+
+	/* Update Global Control Set */
+	global_ctrlsets = *((u32 *)(out_obj.buffer.pointer + 8));
+	return AE_OK;
+}
+
+
+static acpi_status  
+acpi_run_osc (
+	acpi_handle	handle,
+	u32		level,
+	void		*context,
+	void		**retval )
+{
+	acpi_status		status;
+	struct acpi_object_list	input;
+	union acpi_object 	in_params[4];
+	struct acpi_buffer	output;
+	union acpi_object 	out_obj;	
+	u32			osc_dw0;
+
+	/* Setting up output buffer */
+	output.length = sizeof(out_obj) + 3*sizeof(u32);  
+	output.pointer = &out_obj;
+	
+	/* Setting up input parameters */
+	input.count = 4;
+	input.pointer = in_params;
+	in_params[0].type 		= ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length 	= 16;
+	in_params[0].buffer.pointer	= OSC_UUID;
+	in_params[1].type 		= ACPI_TYPE_INTEGER;
+	in_params[1].integer.value 	= 1;
+	in_params[2].type 		= ACPI_TYPE_INTEGER;
+	in_params[2].integer.value	= 3;
+	in_params[3].type		= ACPI_TYPE_BUFFER;
+	in_params[3].buffer.length 	= 12;
+	in_params[3].buffer.pointer 	= (u8 *)context;
+
+	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
+	if (ACPI_FAILURE (status)) {
+		printk(KERN_DEBUG  
+			"Evaluate _OSC Set fails. Status = 0x%04x\n", status);
+		return status;
+	}
+	if (out_obj.type != ACPI_TYPE_BUFFER) {
+		printk(KERN_DEBUG  
+			"Evaluate _OSC returns wrong type\n");
+		return AE_TYPE;
+	}
+	osc_dw0 = *((u32 *) out_obj.buffer.pointer);
+	if (osc_dw0) {
+		if (osc_dw0 & OSC_REQUEST_ERROR)
+			printk(KERN_DEBUG "_OSC request fails\n"); 
+		if (osc_dw0 & OSC_INVALID_UUID_ERROR)
+			printk(KERN_DEBUG "_OSC invalid UUID\n"); 
+		if (osc_dw0 & OSC_INVALID_REVISION_ERROR)
+			printk(KERN_DEBUG "_OSC invalid revision\n"); 
+		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
+			printk(KERN_DEBUG "_OSC FW not grant req. control\n");
+			return AE_SUPPORT;
+		}
+		return AE_ERROR;
+	}
+	return AE_OK;
+}
+
+/**
+ * pci_osc_support_set - register OS support to Firmware
+ * @flags: OS support bits
+ *
+ * Update OS support fields and doing a _OSC Query to obtain an update
+ * from Firmware on supported control bits.
+ **/
+acpi_status pci_osc_support_set(u32 flags)
+{
+	u32 temp;
+
+	if (!(flags & OSC_SUPPORT_MASKS)) {
+		return AE_TYPE;
+	}
+	ctrlset_buf[OSC_SUPPORT_TYPE] |= (flags & OSC_SUPPORT_MASKS);
+
+	/* do _OSC query for all possible controls */
+	temp = ctrlset_buf[OSC_CONTROL_TYPE];
+	ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
+	ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
+	acpi_get_devices ( PCI_ROOT_HID_STRING,
+			acpi_query_osc,
+			ctrlset_buf,
+			NULL );
+	ctrlset_buf[OSC_QUERY_TYPE] = !OSC_QUERY_ENABLE;
+	ctrlset_buf[OSC_CONTROL_TYPE] = temp;
+	return AE_OK;
+}
+EXPORT_SYMBOL(pci_osc_support_set);
+
+/**
+ * pci_osc_control_set - commit requested control to Firmware
+ * @flags: driver's requested control bits
+ *
+ * Attempt to take control from Firmware on requested control bits.
+ **/
+acpi_status pci_osc_control_set(u32 flags)
+{
+	acpi_status	status;
+	u32		ctrlset;
+
+	ctrlset = (flags & OSC_CONTROL_MASKS);
+	if (!ctrlset) {
+		return AE_TYPE;
+	}
+	if (ctrlset_buf[OSC_SUPPORT_TYPE] && 
+	 	((global_ctrlsets & ctrlset) != ctrlset)) {
+		return AE_SUPPORT;
+	}
+	ctrlset_buf[OSC_CONTROL_TYPE] |= ctrlset;
+	status = acpi_get_devices ( PCI_ROOT_HID_STRING,
+				acpi_run_osc,
+				ctrlset_buf,
+				NULL );
+	if (ACPI_FAILURE (status)) {
+		ctrlset_buf[OSC_CONTROL_TYPE] &= ~ctrlset;
+	}
+	
+	return status;
+}
+EXPORT_SYMBOL(pci_osc_control_set);
diff -Nru a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/pci-acpi.h	2004-11-12 15:13:59 -08:00
@@ -0,0 +1,61 @@
+/*
+ * File		pci-acpi.h
+ *
+ * Copyright (C) 2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ */
+
+#ifndef _PCI_ACPI_H_
+#define _PCI_ACPI_H_
+
+#define OSC_QUERY_TYPE			0
+#define OSC_SUPPORT_TYPE 		1
+#define OSC_CONTROL_TYPE		2
+#define OSC_SUPPORT_MASKS		0x1f
+
+/*
+ * _OSC DW0 Definition 
+ */
+#define OSC_QUERY_ENABLE		1
+#define OSC_REQUEST_ERROR		2
+#define OSC_INVALID_UUID_ERROR		4
+#define OSC_INVALID_REVISION_ERROR	8
+#define OSC_CAPABILITIES_MASK_ERROR	16
+
+/*
+ * _OSC DW1 Definition (OS Support Fields)
+ */
+#define OSC_EXT_PCI_CONFIG_SUPPORT		1
+#define OSC_ACTIVE_STATE_PWR_SUPPORT 		2
+#define OSC_CLOCK_PWR_CAPABILITY_SUPPORT	4
+#define OSC_PCI_SEGMENT_GROUPS_SUPPORT		8
+#define OSC_MSI_SUPPORT				16
+
+/*
+ * _OSC DW1 Definition (OS Control Fields)
+ */
+#define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	1
+#define OSC_SHPC_NATIVE_HP_CONTROL 		2
+#define OSC_PCI_EXPRESS_PME_CONTROL		4
+#define OSC_PCI_EXPRESS_AER_CONTROL		8
+#define OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL	16
+
+#define OSC_CONTROL_MASKS 	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | 	\
+				OSC_SHPC_NATIVE_HP_CONTROL | 		\
+				OSC_PCI_EXPRESS_PME_CONTROL |		\
+				OSC_PCI_EXPRESS_AER_CONTROL |		\
+				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
+
+#ifdef CONFIG_ACPI
+extern acpi_status pci_osc_control_set(u32 flags);
+extern acpi_status pci_osc_support_set(u32 flags);
+#else
+#if !defined(acpi_status)
+typedef u32 		acpi_status;
+#define AE_ERROR      	(acpi_status) (0x0001)
+#endif    
+static inline acpi_status pci_osc_control_set(u32 flags) {return AE_ERROR;}
+static inline acpi_status pci_osc_support_set(u32 flags) {return AE_ERROR;} 
+#endif
+
+#endif	/* _PCI_ACPI_H_ */

