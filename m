Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUE1Vul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUE1Vul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUE1Vll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:41:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:38067 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263972AbUE1ViG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:38:06 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1085780115273@kroah.com>
Date: Fri, 28 May 2004 14:35:16 -0700
Message-Id: <10857801154003@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.26, 2004/05/26 15:37:25-07:00, arjanv@redhat.com

[PATCH] PCI: restore pci config space on resume

The patch below enhances the PCI layer with 2 things
1) enable and busmaster state are stored in the pci device struct
2) pci config space is stored to the pci device struct

with that, it is possible to make a generic pci resume method that restores
config space and reenables the device, including busmaster when appropriate.

One can rightfully argue that the driver resume method should do this, and
yes that is right. So the patch only does it for devices that don't have a
resume method. Like the main PCI bridge on my testbox of which the bios so
nicely forgets to restore the bus master bit during resume.. With this patch
my testbox resumes just fine while it, well, wasn't all too happy as you can
imagine without a busmaster pci bridge.


 drivers/pci/pci-driver.c |   26 ++++++++++++++++++++++++--
 drivers/pci/pci.c        |    5 +++++
 include/linux/pci.h      |    5 +++++
 3 files changed, 34 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Fri May 28 14:29:10 2004
+++ b/drivers/pci/pci-driver.c	Fri May 28 14:29:10 2004
@@ -299,10 +299,30 @@
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
+	int i = 0;
 
 	if (drv && drv->suspend)
-		return drv->suspend(pci_dev,state);
-	return 0;
+		i = drv->suspend(pci_dev,state);
+		
+	pci_save_state(pci_dev, pci_dev->saved_config_space);
+	return i;
+}
+
+
+/* 
+ * Default resume method for devices that have no driver provided resume,
+ * or not even a driver at all.
+ */
+static void pci_default_resume(struct pci_dev *pci_dev)
+{
+	/* restore the PCI config space */
+	pci_restore_state(pci_dev, pci_dev->saved_config_space);
+	/* if the device was enabled before suspend, reenable */
+	if (pci_dev->is_enabled)
+		pci_enable_device(pci_dev);
+	/* if the device was busmaster before the suspend, make it busmaster again */
+	if (pci_dev->is_busmaster)
+		pci_set_master(pci_dev);
 }
 
 static int pci_device_resume(struct device * dev)
@@ -312,6 +332,8 @@
 
 	if (drv && drv->resume)
 		drv->resume(pci_dev);
+	else
+		pci_default_resume(pci_dev);
 	return 0;
 }
 
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Fri May 28 14:29:10 2004
+++ b/drivers/pci/pci.c	Fri May 28 14:29:10 2004
@@ -385,6 +385,7 @@
 int
 pci_enable_device(struct pci_dev *dev)
 {
+	dev->is_enabled = 1;
 	return pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
 }
 
@@ -399,6 +400,9 @@
 pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
+	
+	dev->is_enabled = 0;
+	dev->is_busmaster = 0;
 
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
@@ -601,6 +605,7 @@
 		cmd |= PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
+	dev->is_busmaster = 1;
 	pcibios_set_master(dev);
 }
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Fri May 28 14:29:10 2004
+++ b/include/linux/pci.h	Fri May 28 14:29:10 2004
@@ -488,6 +488,11 @@
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
 	unsigned int	multifunction:1;/* Part of multi-function device */
+	/* keep track of device state */
+	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
+	unsigned int	is_busmaster:1; /* device is busmaster */
+	
+	unsigned int 	saved_config_space[16]; /* config space saved at suspend time */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */

