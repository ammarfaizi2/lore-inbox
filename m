Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUDHTtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUDHTtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:49:53 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:49380 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262382AbUDHTtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:49:09 -0400
Subject: [PATCH] filling in ACPI method access via sysfs namespace
From: Alex Williamson <alex.williamson@hp.com>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1081453741.3398.77.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Apr 2004 13:49:02 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Here's a patch that adds object and control method access to devices
in the /sys/firmware/acpi/namespace/ACPI/ tree.  I sent out an RFC on
this approach several days ago and got a couple of good responses. 
Since then I've added a lot more methods, including several control
methods to allow you to do more than simply look at object properties.

   There are a lot of potential consumers of this type of data.  For
instance:

      * Laptop users may be able to access some of their 'hotkey'
        features from userspace (display switching, eject).
      * Servers and workstations can associate PCI buses, slots, address
        spaces, etc.
      * Hotplug tools could discover devices dependent on other devices
        prior to eject.
      * Manageability tools could have easy access to device
        identification and location methods.
      * etc...

   The code has been tried on several x86 and ia64 systems.  I expanded
the existing sysfs namespace to include devices which the _STA methods
do not list as present at bootup.  This helps to show things like
hotplug PCI slots that aren't currently in use and extra battery bays in
laptops that are vacant.  There are several methods that return complex
data structures.  I started trying to parse them into pretty text for
output, but the code bloat got too big too fast.  So, I've left that for
userspace tools and just dump the raw data via this interface.  Most
object methods return basic elements and are easily represented as
parsed text.  Also, fair warning: calling _EJ0 methods on devices may be
unsafe.  I've made the files only accessible by root to help avoid
issues in this area.  A couple fun things for laptop users (YMMV):

To eject from a dock (works on an omnibook 500, exact paths will vary):
echo 0 > /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/ISA0/JP1/_DCK
echo 1 > /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/ISA0/JP1/_EJ0

When re-docking, do:
echo 1 > /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/ISA0/JP1/_DCK

To switch displays (X can get in the way and prevent switching):
CRT only -> LCD only:
echo 0 > /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VGA/CRT/_DSS
echo 0x80000001 > /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VGA/LCD/_DSS
LCD only -> LCD+CRT:
echo 0x80000001 > /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VGA/CRT/_DSS
LCD+CRT -> CRT only:
echo 0x80000000 > /sys/firmware/acpi/namespace/ACPI/_SB/PCI0/AGP/VGA/LCD/_DSS
   
   It's highly dependent on how your firmware works as to how complete
