Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWD2Iq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWD2Iq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 04:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWD2Iq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 04:46:57 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:15269 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751145AbWD2Iq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 04:46:57 -0400
Subject: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Arjan van de Ven <arjan@linux.intel.com>
To: greg@kroah.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 29 Apr 2006 10:46:24 +0200
Message-Id: <1146300385.3125.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an "enable" sysfs attribute to each PCI device. When read it
shows the "enabled-ness" of the device, but you can write a "0" into it to
disable a device, and a "1" to enable it.

This later is needed for X and other cases where userspace wants to enable
the BARs on a device (typical example: to run the video bios on a secundary
head). Right now X does all this "by hand" via bitbanging, that's just evil.
This allows X to no longer do that but to just let the kernel do this.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
CC: Peter Jones <pjones@redhat.com>
CC: Dave Airlie <airlied@linux.ie>
---
 drivers/pci/pci-sysfs.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: linux-2.6.17-rc2-enable/drivers/pci/pci-sysfs.c
===================================================================
--- linux-2.6.17-rc2-enable.orig/drivers/pci/pci-sysfs.c
+++ linux-2.6.17-rc2-enable/drivers/pci/pci-sysfs.c
@@ -43,6 +43,7 @@ pci_config_attr(subsystem_vendor, "0x%04
 pci_config_attr(subsystem_device, "0x%04x\n");
 pci_config_attr(class, "0x%06x\n");
 pci_config_attr(irq, "%u\n");
+pci_config_attr(is_enabled, "%u\n");
 
 static ssize_t local_cpus_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -90,6 +91,28 @@ static ssize_t modalias_show(struct devi
 		       (u8)(pci_dev->class >> 16), (u8)(pci_dev->class >> 8),
 		       (u8)(pci_dev->class));
 }
+static ssize_t
+is_enabled_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+        struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pdev)
+		return 1;
+
+	/* this can crash the machine when done on the "wrong" device */
+	if (!capable(CAP_SYS_ADMIN))
+		return 1;
+
+	if (*buf == '0')
+		pci_disable_device(pdev);
+
+	if (*buf == '1')
+		pci_enable_device(pdev);
+
+	return 1;
+}
+
 
 struct device_attribute pci_dev_attrs[] = {
 	__ATTR_RO(resource),
@@ -101,6 +124,7 @@ struct device_attribute pci_dev_attrs[] 
 	__ATTR_RO(irq),
 	__ATTR_RO(local_cpus),
 	__ATTR_RO(modalias),
+	__ATTR(enable, 0600, is_enabled_show, is_enabled_store),
 	__ATTR_NULL,
 };
 

