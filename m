Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVFAFEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVFAFEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVFAFEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:04:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:12509 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261258AbVFAE6W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 00:58:22 -0400
Cc: scottm@somanetworks.com
Subject: [PATCH] PCI Hotplug: more CPCI updates
In-Reply-To: <111760252426@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 31 May 2005 22:08:44 -0700
Message-Id: <11176025242587@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: more CPCI updates

Here is my third attempt at a patch to further update the CompactPCI
hotplug driver infrastructure to address the pci_enable_device issue
discussed on the list as well as a few other issues I discovered during
some more testing.  This version addresses a few more issues pointed out
by Prarit Bhargava.  Changes include:
- cpci_enable_device and its recursive calling of pci_enable_device on
  new devices removed.
- Use list_rwsem to avoid slot status change races between disable_slot
  and check_slots.
- Fixed oopsing in cpci_hp_unregister_bus caused by calling list_del on
  a slot after calling pci_hp_deregister.
- Removed kfree calls in cleanup_slots since release_slot will have
  done it already.
- Reworked init_slots a bit to fix latch and adapter file updating on
  subsequent calls to cpci_hp_start.
- Improved sanity checking in cpci_hp_register_controller.
- Now shut things down correctly in cpci_hotplug_exit.
- Switch to pci_get_slot instead of deprecated pci_find_slot.
- A bunch of CodingStyle fixes.

Signed-off-by: Scott Murray <scottm@somanetworks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit bcc488ab02254a6e60d749187a632dc3d642d4f8
tree 4cd45b4d546cf85c14c442b27f611e048a4d9938
parent af00f9811e0ccbd3db84ddc4cffb0da942653393
author Scott Murray <scottm@somanetworks.com> Fri, 27 May 2005 16:48:52 -0400
committer Greg KH <gregkh@suse.de> Tue, 31 May 2005 14:26:38 -0700

 drivers/pci/hotplug/cpci_hotplug_core.c |  302 ++++++++++++++-----------------
 drivers/pci/hotplug/cpci_hotplug_pci.c  |  144 ++++++---------
 2 files changed, 192 insertions(+), 254 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -1,7 +1,7 @@
 /*
  * CompactPCI Hot Plug Driver
  *
- * Copyright (C) 2002 SOMA Networks, Inc.
+ * Copyright (C) 2002,2005 SOMA Networks, Inc.
  * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
  * Copyright (C) 2001 IBM Corp.
  *
@@ -45,10 +45,10 @@
 
 #define dbg(format, arg...)					\
 	do {							\
-		if(cpci_debug)					\
+		if (cpci_debug)					\
 			printk (KERN_DEBUG "%s: " format "\n",	\
 				MY_NAME , ## arg); 		\
-	} while(0)
+	} while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
@@ -111,10 +111,8 @@ enable_slot(struct hotplug_slot *hotplug
 
 	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
-	if(controller->ops->set_power) {
+	if (controller->ops->set_power)
 		retval = controller->ops->set_power(slot, 1);
-	}
-
 	return retval;
 }
 
@@ -126,37 +124,41 @@ disable_slot(struct hotplug_slot *hotplu
 
 	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
+	down_write(&list_rwsem);
+
 	/* Unconfigure device */
 	dbg("%s - unconfiguring slot %s",
 	    __FUNCTION__, slot->hotplug_slot->name);
-	if((retval = cpci_unconfigure_slot(slot))) {
+	if ((retval = cpci_unconfigure_slot(slot))) {
 		err("%s - could not unconfigure slot %s",
 		    __FUNCTION__, slot->hotplug_slot->name);
-		return retval;
+		goto disable_error;
 	}
 	dbg("%s - finished unconfiguring slot %s",
 	    __FUNCTION__, slot->hotplug_slot->name);
 
 	/* Clear EXT (by setting it) */
-	if(cpci_clear_ext(slot)) {
+	if (cpci_clear_ext(slot)) {
 		err("%s - could not clear EXT for slot %s",
 		    __FUNCTION__, slot->hotplug_slot->name);
 		retval = -ENODEV;
+		goto disable_error;
 	}
 	cpci_led_on(slot);
 
-	if(controller->ops->set_power) {
-		retval = controller->ops->set_power(slot, 0);
-	}
+	if (controller->ops->set_power)
+		if ((retval = controller->ops->set_power(slot, 0)))
+			goto disable_error;
 
-	if(update_adapter_status(slot->hotplug_slot, 0)) {
+	if (update_adapter_status(slot->hotplug_slot, 0))
 		warn("failure to update adapter file");
-	}
 
-	if(slot->extracting) {
+	if (slot->extracting) {
 		slot->extracting = 0;
 		atomic_dec(&extracting);
 	}
+disable_error:
+	up_write(&list_rwsem);
 	return retval;
 }
 
@@ -165,9 +167,8 @@ cpci_get_power_status(struct slot *slot)
 {
 	u8 power = 1;
 
-	if(controller->ops->get_power) {
+	if (controller->ops->get_power)
 		power = controller->ops->get_power(slot);
-	}
 	return power;
 }
 
@@ -237,9 +238,8 @@ cpci_hp_register_bus(struct pci_bus *bus
 	int status = -ENOMEM;
 	int i;
 
-	if(!(controller && bus)) {
+	if (!(controller && bus))
 		return -ENODEV;
-	}
 
 	/*
 	 * Create a structure for each slot, and register that slot
@@ -316,32 +316,30 @@ int
 cpci_hp_unregister_bus(struct pci_bus *bus)
 {
 	struct slot *slot;
-	struct list_head *tmp;
-	struct list_head *next;
-	int status;
+	struct slot *tmp;
+	int status = 0;
 
 	down_write(&list_rwsem);
-	if(!slots) {
+	if (!slots) {
 		up_write(&list_rwsem);
 		return -1;
 	}
-	list_for_each_safe(tmp, next, &slot_list) {
-		slot = list_entry(tmp, struct slot, slot_list);
-		if(slot->bus == bus) {
+	list_for_each_entry_safe(slot, tmp, &slot_list, slot_list) {
+		if (slot->bus == bus) {
+			list_del(&slot->slot_list);
+			slots--;
+
 			dbg("deregistering slot %s", slot->hotplug_slot->name);
 			status = pci_hp_deregister(slot->hotplug_slot);
-			if(status) {
+			if (status) {
 				err("pci_hp_deregister failed with error %d",
 				    status);
-				return status;
+				break;
 			}
-
-			list_del(&slot->slot_list);
-			slots--;
 		}
 	}
 	up_write(&list_rwsem);
-	return 0;
+	return status;
 }
 
 /* This is the interrupt mode interrupt handler */
@@ -351,7 +349,7 @@ cpci_hp_intr(int irq, void *data, struct
 	dbg("entered cpci_hp_intr");
 
 	/* Check to see if it was our interrupt */
-	if((controller->irq_flags & SA_SHIRQ) &&
+	if ((controller->irq_flags & SA_SHIRQ) &&
 	    !controller->ops->check_irq(controller->dev_id)) {
 		dbg("exited cpci_hp_intr, not our interrupt");
 		return IRQ_NONE;
@@ -373,38 +371,30 @@ cpci_hp_intr(int irq, void *data, struct
  * INS bits of the cold-inserted devices.
  */
 static int
-init_slots(void)
+init_slots(int clear_ins)
 {
 	struct slot *slot;
-	struct list_head *tmp;
 	struct pci_dev* dev;
 
 	dbg("%s - enter", __FUNCTION__);
 	down_read(&list_rwsem);
-	if(!slots) {
+	if (!slots) {
 		up_read(&list_rwsem);
 		return -1;
 	}
-	list_for_each(tmp, &slot_list) {
-		slot = list_entry(tmp, struct slot, slot_list);
+	list_for_each_entry(slot, &slot_list, slot_list) {
 		dbg("%s - looking at slot %s",
 		    __FUNCTION__, slot->hotplug_slot->name);
-		if(cpci_check_and_clear_ins(slot)) {
+		if (clear_ins && cpci_check_and_clear_ins(slot))
 			dbg("%s - cleared INS for slot %s",
 			    __FUNCTION__, slot->hotplug_slot->name);
-			dev = pci_find_slot(slot->bus->number, PCI_DEVFN(slot->number, 0));
-			if(dev) {
-				if(update_adapter_status(slot->hotplug_slot, 1)) {
-					warn("failure to update adapter file");
-				}
-				if(update_latch_status(slot->hotplug_slot, 1)) {
-					warn("failure to update latch file");
-				}
-				slot->dev = dev;
-			} else {
-				err("%s - no driver attached to device in slot %s",
-				    __FUNCTION__, slot->hotplug_slot->name);
-			}
+		dev = pci_get_slot(slot->bus, PCI_DEVFN(slot->number, 0));
+		if (dev) {
+			if (update_adapter_status(slot->hotplug_slot, 1))
+				warn("failure to update adapter file");
+			if (update_latch_status(slot->hotplug_slot, 1))
+				warn("failure to update latch file");
+			slot->dev = dev;
 		}
 	}
 	up_read(&list_rwsem);
@@ -416,26 +406,28 @@ static int
 check_slots(void)
 {
 	struct slot *slot;
-	struct list_head *tmp;
 	int extracted;
 	int inserted;
 	u16 hs_csr;
 
 	down_read(&list_rwsem);
-	if(!slots) {
+	if (!slots) {
 		up_read(&list_rwsem);
 		err("no slots registered, shutting down");
 		return -1;
 	}
 	extracted = inserted = 0;
-	list_for_each(tmp, &slot_list) {
-		slot = list_entry(tmp, struct slot, slot_list);
+	list_for_each_entry(slot, &slot_list, slot_list) {
 		dbg("%s - looking at slot %s",
 		    __FUNCTION__, slot->hotplug_slot->name);
-		if(cpci_check_and_clear_ins(slot)) {
-			/* Some broken hardware (e.g. PLX 9054AB) asserts ENUM# twice... */
-			if(slot->dev) {
-				warn("slot %s already inserted", slot->hotplug_slot->name);
+		if (cpci_check_and_clear_ins(slot)) {
+			/*
+			 * Some broken hardware (e.g. PLX 9054AB) asserts
+			 * ENUM# twice...
+			 */
+			if (slot->dev) {
+				warn("slot %s already inserted",
+				     slot->hotplug_slot->name);
 				inserted++;
 				continue;
 			}
@@ -452,7 +444,7 @@ check_slots(void)
 			/* Configure device */
 			dbg("%s - configuring slot %s",
 			    __FUNCTION__, slot->hotplug_slot->name);
-			if(cpci_configure_slot(slot)) {
+			if (cpci_configure_slot(slot)) {
 				err("%s - could not configure slot %s",
 				    __FUNCTION__, slot->hotplug_slot->name);
 				continue;
@@ -465,13 +457,11 @@ check_slots(void)
 			dbg("%s - slot %s HS_CSR (2) = %04x",
 			    __FUNCTION__, slot->hotplug_slot->name, hs_csr);
 
-			if(update_latch_status(slot->hotplug_slot, 1)) {
+			if (update_latch_status(slot->hotplug_slot, 1))
 				warn("failure to update latch file");
-			}
 
-			if(update_adapter_status(slot->hotplug_slot, 1)) {
+			if (update_adapter_status(slot->hotplug_slot, 1))
 				warn("failure to update adapter file");
-			}
 
 			cpci_led_off(slot);
 
@@ -481,7 +471,7 @@ check_slots(void)
 			    __FUNCTION__, slot->hotplug_slot->name, hs_csr);
 
 			inserted++;
-		} else if(cpci_check_ext(slot)) {
+		} else if (cpci_check_ext(slot)) {
 			/* Process extraction request */
 			dbg("%s - slot %s extracted",
 			    __FUNCTION__, slot->hotplug_slot->name);
@@ -491,27 +481,25 @@ check_slots(void)
 			dbg("%s - slot %s HS_CSR = %04x",
 			    __FUNCTION__, slot->hotplug_slot->name, hs_csr);
 
-			if(!slot->extracting) {
-				if(update_latch_status(slot->hotplug_slot, 0)) {
+			if (!slot->extracting) {
+				if (update_latch_status(slot->hotplug_slot, 0)) {
 					warn("failure to update latch file");
-
 				}
-				atomic_inc(&extracting);
 				slot->extracting = 1;
+				atomic_inc(&extracting);
 			}
 			extracted++;
-		} else if(slot->extracting) {
+		} else if (slot->extracting) {
 			hs_csr = cpci_get_hs_csr(slot);
-			if(hs_csr == 0xffff) {
+			if (hs_csr == 0xffff) {
 				/*
 				 * Hmmm, we're likely hosed at this point, should we
 				 * bother trying to tell the driver or not?
 				 */
 				err("card in slot %s was improperly removed",
 				    slot->hotplug_slot->name);
-				if(update_adapter_status(slot->hotplug_slot, 0)) {
+				if (update_adapter_status(slot->hotplug_slot, 0))
 					warn("failure to update adapter file");
-				}
 				slot->extracting = 0;
 				atomic_dec(&extracting);
 			}
@@ -520,10 +508,9 @@ check_slots(void)
 	up_read(&list_rwsem);
 	dbg("inserted=%d, extracted=%d, extracting=%d",
 	    inserted, extracted, atomic_read(&extracting));
-	if(inserted || extracted) {
+	if (inserted || extracted)
 		return extracted;
-	}
-	else if(!atomic_read(&extracting)) {
+	else if (!atomic_read(&extracting)) {
 		err("cannot find ENUM# source, shutting down");
 		return -1;
 	}
@@ -541,12 +528,12 @@ event_thread(void *data)
 	unlock_kernel();
 
 	dbg("%s - event thread started", __FUNCTION__);
-	while(1) {
+	while (1) {
 		dbg("event thread sleeping");
 		down_interruptible(&event_semaphore);
 		dbg("event thread woken, thread_finished = %d",
 		    thread_finished);
-		if(thread_finished || signal_pending(current))
+		if (thread_finished || signal_pending(current))
 			break;
 		do {
 			rc = check_slots();
@@ -558,7 +545,9 @@ event_thread(void *data)
 				thread_finished = 1;
 				break;
 			}
-		} while(atomic_read(&extracting) != 0);
+		} while (atomic_read(&extracting) && !thread_finished);
+		if (thread_finished)
+			break;
 
 		/* Re-enable ENUM# interrupt */
 		dbg("%s - re-enabling irq", __FUNCTION__);
@@ -579,21 +568,21 @@ poll_thread(void *data)
 	daemonize("cpci_hp_polld");
 	unlock_kernel();
 
-	while(1) {
-		if(thread_finished || signal_pending(current))
+	while (1) {
+		if (thread_finished || signal_pending(current))
 			break;
-		if(controller->ops->query_enum()) {
+		if (controller->ops->query_enum()) {
 			do {
 				rc = check_slots();
-				if(rc > 0) {
+				if (rc > 0) {
 					/* Give userspace a chance to handle extraction */
 					msleep(500);
-				} else if(rc < 0) {
+				} else if (rc < 0) {
 					dbg("%s - error checking slots", __FUNCTION__);
 					thread_finished = 1;
 					break;
 				}
-			} while(atomic_read(&extracting) != 0);
+			} while (atomic_read(&extracting) && !thread_finished);
 		}
 		msleep(100);
 	}
@@ -612,12 +601,11 @@ cpci_start_thread(void)
 	init_MUTEX_LOCKED(&thread_exit);
 	thread_finished = 0;
 
-	if(controller->irq) {
+	if (controller->irq)
 		pid = kernel_thread(event_thread, NULL, 0);
-	} else {
+	else
 		pid = kernel_thread(poll_thread, NULL, 0);
-	}
-	if(pid < 0) {
+	if (pid < 0) {
 		err("Can't start up our thread");
 		return -1;
 	}
@@ -630,9 +618,8 @@ cpci_stop_thread(void)
 {
 	thread_finished = 1;
 	dbg("thread finish command given");
-	if(controller->irq) {
+	if (controller->irq)
 		up(&event_semaphore);
-	}
 	dbg("wait for thread to exit");
 	down(&thread_exit);
 }
@@ -642,45 +629,67 @@ cpci_hp_register_controller(struct cpci_
 {
 	int status = 0;
 
-	if(!controller) {
-		controller = new_controller;
-		if(controller->irq) {
-			if(request_irq(controller->irq,
-					cpci_hp_intr,
-					controller->irq_flags,
-					MY_NAME, controller->dev_id)) {
-				err("Can't get irq %d for the hotplug cPCI controller", controller->irq);
-				status = -ENODEV;
-			}
-			dbg("%s - acquired controller irq %d", __FUNCTION__,
-			    controller->irq);
+	if (controller)
+		return -1;
+	if (!(new_controller && new_controller->ops))
+		return -EINVAL;
+	if (new_controller->irq) {
+		if (!(new_controller->ops->enable_irq &&
+		     new_controller->ops->disable_irq))
+			status = -EINVAL;
+		if (request_irq(new_controller->irq,
+			       cpci_hp_intr,
+			       new_controller->irq_flags,
+			       MY_NAME,
+			       new_controller->dev_id)) {
+			err("Can't get irq %d for the hotplug cPCI controller",
+			    new_controller->irq);
+			status = -ENODEV;
 		}
-	} else {
-		err("cPCI hotplug controller already registered");
-		status = -1;
+		dbg("%s - acquired controller irq %d",
+		    __FUNCTION__, new_controller->irq);
 	}
+	if (!status)
+		controller = new_controller;
 	return status;
 }
 
+static void
+cleanup_slots(void)
+{
+	struct slot *slot;
+	struct slot *tmp;
+
+	/*
+	 * Unregister all of our slots with the pci_hotplug subsystem,
+	 * and free up all memory that we had allocated.
+	 */
+	down_write(&list_rwsem);
+	if (!slots)
+		goto cleanup_null;
+	list_for_each_entry_safe(slot, tmp, &slot_list, slot_list) {
+		list_del(&slot->slot_list);
+		pci_hp_deregister(slot->hotplug_slot);
+	}
+cleanup_null:
+	up_write(&list_rwsem);
+	return;
+}
+
 int
 cpci_hp_unregister_controller(struct cpci_hp_controller *old_controller)
 {
 	int status = 0;
 
-	if(controller) {
-		if(atomic_read(&extracting) != 0) {
-			return -EBUSY;
-		}
-		if(!thread_finished) {
+	if (controller) {
+		if (!thread_finished)
 			cpci_stop_thread();
-		}
-		if(controller->irq) {
+		if (controller->irq)
 			free_irq(controller->irq, controller->dev_id);
-		}
 		controller = NULL;
-	} else {
+		cleanup_slots();
+	} else
 		status = -ENODEV;
-	}
 	return status;
 }
 
@@ -691,32 +700,28 @@ cpci_hp_start(void)
 	int status;
 
 	dbg("%s - enter", __FUNCTION__);
-	if(!controller) {
+	if (!controller)
 		return -ENODEV;
-	}
 
 	down_read(&list_rwsem);
-	if(list_empty(&slot_list)) {
+	if (list_empty(&slot_list)) {
 		up_read(&list_rwsem);
 		return -ENODEV;
 	}
 	up_read(&list_rwsem);
 
-	if(first) {
-		status = init_slots();
-		if(status) {
-			return status;
-		}
+	status = init_slots(first);
+	if (first)
 		first = 0;
-	}
+	if (status)
+		return status;
 
 	status = cpci_start_thread();
-	if(status) {
+	if (status)
 		return status;
-	}
 	dbg("%s - thread started", __FUNCTION__);
 
-	if(controller->irq) {
+	if (controller->irq) {
 		/* Start enum interrupt processing */
 		dbg("%s - enabling irq", __FUNCTION__);
 		controller->ops->enable_irq();
@@ -728,13 +733,9 @@ cpci_hp_start(void)
 int
 cpci_hp_stop(void)
 {
-	if(!controller) {
+	if (!controller)
 		return -ENODEV;
-	}
-	if(atomic_read(&extracting) != 0) {
-		return -EBUSY;
-	}
-	if(controller->irq) {
+	if (controller->irq) {
 		/* Stop enum interrupt processing */
 		dbg("%s - disabling irq", __FUNCTION__);
 		controller->ops->disable_irq();
@@ -743,34 +744,6 @@ cpci_hp_stop(void)
 	return 0;
 }
 
-static void __exit
-cleanup_slots(void)
-{
-	struct list_head *tmp;
-	struct slot *slot;
-
-	/*
-	 * Unregister all of our slots with the pci_hotplug subsystem,
-	 * and free up all memory that we had allocated.
-	 */
-	down_write(&list_rwsem);
-	if(!slots) {
-		goto null_cleanup;
-	}
-	list_for_each(tmp, &slot_list) {
-		slot = list_entry(tmp, struct slot, slot_list);
-		list_del(&slot->slot_list);
-		pci_hp_deregister(slot->hotplug_slot);
-		kfree(slot->hotplug_slot->info);
-		kfree(slot->hotplug_slot->name);
-		kfree(slot->hotplug_slot);
-		kfree(slot);
-	}
-      null_cleanup:
-	up_write(&list_rwsem);
-	return;
-}
-
 int __init
 cpci_hotplug_init(int debug)
 {
@@ -784,7 +757,8 @@ cpci_hotplug_exit(void)
 	/*
 	 * Clean everything up.
 	 */
-	cleanup_slots();
+	cpci_hp_stop();
+	cpci_hp_unregister_controller(controller);
 }
 
 EXPORT_SYMBOL_GPL(cpci_hp_register_controller);
diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -1,7 +1,7 @@
 /*
  * CompactPCI Hot Plug Driver PCI functions
  *
- * Copyright (C) 2002 by SOMA Networks, Inc.
+ * Copyright (C) 2002,2005 by SOMA Networks, Inc.
  *
  * All rights reserved.
  *
@@ -38,10 +38,10 @@ extern int cpci_debug;
 
 #define dbg(format, arg...)					\
 	do {							\
-		if(cpci_debug)					\
+		if (cpci_debug)					\
 			printk (KERN_DEBUG "%s: " format "\n",	\
 				MY_NAME , ## arg); 		\
-	} while(0)
+	} while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
@@ -57,16 +57,15 @@ u8 cpci_get_attention_status(struct slot
 	hs_cap = pci_bus_find_capability(slot->bus,
 					 slot->devfn,
 					 PCI_CAP_ID_CHSWP);
-	if(!hs_cap) {
+	if (!hs_cap)
 		return 0;
-	}
 
-	if(pci_bus_read_config_word(slot->bus,
+	if (pci_bus_read_config_word(slot->bus,
 				     slot->devfn,
 				     hs_cap + 2,
-				     &hs_csr)) {
+				     &hs_csr))
 		return 0;
-	}
+
 	return hs_csr & 0x0008 ? 1 : 0;
 }
 
@@ -78,27 +77,22 @@ int cpci_set_attention_status(struct slo
 	hs_cap = pci_bus_find_capability(slot->bus,
 					 slot->devfn,
 					 PCI_CAP_ID_CHSWP);
-	if(!hs_cap) {
+	if (!hs_cap)
 		return 0;
-	}
-
-	if(pci_bus_read_config_word(slot->bus,
+	if (pci_bus_read_config_word(slot->bus,
 				     slot->devfn,
 				     hs_cap + 2,
-				     &hs_csr)) {
+				     &hs_csr))
 		return 0;
-	}
-	if(status) {
+	if (status)
 		hs_csr |= HS_CSR_LOO;
-	} else {
+	else
 		hs_csr &= ~HS_CSR_LOO;
-	}
-	if(pci_bus_write_config_word(slot->bus,
+	if (pci_bus_write_config_word(slot->bus,
 				      slot->devfn,
 				      hs_cap + 2,
-				      hs_csr)) {
+				      hs_csr))
 		return 0;
-	}
 	return 1;
 }
 
@@ -110,16 +104,13 @@ u16 cpci_get_hs_csr(struct slot* slot)
 	hs_cap = pci_bus_find_capability(slot->bus,
 					 slot->devfn,
 					 PCI_CAP_ID_CHSWP);
-	if(!hs_cap) {
+	if (!hs_cap)
 		return 0xFFFF;
-	}
-
-	if(pci_bus_read_config_word(slot->bus,
+	if (pci_bus_read_config_word(slot->bus,
 				     slot->devfn,
 				     hs_cap + 2,
-				     &hs_csr)) {
+				     &hs_csr))
 		return 0xFFFF;
-	}
 	return hs_csr;
 }
 
@@ -132,24 +123,22 @@ int cpci_check_and_clear_ins(struct slot
 	hs_cap = pci_bus_find_capability(slot->bus,
 					 slot->devfn,
 					 PCI_CAP_ID_CHSWP);
-	if(!hs_cap) {
+	if (!hs_cap)
 		return 0;
-	}
-	if(pci_bus_read_config_word(slot->bus,
+	if (pci_bus_read_config_word(slot->bus,
 				     slot->devfn,
 				     hs_cap + 2,
-				     &hs_csr)) {
+				     &hs_csr))
 		return 0;
-	}
-	if(hs_csr & HS_CSR_INS) {
+	if (hs_csr & HS_CSR_INS) {
 		/* Clear INS (by setting it) */
-		if(pci_bus_write_config_word(slot->bus,
+		if (pci_bus_write_config_word(slot->bus,
 					      slot->devfn,
 					      hs_cap + 2,
-					      hs_csr)) {
+					      hs_csr))
 			ins = 0;
-		}
-		ins = 1;
+		else
+			ins = 1;
 	}
 	return ins;
 }
@@ -163,18 +152,15 @@ int cpci_check_ext(struct slot* slot)
 	hs_cap = pci_bus_find_capability(slot->bus,
 					 slot->devfn,
 					 PCI_CAP_ID_CHSWP);
-	if(!hs_cap) {
+	if (!hs_cap)
 		return 0;
-	}
-	if(pci_bus_read_config_word(slot->bus,
+	if (pci_bus_read_config_word(slot->bus,
 				     slot->devfn,
 				     hs_cap + 2,
-				     &hs_csr)) {
+				     &hs_csr))
 		return 0;
-	}
-	if(hs_csr & HS_CSR_EXT) {
+	if (hs_csr & HS_CSR_EXT)
 		ext = 1;
-	}
 	return ext;
 }
 
@@ -186,23 +172,20 @@ int cpci_clear_ext(struct slot* slot)
 	hs_cap = pci_bus_find_capability(slot->bus,
 					 slot->devfn,
 					 PCI_CAP_ID_CHSWP);
-	if(!hs_cap) {
+	if (!hs_cap)
 		return -ENODEV;
-	}
-	if(pci_bus_read_config_word(slot->bus,
+	if (pci_bus_read_config_word(slot->bus,
 				     slot->devfn,
 				     hs_cap + 2,
-				     &hs_csr)) {
+				     &hs_csr))
 		return -ENODEV;
-	}
-	if(hs_csr & HS_CSR_EXT) {
+	if (hs_csr & HS_CSR_EXT) {
 		/* Clear EXT (by setting it) */
-		if(pci_bus_write_config_word(slot->bus,
+		if (pci_bus_write_config_word(slot->bus,
 					      slot->devfn,
 					      hs_cap + 2,
-					      hs_csr)) {
+					      hs_csr))
 			return -ENODEV;
-		}
 	}
 	return 0;
 }
@@ -215,18 +198,16 @@ int cpci_led_on(struct slot* slot)
 	hs_cap = pci_bus_find_capability(slot->bus,
 					 slot->devfn,
 					 PCI_CAP_ID_CHSWP);
-	if(!hs_cap) {
+	if (!hs_cap)
 		return -ENODEV;
-	}
-	if(pci_bus_read_config_word(slot->bus,
+	if (pci_bus_read_config_word(slot->bus,
 				     slot->devfn,
 				     hs_cap + 2,
-				     &hs_csr)) {
+				     &hs_csr))
 		return -ENODEV;
-	}
-	if((hs_csr & HS_CSR_LOO) != HS_CSR_LOO) {
+	if ((hs_csr & HS_CSR_LOO) != HS_CSR_LOO) {
 		hs_csr |= HS_CSR_LOO;
-		if(pci_bus_write_config_word(slot->bus,
+		if (pci_bus_write_config_word(slot->bus,
 					      slot->devfn,
 					      hs_cap + 2,
 					      hs_csr)) {
@@ -246,18 +227,16 @@ int cpci_led_off(struct slot* slot)
 	hs_cap = pci_bus_find_capability(slot->bus,
 					 slot->devfn,
 					 PCI_CAP_ID_CHSWP);
-	if(!hs_cap) {
+	if (!hs_cap)
 		return -ENODEV;
-	}
-	if(pci_bus_read_config_word(slot->bus,
+	if (pci_bus_read_config_word(slot->bus,
 				     slot->devfn,
 				     hs_cap + 2,
-				     &hs_csr)) {
+				     &hs_csr))
 		return -ENODEV;
-	}
-	if(hs_csr & HS_CSR_LOO) {
+	if (hs_csr & HS_CSR_LOO) {
 		hs_csr &= ~HS_CSR_LOO;
-		if(pci_bus_write_config_word(slot->bus,
+		if (pci_bus_write_config_word(slot->bus,
 					      slot->devfn,
 					      hs_cap + 2,
 					      hs_csr)) {
@@ -274,19 +253,6 @@ int cpci_led_off(struct slot* slot)
  * Device configuration functions
  */
 
-static void cpci_enable_device(struct pci_dev *dev)
-{
-	struct pci_bus *bus;
-
-	pci_enable_device(dev);
-	if(dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		bus = dev->subordinate;
-		list_for_each_entry(dev, &bus->devices, bus_list) {
-			cpci_enable_device(dev);
-		}
-	}
-}
-
 int cpci_configure_slot(struct slot* slot)
 {
 	unsigned char busnr;
@@ -294,14 +260,14 @@ int cpci_configure_slot(struct slot* slo
 
 	dbg("%s - enter", __FUNCTION__);
 
-	if(slot->dev == NULL) {
+	if (slot->dev == NULL) {
 		dbg("pci_dev null, finding %02x:%02x:%x",
 		    slot->bus->number, PCI_SLOT(slot->devfn), PCI_FUNC(slot->devfn));
-		slot->dev = pci_find_slot(slot->bus->number, slot->devfn);
+		slot->dev = pci_get_slot(slot->bus, slot->devfn);
 	}
 
 	/* Still NULL? Well then scan for it! */
-	if(slot->dev == NULL) {
+	if (slot->dev == NULL) {
 		int n;
 		dbg("pci_dev still null");
 
@@ -311,10 +277,10 @@ int cpci_configure_slot(struct slot* slo
 		 */
 		n = pci_scan_slot(slot->bus, slot->devfn);
 		dbg("%s: pci_scan_slot returned %d", __FUNCTION__, n);
-		if(n > 0)
+		if (n > 0)
 			pci_bus_add_devices(slot->bus);
-		slot->dev = pci_find_slot(slot->bus->number, slot->devfn);
-		if(slot->dev == NULL) {
+		slot->dev = pci_get_slot(slot->bus, slot->devfn);
+		if (slot->dev == NULL) {
 			err("Could not find PCI device for slot %02x", slot->number);
 			return 1;
 		}
@@ -329,8 +295,6 @@ int cpci_configure_slot(struct slot* slo
 
 	pci_bus_assign_resources(slot->dev->bus);
 
-	cpci_enable_device(slot->dev);
-
 	dbg("%s - exit", __FUNCTION__);
 	return 0;
 }
@@ -341,15 +305,15 @@ int cpci_unconfigure_slot(struct slot* s
 	struct pci_dev *dev;
 
 	dbg("%s - enter", __FUNCTION__);
-	if(!slot->dev) {
+	if (!slot->dev) {
 		err("No device for slot %02x\n", slot->number);
 		return -ENODEV;
 	}
 
 	for (i = 0; i < 8; i++) {
-		dev = pci_find_slot(slot->bus->number,
+		dev = pci_get_slot(slot->bus,
 				    PCI_DEVFN(PCI_SLOT(slot->devfn), i));
-		if(dev) {
+		if (dev) {
 			pci_remove_bus_device(dev);
 			slot->dev = NULL;
 		}

