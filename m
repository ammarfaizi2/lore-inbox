Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbVKDAvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbVKDAvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbVKDAuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:50:52 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:51091
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161012AbVKDAuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:50:05 -0500
Date: Thu, 3 Nov 2005 18:50:04 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 12/42]: ppc64: PCI error event dispatcher
Message-ID: <20051104005004.GA26878@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

12-eeh-event-dispatcher.patch

ppc64: EEH Recovery dispatcher thread

This patch adds a mechanism to create recovery threads when an
EEH event is received.  Since an EEH freeze state may be detected 
within an interrupt context, we need to get out of the interrupt
context before starting recovery. This dispatcher does this in 
two steps: first, it uses a workqueue to get out, and then 
lanuches a kernel thread, so that the recovery routine can 
sleep for exteded periods without upseting the keventd.

A kernel thread is created with each EEH event, rather than 
having one long-running daemon started at boot time.  This is 
because it is anticipated that EEH events will be very rare 
(very very rare, ideally) and so its pointless to cluter the 
process tables with a daemon that will almost never run.


Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:30:49.790591516 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:32:35.713742506 -0600
@@ -19,7 +19,6 @@
 
 #include <linux/init.h>
 #include <linux/list.h>
-#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/rbtree.h>
@@ -27,12 +26,12 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 #include <asm/eeh.h>
+#include <asm/eeh_event.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
+#include <asm/ppc-pci.h>
 #include <asm/rtas.h>
-#include <asm/atomic.h>
 #include <asm/systemcfg.h>
-#include <asm/ppc-pci.h>
 
 #undef DEBUG
 
@@ -70,14 +69,6 @@
  *  and sent out for processing.
  */
 
-/* EEH event workqueue setup. */
-static DEFINE_SPINLOCK(eeh_eventlist_lock);
-LIST_HEAD(eeh_eventlist);
-static void eeh_event_handler(void *);
-DECLARE_WORK(eeh_event_wq, eeh_event_handler, NULL);
-
-static struct notifier_block *eeh_notifier_chain;
-
 /* If a device driver keeps reading an MMIO register in an interrupt
  * handler after a slot isolation event has occurred, we assume it
  * is broken and panic.  This sets the threshold for how many read
@@ -421,24 +412,6 @@
 }
 
 /**
- * eeh_register_notifier - Register to find out about EEH events.
- * @nb: notifier block to callback on events
- */
-int eeh_register_notifier(struct notifier_block *nb)
-{
-	return notifier_chain_register(&eeh_notifier_chain, nb);
-}
-
-/**
- * eeh_unregister_notifier - Unregister to an EEH event notifier.
- * @nb: notifier block to callback on events
- */
-int eeh_unregister_notifier(struct notifier_block *nb)
-{
-	return notifier_chain_unregister(&eeh_notifier_chain, nb);
-}
-
-/**
  * read_slot_reset_state - Read the reset state of a device node's slot
  * @dn: device node to read
  * @rets: array to return results in
@@ -461,73 +434,6 @@
 }
 
 /**
- * eeh_panic - call panic() for an eeh event that cannot be handled.
- * The philosophy of this routine is that it is better to panic and
- * halt the OS than it is to risk possible data corruption by
- * oblivious device drivers that don't know better.
- *
- * @dev pci device that had an eeh event
- * @reset_state current reset state of the device slot
- */
-static void eeh_panic(struct pci_dev *dev, int reset_state)
-{
-	/*
-	 * XXX We should create a separate sysctl for this.
-	 *
-	 * Since the panic_on_oops sysctl is used to halt the system
-	 * in light of potential corruption, we can use it here.
-	 */
-	if (panic_on_oops) {
-		struct device_node *dn = pci_device_to_OF_node(dev);
-		eeh_slot_error_detail (PCI_DN(dn), 2 /* Permanent Error */);
-		panic("EEH: MMIO failure (%d) on device:%s\n", reset_state,
-		      pci_name(dev));
-	}
-	else {
-		__get_cpu_var(ignored_failures)++;
-		printk(KERN_INFO "EEH: Ignored MMIO failure (%d) on device:%s\n",
-		       reset_state, pci_name(dev));
-	}
-}
-
-/**
- * eeh_event_handler - dispatch EEH events.  The detection of a frozen
- * slot can occur inside an interrupt, where it can be hard to do
- * anything about it.  The goal of this routine is to pull these
- * detection events out of the context of the interrupt handler, and
- * re-dispatch them for processing at a later time in a normal context.
- *
- * @dummy - unused
- */
-static void eeh_event_handler(void *dummy)
-{
-	unsigned long flags;
-	struct eeh_event	*event;
-
-	while (1) {
-		spin_lock_irqsave(&eeh_eventlist_lock, flags);
-		event = NULL;
-		if (!list_empty(&eeh_eventlist)) {
-			event = list_entry(eeh_eventlist.next, struct eeh_event, list);
-			list_del(&event->list);
-		}
-		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
-		if (event == NULL)
-			break;
-
-		printk(KERN_INFO "EEH: MMIO failure (%d), notifiying device "
-		       "%s\n", event->reset_state,
-		       pci_name(event->dev));
-
-		notifier_call_chain (&eeh_notifier_chain,
-				     EEH_NOTIFY_FREEZE, event);
-
-		pci_dev_put(event->dev);
-		kfree(event);
-	}
-}
-
-/**
  * eeh_token_to_phys - convert EEH address token to phys address
  * @token i/o token, should be address in the form 0xA....
  */
@@ -613,8 +519,6 @@
 	int ret;
 	int rets[3];
 	unsigned long flags;
-	int reset_state;
-	struct eeh_event  *event;
 	struct pci_dn *pdn;
 	struct device_node *pe_dn;
 	int rc = 0;
@@ -722,33 +626,12 @@
 	__eeh_mark_slot (pe_dn);
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 
-	reset_state = rets[0];
-
-	eeh_slot_error_detail (pdn, 1 /* Temporary Error */);
-
-	printk(KERN_INFO "EEH: MMIO failure (%d) on device: %s %s\n",
-	       rets[0], dn->name, dn->full_name);
-	event = kmalloc(sizeof(*event), GFP_ATOMIC);
-	if (event == NULL) {
-		eeh_panic(dev, reset_state);
-		return 1;
- 	}
-
-	event->dev = dev;
-	event->dn = dn;
-	event->reset_state = reset_state;
-
-	/* We may or may not be called in an interrupt context */
-	spin_lock_irqsave(&eeh_eventlist_lock, flags);
-	list_add(&event->list, &eeh_eventlist);
-	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
-
+	eeh_send_failure_event (dn, dev, rets[0], rets[2]);
+	
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out. */
 	if (rets[0] != 5) dump_stack();
-	schedule_work(&eeh_event_wq);
-
 	return 1;
 
 dn_unlock:
@@ -793,6 +676,14 @@
 
 EXPORT_SYMBOL(eeh_check_failure);
 
