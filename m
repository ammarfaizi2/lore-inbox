Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVI3Avp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVI3Avp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVI3Avp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:51:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61322 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932514AbVI3Avn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:51:43 -0400
Date: Thu, 29 Sep 2005 19:51:41 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] ppc64: EEH typos, include files, macros, whitespace
Message-ID: <20050930005141.GA6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930004800.GL29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


01-eeh-minor-cleanup.patch

This patch performs some minor cleanup of the eeh.c file, including:
-- trim some trailing whitespace
-- remove extraneous #includes
-- use the macro PCI_DN uniformly, instead of the void pointer chase.
-- typos in comments
-- improved debug printk's

Signed-off-by: Linas Vepstas <linas@linas.org>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-09-29 11:03:52.084426836 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-09-29 13:09:10.306972480 -0500
@@ -1,32 +1,31 @@
 /*
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
 #include <linux/init.h>
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
@@ -49,8 +48,8 @@
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
@@ -256,18 +255,17 @@
 
 	dn = pci_device_to_OF_node(dev);
 	if (!dn) {
-		printk(KERN_WARNING "PCI: no pci dn found for dev=%s\n",
-			pci_name(dev));
+		printk(KERN_WARNING "PCI: no pci dn found for dev=%s\n", pci_name(dev));
 		return;
 	}
 
 	/* Skip any devices for which EEH is not enabled. */
-	pdn = dn->data;
+	pdn = PCI_DN(dn);
 	if (!(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
 #ifdef DEBUG
-		printk(KERN_INFO "PCI: skip building address cache for=%s\n",
-		       pci_name(dev));
+		printk(KERN_INFO "PCI: skip building address cache for=%s - %s\n",
+		       pci_name(dev), pdn->node->full_name);
 #endif
 		return;
 	}
@@ -410,16 +408,16 @@
  * @dn: device node to read
  * @rets: array to return results in
  */
-static int read_slot_reset_state(struct device_node *dn, int rets[])
+static int read_slot_reset_state(struct pci_dn *pdn, int rets[])
 {
 	int token, outputs;
-	struct pci_dn *pdn = dn->data;
 
 	if (ibm_read_slot_reset_state2 != RTAS_UNKNOWN_SERVICE) {
 		token = ibm_read_slot_reset_state2;
 		outputs = 4;
 	} else {
 		token = ibm_read_slot_reset_state;
+		rets[2] = 0; /* fake PE Unavailable info */
 		outputs = 3;
 	}
 
@@ -496,7 +494,7 @@
 
 /**
  * eeh_token_to_phys - convert EEH address token to phys address
- * @token i/o token, should be address in the form 0xE....
+ * @token i/o token, should be address in the form 0xA....
  */
 static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
@@ -522,7 +520,7 @@
  * will query firmware for the EEH status.
  *
  * Returns 0 if there has not been an EEH error; otherwise returns
- * a non-zero value and queues up a solt isolation event notification.
+ * a non-zero value and queues up a slot isolation event notification.
  *
  * It is safe to call this routine in an interrupt context.
  */
@@ -542,7 +540,7 @@
 
 	if (!dn)
 		return 0;
-	pdn = dn->data;
+	pdn = PCI_DN(dn);
 
 	/* Access to IO BARs might get this far and still not want checking. */
 	if (!pdn->eeh_capable || !(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
@@ -562,7 +560,7 @@
 		atomic_inc(&eeh_fail_count);
 		if (atomic_read(&eeh_fail_count) >= EEH_MAX_FAILS) {
 			/* re-read the slot reset state */
-			if (read_slot_reset_state(dn, rets) != 0)
+			if (read_slot_reset_state(pdn, rets) != 0)
 				rets[0] = -1;	/* reset state unknown */
 			eeh_panic(dev, rets[0]);
 		}
@@ -576,7 +574,7 @@
 	 * function zero of a multi-function device.
 	 * In any case they must share a common PHB.
 	 */
-	ret = read_slot_reset_state(dn, rets);
+	ret = read_slot_reset_state(pdn, rets);
 	if (!(ret == 0 && rets[1] == 1 && (rets[0] == 2 || rets[0] == 4))) {
 		__get_cpu_var(false_positives)++;
 		return 0;
@@ -635,7 +633,6 @@
  * @token i/o token, should be address in the form 0xA....
  * @val value, should be all 1's (XXX why do we need this arg??)
  *
- * Check for an eeh failure at the given token address.
  * Check for an EEH failure at the given token address.  Call this
  * routine if the result of a read was all 0xff's and you want to
  * find out if this is due to an EEH slot freeze event.  This routine
@@ -680,7 +677,7 @@
 	u32 *device_id = (u32 *)get_property(dn, "device-id", NULL);
 	u32 *regs;
 	int enable;
-	struct pci_dn *pdn = dn->data;
+	struct pci_dn *pdn = PCI_DN(dn);
 
 	pdn->eeh_mode = 0;
 
@@ -732,7 +729,7 @@
 
 			/* This device doesn't support EEH, but it may have an
 			 * EEH parent, in which case we mark it as supported. */
-			if (dn->parent && dn->parent->data
+			if (dn->parent && PCI_DN(dn->parent)
 			    && (PCI_DN(dn->parent)->eeh_mode & EEH_MODE_SUPPORTED)) {
 				/* Parent supports EEH. */
 				pdn->eeh_mode |= EEH_MODE_SUPPORTED;
@@ -745,7 +742,7 @@
 		       dn->full_name);
 	}
 
-	return NULL; 
+	return NULL;
 }
 
 /*
@@ -793,13 +790,11 @@
 	for (phb = of_find_node_by_name(NULL, "pci"); phb;
 	     phb = of_find_node_by_name(phb, "pci")) {
 		unsigned long buid;
-		struct pci_dn *pci;
 
 		buid = get_phb_buid(phb);
-		if (buid == 0 || phb->data == NULL)
+		if (buid == 0 || PCI_DN(phb) == NULL)
 			continue;
 
-		pci = phb->data;
 		info.buid_lo = BUID_LO(buid);
 		info.buid_hi = BUID_HI(buid);
 		traverse_pci_devices(phb, early_enable_eeh, &info);
@@ -828,11 +823,13 @@
 	struct pci_controller *phb;
 	struct eeh_early_enable_info info;
 
-	if (!dn || !dn->data)
+	if (!dn || !PCI_DN(dn))
 		return;
 	phb = PCI_DN(dn)->phb;
 	if (NULL == phb || 0 == phb->buid) {
-		printk(KERN_WARNING "EEH: Expected buid but found none\n");
+		printk(KERN_WARNING "EEH: Expected buid but found none for %s\n",
+		       dn->full_name);
+		dump_stack();
 		return;
 	}
 
