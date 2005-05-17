Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVEQWAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVEQWAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVEQV7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:59:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:63899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261998AbVEQVo5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:44:57 -0400
Cc: scottm@somanetworks.com
Subject: [PATCH] PCI Hotplug: CPCI update
In-Reply-To: <11163663054163@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 17 May 2005 14:45:06 -0700
Message-Id: <11163663062761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: CPCI update

[PATCH] CPCI: update

I have finally done some work to update the CompactPCI hotplug driver to
fix some of the outstanding issues in 2.6:
- Added adapter and latch status ops so that those files will get created
  by the current PCI hotplug core.  This used to not be required, but
  seems to be now after some of the sysfs rework in the core.
- Replaced slot list spinlock with a r/w semaphore to avoid any potential
  issues with sleeping.  This quiets all of the runtime warnings.
- Reworked interrupt driven hot extraction handling to remove need for a
  polling operator for ENUM# status.  There are a lot of boards that only
  have an interrupt driven by ENUM#, so this lowers the bar to entry.
- Replaced pci_visit_dev usage with better use of the PCI core functions.
  The new code is functionally equivalent to the previous code, but the
  use of pci_enable_device on insert needs to be investigated further, as
  I need to do some more testing to see if it is still necessary.

Signed-off-by: Scott Murray <scottm@somanetworks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 43b7d7cfb157b5c8c5cc0933f4e96fd81adc81ca
tree 2af3b43ed8ee9468b1e0418c10275f33d23ced19
parent 8b245e45f34280ec61e3c8d643d4613b9e0eb7a4
author Scott Murray <scottm@somanetworks.com> Mon, 09 May 2005 17:31:50 -0400
committer Greg KH <gregkh@suse.de> Tue, 17 May 2005 14:31:11 -0700

 drivers/pci/hotplug/cpci_hotplug.h      |    2 
 drivers/pci/hotplug/cpci_hotplug_core.c |  169 +++++++--------
 drivers/pci/hotplug/cpci_hotplug_pci.c  |  352 ++------------------------------
 3 files changed, 112 insertions(+), 411 deletions(-)

Index: drivers/pci/hotplug/cpci_hotplug.h
===================================================================
--- aefa5d7e3d4689f5f1df21a7820088e8d9c7070b/drivers/pci/hotplug/cpci_hotplug.h  (mode:100644)
+++ 2af3b43ed8ee9468b1e0418c10275f33d23ced19/drivers/pci/hotplug/cpci_hotplug.h  (mode:100644)
@@ -31,7 +31,7 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 
-/* PICMG 2.12 R2.0 HS CSR bits: */
+/* PICMG 2.1 R2.0 HS CSR bits: */
 #define HS_CSR_INS	0x0080
 #define HS_CSR_EXT	0x0040
 #define HS_CSR_PI	0x0030
Index: drivers/pci/hotplug/cpci_hotplug_core.c
===================================================================
--- aefa5d7e3d4689f5f1df21a7820088e8d9c7070b/drivers/pci/hotplug/cpci_hotplug_core.c  (mode:100644)
+++ 2af3b43ed8ee9468b1e0418c10275f33d23ced19/drivers/pci/hotplug/cpci_hotplug_core.c  (mode:100644)
@@ -33,11 +33,11 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
+#include <asm/atomic.h>
 #include <linux/delay.h>
 #include "pci_hotplug.h"
 #include "cpci_hotplug.h"
 
-#define DRIVER_VERSION	"0.2"
 #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
 #define DRIVER_DESC	"CompactPCI Hot Plug Core"
 
@@ -54,9 +54,10 @@
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
 
 /* local variables */
-static spinlock_t list_lock;
+static DECLARE_RWSEM(list_rwsem);
 static LIST_HEAD(slot_list);
 static int slots;
+static atomic_t extracting;
 int cpci_debug;
 static struct cpci_hp_controller *controller;
 static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
@@ -68,6 +69,8 @@
 static int set_attention_status(struct hotplug_slot *slot, u8 value);
 static int get_power_status(struct hotplug_slot *slot, u8 * value);
 static int get_attention_status(struct hotplug_slot *slot, u8 * value);
+static int get_adapter_status(struct hotplug_slot *slot, u8 * value);
+static int get_latch_status(struct hotplug_slot *slot, u8 * value);
 
 static struct hotplug_slot_ops cpci_hotplug_slot_ops = {
 	.owner = THIS_MODULE,
@@ -76,6 +79,8 @@
 	.set_attention_status = set_attention_status,
 	.get_power_status = get_power_status,
 	.get_attention_status = get_attention_status,
+	.get_adapter_status = get_adapter_status,
+	.get_latch_status = get_latch_status,
 };
 
 static int
@@ -148,8 +153,10 @@
 		warn("failure to update adapter file");
 	}
 
-	slot->extracting = 0;
-
+	if(slot->extracting) {
+		slot->extracting = 0;
+		atomic_dec(&extracting);
+	}
 	return retval;
 }
 
@@ -188,6 +195,20 @@
 	return cpci_set_attention_status(hotplug_slot->private, status);
 }
 
+static int
+get_adapter_status(struct hotplug_slot *hotplug_slot, u8 * value)
+{
+	*value = hotplug_slot->info->adapter_status;
+	return 0;
+}
+
+static int
+get_latch_status(struct hotplug_slot *hotplug_slot, u8 * value)
+{
+	*value = hotplug_slot->info->latch_status;
+	return 0;
+}
+
 static void release_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct slot *slot = hotplug_slot->private;
@@ -273,10 +294,10 @@
 		}
 
 		/* Add slot to our internal list */
-		spin_lock(&list_lock);
+		down_write(&list_rwsem);
 		list_add(&slot->slot_list, &slot_list);
 		slots++;
-		spin_unlock(&list_lock);
+		up_write(&list_rwsem);
 	}
 	return 0;
 error_name:
@@ -299,9 +320,9 @@
 	struct list_head *next;
 	int status;
 
-	spin_lock(&list_lock);
+	down_write(&list_rwsem);
 	if(!slots) {
-		spin_unlock(&list_lock);
+		up_write(&list_rwsem);
 		return -1;
 	}
 	list_for_each_safe(tmp, next, &slot_list) {
@@ -319,7 +340,7 @@
 			slots--;
 		}
 	}
-	spin_unlock(&list_lock);
+	up_write(&list_rwsem);
 	return 0;
 }
 
@@ -347,7 +368,7 @@
 }
 
 /*
- * According to PICMG 2.12 R2.0, section 6.3.2, upon
+ * According to PICMG 2.1 R2.0, section 6.3.2, upon
  * initialization, the system driver shall clear the
  * INS bits of the cold-inserted devices.
  */
@@ -359,9 +380,9 @@
 	struct pci_dev* dev;
 
 	dbg("%s - enter", __FUNCTION__);
-	spin_lock(&list_lock);
+	down_read(&list_rwsem);
 	if(!slots) {
-		spin_unlock(&list_lock);
+		up_read(&list_rwsem);
 		return -1;
 	}
 	list_for_each(tmp, &slot_list) {
@@ -386,7 +407,7 @@
 			}
 		}
 	}
-	spin_unlock(&list_lock);
+	up_read(&list_rwsem);
 	dbg("%s - exit", __FUNCTION__);
 	return 0;
 }
@@ -398,10 +419,11 @@
 	struct list_head *tmp;
 	int extracted;
 	int inserted;
+	u16 hs_csr;
 
-	spin_lock(&list_lock);
+	down_read(&list_rwsem);
 	if(!slots) {
-		spin_unlock(&list_lock);
+		up_read(&list_rwsem);
 		err("no slots registered, shutting down");
 		return -1;
 	}
