Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbVKDAvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbVKDAvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbVKDAvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:51:08 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:60051
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161026AbVKDAvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:51:04 -0500
Date: Thu, 3 Nov 2005 18:50:48 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 17/42]: ppc64: mark failed devices
Message-ID: <20051104005048.GA26970@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

17-eeh-slot-marking-bug.patch

A device that experiences a PCI outage may be just one deivce out 
of many that was affected. In order to avoid repeated reports of 
a failure, the entire tree of affected devices should be marked 
as failed. This patch marks up the entire tree.

Signed-off-by: Linas Vepstas <linas@linas.org>


Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:34:19.926132452 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:35:39.290005477 -0600
@@ -479,32 +479,47 @@
  *  an interrupt context, which is bad.
  */
 
-static inline void __eeh_mark_slot (struct device_node *dn)
+static inline void __eeh_mark_slot (struct device_node *dn, int mode_flag)
 {
 	while (dn) {
-		PCI_DN(dn)->eeh_mode |= EEH_MODE_ISOLATED;
+		if (PCI_DN(dn)) {
+			PCI_DN(dn)->eeh_mode |= mode_flag;
 
-		if (dn->child)
-			__eeh_mark_slot (dn->child);
+			if (dn->child)
+				__eeh_mark_slot (dn->child, mode_flag);
+		}
 		dn = dn->sibling;
 	}
 }
 
-static inline void __eeh_clear_slot (struct device_node *dn)
+void eeh_mark_slot (struct device_node *dn, int mode_flag)
+{
+	dn = find_device_pe (dn);
+	PCI_DN(dn)->eeh_mode |= mode_flag;
+	__eeh_mark_slot (dn->child, mode_flag);
+}
+
+static inline void __eeh_clear_slot (struct device_node *dn, int mode_flag)
 {
 	while (dn) {
-		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_ISOLATED;
-		if (dn->child)
-			__eeh_clear_slot (dn->child);
+		if (PCI_DN(dn)) {
+			PCI_DN(dn)->eeh_mode &= ~mode_flag;
+			PCI_DN(dn)->eeh_check_count = 0;
+			if (dn->child)
+				__eeh_clear_slot (dn->child, mode_flag);
+		}
 		dn = dn->sibling;
 	}
 }
 
-static inline void eeh_clear_slot (struct device_node *dn)
+void eeh_clear_slot (struct device_node *dn, int mode_flag)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&confirm_error_lock, flags);
-	__eeh_clear_slot (dn);
+	dn = find_device_pe (dn);
+	PCI_DN(dn)->eeh_mode &= ~mode_flag;
+	PCI_DN(dn)->eeh_check_count = 0;
+	__eeh_clear_slot (dn->child, mode_flag);
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 }
 
@@ -529,7 +544,6 @@
 	int rets[3];
 	unsigned long flags;
 	struct pci_dn *pdn;
-	struct device_node *pe_dn;
 	int rc = 0;
 
 	__get_cpu_var(total_mmio_ffs)++;
@@ -631,8 +645,7 @@
 	/* Avoid repeated reports of this failure, including problems
 	 * with other functions on this device, and functions under
 	 * bridges. */
-	pe_dn = find_device_pe (dn);
-	__eeh_mark_slot (pe_dn);
+	eeh_mark_slot (dn, EEH_MODE_ISOLATED);
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 
 	eeh_send_failure_event (dn, dev, rets[0], rets[2]);
@@ -744,9 +757,6 @@
 		        rc, state, pdn->node->full_name);
 		return;
 	}
-
-	if (state == 0)
-		eeh_clear_slot (pdn->node->parent->child);
 }
 
 /** rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
@@ -765,6 +775,12 @@
 
 #define PCI_BUS_RST_HOLD_TIME_MSEC 250
 	msleep (PCI_BUS_RST_HOLD_TIME_MSEC);
+	
+	/* We might get hit with another EEH freeze as soon as the 
+	 * pci slot reset line is dropped. Make sure we don't miss
+	 * these, and clear the flag now. */
+	eeh_clear_slot (pdn->node, EEH_MODE_ISOLATED);
+
 	rtas_pci_slot_reset (pdn, 0);
 
 	/* After a PCI slot has been reset, the PCI Express spec requires
Index: linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-powerpc/ppc-pci.h	2005-11-02 14:34:19.931131751 -0600
+++ linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h	2005-11-02 14:35:39.295004776 -0600
@@ -86,6 +86,13 @@
 
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 
+/**
+ * mark and clear slots: find "partition endpoint" PE and set or 
+ * clear the flags for each subnode of the PE.
+ */
+void eeh_mark_slot (struct device_node *dn, int mode_flag);
+void eeh_clear_slot (struct device_node *dn, int mode_flag);
+
 #endif
 
 #endif /* _ASM_POWERPC_PPC_PCI_H */
