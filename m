Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUHEPy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUHEPy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUHEPy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:54:26 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:47593 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S267730AbUHEPxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:53:10 -0400
Subject: Re: [RFC] dev_acpi: device driver for userspace access to ACPI
From: Alex Williamson <alex.williamson@hp.com>
To: Greg KH <greg@kroah.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040805043636.GA28244@kroah.com>
References: <1091552426.4981.103.camel@tdi>
	 <20040805043636.GA28244@kroah.com>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 05 Aug 2004 09:52:56 -0600
Message-Id: <1091721177.3837.39.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 21:36 -0700, Greg KH wrote:
> On Tue, Aug 03, 2004 at 11:00:26AM -0600, Alex Williamson wrote:
> > 
> >   Populating the sysfs tree didn't seem to generate as much interest as
> > I'd hoped and I don't think it kept with the spirit of sysfs very well.
> 
> I'm sorry if I didn't speak up at the time, but I still think that your
> sysfs patches were the right way to go.  Why do you think they don't
> keep with the spirit of sysfs?  Do you have a pointer to your last
> patch that exported the acpi table info through sysfs?

   The sysfs patch definitely has a higher coolness factor than the
device file approach.  For the most part, the functionality is the same,
so I'm happy to go either way.  The kludgy part of the sysfs patch is
the way it's kind of hacking an ioctl interface into the read()/write()
interface available.  A read of an object file can return various things
based on what's been written.  The same is true of the device file
patch, but the device file patch is far less invasive and ends up being
a nice standalone module.  I had to tweak some things in sysfs to get it
to behave the way I wanted (like add some backing store), which made me
start thinking perhaps I should do it another way.  I toyed with the
idea of actually making an acpifs, but I couldn't come up with a big
enough win over the sysfs approach to go down that path.

   If the sysfs version isn't making too many people cringe, I'd prefer
to pursue that direction.  Here's a pointer to the last version I
posted:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108239031314885&w=2

I also attached the latest version I have below, it's newer, but still
dated from April.  I believe it still applies and works.  let me know if
you think it has a chance.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

 drivers/acpi/scan.c             |  661 +++++++++++++++++++++++++++++++++++++++-
 drivers/base/firmware_class.c   |    8 
 drivers/i2c/chips/eeprom.c      |    3 
 drivers/pci/pci-sysfs.c         |    6 
 drivers/scsi/qla2xxx/qla_os.c   |   32 -
 drivers/video/aty/radeon_base.c |    6 
 drivers/zorro/zorro-sysfs.c     |    4 
 fs/sysfs/bin.c                  |   17 -
 include/linux/sysfs.h           |    8 
 9 files changed, 711 insertions(+), 34 deletions(-)

===== drivers/acpi/scan.c 1.22 vs edited =====
--- 1.22/drivers/acpi/scan.c	Tue Feb  3 22:29:19 2004
+++ edited/drivers/acpi/scan.c	Mon Apr 26 22:11:02 2004
@@ -7,6 +7,7 @@
 
 #include <acpi/acpi_drivers.h>
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
+#include <acpi/acnamesp.h>      /* for acpi_ns_map_handle_to_node() */
 
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
@@ -25,6 +26,662 @@
 static LIST_HEAD(acpi_device_list);
 static spinlock_t acpi_device_lock = SPIN_LOCK_UNLOCKED;
 