@@ -411,8 +433,6 @@
 		dbg("%s - looking at slot %s",
 		    __FUNCTION__, slot->hotplug_slot->name);
 		if(cpci_check_and_clear_ins(slot)) {
-			u16 hs_csr;
-
 			/* Some broken hardware (e.g. PLX 9054AB) asserts ENUM# twice... */
 			if(slot->dev) {
 				warn("slot %s already inserted", slot->hotplug_slot->name);
@@ -462,8 +482,6 @@
 
 			inserted++;
 		} else if(cpci_check_ext(slot)) {
-			u16 hs_csr;
-
 			/* Process extraction request */
 			dbg("%s - slot %s extracted",
 			    __FUNCTION__, slot->hotplug_slot->name);
@@ -476,20 +494,40 @@
 			if(!slot->extracting) {
 				if(update_latch_status(slot->hotplug_slot, 0)) {
 					warn("failure to update latch file");
+
 				}
+				atomic_inc(&extracting);
 				slot->extracting = 1;
 			}
 			extracted++;
+		} else if(slot->extracting) {
+			hs_csr = cpci_get_hs_csr(slot);
+			if(hs_csr == 0xffff) {
+				/*
+				 * Hmmm, we're likely hosed at this point, should we
+				 * bother trying to tell the driver or not?
+				 */
+				err("card in slot %s was improperly removed",
+				    slot->hotplug_slot->name);
+				if(update_adapter_status(slot->hotplug_slot, 0)) {
+					warn("failure to update adapter file");
+				}
+				slot->extracting = 0;
+				atomic_dec(&extracting);
+			}
 		}
 	}
-	spin_unlock(&list_lock);
+	up_read(&list_rwsem);
+	dbg("inserted=%d, extracted=%d, extracting=%d",
+	    inserted, extracted, atomic_read(&extracting));
 	if(inserted || extracted) {
 		return extracted;
 	}
-	else {
+	else if(!atomic_read(&extracting)) {
 		err("cannot find ENUM# source, shutting down");
 		return -1;
 	}
+	return 0;
 }
 
 /* This is the interrupt mode worker thread body */
@@ -497,8 +535,6 @@
 event_thread(void *data)
 {
 	int rc;
-	struct slot *slot;
-	struct list_head *tmp;
 
 	lock_kernel();
 	daemonize("cpci_hp_eventd");
@@ -512,39 +548,22 @@
 		    thread_finished);
 		if(thread_finished || signal_pending(current))
 			break;
-		while(controller->ops->query_enum()) {
+		do {
 			rc = check_slots();
-			if (rc > 0)
+			if (rc > 0) {
 				/* Give userspace a chance to handle extraction */
 				msleep(500);
-			else if (rc < 0) {
+			} else if (rc < 0) {
 				dbg("%s - error checking slots", __FUNCTION__);
 				thread_finished = 1;
 				break;
 			}
-		}
-		/* Check for someone yanking out a board */
-		list_for_each(tmp, &slot_list) {
-			slot = list_entry(tmp, struct slot, slot_list);
-			if(slot->extracting) {
-				/*
-				 * Hmmm, we're likely hosed at this point, should we
-				 * bother trying to tell the driver or not?
-				 */
-				err("card in slot %s was improperly removed",
-				    slot->hotplug_slot->name);
-				if(update_adapter_status(slot->hotplug_slot, 0)) {
-					warn("failure to update adapter file");
-				}
-				slot->extracting = 0;
-			}
-		}
+		} while(atomic_read(&extracting) != 0);
 
 		/* Re-enable ENUM# interrupt */
 		dbg("%s - re-enabling irq", __FUNCTION__);
 		controller->ops->enable_irq();
 	}
-
 	dbg("%s - event thread signals exit", __FUNCTION__);
 	up(&thread_exit);
 	return 0;
