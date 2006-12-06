Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937065AbWLFScY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937065AbWLFScY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937069AbWLFScX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:32:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45793 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937065AbWLFScX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:32:23 -0500
Date: Wed, 6 Dec 2006 12:32:20 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: EEH recovery tweaks (resend)
Message-ID: <20061206183220.GB17931@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

Please apply and forward upstream. 
(Resend of patch from 27 October 2006.)

--linas

Subject: [PATCH] powerpc: EEH recovery tweaks

If one attempts to create a device driver recovery sequence that
does not depend on a hard reset of the device, but simply just
attempts to resume processing, then one discovers that the 
recovery sequence implemented on powerpc is not quite right.
This patch fixes this up.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c        |    1 +
 arch/powerpc/platforms/pseries/eeh_driver.c |   13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.19-git7.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-11-29 15:57:37.000000000 -0600
+++ linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh_driver.c	2006-12-06 11:56:21.000000000 -0600
@@ -170,14 +170,19 @@ static void eeh_report_reset(struct pci_
 static void eeh_report_resume(struct pci_dev *dev, void *userdata)
 {
 	struct pci_driver *driver = dev->driver;
+	struct device_node *dn = pci_device_to_OF_node(dev);
 
 	dev->error_state = pci_channel_io_normal;
 
 	if (!driver)
 		return;
-	if (!driver->err_handler)
-		return;
-	if (!driver->err_handler->resume)
+
+	if ((PCI_DN(dn)->eeh_mode) & EEH_MODE_IRQ_DISABLED) {
+		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_IRQ_DISABLED;
+		enable_irq(dev->irq);
+	}
+	if (!driver->err_handler ||
+	    !driver->err_handler->resume)
 		return;
 
 	driver->err_handler->resume(dev);
@@ -407,6 +412,8 @@ struct pci_dn * handle_eeh_events (struc
 
 		if (rc)
 			result = PCI_ERS_RESULT_NEED_RESET;
+		else
+			result = PCI_ERS_RESULT_RECOVERED;
 	}
 
 	/* If any device has a hard failure, then shut off everything. */
Index: linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.19-git7.orig/arch/powerpc/platforms/pseries/eeh.c	2006-11-29 15:57:37.000000000 -0600
+++ linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh.c	2006-12-06 11:56:21.000000000 -0600
@@ -337,6 +337,7 @@ int eeh_dn_check_failure(struct device_n
 			printk (KERN_ERR "EEH: Device driver ignored %d bad reads, panicing\n",
 			        pdn->eeh_check_count);
 			dump_stack();
+			msleep(5000);
 			
 			/* re-read the slot reset state */
 			if (read_slot_reset_state(pdn, rets) != 0)
