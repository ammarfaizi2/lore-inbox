Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVAFUbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVAFUbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVAFU3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:29:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:3779 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263008AbVAFUQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:16:30 -0500
Date: Thu, 6 Jan 2005 13:24:13 -0600
To: paulus@samba.org, anton@samba.org, akpm@osdl.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: EEH Recovery
Message-ID: <20050106192413.GK22274@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Paul,

The patch below implements hotplug style EEH error recovery. 
Its split into two pieces: a part that needs to be applied to the
PPC64 arch tree, and a part that needs to be applied to the 
RPA PHP hotplug tree. The PPC64 part needs to go in first.

Assuming this doesn't generate a round of discussion, please
forward upstream to akpm/torvalds.

Signed-off-by: Linas Vepstas <linas@linas.org>



--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eeh-recovery-bk-ppc64-3.patch"

===== arch/ppc64/kernel/eeh.c 1.41 vs edited =====
--- 1.41/arch/ppc64/kernel/eeh.c	2005-01-06 13:05:42 -06:00
+++ edited/arch/ppc64/kernel/eeh.c	2005-01-06 13:08:03 -06:00
@@ -17,21 +17,19 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#include <linux/bootmem.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/list.h>
-#include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/rbtree.h>
 #include <linux/seq_file.h>
-#include <linux/spinlock.h>
+#include <asm/atomic.h>
 #include <asm/eeh.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/rtas.h>
-#include <asm/atomic.h>
 #include "pci.h"
 
 #undef DEBUG
@@ -89,7 +87,6 @@ static struct notifier_block *eeh_notifi
  * attempts we allow before panicking.
  */
 #define EEH_MAX_FAILS	1000
-static atomic_t eeh_fail_count;
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -106,6 +103,10 @@ static spinlock_t slot_errbuf_lock = SPI
 static int eeh_error_buf_size;
 
 /* System monitoring statistics */
+static DEFINE_PER_CPU(unsigned long, no_device);
+static DEFINE_PER_CPU(unsigned long, no_dn);
+static DEFINE_PER_CPU(unsigned long, no_cfg_addr);
+static DEFINE_PER_CPU(unsigned long, ignored_check);
 static DEFINE_PER_CPU(unsigned long, total_mmio_ffs);
 static DEFINE_PER_CPU(unsigned long, false_positives);
 static DEFINE_PER_CPU(unsigned long, ignored_failures);
