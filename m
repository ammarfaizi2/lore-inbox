Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUDKDUk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 23:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUDKDUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 23:20:40 -0400
Received: from mailhub.hp.com ([192.151.27.10]:46721 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S262217AbUDKDUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 23:20:22 -0400
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs
	namespace
From: Alex Williamson <alex.williamson@hp.com>
To: John Belmonte <john@neggie.net>
Cc: acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1081629776.2562.40.camel@wilson.home.net>
References: <1081453741.3398.77.camel@patsy.fc.hp.com>
	 <1081549317.2694.25.camel@patsy.fc.hp.com>  <4077535D.6020403@neggie.net>
	 <1081566768.2562.8.camel@wilson.home.net>  <407786C6.7030706@neggie.net>
	 <1081629776.2562.40.camel@wilson.home.net>
Content-Type: text/plain
Message-Id: <1081653618.2562.52.camel@wilson.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Apr 2004 21:20:19 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-10 at 14:42, Alex Williamson wrote:
> 
>    Ok, I took a look.  The open/write/read/close interface seems to be
> the best approach.  It shouldn't be too hard, except the read/write
> interfaces don't pass in the attribute pointer like they do for the
> show/store interface.

   I made the assumption that this wasn't that big of a stretch to the
bin file interface and extended it to add the arribute pointer.  Below
is what I came up with.  There are luckly only a handful of places using
the current sysfs bin file interface, so the additional changes are
pretty small.  I'm guessing I can probably get rid of the spinlocks I
added for the previous implementation, but they're not hurting anything
for now.  Am I getting closer?  Thanks,

	Alex

 drivers/acpi/scan.c             |  236 +++++++++++++++++++++++++++++++++++++++-
 drivers/base/firmware_class.c   |    8 -
 drivers/i2c/chips/eeprom.c      |    3 
 drivers/pci/pci-sysfs.c         |    6 -
 drivers/scsi/qla2xxx/qla_os.c   |   32 ++---
 drivers/video/aty/radeon_base.c |    6 -
 drivers/zorro/zorro-sysfs.c     |    4 
 fs/sysfs/bin.c                  |    4 
 include/linux/sysfs.h           |    6 -
 9 files changed, 273 insertions(+), 32 deletions(-)

===== drivers/acpi/scan.c 1.22 vs edited =====
--- 1.22/drivers/acpi/scan.c	Tue Feb  3 22:29:19 2004
+++ edited/drivers/acpi/scan.c	Sat Apr 10 20:55:30 2004
@@ -25,6 +25,238 @@
 static LIST_HEAD(acpi_device_list);
 static spinlock_t acpi_device_lock = SPIN_LOCK_UNLOCKED;
 
+struct acpi_handle_attribute {
+	struct attribute attr;
+	size_t size;
+	ssize_t (*read)(struct kobject *, struct attribute *,
+	                char *, loff_t, size_t);
+	ssize_t (*write)(struct kobject *, struct attribute *,
+	                 char *, loff_t, size_t); 
+	union acpi_object *args;
+	size_t length;
+	spinlock_t lock;
+};
+
+#define to_acpi_device(n) container_of(n, struct acpi_device, kobj)
+#define to_handle_attr(n) container_of(n, struct acpi_handle_attribute, attr);
+
+static ssize_t
+acpi_device_write_raw(
+	struct kobject		*kobj,
+	struct attribute	*attr,
+	char			*buf,
+	loff_t			off,
+	size_t			length)
+{
+	struct acpi_handle_attribute *attrib = to_handle_attr(attr);
+
+	/*
+	 * Not sure if offsets should be ignored or enforced, suppose we could
+	 * pass multiple arguments that way, but this interface already
+	 * accepts multiple arguments packed into an acpi_object array
+	 */
+	if (off)
+		return -ENODEV;
+
+	spin_lock(&attrib->lock);
+	if (attrib->args) {
+		kfree(attrib->args);
+		attrib->args = NULL;
+		attrib->length = 0;
+	}
+
+	attrib->args = kmalloc(length, GFP_KERNEL);
+	if (!attrib->args) {
+		spin_unlock(&attrib->lock);
+		return -ENODEV;
+	}
+
+	memcpy(attrib->args, buf, length);
+	attrib->length = length;
+	spin_unlock(&attrib->lock);
+
+	return length;
+}
+
+static ssize_t
+acpi_device_read_raw(
+	struct kobject		*kobj,
+	struct attribute	*attr,
+	char			*buf,
+	loff_t			off,
+	size_t			length)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_handle_attribute *attrib = to_handle_attr(attr);
+	struct acpi_object_list *arg_list = NULL;
+	union acpi_object **cur_arg, *args = NULL;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status status;
+	u32 count, i;
+	size_t size;
+
+	/* Ditto, see comment above */
+	if (off)
+		return -ENODEV;
+
+	spin_lock(&attrib->lock);
+
+	/*
+	 * For convenience, handle cases where the last argument
+	 * is too small.
+	 */
+	count = attrib->length / sizeof(union acpi_object);
+	if (attrib->length % sizeof(union acpi_object))
+		count++;
+
+	if (count) {
+		size = sizeof(struct acpi_object_list) +
+		       ((count - 1) * sizeof(union acpi_object *));
+
+		arg_list = kmalloc(size, GFP_KERNEL);
+		if (!arg_list) {
+			spin_unlock(&attrib->lock);
+			return -ENODEV;
+		}
+
+		memset(arg_list, 0, size);
+		arg_list->count = count;
+
+		size = count * sizeof(union acpi_object);
+		args = kmalloc(size, GFP_KERNEL);
+		if (!args) {
+			kfree(arg_list);
+			spin_unlock(&attrib->lock);
+			return -ENODEV;
+		}
+		memset(args, 0, size);
+		memcpy(args, attrib->args, min(attrib->length, size));
+
+		cur_arg = &arg_list->pointer;
+		for (i = 0 ; i < count ; i++)
+			cur_arg[i] = &args[i];
+
+		kfree(attrib->args);
+		attrib->args = NULL;
+		attrib->length = 0;
+	}
+	spin_unlock(&attrib->lock);
+
+	status = acpi_evaluate_object(device->handle, attrib->attr.name,
+	                              arg_list, &buffer);
+	if (arg_list)
+		kfree(arg_list);
+	if (args)
+		kfree(args);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	size = min((unsigned long)buffer.length, PAGE_SIZE);
+	memcpy(buf, buffer.pointer, size);
+	acpi_os_free(buffer.pointer);
+
+	return size;
+}
+
+static void
+create_sysfs_files(struct acpi_device *dev)
+{
+	acpi_handle                  chandle = 0;
+	char                         pathname[ACPI_PATHNAME_MAX];
+	acpi_status                  status;
+	struct acpi_buffer           buffer;
+	struct bin_attribute         *attrib;
+	int                          error;
+
+	buffer.length = sizeof(pathname);
+	buffer.pointer = pathname;
+
+	while (ACPI_SUCCESS(acpi_get_next_object(ACPI_TYPE_METHOD, dev->handle,
+	                                         chandle, &chandle))) {
+
+		memset(pathname, 0 , sizeof(pathname));
+
+		status = acpi_get_name(chandle, ACPI_SINGLE_NAME, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		attrib = kmalloc(sizeof(struct acpi_handle_attribute),
+		                 GFP_KERNEL);
+		if (!attrib)
+			continue;
+
+		memset(attrib, 0, sizeof(struct acpi_handle_attribute));
+
+		attrib->attr.name = kmalloc(strlen(pathname), GFP_KERNEL);
+		if (!attrib->attr.name) {
+			kfree(attrib);
+			continue;
+		}
+
+		strcpy(attrib->attr.name, pathname);
+
+		attrib->size = PAGE_SIZE;
+		attrib->attr.mode = S_IFREG | S_IRUSR |
+		                    S_IWUSR | S_IRGRP | S_IWGRP;
+		attrib->read = acpi_device_read_raw;
+		attrib->write = acpi_device_write_raw;
+		spin_lock_init(&((struct acpi_handle_attribute *)attrib)->lock);
+
+		error = sysfs_create_bin_file(&dev->kobj, attrib);
+		if (error) {
+			kfree(attrib->attr.name);
+			kfree(attrib);
+			continue;
+		}
+	}
+}
+
+extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
+
+static void
+remove_sysfs_files(struct acpi_device *dev)
+{
+	acpi_handle                  chandle = 0;
+	char                         pathname[ACPI_PATHNAME_MAX];
+	acpi_status                  status;
+	struct acpi_buffer           buffer;
+	struct bin_attribute         *old_attrib;
+	struct dentry                *dentry;
+
+	buffer.length = sizeof(pathname);
+	buffer.pointer = pathname;
+
+	while (ACPI_SUCCESS(acpi_get_next_object(ACPI_TYPE_METHOD, dev->handle,
+	                                         chandle, &chandle))) {
+
+		memset(pathname, 0 , sizeof(pathname));
+
+		status = acpi_get_name(chandle, ACPI_SINGLE_NAME, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		down(&(dev->kobj.dentry->d_inode->i_sem));
+		dentry = sysfs_get_dentry(dev->kobj.dentry, pathname);
+		if (!IS_ERR(dentry))
+			old_attrib = dentry->d_fsdata;
+		else
+			old_attrib = NULL;
+		up(&(dev->kobj.dentry->d_inode->i_sem));
+		
+		if (old_attrib) {
+			if (strncmp(pathname, old_attrib->attr.name,
+			    strlen(pathname)) != 0)
+				continue;
+
+			sysfs_remove_bin_file(&dev->kobj, old_attrib);
+
+			kfree(old_attrib->attr.name);
+			kfree(old_attrib);
+		}
+	}
+}
+
 static void acpi_device_release(struct kobject * kobj)
 {
 	struct acpi_device * dev = container_of(kobj,struct acpi_device,kobj);
@@ -72,6 +304,7 @@
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_add(&device->kobj);
+	create_sysfs_files(device);
 }
 
 static int
@@ -79,6 +312,7 @@
 	struct acpi_device	*device, 
 	int			type)
 {
+	remove_sysfs_files(device);
 	kobject_unregister(&device->kobj);
 	return 0;
 }
@@ -706,7 +940,7 @@
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result) || !device->status.present) {
+		if (ACPI_FAILURE(result)) {
 			result = -ENOENT;
 			goto end;
 		}
===== drivers/base/firmware_class.c 1.16 vs edited =====
--- 1.16/drivers/base/firmware_class.c	Mon Mar  1 20:01:49 2004
+++ edited/drivers/base/firmware_class.c	Sat Apr 10 15:31:43 2004
@@ -167,8 +167,8 @@
 			firmware_loading_show, firmware_loading_store);
 
 static ssize_t
-firmware_data_read(struct kobject *kobj,
-		   char *buffer, loff_t offset, size_t count)
+firmware_data_read(struct kobject *kobj, struct attribute *attr,
+                   char *buffer, loff_t offset, size_t count)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
@@ -227,8 +227,8 @@
  *	the driver as a firmware image.
  **/
 static ssize_t
-firmware_data_write(struct kobject *kobj,
-		    char *buffer, loff_t offset, size_t count)
+firmware_data_write(struct kobject *kobj, struct attribute *attr,
+                    char *buffer, loff_t offset, size_t count)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
===== drivers/i2c/chips/eeprom.c 1.6 vs edited =====
--- 1.6/drivers/i2c/chips/eeprom.c	Mon Mar 15 03:38:36 2004
+++ edited/drivers/i2c/chips/eeprom.c	Sat Apr 10 15:32:02 2004
@@ -122,7 +122,8 @@
 	up(&data->update_lock);
 }
 
-static ssize_t eeprom_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+static ssize_t eeprom_read(struct kobject *kobj, struct attribute *attr,
+                           char *buf, loff_t off, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
 	struct eeprom_data *data = i2c_get_clientdata(client);
===== drivers/pci/pci-sysfs.c 1.8 vs edited =====
--- 1.8/drivers/pci/pci-sysfs.c	Mon Feb  9 21:55:42 2004
+++ edited/drivers/pci/pci-sysfs.c	Sat Apr 10 20:39:02 2004
@@ -63,7 +63,8 @@
 static DEVICE_ATTR(resource,S_IRUGO,pci_show_resources,NULL);
 
 static ssize_t
-pci_read_config(struct kobject *kobj, char *buf, loff_t off, size_t count)
+pci_read_config(struct kobject *kobj, struct attribute *attr,
+                char *buf, loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
 	unsigned int size = 64;
@@ -117,7 +118,8 @@
 }
 
 static ssize_t
-pci_write_config(struct kobject *kobj, char *buf, loff_t off, size_t count)
+pci_write_config(struct kobject *kobj, struct attribute *attr,
+                 char *buf, loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
 	unsigned int size = count;
===== drivers/scsi/qla2xxx/qla_os.c 1.6 vs edited =====
--- 1.6/drivers/scsi/qla2xxx/qla_os.c	Wed Feb 18 20:42:35 2004
+++ edited/drivers/scsi/qla2xxx/qla_os.c	Sat Apr 10 15:34:14 2004
@@ -435,10 +435,10 @@
 int qla2x00_allocate_sp_pool( scsi_qla_host_t *ha);
 void qla2x00_free_sp_pool(scsi_qla_host_t *ha);
 
-static ssize_t qla2x00_sysfs_read_fw_dump(struct kobject *, char *, loff_t,
-    size_t);
-static ssize_t qla2x00_sysfs_write_fw_dump(struct kobject *, char *, loff_t,
-    size_t);
+static ssize_t qla2x00_sysfs_read_fw_dump(struct kobject *, struct attribute *,
+    char *, loff_t, size_t);
+static ssize_t qla2x00_sysfs_write_fw_dump(struct kobject *, struct attribute *,
+    char *, loff_t, size_t);
 static struct bin_attribute sysfs_fw_dump_attr = {
 	.attr = {
 		.name = "fw_dump",
@@ -448,10 +448,10 @@
 	.read = qla2x00_sysfs_read_fw_dump,
 	.write = qla2x00_sysfs_write_fw_dump,
 };
-static ssize_t qla2x00_sysfs_read_nvram(struct kobject *, char *, loff_t,
-    size_t);
-static ssize_t qla2x00_sysfs_write_nvram(struct kobject *, char *, loff_t,
-    size_t);
+static ssize_t qla2x00_sysfs_read_nvram(struct kobject *, struct attribute *,
+    char *, loff_t, size_t);
+static ssize_t qla2x00_sysfs_write_nvram(struct kobject *, struct attribute *,
+    char *, loff_t, size_t);
 static struct bin_attribute sysfs_nvram_attr = {
 	.attr = {
 		.name = "nvram",
@@ -473,8 +473,8 @@
 
 
 /* SysFS attributes. */
-static ssize_t qla2x00_sysfs_read_fw_dump(struct kobject *kobj, char *buf,
-    loff_t off, size_t count)
+static ssize_t qla2x00_sysfs_read_fw_dump(struct kobject *kobj,
+    struct attribute *attr, char *buf, loff_t off, size_t count)
 {
 	struct scsi_qla_host *ha = to_qla_host(dev_to_shost(container_of(kobj,
 	    struct device, kobj)));
@@ -491,8 +491,8 @@
 	return (count);
 }
 
-static ssize_t qla2x00_sysfs_write_fw_dump(struct kobject *kobj, char *buf,
-    loff_t off, size_t count)
+static ssize_t qla2x00_sysfs_write_fw_dump(struct kobject *kobj,
+    struct attribute *attr, char *buf, loff_t off, size_t count)
 {
 	struct scsi_qla_host *ha = to_qla_host(dev_to_shost(container_of(kobj,
 	    struct device, kobj)));
@@ -546,8 +546,8 @@
 	return (count);
 }
 
-static ssize_t qla2x00_sysfs_read_nvram(struct kobject *kobj, char *buf,
-    loff_t off, size_t count)
+static ssize_t qla2x00_sysfs_read_nvram(struct kobject *kobj,
+    struct attribute *attr, char *buf, loff_t off, size_t count)
 {
 	struct scsi_qla_host *ha = to_qla_host(dev_to_shost(container_of(kobj,
 	    struct device, kobj)));
@@ -573,8 +573,8 @@
 	return (count);
 }
 
-static ssize_t qla2x00_sysfs_write_nvram(struct kobject *kobj, char *buf,
-    loff_t off, size_t count)
+static ssize_t qla2x00_sysfs_write_nvram(struct kobject *kobj,
+    struct attribute *attr, char *buf, loff_t off, size_t count)
 {
 	struct scsi_qla_host *ha = to_qla_host(dev_to_shost(container_of(kobj,
 	    struct device, kobj)));
===== drivers/video/aty/radeon_base.c 1.12 vs edited =====
--- 1.12/drivers/video/aty/radeon_base.c	Fri Mar  5 03:40:50 2004
+++ edited/drivers/video/aty/radeon_base.c	Sat Apr 10 15:35:04 2004
@@ -2014,7 +2014,8 @@
 }
 
 
-static ssize_t radeon_show_edid1(struct kobject *kobj, char *buf, loff_t off, size_t count)
+static ssize_t radeon_show_edid1(struct kobject *kobj, struct attribute *attr,
+                                 char *buf, loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2025,7 +2026,8 @@
 }
 
 
-static ssize_t radeon_show_edid2(struct kobject *kobj, char *buf, loff_t off, size_t count)
+static ssize_t radeon_show_edid2(struct kobject *kobj, struct attribute *attr,
+                                 char *buf, loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
===== drivers/zorro/zorro-sysfs.c 1.1 vs edited =====
--- 1.1/drivers/zorro/zorro-sysfs.c	Sun Jan 18 23:35:41 2004
+++ edited/drivers/zorro/zorro-sysfs.c	Sat Apr 10 15:35:55 2004
@@ -47,8 +47,8 @@
 
 static DEVICE_ATTR(resource, S_IRUGO, zorro_show_resource, NULL);
 
-static ssize_t zorro_read_config(struct kobject *kobj, char *buf, loff_t off,
-				 size_t count)
+static ssize_t zorro_read_config(struct kobject *kobj, struct attribute *attr,
+                                 char *buf, loff_t off, size_t count)
 {
 	struct zorro_dev *z = to_zorro_dev(container_of(kobj, struct device,
 					   kobj));
===== fs/sysfs/bin.c 1.12 vs edited =====
--- 1.12/fs/sysfs/bin.c	Fri Aug 29 10:40:51 2003
+++ edited/fs/sysfs/bin.c	Sat Apr 10 15:36:38 2004
@@ -20,7 +20,7 @@
 	struct bin_attribute * attr = dentry->d_fsdata;
 	struct kobject * kobj = dentry->d_parent->d_fsdata;
 
-	return attr->read(kobj, buffer, off, count);
+	return attr->read(kobj, &attr->attr, buffer, off, count);
 }
 
 static ssize_t
@@ -63,7 +63,7 @@
 	struct bin_attribute *attr = dentry->d_fsdata;
 	struct kobject *kobj = dentry->d_parent->d_fsdata;
 
-	return attr->write(kobj, buffer, offset, count);
+	return attr->write(kobj, &attr->attr, buffer, offset, count);
 }
 
 static ssize_t write(struct file * file, const char __user * userbuf,
===== include/linux/sysfs.h 1.32 vs edited =====
--- 1.32/include/linux/sysfs.h	Tue Aug 12 09:53:51 2003
+++ edited/include/linux/sysfs.h	Sat Apr 10 16:32:12 2004
@@ -21,8 +21,10 @@
 struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
-	ssize_t (*read)(struct kobject *, char *, loff_t, size_t);
-	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
+	ssize_t (*read)(struct kobject *, struct attribute *,
+	                char *, loff_t, size_t);
+	ssize_t (*write)(struct kobject *, struct attribute *,
+	                 char *, loff_t, size_t);
 };
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);


