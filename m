Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbVKDAzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbVKDAzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbVKDAzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:55:16 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:34708
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161019AbVKDAyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:54:55 -0500
Date: Thu, 3 Nov 2005 18:54:54 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 38/42]: ppc64: Don't continue with PCI Error recovery if slot reset failed.
Message-ID: <20051104005454.GA27146@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

238-eeh-stop-if-reset_failed.patch

If the firmware is unable to reset the PCI slot for some reason, then 
don't attempt any further recovery steps after that point.  Instead,
mark the device as permanently failed.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:47:38.997080468 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:48:13.093298267 -0600
@@ -450,11 +450,16 @@
 	if (rc) return rc;
 
 	if (rets[1] == 0) return -1;  /* EEH is not supported */
-	if (rets[0] == 0)  return 0;  /* Oll Korrect */
+	if (rets[0] == 0) return 0;   /* Oll Korrect */
 	if (rets[0] == 5) {
 		if (rets[2] == 0) return -1; /* permanently unavailable */
 		return rets[2]; /* number of millisecs to wait */
 	}
+	if (rets[0] == 1)
+		return 250;
+
+	printk (KERN_ERR "EEH: Slot unavailable: rc=%d, rets=%d %d %d\n",
+		rc, rets[0], rets[1], rets[2]);
 	return -1;
 }
 
@@ -501,9 +506,11 @@
 
 /** rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
  *  dn -- device node to be reset.
+ *
+ *  Return 0 if success, else a non-zero value.
  */
 
-void
+int
 rtas_set_slot_reset(struct pci_dn *pdn)
 {
 	int i, rc;
@@ -533,10 +540,21 @@
 	 * ready to be used; if not, wait for recovery. */
 	for (i=0; i<10; i++) {
 		rc = eeh_slot_availability (pdn);
-		if (rc <= 0) break;
+		if (rc < 0)
+			printk (KERN_ERR "EEH: failed (%d) to reset slot %s\n", rc, pdn->node->full_name);
+		if (rc == 0)
+			return 0;
+		if (rc < 0)
+			return -1;
 
 		msleep (rc+100);
 	}
+
+	rc = eeh_slot_availability (pdn);
+	if (rc)
+		printk (KERN_ERR "EEH: timeout resetting slot %s\n", pdn->node->full_name);
+
+	return rc;
 }
 
 /* ------------------------------------------------------- */
Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2005-11-02 14:45:43.638259683 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_driver.c	2005-11-02 14:48:13.100297285 -0600
@@ -200,14 +200,18 @@
  *            bus resets can be performed.
  */
 
-static void eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
+static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 {
+	int rc;
 	if (bus)
 		pcibios_remove_pci_devices(bus);
 
 	/* Reset the pci controller. (Asserts RST#; resets config space).
-	 * Reconfigure bridges and devices */
-	rtas_set_slot_reset(pe_dn);
+	 * Reconfigure bridges and devices. Don't try to bring the system
+	 * up if the reset failed for some reason. */
+	rc = rtas_set_slot_reset(pe_dn);
+	if (rc)
+		return rc;
 
 	/* Walk over all functions on this device */
 	rtas_configure_bridge(pe_dn);
@@ -223,6 +227,8 @@
 		ssleep (5);
 		pcibios_add_pci_devices(bus);
 	}
