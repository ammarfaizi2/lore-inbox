Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUDJFcu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 01:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUDJFcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 01:32:50 -0400
Received: from mailhub.hp.com ([192.151.27.10]:23480 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S261947AbUDJFc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 01:32:29 -0400
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs
	namespace
From: Alex Williamson <alex.williamson@hp.com>
To: John Belmonte <john@neggie.net>
Cc: acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1081566768.2562.8.camel@wilson.home.net>
References: <1081453741.3398.77.camel@patsy.fc.hp.com>
	 <1081549317.2694.25.camel@patsy.fc.hp.com>  <4077535D.6020403@neggie.net>
	 <1081566768.2562.8.camel@wilson.home.net>
Content-Type: text/plain
Message-Id: <1081575145.2562.18.camel@wilson.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Apr 2004 23:32:26 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-09 at 21:12, Alex Williamson wrote:

> We could make the store function save off the method
> parameters, then the show function would call the method with the saved
> parameters and return the results.  Obviously there are some userspace
> ordering issues that could make this complicated, but it's easy to code
> on the kernel side.

   Here's an implementation of this.  It's a little klunky, but
certainly fills in the functionality.

	Alex

===== drivers/acpi/scan.c 1.22 vs edited =====
--- 1.22/drivers/acpi/scan.c	Tue Feb  3 22:29:19 2004
+++ edited/drivers/acpi/scan.c	Fri Apr  9 23:02:48 2004
@@ -25,6 +25,208 @@
 static LIST_HEAD(acpi_device_list);
 static spinlock_t acpi_device_lock = SPIN_LOCK_UNLOCKED;
 
+struct acpi_handle_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct acpi_device *, struct acpi_handle_attribute *, char *);
+	ssize_t (*store)(struct acpi_device *, struct acpi_handle_attribute *, const char *, size_t);
+	union acpi_object *args;
+	size_t length;
+	spinlock_t lock;
+};
+
+static ssize_t
+acpi_device_write_raw(
+	struct acpi_device		*device,
+	struct acpi_handle_attribute	*attrib,
+	const char			*buf,
+	size_t				length)
+{
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
+	struct acpi_device		*device,
+	struct acpi_handle_attribute	*attrib,
+	char				*buf)
+{
+	struct acpi_object_list *arg_list = NULL;
+	union acpi_object **cur_arg, *args = NULL;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status status;
+	u32 count, i;
+	size_t size;
+
+	spin_lock(&attrib->lock);
+	count = attrib->length / sizeof(union acpi_object);
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
+		args = kmalloc(attrib->length, GFP_KERNEL);
+		if (!args) {
+			kfree(arg_list);
+			spin_unlock(&attrib->lock);
+			return -ENODEV;
+		}
+		memcpy(args, attrib->args, attrib->length);
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
+	memcpy(buf, buffer.pointer, buffer.length);
+	acpi_os_free(buffer.pointer);
+
+	return buffer.length;
+}
+
+#define to_acpi_device(n) container_of(n, struct acpi_device, kobj)
+#define to_handle_attr(n) container_of(n, struct acpi_handle_attribute, attr);
+
+static void
+create_sysfs_files(struct acpi_device *dev)
+{
+	acpi_handle                  chandle = 0;
+	char                         pathname[ACPI_PATHNAME_MAX];
+	acpi_status                  status;
+	struct acpi_buffer           buffer;
+	struct acpi_handle_attribute *attrib;
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
+		attrib->attr.mode = S_IFREG | S_IRUSR |
+		                    S_IWUSR | S_IRGRP | S_IWGRP;
+		attrib->show = acpi_device_read_raw;
+		attrib->store = acpi_device_write_raw;
+		spin_lock_init(&attrib->lock);
+
+		error = sysfs_create_file(&dev->kobj, &attrib->attr);
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
+	struct acpi_handle_attribute attrib, *old_attrib;
+	struct attribute             *old_attr;
+	struct dentry                *dentry;
+
+	buffer.length = sizeof(pathname);
+	buffer.pointer = pathname;
+	attrib.attr.name = pathname;
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
+			old_attr = dentry->d_fsdata;
+		else
+			old_attr = NULL;
+		up(&(dev->kobj.dentry->d_inode->i_sem));
+		
+		sysfs_remove_file(&dev->kobj, &attrib.attr);
+
+		if (old_attr) {
+			if (strncmp(pathname, old_attr->name,
+			    strlen(pathname)) != 0)
+				continue;
+
+			old_attrib = to_handle_attr(old_attr);
+			kfree(old_attr->name);
+			kfree(old_attrib);
+		}
+	}
+}
+
 static void acpi_device_release(struct kobject * kobj)
 {
 	struct acpi_device * dev = container_of(kobj,struct acpi_device,kobj);
@@ -33,7 +235,31 @@
 	kfree(dev);
 }
 
+static ssize_t acpi_device_attr_show(struct kobject *kobj,
+                struct attribute *attr, char *buf)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_handle_attribute *attribute = to_handle_attr(attr);
+	return attribute->show ?
+	       attribute->show(device, attribute, buf) : 0;
+}
+
+static ssize_t acpi_device_attr_store(struct kobject *kobj,
+                struct attribute *attr, const char *buf, size_t len)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_handle_attribute *attribute = to_handle_attr(attr);
+	return attribute->store ?
+	       attribute->store(device, attribute, buf, len) : 0;
+}
+
+static struct sysfs_ops acpi_device_sysfs_ops = {
+	.show = acpi_device_attr_show,
+	.store = acpi_device_attr_store,
+};
+
 static struct kobj_type ktype_acpi_ns = {
+	.sysfs_ops	= &acpi_device_sysfs_ops,
 	.release	= acpi_device_release,
 };
 
@@ -72,6 +298,7 @@
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_add(&device->kobj);
+	create_sysfs_files(device);
 }
 
 static int
@@ -79,6 +306,7 @@
 	struct acpi_device	*device, 
 	int			type)
 {
+	remove_sysfs_files(device);
 	kobject_unregister(&device->kobj);
 	return 0;
 }
@@ -706,7 +934,7 @@
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result) || !device->status.present) {
+		if (ACPI_FAILURE(result)) {
 			result = -ENOENT;
 			goto end;
 		}


