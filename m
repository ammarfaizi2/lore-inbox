Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbUL1Iga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUL1Iga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 03:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUL1Ig3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 03:36:29 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:51345 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261778AbUL1IaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 03:30:12 -0500
Date: Tue, 28 Dec 2004 09:28:37 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] s390: new DCSS SHM device driver
Message-ID: <20041228082837.GH7988@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 7/8] s390: dcss shared memory.

From: Carsten Otte <cotte@de.ibm.com>

Add support for shared memory using z/VM DCSS.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 drivers/s390/Kconfig        |   11 
 drivers/s390/char/Makefile  |    1 
 drivers/s390/char/dcssshm.c |  728 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 740 insertions(+)

diff -urN linux-2.6/drivers/s390/char/dcssshm.c linux-2.6-patched/drivers/s390/char/dcssshm.c
--- linux-2.6/drivers/s390/char/dcssshm.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/dcssshm.c	2004-12-28 08:50:52.000000000 +0100
@@ -0,0 +1,728 @@
+/*
+ * dcssshm.c --  dcss shared memory for userspace
+ *
+ * (C) Copyright IBM Corp. 2004
+ * Author(s): Carsten Otte <cotte@de.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/ctype.h>
+#include <linux/kdev_t.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <asm/extmem.h>
+#include <asm/page.h>
+#include <asm/ccwdev.h> 	// for s390_root_dev_(un)register()
+
+#define DCSSSHM_DEBUG		/* Debug messages on/off */
+#define DCSSSHM_NAME "dcssshm"
+#ifdef DCSSSHM_DEBUG
+#define PRINT_DEBUG(x...) printk(KERN_DEBUG DCSSSHM_NAME " debug: " x)
+#else
+#define PRINT_DEBUG(x...) do {} while (0)
+#endif
+#define PRINT_INFO(x...)  printk(KERN_INFO DCSSSHM_NAME " info: " x)
+#define PRINT_WARN(x...)  printk(KERN_WARNING DCSSSHM_NAME " warning: " x)
+#define PRINT_ERR(x...)	  printk(KERN_ERR DCSSSHM_NAME " error: " x)
+
+static ssize_t dcssshm_add_store(struct device * dev, const char * buf,
+				  size_t count);
+static ssize_t dcssshm_remove_store(struct device * dev, const char * buf,
+				  size_t count);
+static ssize_t dcssshm_save_store(struct device * dev, const char * buf,
+				  size_t count);
+static ssize_t dcssshm_save_show(struct device *dev, char *buf);
+static ssize_t dcssshm_shared_store(struct device * dev, const char * buf,
+				  size_t count);
+static ssize_t dcssshm_shared_show(struct device *dev, char *buf);
+
+static int   dcssshm_open(struct inode *inode, struct file *filp);
+static int   dcssshm_release(struct inode *inode, struct file *filp);
+static int dcssshm_mmap(struct file * file, struct vm_area_struct * vma);
+static struct page * dcssshm_nopage_in_place(struct vm_area_struct * area,
+				      unsigned long address, int* type);
+static loff_t dcssshm_llseek (struct file* file, loff_t offset, int orig);
+
+static DEVICE_ATTR(add, S_IWUSR, NULL, dcssshm_add_store);
+static DEVICE_ATTR(remove, S_IWUSR, NULL, dcssshm_remove_store);
+static DEVICE_ATTR(save, S_IWUSR | S_IRUGO, dcssshm_save_show,
+		   dcssshm_save_store);
+static DEVICE_ATTR(shared, S_IWUSR | S_IRUGO, dcssshm_shared_show,
+		   dcssshm_shared_store);
+
+static int dcssshm_major = 0;
+static struct device *dcssshm_root_dev;
+
+struct dcssshm_dev_info {
+	struct list_head lh;
+	struct device dev;
+	struct cdev *cdev;
+	char segment_name[BUS_ID_SIZE];
+	atomic_t use_count;
+	unsigned long start;
+	unsigned long end;
+	int segment_type;
+	unsigned char save_pending;
+	unsigned char is_shared;
+	unsigned char is_ro;
+	int minor;
+};
+
+static struct vm_operations_struct dcssshm_vm_ops = {
+	.nopage		= dcssshm_nopage_in_place,
+};
+
+static struct file_operations dcssshm_fops =
+{
+	.owner = THIS_MODULE,
+	.open = dcssshm_open,
+	.release = dcssshm_release,
+	.mmap = dcssshm_mmap,
+	.llseek = dcssshm_llseek,
+};
+
+static struct list_head dcssshm_devices = LIST_HEAD_INIT(dcssshm_devices);
+static struct rw_semaphore dcssshm_devices_sem;
+
+/*
+ * print appropriate error message for segment_load()/segment_info()
+ * return code
+ */
+static void
+dcssshm_segment_warn(int rc, char* seg_name)
+{
+	switch (rc) {
+	case -ENOENT:
+		PRINT_WARN("cannot load/query segment %s, does not exist\n",
+			   seg_name);
+		break;
+	case -ENOSYS:
+		PRINT_WARN("cannot load/query segment %s, not running on VM\n",
+			   seg_name);
+		break;
+	case -EIO:
+		PRINT_WARN("cannot load/query segment %s, hardware error\n",
+			   seg_name);
+		break;
+	case -ENOTSUPP:
+		PRINT_WARN("cannot load/query segment %s, is a multi-part "
+			   "segment\n", seg_name);
+		break;
+	case -ENOSPC:
+		PRINT_WARN("cannot load/query segment %s, overlaps with "
+			   "storage\n", seg_name);
+		break;
+	case -EBUSY:
+		PRINT_WARN("cannot load/query segment %s, overlaps with "
+			   "already loaded dcss\n", seg_name);
+		break;
+	case -ERANGE:
+		PRINT_WARN("cannot load/query segment %s, exceeds kernel "
+			   "mapping range\n", seg_name);
+		break;
+	case -EPERM:
+		PRINT_WARN("cannot load/query segment %s, already loaded in "
+			   "incompatible mode\n", seg_name);
+		break;
+	case -ENOMEM:
+		PRINT_WARN("cannot load/query segment %s, out of memory\n",
+			   seg_name);
+		break;
+	default:
+		PRINT_WARN("cannot load/query segment %s, return value %i\n",
+			   seg_name, rc);
+		break;
+	}
+}
+
+
+/*
+ * release function for segment device.
+ */
+static void
+dcssshm_release_segment(struct device *dev)
+{
+	PRINT_DEBUG("segment release fn called for %s\n", dev->bus_id);
+	kfree(container_of(dev, struct dcssshm_dev_info, dev));
+	module_put(THIS_MODULE);
+}
+
+/*
+ * get a minor number. needs to be called with
+ * down_write(&dcssshm_devices_sem) and the
+ * device needs to be enqueued before the semaphore is
+ * freed.
+ */
+static inline int
+dcssshm_assign_free_minor(struct dcssshm_dev_info *dev_info)
+{
+	int minor, found;
+	struct dcssshm_dev_info *entry;
+
+	if (dev_info == NULL)
+		return -EINVAL;
+	for (minor = 0; minor < (1<<MINORBITS); minor++) {
+		found = 0;
+		// test if minor available
+		list_for_each_entry(entry, &dcssshm_devices, lh)
+			if (minor == entry->minor)
+				found++;
+		if (!found) break; // got unused minor
+	}
+	if (found)
+		return -EBUSY;
+	dev_info->minor = minor;
+	return 0;
+}
+
+/*
+ * get the struct dcssshm_dev_info from dcssshm_devices
+ * for the given name.
+ * down_read(&dcssshm_devices_sem) must be held.
+ */
+static struct dcssshm_dev_info *
+dcssshm_get_device_by_name(char *name)
+{
+	struct dcssshm_dev_info *entry;
+
+	list_for_each_entry(entry, &dcssshm_devices, lh) {
+		if (!strcmp(name, entry->segment_name)) {
+			return entry;
+		}
+	}
+	return NULL;
+}
+
+/*
+ * get the struct dcssshm_dev_info from dcssshm_devices
+ * for the given minor.
+ * down_read(&dcssshm_devices_sem) must be held.
+ */
+static struct dcssshm_dev_info *
+dcssshm_get_device_by_minor(int minor)
+{
+	struct dcssshm_dev_info *entry;
+
+	list_for_each_entry(entry, &dcssshm_devices, lh) {
+		if (minor == entry->minor) {
+			return entry;
+		}
+	}
+	return NULL;
+}
+
+
+
+/*
+ * device attribute for switching shared/nonshared (exclusive)
+ * operation (show + store)
+ */
+static ssize_t
+dcssshm_shared_show(struct device *dev, char *buf)
+{
+	struct dcssshm_dev_info *dev_info;
+
+	dev_info = container_of(dev, struct dcssshm_dev_info, dev);
+	return sprintf(buf, dev_info->is_shared ? "1\n" : "0\n");
+}
+
+static ssize_t
+dcssshm_shared_store(struct device *dev, const char *inbuf, size_t count)
+{
+	struct dcssshm_dev_info *dev_info;
+	int rc;
+
+	if ((count > 1) && (inbuf[1] != '\n') && (inbuf[1] != '\0')) {
+		PRINT_WARN("Invalid value, must be 0 or 1\n");
+		return -EINVAL;
+	}
+	down_write(&dcssshm_devices_sem);
+	dev_info = container_of(dev, struct dcssshm_dev_info, dev);
+	if (atomic_read(&dev_info->use_count)) {
+		PRINT_ERR("share: segment %s is busy!\n",
+			  dev_info->segment_name);
+		up_write(&dcssshm_devices_sem);
+		return -EBUSY;
+	}
+	if (inbuf[0] == '1') {
+		// reload segment in shared mode
+		rc = segment_modify_shared(dev_info->segment_name,
+						SEGMENT_SHARED);
+		if (rc < 0) {
+			BUG_ON (rc == -EINVAL);
+			if (rc == -EIO || rc == -ENOENT)
+				goto removeseg;
+		} else {
+			dev_info->is_shared = 1;
+			switch (dev_info->segment_type) {
+				case SEG_TYPE_SR:
+				case SEG_TYPE_ER:
+				case SEG_TYPE_SC:
+					dev_info->is_ro=1;
+			}
+		}
+	} else if (inbuf[0] == '0') {
+		// reload segment in exclusive mode
+		if (dev_info->segment_type == SEG_TYPE_SC) {
+			PRINT_ERR("Segment type SC (%s) cannot be loaded in "
+				  "non-shared mode\n", dev_info->segment_name);
+			up_write(&dcssshm_devices_sem);
+			return -EINVAL;
+		}
+		rc = segment_modify_shared(dev_info->segment_name,
+						SEGMENT_EXCLUSIVE);
+		if (rc < 0) {
+			BUG_ON (rc == -EINVAL);
+			if (rc == -EIO || rc == -ENOENT)
+				goto removeseg;
+		} else {
+			dev_info->is_shared = 0;
+			dev_info->is_ro = 0;
+		}
+	} else {
+		up_write(&dcssshm_devices_sem);
+		PRINT_WARN("Invalid value, must be 0 or 1\n");
+		return -EINVAL;
+	}
+	rc = count;
+	up_write(&dcssshm_devices_sem);
+	goto out;
+
+removeseg:
+	PRINT_ERR("Could not reload segment %s, removing it now!\n",
+			dev_info->segment_name);
+	list_del(&dev_info->lh);
+	device_unregister(dev);
+	put_device(dev);
+	up_write(&dcssshm_devices_sem);
+out:
+	return rc;
+}
+
+/*
+ * device attribute for save operation on current copy
+ * of the segment. If the segment is busy, saving will
+ * become pending until it gets released, which can be
+ * undone by storing a non-true value to this entry.
+ * (show + store)
+ */
+static ssize_t
+dcssshm_save_show(struct device *dev, char *buf)
+{
+	struct dcssshm_dev_info *dev_info;
+
+	dev_info = container_of(dev, struct dcssshm_dev_info, dev);
+	return sprintf(buf, dev_info->save_pending ? "1\n" : "0\n");
+}
+
+static ssize_t
+dcssshm_save_store(struct device *dev, const char *inbuf, size_t count)
+{
+	struct dcssshm_dev_info *dev_info;
+
+	if ((count > 1) && (inbuf[1] != '\n') && (inbuf[1] != '\0')) {
+		PRINT_WARN("Invalid value, must be 0 or 1\n");
+		return -EINVAL;
+	}
+	dev_info = container_of(dev, struct dcssshm_dev_info, dev);
+
+	down_write(&dcssshm_devices_sem);
+	if (inbuf[0] == '1') {
+		if (atomic_read(&dev_info->use_count) == 0) {
+			// device is idle => we save immediately
+			PRINT_INFO("Saving segment %s\n",
+				   dev_info->segment_name);
+			segment_save(dev_info->segment_name);
+		}  else {
+			// device is busy => we save it when it becomes
+			// idle in dcssshm_release
+			PRINT_INFO("Segment %s is currently busy, it will "
+				   "be saved when it becomes idle...\n",
+				   dev_info->segment_name);
+			dev_info->save_pending = 1;
+		}
+	} else if (inbuf[0] == '0') {
+		if (dev_info->save_pending) {
+			// device is busy & the user wants to undo his save
+			// request
+			dev_info->save_pending = 0;
+			PRINT_INFO("Pending save for segment %s deactivated\n",
+					dev_info->segment_name);
+		}
+	} else {
+		up_write(&dcssshm_devices_sem);
+		PRINT_WARN("Invalid value, must be 0 or 1\n");
+		return -EINVAL;
+	}
+	up_write(&dcssshm_devices_sem);
+	return count;
+}
+
+/*
+ * device attribute for adding devices
+ */
+static ssize_t
+dcssshm_add_store(struct device *dev, const char *buf, size_t count)
+{
+	int rc, i;
+	struct dcssshm_dev_info *dev_info;
+	char *local_buf;
+
+	dev_info = NULL;
+	if (dev != dcssshm_root_dev) {
+		rc = -EINVAL;
+		goto out_nobuf;
+	}
+	local_buf = kmalloc(count + 1, GFP_KERNEL);
+	if (local_buf == NULL) {
+		rc = -ENOMEM;
+		goto out_nobuf;
+	}
+	/*
+	 * parse input
+	 */
+	for (i = 0; ((buf[i] != '\0') && (buf[i] != '\n') && i < count); i++) {
+		local_buf[i] = toupper(buf[i]);
+	}
+	local_buf[i] = '\0';
+	if ((i == 0) || (i > 8)) {
+		rc = -ENAMETOOLONG;
+		goto out;
+	}
+	/*
+	 * already loaded?
+	 */
+	down_read(&dcssshm_devices_sem);
+	dev_info = dcssshm_get_device_by_name(local_buf);
+	up_read(&dcssshm_devices_sem);
+	if (dev_info != NULL) {
+		PRINT_WARN("Segment %s already loaded!\n", local_buf);
+		rc = -EEXIST;
+		goto out;
+	}
+	/*
+	 * get a struct dcssshm_dev_info and a cdev
+	 */
+	dev_info = kmalloc(sizeof(struct dcssshm_dev_info), GFP_KERNEL);
+	if (dev_info == NULL) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	memset(dev_info, 0, sizeof(struct dcssshm_dev_info));
+	dev_info->cdev = cdev_alloc();
+	if (dev_info->cdev == NULL) {
+		rc = -ENOMEM;
+		goto free_dev_info;
+	}
+	/* initialize char device and dev info */
+	strcpy(dev_info->segment_name, local_buf);
+	strlcpy(dev_info->dev.bus_id, local_buf, BUS_ID_SIZE);
+	dev_info->dev.release = dcssshm_release_segment;
+	INIT_LIST_HEAD(&dev_info->lh);
+
+	dev_info->cdev->owner = THIS_MODULE;
+	dev_info->cdev->ops   = &dcssshm_fops;
+
+	/*
+	 * load the segment
+	 */
+	rc = segment_load(local_buf, SEGMENT_SHARED,
+				&dev_info->start, &dev_info->end);
+	if (rc < 0) {
+		dcssshm_segment_warn (rc, dev_info->segment_name);
+		goto free_cdev;
+	}
+
+	dev_info->segment_type = rc;
+	dev_info->save_pending = 0;
+	dev_info->is_shared = 1;
+	dev_info->dev.parent = dcssshm_root_dev;
+
+	if (rc == SEG_TYPE_SR || rc == SEG_TYPE_ER || rc == SEG_TYPE_SC)
+		dev_info->is_ro=1;
+	else
+		dev_info->is_ro=0;
+
+	/*
+	 * get minor, add to list
+	 */
+	down_write(&dcssshm_devices_sem);
+	rc = dcssshm_assign_free_minor(dev_info);
+	if (rc) {
+		up_write(&dcssshm_devices_sem);
+		PRINT_ERR("No free minor number available! "
+			  "Unloading segment...\n");
+		goto unload_seg;
+	}
+	list_add_tail(&dev_info->lh, &dcssshm_devices);
+
+	dev_info->cdev->dev = MKDEV (dcssshm_major, dev_info->minor);
+
+	if (!try_module_get(THIS_MODULE)) {
+		rc = -ENODEV;
+		goto list_del;
+	}
+	/*
+	 * register the device
+	 */
+	rc = device_register(&dev_info->dev);
+	if (rc) {
+		PRINT_ERR("Segment %s could not be registered RC=%d\n",
+				local_buf, rc);
+		module_put(THIS_MODULE);
+		goto list_del;
+	}
+	get_device(&dev_info->dev);
+	rc = device_create_file(&dev_info->dev, &dev_attr_shared);
+	if (rc)
+		goto unregister_dev;
+	rc = device_create_file(&dev_info->dev, &dev_attr_save);
+	if (rc)
+		goto unregister_dev;
+
+	/* add cdev */
+	rc = cdev_add (dev_info->cdev, dev_info->cdev->dev, 1);
+
+	PRINT_DEBUG("Segment %s loaded successfully\n", local_buf);
+	up_write(&dcssshm_devices_sem);
+	rc = count;
+	goto out;
+
+unregister_dev:
+	PRINT_ERR("device_create_file() failed!\n");
+	list_del(&dev_info->lh);
+	device_unregister(&dev_info->dev);
+	segment_unload(dev_info->segment_name);
+	put_device(&dev_info->dev);
+	up_write(&dcssshm_devices_sem);
+	goto out;
+list_del:
+	list_del(&dev_info->lh);
+	up_write(&dcssshm_devices_sem);
+unload_seg:
+	segment_unload(local_buf);
+free_cdev:
+	kobject_put (&dev_info->cdev->kobj);
+free_dev_info:
+	kfree(dev_info);
+out:
+	kfree(local_buf);
+out_nobuf:
+	return rc;
+}
+
+/*
+ * device attribute for removing devices
+ */
+static ssize_t
+dcssshm_remove_store(struct device *dev, const char *buf, size_t count)
+{
+	struct dcssshm_dev_info *dev_info;
+	int rc, i;
+	char *local_buf;
+
+	if (dev != dcssshm_root_dev) {
+		return -EINVAL;
+	}
+	local_buf = kmalloc(count + 1, GFP_KERNEL);
+	if (local_buf == NULL) {
+		return -ENOMEM;
+	}
+
+	/*
+	 * parse input
+	 */
+	for (i = 0; ((*(buf+i)!='\0') && (*(buf+i)!='\n') && i < count); i++) {
+		local_buf[i] = toupper(buf[i]);
+	}
+	local_buf[i] = '\0';
+	if ((i == 0) || (i > 8)) {
+		rc = -ENAMETOOLONG;
+		goto out_buf;
+	}
+
+	down_write(&dcssshm_devices_sem);
+	dev_info = dcssshm_get_device_by_name(local_buf);
+	if (dev_info == NULL) {
+		up_write(&dcssshm_devices_sem);
+		PRINT_WARN("Segment %s is not loaded!\n", local_buf);
+		rc = -ENODEV;
+		goto out_buf;
+	}
+	if (atomic_read(&dev_info->use_count) != 0) {
+		up_write(&dcssshm_devices_sem);
+		PRINT_WARN("Segment %s is in use!\n", local_buf);
+		rc = -EBUSY;
+		goto out_buf;
+	}
+	list_del(&dev_info->lh);
+
+	device_unregister(&dev_info->dev);
+	segment_unload(dev_info->segment_name);
+	PRINT_DEBUG("Segment %s unloaded successfully\n",
+			dev_info->segment_name);
+	cdev_del (dev_info->cdev);
+	put_device(&dev_info->dev);
+	up_write(&dcssshm_devices_sem);
+
+	rc = count;
+out_buf:
+	kfree(local_buf);
+	return rc;
+}
+
+/* char device stuff */
+static int
+dcssshm_open(struct inode *inode, struct file *filp)
+{
+	struct dcssshm_dev_info* dev_info;
+	int minor, rc;
+
+	if (imajor(filp->f_dentry->d_inode) != dcssshm_major)
+		return -ENODEV;
+
+	minor = iminor(filp->f_dentry->d_inode);
+	down_write(&dcssshm_devices_sem);
+	dev_info = dcssshm_get_device_by_minor(minor);
+	if (!dev_info) {
+		rc = -ENODEV;
+		goto up_read;
+	}
+
+
+	filp->private_data = dev_info;
+	atomic_inc(&dev_info->use_count);
+
+	rc = 0;
+up_read:
+	up_write(&dcssshm_devices_sem);
+	return rc;
+}
+
+static int
+dcssshm_release(struct inode *inode, struct file *filp)
+{
+	struct dcssshm_dev_info *dev_info = (struct dcssshm_dev_info*)filp->private_data;
+	int rc;
+
+	down_write(&dcssshm_devices_sem);
+	if (atomic_dec_and_test(&dev_info->use_count)
+	    && (dev_info->save_pending)) {
+		PRINT_INFO("Segment %s became idle and is being saved now\n",
+			    dev_info->segment_name);
+		segment_save(dev_info->segment_name);
+		dev_info->save_pending = 0;
+	}
+	up_write(&dcssshm_devices_sem);
+	rc = 0;
+	return rc;
+}
+
+
+static int
+dcssshm_mmap(struct file * file, struct vm_area_struct * vma)
+{
+	file_accessed(file);
+	vma->vm_ops = &dcssshm_vm_ops;
+	return 0;
+}
+
+static struct page *
+dcssshm_nopage_in_place(struct vm_area_struct * area, unsigned long address,
+			int* type)
+{
+	struct dcssshm_dev_info* dev_info = area->vm_file->private_data;
+	unsigned long pgoff;
+
+	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) +
+		area->vm_pgoff;
+	if ((pgoff+1)*PAGE_SIZE-1 > dev_info->end - dev_info->start)
+		return NULL;
+	return virt_to_page((unsigned long)(dev_info->start+pgoff*PAGE_SIZE));
+}
+
+static loff_t
+dcssshm_llseek (struct file* file, loff_t offset, int orig)
+{
+	loff_t ret;
+	struct dcssshm_dev_info *dev_info = (struct dcssshm_dev_info*)
+						file->private_data;
+	switch (orig) {
+	case 0: // SEEK_SET
+		if (offset < 0)
+			return -EINVAL;
+		if (offset > (dev_info->end - dev_info->start))
+			return -EINVAL;
+		file->f_pos = offset;
+		ret = file->f_pos;
+		break;
+	case 1: // SEEK_CURR
+		if (file->f_pos + offset > dev_info->end - dev_info->start)
+			return -EINVAL;
+		if (file->f_pos + offset < 0)
+			return -EINVAL;
+		file->f_pos += offset;
+		ret = file->f_pos;
+		break;
+	case 2: // SEEK_END
+		if (offset > 0)
+			return -EINVAL;
+		if (offset < (((long)dev_info->start) - ((long)dev_info->end)))
+			return -EINVAL;
+		file->f_pos = dev_info->end - dev_info->start + offset;
+		ret = file->f_pos;
+		break;
+	default: // unknown origin
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static int __init
+dcssshm_init(void)
+{
+	int rc;
+	dev_t dev;
+	dcssshm_root_dev = s390_root_dev_register("dcssshm");
+	if (IS_ERR(dcssshm_root_dev)) {
+		PRINT_ERR("device_register() failed!\n");
+		return PTR_ERR(dcssshm_root_dev);
+	}
+	rc = device_create_file(dcssshm_root_dev, &dev_attr_add);
+	if (rc) {
+		PRINT_ERR("device_create_file(add) failed!\n");
+		s390_root_dev_unregister(dcssshm_root_dev);
+		return rc;
+	}
+	rc = device_create_file(dcssshm_root_dev, &dev_attr_remove);
+	if (rc) {
+		PRINT_ERR("device_create_file(remove) failed!\n");
+		s390_root_dev_unregister(dcssshm_root_dev);
+		return rc;
+	}
+	rc = alloc_chrdev_region (&dev, 0, 256, "dcssshm");
+	if (rc) {
+	        PRINT_ERR("alloc_chrdev_region falied!\n");
+		s390_root_dev_unregister(dcssshm_root_dev);
+		return rc;
+	}
+	dcssshm_major = MAJOR(dev);
+	return 0;
+}
+
+static void __exit
+dcssshm_exit(void)
+{
+	s390_root_dev_unregister(dcssshm_root_dev);
+	if (dcssshm_major)
+		unregister_chrdev_region(MKDEV(dcssshm_major, 0), 256);
+	return;
+}
+
+module_init(dcssshm_init);
+module_exit(dcssshm_exit);
+
+MODULE_LICENSE("GPL");
diff -urN linux-2.6/drivers/s390/char/Makefile linux-2.6-patched/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	2004-12-24 22:34:44.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/Makefile	2004-12-28 08:50:52.000000000 +0100
@@ -26,3 +26,4 @@
 obj-$(CONFIG_S390_TAPE) += tape.o tape_class.o
 obj-$(CONFIG_S390_TAPE_34XX) += tape_34xx.o
 obj-$(CONFIG_MONREADER) += monreader.o
+obj-$(CONFIG_DCSS_SHM)	+= dcssshm.o
diff -urN linux-2.6/drivers/s390/Kconfig linux-2.6-patched/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6-patched/drivers/s390/Kconfig	2004-12-28 08:50:52.000000000 +0100
@@ -193,6 +193,17 @@
 	help
 	  Character device driver for reading z/VM monitor service records
 
+config DCSS_SHM
+	tristate "Support for shared memory using z/VM DCSS"
+	depends on EXPERIMENTAL
+	help
+	  Select this option if you want to access z/VM DCSS by using the
+	  character device interface to get userspace shared memory among
+	  applications on different Linux images via the mmap() operation.
+	  This feature is EXPERIMENTAL, do NOT use it in production
+	  environments. If you find this feature useful, please send an
+	  email to linux390@de.ibm.com and ask for a stable version.
+
 endmenu
 
 menu "Cryptographic devices"
