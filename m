Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270710AbUJULvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270710AbUJULvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 07:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270692AbUJULu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 07:50:26 -0400
Received: from ozlabs.org ([203.10.76.45]:5853 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268982AbUJULrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 07:47:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16759.40343.865153.297604@cargo.ozlabs.ibm.com>
Date: Thu, 21 Oct 2004 21:29:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org,
       linas@linas.org
Subject: [PATCH] PPC64 Provide notifier list for EEH slot isolations
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the EEH (enhanced i/o error handling) hardware on pSeries detects
various kinds of PCI errors, it immediately freezes and isolates the
slot of the offending PCI card.  We get to know about that by noticing
that reads from the device return all-1s, and then we have to do a
firmware call to find out whether the all-1s value was due to a slot
isolation.

This patch adds a notifier so that other parts of the system (e.g. the
RPA PCI hotplug driver) can know that a slot isolation event has
occurred and take whatever recovery action is appropriate.  The
notifier is called in a workqueue function, although the read from the
device that noticed the all-1s value may have been at interrupt
level.  As a precaution, if we keep trying to read from the device at
interrupt level, and do 1000 reads without the workqueue getting a
chance to run, we panic, on the grounds that we presumably have a
badly-written driver which will spin forever in its interrupt routine,
e.g. waiting for a bit in a device register to go to 0.

This patch is based on an earlier patch by Linas Vepstas
<linas@linas.org>.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/eeh.c test/arch/ppc64/kernel/eeh.c
--- linux-2.5/arch/ppc64/kernel/eeh.c	2004-10-17 09:39:44.000000000 +1000
+++ test/arch/ppc64/kernel/eeh.c	2004-10-20 22:31:47.000000000 +1000
@@ -17,29 +17,79 @@
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
 #include <asm/rtas.h>
+#include <asm/atomic.h>
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
+
+/*
+ * If a device driver keeps reading an MMIO register in an interrupt
+ * handler after a slot isolation event has occurred, we assume it
+ * is broken and panic.  This sets the threshold for how many read
+ * attempts we allow before panicking.
+ */
+#define EEH_MAX_FAILS	1000
+static atomic_t eeh_fail_count;
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -58,13 +108,15 @@
 static DEFINE_PER_CPU(unsigned long, total_mmio_ffs);
 static DEFINE_PER_CPU(unsigned long, false_positives);
 static DEFINE_PER_CPU(unsigned long, ignored_failures);
+static DEFINE_PER_CPU(unsigned long, slot_resets);
 
 /**
  * The pci address cache subsystem.  This subsystem places
  * PCI device address resources into a red-black tree, sorted
  * according to the address range, so that given only an i/o
  * address, the corresponding PCI device can be **quickly**
- * found.
+ * found. It is safe to perform an address lookup in an interrupt
+ * context; this ability is an important feature.
  *
  * Currently, the only customer of this code is the EEH subsystem;
  * thus, this code has been somewhat tailored to suit EEH better.
@@ -333,6 +385,94 @@
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
+	 * XXX We should create a separate sysctl for this.
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
+		printk(KERN_INFO "EEH: MMIO failure (%d), notifiying device "
+		       "%s %s\n", event->reset_state,
+		       pci_name(event->dev), pci_pretty_name(event->dev));
+
+		atomic_set(&eeh_fail_count, 0);
+		notifier_call_chain (&eeh_notifier_chain,
+				     EEH_NOTIFY_FREEZE, event);
+
+		__get_cpu_var(slot_resets)++;
+
+		pci_dev_put(event->dev);
+		kfree(event);
+	}
+}
+
 /**
  * eeh_token_to_phys - convert EEH address token to phys address
  * @token i/o token, should be address in the form 0xE....
@@ -357,11 +497,11 @@
  *
  * Check for an EEH failure for the given device node.  Call this
  * routine if the result of a read was all 0xff's and you want to
- * find out if this is due to an EEH slot freeze event.  This routine
+ * find out if this is due to an EEH slot freeze.  This routine
  * will query firmware for the EEH status.
  *
  * Returns 0 if there has not been an EEH error; otherwise returns
- * an error code.
+ * a non-zero value and queues up a solt isolation event notification.
  *
  * It is safe to call this routine in an interrupt context.
  */
@@ -370,6 +510,8 @@
 	int ret;
 	int rets[2];
 	unsigned long flags;
+	int rc, reset_state;
+	struct eeh_event  *event;
 
 	__get_cpu_var(total_mmio_ffs)++;
 
@@ -388,6 +530,24 @@
 	if (!dn->eeh_config_addr) {
 		return 0;
 	}
+	
+	/*
+	 * If we already have a pending isolation event for this
+	 * slot, we know it's bad already, we don't need to check...
+	 */
+	if (dn->eeh_mode & EEH_MODE_ISOLATED) {
+		atomic_inc(&eeh_fail_count);
+		if (atomic_read(&eeh_fail_count) >= EEH_MAX_FAILS) {
+			/* re-read the slot reset state */
+			rets[0] = -1;
+			rtas_call(ibm_read_slot_reset_state, 3, 3, rets,
+				  dn->eeh_config_addr,
+				  BUID_HI(dn->phb->buid),
+				  BUID_LO(dn->phb->buid));
+			eeh_panic(dev, rets[0]);
+		}
+		return 0;
+	}
 
 	/*
 	 * Now test for an EEH failure.  This is VERY expensive.
@@ -400,47 +560,54 @@
 			dn->eeh_config_addr, BUID_HI(dn->phb->buid),
 			BUID_LO(dn->phb->buid));
 
-	if (ret == 0 && rets[1] == 1 && (rets[0] == 2 || rets[0] == 4)) {
-		int log_event;
-
-		spin_lock_irqsave(&slot_errbuf_lock, flags);
-		memset(slot_errbuf, 0, eeh_error_buf_size);
-
-		log_event = rtas_call(ibm_slot_error_detail,
-		                      8, 1, NULL, dn->eeh_config_addr,
-		                      BUID_HI(dn->phb->buid),
-		                      BUID_LO(dn->phb->buid), NULL, 0,
-		                      virt_to_phys(slot_errbuf),
-		                      eeh_error_buf_size,
-		                      1 /* Temporary Error */);
-
-		if (log_event == 0)
-			log_error(slot_errbuf, ERR_TYPE_RTAS_LOG,
-				  1 /* Fatal */);
-
-		spin_unlock_irqrestore(&slot_errbuf_lock, flags);
-
-		printk(KERN_INFO "EEH: MMIO failure (%d) on device: %s %s\n",
-		       rets[0], dn->name, dn->full_name);
-		WARN_ON(1);
-
-		/*
-		 * XXX We should create a separate sysctl for this.
-		 *
-		 * Since the panic_on_oops sysctl is used to halt
-		 * the system in light of potential corruption, we
-		 * can use it here.
-		 */
-		if (panic_on_oops) {
-			panic("EEH: MMIO failure (%d) on device: %s %s\n",
-			      rets[0], dn->name, dn->full_name);
-		} else {
-			__get_cpu_var(ignored_failures)++;
-		}
-	} else {
+	if (!(ret == 0 && rets[1] == 1 && (rets[0] == 2 || rets[0] == 4))) {
 		__get_cpu_var(false_positives)++;
+		return 0;
 	}
 
+	/* prevent repeated reports of this failure */
+	dn->eeh_mode |= EEH_MODE_ISOLATED;
+
+	reset_state = rets[0];
+	
+	spin_lock_irqsave(&slot_errbuf_lock, flags);
+	memset(slot_errbuf, 0, eeh_error_buf_size);
+
+	rc = rtas_call(ibm_slot_error_detail,
+	               8, 1, NULL, dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid), NULL, 0,
+	               virt_to_phys(slot_errbuf),
+	               eeh_error_buf_size,
+	               1 /* Temporary Error */);
+
+	if (rc == 0)
+		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
+	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
+
+	printk(KERN_INFO "EEH: MMIO failure (%d) on device: %s %s\n",
+	       rets[0], dn->name, dn->full_name);
+	event = kmalloc(sizeof(*event), GFP_ATOMIC);
+	if (event == NULL) {
+		eeh_panic(dev, reset_state);
+		return 1;
+ 	}
+
+	event->dev = dev;
+	event->dn = dn;
+	event->reset_state = reset_state;
+
+	/* We may or may not be called in an interrupt context */
+	spin_lock_irqsave(&eeh_eventlist_lock, flags);
+	list_add(&event->list, &eeh_eventlist);
+	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+
+	/* Most EEH events are due to device driver bugs.  Having
+	 * a stack trace will help the device-driver authors figure
+	 * out what happened.  So print that out. */
+	dump_stack();
+	schedule_work(&eeh_event_wq);
+
 	return 0;
 }
 
