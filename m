Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWBBWnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWBBWnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWBBWnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:43:25 -0500
Received: from sipsolutions.net ([66.160.135.76]:62213 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932388AbWBBWnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:43:23 -0500
Subject: [RFC 4/4] firewire: add mem1394
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
In-Reply-To: <1138919238.3621.12.camel@localhost>
References: <1138919238.3621.12.camel@localhost>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 23:43:05 +0100
Message-Id: <1138920185.3621.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While the previous patches were purely infrastructure, this patch
actually adds the code using it: mem1394.

There are some open questions on a few things, maybe someone can help
out there.

diff --git a/drivers/ieee1394/Kconfig b/drivers/ieee1394/Kconfig
index 39142e2..cd7b28c 100644
--- a/drivers/ieee1394/Kconfig
+++ b/drivers/ieee1394/Kconfig
@@ -169,4 +169,21 @@ config IEEE1394_RAWIO
 	  To compile this driver as a module, say M here: the
 	  module will be called raw1394.
 
+config IEEE1394_MEMDEV
+	tristate "IEEE1394 memory device support"
+	depends on IEEE1394 && EXPERIMENTAL
+	help
+	  Say Y here if you want support for the ieee1394 memory device.
+	  This is useful for debugging systems attached via firewire
+	  since it usually allows you to read from and write to their memory,
+	  depending on the controller and machine setup.
+	  
+	  It differs from raw access (which allows the same usage) in that
+	  it provides devices nodes (usually called /dev/fwmem-<guid>) that can
+	  be read and written with any tool, as opposed to specialised tools
+	  required for raw1394.
+	  
+	  To compile this driver as a module, say M here: the
+	  module will be called mem1394.
+
 endmenu
diff --git a/drivers/ieee1394/Makefile b/drivers/ieee1394/Makefile
index 180bf82..7da4e21 100644
--- a/drivers/ieee1394/Makefile
+++ b/drivers/ieee1394/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_IEEE1394_RAWIO) += raw1394.
 obj-$(CONFIG_IEEE1394_SBP2) += sbp2.o
 obj-$(CONFIG_IEEE1394_DV1394) += dv1394.o
 obj-$(CONFIG_IEEE1394_ETH1394) += eth1394.o
+obj-$(CONFIG_IEEE1394_MEMDEV) += mem1394.o
 
 quiet_cmd_oui2c = OUI2C   $@
       cmd_oui2c = $(CONFIG_SHELL) $(src)/oui2c.sh < $< > $@
