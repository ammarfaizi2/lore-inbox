Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUDIWWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUDIWWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 18:22:34 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:43952 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261802AbUDIWV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 18:21:59 -0400
Subject: Re: [PATCH] filling in ACPI method access via sysfs namespace
From: Alex Williamson <alex.williamson@hp.com>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1081453741.3398.77.camel@patsy.fc.hp.com>
References: <1081453741.3398.77.camel@patsy.fc.hp.com>
Content-Type: text/plain
Message-Id: <1081549317.2694.25.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Apr 2004 16:21:57 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Here's another approach that's far less ugly than the last and is
much more powerful.  The code is a little over half the size as a
bonus.  Rather than specifically poking for certain methods and exposing
them, this patch exposes everything.  The down side is that all reading
and writing of the files need to use binary acpi data structures.  This
interface certainly provides "shoot yourself in the foot" potential, but
the access to the namespace from userspace is hard to beat.  Any
thoughts on this approach versus the last?  This interface and a simple
set of libraries to go along with it has a lot of potential.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

===== drivers/acpi/scan.c 1.22 vs edited =====
--- 1.22/drivers/acpi/scan.c	Tue Feb  3 22:29:19 2004
+++ edited/drivers/acpi/scan.c	Fri Apr  9 16:06:54 2004
@@ -25,6 +25,185 @@
 static LIST_HEAD(acpi_device_list);
 static spinlock_t acpi_device_lock = SPIN_LOCK_UNLOCKED;
 
+struct acpi_handle_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct acpi_device *, char *, char *);
+	ssize_t (*store)(struct acpi_device *, char *, const char *, size_t);
+};
+
+static ssize_t
+acpi_device_read_raw(
+	struct acpi_device	*device,
+	char			*method,
+	char			*buf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	status = acpi_evaluate_object(device->handle, method, NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	memcpy(buf, buffer.pointer, buffer.length);
+	acpi_os_free(buffer.pointer);
+	return buffer.length;
+}
+
+static ssize_t
+acpi_device_write_raw(
+	struct acpi_device	*device,
+	char			*method,
+	const char		*buf,
+	size_t			length)
+{
+	struct acpi_object_list *arg_list;
+	union acpi_object *args, **cur_arg;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status status;
+	u32 count, i;
+	size_t size;
+
+	args = kmalloc(length, GFP_KERNEL);
+	if (!args)
+		return -ENODEV;
+
+	memcpy(args, buf, length);
+
+	count = length / sizeof(union acpi_object);
+
+	size = sizeof(struct acpi_object_list) +
+	       ((count - 1) * sizeof(union acpi_object *));
+
+	arg_list = kmalloc(size, GFP_KERNEL);
+	if (!arg_list) {
+		kfree(args);
+		return -ENODEV;
+	}
+
+	memset(arg_list, 0, size);
+	arg_list->count = count;
+
+	cur_arg = &arg_list->pointer;
+	for (i = 0 ; i < count ; i++)
+		cur_arg[i] = &args[i];
+
+	status = acpi_evaluate_object(device->handle, method, arg_list,
+	                              &buffer);
+	kfree(arg_list);
+	kfree(args);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	/* TODO: how to return this? */
+	if (buffer.pointer)
+		acpi_os_free(buffer.pointer);
+
+	return length;
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
@@ -33,7 +212,31 @@
 	kfree(dev);
 }
 
+static ssize_t acpi_device_attr_show(struct kobject *kobj,
+                struct attribute *attr, char *buf)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_handle_attribute *attribute = to_handle_attr(attr);
+	return attribute->show ?
+	       attribute->show(device, attribute->attr.name, buf) : 0;
+}
+
+static ssize_t acpi_device_attr_store(struct kobject *kobj,
+                struct attribute *attr, const char *buf, size_t len)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_handle_attribute *attribute = to_handle_attr(attr);
+	return attribute->store ?
+	       attribute->store(device, attribute->attr.name, buf, len) : 0;
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
 
@@ -72,6 +275,7 @@
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_add(&device->kobj);
+	create_sysfs_files(device);
 }
 
 static int
@@ -79,6 +283,7 @@
 	struct acpi_device	*device, 
 	int			type)
 {
+	remove_sysfs_files(device);
 	kobject_unregister(&device->kobj);
 	return 0;
 }
@@ -706,7 +911,7 @@
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result) || !device->status.present) {
+		if (ACPI_FAILURE(result)) {
 			result = -ENOENT;
 			goto end;
 		}


