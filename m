Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWDRMty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWDRMty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWDRMty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:49:54 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:6160 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751048AbWDRMtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:49:53 -0400
Date: Tue, 18 Apr 2006 14:49:56 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] PCI: Error handling on PCI device resume
Message-Id: <20060418144956.7643e844.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We currently don't handle errors properly when resuming a PCI device:
* In pci_default_resume() we capture the error code returned by
  pci_enable_device() but don't pass it up to the caller.
  Introduced by commit 95a629657dbe28e44a312c47815b3dc3f1ce0970
* In pci_resume_device(), the errors possibly returned by the driver's
  .resume method or by the generic pci_default_resume() function are
  ignored.

This patch fixes both issues.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/pci/pci-driver.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- linux-2.6.17-rc1.orig/drivers/pci/pci-driver.c	2006-04-16 09:29:58.000000000 +0200
+++ linux-2.6.17-rc1/drivers/pci/pci-driver.c	2006-04-18 08:45:32.000000000 +0200
@@ -285,9 +285,9 @@
  * Default resume method for devices that have no driver provided resume,
  * or not even a driver at all.
  */
-static void pci_default_resume(struct pci_dev *pci_dev)
+static int pci_default_resume(struct pci_dev *pci_dev)
 {
-	int retval;
+	int retval = 0;
 
 	/* restore the PCI config space */
 	pci_restore_state(pci_dev);
@@ -297,18 +297,21 @@
 	/* if the device was busmaster before the suspend, make it busmaster again */
 	if (pci_dev->is_busmaster)
 		pci_set_master(pci_dev);
+
+	return retval;
 }
 
 static int pci_device_resume(struct device * dev)
 {
+	int error;
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
 	if (drv && drv->resume)
-		drv->resume(pci_dev);
+		error = drv->resume(pci_dev);
 	else
-		pci_default_resume(pci_dev);
-	return 0;
+		error = pci_default_resume(pci_dev);
+	return error;
 }
 
 static void pci_device_shutdown(struct device *dev)


-- 
Jean Delvare