the behavior will be.  I've seen a report from an IBM T30 that _EJ0 from
the dock won't trigger the electro-mechanical eject, but seems to do
most everything else.  Bug reports welcomed (but I can't fix your
firmware if it doesn't do what you expect).  Please consider integrating
upstream.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

===== drivers/acpi/scan.c 1.22 vs edited =====
--- 1.22/drivers/acpi/scan.c	Tue Feb  3 22:29:19 2004
+++ edited/drivers/acpi/scan.c	Thu Apr  8 11:59:36 2004
@@ -7,6 +7,7 @@
 
 #include <acpi/acpi_drivers.h>
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
+#include <acpi/actypes.h>
 
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
@@ -22,9 +23,364 @@
 #define ACPI_BUS_DRIVER_NAME		"ACPI Bus Driver"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
+#define METHOD_NAME__BCL		"_BCL"
+#define METHOD_NAME__BCM		"_BCM"
+#define METHOD_NAME__DCK		"_DCK"
+#define METHOD_NAME__DCS		"_DCS"
+#define METHOD_NAME__DGS		"_DGS"
+#define METHOD_NAME__DDN		"_DDN"
+#define METHOD_NAME__DSS		"_DSS"
+#define METHOD_NAME__DOS		"_DOS"
+#define METHOD_NAME__DOD		"_DOD"
+#define METHOD_NAME__EDL		"_EDL"
+#define METHOD_NAME__EJ0		"_EJ0"
+#define METHOD_NAME__EJD		"_EJD"
+#define METHOD_NAME__FIX		"_FIX"
+#define METHOD_NAME__HPP		"_HPP"
+#define METHOD_NAME__LCK		"_LCK"
+#define METHOD_NAME__LID		"_LID"
+#define METHOD_NAME__MAT		"_MAT"
+#define METHOD_NAME__PXM		"_PXM"
+#define METHOD_NAME__RMV		"_RMV"
+#define METHOD_NAME__STR		"_STR"
+#define METHOD_NAME__SUN		"_SUN"
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
+	length += 2;
+	return snprintf(buf, length, "%s\n", pointer);
+}
+
+static ssize_t
+parse_buffer(char *buf, u32 length, u8 *pointer, unsigned int flags) {
+	ssize_t offset = 0;
+
+	if (flags & UNICODE_TYPE) {
+		for (; length > 0 ; length -= 2) {
+			buf[offset++] = *pointer;
+			pointer += 2;
+		}
+	} else {
+		for (; length > 0 ; length--) {
+			sprintf(buf + offset, "%02x", *pointer);
+			offset += 2;
+			pointer++;
+		}
+	}
+	buf[offset++] = '\n';
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
+	    || !strcmp(method, METHOD_NAME__CID)
+	    || !strcmp(method, METHOD_NAME__FIX))
+		flags = EISA_ID_TYPE;
+
+	if (!strcmp(method, METHOD_NAME__STR))
+		flags = UNICODE_TYPE;
+
+	element = (union acpi_object *) buffer.pointer;
+	retval = parse_element(buf, element, flags);
+	acpi_os_free(buffer.pointer);
+
+	return retval;
+}
+
+static ssize_t
+acpi_device_read_raw(struct acpi_device *device, char *method, char *buf)
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
+acpi_device_read_crs(struct acpi_device *device, char *method, char *buf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	status = acpi_get_current_resources(device->handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	memcpy(buf, buffer.pointer, buffer.length);
+	acpi_os_free(buffer.pointer);
+	return buffer.length;
+}
+
+static ssize_t
+acpi_device_read_prs(struct acpi_device *device, char *method, char *buf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	status = acpi_get_possible_resources(device->handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	memcpy(buf, buffer.pointer, buffer.length);
+	acpi_os_free(buffer.pointer);
+	return buffer.length;
+}
+
+static ssize_t
+acpi_device_read_prt(struct acpi_device *device, char *method, char *buf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	status = acpi_get_irq_routing_table(device->handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	memcpy(buf, buffer.pointer, buffer.length);
+	acpi_os_free(buffer.pointer);
+	return buffer.length;
+}
+
+static ssize_t
+acpi_device_write_integer (
+	struct acpi_device	*device,
+	char			*method,
+	const char		*buf,
+	size_t			length)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	int value;
+
+	value = simple_strtol(buf, NULL, 0);
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = value;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(device->handle, method, &arg_list, NULL)))
+		return -ENODEV;
+	
+	return length;
+}
+
+#define acpi_handle_attr_rw(method, show_func, store_func) \
+static struct acpi_handle_attribute acpi_handle_attr##method = { \
+	.attr = {.name = METHOD_NAME_##method, \
+	         .mode = S_IFREG | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP}, \
+	.show = show_func, \
+	.store = store_func, \
+};
+
+#define acpi_handle_attr_ro(method, show_func) \
+static struct acpi_handle_attribute acpi_handle_attr##method = { \
+	.attr = {.name = METHOD_NAME_##method, \
+	         .mode = S_IFREG | S_IRUSR | S_IRGRP}, \
+	.show = show_func, \
+};
+
+#define acpi_handle_attr_wo(method, store_func) \
+static struct acpi_handle_attribute acpi_handle_attr##method = { \
+	.attr = {.name = METHOD_NAME_##method, \
+	         .mode = S_IFREG | S_IWUSR | S_IWGRP}, \
+	.store = store_func, \
+};
+
+acpi_handle_attr_ro(_ADR, acpi_device_read_file)
+acpi_handle_attr_ro(_BBN, acpi_device_read_file)
+acpi_handle_attr_ro(_BCL, acpi_device_read_file)
+acpi_handle_attr_wo(_BCM, acpi_device_write_integer)
+acpi_handle_attr_ro(_CID, acpi_device_read_file)
+acpi_handle_attr_ro(_CRS, acpi_device_read_crs)
+acpi_handle_attr_wo(_DCK, acpi_device_write_integer)
+acpi_handle_attr_ro(_DCS, acpi_device_read_file)
+acpi_handle_attr_ro(_DGS, acpi_device_read_file)
+acpi_handle_attr_ro(_DDN, acpi_device_read_file)
+acpi_handle_attr_wo(_DSS, acpi_device_write_integer)
+acpi_handle_attr_wo(_DOS, acpi_device_write_integer)
+acpi_handle_attr_ro(_DOD, acpi_device_read_file)
+acpi_handle_attr_ro(_EDL, acpi_device_read_file)
+acpi_handle_attr_wo(_EJ0, acpi_device_write_integer)
+acpi_handle_attr_ro(_EJD, acpi_device_read_file)
+acpi_handle_attr_ro(_FIX, acpi_device_read_file)
+acpi_handle_attr_ro(_HID, acpi_device_read_file)
+acpi_handle_attr_ro(_HPP, acpi_device_read_file)
+acpi_handle_attr_wo(_LCK, acpi_device_write_integer)
+acpi_handle_attr_ro(_LID, acpi_device_read_file)
+acpi_handle_attr_ro(_MAT, acpi_device_read_raw)
+acpi_handle_attr_ro(_PRS, acpi_device_read_prs)
+acpi_handle_attr_ro(_PRT, acpi_device_read_prt)
+acpi_handle_attr_ro(_PXM, acpi_device_read_file)
+acpi_handle_attr_ro(_RMV, acpi_device_read_file)
+acpi_handle_attr_ro(_SEG, acpi_device_read_file)
+acpi_handle_attr_ro(_STA, acpi_device_read_file)
+acpi_handle_attr_ro(_STR, acpi_device_read_file)
+acpi_handle_attr_ro(_SUN, acpi_device_read_file)
+acpi_handle_attr_ro(_UID, acpi_device_read_file)
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
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__BCL, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_BCL.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__BCM, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_BCM.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__CID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_CID.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__CRS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_CRS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DCK, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DCK.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DCS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DCS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DGS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DGS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DDN, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DDN.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DSS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DSS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DOS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DOS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__DOD, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_DOD.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__EDL, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_EDL.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__EJ0, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_EJ0.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__EJD, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_EJD.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__FIX, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_FIX.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__HID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_HID.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__HPP, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_HPP.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__LCK, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_LCK.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__LID, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_LID.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__MAT, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_MAT.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__PRS, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_PRS.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__PRT, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_PRT.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__PXM, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_PXM.attr);
+	if (ACPI_SUCCESS(acpi_get_handle(dev->handle, METHOD_NAME__RMV, &tmp)))
+		(*(func))(&dev->kobj, &acpi_handle_attr_RMV.attr);
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
@@ -33,7 +389,32 @@
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
+	return attribute->store ? attribute->store(device, attribute->attr.name, buf, len) : len;
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
 
@@ -72,6 +453,7 @@
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_add(&device->kobj);
+	create_sysfs_files(device);
 }
 
 static int
@@ -79,6 +461,7 @@
 	struct acpi_device	*device, 
 	int			type)
 {
+	remove_sysfs_files(device);
 	kobject_unregister(&device->kobj);
 	return 0;
 }
@@ -706,7 +1089,7 @@
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result) || !device->status.present) {
+		if (ACPI_FAILURE(result)) {
 			result = -ENOENT;
 			goto end;
 		}