+/* ------------------------------------------------------------- */
+/* The code below deals with enabling EEH for devices during  the
+ * early boot sequence.  EEH must be enabled before any PCI probing
+ * can be done.
+ */
+
+#define EEH_ENABLE 1
+
 struct eeh_early_enable_info {
 	unsigned int buid_hi;
 	unsigned int buid_lo;
@@ -850,8 +741,9 @@
 		/* First register entry is addr (00BBSS00)  */
 		/* Try to enable eeh */
 		ret = rtas_call(ibm_set_eeh_option, 4, 1, NULL,
-				regs[0], info->buid_hi, info->buid_lo,
-				EEH_ENABLE);
+		                regs[0], info->buid_hi, info->buid_lo,
+		                EEH_ENABLE);
+
 		if (ret == 0) {
 			eeh_subsystem_enabled = 1;
 			pdn->eeh_mode |= EEH_MODE_SUPPORTED;
Index: linux-2.6.14-git3/include/asm-powerpc/eeh_event.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14-git3/include/asm-powerpc/eeh_event.h	2005-11-02 14:32:35.718741805 -0600
@@ -0,0 +1,52 @@
+/*
+ *	eeh_event.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * Copyright (c) 2005 Linas Vepstas <linas@linas.org>
+ */
+
+#ifndef ASM_PPC64_EEH_EVENT_H
+#define ASM_PPC64_EEH_EVENT_H
+
+/** EEH event -- structure holding pci controller data that describes
+ *  a change in the isolation status of a PCI slot.  A pointer
+ *  to this struct is passed as the data pointer in a notify callback.
+ */
+struct eeh_event {
+	struct list_head     list;
+	struct device_node 	*dn;   /* struct device node */
+	struct pci_dev       *dev;  /* affected device */
+	int                  state;
+	int time_unavail;    /* milliseconds until device might be available */
+};
+
+/**
+ * eeh_send_failure_event - generate a PCI error event
+ * @dev pci device
+ *
+ * This routine builds a PCI error event which will be delivered
+ * to all listeners on the peh_notifier_chain.
+ *
+ * This routine can be called within an interrupt context;
+ * the actual event will be delivered in a normal context
+ * (from a workqueue).
+ */
+int eeh_send_failure_event (struct device_node *dn,
+                            struct pci_dev *dev,
+                            int reset_state,
+                            int time_unavail);
+
+#endif /* ASM_PPC64_EEH_EVENT_H */
Index: linux-2.6.14-git3/include/asm-ppc64/eeh.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-ppc64/eeh.h	2005-11-02 14:29:21.496968403 -0600
+++ linux-2.6.14-git3/include/asm-ppc64/eeh.h	2005-11-02 14:32:35.725740824 -0600
@@ -1,4 +1,4 @@
-/* 
+/*
  * eeh.h
  * Copyright (C) 2001  Dave Engebretsen & Todd Inglett IBM Corporation.
  *
@@ -6,12 +6,12 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
@@ -27,8 +27,6 @@
 
 struct pci_dev;
 struct device_node;
-struct device_node;
-struct notifier_block;
 
 #ifdef CONFIG_EEH
 
@@ -37,6 +35,10 @@
 #define EEH_MODE_NOCHECK	(1<<1)
 #define EEH_MODE_ISOLATED	(1<<2)
 
+/* Max number of EEH freezes allowed before we consider the device
+ * to be permanently disabled. */
+#define EEH_MAX_ALLOWED_FREEZES 5
+
 void __init eeh_init(void);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
 				unsigned long val);
@@ -59,36 +61,14 @@
  * eeh_remove_device - undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
  *
- * This routine should be when a device is removed from a running
- * system (e.g. by hotplug or dlpar).
+ * This routine should be called when a device is removed from
+ * a running system (e.g. by hotplug or dlpar).  It unregisters
+ * the PCI device from the EEH subsystem.  I/O errors affecting
+ * this device will no longer be detected after this call; thus,
+ * i/o errors affecting this slot may leave this device unusable.
  */
 void eeh_remove_device(struct pci_dev *);
 
-#define EEH_DISABLE		0
-#define EEH_ENABLE		1
-#define EEH_RELEASE_LOADSTORE	2
-#define EEH_RELEASE_DMA		3
-
-/**
- * Notifier event flags.
- */
-#define EEH_NOTIFY_FREEZE  1
-
-/** EEH event -- structure holding pci slot data that describes
- *  a change in the isolation status of a PCI slot.  A pointer
- *  to this struct is passed as the data pointer in a notify callback.
- */
-struct eeh_event {
-	struct list_head     list;
-	struct pci_dev       *dev;
-	struct device_node   *dn;
-	int                  reset_state;
-};
-
-/** Register to find out about EEH events. */
-int eeh_register_notifier(struct notifier_block *nb);
-int eeh_unregister_notifier(struct notifier_block *nb);
-
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
  *
@@ -129,7 +109,7 @@
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
 