@@ -701,11 +868,13 @@
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
@@ -715,8 +884,11 @@
 		seq_printf(m, "EEH Subsystem is enabled\n");
 		seq_printf(m, "eeh_total_mmio_ffs=%ld\n"
 			   "eeh_false_positives=%ld\n"
-			   "eeh_ignored_failures=%ld\n",
-			   ffs, positives, failures);
+			   "eeh_ignored_failures=%ld\n"
+			   "eeh_slot_resets=%ld\n"
+				"eeh_fail_count=%d\n",
+			   ffs, positives, failures, resets,
+				eeh_fail_count.counter);
 	}
 
 	return 0;
diff -urN linux-2.5/include/asm-ppc64/eeh.h test/include/asm-ppc64/eeh.h
--- linux-2.5/include/asm-ppc64/eeh.h	2004-10-20 08:16:49.000000000 +1000
+++ test/include/asm-ppc64/eeh.h	2004-10-20 22:30:09.000000000 +1000
@@ -20,8 +20,10 @@
 #ifndef _PPC64_EEH_H
 #define _PPC64_EEH_H
 
-#include <linux/string.h>
 #include <linux/init.h>
+#include <linux/list.h>
+#include <linux/string.h>
+#include <linux/notifier.h>
 
 struct pci_dev;
 struct device_node;
@@ -29,6 +31,7 @@
 /* Values for eeh_mode bits in device_node */
 #define EEH_MODE_SUPPORTED	(1<<0)
 #define EEH_MODE_NOCHECK	(1<<1)
+#define EEH_MODE_ISOLATED	(1<<2)
 
 #ifdef CONFIG_PPC_PSERIES
 extern void __init eeh_init(void);
@@ -68,7 +71,28 @@
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
  * If this macro yields TRUE, the caller relays to eeh_check_failure()
