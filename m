Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUITVng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUITVng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUITVng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:43:36 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:14307 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S267368AbUITVky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:40:54 -0400
Subject: [PATCH/RFC] exposing ACPI objects in sysfs
From: Alex Williamson <alex.williamson@hp.com>
To: acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 20 Sep 2004 15:41:16 -0600
Message-Id: <1095716476.5360.61.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I've lost track of how many of these patches I've done, but here's
the much anticipated next revision ;^)  The purpose of this patch is to
expose ACPI objects in the already existing namespace in sysfs
(/sys/firmware/acpi/namespace/ACPI).  There's a lot of information
currently available in ACPI namespace, but no way to get at it from
userspace.  What's new in this version:

      * Untied from acpi_bus_scan() to be made standalone - loadable as
        a module now!
      * Removed some questionable interfaces (arg count, saving and re-
        loading AML).  If you don't know how many args a method takes,
        don't call it.  The other stuff was likely far too dangerous
        anyway.
      * Re-worked the writing of method parameters.  Now users should
        write an acpi_object_list structure to the object.  All pointers
        should be replaced by offsets into the buffer, just like return
        buffers, packages and strings previously
      * Added "nonstd" and "dangerous" module options to limit what
        namespace objects get exposed.  I'm sure these need refinement,
        but at least a little protection from shooting yourself in the
        foot.
      * Numerous fixes and cleanups

   Changes to existing kernel code are pretty trivial now.  The major
change is adding open() and release() functions to the sysfs bin_file
support.  This allows backing store on a per-open basis, and eliminates
multiple reader/writer problems.  Besides, it seems reasonable for a
file entry to able to have a little more control over it's private_data
structure.

  The other generic kernel change is to export acpi_os_allocate(). This
is because I chose to use acpi_buffers for internal management and
wanted a consistent alloc/free interface for them.  I'd be happy to
separate these into individual patches if they're acceptable.

   I'll try to make my debug utility available shortly so people can
poke around on their systems and see what's available.  For a lot of
things, using xxd to dump the object provides some info and is
sufficient for _ON/_OFF type methods.  Let me know if you have any
feedback or bug reports.  Patch is against current bitkeeper, but should
apply against almost anything recent.  Thanks,

	Alex

PS - I added a version interface, but please don't consider anything
stable at this point.

-- 
Alex Williamson                             HP Linux & Open Source Lab

 drivers/acpi/Kconfig                |    9 
 drivers/acpi/Makefile               |    1 
 drivers/acpi/acpi_ksyms.c           |    1 
 fs/sysfs/bin.c                      |   13 
 include/linux/sysfs.h               |    2 
 drivers/acpi/acpi_sysfs.c           |  884 ++++++++++++++++++++++++++++++++++++

===== drivers/acpi/Kconfig 1.32 vs edited =====
--- 1.32/drivers/acpi/Kconfig	Mon Apr  5 04:54:30 2004
+++ edited/drivers/acpi/Kconfig	Tue Sep 14 21:04:15 2004
@@ -270,5 +270,14 @@
 	  kernel logs, and/or you are using this on a notebook which
 	  does not yet have an HPET, you should say "Y" here.
 
+config ACPI_SYSFS
+	tristate "ACPI object support in sysfs"
+	depends on EXPERIMENTAL && ACPI
+	default m
+	help
+	  This driver adds support for exposing ACPI objects in sysfs.
+	  Reading and writing the objects can preform operations allowing
+	  userspace to interact with ACPI namespace.
+       
 endmenu
 
===== drivers/acpi/Makefile 1.37 vs edited =====
--- 1.37/drivers/acpi/Makefile	Thu May 20 00:36:01 2004
+++ edited/drivers/acpi/Makefile	Tue Sep 14 21:04:15 2004
@@ -48,3 +48,4 @@
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
+obj-$(CONFIG_ACPI_SYSFS)	+= acpi_sysfs.o
===== drivers/acpi/acpi_ksyms.c 1.28 vs edited =====
--- 1.28/drivers/acpi/acpi_ksyms.c	Thu Jul 15 02:05:19 2004
+++ edited/drivers/acpi/acpi_ksyms.c	Tue Sep 14 21:04:15 2004
@@ -98,6 +98,7 @@
 
 /* ACPI OS Services Layer (acpi_osl.c) */
 
