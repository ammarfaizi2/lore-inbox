Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVKPDXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVKPDXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbVKPDXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:23:17 -0500
Received: from peabody.ximian.com ([130.57.169.10]:8408 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965216AbVKPDW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:22:56 -0500
Subject: [RFC][PATCH 6/6] PCI PM: pci_save/restore_state improvements
From: Adam Belay <abelay@novell.com>
To: Linux-pm mailing list <linux-pm@lists.osdl.org>, Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 15 Nov 2005 22:31:42 -0500
Message-Id: <1132111902.9809.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some improvements to pci_save_state and
pci_restore_state.  Instead of saving and restoring all standard
registers (even read-only ones), it only restores necessary registers.
Also, the command register is handled more carefully.  Let me know if
I'm missing anything important.


--- a/drivers/pci/pm.c	2005-11-13 20:32:24.000000000 -0500
+++ b/drivers/pci/pm.c	2005-11-13 20:29:32.000000000 -0500
@@ -53,10 +53,13 @@
  */
 int pci_save_state(struct pci_dev *dev)
 {
-	int i;
-	/* XXX: 100% dword access ok here? */
-	for (i = 0; i < 16; i++)
-		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
+	struct pci_dev_config * conf = &dev->saved_config;
+
+	pci_read_config_word(dev, PCI_COMMAND, &conf->command);
+	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &conf->cacheline_size);
+	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &conf->latency_timer);
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &conf->interrupt_line);
+
 	return 0;
 }
 
@@ -68,10 +71,20 @@
  */
 int pci_restore_state(struct pci_dev *dev)
 {
-	int i;
+	u16 command;
+	struct pci_dev_config * conf = &dev->saved_config;
+
+	command = conf->command & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+				    PCI_COMMAND_MASTER);
+
+	pci_write_config_word(dev, PCI_COMMAND, command);
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, conf->cacheline_size);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, conf->latency_timer);
+	pci_write_config_byte(dev, PCI_INTERRUPT_PIN, conf->interrupt_line);
+	
+	pci_restore_bars(dev);
+	
 
-	for (i = 0; i < 16; i++)
-		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
 	return 0;
 }
 
--- a/include/linux/pci.h	2005-11-08 17:10:22.000000000 -0500
+++ b/include/linux/pci.h	2005-11-13 20:21:20.000000000 -0500
@@ -68,6 +68,13 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
+struct pci_dev_config {
+	unsigned short	command;
+	unsigned char	cacheline_size;
+	unsigned char	latency_timer;
+	unsigned char	interrupt_line;
+};
+
 struct pci_dev_pm {
 	unsigned int	pm_offset;	/* the PCI PM capability offset */
 
@@ -152,7 +159,7 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 
-	u32		saved_config_space[16]; /* config space saved at suspend time */
+	struct pci_dev_config saved_config; /* config space saved for power management */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */


