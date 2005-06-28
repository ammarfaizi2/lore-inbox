Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVF2A4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVF2A4P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVF2Azi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:55:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:48371 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262340AbVF2AAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:00:01 -0400
Date: Tue, 28 Jun 2005 18:59:56 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 10/13]: PCI Err: PPC64-specific recovery infrastructure
Message-ID: <20050628235956.GA6455@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-10-ppc64.patch

Implements ppc64-specific parts of detecting PCI bus errors,
(via calls to the firmware to ask the hardware pci bridges)
and the related mechanisms for reseting the affects PCI
slots (again, via firmware calls).

Signed-off-by: Linas Vepstas <linas@linas.org>

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-10-ppc64.patch"

--- linux-2.6.12-git10/include/asm-ppc64/eeh.h.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/include/asm-ppc64/eeh.h	2005-06-28 16:54:06.000000000 -0500
@@ -36,6 +36,11 @@ struct notifier_block;
 #define EEH_MODE_SUPPORTED	(1<<0)
 #define EEH_MODE_NOCHECK	(1<<1)
 #define EEH_MODE_ISOLATED	(1<<2)
+#define EEH_MODE_RECOVERING	(1<<3)
+
+/* Max number of EEH freezes allowed before we consider the device
+ * to be permanently disabled. */
+#define EEH_MAX_ALLOWED_FREEZES 5
 
 void __init eeh_init(void);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
