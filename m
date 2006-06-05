Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750775AbWFEIh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWFEIh6 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWFEIha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:37:30 -0400
Received: from peabody.ximian.com ([130.57.169.10]:31374 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750786AbWFEIhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:37:07 -0400
Subject: [PATCH 9/9] PCI PM: generic suspend/resume fixes
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:46:18 -0400
Message-Id: <1149497178.7831.163.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers never call pci_enable_device() or pci_enable_master() and
instead assume the bios will have initialized the device.  As a
workaround, this patch modifies the generic resume function to verify
which device features need to be enabled by checking the previous state
of the COMMAND register.  Also, pci_disable_device() is now called
during generic suspend.

Signed-off-by: Adam Belay <abelay@novell.com>

---
 pci-driver.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff -urN a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2006-05-30 21:41:14.000000000 -0400
+++ b/drivers/pci/pci-driver.c	2006-06-05 00:29:24.000000000 -0400
@@ -265,6 +265,16 @@
 	return 0;
 }
 
+/*
+ * Default suspend method for devices that have no driver provided suspend,
+ * or not even a driver at all.
+ */
+static void pci_default_suspend(struct pci_dev *pci_dev)
+{
+	pci_save_state(pci_dev);
+	pci_disable_device(pci_dev);
+}
+
 static int pci_device_suspend(struct device * dev, pm_message_t state)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
@@ -274,13 +284,11 @@
 	if (drv && drv->suspend) {
 		i = drv->suspend(pci_dev, state);
 		suspend_report_result(drv->suspend, i);
-	} else {
-		pci_save_state(pci_dev);
-	}
+	} else
+		pci_default_suspend(pci_dev);
 	return i;
 }
 
-
 /*
  * Default resume method for devices that have no driver provided resume,
  * or not even a driver at all.
@@ -288,14 +296,15 @@
 static void pci_default_resume(struct pci_dev *pci_dev)
 {
 	int retval;
+	u16 cmd = pci_dev->saved_config.command;
 
 	/* restore the PCI config space */
 	pci_restore_state(pci_dev);
 	/* if the device was enabled before suspend, reenable */
-	if (pci_dev->is_enabled)
+	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
 		retval = pci_enable_device(pci_dev);
 	/* if the device was busmaster before the suspend, make it busmaster again */
-	if (pci_dev->is_busmaster)
+	if (cmd & PCI_COMMAND_MASTER)
 		pci_set_master(pci_dev);
 }
 


