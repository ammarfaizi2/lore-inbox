Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTDGXjO (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263917AbTDGXiC (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:38:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14224 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263745AbTDGXcA (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 19:32:00 -0400
Date: Tue, 8 Apr 2003 00:43:34 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH] [2/3] PCI sysfs improvements
Message-ID: <20030407234334.GS23430@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Note: This patch depends on the sysfs-bin patch]

Improve pci-sysfs:
 - Add PCI config space access to sysfs.
 - Prefix values in the PCI space with `0x' cos they're hex values.
 - Reformat the resource file with 64-bit values.
 - Present all resources in the file, don't stop at the first empty one.

Todo:
 - Implement write access.
 - Convert resource file into directories

diff -urpNX dontdiff linux-2.5.66/drivers/pci/pci-sysfs.c linux-2.5.66-laptop/drivers/pci/pci-sysfs.c
--- linux-2.5.66/drivers/pci/pci-sysfs.c	2003-02-24 13:05:33.000000000 -0600
+++ linux-2.5.66-laptop/drivers/pci/pci-sysfs.c	2003-04-07 14:33:12.000000000 -0500
@@ -18,12 +18,6 @@
 
 #include "pci.h"
 
-#if BITS_PER_LONG == 32
-#define LONG_FORMAT "\t%08lx"
-#else
-#define LONG_FORMAT "\t%16lx"
-#endif
-
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
@@ -36,11 +30,11 @@ show_##field (struct device *dev, char *
 }									\
 static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
 
-pci_config_attr(vendor, "%04x\n");
-pci_config_attr(device, "%04x\n");
-pci_config_attr(subsystem_vendor, "%04x\n");
-pci_config_attr(subsystem_device, "%04x\n");
-pci_config_attr(class, "%06x\n");
+pci_config_attr(vendor, "%#06x\n");
+pci_config_attr(device, "%#06x\n");
+pci_config_attr(subsystem_vendor, "%#06x\n");
+pci_config_attr(subsystem_device, "%#06x\n");
+pci_config_attr(class, "%#08x\n");
 pci_config_attr(irq, "%u\n");
 
 /* show resources */
@@ -50,9 +44,14 @@ pci_show_resources(struct device * dev, 
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	char * str = buf;
 	int i;
+	int max = 7;
+
+	if (pci_dev->subordinate)
+		max = DEVICE_COUNT_RESOURCE;
 
-	for (i = 0; i < DEVICE_COUNT_RESOURCE && pci_resource_start(pci_dev,i); i++) {
-		str += sprintf(str,LONG_FORMAT LONG_FORMAT LONG_FORMAT "\n",
+	for (i = 0; i < max; i++) {
+
+		str += sprintf(str,"\t%#018lx\t%#018lx\t%#018lx\n",
 			       pci_resource_start(pci_dev,i),
 			       pci_resource_end(pci_dev,i),
 			       pci_resource_flags(pci_dev,i));
@@ -62,6 +61,80 @@ pci_show_resources(struct device * dev, 
 
 static DEVICE_ATTR(resource,S_IRUGO,pci_show_resources,NULL);
 
+static ssize_t
+pci_read_config(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	unsigned int size = 64;
+
+	printk("data %p, offset %lld, count %zd\n", buf, off, count);
+	/* Several chips lock up trying to read undefined config space */
+	if (capable(CAP_SYS_ADMIN)) {
+		size = 256;
+	} else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
+		size = 128;
+	}
+
+	printk("size = %d", size);
+
+	if (off > size)
+		return 0;
+	if (off + count > size) {
+		size -= off;
+		count = size;
+	} else {
+		size = count;
+	}
+
+	printk("data %p, offset %lld, count %zd\n", buf, off, count);
+
+	while (off & 3) {
+		unsigned char val;
+		pci_read_config_byte(dev, off, &val);
+		buf[off] = val;
+		off++;
+		if (--size == 0)
+			break;
+	}
+
+	while (size > 3) {
+		unsigned int val;
+		pci_read_config_dword(dev, off, &val);
+		buf[off] = val & 0xff;
+		buf[off + 1] = (val >> 8) & 0xff;
+		buf[off + 2] = (val >> 16) & 0xff;
+		buf[off + 3] = (val >> 24) & 0xff;
+		off += 4;
+		size -= 4;
+	}
+
+	while (size > 0) {
+		unsigned char val;
+		pci_read_config_byte(dev, off, &val);
+		buf[off] = val;
+		off++;
+		--size;
+	}
+
+	return count;
+}
+
+static ssize_t
+pci_write_config(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	return 0;
+}
+
+static struct bin_attribute pci_config_attr = {
+	.attr =	{
+		.name = "config",
+		.mode = S_IRUGO | S_IWUSR,
+	},
+	.size = 256,
+	.read = pci_read_config,
+	.write = pci_write_config,
+};
+
 void pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -74,4 +147,5 @@ void pci_create_sysfs_dev_files (struct 
 	device_create_file (dev, &dev_attr_class);
 	device_create_file (dev, &dev_attr_irq);
 	device_create_file (dev, &dev_attr_resource);
+	sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
 }

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
