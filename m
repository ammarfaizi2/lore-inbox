Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWJ0VMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWJ0VMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWJ0VMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:12:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:11731 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751488AbWJ0VMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:12:51 -0400
Date: Fri, 27 Oct 2006 16:12:28 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Subject: [PATCH] powerpc: EEH recovery tweaks
Message-ID: <20061027211227.GJ6360@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

Please apply and forward upstream. This patch is not urgent,
it provides fixes for a code path that is not currently used
by any existing driver.

--linas

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

Index: linux-2.6.19-rc1-git11/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-10-26 16:21:06.000000000 -0500
+++ linux-2.6.19-rc1-git11/arch/powerpc/platforms/pseries/eeh_driver.c	2006-10-26 16:33:19.000000000 -0500
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
