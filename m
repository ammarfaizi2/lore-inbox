Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263882AbUDFP7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUDFP7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:59:14 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:27825 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S263882AbUDFP4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:56:32 -0400
Subject: [RFC] filling in ACPI files in sysfs
From: Alex Williamson <alex.williamson@hp.com>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1081266989.2375.35.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Apr 2004 09:56:30 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Seems like it's about time the ACPI sysfs namespace started doing
more than looking pretty.  Here's a stab at adding in some basic
functionality.  I'd like to get some feedback before I start filling in
the more complicated features.  This has been lightly tested on a
sampling of HP ia64 boxes.  Does this seem like a reasonable start? 
Comments and reports from other platforms welcome.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

===== drivers/acpi/scan.c 1.22 vs edited =====
--- 1.22/drivers/acpi/scan.c	Tue Feb  3 22:29:19 2004
+++ edited/drivers/acpi/scan.c	Tue Apr  6 09:15:29 2004
@@ -7,6 +7,7 @@
 
 #include <acpi/acpi_drivers.h>
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
+#include <acpi/actypes.h>
 
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
@@ -22,9 +23,184 @@
 #define ACPI_BUS_DRIVER_NAME		"ACPI Bus Driver"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
+#define METHOD_NAME__DDN		"_DDN"
+#define METHOD_NAME__SUN		"_SUN"
+#define METHOD_NAME__STR		"_STR"
+
 static LIST_HEAD(acpi_device_list);
 static spinlock_t acpi_device_lock = SPIN_LOCK_UNLOCKED;
 
