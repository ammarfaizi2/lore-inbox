Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUGGUZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUGGUZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUGGUZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:25:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12967 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265410AbUGGUYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:24:53 -0400
Date: Wed, 7 Jul 2004 15:24:12 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: [PATCH] 2.6 PPC64: EEH notifier call chain
Message-ID: <20040707152412.F21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Pjk796cY0SfIo9Z2"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pjk796cY0SfIo9Z2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Paul, 

Please review and forward upstream as appropriate.  

This patch implements a notifier call chain for EEH, as per pervious emails.
When an EEH slot freeze is detected, it is placed on a workqueue, from
whence it is dispatched to any regiistered notify callbacks.   The goal 
of the qorkqueue is to pull the slot-freeze detection out of an interrupt 
context.    As before, this patch only handles events for ethernet controllers;
I'll try to broaden the scope in future revisions.

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas

p.s. this patch to be followed shortly by a correpsonding patch to
the pci hotplug routines to actually catch and deal with events.

--Pjk796cY0SfIo9Z2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eeh-notifier-ppc64.patch"

===== arch/ppc64/kernel/eeh.c 1.24 vs edited =====
--- 1.24/arch/ppc64/kernel/eeh.c	Wed Jul  7 11:06:54 2004
+++ edited/arch/ppc64/kernel/eeh.c	Wed Jul  7 14:12:50 2004
@@ -17,28 +17,68 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/bootmem.h>
 #include <linux/init.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
-#include <linux/bootmem.h>
-#include <linux/mm.h>
 #include <linux/rbtree.h>
-#include <linux/spinlock.h>
 #include <linux/seq_file.h>
-#include <asm/paca.h>
-#include <asm/processor.h>
-#include <asm/naca.h>
+#include <linux/spinlock.h>
+#include <asm/eeh.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/pgtable.h>
 #include "pci.h"
 
 #undef DEBUG
 
+/** Overview:
+ *  EEH, or "Extended Error Handling" is a PCI bridge technology for 
+ *  dealing with PCI bus errors that can't be dealt with within the 
+ *  usual PCI framework, except by check-stopping the CPU.  Systems
+ *  that are designed for high-availability/reliability cannot afford
+ *  to crash due to a "mere" PCI error, thus the need for EEH. 
+ *  An EEH-capable bridge operates by converting a detected error
+ *  into a "slot freeze", taking the PCI adapter off-line, making 
+ *  the slot behave, from the OS'es point of view, as if the slot 
+ *  were "empty": all reads return 0xff's and all writes are silently 
+ *  ignored.  EEH slot isolation events can be triggered by parity
+ *  errors on the address or data busses (e.g. during posted writes),
+ *  which in turn might be caused by dust, vibration, humidity,
+ *  radioactivity or plain-old failed hardware.  
+ *
+ *  Note, however, that one of the leading causes of EEH slot
+ *  freeze events are buggy device drivers, buggy device microcode,
+ *  or buggy device hardware.  This is because any attempt by the
+ *  device to bus-master data to a memory address that is not 
+ *  assigned to the device will trigger a slot freeze.   (The idea
+ *  is to prevent devices-gone-wild from corrupting system memory). 
+ *  Buggy hardware/drivers will have a miserable time co-existing 
+ *  with EEH.
+ *  
+ *  Ideally, a PCI device driver, when suspecting that an isolation 
+ *  event has occured (e.g. by reading 0xff's), will then ask EEH
+ *  whether this is the case, and then take appropriate steps to 
+ *  reset the PCI slot, the PCI device, and then resume operations.
+ *  However, until that day,  the checking is done here, with the
+ *  eeh_check_failure() routine embedded in the MMIO macros.  If 
+ *  the slot is found to be isolated, an "EEH Event" is synthesized 
+ *  and sent out for processing.
+ */
+
+/** Bus Unit ID macros; get low and hi 32-bits of the 64-bit BUID */
 #define BUID_HI(buid) ((buid) >> 32)
 #define BUID_LO(buid) ((buid) & 0xffffffff)
-#define CONFIG_ADDR(busno, devfn) \
-		(((((busno) & 0xff) << 8) | ((devfn) & 0xf8)) << 8)
+
+/* EEH event workqueue setup. */
+static spinlock_t eeh_eventlist_lock = SPIN_LOCK_UNLOCKED;
+LIST_HEAD(eeh_eventlist);
+static void eeh_event_handler(void *);
+DECLARE_WORK(eeh_event_wq, eeh_event_handler, NULL);
+
+static struct notifier_block *eeh_notifier_chain;
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -60,6 +100,7 @@
 static DEFINE_PER_CPU(unsigned long, total_mmio_ffs);
 static DEFINE_PER_CPU(unsigned long, false_positives);
 static DEFINE_PER_CPU(unsigned long, ignored_failures);