@@ -224,9 +225,9 @@ pci_addr_cache_insert(struct pci_dev *de
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
@@ -244,6 +245,11 @@ pci_addr_cache_insert(struct pci_dev *de
 	piar->addr_hi = ahi;
 	piar->pcidev = dev;
 	piar->flags = flags;
+	
+#ifdef DEBUG 
+	printk (KERN_DEBUG "PIAR: insert range=[%lx:%lx] dev=%s\n", 
+	               alo, ahi, pci_name (dev));
+#endif
 
 	rb_link_node(&piar->rb_node, parent, p);
 	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
@@ -368,6 +374,7 @@ void pci_addr_cache_remove_device(struct
  */
 void __init pci_addr_cache_build(void)
 {
+	struct device_node *dn;
 	struct pci_dev *dev = NULL;
 
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
@@ -378,6 +385,14 @@ void __init pci_addr_cache_build(void)
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
+		}
 	}
 
 #ifdef DEBUG
@@ -389,6 +404,32 @@ void __init pci_addr_cache_build(void)
 /* --------------------------------------------------------------- */
 /* Above lies the PCI Address Cache. Below lies the EEH event infrastructure */
 
+void eeh_slot_error_detail (struct device_node *dn, int severity)
+{
+	unsigned long flags;
+	int rc;
+
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
+}
+
+EXPORT_SYMBOL(eeh_slot_error_detail);
+
 /**
  * eeh_register_notifier - Register to find out about EEH events.
  * @nb: notifier block to callback on events
@@ -484,11 +525,9 @@ static void eeh_event_handler(void *dumm
 		       "%s %s\n", event->reset_state,
 		       pci_name(event->dev), pci_pretty_name(event->dev));
 
-		atomic_set(&eeh_fail_count, 0);
-		notifier_call_chain (&eeh_notifier_chain,
-				     EEH_NOTIFY_FREEZE, event);
-
 		__get_cpu_var(slot_resets)++;
+		notifier_call_chain (&eeh_notifier_chain,
+		           EEH_NOTIFY_FREEZE, event);
 
 		pci_dev_put(event->dev);
 		kfree(event);
@@ -496,8 +535,8 @@ static void eeh_event_handler(void *dumm
 }
 
 /**
- * eeh_token_to_phys - convert EEH address token to phys address
- * @token i/o token, should be address in the form 0xE....
+ * eeh_token_to_phys - convert I/O address to phys address
+ * @token i/o address, should be address in the form 0xA....
  */
 static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
@@ -512,6 +551,17 @@ static inline unsigned long eeh_token_to
 	return pa | (token & (PAGE_SIZE-1));
 }
 
+static inline struct pci_dev * eeh_get_pci_dev(struct device_node *dn)
+{
+	struct pci_dev *dev = NULL;
+
+	for_each_pci_dev(dev) {
+		if (pci_device_to_OF_node(dev) == dn)
+			return dev;
+	}
+	return NULL;
+}
+
 /**
  * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
  * @dn device node
@@ -532,7 +582,7 @@ int eeh_dn_check_failure(struct device_n
 	int ret;
 	int rets[3];
 	unsigned long flags;
-	int rc, reset_state;
+	int reset_state;
 	struct eeh_event  *event;
 
 	__get_cpu_var(total_mmio_ffs)++;
@@ -540,16 +590,20 @@ int eeh_dn_check_failure(struct device_n
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
 		return 0;
 	}
 
 	if (!dn->eeh_config_addr) {
+		__get_cpu_var(no_cfg_addr)++;
 		return 0;
 	}
 
@@ -558,8 +612,9 @@ int eeh_dn_check_failure(struct device_n
 	 * slot, we know it's bad already, we don't need to check...
 	 */
 	if (dn->eeh_mode & EEH_MODE_ISOLATED) {
-		atomic_inc(&eeh_fail_count);
-		if (atomic_read(&eeh_fail_count) >= EEH_MAX_FAILS) {
+		dn->eeh_freeze_count ++;
+		if (dn->eeh_freeze_count >= EEH_MAX_FAILS) {
+			dump_stack();
 			/* re-read the slot reset state */
 			if (read_slot_reset_state(dn, rets) != 0)
 				rets[0] = -1;	/* reset state unknown */
@@ -581,34 +636,25 @@ int eeh_dn_check_failure(struct device_n
 		return 0;
 	}
 
-	/* prevent repeated reports of this failure */
+	/* Prevent repeated reports of this failure */
 	dn->eeh_mode |= EEH_MODE_ISOLATED;
 
 	reset_state = rets[0];
+	/* Log the error with the rtas logger */
+	if (dn->eeh_freeze_count < EEH_MAX_ALLOWED_FREEZES) {
+		eeh_slot_error_detail (dn, 1 /* Temporary Error */);
+	} else {
+		eeh_slot_error_detail (dn, 2 /* Permanent Error */);
+   }
 
-	spin_lock_irqsave(&slot_errbuf_lock, flags);
-	memset(slot_errbuf, 0, eeh_error_buf_size);
-
-	rc = rtas_call(ibm_slot_error_detail,
-	               8, 1, NULL, dn->eeh_config_addr,
-	               BUID_HI(dn->phb->buid),
-	               BUID_LO(dn->phb->buid), NULL, 0,
-	               virt_to_phys(slot_errbuf),
-	               eeh_error_buf_size,
-	               1 /* Temporary Error */);
-
-	if (rc == 0)
-		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
-	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
-
-	printk(KERN_INFO "EEH: MMIO failure (%d) on device: %s %s\n",
-	       rets[0], dn->name, dn->full_name);
 	event = kmalloc(sizeof(*event), GFP_ATOMIC);
 	if (event == NULL) {
-		eeh_panic(dev, reset_state);
+		printk (KERN_ERR "EEH: out of memory, event not handled\n");
 		return 1;
  	}
 
+	if (!dev)
+		dev = eeh_get_pci_dev (dn);
 	event->dev = dev;
 	event->dn = dn;
 	event->reset_state = reset_state;
@@ -634,7 +680,6 @@ EXPORT_SYMBOL(eeh_dn_check_failure);
  * @token i/o token, should be address in the form 0xA....
  * @val value, should be all 1's (XXX why do we need this arg??)
  *
- * Check for an eeh failure at the given token address.
  * Check for an EEH failure at the given token address.  Call this
  * routine if the result of a read was all 0xff's and you want to
  * find out if this is due to an EEH slot freeze event.  This routine
@@ -642,6 +687,7 @@ EXPORT_SYMBOL(eeh_dn_check_failure);
  *
  * Note this routine is safe to call in an interrupt context.
  */
+
 unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val)
 {
 	unsigned long addr;
@@ -651,8 +697,10 @@ unsigned long eeh_check_failure(const vo
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
@@ -663,6 +711,172 @@ unsigned long eeh_check_failure(const vo
 
 EXPORT_SYMBOL(eeh_check_failure);
 
+/* ------------------------------------------------------------- */
+/* The code below deals with error recovery */
+
+void
+rtas_set_slot_reset(struct device_node *dn)
+{
+	int token = rtas_token ("ibm,set-slot-reset");
+	int rc;
+
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return;
+	rc = rtas_call(token,4,1, NULL,
+	               dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid),
+	               1);
+	if (rc) {
+		printk (KERN_WARNING "EEH: Unable to reset the failed slot\n");
+		return;
+	}
+	
+	/* The PCI bus requires that the reset be held high for at least
+	 * a 100 milliseconds. We wait a bit longer 'just in case'.
+	 */
+   msleep (200);
+	
+	rc = rtas_call(token,4,1, NULL,
+	               dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid),
+	               0);
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
+		printk (KERN_WARNING "EEH: Unable to configure device bridge\n");
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
+
+struct eeh_cfg_tree
+{
+	struct eeh_cfg_tree *sibling;
+	struct eeh_cfg_tree *child;
+	struct device_node *dn;
+	int is_bridge;
+};
+
+/** 
+ * eeh_save_bars - save the PCI config space info
+ */
+struct eeh_cfg_tree * eeh_save_bars(struct device_node *dn)
+{
+	struct pci_dev *dev;
+	struct eeh_cfg_tree *cnode;
+
+	dev = eeh_get_pci_dev(dn);
+	if (!dev)
+		return NULL;
+	
+	cnode = kmalloc(sizeof(struct eeh_cfg_tree), GFP_KERNEL);
+	if (!cnode) 
+		return NULL;
+	
+	cnode->is_bridge = 0;
+	
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) 
+		cnode->is_bridge = 1;
+			  
+	of_node_get(dn);
+	cnode->dn = dn;
+	
+	cnode->sibling = NULL;
+	cnode->child = NULL;
+
+	if (dn->child) {
+		cnode->child = eeh_save_bars (dn->child);
+	}
+	if (dn->sibling) {
+		cnode->sibling = eeh_save_bars (dn->sibling);
+	}
+
+	return cnode;
+}
+EXPORT_SYMBOL(eeh_save_bars);
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
+	for (i=4; i<10; i++) {
+		rtas_write_config(dn, i*4, 4, dn->config_space[i]);
+	}
+
+	/* 12 == Expansion ROM Address */
+	rtas_write_config(dn, 12*4, 4, dn->config_space[12]);
+	
+#define SAVED_BYTE(OFF) (((u8 *)(dn->config_space))[OFF])
+	
+	rtas_write_config (dn, PCI_CACHE_LINE_SIZE, 1, 
+	            SAVED_BYTE(PCI_CACHE_LINE_SIZE));
+	
+	rtas_write_config (dn, PCI_LATENCY_TIMER, 1, 
+	            SAVED_BYTE(PCI_LATENCY_TIMER));
+	
+	rtas_write_config (dn, PCI_INTERRUPT_LINE, 1, 
+	            SAVED_BYTE(PCI_INTERRUPT_LINE));
+}
+
+/** 
+ * eeh_restore_bars - restore the PCI config space info
+ */
+void eeh_restore_bars(struct eeh_cfg_tree *tree)
+{
+	if (!(tree->is_bridge))
+		__restore_bars (tree->dn);
+	
+	if (tree->child)
+		eeh_restore_bars (tree->child);
+
+	if (tree->sibling)
+		eeh_restore_bars (tree->sibling);
+
+	of_node_put (tree->dn);
+	kfree (tree);
+}
+EXPORT_SYMBOL(eeh_restore_bars);
+
+/* ------------------------------------------------------------- */
+/* The code below deals with enabling EEH for devices during  the
+ * early boot sequence.  EEH must be enabled before any PCI probing
+ * can be done.
+ */
+
 struct eeh_early_enable_info {
 	unsigned int buid_hi;
 	unsigned int buid_lo;
@@ -829,7 +1043,9 @@ void eeh_add_device_early(struct device_
 		return;
 	phb = dn->phb;
 	if (NULL == phb || 0 == phb->buid) {
-		printk(KERN_WARNING "EEH: Expected buid but found none\n");
+		printk(KERN_WARNING "EEH: Expected buid but found none for %s\n",
+		                dn->full_name);
+		dump_stack();
 		return;
 	}
 
@@ -848,6 +1064,9 @@ EXPORT_SYMBOL(eeh_add_device_early);
  */
 void eeh_add_device_late(struct pci_dev *dev)
 {
+	int i;
+	struct device_node *dn;
+
 	if (!dev || !eeh_subsystem_enabled)
 		return;
 
@@ -857,6 +1076,11 @@ void eeh_add_device_late(struct pci_dev 
 #endif
 
 	pci_addr_cache_insert_device (dev);
+
+	/* Save the BAR's; firmware doesn't restore these after EEH reset */
+	dn = pci_device_to_OF_node(dev);
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(dev, i * 4, &dn->config_space[i]);
 }
 EXPORT_SYMBOL(eeh_add_device_late);
 
@@ -886,12 +1110,17 @@ static int proc_eeh_show(struct seq_file
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
@@ -899,13 +1128,17 @@ static int proc_eeh_show(struct seq_file
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
===== arch/ppc64/kernel/pSeries_pci.c 1.59 vs edited =====
--- 1.59/arch/ppc64/kernel/pSeries_pci.c	2004-11-15 21:29:10 -06:00
+++ edited/arch/ppc64/kernel/pSeries_pci.c	2005-01-05 13:41:09 -06:00
@@ -102,7 +102,7 @@ static int rtas_pci_read_config(struct p
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
-static int rtas_write_config(struct device_node *dn, int where, int size, u32 val)
+int rtas_write_config(struct device_node *dn, int where, int size, u32 val)
 {
 	unsigned long buid, addr;
 	int ret;
===== include/asm-ppc64/eeh.h 1.23 vs edited =====
--- 1.23/include/asm-ppc64/eeh.h	2004-10-25 18:17:38 -05:00
+++ edited/include/asm-ppc64/eeh.h	2005-01-05 13:47:55 -06:00
@@ -22,8 +22,8 @@
 
 #include <linux/init.h>
 #include <linux/list.h>
-#include <linux/string.h>
 #include <linux/notifier.h>
+#include <linux/string.h>
 
 struct pci_dev;
 struct device_node;
@@ -33,6 +33,10 @@ struct device_node;
 #define EEH_MODE_NOCHECK	(1<<1)
 #define EEH_MODE_ISOLATED	(1<<2)
 
+/* Max number of EEH freezes allowed before we consider the device
+ * to be permanently disabled. */
+#define EEH_MAX_ALLOWED_FREEZES 5
+
 #ifdef CONFIG_PPC_PSERIES
 extern void __init eeh_init(void);
 unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned long val);
@@ -57,6 +61,34 @@ void eeh_add_device_early(struct device_
 void eeh_add_device_late(struct pci_dev *);
 
 /**
+ * eeh_slot_error_detail -- record and EEH error condition to the log
+ * @severity: 1 if temporary, 2 if permanent failure.
+ *
+ * Obtains the the EEH error details from the RTAS subsystem, 
+ * and then logs these details with the RTAS error log system.
+ */
+void eeh_slot_error_detail (struct device_node *dn, int severity);
+
+/** 
+ * rtas_set_slot_reset -- unfreeze a frozen slot
+ *
+ * Clear the EEH-frozen condition on a slot.  This routine
+ * does this by asserting the PCI #RST line for 1/8th of 
+ * a second; this routine will sleep while the adapter is 
+ * being reset.
+ */
+void rtas_set_slot_reset (struct device_node *dn);
+
+/**
+ * rtas_configure_bridge -- firmware initialization of pci bridge
+ * 
+ * Ask the firmware to configure any PCI bridge devices 
+ * located behind the indicated node. Required after a 
+ * pci device reset.
+ */
+void rtas_configure_bridge(struct device_node *dn);
+
+/**
  * eeh_remove_device - undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
  *
@@ -91,6 +123,13 @@ struct eeh_event {
 /** Register to find out about EEH events. */
 int eeh_register_notifier(struct notifier_block *nb);
 int eeh_unregister_notifier(struct notifier_block *nb);
+
+/** Save and restore device configuration info across
+ *  device resets.
+ */
+struct eeh_cfg_tree;
+struct eeh_cfg_tree * eeh_save_bars(struct device_node *dn);
+void eeh_restore_bars(struct eeh_cfg_tree *tree);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
===== include/asm-ppc64/prom.h 1.24 vs edited =====
--- 1.24/include/asm-ppc64/prom.h	2004-11-25 00:42:42 -06:00
+++ edited/include/asm-ppc64/prom.h	2005-01-05 13:41:09 -06:00
@@ -164,8 +164,10 @@ struct device_node {
 	int	status;			/* Current device status (non-zero is bad) */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
+	int	eeh_freeze_count;   /* number of times this device froze up. */
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
+	u32      config_space[16]; /* saved PCI config space */
 
 	struct	property *properties;
 	struct	device_node *parent;
===== include/asm-ppc64/rtas.h 1.25 vs edited =====
--- 1.25/include/asm-ppc64/rtas.h	2004-11-25 00:42:42 -06:00
+++ edited/include/asm-ppc64/rtas.h	2005-01-05 13:41:09 -06:00
@@ -241,4 +241,6 @@ extern void rtas_stop_self(void);
 /* RMO buffer reserved for user-space RTAS use */
 extern unsigned long rtas_rmo_buf;
 
+extern int rtas_write_config(struct device_node *dn, int where, int size, u32 val);
+
 #endif /* _PPC64_RTAS_H */

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eeh-recovery-bk-hotplug-3.patch"

===== drivers/pci/hotplug/rpaphp.h 1.11 vs edited =====
--- 1.11/drivers/pci/hotplug/rpaphp.h	2004-10-06 11:43:44 -05:00
+++ edited/drivers/pci/hotplug/rpaphp.h	2005-01-05 13:41:09 -06:00
@@ -126,6 +126,8 @@ extern int register_pci_slot(struct slot
 extern int rpaphp_unconfig_pci_adapter(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
 extern struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev);
+extern void init_eeh_handler (void);
+extern void exit_eeh_handler (void);
 
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
===== drivers/pci/hotplug/rpaphp_core.c 1.18 vs edited =====
--- 1.18/drivers/pci/hotplug/rpaphp_core.c	2004-10-06 11:43:44 -05:00
+++ edited/drivers/pci/hotplug/rpaphp_core.c	2005-01-05 13:41:09 -06:00
@@ -443,12 +443,18 @@ static int __init rpaphp_init(void)
 {
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
+	/* Get set to handle EEH events. */
+	init_eeh_handler();
+
 	/* read all the PRA info from the system */
 	return init_rpa();
 }
 
 static void __exit rpaphp_exit(void)
 {
+	/* Let EEH know we are going away. */
+	exit_eeh_handler();
+
 	cleanup_slots();
 }
 
===== drivers/pci/hotplug/rpaphp_pci.c 1.17 vs edited =====
--- 1.17/drivers/pci/hotplug/rpaphp_pci.c	2004-11-18 02:36:18 -06:00
+++ edited/drivers/pci/hotplug/rpaphp_pci.c	2005-01-05 15:30:29 -06:00
@@ -22,8 +22,12 @@
  * Send feedback to <lxie@us.ibm.com>
  *
  */
+#include <linux/delay.h>
+#include <linux/notifier.h>
 #include <linux/pci.h>
+#include <asm/eeh.h>
 #include <asm/pci-bridge.h>
+#include <asm/prom.h>
 #include <asm/rtas.h>
 #include "../pci.h"		/* for pci_add_new_bus */
 
@@ -62,6 +66,7 @@ int rpaphp_claim_resource(struct pci_dev
 		    root ? "Address space collision on" :
 		    "No parent found for",
 		    resource, dtype, pci_name(dev), res->start, res->end);
+		dump_stack();
 	}
 	return err;
 }
@@ -184,6 +189,19 @@ rpaphp_fixup_new_pci_devices(struct pci_
 
 static int rpaphp_pci_config_bridge(struct pci_dev *dev);
 
+static void rpaphp_eeh_add_bus_device(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		eeh_add_device_late(dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+			struct pci_bus *subbus = dev->subordinate;
+			if (bus)
+				rpaphp_eeh_add_bus_device (subbus);
+		}
+	}
+}
+
 /*****************************************************************************
  rpaphp_pci_config_slot() will  configure all devices under the 
  given slot->dn and return the the first pci_dev.
@@ -211,6 +229,8 @@ rpaphp_pci_config_slot(struct device_nod
 		}
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) 
 			rpaphp_pci_config_bridge(dev);
+
+		rpaphp_eeh_add_bus_device(bus);
 	}
 	return dev;
 }
@@ -219,7 +239,6 @@ static int rpaphp_pci_config_bridge(stru
 {
 	u8 sec_busno;
 	struct pci_bus *child_bus;
-	struct pci_dev *child_dev;
 
 	dbg("Enter %s:  BRIDGE dev=%s\n", __FUNCTION__, pci_name(dev));
 
@@ -236,11 +255,7 @@ static int rpaphp_pci_config_bridge(stru
 	/* do pci_scan_child_bus */
 	pci_scan_child_bus(child_bus);
 
-	list_for_each_entry(child_dev, &child_bus->devices, bus_list) {
-		eeh_add_device_late(child_dev);
-	}
-
-	 /* fixup new pci devices without touching bus struct */
+	/* Fixup new pci devices without touching bus struct */
 	rpaphp_fixup_new_pci_devices(child_bus, 0);
 
 	/* Make the discovered devices available */
@@ -278,7 +293,7 @@ static void print_slot_pci_funcs(struct 
 	return;
 }
 #else
-static void print_slot_pci_funcs(struct slot *slot)
+static inline void print_slot_pci_funcs(struct slot *slot)
 {
 	return;
 }
@@ -360,7 +375,6 @@ static void rpaphp_eeh_remove_bus_device
 			if (pdev)
 				rpaphp_eeh_remove_bus_device(pdev);
 		}
-
 	}
 	return;
 }
@@ -562,36 +576,154 @@ exit:
 	return retval;
 }
 
-struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev)
+/**
+ * rpaphp_find_slot - find and return the slot holding the device
+ * @dev: pci device for which we want the slot structure.
+ */
+static struct slot *rpaphp_find_slot(struct pci_dev *dev)
 {
-	struct list_head	*tmp, *n;
-	struct slot		*slot;
+	struct list_head *tmp, *n;
+	struct slot	*slot;
 
 	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
 		struct pci_bus *bus;
 		struct list_head *ln;
 
 		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
-		if (slot->bridge == NULL) {
-			if (slot->dev_type == PCI_DEV) {
-				printk(KERN_WARNING "PCI slot missing bridge %s %s \n", 
-				                    slot->name, slot->location);
-			}
+		
+		/* PHB slots don't have bridges */
+		if (slot->bridge == NULL)
 			continue;
-		}
+
+		/* the PCI device could be the PHB itself */
+		if (slot->bridge == dev)
+			return slot;
 
 		bus = slot->bridge->subordinate;
 		if (!bus) {
+			printk (KERN_WARNING "PCI bridge is missing bus: %s %s\n",
+			    pci_name (slot->bridge), pci_pretty_name (slot->bridge));
 			continue;  /* should never happen? */
 		}
+
 		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-                                struct pci_dev *pdev = pci_dev_b(ln);
-				if (pdev == dev)
-					return slot->hotplug_slot;
+			struct pci_dev *pdev = pci_dev_b(ln);
+			if (pdev == dev)
+				return slot;
 		}
 	}
 
 	return NULL;
 }
 
-EXPORT_SYMBOL_GPL(rpaphp_find_hotplug_slot);
+/* ------------------------------------------------------- */
+/**
+ * handle_eeh_events -- reset a PCI device after hard lockup.
+ *
+ * pSeries systems will isolate a PCI slot if the PCI-Host
+ * bridge detects address or data parity errors, DMA's 
+ * occuring to wild addresses (which usually happen due to
+ * bugs in device drivers or in PCI adapter firmware).
+ * Slot isolations also occur if #SERR, #PERR or other misc
+ * PCI-related errors are detected.
+ * 
+ * Recovery process consists of unplugging the device driver
+ * (which generated hotplug events to userspace), then issuing
+ * a PCI #RST to the device, then reconfiguring the PCI config 
+ * space for all bridges & devices under this slot, and then 
+ * finally restarting the device drivers (which cause a second
+ * set of hotplug events to go out to userspace).
+ */
+int handle_eeh_events (struct notifier_block *self, 
+                       unsigned long reason, void *ev)
+{
+	int freeze_count=0;
+	struct eeh_event *event = ev;
+	struct slot *frozen_slot;
+	struct eeh_cfg_tree * saved_bars;
+
+debug=1;
+	frozen_slot = rpaphp_find_slot(event->dev);
+	if (!frozen_slot)
+	{
+		printk (KERN_ERR 
+			"EEH: Cannot find PCI slot for EEH error! dev=%p dn=%p\n", 
+			event->dev, event->dn);
+		if (event->dev)
+			printk("EEH: above message for pci device %s %s\n", 
+				pci_name(event->dev), pci_pretty_name (event->dev));
+		if (event->dn)
+			printk ("EEH: above message for dn %s\n", event->dn->full_name);
+		return 1;
+	}
+
+	/* Keep a copy of the config space registers */
+	saved_bars = eeh_save_bars(frozen_slot->dn);
+	of_node_get(event->dn);
+	pci_dev_get(event->dev);
+
+	if (frozen_slot->dn->child)
+		freeze_count = frozen_slot->dn->child->eeh_freeze_count;
+	rpaphp_unconfig_pci_adapter (frozen_slot);
+
+	freeze_count ++;
+	if (freeze_count > EEH_MAX_ALLOWED_FREEZES) {
+		/* 
+		 * About 90% of all real-life EEH failures in the field
+		 * are due to poorly seated PCI cards. Only 10% or so are
+		 * due to actual, failed cards 
+		 */
+		printk (KERN_ERR
+		   "EEH: device %s:%s has failed %d times \n"
+			"and has been permanently disabled.  Please try reseating\n"
+		   "this device or replacing it.\n",
+			pci_name (event->dev),
+			pci_pretty_name (event->dev),
+			freeze_count);
+		goto rdone;
+	}
+	printk (KERN_WARNING
+	   "EEH: This device has failed %d times since last reoobt: %s:%s\n",
+		freeze_count,
+		pci_name (event->dev),
+		pci_pretty_name (event->dev));
+
+	/* Reset the pci controller. (Asserts RST#; resets config space). 
+	 * Reconfigure bridges and devices */
+	rtas_set_slot_reset (event->dn);
+	rtas_configure_bridge(event->dn);
+	eeh_restore_bars(saved_bars);
+
+	/* Give the system 5 seconds to finish running the user-space
+	 * hotplug scripts, e.g. ifdown for ethernet.  Yes, this is a hack, 
+	 * but if we don't do this, weird things happen.
+	 */
+	ssleep (5);
+
+	rpaphp_enable_pci_slot (frozen_slot);
+
+	/* Store the freeze count with the pci adapter, and not the slot.
+	 * This way, if the device is replaced, the count is cleared.
+	 */
+	if (frozen_slot->dn->child)
+		frozen_slot->dn->child->eeh_freeze_count = freeze_count;
+
+rdone:
+	of_node_put(event->dn);
+	pci_dev_put(event->dev);
+	return 0;
+}
+
+static struct notifier_block eeh_block;
+
+void __init init_eeh_handler (void)
+{
+	eeh_block.notifier_call = handle_eeh_events;
+	eeh_register_notifier (&eeh_block);
+}
+
+void __exit exit_eeh_handler (void)
+{
+	eeh_unregister_notifier (&eeh_block);
+}
+

--Dxnq1zWXvFF0Q93v--