+struct acpi_handle_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct acpi_device *, char *, char *);
+	ssize_t (*store)(struct acpi_device *, char *, const char *, size_t);
+};
+
+#define EISA_ID_TYPE (1<<0)
+#define UNICODE_TYPE (1<<1)
+
+static ssize_t
+parse_integer(char *buf, u32 value, unsigned int flags) {
+	if (flags & EISA_ID_TYPE) {
+		acpi_ex_eisa_id_to_string(value, buf);
+		buf[8] = '\n';
+		return 9;
+	}
+	return sprintf(buf, "%08x\n", value);
+}
+
+static ssize_t
+parse_string(char *buf, u32 length, char *pointer, unsigned int flags) {
+	snprintf(buf, length, "%s", pointer);
+	buf[length] = '\n';
+	return length + 1;
+}
+
+static ssize_t
+parse_buffer(char *buf, u32 length, u8 *pointer, unsigned int flags) {
+	ssize_t offset = 0;
+
+	if (flags & UNICODE_TYPE) {
+		for (; length > 0 ; length -= 2) {
+			sprintf(buf + offset, "%c", *pointer);
+			offset++;
+			pointer += 2;
+		}
+	} else {
+		for (; length > 0 ; length--) {
+			sprintf(buf + offset, "%02x", *pointer);
+			offset += 2;
+			pointer++;
+		}
+	}
+	sprintf(buf + offset++, "\n");
+	return offset;
+}
+
+static ssize_t parse_package(char *, union acpi_object *, unsigned int);
+
+static ssize_t
+parse_element(
+	char			*buf,
+	union acpi_object	*element,
+	unsigned int		flags)
+{
+
+	switch (element->type) {
+		case ACPI_TYPE_INTEGER:
+			return parse_integer(buf, element->integer.value, flags);
+		case ACPI_TYPE_STRING:
+			return parse_string(buf, element->string.length,
+			                    element->string.pointer, flags);
+		case ACPI_TYPE_BUFFER:
+			return parse_buffer(buf, element->buffer.length,
+			                   element->buffer.pointer, flags);
+		case ACPI_TYPE_PACKAGE:
+			return parse_package(buf, element, flags);
+		default:
+			return sprintf(buf, "Unknown Type: %d\n", element->type);
+	}
+}
+
+static ssize_t
+parse_package(char *buf, union acpi_object *element, unsigned int flags) {
+	int count = element->package.count;
+	ssize_t tmp, retval = 0;
+
+	element = element->package.elements;
+
+	for (; count > 0 ; count--, element++) {
+		tmp = parse_element(buf, element, flags);
+		buf += tmp;
+		retval += tmp;
+	}
+	return retval;
+}
+
+static ssize_t
+acpi_device_read_file (
+	struct acpi_device	*device,
+	char			*method,
+	char			*buf)
+{
+	acpi_status status;
+	union acpi_object *element;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	ssize_t retval = 0;
+	unsigned int flags = 0;
+
+	status = acpi_evaluate_object(device->handle, method, NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+	
+	if (!strcmp(method, METHOD_NAME__HID)
+	    || !strcmp(method, METHOD_NAME__CID))
+		flags |= EISA_ID_TYPE;
+
+	if (!strcmp(method, METHOD_NAME__STR))
+		flags |= UNICODE_TYPE;
+
+	element = (union acpi_object *) buffer.pointer;
+	retval = parse_element(buf, element, flags);
+	acpi_os_free(element);
+	return retval;
+}
+
+#define acpi_handle_attr(method, show_func, store_func) \
+static struct acpi_handle_attribute acpi_handle_attr##method = { \
+	.attr = {.name = METHOD_NAME_##method, .mode = S_IFREG | S_IRUGO}, \
+	.show = show_func, \
+	.store = store_func, \
+};
+
+acpi_handle_attr(_ADR, acpi_device_read_file, NULL)
+acpi_handle_attr(_BBN, acpi_device_read_file, NULL)
+acpi_handle_attr(_CID, acpi_device_read_file, NULL)
+acpi_handle_attr(_DDN, acpi_device_read_file, NULL)
+acpi_handle_attr(_HID, acpi_device_read_file, NULL)
+acpi_handle_attr(_SEG, acpi_device_read_file, NULL)
+acpi_handle_attr(_STA, acpi_device_read_file, NULL)
+acpi_handle_attr(_STR, acpi_device_read_file, NULL)
+acpi_handle_attr(_SUN, acpi_device_read_file, NULL)
+acpi_handle_attr(_UID, acpi_device_read_file, NULL)
+
+typedef void acpi_device_sysfs_files(struct kobject *,
+                                     const struct attribute *);
+
+static void
+setup_sys_fs_files (
+	struct acpi_device *dev,
+	acpi_device_sysfs_files *func)
+{
+	acpi_handle tmp = NULL;
+
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__ADR, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_ADR.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__BBN, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_BBN.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__CID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_CID.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DDN, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DDN.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__HID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_HID.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__SEG, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_SEG.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__STA, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_STA.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__STR, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_STR.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__SUN, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_SUN.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__UID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_UID.attr);
+}
+
+#define create_sysfs_files(dev) \
+	setup_sys_fs_files(dev, (acpi_device_sysfs_files *)&sysfs_create_file)
+#define remove_sysfs_files(dev) \
+	setup_sys_fs_files(dev, &sysfs_remove_file)
+
 static void acpi_device_release(struct kobject * kobj)
 {
 	struct acpi_device * dev = container_of(kobj,struct acpi_device,kobj);
@@ -33,7 +209,32 @@
 	kfree(dev);
 }
 
+#define to_acpi_device(n) container_of(n, struct acpi_device, kobj)
+#define to_handle_attr(n) container_of(n, struct acpi_handle_attribute, attr);
+
+static ssize_t acpi_device_attr_show(struct kobject *kobj,
+                struct attribute *attr, char *buf)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_handle_attribute *attribute = to_handle_attr(attr);
+	return attribute->show ? attribute->show(device, attribute->attr.name, buf) : 0;
+}
+
+static ssize_t acpi_device_attr_store(struct kobject *kobj,
+                struct attribute *attr, const char *buf, size_t len)
+{
+	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_handle_attribute *attribute = to_handle_attr(attr);
+	return attribute->store ? attribute->store(device, attribute->attr.name, buf, len) : 0;
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
 
@@ -72,6 +273,7 @@
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_add(&device->kobj);
+	create_sysfs_files(device);
 }
 
 static int
@@ -79,6 +281,7 @@
 	struct acpi_device	*device, 
 	int			type)
 {
+	remove_sysfs_files(device);
 	kobject_unregister(&device->kobj);
 	return 0;
 }
	

