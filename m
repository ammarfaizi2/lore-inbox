Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271362AbTGQJuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271363AbTGQJuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:50:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:33665 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S271362AbTGQJt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:49:59 -0400
Date: Thu, 17 Jul 2003 15:41:24 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI vendor and device strings in sysfs
Message-ID: <20030717101123.GA6069@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here is a patch against 2.6.0-test1 to display PCI vendor and
device strings in sysfs.

At present, the PCI "name" attribute has a length restriction
(DEVICE_NAME_SIZE) within which it tries to accomodate the vendor
and device strings, leading to, in most cases, truncation of one
or both strings.

This patch alleviates the issue by creating the vendor_name and
device_name attributes for PCI devices.

Here is an example:

ananth@llm06:/sys/devices/pci0000:00/0000:00:01.0> cat name
Intel Corp. 82810 DC-100 CGC [Ch
ananth@llm06:/sys/devices/pci0000:00/0000:00:01.0> cat vendor_name
Intel Corp.
ananth@llm06:/sys/devices/pci0000:00/0000:00:01.0> cat device_name
82810 DC-100 CGC [Chipset Graphics Controller]

Thanks,
-- 
Ananth Narayan <ananth@in.ibm.com>
Linux Technology Center,
IBM Software Lab, INDIA


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="km_pci.patch"

diff -Naur linux-2.6.0-test1/include/linux/pci.h linux-2.6.0-test1-fix/include/linux/pci.h
--- linux-2.6.0-test1/include/linux/pci.h	2003-07-14 09:04:02.000000000 +0530
+++ linux-2.6.0-test1-fix/include/linux/pci.h	2003-07-17 14:23:05.000000000 +0530
@@ -416,6 +416,10 @@
 
 	char *		slot_name;	/* pointer to dev.bus_id */
 
+	/* pointer to export vendor and device strings to sysfs */
+	char *		vendor_name;
+	char *		device_name;
+
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
 	unsigned int	multifunction:1;/* Part of multi-function device */

diff -Naur linux-2.6.0-test1/drivers/pci/names.c linux-2.6.0-test1-fix/drivers/pci/names.c
--- linux-2.6.0-test1/drivers/pci/names.c	2003-07-14 09:00:37.000000000 +0530
+++ linux-2.6.0-test1-fix/drivers/pci/names.c	2003-07-17 14:35:10.000000000 +0530
@@ -57,6 +57,8 @@
 	const struct pci_vendor_info *vendor_p = pci_vendor_list;
 	int i = VENDORS;
 	char *name = dev->dev.name;
+	char *vendor_unknown = "Unknown vendor";
+	char *device_unknown = "Unknown device";
 
 	do {
 		if (vendor_p->vendor == dev->vendor)
@@ -66,7 +68,15 @@
 
 	/* Couldn't find either the vendor nor the device */
 	sprintf(name, "PCI device %04x:%04x", dev->vendor, dev->device);
-	return;
+	dev->vendor_name = kmalloc(strlen(vendor_unknown)+1, GFP_KERNEL);
+	if (!dev->vendor_name)
+		goto out;
+	strcpy(dev->vendor_name, vendor_unknown);
+	dev->device_name = kmalloc(strlen(device_unknown)+1, GFP_KERNEL);
+	if (!dev->device_name)
+		goto out;
+	strcpy(dev->device_name, device_unknown);
+	goto out;
 
 	match_vendor: {
 		struct pci_device_info *device_p = vendor_p->devices;
@@ -82,19 +92,39 @@
 		/* Ok, found the vendor, but unknown device */
 		sprintf(name, "PCI device %04x:%04x (%." DEVICE_NAME_HALF "s)",
 				dev->vendor, dev->device, vendor_p->name);
-		return;
+		dev->vendor_name = kmalloc(strlen(vendor_p->name)+1, GFP_KERNEL);
+		if (!dev->vendor_name)
+			goto out;
+		strcpy(dev->vendor_name, vendor_p->name);
+		dev->device_name = kmalloc(strlen(device_unknown)+1, GFP_KERNEL);
+		if (!dev->device_name)
+			goto out;
+		strcpy(dev->device_name, device_unknown);
+		goto out;
 
 		/* Full match */
 		match_device: {
 			char *n = name + sprintf(name, "%." DEVICE_NAME_HALF
 					"s %." DEVICE_NAME_HALF "s",
 					vendor_p->name, device_p->name);
-			int nr = device_p->seen + 1;
-			device_p->seen = nr;
-			if (nr > 1)
-				sprintf(n, " (#%d)", nr);
+
+			dev->vendor_name = kmalloc(strlen(vendor_p->name)+1, GFP_KERNEL);
+			if (!dev->vendor_name)
+				goto update_count;
+			strcpy(dev->vendor_name, vendor_p->name);
+			dev->device_name = kmalloc(strlen(device_p->name)+1, GFP_KERNEL);
+			if (dev->device_name)
+				strcpy(dev->device_name, device_p->name);
+			update_count: {
+				int nr = device_p->seen + 1;
+				device_p->seen = nr;
+				if (nr > 1)
+					sprintf(n, " (#%d)", nr);
+			}
 		}
 	}
+out:
+	return;
 }
 
 /*

diff -Naur linux-2.6.0-test1/drivers/pci/pci-sysfs.c linux-2.6.0-test1-fix/drivers/pci/pci-sysfs.c
--- linux-2.6.0-test1/drivers/pci/pci-sysfs.c	2003-07-14 09:04:40.000000000 +0530
+++ linux-2.6.0-test1-fix/drivers/pci/pci-sysfs.c	2003-07-16 12:03:16.000000000 +0530
@@ -39,6 +39,42 @@
 pci_config_attr(class, "0x%06x\n");
 pci_config_attr(irq, "%u\n");
 
+/* show vendor name */
+static ssize_t
+pci_show_vendor_name(struct device *dev, char *buf)
+{
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	int len;
+	
+	if (!pci_dev->vendor_name)
+		return 0;
+	strcpy(buf, pci_dev->vendor_name);
+	len = strlen(pci_dev->vendor_name);
+	buf[len] = '\n';
+	buf[len+1] = 0;
+	return len+1;
+}
+
+static DEVICE_ATTR(vendor_name,S_IRUGO,pci_show_vendor_name,NULL);
+	
+/* show device name */
+static ssize_t
+pci_show_device_name(struct device *dev, char *buf)
+{
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	int len;
+	
+	if (!pci_dev->device_name)
+		return 0;
+	strcpy(buf, pci_dev->device_name);
+	len = strlen(pci_dev->device_name);
+	buf[len] = '\n';
+	buf[len+1] = 0;
+	return len+1;
+}
+
+static DEVICE_ATTR(device_name,S_IRUGO,pci_show_device_name,NULL);
+
 /* show resources */
 static ssize_t
 pci_show_resources(struct device * dev, char * buf)
@@ -176,5 +212,7 @@
 	device_create_file (dev, &dev_attr_class);
 	device_create_file (dev, &dev_attr_irq);
 	device_create_file (dev, &dev_attr_resource);
+	device_create_file (dev, &dev_attr_vendor_name);
+	device_create_file (dev, &dev_attr_device_name);
 	sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
 }

diff -Naur linux-2.6.0-test1/drivers/pci/probe.c linux-2.6.0-test1-fix/drivers/pci/probe.c
--- linux-2.6.0-test1/drivers/pci/probe.c	2003-07-14 09:06:33.000000000 +0530
+++ linux-2.6.0-test1-fix/drivers/pci/probe.c	2003-07-15 17:25:42.000000000 +0530
@@ -478,6 +478,8 @@
 	struct pci_dev *pci_dev;
 
 	pci_dev = to_pci_dev(dev);
+	kfree(pci_dev->vendor_name);
+	kfree(pci_dev->device_name);
 	kfree(pci_dev);
 }
 

--GvXjxJ+pjyke8COw--