@@ -59,35 +64,71 @@ void eeh_add_device_late(struct pci_dev 
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
+/**
+ * eeh_slot_error_detail -- record and EEH error condition to the log
+ * @severity: 1 if temporary, 2 if permanent failure.
+ *
+ * Obtains the the EEH error details from the RTAS subsystem,
+ * and then logs these details with the RTAS error log system.
+ */
+void eeh_slot_error_detail (struct device_node *dn, int severity);
 
 /**
- * Notifier event flags.
+ * rtas_set_slot_reset -- unfreeze a frozen slot
+ *
+ * Clear the EEH-frozen condition on a slot.  This routine
+ * does this by asserting the PCI #RST line for 1/8th of
+ * a second; this routine will sleep while the adapter is
+ * being reset.
  */
-#define EEH_NOTIFY_FREEZE  1
+void rtas_set_slot_reset (struct device_node *dn);
 
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
+/** rtas_pci_slot_reset raises/lowers the pci #RST line
+ *  state: 1/0 to raise/lower the #RST
+ *
+ * Clear the EEH-frozen condition on a slot.  This routine
+ * asserts the PCI #RST line if the 'state' argument is '1',
+ * and drops the #RST line if 'state is '0'.  This routine is
+ * safe to call in an interrupt context.
+ *
+ */
+void rtas_pci_slot_reset(struct device_node *dn, int state);
+void eeh_pci_slot_reset(struct pci_dev *dev, int state);
+
+/** eeh_pci_slot_availability -- Indicates whether a PCI
+ *  slot is ready to be used. After a PCI reset, it may take a while
+ *  for the PCI fabric to fully reset the comminucations path to the
+ *  given PCI card.  This routine can be used to determine how long
+ *  to wait before a PCI slot might become usable.
+ *
+ *  This routine returns how long to wait (in milliseconds) before
+ *  the slot is expected to be usable.  A value of zero means the
+ *  slot is immediately usable. A negavitve value means that the
+ *  slot is permanently disabled.
+ */
+int eeh_pci_slot_availability(struct pci_dev *dev);
+
+/** Restore device configuration info across device resets.
+ */
+void eeh_restore_bars(struct device_node *);
+void eeh_pci_restore_bars(struct pci_dev *dev);
+
+/**
+ * rtas_configure_bridge -- firmware initialization of pci bridge
+ *
+ * Ask the firmware to configure any PCI bridge devices
+ * located behind the indicated node. Required after a
+ * pci device reset.
+ */
+void rtas_configure_bridge(struct device_node *dn);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
--- linux-2.6.12-git10/include/asm-ppc64/prom.h.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/include/asm-ppc64/prom.h	2005-06-28 16:33:31.000000000 -0500
@@ -119,6 +119,7 @@ struct property {
  */
 struct pci_controller;
 struct iommu_table;
+struct eeh_recovery_ops;
 
 struct device_node {
 	char	*name;
@@ -137,9 +138,13 @@ struct device_node {
 	int	devfn;			/* for pci devices */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
+	int   eeh_check_count;    /* number of times device driver ignored error */
+	int   eeh_freeze_count;   /* number of times this device froze up. */
+	int   eeh_is_bridge;      /* device is pci-to-pci bridge */
 	int	pci_ext_config_space;	/* for pci devices */
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
+	u32      config_space[16]; /* saved PCI config space */
 
 	struct	property *properties;
 	struct	device_node *parent;
--- linux-2.6.12-git10/include/asm-ppc64/rtas.h.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/include/asm-ppc64/rtas.h	2005-06-22 15:28:29.000000000 -0500
@@ -246,4 +246,6 @@ extern unsigned long rtas_rmo_buf;
 
 #define GLOBAL_INTERRUPT_QUEUE 9005
 
+extern int rtas_write_config(struct device_node *dn, int where, int size, u32 val);
+
 #endif /* _PPC64_RTAS_H */
--- linux-2.6.12-git10/arch/ppc64/kernel/eeh.c.linas-orig	2005-06-28 12:17:02.000000000 -0500
+++ linux-2.6.12-git10/arch/ppc64/kernel/eeh.c	2005-06-28 18:26:30.000000000 -0500
@@ -1,32 +1,34 @@
 /*
+ *
  * eeh.c
  * Copyright (C) 2001 Dave Engebretsen & Todd Inglett IBM Corporation
- * 
+ *
  * This program is free software; you can redistribute it and/or modify
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
  */
 
-#include <linux/bootmem.h>
+#include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/list.h>
-#include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/rbtree.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
+#include <asm/atomic.h>
 #include <asm/eeh.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
@@ -49,8 +51,8 @@
  *  were "empty": all reads return 0xff's and all writes are silently
  *  ignored.  EEH slot isolation events can be triggered by parity
  *  errors on the address or data busses (e.g. during posted writes),
- *  which in turn might be caused by dust, vibration, humidity,
- *  radioactivity or plain-old failed hardware.
+ *  which in turn might be caused by low voltage on the bus, dust,
+ *  vibration, humidity, radioactivity or plain-old failed hardware.
  *
  *  Note, however, that one of the leading causes of EEH slot
  *  freeze events are buggy device drivers, buggy device microcode,
@@ -75,22 +77,13 @@
 #define BUID_HI(buid) ((buid) >> 32)
 #define BUID_LO(buid) ((buid) & 0xffffffff)
 
-/* EEH event workqueue setup. */
-static DEFINE_SPINLOCK(eeh_eventlist_lock);
-LIST_HEAD(eeh_eventlist);
-static void eeh_event_handler(void *);
-DECLARE_WORK(eeh_event_wq, eeh_event_handler, NULL);
-
-static struct notifier_block *eeh_notifier_chain;
-
 /*
  * If a device driver keeps reading an MMIO register in an interrupt
  * handler after a slot isolation event has occurred, we assume it
  * is broken and panic.  This sets the threshold for how many read
  * attempts we allow before panicking.
  */
-#define EEH_MAX_FAILS	1000
-static atomic_t eeh_fail_count;
+#define EEH_MAX_FAILS	100000
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -107,6 +100,10 @@ static DEFINE_SPINLOCK(slot_errbuf_lock)
 static int eeh_error_buf_size;
 
 /* System monitoring statistics */
+static DEFINE_PER_CPU(unsigned long, no_device);
+static DEFINE_PER_CPU(unsigned long, no_dn);
+static DEFINE_PER_CPU(unsigned long, no_cfg_addr);
+static DEFINE_PER_CPU(unsigned long, ignored_check);
 static DEFINE_PER_CPU(unsigned long, total_mmio_ffs);
 static DEFINE_PER_CPU(unsigned long, false_positives);
 static DEFINE_PER_CPU(unsigned long, ignored_failures);
@@ -225,9 +222,9 @@ pci_addr_cache_insert(struct pci_dev *de
 	while (*p) {
 		parent = *p;
 		piar = rb_entry(parent, struct pci_io_addr_range, rb_node);
-		if (alo < piar->addr_lo) {
+		if (ahi < piar->addr_lo) {
 			p = &parent->rb_left;
-		} else if (ahi > piar->addr_hi) {
+		} else if (alo > piar->addr_hi) {
 			p = &parent->rb_right;
 		} else {
 			if (dev != piar->pcidev ||
@@ -246,6 +243,11 @@ pci_addr_cache_insert(struct pci_dev *de
 	piar->pcidev = dev;
 	piar->flags = flags;
 
+#ifdef DEBUG
+	printk (KERN_DEBUG "PIAR: insert range=[%lx:%lx] dev=%s\n",
+	               alo, ahi, pci_name (dev));
+#endif
+
 	rb_link_node(&piar->rb_node, parent, p);
 	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
 
@@ -268,9 +270,10 @@ static void __pci_addr_cache_insert_devi
 	/* Skip any devices for which EEH is not enabled. */
 	if (!(dn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    dn->eeh_mode & EEH_MODE_NOCHECK) {
-#ifdef DEBUG
-		printk(KERN_INFO "PCI: skip building address cache for=%s %s\n",
-		       pci_name(dev), pci_pretty_name(dev));
+// #ifdef DEBUG
+#if 1
+		printk(KERN_INFO "PCI: skip building address cache for=%s %s %s\n",
+		       pci_name(dev), pci_pretty_name(dev), dn->type);
 #endif
 		return;
 	}
@@ -369,8 +372,12 @@ void pci_addr_cache_remove_device(struct
  */
 void __init pci_addr_cache_build(void)
 {
+	struct device_node *dn;
 	struct pci_dev *dev = NULL;
 
+	if (!eeh_subsystem_enabled)
+		return;
+
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
 
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
@@ -379,6 +386,17 @@ void __init pci_addr_cache_build(void)
 			continue;
 		}
 		pci_addr_cache_insert_device(dev);
+
+		/* Save the BAR's; firmware doesn't restore these after EEH reset */
+		dn = pci_device_to_OF_node(dev);
+		if (dn) {
+			int i;
+			for (i = 0; i < 16; i++)
+				pci_read_config_dword(dev, i * 4, &dn->config_space[i]);
+
+			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+				dn->eeh_is_bridge = 1;
+		}
 	}
 
 #ifdef DEBUG
@@ -390,24 +408,32 @@ void __init pci_addr_cache_build(void)
 /* --------------------------------------------------------------- */
 /* Above lies the PCI Address Cache. Below lies the EEH event infrastructure */
 
-/**
- * eeh_register_notifier - Register to find out about EEH events.
- * @nb: notifier block to callback on events
- */
-int eeh_register_notifier(struct notifier_block *nb)
+void eeh_slot_error_detail (struct device_node *dn, int severity)
 {
-	return notifier_chain_register(&eeh_notifier_chain, nb);
-}
+	unsigned long flags;
+	int rc;
 
-/**
- * eeh_unregister_notifier - Unregister to an EEH event notifier.
- * @nb: notifier block to callback on events
- */
-int eeh_unregister_notifier(struct notifier_block *nb)
-{
-	return notifier_chain_unregister(&eeh_notifier_chain, nb);
+	if (!dn) return;
+
+	/* Log the error with the rtas logger */
+	spin_lock_irqsave(&slot_errbuf_lock, flags);
+	memset(slot_errbuf, 0, eeh_error_buf_size);
+
+	rc = rtas_call(ibm_slot_error_detail,
+	               8, 1, NULL, dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid), NULL, 0,
+	               virt_to_phys(slot_errbuf),
+	               eeh_error_buf_size,
+	               severity);
+
+	if (rc == 0)
+		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
+	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
 }
 
+EXPORT_SYMBOL(eeh_slot_error_detail);
+
 /**
  * read_slot_reset_state - Read the reset state of a device node's slot
  * @dn: device node to read
@@ -422,6 +448,7 @@ static int read_slot_reset_state(struct 
 		outputs = 4;
 	} else {
 		token = ibm_read_slot_reset_state;
+		rets[2] = 0; /* fake PE Unavailable info */
 		outputs = 3;
 	}
 
@@ -430,75 +457,8 @@ static int read_slot_reset_state(struct 
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
-	if (panic_on_oops)
-		panic("EEH: MMIO failure (%d) on device:%s %s\n", reset_state,
-		      pci_name(dev), pci_pretty_name(dev));
-	else {
-		__get_cpu_var(ignored_failures)++;
-		printk(KERN_INFO "EEH: Ignored MMIO failure (%d) on device:%s %s\n",
-		       reset_state, pci_name(dev), pci_pretty_name(dev));
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
-		       "%s %s\n", event->reset_state,
-		       pci_name(event->dev), pci_pretty_name(event->dev));
-
-		atomic_set(&eeh_fail_count, 0);
-		notifier_call_chain (&eeh_notifier_chain,
-				     EEH_NOTIFY_FREEZE, event);
-
-		__get_cpu_var(slot_resets)++;
-
-		pci_dev_put(event->dev);
-		kfree(event);
-	}
-}
-
-/**
- * eeh_token_to_phys - convert EEH address token to phys address
- * @token i/o token, should be address in the form 0xE....
+ * eeh_token_to_phys - convert I/O address to phys address
+ * @token i/o address, should be address in the form 0xA....
  */
 static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
@@ -513,6 +473,46 @@ static inline unsigned long eeh_token_to
 	return pa | (token & (PAGE_SIZE-1));
 }
 
+static inline struct pci_dev * eeh_find_pci_dev(struct device_node *dn)
+{
+	struct pci_dev *dev = NULL;
+	for_each_pci_dev(dev) {
+		if (pci_device_to_OF_node(dev) == dn)
+			return dev;
+	}
+	return NULL;
+}
+
+/** Mark all devices that are peers of this device as failed.
+ *  Mark the device driver too, so that it can see the failure
+ *  immediately (needed for polling in interrupts).
+ */
+static inline void eeh_mark_slot (struct device_node *dn)
+{
+	while (dn) {
+		dn->eeh_mode |= EEH_MODE_ISOLATED;
+
+		/* Mark the pci device driver too */
+		struct pci_dev *dev = eeh_find_pci_dev (dn);
+		if (dev && dev->driver) {
+			dev->driver->err_handler.error_state = pci_channel_io_frozen;
+		}
+		if (dn->child)
+			eeh_mark_slot (dn->child);
+		dn = dn->sibling;
+	}
+}
+
+static inline void eeh_clear_slot (struct device_node *dn)
+{
+	while (dn) {
+		dn->eeh_mode &= ~(EEH_MODE_RECOVERING|EEH_MODE_ISOLATED);
+		if (dn->child)
+			eeh_clear_slot (dn->child);
+		dn = dn->sibling;
+	}
+}
+
 /**
  * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
  * @dn device node
@@ -528,29 +528,37 @@ static inline unsigned long eeh_token_to
  *
  * It is safe to call this routine in an interrupt context.
  */
+extern void disable_irq_nosync(unsigned int);
+
 int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 {
 	int ret;
 	int rets[3];
-	unsigned long flags;
-	int rc, reset_state;
-	struct eeh_event  *event;
+	enum pci_channel_state state;
 
 	__get_cpu_var(total_mmio_ffs)++;
 
 	if (!eeh_subsystem_enabled)
 		return 0;
 
-	if (!dn)
+	if (!dn) {
+		__get_cpu_var(no_dn)++;
 		return 0;
+	}
 
 	/* Access to IO BARs might get this far and still not want checking. */
 	if (!(dn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    dn->eeh_mode & EEH_MODE_NOCHECK) {
+		__get_cpu_var(ignored_check)++;
+#ifdef DEBUG
+		printk ("EEH:ignored check for %s %s\n",
+		           pci_pretty_name (dev), dn->full_name);
+#endif
 		return 0;
 	}
 
 	if (!dn->eeh_config_addr) {
+		__get_cpu_var(no_cfg_addr)++;
 		return 0;
 	}
 
@@ -559,12 +567,19 @@ int eeh_dn_check_failure(struct device_n
 	 * slot, we know it's bad already, we don't need to check...
 	 */
 	if (dn->eeh_mode & EEH_MODE_ISOLATED) {
-		atomic_inc(&eeh_fail_count);
-		if (atomic_read(&eeh_fail_count) >= EEH_MAX_FAILS) {
+		dn->eeh_check_count ++;
+		if (dn->eeh_check_count >= EEH_MAX_FAILS) {
+			printk (KERN_ERR "EEH: Device driver ignored %d bad reads, panicing\n",
+			        dn->eeh_check_count);
+			dump_stack();
 			/* re-read the slot reset state */
 			if (read_slot_reset_state(dn, rets) != 0)
 				rets[0] = -1;	/* reset state unknown */
-			eeh_panic(dev, rets[0]);
+
+*((long *) 0x0) = 42;
+			/* If we are here, then we hit an infinite loop. Stop. */
+			panic("EEH: MMIO halt (%d) on device:%s %s\n", rets[0],
+		      pci_name(dev), pci_pretty_name(dev));
 		}
 		return 0;
 	}
@@ -577,53 +592,43 @@ int eeh_dn_check_failure(struct device_n
 	 * In any case they must share a common PHB.
 	 */
 	ret = read_slot_reset_state(dn, rets);
-	if (!(ret == 0 && rets[1] == 1 && (rets[0] == 2 || rets[0] == 4))) {
+	if (!(ret == 0 && ((rets[1] == 1 && (rets[0] == 2 || rets[0] >= 4))
+	                   || (rets[0] == 5)))) {
 		__get_cpu_var(false_positives)++;
 		return 0;
 	}
 
-	/* prevent repeated reports of this failure */
-	dn->eeh_mode |= EEH_MODE_ISOLATED;
-
-	reset_state = rets[0];
+	/* Note that empty slots will fail; empty slots don't have children... */
+	if ((rets[0] == 5) && (dn->child == NULL)) {
+		__get_cpu_var(false_positives)++;
+		return 0;
+	}
 
-	spin_lock_irqsave(&slot_errbuf_lock, flags);
-	memset(slot_errbuf, 0, eeh_error_buf_size);
+	/* Avoid repeated reports of this failure, including problems
+	 * with other functions on this device, and functions under 
+	 * bridges. */
+	eeh_mark_slot (dn->parent->child);
+	__get_cpu_var(slot_resets)++;
 
-	rc = rtas_call(ibm_slot_error_detail,
-	               8, 1, NULL, dn->eeh_config_addr,
-	               BUID_HI(dn->phb->buid),
-	               BUID_LO(dn->phb->buid), NULL, 0,
-	               virt_to_phys(slot_errbuf),
-	               eeh_error_buf_size,
-	               1 /* Temporary Error */);
+	if (!dev)
+		dev = eeh_find_pci_dev (dn);
 
-	if (rc == 0)
-		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
-	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
+	/* Some devices go crazy if irq's are not ack'ed; disable irq now */
+	if (dev)
+		disable_irq_nosync (dev->irq);
+
+	state = pci_channel_io_normal;
+	if ((rets[0] == 2) || (rets[0] == 4))
+		state = pci_channel_io_frozen;
+	if (rets[0] == 5)
+		state = pci_channel_io_perm_failure;
 
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
+	peh_send_failure_event (dev, state, rets[2]);
 
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out. */
-	dump_stack();
-	schedule_work(&eeh_event_wq);
+	if (rets[0] != 5) dump_stack();
 
 	return 0;
 }
@@ -635,7 +640,6 @@ EXPORT_SYMBOL(eeh_dn_check_failure);
  * @token i/o token, should be address in the form 0xA....
  * @val value, should be all 1's (XXX why do we need this arg??)
  *
- * Check for an eeh failure at the given token address.
  * Check for an EEH failure at the given token address.  Call this
  * routine if the result of a read was all 0xff's and you want to
  * find out if this is due to an EEH slot freeze event.  This routine
@@ -643,6 +647,7 @@ EXPORT_SYMBOL(eeh_dn_check_failure);
  *
  * Note this routine is safe to call in an interrupt context.
  */
+
 unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
 {
 	unsigned long addr;
@@ -652,8 +657,10 @@ unsigned long eeh_check_failure(const vo
 	/* Finding the phys addr + pci device; this is pretty quick. */
 	addr = eeh_token_to_phys((unsigned long __force) token);
 	dev = pci_get_device_by_addr(addr);
-	if (!dev)
+	if (!dev) {
+		__get_cpu_var(no_device)++;
 		return val;
+	}
 
 	dn = pci_device_to_OF_node(dev);
 	eeh_dn_check_failure (dn, dev);
@@ -664,6 +671,209 @@ unsigned long eeh_check_failure(const vo
 
 EXPORT_SYMBOL(eeh_check_failure);
 
+/* ------------------------------------------------------------- */
+/* The code below deals with error recovery */
+
+/** eeh_pci_slot_reset -- raises/lowers the pci #RST line
+ *  state: 1/0 to raise/lower the #RST
+ */
+void
+eeh_pci_slot_reset(struct pci_dev *dev, int state)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	rtas_pci_slot_reset (dn, state);
+}
+
+/** Return negative value if a permanent error, else return
+ * a number of milliseconds to wait until the PCI slot is
+ * ready to be used.
+ */
+static int
+eeh_slot_availability(struct device_node *dn)
+{
+	int rc;
+	int rets[3];
+
+	rc = read_slot_reset_state(dn, rets);
+
+	if (rc) return rc;
+
+	if (rets[1] == 0) return -1;  /* EEH is not supported */
+	if (rets[0] == 0)  return 0;  /* Oll Korrect */
+	if (rets[0] == 5) {
+		if (rets[2] == 0) return -1; /* permanently unavailable */
+		return rets[2]; /* number of millisecs to wait */
+	}
+	return -1;
+}
+
+int
+eeh_pci_slot_availability(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	if (!dn) return -1;
+
+	BUG_ON (dn->phb==NULL);
+	if (dn->phb==NULL) {
+		printk (KERN_ERR "EEH, checking on slot with no phb dn=%s dev=%s:%s\n",
+		       dn->full_name, pci_name(dev), pci_pretty_name (dev));
+		return -1;
+	}
+	return eeh_slot_availability (dn);
+}
+
+void
+rtas_pci_slot_reset(struct device_node *dn, int state)
+{
+	int rc;
+
+	if (!dn)
+		return;
+	if (!dn->phb) {
+		printk (KERN_WARNING "EEH: in slot reset, device node %s has no phb\n",                    dn->full_name);
+		return;
+	}
+
+	dn->eeh_mode |= EEH_MODE_RECOVERING;
+	rc = rtas_call(ibm_set_slot_reset,4,1, NULL,
+	               dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid),
+	               state);
+	if (rc) {
+		printk (KERN_WARNING "EEH: Unable to reset the failed slot, (%d) #RST=%d\n", rc, state);
+		return;
+	}
+
+	if (state == 0)
+		eeh_clear_slot (dn->parent->child);
+}
+
+/** rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
+ *  dn -- device node to be reset.
+ */
+
+void
+rtas_set_slot_reset(struct device_node *dn)
+{
+	int i, rc;
+
+	rtas_pci_slot_reset (dn, 1);
+
+	/* The PCI bus requires that the reset be held high for at least
+	 * a 100 milliseconds. We wait a bit longer 'just in case'.  */
+
+#define PCI_BUS_RST_HOLD_TIME_MSEC 250
+	msleep (PCI_BUS_RST_HOLD_TIME_MSEC);
+	rtas_pci_slot_reset (dn, 0);
+
+	/* After a PCI slot has been reset, the PCI Express spec requires
+	 * a 1.5 second idle time for the bus to stabilize, before starting
+	 * up traffic. */
+#define PCI_BUS_SETTLE_TIME_MSEC 1800
+	msleep (PCI_BUS_SETTLE_TIME_MSEC);
+
+	/* Now double check with the firmware to make sure the device is
+	 * ready to be used; if not, wait for recovery. */
+	for (i=0; i<10; i++) {
+		rc = eeh_slot_availability (dn);
+		if (rc <= 0) break;
+
+		msleep (rc+100);
+	}
+}
+
+EXPORT_SYMBOL(rtas_set_slot_reset);
+
+void
+rtas_configure_bridge(struct device_node *dn)
+{
+	int token = rtas_token ("ibm,configure-bridge");
+	int rc;
+
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return;
+	rc = rtas_call(token,3,1, NULL,
+	               dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid));
+	if (rc) {
+		printk (KERN_WARNING "EEH: Unable to configure device bridge (%d) for %s\n",
+		        rc, dn->full_name);
+	}
+}
+
+EXPORT_SYMBOL(rtas_configure_bridge);
+
+/* ------------------------------------------------------- */
+/** Save and restore of PCI BARs
+ *
+ * Although firmware will set up BARs during boot, it doesn't
+ * set up device BAR's after a device reset, although it will,
+ * if requested, set up bridge configuration. Thus, we need to
+ * configure the PCI devices ourselves.  Config-space setup is
+ * stored in the PCI structures which are normally deleted during
+ * device removal.  Thus, the "save" routine references the
+ * structures so that they aren't deleted.
+ */
+
+/**
+ * __restore_bars - Restore the Base Address Registers
+ * Loads the PCI configuration space base address registers,
+ * the expansion ROM base address, the latency timer, and etc.
+ * from the saved values in the device node.
+ */
+static inline void __restore_bars (struct device_node *dn)
+{
+	int i;
+
+	if (NULL==dn->phb) return;
+	for (i=4; i<10; i++) {
+		rtas_write_config(dn, i*4, 4, dn->config_space[i]);
+	}
+
+	/* 12 == Expansion ROM Address */
+	rtas_write_config(dn, 12*4, 4, dn->config_space[12]);
+
+#define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
+#define SAVED_BYTE(OFF) (((u8 *)(dn->config_space))[BYTE_SWAP(OFF)])
+
+	rtas_write_config (dn, PCI_CACHE_LINE_SIZE, 1,
+	            SAVED_BYTE(PCI_CACHE_LINE_SIZE));
+
+	rtas_write_config (dn, PCI_LATENCY_TIMER, 1,
+	            SAVED_BYTE(PCI_LATENCY_TIMER));
+
+	/* max latency, min grant, interrupt pin and line */
+	rtas_write_config(dn, 15*4, 4, dn->config_space[15]);
+}
+
+/**
+ * eeh_restore_bars - restore the PCI config space info
+ */
+void eeh_restore_bars(struct device_node *dn)
+{
+	if (! dn->eeh_is_bridge)
+		__restore_bars (dn);
+
+	if (dn->child)
+		eeh_restore_bars (dn->child);
+}
+
+void eeh_pci_restore_bars(struct pci_dev *dev)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	eeh_restore_bars (dn);
+}
+
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
@@ -682,6 +892,8 @@ static void *early_enable_eeh(struct dev
 	int enable;
 
 	dn->eeh_mode = 0;
+	dn->eeh_check_count = 0;
+	dn->eeh_freeze_count = 0;
 
 	if (status && strcmp(status, "ok") != 0)
 		return NULL;	/* ignore devices with bad status */
@@ -743,7 +955,7 @@ static void *early_enable_eeh(struct dev
 		       dn->full_name);
 	}
 
-	return NULL; 
+	return NULL;
 }
 
 /*
@@ -828,7 +1040,9 @@ void eeh_add_device_early(struct device_
 		return;
 	phb = dn->phb;
 	if (NULL == phb || 0 == phb->buid) {
-		printk(KERN_WARNING "EEH: Expected buid but found none\n");
+		printk(KERN_WARNING "EEH: Expected buid but found none for %s\n",
+		        dn->full_name);
+		dump_stack();
 		return;
 	}
 
@@ -847,6 +1061,9 @@ EXPORT_SYMBOL(eeh_add_device_early);
  */
 void eeh_add_device_late(struct pci_dev *dev)
 {
+	int i;
+	struct device_node *dn;
+
 	if (!dev || !eeh_subsystem_enabled)
 		return;
 
@@ -856,6 +1073,14 @@ void eeh_add_device_late(struct pci_dev 
 #endif
 
 	pci_addr_cache_insert_device (dev);
+
+	/* Save the BAR's; firmware doesn't restore these after EEH reset */
+	dn = pci_device_to_OF_node(dev);
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(dev, i * 4, &dn->config_space[i]);
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		dn->eeh_is_bridge = 1;
 }
 EXPORT_SYMBOL(eeh_add_device_late);
 
@@ -885,12 +1110,17 @@ static int proc_eeh_show(struct seq_file
 	unsigned int cpu;
 	unsigned long ffs = 0, positives = 0, failures = 0;
 	unsigned long resets = 0;
+	unsigned long no_dev = 0, no_dn = 0, no_cfg = 0, no_check = 0;
 
 	for_each_cpu(cpu) {
 		ffs += per_cpu(total_mmio_ffs, cpu);
 		positives += per_cpu(false_positives, cpu);
 		failures += per_cpu(ignored_failures, cpu);
 		resets += per_cpu(slot_resets, cpu);
+		no_dev += per_cpu(no_device, cpu);
+		no_dn += per_cpu(no_dn, cpu);
+		no_cfg += per_cpu(no_cfg_addr, cpu);
+		no_check += per_cpu(ignored_check, cpu);
 	}
 
 	if (0 == eeh_subsystem_enabled) {
@@ -898,13 +1128,17 @@ static int proc_eeh_show(struct seq_file
 		seq_printf(m, "eeh_total_mmio_ffs=%ld\n", ffs);
 	} else {
 		seq_printf(m, "EEH Subsystem is enabled\n");
-		seq_printf(m, "eeh_total_mmio_ffs=%ld\n"
+		seq_printf(m,
+				"no device=%ld\n"
+				"no device node=%ld\n"
+				"no config address=%ld\n"
+				"check not wanted=%ld\n"
+				"eeh_total_mmio_ffs=%ld\n"
 			   "eeh_false_positives=%ld\n"
 			   "eeh_ignored_failures=%ld\n"
-			   "eeh_slot_resets=%ld\n"
-				"eeh_fail_count=%d\n",
-			   ffs, positives, failures, resets,
-				eeh_fail_count.counter);
+			   "eeh_slot_resets=%ld\n",
+				no_dev, no_dn, no_cfg, no_check,
+			   ffs, positives, failures, resets);
 	}
 
 	return 0;
--- linux-2.6.12-git10/arch/ppc64/kernel/rtas_pci.c.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/arch/ppc64/kernel/rtas_pci.c	2005-06-22 15:28:29.000000000 -0500
@@ -58,7 +58,7 @@ static int config_access_valid(struct de
 	return 0;
 }
 
-static int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
+int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
 {
 	int returnval = -1;
 	unsigned long buid, addr;
@@ -108,7 +108,7 @@ static int rtas_pci_read_config(struct p
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
-static int rtas_write_config(struct device_node *dn, int where, int size, u32 val)
+int rtas_write_config(struct device_node *dn, int where, int size, u32 val)
 {
 	unsigned long buid, addr;
 	int ret;

--G4iJoqBmSsgzjUCe--
