Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbTGDB4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265653AbTGDB4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:56:01 -0400
Received: from granite.he.net ([216.218.226.66]:24846 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265654AbTGDByw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:52 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1057284553312@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845532384@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1369, 2003/07/03 15:52:14-07:00, willy@debian.org

[PATCH] PCI config space in sysfs
 - Fix a couple of bugs in sysfs's handling of binary files (my fault).
 - Implement pci config space reads and writes in sysfs


 drivers/pci/pci-sysfs.c |  105 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/sysfs/bin.c          |   23 ++++------
 2 files changed, 114 insertions(+), 14 deletions(-)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	Thu Jul  3 18:16:32 2003
+++ b/drivers/pci/pci-sysfs.c	Thu Jul  3 18:16:32 2003
@@ -3,6 +3,8 @@
  *
  * (C) Copyright 2002 Greg Kroah-Hartman
  * (C) Copyright 2002 IBM Corp.
+ * (C) Copyright 2003 Matthew Wilcox
+ * (C) Copyright 2003 Hewlett-Packard
  *
  * File attributes for PCI devices
  *
@@ -60,6 +62,108 @@
 
 static DEVICE_ATTR(resource,S_IRUGO,pci_show_resources,NULL);
 
+static ssize_t
+pci_read_config(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	unsigned int size = 64;
+
+	/* Several chips lock up trying to read undefined config space */
+	if (capable(CAP_SYS_ADMIN)) {
+		size = 256;
+	} else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
+		size = 128;
+	}
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
+	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	unsigned int size = count;
+
+	if (off > 256)
+		return 0;
+	if (off + count > 256) {
+		size = 256 - off;
+		count = size;
+	}
+
+	while (off & 3) {
+		pci_write_config_byte(dev, off, buf[off]);
+		off++;
+		if (--size == 0)
+			break;
+	}
+
+	while (size > 3) {
+		unsigned int val = buf[off];
+		val |= (unsigned int) buf[off + 1] << 8;
+		val |= (unsigned int) buf[off + 2] << 16;
+		val |= (unsigned int) buf[off + 3] << 24;
+		pci_write_config_dword(dev, off, val);
+		off += 4;
+		size -= 4;
+	}
+
+	while (size > 0) {
+		pci_write_config_byte(dev, off, buf[off]);
+		off++;
+		--size;
+	}
+
+	return count;
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
@@ -72,4 +176,5 @@
 	device_create_file (dev, &dev_attr_class);
 	device_create_file (dev, &dev_attr_irq);
 	device_create_file (dev, &dev_attr_resource);
+	sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
 }
diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c	Thu Jul  3 18:16:32 2003
+++ b/fs/sysfs/bin.c	Thu Jul  3 18:16:32 2003
@@ -42,18 +42,17 @@
 
 	ret = fill_read(dentry, buffer, offs, count);
 	if (ret < 0) 
-		goto Done;
+		return ret;
 	count = ret;
 
-	ret = -EFAULT;
-	if (copy_to_user(userbuf, buffer, count) != 0)
-		goto Done;
+	if (copy_to_user(userbuf, buffer + offs, count) != 0)
+		return -EINVAL;
+
+	printk("offs = %lld, *off = %lld, count = %zd\n", offs, *off, count);
 
 	*off = offs + count;
-	ret = count;
 
- Done:
-	return ret;
+	return count;
 }
 
 static int
@@ -72,7 +71,6 @@
 	struct dentry *dentry = file->f_dentry;
 	int size = dentry->d_inode->i_size;
 	loff_t offs = *off;
-	int ret;
 
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
@@ -83,16 +81,13 @@
 			count = size - offs;
 	}
 
-	ret = -EFAULT;
-	if (copy_from_user(buffer, userbuf, count))
-		goto Done;
+	if (copy_from_user(buffer + offs, userbuf, count))
+		return -EFAULT;
 
 	count = flush_write(dentry, buffer, offs, count);
 	if (count > 0)
 		*off = offs + count;
-	ret = count;
- Done:
-	return ret;
+	return count;
 }
 
 static int open(struct inode * inode, struct file * file)