-/* 
+/*
  * MMIO read/write operations with EEH support.
  */
 static inline u8 eeh_readb(const volatile void __iomem *addr)
Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_event.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_event.c	2005-11-02 14:32:35.731739983 -0600
@@ -0,0 +1,155 @@
+/*
+ * eeh_event.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * Copyright (c) 2005 Linas Vepstas <linas@linas.org>
+ */
+
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <asm/eeh_event.h>
+
+/** Overview:
+ *  EEH error states may be detected within exception handlers;
+ *  however, the recovery processing needs to occur asynchronously
+ *  in a normal kernel context and not an interrupt context.
+ *  This pair of routines creates an event and queues it onto a
+ *  work-queue, where a worker thread can drive recovery.
+ */
+
+/* EEH event workqueue setup. */
+static spinlock_t eeh_eventlist_lock = SPIN_LOCK_UNLOCKED;
+LIST_HEAD(eeh_eventlist);
+static void eeh_thread_launcher(void *);
+DECLARE_WORK(eeh_event_wq, eeh_thread_launcher, NULL);
+
+/**
+ * eeh_panic - call panic() for an eeh event that cannot be handled.
+ * The philosophy of this routine is that it is better to panic and
+ * halt the OS than it is to risk possible data corruption by
+ * oblivious device drivers that don't know better.
+ *
+ * @dev pci device that had an eeh event
+ * @reset_state current reset state of the device slot
+ */
+static void eeh_panic(struct pci_dev *dev, int reset_state)
+{
+	/*
+	 * Since the panic_on_oops sysctl is used to halt the system
+	 * in light of potential corruption, we can use it here.
+	 */
+	if (panic_on_oops) {
+		panic("EEH: MMIO failure (%d) on device:%s\n", reset_state,
+		      pci_name(dev));
+	}
+	else {
+		printk(KERN_INFO "EEH: Ignored MMIO failure (%d) on device:%s\n",
+		       reset_state, pci_name(dev));
+	}
+}
+
+/**
+ * eeh_event_handler - dispatch EEH events.  The detection of a frozen
+ * slot can occur inside an interrupt, where it can be hard to do
+ * anything about it.  The goal of this routine is to pull these
+ * detection events out of the context of the interrupt handler, and
+ * re-dispatch them for processing at a later time in a normal context.
+ *
+ * @dummy - unused
+ */
+static int eeh_event_handler(void * dummy)
+{
+	unsigned long flags;
+	struct eeh_event	*event;
+
+	daemonize ("eehd");
+
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_irqsave(&eeh_eventlist_lock, flags);
+		event = NULL;
+		if (!list_empty(&eeh_eventlist)) {
+			event = list_entry(eeh_eventlist.next, struct eeh_event, list);
+			list_del(&event->list);
+		}
+		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+		if (event == NULL)
+			break;
+
+		printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
+		       pci_name(event->dev));
+
+		eeh_panic (event->dev, event->state);
+
+		kfree(event);
+	}
+
+	return 0;
+}
+
+/**
+ * eeh_thread_launcher
+ *
+ * @dummy - unused
+ */
+static void eeh_thread_launcher(void *dummy)
+{
+	if (kernel_thread(eeh_event_handler, NULL, CLONE_KERNEL) < 0)
+		printk(KERN_ERR "Failed to start EEH daemon\n");
+}
+
+/**
+ * eeh_send_failure_event - generate a PCI error event
+ * @dev pci device
+ *
+ * This routine can be called within an interrupt context;
+ * the actual event will be delivered in a normal context
+ * (from a workqueue).
+ */
+int eeh_send_failure_event (struct device_node *dn,
+                            struct pci_dev *dev,
+                            int state,
+                            int time_unavail)
+{
+	unsigned long flags;
+	struct eeh_event *event;
+
+	event = kmalloc(sizeof(*event), GFP_ATOMIC);
+	if (event == NULL) {
+		printk (KERN_ERR "EEH: out of memory, event not handled\n");
+		return 1;
+ 	}
+
+	if (dev)
+		pci_dev_get(dev);
+
+	event->dn = dn;
+	event->dev = dev;
+	event->state = state;
+	event->time_unavail = time_unavail;
+
+	/* We may or may not be called in an interrupt context */
+	spin_lock_irqsave(&eeh_eventlist_lock, flags);
+	list_add(&event->list, &eeh_eventlist);
+	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+
+	schedule_work(&eeh_event_wq);
+
+	return 0;
+}
+
+/********************** END OF FILE ******************************/
Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/Makefile	2005-11-02 14:31:36.150092654 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/Makefile	2005-11-02 14:32:55.306995693 -0600
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_IBMVIO)	+= vio.o
 obj-$(CONFIG_XICS)	+= xics.o
-obj-$(CONFIG_EEH)    += eeh.o
+obj-$(CONFIG_EEH)    += eeh.o eeh_event.o