+static DEFINE_PER_CPU(unsigned long, slot_resets);
 
 static int eeh_check_opts_config(struct device_node *dn, int class_code,
 				 int vendor_id, int device_id,
@@ -70,7 +111,8 @@
  * PCI device address resources into a red-black tree, sorted
  * according to the address range, so that given only an i/o
  * address, the corresponding PCI device can be **quickly**
- * found.
+ * found. It is safe to perform an address lookup in an interrupt 
+ * context; this ability is an important feature.
  *
  * Currently, the only customer of this code is the EEH subsystem;
  * thus, this code has been somewhat tailored to suit EEH better.
@@ -326,6 +368,103 @@
 #endif
 }
 
+/* --------------------------------------------------------------- */
+/* Above lies the PCI Address Cache. Below lies the EEH event infrastructure */
+
+/**
+ * eeh_register_notifier - Register to find out about EEH events.
+ * @nb: notifier block to callback on events
+ */
+int eeh_register_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_register(&eeh_notifier_chain, nb);
+}
+
+/**
+ * eeh_unregister_notifier - Unregister to an EEH event notifier.
+ * @nb: notifier block to callback on events
+ */
+int eeh_unregister_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&eeh_notifier_chain, nb);
+}
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
+	 * XXX We should create a seperate sysctl for this.
+	 *
+	 * Since the panic_on_oops sysctl is used to halt the system
+	 * in light of potential corruption, we can use it here.
+	 */
+	if (panic_on_oops)
+		panic("EEH: MMIO failure (%d) on device:%s %s\n", reset_state,
+		      pci_name(dev), pci_pretty_name(dev));
+	else {
+		__get_cpu_var(ignored_failures)++;
+		printk(KERN_INFO "EEH: Ignored MMIO failure (%d) on device:%s %s\n",
+		       reset_state, pci_name(dev), pci_pretty_name(dev));
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
+static void eeh_event_handler(void *dummy)
+{
+	unsigned long flags;
+	struct eeh_event	*event;
+
+	while (1) {
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
+		/* We can only recover ethernet adapters at this time. */
+		if (eeh_notifier_chain && 
+		    strcmp(event->dn->name, "ethernet") == 0) {
+			printk(KERN_INFO "EEH: MMIO failure (%d), notifiying device "
+				"%s %s\n", event->reset_state,
+				pci_name(event->dev), pci_pretty_name(event->dev));
+
+			notifier_call_chain (&eeh_notifier_chain, 
+			                     EEH_NOTIFY_FREEZE, event);
+
+			__get_cpu_var(slot_resets)++;
+
+		} else {
+			printk(KERN_ERR "EEH: MMIO failure (%d), recovery not supported "
+				"%s %s\n", event->reset_state,
+				pci_name(event->dev), pci_pretty_name(event->dev));
+			eeh_panic(event->dev, event->reset_state);
+		}
+
+		pci_dev_put(event->dev);
+		kfree(event);
+	}
+}
+
 /**
  * eeh_token_to_phys - convert EEH address token to phys address
  * @token i/o token, should be address in the form 0xA....
@@ -362,7 +501,7 @@
  * Probe to determine if an error actually occurred.  If not return val.
  * Otherwise panic.
  *
- * Note this routine might be called in an interrupt context ...
+ * Note this routine is safe to call in an interrupt context.
  */
 unsigned long eeh_check_failure(void *token, unsigned long val)
 {
@@ -371,7 +510,6 @@
 	struct device_node *dn;
 	int ret;
 	int rets[2];
-	unsigned long flags;
 
 	__get_cpu_var(total_mmio_ffs)++;
 
@@ -414,12 +552,14 @@
 			BUID_LO(dn->phb->buid));
 
 	if (ret == 0 && rets[1] == 1 && rets[0] >= 2) {
-		int log_event;
+		int reset_state = rets[0];
+		unsigned long flags;
+		int rc;
 
 		spin_lock_irqsave(&slot_errbuf_lock, flags);
 		memset(slot_errbuf, 0, eeh_error_buf_size);
 
-		log_event = rtas_call(ibm_slot_error_detail,
+		rc = rtas_call(ibm_slot_error_detail,
 		                      8, 1, NULL, dn->eeh_config_addr,
 		                      BUID_HI(dn->phb->buid),
 		                      BUID_LO(dn->phb->buid), NULL, 0,
@@ -427,26 +567,48 @@
 		                      eeh_error_buf_size,
 		                      2 /* Permanent Error */);
 
-		if (log_event == 0)
-			log_error(slot_errbuf, ERR_TYPE_RTAS_LOG,
-				  1 /* Fatal */);
-
+		if (rc == 0)
+			log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
 		spin_unlock_irqrestore(&slot_errbuf_lock, flags);
 
-		/*
-		 * XXX We should create a separate sysctl for this.
-		 *
-		 * Since the panic_on_oops sysctl is used to halt
-		 * the system in light of potential corruption, we
-		 * can use it here.
-		 */
-		if (panic_on_oops) {
-			panic("EEH: MMIO failure (%d) on device:%s %s\n",
-			      rets[0], pci_name(dev), pci_pretty_name(dev));
-		} else {
-			__get_cpu_var(ignored_failures)++;
-			printk(KERN_INFO "EEH: MMIO failure (%d) on device:%s %s\n",
-			       rets[0], pci_name(dev), pci_pretty_name(dev));
+		/* prevent repeated reports of this failure */
+		dn->eeh_mode |= EEH_MODE_NOCHECK;
+		
+		/* Some errors are recoverable; we handle those
+		 * asynchronously. */
+		if (strcmp(dn->name, "ethernet") == 0) {
+			struct eeh_event  *event;
+
+			event = kmalloc(sizeof(*event), GFP_ATOMIC);
+			if (event == NULL) {
+				eeh_panic(dev, reset_state);
+				pci_dev_put(dev);
+				return val;
+			}
+	
+			event->dev = dev;
+			event->dn = dn;
+			event->reset_state = reset_state;
+	
+			/* We may or may not be called in an interrupt context */
+			spin_lock_irqsave(&eeh_eventlist_lock, flags);
+			list_add(&event->list, &eeh_eventlist);
+			spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+	
+			/* Most EEH events are due to device driver bugs.  Having
+			 * a stack trace will help the device-driver authors figure
+			 * out what happened.  So print that out. */
+			dump_stack();
+			schedule_work(&eeh_event_wq);
+		}
+		else
+		{
+			/* For non-recoverable errors, we panic now.  This
+			 * prevents the device driver from getting tangled 
+			 * in its own shorts.  */
+			eeh_panic(dev, reset_state);
+			pci_dev_put(dev);
+			return val;
 		}
 	} else {
 		__get_cpu_var(false_positives)++;
@@ -733,11 +895,13 @@
 {
 	unsigned int cpu;
 	unsigned long ffs = 0, positives = 0, failures = 0;
+	unsigned long resets = 0;
 
 	for_each_cpu(cpu) {
 		ffs += per_cpu(total_mmio_ffs, cpu);
 		positives += per_cpu(false_positives, cpu);
 		failures += per_cpu(ignored_failures, cpu);
+		resets += per_cpu(slot_resets, cpu);
 	}
 
 	if (0 == eeh_subsystem_enabled) {
@@ -747,8 +911,9 @@
 		seq_printf(m, "EEH Subsystem is enabled\n");
 		seq_printf(m, "eeh_total_mmio_ffs=%ld\n"
 			   "eeh_false_positives=%ld\n"
-			   "eeh_ignored_failures=%ld\n",
-			   ffs, positives, failures);
+			   "eeh_ignored_failures=%ld\n"
+			   "eeh_slot_resets=%ld\n",
+			   ffs, positives, failures, resets);
 	}
 
 	return 0;
===== include/asm-ppc64/eeh.h 1.11 vs edited =====
--- 1.11/include/asm-ppc64/eeh.h	Sun Jun 20 20:15:35 2004
+++ edited/include/asm-ppc64/eeh.h	Wed Jul  7 13:20:46 2004
@@ -20,8 +20,9 @@
 #ifndef _PPC64_EEH_H
 #define _PPC64_EEH_H
 
-#include <linux/string.h>
 #include <linux/init.h>
+#include <linux/list.h>
+#include <linux/string.h>
 
 struct pci_dev;
 
@@ -74,7 +75,28 @@
 #define EEH_RELEASE_DMA		3
 int eeh_set_option(struct pci_dev *dev, int options);
 
-/*
+
+/**
+ * Notifier event flags.
+ */
+#define EEH_NOTIFY_FREEZE  1
+
+/** EEH event -- structure holding pci slot data that describes 
+ *  a change in the isolation status of a PCI slot.  A pointer
+ *  to this struct is passed as the data pointer in a notify callback.
+ */
+struct eeh_event {
+	struct list_head     list;
+	struct pci_dev       *dev;
+	struct device_node   *dn;
+	int                  reset_state;
+};
+
+/** Register to find out about EEH events. */
+int eeh_register_notifier(struct notifier_block *nb);
+int eeh_unregister_notifier(struct notifier_block *nb);
+
+/**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
  *
  * Order this macro for performance.

--Pjk796cY0SfIo9Z2--
