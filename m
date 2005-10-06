Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVJFX2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVJFX2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVJFX2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:28:34 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:24217 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932066AbVJFX2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:28:33 -0400
Date: Thu, 6 Oct 2005 18:28:31 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 4/22] ppc64: EEH Recovery support routines
Message-ID: <20051006232831.GE29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


04-eeh-recovery-support-routines.patch

EEH Recovery support routines

This patch adds routines required to help drive the recovery of
EEH-frozen slots.  The main function is to drive the PCI #RST
signal line high for a qurter of a second, and then allow for 
a second & a half of settle time.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pci.h	2005-10-06 17:50:31.847694674 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.h	2005-10-06 17:51:58.844488173 -0500
@@ -51,4 +51,18 @@
 extern unsigned long pci_assign_all_buses;
 extern int pci_read_irq_line(struct pci_dev *pci_dev);
 
+/* ---- EEH internal-use-only related routines ---- */
+#ifdef CONFIG_EEH
+/**
+ * rtas_set_slot_reset -- unfreeze a frozen slot
+ *
+ * Clear the EEH-frozen condition on a slot.  This routine
+ * does this by asserting the PCI #RST line for 1/8th of
+ * a second; this routine will sleep while the adapter is
+ * being reset.
+ */
+void rtas_set_slot_reset (struct pci_dn *);
+
+#endif
+
 #endif /* __PPC_KERNEL_PCI_H__ */
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-10-06 17:50:31.847694674 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-10-06 17:52:27.908410223 -0500
@@ -17,6 +17,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/pci.h>
@@ -678,6 +679,104 @@
 EXPORT_SYMBOL(eeh_check_failure);
 
 /* ------------------------------------------------------------- */
+/* The code below deals with error recovery */
+
+/** Return negative value if a permanent error, else return
+ * a number of milliseconds to wait until the PCI slot is
+ * ready to be used.
+ */
+static int
+eeh_slot_availability(struct pci_dn *pdn)
+{
+	int rc;
+	int rets[3];
+
+	rc = read_slot_reset_state(pdn, rets);
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
+/** rtas_pci_slot_reset raises/lowers the pci #RST line
+ *  state: 1/0 to raise/lower the #RST
+ *
+ * Clear the EEH-frozen condition on a slot.  This routine
+ * asserts the PCI #RST line if the 'state' argument is '1',
+ * and drops the #RST line if 'state is '0'.  This routine is
+ * safe to call in an interrupt context.
+ *
+ */
+
+static void
+rtas_pci_slot_reset(struct pci_dn *pdn, int state)
+{
+	int rc;
+
+	BUG_ON (pdn==NULL); 
+
+	if (!pdn->phb) {
+		printk (KERN_WARNING "EEH: in slot reset, device node %s has no phb\n",
+		        pdn->node->full_name);
+		return;
+	}
+
+	rc = rtas_call(ibm_set_slot_reset,4,1, NULL,
+	               pdn->eeh_config_addr,
+	               BUID_HI(pdn->phb->buid),
+	               BUID_LO(pdn->phb->buid),
+	               state);
+	if (rc) {
+		printk (KERN_WARNING "EEH: Unable to reset the failed slot, (%d) #RST=%d dn=%s\n", 
+		        rc, state, pdn->node->full_name);
+		return;
+	}
+
+	if (state == 0)
+		eeh_clear_slot (pdn->node->parent->child);
+}
+
+/** rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
+ *  dn -- device node to be reset.
+ */
+
+void
+rtas_set_slot_reset(struct pci_dn *pdn)
+{
+	int i, rc;
+
+	rtas_pci_slot_reset (pdn, 1);
+
+	/* The PCI bus requires that the reset be held high for at least
+	 * a 100 milliseconds. We wait a bit longer 'just in case'.  */
+
+#define PCI_BUS_RST_HOLD_TIME_MSEC 250
+	msleep (PCI_BUS_RST_HOLD_TIME_MSEC);
+	rtas_pci_slot_reset (pdn, 0);
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
+		rc = eeh_slot_availability (pdn);
+		if (rc <= 0) break;
+
+		msleep (rc+100);
+	}
+}
+
+/* ------------------------------------------------------------- */
 /* The code below deals with enabling EEH for devices during  the
  * early boot sequence.  EEH must be enabled before any PCI probing
  * can be done.