+static LIST_HEAD(acpi_bin_file_list);
+static spinlock_t acpi_bin_file_lock = SPIN_LOCK_UNLOCKED;
+
+struct acpi_bin_files {
+	struct list_head	list;
+	struct bin_attribute	*bin_attrib;
+	u32			use_count;
+};
+
+struct acpi_private_data {
+	char	buf[PAGE_SIZE];
+	size_t	write_len;
+	size_t	read_len;
+	char	*write_buf;
+	char	*read_buf;
+};
+
+#define to_acpi_device(n) container_of(n, struct acpi_device, kobj)
+#define to_bin_attr(n) container_of(n, struct bin_attribute, attr)
+
+static ssize_t
+acpi_device_write_raw(
+	struct kobject		*kobj,
+	struct attribute	*attr,
+	char			*buf,
+	loff_t			off,
+	size_t			length)
+{
+	struct acpi_private_data	*data = (struct acpi_private_data *)buf;
+	char				*new_buf;
+	size_t				new_size;
+
+	/* Writing always clears anything left in the read buffer */
+	if (data->read_len) {
+		acpi_os_free(data->read_buf);
+		data->read_len = 0;
+	}
+
+	/* Allow of multiple writes to build up a buffer */
+	new_size = max(data->write_len, (size_t)(off + length));
+	new_buf = kmalloc(new_size, GFP_KERNEL);
+	if (!new_buf)
+		return -ENOMEM;
+
+	memset(new_buf, 0, new_size);
+	memcpy(new_buf, data->write_buf, data->write_len);
+	memcpy(new_buf + off, buf, length);
+
+	if (data->write_len)
+		kfree(data->write_buf);
+
+	data->write_buf = new_buf;
+	data->write_len = new_size;
+
+	return length;
+}
+
+struct acpi_device_special_cmd {
+	acpi_object_type	type;
+	unsigned int		cmd;
+	char			*args;
+};
+
+static void
+fixup_string(
+	unsigned long		start,
+	acpi_integer		length,
+	union acpi_object	*element)
+{
+	unsigned long offset;
+	unsigned long **ptr;
+
+	offset = (unsigned long)(element->string.pointer) - start;
+
+	if (offset > length)
+		offset = 0;
+
+	ptr = (unsigned long **)&element->string.pointer;
+	*ptr = (unsigned long *)offset;
+}
+
+static void
+fixup_buffer(
+	unsigned long		start,
+	acpi_integer		length,
+	union acpi_object	*element)
+{
+	unsigned long offset;
+	unsigned long **ptr;
+
+	offset = (unsigned long)(element->buffer.pointer) - start;
+
+	if (offset > length)
+		offset = 0;
+
+	ptr = (unsigned long **)&element->buffer.pointer;
+	*ptr = (unsigned long *)offset;
+}
+
+static void fixup_package(unsigned long, acpi_integer, union acpi_object *);
+
+/*
+ * strings, buffers, and packages contain pointers.  These should just
+ * be pointing further down in the buffer, so before passing to user
+ * space, change the pointers into offsets from the beginning of the buffer.
+ */
+static void
+fixup_element(
+	unsigned long		start,
+	acpi_integer		length,
+	union acpi_object	*element)
+{
+	unsigned long buf_left;
+
+	buf_left = (start + length)  - (unsigned long)element;
+	if (buf_left < sizeof(union acpi_object))
+		return;
+
+	switch (element->type) {
+		case ACPI_TYPE_STRING:
+			return fixup_string(start, length, element);
+		case ACPI_TYPE_BUFFER:
+			return fixup_buffer(start, length, element);
+		case ACPI_TYPE_PACKAGE:
+			return fixup_package(start, length, element);
+		default:
+			/* No fixup necessary */
+			return;
+	}
+}
+
+static void
+fixup_package(
+	unsigned long		start,
+	acpi_integer		length,
+	union acpi_object	*element)
+{
+	u32 count;
+	union acpi_object *next_element;
+	unsigned long offset;
+	unsigned long **ptr;
+
+	count = element->package.count;
+
+	next_element = element->package.elements;
+
+	for ( ; count > 0 ; count-- ) {
+		fixup_element(start, length, next_element);
+		next_element++;
+	}
+
+	offset = (unsigned long)(element->package.elements) - start;
+
+	if (offset > length)
+		offset = 0;
+
+	ptr = (unsigned long **)&element->package.elements;
+	*ptr = (unsigned long *)offset;
+}
+
+/* These probably need to go in a header file if this goes live */
+#define OBJ_LEN     0x0
+#define GET_TYPE    0x1
+#define GET_ARG_CNT 0x2
+#define GET_AML     0x3
+#define SET_AML     0x4
+
+static ssize_t
+acpi_device_read_special(
+	acpi_handle		handle,
+	char			*attr_name,
+	struct acpi_buffer	*buffer,
+	char			*buf,
+	size_t			length)
+{
+	struct acpi_device_special_cmd	*special =
+	                                 (struct acpi_device_special_cmd *)buf;
+	struct acpi_namespace_node	*node;
+	union acpi_operand_object	*obj_desc;
+	acpi_object_type		type;
+	acpi_handle			chandle = NULL;
+	acpi_status			status;
+	ssize_t				ret_val;
+
+	switch (special->cmd) {
+	/*
+	 * OBJ_LEN: Return the length of a union acpi_object.  Hopefully
+	 *          useful for synchronization between kernel & userspace.
+	 */
+	case OBJ_LEN:
+		buffer->pointer = acpi_os_allocate(sizeof(unsigned int));
+
+		if (!buffer->pointer)
+			return -ENOMEM;
+			
+		buffer->length = sizeof(unsigned int);
+		*(unsigned int *)(buffer->pointer) = sizeof(union acpi_object);
+
+		return buffer->length;
+
+	/*
+	 * GET_TYPE: Return the type of an object.
+	 */
+	case GET_TYPE:
+		status = acpi_get_handle(handle, attr_name, &chandle);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		buffer->pointer = acpi_os_allocate(sizeof(acpi_object_type));
+
+		if (!buffer->pointer)
+			return -ENOMEM;
+			
+		buffer->length = sizeof(acpi_object_type);
+
+		status = acpi_get_type(chandle, buffer->pointer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_free(buffer->pointer);
+			buffer->length = 0;
+			return -ENODEV;
+		}
+		return buffer->length;
+
+	/*
+	 * GET_ARG_CNT: If object is a method, return the number of arguments
+	 *              it takes.
+	 */
+	case GET_ARG_CNT:
+	/*
+	 * GET_AML: If object is a method, return a buffer with the raw AML.
+	 */
+	case GET_AML:
+	/*
+	 * SET_AML: If object is a method, write new AML.
+	 */
+	case SET_AML:
+		ret_val = -ENODEV;
+		status = acpi_get_handle(handle, attr_name, &chandle);
+		if (ACPI_FAILURE(status))
+			return ret_val;
+
+		status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+		if (ACPI_FAILURE (status))
+			return ret_val;
+
+		node = acpi_ns_map_handle_to_node(chandle);
+		if (!node)
+			goto aml_out;
+
+		type = acpi_ns_get_type(node);
+		/* FIXME: do we care about aliases? */
+		if (type != ACPI_TYPE_METHOD)
+			goto aml_out;
+
+		obj_desc = acpi_ns_get_attached_object(node);
+		if (!obj_desc)
+			goto aml_out;
+
+		ret_val = -ENOMEM;
+		if (special->cmd == GET_ARG_CNT) {
+			buffer->pointer =
+			                acpi_os_allocate(sizeof(unsigned int));
+
+			if (!buffer->pointer)
+				goto aml_out;
+
+			buffer->length = sizeof(unsigned int);
+
+			*(unsigned int *)(buffer->pointer) =
+			                          obj_desc->method.param_count;
+
+			ret_val = buffer->length;
+
+		} else if (special->cmd == GET_AML) {
+			buffer->pointer =
+			         acpi_os_allocate(obj_desc->method.aml_length);
+
+			if (!buffer->pointer)
+				goto aml_out;
+
+			buffer->length = obj_desc->method.aml_length;
+
+			memcpy(buffer->pointer, obj_desc->method.aml_start,
+			       obj_desc->method.aml_length);
+
+			ret_val = buffer->length;
+
+		} else if (special->cmd == SET_AML) {
+			u8 *new_aml;
+			size_t size;
+
+			size = offsetof(struct acpi_device_special_cmd, args);
+			size = length - size;
+			new_aml = kmalloc(size, GFP_KERNEL);
+			if (!new_aml)
+				goto aml_out;
+
+			/*
+			 * FIXME: Memory leak, does the old data
+			 *        get kmalloc'd?  I'll assume this
+			 *        interface isn't going to get stress
+			 *        enough to care for now.
+			 * if (obj_desc->method.aml_length)
+			 * 	kfree(obj_desc->method.aml_start);
+			 */
+
+			memcpy(new_aml, &special->args, size);
+			obj_desc->method.aml_start = new_aml;
+			obj_desc->method.aml_length = size;
+			ret_val = buffer->length = 0;
+		}
+aml_out:
+		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+		return ret_val;
+
+	default:
+		buffer->length = 0;
+		return 0;
+	}
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
+	struct acpi_device		*device = to_acpi_device(kobj);
+	struct bin_attribute		*attrib = to_bin_attr(attr);
+	struct acpi_private_data	*data = (struct acpi_private_data *)buf;
+	struct acpi_buffer		buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_object_list		*arg_list = NULL;
+	union acpi_object		**cur_arg, *args = NULL;
+	unsigned int			count, i;
+	acpi_status			status;
+	size_t				size;
+
+	/* Check for special command */
+	if (data->write_len > sizeof(acpi_object_type) && !off) {
+		struct acpi_device_special_cmd *special;
+		
+		special = ((struct acpi_device_special_cmd *)data->write_buf);
+
+		if (special->type == ACPI_TYPE_NOT_FOUND) {
+			ssize_t ret_val;
+			ret_val = acpi_device_read_special(device->handle,
+			                                   attrib->attr.name,
+							   &buffer,
+			                                   data->write_buf,
+			                                   data->write_len);
+			if (ret_val < 0)
+				return ret_val;
+
+			if (data->read_len)
+				acpi_os_free(data->read_buf);
+
+			data->read_buf = buffer.pointer;
+			data->read_len = buffer.length;
+			goto return_data;
+		}
+	}
+
+	/* An offset of zero implies new-read */
+	if (!off) {
+		/* Check if parameters are written in the write_buf */
+		count = data->write_len / sizeof(union acpi_object);
+		if (data->write_len % sizeof(union acpi_object))
+			count++;
+
+		if (count) {
+			size = sizeof(struct acpi_object_list) +
+			       ((count - 1) * sizeof(union acpi_object *));
+
+			arg_list = kmalloc(size, GFP_KERNEL);
+			if (!arg_list)
+				return -ENOMEM;
+
+			memset(arg_list, 0, size);
+			arg_list->count = count;
+
+			args = (union acpi_object *)data->write_buf;
+
+			/*
+			 * Make argument pointers point at the right offsets
+			 * into the write_buf.  Note args can only be union
+			 * acpi_object in size.
+			 */
+			cur_arg = &arg_list->pointer;
+			for (i = 0 ; i < count ; i++)
+				cur_arg[i] = &args[i];
+		}
+
+		status = acpi_evaluate_object(device->handle, attrib->attr.name,
+		                              arg_list, &buffer);
+		if (arg_list)
+			kfree(arg_list);
+		if (data->read_len)
+			acpi_os_free(data->read_buf);
+
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		fixup_element((unsigned long)buffer.pointer,
+		              buffer.length, buffer.pointer);
+
+		data->read_buf = buffer.pointer;
+		data->read_len = buffer.length;
+	}
+
+return_data:
+
+	/* Write buffer always gets cleared on a successful read */
+	if (data->write_len) {
+		kfree(data->write_buf);
+		data->write_len = 0;
+	}
+
+	/* Return only what we're asked for */
+	if (off > data->read_len)
+		return 0;
+	if (off + length > data->read_len)
+		length = data->read_len - off;
+
+	memcpy(buf, data->read_buf + off, length);
+
+	return length;
+}
+
+static char *
+acpi_device_open_raw(
+	struct kobject		*kobj,
+	struct attribute	*attr)
+{
+	struct acpi_private_data *data;
+
+	data = kmalloc(sizeof(struct acpi_private_data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	memset(data, 0, sizeof(struct acpi_private_data));
+	return (char *)data;
+}
+
+static void
+acpi_device_release_raw(
+	struct kobject		*kobj,
+	struct attribute	*attr,
+	char			*buf)
+{
+	struct acpi_private_data *data = (struct acpi_private_data *)buf;
+
+	if (data->read_len)
+		acpi_os_free(data->read_buf);
+	if (data->write_len)
+		kfree(data->write_buf);
+
+	kfree(data);
+
+	return;
+}
+
+static struct acpi_bin_files *
+find_bin_file(char *name) {
+	struct list_head *node, *next;
+	struct acpi_bin_files *bin_file;
+
+	list_for_each_safe(node, next, &acpi_bin_file_list) {
+		bin_file = container_of(node, struct acpi_bin_files, list);
+
+		if (!strcmp(name, bin_file->bin_attrib->attr.name))
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
+			case ACPI_TYPE_DEVICE:
+			case ACPI_TYPE_PROCESSOR:
+			case ACPI_TYPE_THERMAL:
+			case ACPI_TYPE_POWER:
+			case ACPI_TYPE_INVALID:
+			case ACPI_TYPE_NOT_FOUND:
+				continue;
+		}
+
+		memset(pathname, 0 , sizeof(pathname));
+
+		status = acpi_get_name(chandle, ACPI_SINGLE_NAME, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		attrib = NULL;
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
+			attrib = bin_file->bin_attrib;
+			bin_file->use_count++;
+		} else {
+			attrib = kmalloc(sizeof(struct bin_attribute),
+			                 GFP_KERNEL);
+			if (!attrib)
+				continue;
+
+			memset(attrib, 0, sizeof(struct bin_attribute));
+
+			attrib->attr.name = kmalloc(strlen(pathname),
+			                            GFP_KERNEL);
+			if (!attrib->attr.name) {
+				kfree(attrib);
+				continue;
+			}
+
+			strcpy(attrib->attr.name, pathname);
+
+			attrib->attr.mode = S_IFREG | S_IRUSR | S_IRGRP |
+			                    S_IWUSR | S_IWGRP;
+			attrib->read = acpi_device_read_raw;
+			attrib->write = acpi_device_write_raw;
+			attrib->open = acpi_device_open_raw;
+			attrib->release = acpi_device_release_raw;
+
+			bin_file = kmalloc(sizeof(struct acpi_bin_files),
+			                   GFP_KERNEL);
+
+			if (!bin_file) {
+				kfree(attrib);
+				kfree(bin_file);
+				continue;
+			}
+
+			INIT_LIST_HEAD(&bin_file->list);
+			bin_file->bin_attrib = attrib;
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
+				kfree(attrib);
+				kfree(bin_file);
+			}
+			spin_unlock(&acpi_bin_file_lock);
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
+	acpi_handle		chandle = 0;
+	char			pathname[ACPI_PATHNAME_MAX];
+	acpi_status		status;
+	struct acpi_buffer	buffer;
+	struct bin_attribute	*old_attrib;
+	struct dentry		*dentry;
+	acpi_object_type	type;		
+	struct acpi_bin_files	*bin_file;
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
+			case ACPI_TYPE_DEVICE:
+			case ACPI_TYPE_PROCESSOR:
+			case ACPI_TYPE_THERMAL:
+			case ACPI_TYPE_POWER:
+			case ACPI_TYPE_INVALID:
+			case ACPI_TYPE_NOT_FOUND:
+				continue;
+		}
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
+			if (strcmp(pathname, old_attrib->attr.name))
+				continue;
+
+			sysfs_remove_bin_file(&dev->kobj, old_attrib);
+
+			spin_lock(&acpi_bin_file_lock);
+			bin_file = find_bin_file(pathname);
+			if (!bin_file)
+				continue;
+
+			bin_file->use_count--;
+			if (!bin_file->use_count) {
+				list_del(&bin_file->list);
+				kfree(old_attrib->attr.name);
+				kfree(old_attrib);
+				kfree(bin_file);
+			}
+			spin_unlock(&acpi_bin_file_lock);
+		}
+	}
+}
+
 static void acpi_device_release(struct kobject * kobj)
 {
 	struct acpi_device * dev = container_of(kobj,struct acpi_device,kobj);
@@ -72,6 +729,7 @@
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
 	kobject_add(&device->kobj);
+	create_sysfs_files(device);
 }
 
 static int
