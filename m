Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWIOX7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWIOX7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWIOX7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:59:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:6797 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932231AbWIOX7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:59:01 -0400
Date: Fri, 15 Sep 2006 18:58:59 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH 4/4]: PowerPC: EEH: support MMIO enable recovery step
Message-ID: <20060915235859.GU29167@austin.ibm.com>
References: <20060915235025.GQ29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915235025.GQ29167@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update to te PowerPC PCI error recovery code.

Add code to enable MMIO if a device driver reports 
that it is capable of recovering on its own. One
anticipated use of this having a device driver 
enable MMIO so that it can take a register dump, 
which might then be followed by the device driver 
requesting a full reset.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |   81 ++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 17 deletions(-)

Index: linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-09-14 15:17:15.000000000 -0500
+++ linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh_driver.c	2006-09-14 17:54:15.000000000 -0500
@@ -100,14 +100,38 @@ static void eeh_report_error(struct pci_
 		PCI_DN(dn)->eeh_mode |= EEH_MODE_IRQ_DISABLED;
 		disable_irq_nosync(dev->irq);
 	}
-	if (!driver->err_handler)
-		return;
-	if (!driver->err_handler->error_detected)
+	if (!driver->err_handler ||
+	    !driver->err_handler->error_detected)
 		return;
 
 	rc = driver->err_handler->error_detected (dev, pci_channel_io_frozen);
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
-	if (*res == PCI_ERS_RESULT_NEED_RESET) return;
+	if (*res == PCI_ERS_RESULT_DISCONNECT &&
+	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
+}
+
+/**
+ * eeh_report_mmio_enabled - tell drivers that MMIO has been enabled
+ *
+ * Report an EEH error to each device driver, collect up and
+ * merge the device driver responses. Cumulative response
+ * passed back in "userdata".
+ */
+
+static void eeh_report_mmio_enabled(struct pci_dev *dev, void *userdata)
+{
+	enum pci_ers_result rc, *res = userdata;
+	struct pci_driver *driver = dev->driver;
+
+	// dev->error_state = pci_channel_mmio_enabled;
+
+	if (!driver ||
+	    !driver->err_handler ||
+	    !driver->err_handler->mmio_enabled)
+		return;
+
+	rc = driver->err_handler->mmio_enabled (dev);
+	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
 	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 }
@@ -118,6 +142,7 @@ static void eeh_report_error(struct pci_
 
 static void eeh_report_reset(struct pci_dev *dev, void *userdata)
 {
+	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver = dev->driver;
 	struct device_node *dn = pci_device_to_OF_node(dev);
 
@@ -128,12 +153,14 @@ static void eeh_report_reset(struct pci_
 		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_IRQ_DISABLED;
 		enable_irq(dev->irq);
 	}
-	if (!driver->err_handler)
-		return;
-	if (!driver->err_handler->slot_reset)
+	if (!driver->err_handler ||
+	    !driver->err_handler->slot_reset)
 		return;
 
-	driver->err_handler->slot_reset(dev);
+	rc = driver->err_handler->slot_reset(dev);
+	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
+	if (*res == PCI_ERS_RESULT_DISCONNECT &&
+	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 }
 
 /**
@@ -362,23 +389,43 @@ struct pci_dn * handle_eeh_events (struc
 			goto hard_fail;
 	}
 
-	/* If any device called out for a reset, then reset the slot */
-	if (result == PCI_ERS_RESULT_NEED_RESET) {
-		rc = eeh_reset_device(frozen_pdn, NULL);
-		if (rc)
-			goto hard_fail;
-		pci_walk_bus(frozen_bus, eeh_report_reset, NULL);
+	/* If all devices reported they can proceed, then re-enable MMIO */
+	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
+		rc = rtas_pci_enable(frozen_pdn, EEH_THAW_MMIO);
+
+		if (rc) {
+			result = PCI_ERS_RESULT_NEED_RESET;
+		} else {
+			result = PCI_ERS_RESULT_NONE;
+			pci_walk_bus(frozen_bus, eeh_report_mmio_enabled, &result);
+		}
 	}
 
-	/* If all devices reported they can proceed, the re-enable PIO */
+	/* If all devices reported they can proceed, then re-enable DMA */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		/* XXX Not supported; we brute-force reset the device */
+		rc = rtas_pci_enable(frozen_pdn, EEH_THAW_DMA);
+
+		if (rc)
+			result = PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	/* If any device has a hard failure, then shut off everything. */
+	if (result == PCI_ERS_RESULT_DISCONNECT)
+		goto hard_fail;
+
+	/* If any device called out for a reset, then reset the slot */
+	if (result == PCI_ERS_RESULT_NEED_RESET) {
 		rc = eeh_reset_device(frozen_pdn, NULL);
 		if (rc)
 			goto hard_fail;
-		pci_walk_bus(frozen_bus, eeh_report_reset, NULL);
+		result = PCI_ERS_RESULT_NONE;
+		pci_walk_bus(frozen_bus, eeh_report_reset, &result);
 	}
 
+	/* All devices should claim they have recovered by now. */
+	if (result != PCI_ERS_RESULT_RECOVERED)
+		goto hard_fail;
+
 	/* Tell all device drivers that they can resume operations */
 	pci_walk_bus(frozen_bus, eeh_report_resume, NULL);
 