diff --git a/drivers/ieee1394/mem1394.c b/drivers/ieee1394/mem1394.c
new file mode 100644
index 0000000..e9d44a2
--- /dev/null
+++ b/drivers/ieee1394/mem1394.c
@@ -0,0 +1,277 @@
+/*
+ * IEEE 1394 for Linux
+ *
+ * Copyright (C) 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * This code is licensed under the GPL v2. See the file COPYING in the root
+ * directory of the kernel sources for details.
+ *
+ * This module provides a character device for each node attached
+ * to the bus and allows direct memory access on them.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/cdev.h>
+
+#include "ieee1394.h"
+#include "ieee1394_core.h"
+#include "ieee1394_transactions.h"
+#include "mem1394.h"
+#include "nodemgr.h"
+#include "highlevel.h"
+
+static int mem1394_mmap(struct file * file, struct vm_area_struct * vma)
+{
+	return -ENOSYS;
+}
+
+static int mem1394_open(struct inode *inode, struct file *file)
+{
+	struct mem1394_file_info *fi;
+
+	fi = kzalloc(sizeof(*fi), GFP_KERNEL);
+	if (!fi)
+		return -ENOMEM;
+	file->private_data = fi;
+	fi->memdev = container_of(inode->i_cdev, struct mem1394_dev, cdev);
+	return 0;
+}
+
+/* This function essentially clones hpsb_read. Might be better
+ * to create a new hpsb_read_user function instead... */
+static int mem1394_read(struct file *file, char __user * buffer,
+			size_t count, loff_t *offset)
+{
+	struct mem1394_file_info *fi = (struct mem1394_file_info*)file->private_data;
+	/* lower levels only support count as a multiple of 4 */
+	size_t submitcount = (count + (4-1)) & ~(4-1);
+	int retval = 0;
+	struct hpsb_packet *packet;
+
+	/* this is a bit icky. I think I'll want to create a
+	 * "struct hpsb_node_class_interface" that you register
+	 * with nodemgr.c instead of registering the "struct class_interface"
+	 * directly. It would wrap around the "struct class_interface"
+	 * and handle things like this.
+	 *
+	 * This means it would call the node_class_interface's
+	 *  - "add" method whenever the device is fully there, and an
+	 *  - "update" method when it survived a bus reset, and the
+	 *  - "remove" method when it went away, also taking care of
+	 * debouncing, which the mem1394 interface currently doesn't handle.
+	 *
+	 * But I need advice on this. It'll probably works this way
+	 * but most likely not once this interface stuff gets more
+	 * use; I can imagine using it for scanners instead of raw1394
+	 * so that the kernel can validate that a user can only
+	 * access a certain scanner and not all 1394 devices on the bus.
+	 * In other words some 'raw1394intf' instead of 'raw1394' which
+	 * creates one character device per ieee1394 node for finer
+	 * grained access control.
+	 * That would definitely want to have debouncing etc.
+	 *
+	 * However, I don't fully understand the states node_entries go
+	 * through yet, so I'm not sure this should even be here!
+	 * Maybe it should be in open? But then the device could go
+	 * into limbo when it is already opened...
+	 *
+	 * Similarly, what happens if a node is suspended?
+	 */
+	if (fi->memdev->ne->in_limbo)
+		return -ENODEV;
+
+	if (count == 0)
+		return 0;
+
+	/* I wonder if it is possible to do DMA directly to the userspace buffer... */
+	packet = hpsb_make_readpacket(fi->memdev->ne->host, fi->memdev->ne->nodeid, *offset, submitcount);
+	if (!packet)
+		return -ENOENT;
+	
+	packet->generation = fi->memdev->ne->generation;
+	retval = hpsb_send_packet_and_wait(packet);
+	if (retval < 0)
+		goto out_free;
+
+	retval = hpsb_packet_success(packet);
+	
+	if (retval == 0) {
+		if (submitcount == 4) {
+			if (copy_to_user(buffer, &packet->header[3], count))
+				retval = -EFAULT;
+		} else {
+			if (copy_to_user(buffer, packet->data, count))
+				retval = -EFAULT;
+		}
+	}
+
+	if (retval == 0) {
+		retval = count;
+		*offset += count;
+	}
+
+ out_free:
+	hpsb_free_tlabel(packet);
+	hpsb_free_packet(packet);
+
+	return retval;
+}
+
+static int mem1394_release(struct inode *inode, struct file *file)
+{
+	struct mem1394_file_info *fi = (struct mem1394_file_info*)file->private_data;
+	
+	kfree(fi);
+
+	return 0;
+}
+
+static struct class *mem1394_sysfs_class;
+
+static struct file_operations mem1394_fops = {
+	.owner = THIS_MODULE,
+	.mmap = mem1394_mmap,
+	.open = mem1394_open,
+	.read = mem1394_read,
+	.release = mem1394_release,
+};
+
+static atomic_t mem1394_dev_ctr;
+
+static struct mem1394_dev * alloc_mem1394_dev(struct device *dev)
+{
+	struct mem1394_dev *result;
+	struct node_entry *ne = container_of(dev, struct node_entry, device);
+	int ret;
+	struct class_device * mem1394_class_member;
+
+	result = kzalloc(sizeof(*result), GFP_KERNEL);
+	if (!result)
+		return NULL;
+
+	cdev_init(&result->cdev, &mem1394_fops);
+	result->cdev.owner = THIS_MODULE;
+	result->ne = ne;
+
+	ret = hpsb_cdev_add(&result->cdev);
+	if (ret) {
+		printk(KERN_ERR "mem1394: failed to register character device!\n");
+		goto out_free;
+	}
+
+	atomic_inc(&mem1394_dev_ctr);
+	mem1394_class_member = class_device_create(mem1394_sysfs_class, NULL, result->cdev.dev,
+						dev, "fwmem-%d", atomic_read(&mem1394_dev_ctr));
+	if (IS_ERR(mem1394_class_member)) {
+		printk(KERN_WARNING "mem1394: class_device_create failed\n");
+	} else {
+		class_set_devdata(mem1394_class_member, result);
+	}
+	dev->driver_data = result;
+
+	return result;
+ out_free:
+	kfree(result);
+	return NULL;
+}
+
+static DEFINE_SPINLOCK(dev_list_lock);
+static LIST_HEAD(dev_list);
+
+static int mem1394_add(struct class_device *cl_dev, struct class_interface *cl_intf)
+{
+	struct mem1394_dev *memdev;
+
+	if (!cl_dev) {
+		printk("cl_dev not assigned\n");
+		return -ENOENT;
+	}
+	if (!cl_dev->dev) {
+		printk("cl_dev->dev not assigned\n");
+		return -ENONET;
+	}
+
+	memdev = alloc_mem1394_dev(cl_dev->dev);
+	if (!memdev)
+		return -ENOMEM;
+
+	spin_lock(&dev_list_lock);
+	list_add_tail(&memdev->list, &dev_list);
+	spin_unlock(&dev_list_lock);
+
+	/* need we do anything else? */
+	return 0;
+}
+
+static void mem1394_del(struct mem1394_dev *memdev)
+{
+	class_device_destroy(mem1394_sysfs_class, memdev->cdev.dev);
+
+	/* kill off everything that might be in progress */
+	/* TODO */
+
+	/* remove character device */
+	hpsb_cdev_del(&memdev->cdev);
+	kfree(memdev);
+}
+
+static void mem1394_remove(struct class_device *cl_dev, struct class_interface *cl_intf)
+{
+	struct mem1394_dev *memdev, *tmp, *found = NULL;
+	
+	/* find our memdev corresponding to the class device */
+	spin_lock(&dev_list_lock);
+	list_for_each_entry_safe(memdev, tmp, &dev_list, list) {
+		if (cl_dev->dev == memdev->dev) {
+			list_del(&memdev->list);
+			found = memdev;
+			break;
+		}
+	}
+	spin_unlock(&dev_list_lock);
+	if (!found)
+		return;
+
+	mem1394_del(found);
+}
+
+static struct class_interface mem1394_interface = {
+	.add		= mem1394_add,
+	.remove		= mem1394_remove,
+};
+                
+static int __init init_mem1394(void)
+{
+	int ret;
+	
+	spin_lock_init(&dev_list_lock);
+	
+	mem1394_sysfs_class = class_create(THIS_MODULE, "mem1394");
+	if (IS_ERR(mem1394_sysfs_class)) {
+		return PTR_ERR(mem1394_sysfs_class);
+	}
+
+	ret = hpsb_register_node_interface(&mem1394_interface);
+	return ret;
+}
+
+static void __exit cleanup_mem1394(void)
+{
+	struct mem1394_dev *memdev, *tmp;
+
+	hpsb_unregister_node_interface(&mem1394_interface);
+	list_for_each_entry_safe(memdev, tmp, &dev_list, list) {
+		list_del(&memdev->list);
+		mem1394_del(memdev);
+	}
+	class_destroy(mem1394_sysfs_class);
+}
+
+module_init(init_mem1394);
+module_exit(cleanup_mem1394);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
diff --git a/drivers/ieee1394/mem1394.h b/drivers/ieee1394/mem1394.h
new file mode 100644
index 0000000..e7cc8ab
--- /dev/null
+++ b/drivers/ieee1394/mem1394.h
@@ -0,0 +1,20 @@
+#ifndef IEEE1394_MEM1394_H
+#define IEEE1394_MEM1394_H
+
+#include <asm/types.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
+#include "nodemgr.h"
+
+struct mem1394_dev {
+	struct device *dev;
+	struct node_entry *ne;
+	struct cdev cdev;
+	struct list_head list;
+};
+
+struct mem1394_file_info {
+	struct mem1394_dev *memdev;
+};
+
+#endif /* IEEE1394_MEM1394_H */