+EXPORT_SYMBOL(acpi_os_allocate);
 EXPORT_SYMBOL(acpi_os_free);
 EXPORT_SYMBOL(acpi_os_printf);
 EXPORT_SYMBOL(acpi_os_sleep);
===== fs/sysfs/bin.c 1.14 vs edited =====
--- 1.14/fs/sysfs/bin.c	Wed Apr 14 12:26:50 2004
+++ edited/fs/sysfs/bin.c	Tue Sep 14 21:04:16 2004
@@ -113,7 +113,11 @@
 		goto Error;
 
 	error = -ENOMEM;
-	file->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (attr->open)
+		file->private_data = attr->open(kobj, &attr->attr);
+	else
+		file->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
 	if (!file->private_data)
 		goto Error;
 
@@ -137,7 +141,12 @@
 	if (kobj) 
 		kobject_put(kobj);
 	module_put(attr->attr.owner);
-	kfree(buffer);
+
+	if (attr->release)
+		attr->release(kobj, &attr->attr, buffer);
+	else
+		kfree(buffer);
+
 	return 0;
 }
 
===== include/linux/sysfs.h 1.37 vs edited =====
--- 1.37/include/linux/sysfs.h	Thu Jun  3 11:27:09 2004
+++ edited/include/linux/sysfs.h	Tue Sep 14 21:04:17 2004
@@ -50,6 +50,8 @@
 	size_t			size;
 	ssize_t (*read)(struct kobject *, char *, loff_t, size_t);
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
+	char    *(*open)(struct kobject *, struct attribute *);
+	void    (*release)(struct kobject *, struct attribute *, char *);
 };
 
 struct sysfs_ops {
--- /dev/null	2004-09-20 13:55:57.000000000 -0600
+++ linux-2.5/drivers/acpi/acpi_sysfs.c	2004-09-20 13:31:25.000000000 -0600
@@ -0,0 +1,884 @@
+/*
+ * acpi_sysfs.c - support for exposing ACPI namespace objects in sysfs
+ *
+ * Copyright (C) 2004 Hewlett-Packard Development Company, LP
+ * Copyright (C) 2004 Alex Williamson <alex.williamson@hp.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#define ACPI_SYSFS_COMPONENT	0x08000000
+#define _COMPONENT		ACPI_SYSFS_COMPONENT
+ACPI_MODULE_NAME		("acpi_sysfs")
+
+static unsigned int acpi_sysfs_nonstd;
+module_param_named(nonstd, acpi_sysfs_nonstd, bool, 0);
+MODULE_PARM_DESC(nonstd, "Expose non-standard objects");
+
+static unsigned int acpi_sysfs_dangerous;
+module_param_named(dangerous, acpi_sysfs_dangerous, bool, 0);
+MODULE_PARM_DESC(dangerous, "Expose \"dangerous\" objects");
+
+/* These probably need to go in a header file if this goes live */
+#define ACPI_SYSFS_MAJOR	0
+#define ACPI_SYSFS_MINOR	1
+
+#define VERSION			0x0
+#define GET_TYPE		0x1
+#define GET_PTYPE		0x2
+
+static LIST_HEAD(acpi_bin_file_list);
+static spinlock_t acpi_bin_file_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * Keep a list of created bin_attribs, there's a lot of reuse
+ * potential since common names will be repeated often.  use_count
+ * should only be touched when holding the lock above, so it doesn't
+ * need to be an atomic.
+ */
+struct acpi_bin_files {
+	struct list_head	list;
+	struct bin_attribute	bin_attrib;
+	u32			use_count;
+};
+
+/*
+ * A simple page size buffer doesn't cut it for this interface, but
+ * it needs to be at the top of the structure to stay compatible
+ * with existing code.  The attribute name gets stuffed in here so
+ * we don't have to modify the read/write routines.
+ */
+struct acpi_private_data {
+	char			buf[PAGE_SIZE];
+	char			*name;
+	struct acpi_buffer	write_buf;
+	struct acpi_buffer	read_buf;
+};
+
+struct special_cmd {
+	u32			magic;
+	unsigned int		cmd;
+	char			*args;
+};
+
+#define to_acpi_device(n) container_of(n, struct acpi_device, kobj)
+#define WBUF(x) (&x->write_buf)
+#define RBUF(x) (&x->read_buf)
+
+#define TO_POINTER 0
+#define TO_OFFSET 1
+
+static int
+range_ok(void *ptr, struct acpi_buffer *range, ssize_t size)
+{
+	ACPI_FUNCTION_TRACE("range_ok");
+
+	if ((unsigned long)ptr < (unsigned long)range->pointer)
+		return 0;
+	if ((unsigned long)ptr + size >
+	    (unsigned long)range->pointer + range->length)
+		return 0;
+
+	return 1;
+}
+
+/*
+ * The next few function are meant to replaces pointers in data structures
+ * with offsets or vica versa.  It's important to check the range to make
+ * sure a malicious program doesn't try to send us off somewhere else.
+ */
+static void *
+fixup_pointer(
+	struct acpi_buffer	*range,
+	void			*off,
+	int			direction)
+{
+	ACPI_FUNCTION_TRACE("fixup_pointer");
+
+	if (direction == TO_POINTER)
+		return (void *)((unsigned long)range->pointer +
+		                (unsigned long)off);
+	else
+		return (void *)((unsigned long)off -
+		                (unsigned long)range->pointer);
+}
+
+static int
+fixup_string(
+	union acpi_object	*obj,
+	struct acpi_buffer	*range,
+	int			direction)
+{
+	char **pointer = &obj->string.pointer;
+
+	ACPI_FUNCTION_TRACE("fixup_string");
+
+	if (direction == TO_OFFSET) {
+		if (!range_ok(*pointer, range, obj->string.length))
+			return 0;
+	}
+
+	*pointer = fixup_pointer(range, *pointer, direction);
+
+	if (direction == TO_POINTER) {
+		if (!range_ok(*pointer, range, obj->string.length))
+			return 0;
+	}
+	return 1;
+}
+
+static int
+fixup_buffer(
+	union acpi_object	*obj,
+	struct acpi_buffer	*range,
+	int			direction)
+{
+	unsigned char **pointer = &obj->buffer.pointer;
+
+	ACPI_FUNCTION_TRACE("fixup_buffer");
+
+	if (direction == TO_OFFSET) {
+		if (!range_ok(*pointer, range, obj->buffer.length))
+			return 0;
+	}
+
+	*pointer = fixup_pointer(range, *pointer, direction);
+
+	if (direction == TO_POINTER) {
+		if (!range_ok(*pointer, range, obj->buffer.length))
+			return 0;
+	}
+	return 1;
+}
+
+static int fixup_package(union acpi_object *, struct acpi_buffer *, int);
+
+/*
+ * strings, buffers, and packages contain pointers.  These should just
+ * be pointing further down in the buffer, so before passing to user
+ * space, change the pointers into offsets from the beginning of the buffer.
+ */
+static int
+fixup_element(
+	union acpi_object	*obj,
+	struct acpi_buffer	*range,
+	int			direction)
+{
+	ACPI_FUNCTION_TRACE("fixup_element");
+
+	if (!obj)
+		return 0;
+
+	switch (obj->type) {
+		case ACPI_TYPE_STRING:
+			return fixup_string(obj, range, direction);
+		case ACPI_TYPE_BUFFER:
+			return fixup_buffer(obj, range, direction);
+		case ACPI_TYPE_PACKAGE:
+			return fixup_package(obj, range, direction);
+		default:
+			/* No fixup necessary */
+			return 1;
+	}
+}
+
+static int
+fixup_package(
+	union acpi_object	*obj,
+	struct acpi_buffer	*range,
+	int			direction)
+{
+	int count;
+	union acpi_object *element = NULL, **pointer = &obj->package.elements;
+
+	ACPI_FUNCTION_TRACE("fixup_package");
+
+	if (direction == TO_OFFSET) {
+		element = *pointer;
+		if (!range_ok(*pointer, range, sizeof(union acpi_object)))
+			return 0;
+	}
+
+	*pointer = fixup_pointer(range, *pointer, direction);
+
+	if (direction == TO_POINTER) {
+		element = *pointer;
+		if (!range_ok(*pointer, range, sizeof(union acpi_object)))
+			return 0;
+	}
+
+	for (count = 0 ; count < obj->package.count ; count++) {
+		if (!fixup_element(element, range, direction))
+			return 0;
+		element++;
+	}
+
+	return 1;
+}
+
+static struct acpi_object_list *
+fixup_arglist(struct acpi_buffer *buffer)
+{
+	struct acpi_object_list *arg_list;
+	union acpi_object **cur_arg, *tmp;
+	unsigned int i;
+
+	ACPI_FUNCTION_TRACE("fixup_arglist");
+
+	if (buffer->length < sizeof(*arg_list))
+		return NULL;
+
+	arg_list = (struct acpi_object_list *)buffer->pointer;
+
+	if (buffer->length < sizeof(*arg_list) +
+	    ((arg_list->count - 1) * sizeof(union acpi_object *)) +
+	    (arg_list->count * sizeof(union acpi_object)))
+		return NULL;
+ 
+	cur_arg = &arg_list->pointer;
+
+	for (i = 0; i < arg_list->count ; i++) {
+		/* point at next arg */
+		tmp = (union acpi_object *)((unsigned long)arg_list +
+		                            (unsigned long)cur_arg[i]);
+
+		if (!range_ok(tmp, buffer, sizeof(union acpi_object)))
+			return NULL;
+
+		/* store pointer into list */
+		cur_arg[i] = tmp;
+
+		if (!fixup_element(tmp, buffer, TO_POINTER))
+			return NULL;
+	}
+
+	return arg_list;
+}
+
+static void
+acpi_clear_buf(struct acpi_buffer *buf)
+{
+	ACPI_FUNCTION_TRACE("acpi_clear_buf");
+
+	if (!buf->pointer)
+		return;
+
+	acpi_os_free(buf->pointer);
+	buf->pointer = NULL;
+	buf->length = 0;
+}
+
+static ssize_t
+acpi_sysfs_read_special(
+	acpi_handle		handle,
+	char			*attr_name,
+	struct acpi_buffer	*buffer,
+	struct acpi_buffer	*cmd)
+{
+	struct special_cmd		*special;
+	acpi_status			status;
+
+	ACPI_FUNCTION_TRACE("acpi_sysfs_read_special");
+
+	special = (struct special_cmd *)cmd->pointer;
+
+	switch (special->cmd) {
+	/*
+	 * VERSION: Interface version.  Major followed by minor,
+	 *          compatibility should not be broken within Major.
+	 *          Also for synchronizing size of acpi_object with
+	 *          userspace.
+	 */
+	case VERSION:
+	{
+		union acpi_object *obj;
+		obj = acpi_os_allocate(sizeof(union acpi_object));
+
+		if (!obj)
+			return -ENOMEM;
+
+		buffer->pointer = obj;
+		buffer->length = sizeof(union acpi_object);
+
+		obj->type = ACPI_TYPE_INTEGER;
+		obj->integer.value =
+		                   (ACPI_SYSFS_MAJOR << 16) | ACPI_SYSFS_MINOR;
+		return buffer->length;
+	}
+	/*
+	 * GET_TYPE: Return the type of an object.
+	 * GET_PTYPE: Return the type of the parent of an object.
+	 */
+	case GET_TYPE:
+	case GET_PTYPE:
+	{
+		acpi_handle	chandle = NULL;
+
+		buffer->pointer = acpi_os_allocate(sizeof(acpi_object_type));
+
+		if (!buffer->pointer)
+			return -ENOMEM;
+			
+		buffer->length = sizeof(acpi_object_type);
+
+		status = acpi_get_handle(handle, attr_name, &chandle);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		if (special->cmd == GET_PTYPE) {
+			acpi_handle cchandle;
+
+			cchandle = chandle;
+
+			status = acpi_get_parent(cchandle, &chandle);
+			if (ACPI_FAILURE(status))
+				return -ENODEV;
+		}
+
+		status = acpi_get_type(chandle, buffer->pointer);
+		if (ACPI_FAILURE(status)) {
+			acpi_clear_buf(buffer);
+			return -ENODEV;
+		}
+		return buffer->length;
+	}
+	default:
+		buffer->length = 0;
+		return -EINVAL;
+	}
+}
+
+static ssize_t
+acpi_sysfs_read(
+	struct kobject		*kobj,
+	char			*buf,
+	loff_t			off,
+	size_t			length)
+{
+	struct acpi_device		*device = to_acpi_device(kobj);
+	struct acpi_private_data	*data = (struct acpi_private_data *)buf;
+
+	ACPI_FUNCTION_TRACE("acpi_sysfs_read");
+	/*
+	 * The write buffer may contain a special command or an
+	 * acpi_object_list to be used for evaluating the object.
+	 * Special commands are denoted w/ object list count (aka
+	 * magic) of ACPI_UINT32_MAX.
+	 */
+	if (!off && WBUF(data)->length >= sizeof(struct special_cmd)) {
+		struct special_cmd	*special;
+		struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+		
+		special = (struct special_cmd *)WBUF(data)->pointer;
+
+		if (special->magic == ACPI_UINT32_MAX) {
+			ssize_t ret_val;
+			ret_val = acpi_sysfs_read_special(device->handle,
+			                                  data->name,
+			                                  &buffer,
+			                                  WBUF(data));
+			acpi_clear_buf(WBUF(data));
+
+			if (ret_val < 0)
+				return ret_val;
+
+			acpi_clear_buf(RBUF(data));
+
+			RBUF(data)->pointer = buffer.pointer;
+			RBUF(data)->length = buffer.length;
+
+			goto return_data;
+		}
+	}
+
+	/* An offset of zero implies new-read */
+	if (!off) {
+		struct acpi_object_list	*arg_list = NULL;
+		acpi_status		status;
+		struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+		/*
+		 * We expect to be passed a complete acpi_object_list
+		 * structure.  A better user interface might be to have each
+		 * write be an acpi_object strucure which we insert into a
+		 * acpi_object_list as they come...
+		 */
+		arg_list = fixup_arglist(WBUF(data));
+
+		if (WBUF(data)->length && !arg_list) {
+			acpi_clear_buf(WBUF(data));
+			acpi_clear_buf(RBUF(data));
+			return -EINVAL;
+		}
+		
+		status = acpi_evaluate_object(device->handle, data->name,
+		                              arg_list, &buffer);
+
+		/* Free up all our buffers */
+		acpi_clear_buf(WBUF(data));
+		acpi_clear_buf(RBUF(data));
+
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		fixup_element((union acpi_object *)buffer.pointer,
+		              &buffer, TO_OFFSET);
+
+		RBUF(data)->pointer = buffer.pointer;
+		RBUF(data)->length = buffer.length;
+	}
+
+return_data:
+
+	/* Return only what we're asked for */
+	if (off > RBUF(data)->length)
+		return 0;
+	if (off + length > RBUF(data)->length)
+		length = RBUF(data)->length - off;
+
+	if (length > sizeof(data->buf))
+		length = sizeof(data->buf);
+
+	memcpy(buf, RBUF(data)->pointer + off, length);
+
+	return length;
+}
+
+static ssize_t
+acpi_sysfs_write(
+	struct kobject		*kobj,
+	char			*buf,
+	loff_t			off,
+	size_t			length)
+{
+	struct acpi_private_data	*data = (struct acpi_private_data *)buf;
+	char				*new_buf;
+	size_t				new_size;
+
+	ACPI_FUNCTION_TRACE("acpi_sysfs_write");
+
+	/* Writing always clears anything left in the read buffer */
+	acpi_clear_buf(RBUF(data));
+
+	/* Allow for multiple writes to build up a buffer */
+	new_size = max(data->write_buf.length, (size_t)(off + length));
+	new_buf = acpi_os_allocate(new_size);
+	if (!new_buf)
+		return -ENOMEM;
+
+	memset(new_buf, 0, new_size);
+	memcpy(new_buf, data->write_buf.pointer, data->write_buf.length);
+	memcpy(new_buf + off, buf, length);
+
+	acpi_clear_buf(WBUF(data));
+
+	data->write_buf.pointer = new_buf;
+	data->write_buf.length = new_size;
+
+	return length;
+}
+
+static char *
+acpi_sysfs_open(
+	struct kobject		*kobj,
+	struct attribute	*attr)
+{
+	struct acpi_private_data *data;
+
+	ACPI_FUNCTION_TRACE("acpi_sysfs_open");
+ 
+	if (!try_module_get(THIS_MODULE))
+		return NULL;
+
+	data = kmalloc(sizeof(struct acpi_private_data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	memset(data, 0, sizeof(struct acpi_private_data));
+
+	data->name = kmalloc(strlen(attr->name) + 1, GFP_KERNEL);
+	if (!data->name) {
+		kfree(data);
+		return NULL;
+	}
+
+	strcpy(data->name, attr->name);
+
+	return (char *)data;
+}
+
+static void
+acpi_sysfs_release(
+	struct kobject		*kobj,
+	struct attribute	*attr,
+	char			*buf)
+{
+	struct acpi_private_data *data = (struct acpi_private_data *)buf;
+
+	ACPI_FUNCTION_TRACE("acpi_sysfs_release");
+
+	acpi_clear_buf(WBUF(data));
+	acpi_clear_buf(RBUF(data));
+
+	kfree(data->name);
+	kfree(data);
+
+	module_put(THIS_MODULE);
+	return;
+}
+
+static struct acpi_bin_files *
+find_bin_file(char *name) {
+	struct list_head *node, *next;
+	struct acpi_bin_files *bin_file;
+
+	ACPI_FUNCTION_TRACE("find_bin_file");
+
+	list_for_each_safe(node, next, &acpi_bin_file_list) {
+		bin_file = container_of(node, struct acpi_bin_files, list);
+
+		if (!strcmp(name, bin_file->bin_attrib.attr.name))
+			return bin_file;
+	}
+	return NULL;
+}
+
+static void
+create_sysfs_files(struct acpi_device *dev)
+{
+	acpi_handle		chandle = 0;
+	char			pathname[ACPI_PATHNAME_MAX];
+	acpi_status		status;
+	struct acpi_buffer	buffer;
+	struct bin_attribute	*attrib;
+	acpi_object_type	type;
+	struct acpi_bin_files	*bin_file;
+	int			error;
+
+	ACPI_FUNCTION_TRACE("create_sysfs_files");
+
+	buffer.length = sizeof(pathname);
+	buffer.pointer = pathname;
+
+	while (ACPI_SUCCESS(acpi_get_next_object(ACPI_TYPE_ANY, dev->handle,
+	                                         chandle, &chandle))) {
+
+		status = acpi_get_type(chandle, &type);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		switch (type) {
+			case ACPI_TYPE_INTEGER:
+			case ACPI_TYPE_STRING:
+			case ACPI_TYPE_BUFFER:
+			case ACPI_TYPE_METHOD:
+				break;
+			default:
+				continue;
+		}
+
+		memset(pathname, 0, sizeof(pathname));
+
+		status = acpi_get_name(chandle, ACPI_SINGLE_NAME, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		/* Simple check for standard objects */
+		if (!acpi_sysfs_nonstd && pathname[0] != '_')
+			continue;
+
+		/*
+		 * Guess at some bad objects we should hide - likley incomplete
+		 */
+		if (!acpi_sysfs_dangerous) {
+			if ((!strcmp(pathname, "_INI")) ||
+			    (!strcmp(pathname, "_GL_")) ||
+			    (!strcmp(pathname, "_GTS")) ||
+			    (!strcmp(pathname, "_PS0")) ||
+			    (!strcmp(pathname, "_PS1")) ||
+			    (!strcmp(pathname, "_PS2")) ||
+			    (!strcmp(pathname, "_PTS")) ||
+			    (!strcmp(pathname, "_S0_")) ||
+			    (!strcmp(pathname, "_S1_")) ||
+			    (!strcmp(pathname, "_S2_")) ||
+			    (!strcmp(pathname, "_S3_")) ||
+			    (!strcmp(pathname, "_S4_")) ||
+			    (!strcmp(pathname, "_S5_")) ||
+			    (!strcmp(pathname, "_WAK")))
+			    continue;
+		}
+
+		spin_lock(&acpi_bin_file_lock);
+
+		/*
+		 * Check if we already have a bin_attribute w/ this name.
+		 * If so, reuse it and save some memory.
+		 */
+		bin_file = find_bin_file(pathname);
+
+		if (bin_file) {
+			attrib = &bin_file->bin_attrib;
+			bin_file->use_count++;
+		} else {
+			bin_file = kmalloc(sizeof(struct acpi_bin_files),
+			                   GFP_KERNEL);
+
+			if (!bin_file)
+				continue;
+
+			attrib = &bin_file->bin_attrib;
+
+			memset(attrib, 0, sizeof(struct bin_attribute));
+
+			attrib->attr.name = kmalloc(strlen(pathname) + 1,
+			                            GFP_KERNEL);
+			if (!attrib->attr.name) {
+				kfree(bin_file);
+				continue;
+			}
+
+			strcpy(attrib->attr.name, pathname);
+
+			attrib->attr.mode = S_IFREG | S_IRUSR | S_IRGRP |
+			                    S_IWUSR | S_IWGRP;
+			attrib->read = acpi_sysfs_read;
+			attrib->write = acpi_sysfs_write;
+			attrib->open = acpi_sysfs_open;
+			attrib->release = acpi_sysfs_release;
+
+			INIT_LIST_HEAD(&bin_file->list);
+			bin_file->use_count = 1;
+
+			list_add_tail(&bin_file->list, &acpi_bin_file_list);
+		}
+		spin_unlock(&acpi_bin_file_lock);
+
+		error = sysfs_create_bin_file(&dev->kobj, attrib);
+		if (error) {
+			spin_lock(&acpi_bin_file_lock);
+			bin_file->use_count--;
+			if (!bin_file->use_count) {
+				list_del(&bin_file->list);
+				kfree(attrib->attr.name);
+				kfree(bin_file);
+			}
+			spin_unlock(&acpi_bin_file_lock);
+			continue;
+		}
+	}
+}
+
+static void
+remove_sysfs_files(struct acpi_device *dev)
+{
+	acpi_handle		chandle = 0;
+	char			pathname[ACPI_PATHNAME_MAX];
+	acpi_status		status;
+	struct acpi_buffer	buffer;
+	struct bin_attribute	*old_attrib;
+	acpi_object_type	type;		
+	struct acpi_bin_files	*bin_file;
+
+	ACPI_FUNCTION_TRACE("remove_sysfs_files");
+
+	buffer.length = sizeof(pathname);
+	buffer.pointer = pathname;
+
+	spin_lock(&acpi_bin_file_lock);
+
+	while (ACPI_SUCCESS(acpi_get_next_object(ACPI_TYPE_ANY, dev->handle,
+	                                         chandle, &chandle))) {
+
+		status = acpi_get_type(chandle, &type);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		switch (type) {
+			case ACPI_TYPE_INTEGER:
+			case ACPI_TYPE_STRING:
+			case ACPI_TYPE_BUFFER:
+			case ACPI_TYPE_METHOD:
+				break;
+			default:
+				continue;
+		}
+
+		memset(pathname, 0, sizeof(pathname));
+
+		status = acpi_get_name(chandle, ACPI_SINGLE_NAME, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		bin_file = find_bin_file(pathname);
+		if (!bin_file)
+			continue;
+
+		old_attrib = &bin_file->bin_attrib;
+
+		sysfs_remove_bin_file(&dev->kobj, old_attrib);
+
+		bin_file->use_count--;
+		if (!bin_file->use_count) {
+			list_del(&bin_file->list);
+			kfree(old_attrib->attr.name);
+			kfree(bin_file);
+		}
+	}
+	spin_unlock(&acpi_bin_file_lock);
+}
+
+acpi_status
+acpi_sysfs_add(
+	acpi_handle	handle,
+	u32		level,
+	void		*context,
+	void		**return_value)
+{
+	struct acpi_device	*device;
+
+	ACPI_FUNCTION_TRACE("acpi_sysfs_add");
+
+	if (acpi_bus_get_device(handle, &device) == 0)
+		create_sysfs_files(device);
+
+	return AE_OK;
+}
+	
+acpi_status
+acpi_sysfs_del(
+	acpi_handle	handle,
+	u32		level,
+	void		*context,
+	void		**return_value)
+{
+	struct acpi_device	*device;
+
+	ACPI_FUNCTION_TRACE("acpi_sysfs_del");
+
+	if (acpi_bus_get_device(handle, &device) == 0)
+		remove_sysfs_files(device);
+
+	return AE_OK;
+}
+	
+int __init
+acpi_sysfs_init(void)
+{
+	acpi_status	status;
+
+	ACPI_FUNCTION_TRACE("acpi_sysfs_init");
+
+	acpi_sysfs_add(ACPI_ROOT_OBJECT, 0, NULL, NULL);
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+	                             ACPI_UINT32_MAX, acpi_sysfs_add,
+				     NULL, NULL);
+	if (ACPI_FAILURE(status))
+		goto cleanup0;
+
+	status = acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
+	                             ACPI_UINT32_MAX, acpi_sysfs_add,
+				     NULL, NULL);
+	if (ACPI_FAILURE(status))
+		goto cleanup1;
+
+	status = acpi_walk_namespace(ACPI_TYPE_THERMAL, ACPI_ROOT_OBJECT,
+	                             ACPI_UINT32_MAX, acpi_sysfs_add,
+				     NULL, NULL);
+	if (ACPI_FAILURE(status))
+		goto cleanup2;
+
+	status = acpi_walk_namespace(ACPI_TYPE_POWER, ACPI_ROOT_OBJECT,
+	                             ACPI_UINT32_MAX, acpi_sysfs_add,
+				     NULL, NULL);
+	if (ACPI_FAILURE(status))
+		goto cleanup3;
+
+	return_VALUE(0);
+
+cleanup3:
+	(void)acpi_walk_namespace(ACPI_TYPE_POWER, ACPI_ROOT_OBJECT,
+	                          ACPI_UINT32_MAX, acpi_sysfs_del,
+	                          NULL, NULL);
+cleanup2:
+	(void)acpi_walk_namespace(ACPI_TYPE_THERMAL, ACPI_ROOT_OBJECT,
+	                          ACPI_UINT32_MAX, acpi_sysfs_del,
+	                          NULL, NULL);
+cleanup1:
+	(void)acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
+	                          ACPI_UINT32_MAX, acpi_sysfs_del,
+	                          NULL, NULL);
+cleanup0:
+	(void)acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+	                          ACPI_UINT32_MAX, acpi_sysfs_del,
+	                          NULL, NULL);
+
+	acpi_sysfs_del(ACPI_ROOT_OBJECT, 0, NULL, NULL);
+
+	return_VALUE(1);
+}
+
+void __exit
+acpi_sysfs_exit(void)
+{
+	struct list_head *node, *next;
+	struct acpi_bin_files *bin_file;
+
+	ACPI_FUNCTION_TRACE("acpi_sysfs_exit");
+
+	(void)acpi_walk_namespace(ACPI_TYPE_POWER, ACPI_ROOT_OBJECT,
+	                          ACPI_UINT32_MAX, acpi_sysfs_del,
+	                          NULL, NULL);
+	(void)acpi_walk_namespace(ACPI_TYPE_THERMAL, ACPI_ROOT_OBJECT,
+	                          ACPI_UINT32_MAX, acpi_sysfs_del,
+	                          NULL, NULL);
+	(void)acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
+	                          ACPI_UINT32_MAX, acpi_sysfs_del,
+	                          NULL, NULL);
+	(void)acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+	                          ACPI_UINT32_MAX, acpi_sysfs_del,
+	                          NULL, NULL);
+
+	acpi_sysfs_del(ACPI_ROOT_OBJECT, 0, NULL, NULL);
+
+	/* List should be empty, but double check.  */
+	spin_lock(&acpi_bin_file_lock);
+	list_for_each_safe(node, next, &acpi_bin_file_list) {
+		bin_file = container_of(node, struct acpi_bin_files, list);
+
+		list_del(&bin_file->list);
+		kfree(bin_file->bin_attrib.attr.name);
+		kfree(bin_file);
+	}
+	spin_unlock(&acpi_bin_file_lock);
+
+	return_VOID;
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alex Williamson <alex.williamson@hp.com>");
+MODULE_DESCRIPTION("Exports ACPI namespace objects via sysfs");
+
+module_init(acpi_sysfs_init);
+module_exit(acpi_sysfs_exit);