+
+	return 0;
 }
 
 /* The longest amount of time to wait for a pci device
@@ -235,7 +241,7 @@
 	struct device_node *frozen_dn;
 	struct pci_dn *frozen_pdn;
 	struct pci_bus *frozen_bus;
-	int perm_failure = 0;
+	int rc = 0;
 
 	frozen_dn = find_device_pe(event->dn);
 	frozen_bus = pcibios_find_pci_bus(frozen_dn);
@@ -272,7 +278,7 @@
 	frozen_pdn->eeh_freeze_count++;
 	
 	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
-		perm_failure = 1;
+		goto hard_fail;
 
 	/* If the reset state is a '5' and the time to reset is 0 (infinity)
 	 * or is more then 15 seconds, then mark this as a permanent failure.
@@ -280,34 +286,7 @@
 	if ((event->state == pci_channel_io_perm_failure) &&
 	    ((event->time_unavail <= 0) ||
 	     (event->time_unavail > MAX_WAIT_FOR_RECOVERY*1000)))
-	{
-		perm_failure = 1;
-	}
-
-	/* Log the error with the rtas logger. */
-	if (perm_failure) {
-		/*
-		 * About 90% of all real-life EEH failures in the field
-		 * are due to poorly seated PCI cards. Only 10% or so are
-		 * due to actual, failed cards.
-		 */
-		printk(KERN_ERR
-		   "EEH: PCI device %s - %s has failed %d times \n"
-		   "and has been permanently disabled.  Please try reseating\n"
-		   "this device or replacing it.\n",
-			pci_name (frozen_pdn->pcidev), 
-			pcid_name(frozen_pdn->pcidev), 
-			frozen_pdn->eeh_freeze_count);
-
-		eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
-
-		/* Notify all devices that they're about to go down. */
-		pci_walk_bus(frozen_bus, eeh_report_failure, 0);
-
-		/* Shut down the device drivers for good. */
-		pcibios_remove_pci_devices(frozen_bus);
-		return;
-	}
+		goto hard_fail;
 
 	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
 	printk(KERN_WARNING
@@ -330,24 +309,54 @@
 	 * go down willingly, without panicing the system.
 	 */
 	if (result == PCIERR_RESULT_NONE) {
-		eeh_reset_device(frozen_pdn, frozen_bus);
+		rc = eeh_reset_device(frozen_pdn, frozen_bus);
+		if (rc)
+			goto hard_fail;
 	}
 
 	/* If any device called out for a reset, then reset the slot */
 	if (result == PCIERR_RESULT_NEED_RESET) {
-		eeh_reset_device(frozen_pdn, NULL);
+		rc = eeh_reset_device(frozen_pdn, NULL);
+		if (rc)
+			goto hard_fail;
 		pci_walk_bus(frozen_bus, eeh_report_reset, 0);
 	}
 
 	/* If all devices reported they can proceed, the re-enable PIO */
 	if (result == PCIERR_RESULT_CAN_RECOVER) {
 		/* XXX Not supported; we brute-force reset the device */
-		eeh_reset_device(frozen_pdn, NULL);
+		rc = eeh_reset_device(frozen_pdn, NULL);
+		if (rc)
+			goto hard_fail;
 		pci_walk_bus(frozen_bus, eeh_report_reset, 0);
 	}
 
 	/* Tell all device drivers that they can resume operations */
 	pci_walk_bus(frozen_bus, eeh_report_resume, 0);
+
+	return;
+	
+hard_fail:
+	/*
+	 * About 90% of all real-life EEH failures in the field
+	 * are due to poorly seated PCI cards. Only 10% or so are
+	 * due to actual, failed cards.
+	 */
+	printk(KERN_ERR
+	   "EEH: PCI device %s - %s has failed %d times \n"
+	   "and has been permanently disabled.  Please try reseating\n"
+	   "this device or replacing it.\n",
+		pci_name (frozen_pdn->pcidev), 
+		pcid_name(frozen_pdn->pcidev), 
+		frozen_pdn->eeh_freeze_count);
+
+	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
+
+	/* Notify all devices that they're about to go down. */
+	pci_walk_bus(frozen_bus, eeh_report_failure, 0);
+
+	/* Shut down the device drivers for good. */
+	pcibios_remove_pci_devices(frozen_bus);
 }
 
 /* ---------- end of file ---------- */
Index: linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-powerpc/ppc-pci.h	2005-11-02 14:45:43.656257159 -0600
+++ linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h	2005-11-02 14:48:13.104296724 -0600
@@ -77,8 +77,10 @@
  * does this by asserting the PCI #RST line for 1/8th of
  * a second; this routine will sleep while the adapter is
  * being reset.
+ *
+ * Returns a non-zero value if the reset failed.
  */
-void rtas_set_slot_reset (struct pci_dn *);
+int rtas_set_slot_reset (struct pci_dn *);
 
 /** 
  * eeh_restore_bars - Restore device configuration info.