@@ -555,8 +574,6 @@
 poll_thread(void *data)
 {
 	int rc;
-	struct slot *slot;
-	struct list_head *tmp;
 
 	lock_kernel();
 	daemonize("cpci_hp_polld");
@@ -565,35 +582,19 @@
 	while(1) {
 		if(thread_finished || signal_pending(current))
 			break;
-
-		while(controller->ops->query_enum()) {
-			rc = check_slots();
-			if(rc > 0)
-				/* Give userspace a chance to handle extraction */
-				msleep(500);
-			else if (rc < 0) {
-				dbg("%s - error checking slots", __FUNCTION__);
-				thread_finished = 1;
-				break;
-			}
-		}
-		/* Check for someone yanking out a board */
-		list_for_each(tmp, &slot_list) {
-			slot = list_entry(tmp, struct slot, slot_list);
-			if(slot->extracting) {
-				/*
-				 * Hmmm, we're likely hosed at this point, should we
-				 * bother trying to tell the driver or not?
-				 */
-				err("card in slot %s was improperly removed",
-				    slot->hotplug_slot->name);
-				if(update_adapter_status(slot->hotplug_slot, 0)) {
-					warn("failure to update adapter file");
+		if(controller->ops->query_enum()) {
+			do {
+				rc = check_slots();
+				if(rc > 0) {
+					/* Give userspace a chance to handle extraction */
+					msleep(500);
+				} else if(rc < 0) {
+					dbg("%s - error checking slots", __FUNCTION__);
+					thread_finished = 1;
+					break;
 				}
-				slot->extracting = 0;
-			}
+			} while(atomic_read(&extracting) != 0);
 		}
-
 		msleep(100);
 	}
 	dbg("poll thread signals exit");
@@ -667,6 +668,9 @@
 	int status = 0;
 
 	if(controller) {
+		if(atomic_read(&extracting) != 0) {
+			return -EBUSY;
+		}
 		if(!thread_finished) {
 			cpci_stop_thread();
 		}
@@ -691,12 +695,12 @@
 		return -ENODEV;
 	}
 
-	spin_lock(&list_lock);
-	if(!slots) {
-		spin_unlock(&list_lock);
+	down_read(&list_rwsem);
+	if(list_empty(&slot_list)) {
+		up_read(&list_rwsem);
 		return -ENODEV;
 	}
-	spin_unlock(&list_lock);
+	up_read(&list_rwsem);
 
 	if(first) {
 		status = init_slots();
@@ -727,7 +731,9 @@
 	if(!controller) {
 		return -ENODEV;
 	}
-
+	if(atomic_read(&extracting) != 0) {
+		return -EBUSY;
+	}
 	if(controller->irq) {
 		/* Stop enum interrupt processing */
 		dbg("%s - disabling irq", __FUNCTION__);
@@ -747,7 +753,7 @@
 	 * Unregister all of our slots with the pci_hotplug subsystem,
 	 * and free up all memory that we had allocated.
 	 */
-	spin_lock(&list_lock);
+	down_write(&list_rwsem);
 	if(!slots) {
 		goto null_cleanup;
 	}
@@ -761,17 +767,14 @@
 		kfree(slot);
 	}
       null_cleanup:
-	spin_unlock(&list_lock);
+	up_write(&list_rwsem);
 	return;
 }
 
 int __init
 cpci_hotplug_init(int debug)
 {
-	spin_lock_init(&list_lock);
 	cpci_debug = debug;
-
-	info(DRIVER_DESC " version: " DRIVER_VERSION);
 	return 0;
 }
 
Index: drivers/pci/hotplug/cpci_hotplug_pci.c
===================================================================
--- aefa5d7e3d4689f5f1df21a7820088e8d9c7070b/drivers/pci/hotplug/cpci_hotplug_pci.c  (mode:100644)
+++ 2af3b43ed8ee9468b1e0418c10275f33d23ced19/drivers/pci/hotplug/cpci_hotplug_pci.c  (mode:100644)
@@ -32,11 +32,7 @@
 #include "pci_hotplug.h"
 #include "cpci_hotplug.h"
 
-#if !defined(MODULE)
 #define MY_NAME	"cpci_hotplug"
-#else
-#define MY_NAME	THIS_MODULE->name
-#endif
 
 extern int cpci_debug;
 
@@ -127,38 +123,6 @@
 	return hs_csr;
 }
 
-#if 0
-u16 cpci_set_hs_csr(struct slot* slot, u16 hs_csr)
-{
-	int hs_cap;
-	u16 new_hs_csr;
-
-	hs_cap = pci_bus_find_capability(slot->bus,
-					 slot->devfn,
-					 PCI_CAP_ID_CHSWP);
-	if(!hs_cap) {
-		return 0xFFFF;
-	}
-
-	/* Write out the new value */
-	if(pci_bus_write_config_word(slot->bus,
-				      slot->devfn,
-				      hs_cap + 2,
-				      hs_csr)) {
-		return 0xFFFF;
-	}
-
-	/* Read back what we just wrote out */
-	if(pci_bus_read_config_word(slot->bus,
-				     slot->devfn,
-				     hs_cap + 2,
-				     &new_hs_csr)) {
-		return 0xFFFF;
-	}
-	return new_hs_csr;
-}
-#endif
-
 int cpci_check_and_clear_ins(struct slot* slot)
 {
 	int hs_cap;
@@ -261,7 +225,6 @@
 		return -ENODEV;
 	}
 	if((hs_csr & HS_CSR_LOO) != HS_CSR_LOO) {
-		/* Set LOO */
 		hs_csr |= HS_CSR_LOO;
 		if(pci_bus_write_config_word(slot->bus,
 					      slot->devfn,
@@ -293,7 +256,6 @@
 		return -ENODEV;
 	}
 	if(hs_csr & HS_CSR_LOO) {
-		/* Clear LOO */
 		hs_csr &= ~HS_CSR_LOO;
 		if(pci_bus_write_config_word(slot->bus,
 					      slot->devfn,
@@ -312,257 +274,23 @@
  * Device configuration functions
  */
 
-static int cpci_configure_dev(struct pci_bus *bus, struct pci_dev *dev)
-{
-	u8 irq_pin;
-	int r;
-
-	dbg("%s - enter", __FUNCTION__);
-
-	/* NOTE: device already setup from prior scan */
-
-	/* FIXME: How would we know if we need to enable the expansion ROM? */
-	pci_write_config_word(dev, PCI_ROM_ADDRESS, 0x00L);
-
-	/* Assign resources */
-	dbg("assigning resources for %02x:%02x.%x",
-	    dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	for (r = 0; r < 6; r++) {
-		struct resource *res = dev->resource + r;
-		if(res->flags)
-			pci_assign_resource(dev, r);
-	}
-	dbg("finished assigning resources for %02x:%02x.%x",
-	    dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-
-	/* Does this function have an interrupt at all? */
-	dbg("checking for function interrupt");
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq_pin);
-	if(irq_pin) {
-		dbg("function uses interrupt pin %d", irq_pin);
-	}
-
-	/*
-	 * Need to explicitly set irq field to 0 so that it'll get assigned
-	 * by the pcibios platform dependent code called by pci_enable_device.
-	 */
-	dev->irq = 0;
-
-	dbg("enabling device");
-	pci_enable_device(dev);	/* XXX check return */
-	dbg("now dev->irq = %d", dev->irq);
-	if(irq_pin && dev->irq) {
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-	}
-
-	/* Can't use pci_insert_device at the moment, do it manually for now */
-	pci_proc_attach_device(dev);
-	dbg("notifying drivers");
-	//pci_announce_device_to_drivers(dev);
-	dbg("%s - exit", __FUNCTION__);
-	return 0;
-}
-
-static int cpci_configure_bridge(struct pci_bus* bus, struct pci_dev* dev)
+static void cpci_enable_device(struct pci_dev *dev)
 {
-	int rc;
-	struct pci_bus* child;
-	struct resource* r;
-	u8 max, n;
-	u16 command;
-
-	dbg("%s - enter", __FUNCTION__);
+	struct pci_bus *bus;
 
-	/* Do basic bridge initialization */
-	rc = pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x40);
-	if(rc) {
-		printk(KERN_ERR "%s - write of PCI_LATENCY_TIMER failed\n", __FUNCTION__);
-	}
-	rc = pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER, 0x40);
-	if(rc) {
-		printk(KERN_ERR "%s - write of PCI_SEC_LATENCY_TIMER failed\n", __FUNCTION__);
-	}
-	rc = pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, L1_CACHE_BYTES / 4);
-	if(rc) {
-		printk(KERN_ERR "%s - write of PCI_CACHE_LINE_SIZE failed\n", __FUNCTION__);
-	}
-
-	/*
-	 * Set parent bridge's subordinate field so that configuration space
-	 * access will work in pci_scan_bridge and friends.
-	 */
-	max = pci_max_busnr();
-	bus->subordinate = max + 1;
-	pci_write_config_byte(bus->self, PCI_SUBORDINATE_BUS, max + 1);
-
-	/* Scan behind bridge */
-	n = pci_scan_bridge(bus, dev, max, 2);
-	child = pci_find_bus(0, max + 1);
-	if (!child)
-		return -ENODEV;
-	pci_proc_attach_bus(child);
-
-	/*
-	 * Update parent bridge's subordinate field if there were more bridges
-	 * behind the bridge that was scanned.
-	 */
-	if(n > max) {
-		bus->subordinate = n;
-		pci_write_config_byte(bus->self, PCI_SUBORDINATE_BUS, n);
-	}
-
-	/*
-	 * Update the bridge resources of the bridge to accommodate devices
-	 * behind it.
-	 */
-	pci_bus_size_bridges(child);
-	pci_bus_assign_resources(child);
-
-	/* Enable resource mapping via command register */
-	command = PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
-	r = child->resource[0];
-	if(r && r->start) {
-		command |= PCI_COMMAND_IO;
-	}
-	r = child->resource[1];
-	if(r && r->start) {
-		command |= PCI_COMMAND_MEMORY;
-	}
-	r = child->resource[2];
-	if(r && r->start) {
-		command |= PCI_COMMAND_MEMORY;
-	}
-	rc = pci_write_config_word(dev, PCI_COMMAND, command);
-	if(rc) {
-		err("Error setting command register");
-		return rc;
-	}
-
-	/* Set bridge control register */
-	command = PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR | PCI_BRIDGE_CTL_NO_ISA;
-	rc = pci_write_config_word(dev, PCI_BRIDGE_CONTROL, command);
-	if(rc) {
-		err("Error setting bridge control register");
-		return rc;
-	}
-	dbg("%s - exit", __FUNCTION__);
-	return 0;
-}
-
-static int configure_visit_pci_dev(struct pci_dev_wrapped *wrapped_dev,
-				   struct pci_bus_wrapped *wrapped_bus)
-{
-	int rc;
-	struct pci_dev *dev = wrapped_dev->dev;
-	struct pci_bus *bus = wrapped_bus->bus;
-	struct slot* slot;
-
-	dbg("%s - enter", __FUNCTION__);
-
-	/*
-	 * We need to fix up the hotplug representation with the Linux
-	 * representation.
-	 */
-	if(wrapped_dev->data) {
-		slot = (struct slot*) wrapped_dev->data;
-		slot->dev = dev;
-	}
-
-	/* If it's a bridge, scan behind it for devices */
+	pci_enable_device(dev);
 	if(dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		rc = cpci_configure_bridge(bus, dev);
-		if(rc)
-			return rc;
-	}
-
-	/* Actually configure device */
-	if(dev) {
-		rc = cpci_configure_dev(bus, dev);
-		if(rc)
-			return rc;
-	}
-	dbg("%s - exit", __FUNCTION__);
-	return 0;
-}
-
-static int unconfigure_visit_pci_dev_phase2(struct pci_dev_wrapped *wrapped_dev,
-					    struct pci_bus_wrapped *wrapped_bus)
-{
-	struct pci_dev *dev = wrapped_dev->dev;
-	struct slot* slot;
-
-	dbg("%s - enter", __FUNCTION__);
-	if(!dev)
-		return -ENODEV;
-
-	/* Remove the Linux representation */
-	if(pci_remove_device_safe(dev)) {
-		err("Could not remove device\n");
-		return -1;
-	}
-
-	/*
-	 * Now remove the hotplug representation.
-	 */
-	if(wrapped_dev->data) {
-		slot = (struct slot*) wrapped_dev->data;
-		slot->dev = NULL;
-	} else {
-		dbg("No hotplug representation for %02x:%02x.%x",
-		    dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	}
-	dbg("%s - exit", __FUNCTION__);
-	return 0;
-}
-
-static int unconfigure_visit_pci_bus_phase2(struct pci_bus_wrapped *wrapped_bus,
-					    struct pci_dev_wrapped *wrapped_dev)
-{
-	struct pci_bus *bus = wrapped_bus->bus;
-	struct pci_bus *parent = bus->self->bus;
-
-	dbg("%s - enter", __FUNCTION__);
-
-	/* The cleanup code for proc entries regarding buses should be in the kernel... */
-	if(bus->procdir)
-		dbg("detach_pci_bus %s", bus->procdir->name);
-	pci_proc_detach_bus(bus);
-
-	/* The cleanup code should live in the kernel... */
-	bus->self->subordinate = NULL;
-
-	/* unlink from parent bus */
-	list_del(&bus->node);
-
-	/* Now, remove */
-	if(bus)
-		kfree(bus);
-
-	/* Update parent's subordinate field */
-	if(parent) {
-		u8 n = pci_bus_max_busnr(parent);
-		if(n < parent->subordinate) {
-			parent->subordinate = n;
-			pci_write_config_byte(parent->self, PCI_SUBORDINATE_BUS, n);
+		bus = dev->subordinate;
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			cpci_enable_device(dev);
 		}
 	}
-	dbg("%s - exit", __FUNCTION__);
-	return 0;
 }
 
-static struct pci_visit configure_functions = {
-	.visit_pci_dev = configure_visit_pci_dev,
-};
-
-static struct pci_visit unconfigure_functions_phase2 = {
-	.post_visit_pci_bus = unconfigure_visit_pci_bus_phase2,
-	.post_visit_pci_dev = unconfigure_visit_pci_dev_phase2
-};
-
-
 int cpci_configure_slot(struct slot* slot)
 {
-	int rc = 0;
+	unsigned char busnr;
+	struct pci_bus *child;
 
 	dbg("%s - enter", __FUNCTION__);
 
@@ -588,74 +316,44 @@
 		slot->dev = pci_find_slot(slot->bus->number, slot->devfn);
 		if(slot->dev == NULL) {
 			err("Could not find PCI device for slot %02x", slot->number);
-			return 0;
+			return 1;
 		}
 	}
-	dbg("slot->dev = %p", slot->dev);
-	if(slot->dev) {
-		struct pci_dev *dev;
-		struct pci_dev_wrapped wrapped_dev;
-		struct pci_bus_wrapped wrapped_bus;
-		int i;
-
-		memset(&wrapped_dev, 0, sizeof (struct pci_dev_wrapped));
-		memset(&wrapped_bus, 0, sizeof (struct pci_bus_wrapped));
-
-		for (i = 0; i < 8; i++) {
-			dev = pci_find_slot(slot->bus->number,
-					    PCI_DEVFN(PCI_SLOT(slot->dev->devfn), i));
-			if(!dev)
-				continue;
-			wrapped_dev.dev = dev;
-			wrapped_bus.bus = slot->dev->bus;
-			if(i)
-				wrapped_dev.data = NULL;
-			else
-				wrapped_dev.data = (void*) slot;
-			rc = pci_visit_dev(&configure_functions, &wrapped_dev, &wrapped_bus);
-		}
+
+	if (slot->dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		pci_read_config_byte(slot->dev, PCI_SECONDARY_BUS, &busnr);
+		child = pci_add_new_bus(slot->dev->bus, slot->dev, busnr);
+		pci_do_scan_bus(child);
+		pci_bus_size_bridges(child);
 	}
 
-	dbg("%s - exit, rc = %d", __FUNCTION__, rc);
-	return rc;
+	pci_bus_assign_resources(slot->dev->bus);
+
+	cpci_enable_device(slot->dev);
+
+	dbg("%s - exit", __FUNCTION__);
+	return 0;
 }
 
 int cpci_unconfigure_slot(struct slot* slot)
 {
-	int rc = 0;
 	int i;
-	struct pci_dev_wrapped wrapped_dev;
-	struct pci_bus_wrapped wrapped_bus;
 	struct pci_dev *dev;
 
 	dbg("%s - enter", __FUNCTION__);
-
 	if(!slot->dev) {
 		err("No device for slot %02x\n", slot->number);
 		return -ENODEV;
 	}
 
-	memset(&wrapped_dev, 0, sizeof (struct pci_dev_wrapped));
-	memset(&wrapped_bus, 0, sizeof (struct pci_bus_wrapped));
-
 	for (i = 0; i < 8; i++) {
 		dev = pci_find_slot(slot->bus->number,
 				    PCI_DEVFN(PCI_SLOT(slot->devfn), i));
 		if(dev) {
-			wrapped_dev.dev = dev;
-			wrapped_bus.bus = dev->bus;
- 			if(i)
- 				wrapped_dev.data = NULL;
- 			else
- 				wrapped_dev.data = (void*) slot;
-			dbg("%s - unconfigure phase 2", __FUNCTION__);
-			rc = pci_visit_dev(&unconfigure_functions_phase2,
-					   &wrapped_dev,
-					   &wrapped_bus);
-			if(rc)
-				break;
+			pci_remove_bus_device(dev);
+			slot->dev = NULL;
 		}
 	}
-	dbg("%s - exit, rc = %d", __FUNCTION__, rc);
-	return rc;
+	dbg("%s - exit", __FUNCTION__);
+	return 0;
 }