@@ -79,6 +737,7 @@
 	struct acpi_device	*device, 
 	int			type)
 {
+	remove_sysfs_files(device);
 	kobject_unregister(&device->kobj);
 	return 0;
 }
@@ -706,7 +1365,7 @@
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result) || !device->status.present) {
+		if (ACPI_FAILURE(result)) {
 			result = -ENOENT;
 			goto end;
 		}
===== drivers/base/firmware_class.c 1.17 vs edited =====
--- 1.17/drivers/base/firmware_class.c	Wed Apr 21 14:42:04 2004
+++ edited/drivers/base/firmware_class.c	Mon Apr 26 20:19:15 2004
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
===== drivers/i2c/chips/eeprom.c 1.9 vs edited =====
--- 1.9/drivers/i2c/chips/eeprom.c	Wed Apr 21 14:42:04 2004
+++ edited/drivers/i2c/chips/eeprom.c	Mon Apr 26 20:19:16 2004
@@ -123,7 +123,8 @@
 	up(&data->update_lock);
 }
 
-static ssize_t eeprom_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+static ssize_t eeprom_read(struct kobject *kobj, struct attribute *attr,
+                           char *buf, loff_t off, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
 	struct eeprom_data *data = i2c_get_clientdata(client);
===== drivers/pci/pci-sysfs.c 1.9 vs edited =====
--- 1.9/drivers/pci/pci-sysfs.c	Fri Mar 26 09:11:04 2004
+++ edited/drivers/pci/pci-sysfs.c	Mon Apr 26 20:19:16 2004
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
===== drivers/scsi/qla2xxx/qla_os.c 1.16 vs edited =====
--- 1.16/drivers/scsi/qla2xxx/qla_os.c	Wed Apr 21 14:42:05 2004
+++ edited/drivers/scsi/qla2xxx/qla_os.c	Mon Apr 26 20:19:17 2004
@@ -394,10 +394,10 @@
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
@@ -408,10 +408,10 @@
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
@@ -434,8 +434,8 @@
 
 
 /* SysFS attributes. */
-static ssize_t qla2x00_sysfs_read_fw_dump(struct kobject *kobj, char *buf,
-    loff_t off, size_t count)
+static ssize_t qla2x00_sysfs_read_fw_dump(struct kobject *kobj,
+    struct attribute *attr, char *buf, loff_t off, size_t count)
 {
 	struct scsi_qla_host *ha = to_qla_host(dev_to_shost(container_of(kobj,
 	    struct device, kobj)));
@@ -452,8 +452,8 @@
 	return (count);
 }
 
-static ssize_t qla2x00_sysfs_write_fw_dump(struct kobject *kobj, char *buf,
-    loff_t off, size_t count)
+static ssize_t qla2x00_sysfs_write_fw_dump(struct kobject *kobj,
+    struct attribute *attr, char *buf, loff_t off, size_t count)
 {
 	struct scsi_qla_host *ha = to_qla_host(dev_to_shost(container_of(kobj,
 	    struct device, kobj)));
@@ -507,8 +507,8 @@
 	return (count);
 }
 
-static ssize_t qla2x00_sysfs_read_nvram(struct kobject *kobj, char *buf,
-    loff_t off, size_t count)
+static ssize_t qla2x00_sysfs_read_nvram(struct kobject *kobj,
+    struct attribute *attr, char *buf, loff_t off, size_t count)
 {
 	struct scsi_qla_host *ha = to_qla_host(dev_to_shost(container_of(kobj,
 	    struct device, kobj)));
@@ -534,8 +534,8 @@
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
+++ edited/drivers/video/aty/radeon_base.c	Mon Apr 26 20:19:21 2004
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
+++ edited/drivers/zorro/zorro-sysfs.c	Mon Apr 26 20:19:22 2004
@@ -47,8 +47,8 @@
 
 static DEVICE_ATTR(resource, S_IRUGO, zorro_show_resource, NULL);
 
-static ssize_t zorro_read_config(struct kobject *kobj, char *buf, loff_t off,
-				 size_t count)
+static ssize_t zorro_read_config(struct kobject *kobj, struct attribute *attr,
+                                 char *buf, loff_t off, size_t count)
 {
 	struct zorro_dev *z = to_zorro_dev(container_of(kobj, struct device,
 					   kobj));
===== fs/sysfs/bin.c 1.13 vs edited =====
--- 1.13/fs/sysfs/bin.c	Wed Apr 21 14:42:04 2004
+++ edited/fs/sysfs/bin.c	Mon Apr 26 20:22:27 2004
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
 
===== include/linux/sysfs.h 1.33 vs edited =====
--- 1.33/include/linux/sysfs.h	Mon Apr 12 11:55:33 2004
+++ edited/include/linux/sysfs.h	Mon Apr 26 20:19:29 2004
@@ -27,8 +27,12 @@
 struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
-	ssize_t (*read)(struct kobject *, char *, loff_t, size_t);
-	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
+	ssize_t (*read)(struct kobject *, struct attribute *,
+	                char *, loff_t, size_t);
+	ssize_t (*write)(struct kobject *, struct attribute *,
+	                 char *, loff_t, size_t);
+	char    *(*open)(struct kobject *, struct attribute *);
+	void    (*release)(struct kobject *, struct attribute *, char *);
 };
 
 struct sysfs_ops {


