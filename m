Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbSLMBU3>; Thu, 12 Dec 2002 20:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267579AbSLMBU3>; Thu, 12 Dec 2002 20:20:29 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35346 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267578AbSLMBUH>;
	Thu, 12 Dec 2002 20:20:07 -0500
Date: Thu, 12 Dec 2002 17:26:19 -0800
From: Greg KH <greg@kroah.com>
To: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: dmfs for 2.5.51
Message-ID: <20021213012618.GH23509@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.5.51 with a updated dmfs.  It contains the two
patches at:
http://people.sistina.com/~thornber/patches/2.5-unstable/2.5.50/2.5.50-dmfs-1/00012.patch
and
http://people.sistina.com/~thornber/patches/2.5-unstable/2.5.50/2.5.50-dmfs-1/00013.patch
with the following modifications:
	- fixed locking type mismatch (trying to call spin_lock on a
	  rw_semaphore).
	- fixed compile time warnings with the dbg() macro (something
	  better should be used here, I just commented it out...)
	- changed the dev file to print out the kdev value, not be the
	  actual block device.

With regards to the last change, I didn't follow the way the other files
operate with their complex page creation structure, as this is only a
simple one line file.  If the lvm developers want me to change this, I
will.  If not, I would argue that a number of the other files created
should be changed to use this simpler format.  Or is there some reason
for creating these lists of pages that I'm missing?

Comments welcome.

thanks,

greg k-h


diff -Nru a/Documentation/filesystems/dmfs.txt b/Documentation/filesystems/dmfs.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/filesystems/dmfs.txt	Thu Dec 12 17:24:06 2002
@@ -0,0 +1,74 @@
+Overview
+--------
+
+dmfs is a little custom filesystem used as a user interface to the
+device-mapper driver.  The directory heirarchy follows this pattern:
+
+/
+  <namespace1>/
+    <device name1>/
+      table
+      suspend
+      status
+      devices
+      dev
+    <device name2>/
+    ...
+
+  <namespace2>
+   ...
+
+
+Examples
+--------
+
+Example commands will make things a bit clearer:
+
+- To mount the filesystem
+
+  mount -r dmfs none /dev/mapper
+
+- Create a namespace for LVM
+
+  cd /dev/mapper
+  mkdir LVM
+  cd LVM
+
+- Create a new device, that is a linear catenation of parts of 2
+  disks.
+
+  mkdir vg0-music
+  cd vg0-music
+  echo -e "0 56 linear /dev/hda3 0\n56 102344 linear /dev/hda4 0" > table
+
+- Remind yourself what table is running
+
+  cat table
+
+- The 'dev' file should now have appeared.  It shows the major/minor value
+  that you can use to mount your new device.
+
+- To suspend the device
+
+  echo -n 1 > suspend
+
+- To resume
+
+  echo -n 0 > suspend
+
+- To find out the status of the targets in the table
+
+  cat status
+
+- Which sub devices are in use ?
+
+  cat devices
+
+- You may hard link device directories between different namespaces to
+  create aliases (eg, LVM likes to associate a unique id with every
+  device as well as giving it a more human readable name).
+
+  cd /dev/mapper
+  mkdir UUID
+  cd UUID
+  ln ../LVM/vg0-music Qmd96y-771S-Esbb-Zp6u-8xo9-Cfmt-YvndHY
diff -Nru a/drivers/md/Kconfig b/drivers/md/Kconfig
--- a/drivers/md/Kconfig	Thu Dec 12 17:24:06 2002
+++ b/drivers/md/Kconfig	Thu Dec 12 17:24:06 2002
@@ -145,5 +145,18 @@
 
 	  If unsure, say N.
 
+config BLK_DEV_DM_FS
+	tristate "Filesystem interface (experimental)"
+	depends on BLK_DEV_DM
+	depends on EXPERIMENTAL
+	---help---
+	  Ram-based filesytem for controlling device-mapper.  Can co-exist
+	  with the ioctl interface.
+
+	  If you want to compile this as a module, say M here and read 
+	  <file:Documentation/modules.txt>.  The module will be called dm-fs.o.
+
+	  If unsure, say N.
+
 endmenu
 
diff -Nru a/drivers/md/Makefile b/drivers/md/Makefile
--- a/drivers/md/Makefile	Thu Dec 12 17:24:06 2002
+++ b/drivers/md/Makefile	Thu Dec 12 17:24:06 2002
@@ -3,8 +3,7 @@
 #
 
 export-objs	:= md.o xor.o dm-table.o dm-target.o
-dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
-		   dm-ioctl.o
+dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o
 
 # Note: link order is important.  All raid personalities
 # and xor.o must come before md.o, as they each initialise 
@@ -17,7 +16,8 @@
 obj-$(CONFIG_MD_RAID5)		+= raid5.o xor.o
 obj-$(CONFIG_MD_MULTIPATH)	+= multipath.o
 obj-$(CONFIG_BLK_DEV_MD)	+= md.o
-obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
+obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o dm-ioctl.o
+obj-$(CONFIG_BLK_DEV_DM_FS)	+= dm-fs.o
 
 include $(TOPDIR)/Rules.make
 
diff -Nru a/drivers/md/dm-fs.c b/drivers/md/dm-fs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/md/dm-fs.c	Thu Dec 12 17:24:06 2002
@@ -0,0 +1,1237 @@
+/*
+ * Copyright (C) 2002 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ *
+ * Filesystem interface to device-mapper:
+ *
+ * You can only mkdir in the top directory, every directory you
+ * create equates to a device.  The device dir will contain 5
+ * files:
+ *
+ * <dev>/table
+ * <dev>/status
+ * <dev>/suspend
+ * <dev>/devices
+ * <dev>/dev - The value of the new device node
+ */
+
+#include "dm.h"
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/ctype.h>
+#include <linux/vmalloc.h>
+#include <linux/namei.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+
+#define dbg(x...) //DMWARN(## x)
+
+/*-----------------------------------------------------------------
+ * Each device directory has an associate dmfs_dir struct.
+ *---------------------------------------------------------------*/
+struct dmfs_dir {
+	atomic_t holders;
+
+	spinlock_t lock;
+	struct mapped_device *md;
+
+	struct dentry *table_dentry;
+	struct dentry *status_dentry;
+	struct dentry *suspend_dentry;
+	struct dentry *subdevs_dentry;
+	struct dentry *dev_dentry;
+};
+
+static int create_file(const char *name, mode_t mode, dev_t dev,
+		       struct dentry *parent,
+		       struct file_operations *fops, struct dentry **dentry);
+static void dmfs_dir_destroy(struct dmfs_dir *dd);
+static struct inode *dmfs_get_inode(struct super_block *sb, int mode, int dev);
+static int create_dev_files(struct dmfs_dir *dd);
+
+static inline void dmfs_get_dir(struct dmfs_dir *dd)
+{
+	atomic_inc(&dd->holders);
+}
+
+static inline void dmfs_put_dir(struct dmfs_dir *dd)
+{
+	if (atomic_dec_and_test(&dd->holders))
+		dmfs_dir_destroy(dd);
+}
+
+/*-----------------------------------------------------------------
+ * Manage a set of pages for storing a file.
+ *---------------------------------------------------------------*/
+struct dmfs_file {
+	struct dmfs_dir *owner;
+	atomic_t holders;
+
+	/* The lock protects len, and the pages list/contents */
+	spinlock_t lock;
+	struct list_head pages;
+	loff_t len;
+};
+
+static struct dmfs_file *file_alloc(struct dmfs_dir *owner)
+{
+	struct dmfs_file *f;
+
+	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	if (f) {
+		dmfs_get_dir(owner);
+		f->owner = owner;
+		atomic_set(&f->holders, 1);
+		f->lock = SPIN_LOCK_UNLOCKED;
+		f->len = 0;
+		INIT_LIST_HEAD(&f->pages);
+	}
+
+	return f;
+}
+
+static inline void file_get(struct dmfs_file *f)
+{
+	atomic_inc(&f->holders);
+}
+
+static void file_put(struct dmfs_file *f)
+{
+	struct list_head *pos, *n;
+
+	if (atomic_dec_and_test(&f->holders)) {
+		dbg("destroying dmfs_file");
+		dmfs_put_dir(f->owner);
+
+		list_for_each_safe (pos, n, &f->pages) {
+			struct page *p = list_entry(pos, struct page, list);
+			__free_page(p);
+		}
+		kfree(f);
+	}
+}
+
+/*
+ * Returns the page from the list that has data starting at the
+ * offset 'len'.  If 'fill' is true then extra pages may be allocated.
+ */
+static struct page *find_page(struct dmfs_file *f, loff_t len, int fill)
+{
+	struct page *p = NULL;
+	struct list_head *pos;
+
+	/*
+	 * Find the right page.
+	 */
+	list_for_each (pos, &f->pages) {
+		if (len < PAGE_SIZE) {
+			p = list_entry(pos, struct page, list);
+			break;
+		}
+
+		len -= PAGE_SIZE;
+	}
+
+	if (!p && fill) {
+		/* we need to allocate new pages */
+		do {
+			void *addr = (void *) __get_free_page(GFP_KERNEL);
+			if (!addr)
+				return NULL;
+
+			p = virt_to_page(addr);
+			list_add_tail(&p->list, &f->pages);
+			len -= PAGE_SIZE;
+
+		} while (len > 0);
+	}
+
+	return p;
+}
+
+/*
+ * This function moves data in or out of the pages that make up
+ * our table file.
+ */
+typedef ssize_t (*io_actor)(char *file_buff, char *client_buff, size_t count);
+
+static ssize_t __io(struct dmfs_file *f, loff_t start,
+		    char *buff, size_t count, int fill, io_actor fn)
+{
+	ssize_t r;
+	size_t page_offset;
+	struct page *p;
+	char *data;
+
+	p = find_page(f, start, fill);
+	if (!p)
+		return 0;	/* no data */
+
+	page_offset = start & (PAGE_SIZE - 1);
+	data = page_address(p) + page_offset;
+
+	/* stay in this page */
+	if (count > (PAGE_SIZE - page_offset))
+		count = PAGE_SIZE - page_offset;
+
+	/* stay in this file */
+	if (!fill && (count > (f->len - start)))
+		count = f->len - start;
+
+	r = fn(data, buff, count);
+	if (r < 0)
+		return r;
+
+	/* have we lengthened the file ? */
+	if (f->len < (start + r))
+		f->len = start + r;
+
+	return r;
+}
+
+/*
+ * Keeps resubmitting until there is an error, or all the io has
+ * completed.
+ */
+static ssize_t file_io(struct dmfs_file *f, loff_t start,
+		       char *buff, size_t count, int fill, io_actor fn)
+{
+	size_t this_io, total = 0;
+
+	spin_lock(&f->lock);
+	do {
+		this_io = __io(f, start, buff, count - total, fill, fn);
+		if (this_io < 0) {
+			total = this_io;
+			break;
+		}
+
+		total += this_io;
+		start += this_io;
+
+	} while (this_io && (total != count));
+
+	spin_unlock(&f->lock);
+
+	return total;
+}
+
+static ssize_t user_read_fn(char *file_buff, char *client_buff, size_t count)
+{
+	return copy_to_user(client_buff, file_buff, count) ? -EFAULT : count;
+}
+
+static ssize_t user_write_fn(char *file_buff, char *client_buff, size_t count)
+{
+	return copy_from_user(file_buff, client_buff, count) ? -EFAULT : count;
+}
+
+static ssize_t kernel_read_fn(char *file_buff, char *client_buff, size_t count)
+{
+	memcpy(client_buff, file_buff, count);
+	return count;
+}
+
+static ssize_t kernel_write_fn(char *file_buff, char *client_buff,
+			       size_t count)
+{
+	memcpy(file_buff, client_buff, count);
+	return count;
+}
+
+/*-----------------------------------------------------------------
+ * Protect accessing the dd->md field with a spin lock, taking
+ * care to increment the md's reference count whilst still within
+ * the lock.
+ *---------------------------------------------------------------*/
+static inline struct mapped_device *get_dm_from_dir(struct dmfs_dir *dd)
+{
+	struct mapped_device *md;
+
+	spin_lock(&dd->lock);
+	md = dd->md;
+	if (md)
+		dm_get(md);
+	spin_unlock(&dd->lock);
+
+	return md;
+}
+
+static inline void set_dm_in_dir(struct dmfs_dir *dd,
+				 struct mapped_device *md)
+{
+	spin_lock(&dd->lock);
+	if (dd->md)
+		dm_put(dd->md);
+	dm_get(md);
+	dd->md = md;
+	spin_lock(&dd->lock);
+}
+
+/*-----------------------------------------------------------------
+ * File ops for the 'table' file, we keep the last successfully
+ * parsed table (ie. the one that's running) in the
+ * inode->u.generic_ip, and the table being loaded in
+ * file->private_data.
+ *---------------------------------------------------------------*/
+static spinlock_t _table_lock = SPIN_LOCK_UNLOCKED;
+static struct dmfs_file *get_old_table(struct file *file)
+{
+	struct dmfs_file *f;
+
+	spin_lock(&_table_lock);
+	f = file->f_dentry->d_inode->u.generic_ip;
+	if (f)
+		file_get(f);
+	spin_unlock(&_table_lock);
+
+	return f;
+}
+
+static void set_old_table(struct file *file, struct dmfs_file *f)
+{
+	struct dmfs_file *old;
+
+	spin_lock(&_table_lock);
+	old = file->f_dentry->d_inode->u.generic_ip;
+	if (old)
+		file_put(old);
+
+	file_get(f);
+	file->f_dentry->d_inode->u.generic_ip = f;
+	spin_unlock(&_table_lock);
+}
+
+/*
+ * Gets the dmfs_dir from the inode of the parent directory of
+ * file.
+ */
+static inline struct dmfs_dir *lookup_dmfs_dir(struct file *file)
+{
+	return file->f_dentry->d_parent->d_inode->u.generic_ip;
+}
+
+/*
+ * Create a struct table_file to read the new table into.
+ */
+static int table_open(struct inode *inode, struct file *file)
+{
+	struct dmfs_dir *dd = lookup_dmfs_dir(file);
+	struct dmfs_file *f;
+
+	f = file_alloc(dd);
+	if (!f)
+		return -ENOMEM;
+
+	file->private_data = f;
+	return 0;
+}
+
+static ssize_t table_read(struct file *file,
+			  char *buf, size_t count, loff_t *offset)
+{
+	ssize_t r = 0;
+	struct dmfs_file *f = get_old_table(file);
+
+	/* has a table been successfully bound ? */
+	if (f) {
+		r = file_io(f, *offset, buf, count, 0, user_read_fn);
+		if (r > 0)
+			*offset += r;
+
+		file_put(f);
+	}
+
+	return r;
+}
+
+static ssize_t table_write(struct file *file, const char *ubuff,
+			   size_t count, loff_t *offset)
+{
+	ssize_t r;
+	struct dmfs_file *f = file->private_data;
+
+	r = file_io(f, *offset, (char *) ubuff, count, 1, user_write_fn);
+	if (r > 0)
+		*offset += r;
+
+	return r;
+}
+
+static int parse_line(struct dm_table *table, char *line)
+{
+	int r, pos;
+	sector_t start, len;
+	char target[32];
+
+	dbg("parsing '%s'", line);
+	r = sscanf(line, SECTOR_FORMAT " " SECTOR_FORMAT " %32s%n",
+		   &start, &len, target, &pos);
+	if (r != 3) {
+		DMERR("badly formed target line: %s", line);
+		return -EINVAL;
+	}
+
+	line += pos;
+
+	/* Add the target to the table */
+	if (dm_table_add_target(table, target, start, len, line)) {
+		DMERR("internal error adding target to table");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static char *eat_space(char *str)
+{
+	int comment = 0;
+
+	while (*str) {
+		if (*str == '#')
+			comment = 1;
+
+		if (!isspace(*str) && !comment)
+			break;
+
+		str++;
+	}
+
+	return str;
+}
+
+static int get_line(struct dmfs_file *f, loff_t offset,
+		    char *buffer, size_t buffer_len)
+{
+	int n, i;
+
+	n = file_io(f, offset, buffer, buffer_len, 0, kernel_read_fn);
+	if (n <= 0)
+		return n;
+
+	for (i = 0; i < n; i++) {
+		if (buffer[i] == '\n') {
+			buffer[i] = '\0';
+			return (i + 1);
+		}
+	}
+
+	/* the last line might not have a newline */
+	if (i < buffer_len) {
+		buffer[i] = '\0';
+		return i;
+	}
+
+	return -EIO;
+}
+
+#define LINE_SIZE 512
+static int parse_table(struct dmfs_file *f, struct dm_table **result)
+{
+	int r;
+	struct dm_table *table = NULL;
+	loff_t offset = 0;
+	char *buffer, *line;
+
+	/* allocate a little buffer for building the lines up in */
+	buffer = kmalloc(LINE_SIZE, GFP_KERNEL);
+	if (!buffer) {
+		DMERR("couldn't allocate line buffer");
+		return -ENOMEM;
+	}
+
+	r = dm_table_create(&table, FMODE_READ | FMODE_WRITE);
+	if (r) {
+		DMERR("couldn't create table");
+		goto out;
+	}
+
+	while (1) {
+		r = get_line(f, offset, buffer, LINE_SIZE);
+		if (r == 0)
+			break;
+
+		else if (r < 0)
+			goto out;
+
+		offset += r;
+		line = eat_space(buffer);
+		if (!*line)
+			continue;
+
+		r = parse_line(table, line);
+		if (r)
+			goto out;
+	}
+	r = dm_table_complete(table);
+
+ out:
+	if (r && table) {
+		dm_table_put(table);
+		table = NULL;
+	}
+
+	kfree(buffer);
+	*result = table;
+	return r;
+}
+
+/*
+ * When the table file is closed for a write we try and parse the
+ * new table.  If we successfully parse the new table we swap it
+ * with the old one.
+ */
+static int table_release(struct inode *inode, struct file *file)
+{
+	int r = 0;
+	struct mapped_device *md = NULL;
+	struct dm_table *table;
+	struct dmfs_file *f = file->private_data;
+	struct dmfs_dir *dd;
+
+	/*
+	 * We're only interested if the user has written
+	 * something to the table.
+	 */
+	if (!f->len)
+		goto out;
+
+	/* parse new table */
+	r = parse_table(f, &table);
+	if (r)
+		goto out;
+
+	dd = f->owner;
+	md = get_dm_from_dir(dd);
+	if (md) {
+		/* swap tables */
+		r = dm_swap_table(md, table);
+		if (r)
+			goto out;
+		dbg("new table swapped in");
+	} else {
+		r = dm_create(-1, table, &md);
+		if (r)
+			goto out;
+		set_dm_in_dir(dd, md);
+		dbg("device created");
+
+		r = create_dev_files(dd);
+		if (r)
+			goto out;
+	}
+
+	/*
+	 * The new table becomes the old table.
+	 */
+	set_old_table(file, f);
+
+ out:
+	if (md)
+		dm_put(md);
+
+	if (table)
+		dm_table_put(table);
+
+	file_put(f);
+	return r;
+}
+
+static struct file_operations _table_fops = {
+	.open = table_open,
+	.read =	table_read,
+	.write = table_write,
+	.release = table_release,
+};
+
+/*-----------------------------------------------------------------
+ * File ops for the 'suspend' file
+ *---------------------------------------------------------------*/
+static ssize_t suspend_read(struct file *file,
+			    char *buf, size_t count, loff_t *offset)
+{
+	struct dmfs_dir *dd = lookup_dmfs_dir(file);
+	struct mapped_device *md;
+
+	/* this file is only 1 char long */
+	if ((*offset != 0) || !count)
+		return 0;
+
+	/* has a table been loaded yet ? */
+	md = get_dm_from_dir(dd);
+	if (!md)
+		return 0;
+
+	if (copy_to_user(buf, dm_suspended(md) ? "1" : "0", 1))
+		return -EFAULT;
+	dm_put(md);
+
+	(*offset)++;
+	return 1;
+}
+
+static ssize_t suspend_write(struct file *file, const char *ubuff,
+			     size_t count, loff_t *offset)
+{
+	struct dmfs_dir *dd = lookup_dmfs_dir(file);
+	struct mapped_device *md;
+	char sus_p;
+
+	/* this file is only 1 char long */
+	if ((*offset != 0) || !count)
+		return 0;
+
+	if (copy_from_user(&sus_p, ubuff, 1))
+		return -EFAULT;
+
+	/* has a table been loaded yet ? */
+	md = get_dm_from_dir(dd);
+	if (!md)
+		return 0;
+
+	switch (sus_p) {
+	case '0':
+		dm_resume(md);
+		break;
+
+	case '1':
+		dm_suspend(md);
+		break;
+
+	default:
+		DMERR("badly formed input to suspend file");
+	}
+	dm_put(md);
+	(*offset)++;
+	return 1;
+}
+
+static struct file_operations _suspend_fops = {
+	.read = suspend_read,
+	.write = suspend_write
+};
+
+/*-----------------------------------------------------------------
+ * File ops for the 'status' file.  A snapshot of the status is
+ * generated when the file is opened and freed when the file is
+ * closed.  In addition the poll method will wait until an event
+ * occurs where upon it will regenerate the status file.
+ *---------------------------------------------------------------*/
+static int generate_status(struct dmfs_file *f, struct mapped_device *md)
+{
+	int i, num_targets, r = 0;
+	ssize_t this_write;
+	loff_t offset = 0;
+	struct dm_target *ti;
+	struct dm_table *table = dm_get_table(md);
+	static char buffer[1024];
+
+	/* Get all the target info */
+	num_targets = dm_table_get_num_targets(table);
+	for (i = 0; i < num_targets; i++) {
+		ti = dm_table_get_target(table, i);
+
+		r = snprintf(buffer, sizeof(buffer),
+			     SECTOR_FORMAT " " SECTOR_FORMAT " %s ",
+			     ti->begin, ti->len, ti->type->name);
+		if (r < 0) {
+			DMERR("status too long for buffer");
+			break;
+		}
+
+		/* Get the status/table string from the target driver */
+		if (ti->type->status)
+			ti->type->status(ti, STATUSTYPE_INFO,
+					 buffer + r, sizeof(buffer) - r);
+
+		/* write the status line to the status file */
+		r = 0;
+		this_write = file_io(f, offset, buffer,
+				     strlen(buffer), 1, kernel_write_fn);
+		if (this_write < 0) {
+			r = this_write;
+			break;
+		}
+		offset += this_write;
+
+		/* write a newline */
+		this_write = file_io(f, offset, "\n", 1, 1, kernel_write_fn);
+		if (this_write < 0) {
+			r = this_write;
+			break;
+		}
+		offset += this_write;
+	}
+
+	dm_table_put(table);
+	return r;
+}
+
+static int status_open(struct inode *inode, struct file *file)
+{
+	int r;
+	struct dmfs_dir *dd = lookup_dmfs_dir(file);
+	struct mapped_device *md;
+	struct dmfs_file *f;
+
+	md = get_dm_from_dir(dd);
+	if (!md)
+		return -ENXIO;
+
+	f = file_alloc(dd);
+	if (!f) {
+		dm_put(md);
+		return -ENOMEM;
+	}
+
+	r = generate_status(f, md);
+	if (r) {
+		dm_put(md);
+		file_put(f);
+		return r;
+	}
+
+	dm_put(md);
+	file->private_data = f;
+	return r;
+}
+#if 0
+static unsigned int status_poll(struct file *file,
+				struct poll_table_struct *pts)
+{
+	struct mapped_device *md;
+	struct dm_table *table;
+	DECLARE_WAITQUEUE(wq, current);
+
+	md = get_dm_from_dir(dd);
+	if (!md)
+		return -ENXIO;
+
+	table = dm_get_table(md);
+	dm_put(md);
+
+	/*
+	 * Wait for a notification event
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	dm_table_add_wait_queue(table, &wq);
+	dm_table_put(table);
+
+	yield();
+	set_current_state(TASK_RUNNING);
+
+	/* FIXME: regenerate the status file */
+	return 0;
+}
+#endif
+static ssize_t status_read(struct file *file,
+			   char *buf, size_t count, loff_t *offset)
+{
+	ssize_t r;
+	struct dmfs_file *f = file->private_data;
+
+	r = file_io(f, *offset, buf, count, 0, user_read_fn);
+	if (r > 0)
+		*offset += r;
+
+	return r;
+}
+
+static int status_release(struct inode *inode, struct file *file)
+{
+	struct dmfs_file *f = file->private_data;
+	file_put(f);
+	return 0;
+}
+
+static struct file_operations _status_fops = {
+	.open = status_open,
+	/*.poll = status_poll,*/
+	.read = status_read,
+	.release = status_release,
+};
+
+/*-----------------------------------------------------------------
+ * File ops for the 'devices' file
+ *---------------------------------------------------------------*/
+static int generate_subdevs(struct dmfs_file *file, struct mapped_device *md)
+{
+	static char buffer[1024];
+
+	int r = 0;
+	ssize_t this_write;
+	loff_t offset = 0;
+	struct dm_table *table = dm_get_table(md);
+	struct list_head *pos;
+
+	/* Get all the device info */
+	list_for_each(pos, dm_table_get_devices(table)) {
+		struct dm_dev *dd = list_entry(pos, struct dm_dev, list);
+
+		snprintf(buffer, sizeof(buffer), "%d:%d\n",
+			 MAJOR(dd->bdev->bd_dev), MINOR(dd->bdev->bd_dev));
+
+		this_write = file_io(file, offset, buffer,
+				     strlen(buffer), 1, kernel_write_fn);
+		if (this_write < 0) {
+			r = this_write;
+			break;
+		}
+
+		offset += this_write;
+	}
+
+	dm_table_put(table);
+	return r;
+}
+
+static int subdevs_open(struct inode *inode, struct file *file)
+{
+	int r;
+	struct dmfs_dir *dd = lookup_dmfs_dir(file);
+	struct mapped_device *md;
+	struct dmfs_file *f;
+
+	f = file_alloc(dd);
+	if (!f)
+		return -ENOMEM;
+
+	md = get_dm_from_dir(dd);
+	if (!md) {
+		file_put(f);
+		return -ENXIO;
+	}
+
+	r = generate_subdevs(f, md);
+	if (r) {
+		dm_put(md);
+		file_put(f);
+		return r;
+	}
+
+	dm_put(md);
+	file->private_data = f;
+	return r;
+}
+
+static ssize_t subdevs_read(struct file *file,
+			    char *buf, size_t count, loff_t *offset)
+{
+	ssize_t r;
+	struct dmfs_file *f = file->private_data;
+	r = file_io(f, *offset, buf, count, 0, user_read_fn);
+	if (r > 0)
+		*offset += r;
+
+	return r;
+}
+
+static int subdevs_release(struct inode *inode, struct file *file)
+{
+	file_put((struct dmfs_file *) file->private_data);
+	return 0;
+}
+
+static struct file_operations _subdevs_fops = {
+	.open = subdevs_open,
+	.read = subdevs_read,
+	.release = subdevs_release,
+};
+
+/*-----------------------------------------------------------------
+ * File ops for the 'dev' file
+ *---------------------------------------------------------------*/
+static int dev_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static ssize_t dev_read(struct file *file,
+			    char *buf, size_t count, loff_t *offset)
+{
+	struct dmfs_dir *dd;
+	struct gendisk *disk;
+	kdev_t kdev;
+	unsigned char *page;
+	int retval;
+	int len;
+	
+	if (*offset < 0)
+		return -EINVAL;
+	if (count <= 0)
+		return 0;
+	if (*offset != 0)
+		return 0;
+
+	page = (unsigned char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	dd = lookup_dmfs_dir(file);
+	disk = dm_disk(dd->md);
+	kdev = mk_kdev(disk->major, disk->first_minor);
+	
+	len = sprintf(page, "%x\n", kdev.value);
+	if (copy_to_user (buf, page, len)) {
+		return -EFAULT;
+		goto exit;
+	}
+	*offset += len;
+	retval = len;
+
+exit:
+	free_page((unsigned long)page);
+	return retval;
+}
+
+static struct file_operations _dev_fops = {
+	.open = dev_open,
+	.read = dev_read,
+};
+
+/*-----------------------------------------------------------------
+ * Directory ops
+ *---------------------------------------------------------------*/
+static int create_file(const char *name, mode_t mode, dev_t dev,
+		       struct dentry *parent,
+		       struct file_operations *fops, struct dentry **dentry)
+{
+	struct dentry *d = NULL;
+	struct qstr qstr;
+	int r;
+
+	*dentry = NULL;
+	qstr.name = name;
+	qstr.len = strlen(name);
+	qstr.hash = full_name_hash(name,qstr.len);
+
+	parent = dget(parent);
+
+	down(&parent->d_inode->i_sem);
+
+	d = lookup_hash(&qstr,parent);
+
+	r = PTR_ERR(d);
+	if (!IS_ERR(d)) {
+		switch(mode & S_IFMT) {
+		case 0:
+		case S_IFREG:
+			r = vfs_create(parent->d_inode, d, mode);
+			break;
+
+		case S_IFBLK:
+			r = vfs_mknod(parent->d_inode, d, mode, dev);
+			break;
+
+		default:
+			DMERR("cannot create special files\n");
+		}
+
+
+		if (fops)
+			d->d_inode->i_fop = fops;
+		*dentry = d;
+	}
+	up(&parent->d_inode->i_sem);
+	dput(parent);
+	return r;
+}
+
+static inline int positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
+static void __remove_file(struct dentry *d)
+{
+	struct dentry *parent = d->d_parent;
+
+	if (!parent || !parent->d_inode)
+		return;
+
+	/*
+	 * The parent inode will already be locked when we get in
+	 * here.
+	 */
+	if (positive(d)) {
+		if (d->d_inode)
+			vfs_unlink(parent->d_inode, d);
+
+		dput(d);
+	}
+}
+
+static void remove_file(struct dentry *d)
+{
+	if (d)
+		__remove_file(d);
+}
+
+static void dmfs_dir_destroy(struct dmfs_dir *dd)
+{
+	dbg("destroying dmfs_dir %p", dd);
+	if (dd->md)
+		dm_put(dd->md);
+
+	remove_file(dd->table_dentry);
+	remove_file(dd->status_dentry);
+	remove_file(dd->suspend_dentry);
+	remove_file(dd->subdevs_dentry);
+	remove_file(dd->dev_dentry);
+	kfree(dd);
+}
+
+static int create_dev_files(struct dmfs_dir *dd)
+{
+	const mode_t mode = S_IFREG | 0755;
+	struct dentry *dir_dentry = dd->table_dentry->d_parent;
+	int r;
+
+	r = create_file("suspend", mode, 0, dir_dentry,
+			&_suspend_fops, &dd->suspend_dentry);
+	if (r) {
+		dbg("couldn't create suspend file");
+		goto out;
+	}
+
+	r = create_file("status", mode, 0, dir_dentry,
+			&_status_fops, &dd->status_dentry);
+	if (r) {
+		dbg("couldn't create status file");
+		goto out;
+	}
+
+	r = create_file("devices", mode, 0, dir_dentry,
+			&_subdevs_fops, &dd->subdevs_dentry);
+	if (r) {
+		dbg("couldn't create devices file");
+		goto out;
+	}
+
+	r = create_file("dev", mode, 0, dir_dentry,
+			&_dev_fops, &dd->subdevs_dentry);
+	if (r) {
+		dbg("couldn't create dev file");
+		goto out;
+	}
+	
+
+ out:
+	return r;
+}
+
+static struct dmfs_dir *dmfs_dir_create(struct dentry *dir_dentry)
+{
+	int r;
+	struct dmfs_dir *dd;
+	mode_t mode = S_IFREG | 0755;
+
+	dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+	if (!dd)
+		return NULL;
+
+	memset(dd, 0, sizeof(*dd));
+	dd->lock = SPIN_LOCK_UNLOCKED;
+
+	r = create_file("table", mode, 0, dir_dentry,
+			&_table_fops, &dd->table_dentry);
+	if (r) {
+		dmfs_dir_destroy(dd);
+		return NULL;
+	}
+
+	return dd;
+}
+
+static int dmfs_mknod(struct inode *dir, struct dentry *dentry,
+		      int mode, dev_t dev)
+{
+	struct inode *inode;
+
+	inode = dmfs_get_inode(dir->i_sb, mode, dev);
+	if (!inode)
+		return -ENOSPC;
+
+	d_instantiate(dentry, inode);
+	dget(dentry);		/* Extra count - pin the dentry in core */
+	return 0;
+}
+
+static int dmfs_create(struct inode *dir, struct dentry *dentry, int mode)
+{
+	return dmfs_mknod(dir, dentry, mode | S_IFREG, 0);
+}
+
+static struct inode_operations _devdir_iops = {
+	.create = dmfs_create,
+	.lookup	= simple_lookup,
+	.mknod = dmfs_mknod,
+};
+
+static struct inode *dmfs_get_inode(struct super_block *sb, int mode, int dev)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_rdev = NODEV;
+		inode->i_atime =
+			inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		switch (mode & S_IFMT) {
+		default:
+			init_special_inode(inode, mode, dev);
+			break;
+
+		case S_IFREG:
+			inode->i_fop = &simple_dir_operations;
+			break;
+
+		case S_IFDIR:
+			inode->i_op = &_devdir_iops;
+			inode->i_fop = &simple_dir_operations;
+
+			/*
+			 * Directory inodes start off with
+			 * i_nlink == 2 (for "." entry).
+			 */
+			inode->i_nlink++;
+			break;
+		}
+	}
+
+	return inode;
+}
+
+static int dmfs_namespace_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int r;
+	struct dmfs_dir *n;
+
+	r = dmfs_mknod(dir, dentry, S_IFDIR | mode, 0);
+	if (r)
+		return r;
+
+	n = dmfs_dir_create(dentry);
+	if (!n) {
+		/* FIXME: check this */
+		dput(dentry);
+		return -ENOMEM;
+	}
+
+	dentry->d_inode->u.generic_ip = n;
+	dir->i_nlink++;
+	return 0;
+}
+
+static int dmfs_namespace_rmdir(struct inode *inode, struct dentry *d)
+{
+	struct dmfs_dir *dd = d->d_inode->u.generic_ip;
+
+	dbg("dmfs_root_rmdir, freeing %p", dd);
+	dmfs_put_dir(dd);
+
+	d->d_inode->i_nlink--;
+	simple_unlink(inode, d);
+	inode->i_nlink--;
+	return 0;
+}
+
+static struct inode_operations _namespace_iops = {
+	.lookup = simple_lookup,
+	.unlink = simple_unlink,
+	.mkdir = dmfs_namespace_mkdir,
+	.rmdir = dmfs_namespace_rmdir,
+	.rename = simple_rename,
+};
+
+static int dmfs_root_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int r;
+
+	r = dmfs_mknod(dir, dentry, S_IFDIR | mode, 0);
+	if (r)
+		return r;
+
+	dentry->d_inode->i_op = &_namespace_iops;
+	dir->i_nlink++;
+	return 0;
+}
+
+static struct inode_operations _root_iops = {
+	.lookup = simple_lookup,
+	.unlink = simple_unlink,
+	.mkdir = dmfs_root_mkdir,
+	.rmdir = simple_rmdir,
+	.rename = simple_rename,
+};
+
+/*-----------------------------------------------------------------
+ * super operations
+ *---------------------------------------------------------------*/
+/* Random magic number */
+#define DMFS_MAGIC 0x23112671
+
+static struct super_operations _dmfs_super_ops = {
+	statfs:         simple_statfs,
+	delete_inode:   generic_delete_inode,
+};
+
+static int dmfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = DMFS_MAGIC;
+	sb->s_op = &_dmfs_super_ops;
+	inode = dmfs_get_inode(sb, S_IFDIR | 0755, 0);
+	if (!inode) {
+		DMERR("%s: could not get inode!\n",__FUNCTION__);
+		return -ENOMEM;
+	}
+
+	/* You can only make directories in the root dir */
+	inode->i_op = &_root_iops;
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		DMERR("%s: could not get root dentry!\n",__FUNCTION__);
+		iput(inode);
+		return -ENOMEM;
+	}
+	sb->s_root = root;
+	return 0;
+}
+
+static struct super_block *dmfs_get_sb(struct file_system_type *fs_type,
+				       int flags, char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, dmfs_fill_super);
+}
+
+static struct file_system_type _dmfs_type = {
+	.name = "dmfs",
+	.get_sb	= dmfs_get_sb,
+	.kill_sb = kill_litter_super,
+};
+
+static int dm_interface_init(void)
+{
+	return register_filesystem(&_dmfs_type);
+}
+
+static void dm_interface_exit(void)
+{
+	unregister_filesystem(&_dmfs_type);
+}
+
+module_init(dm_interface_init);
+module_exit(dm_interface_exit);
diff -Nru a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
--- a/drivers/md/dm-ioctl.c	Thu Dec 12 17:24:06 2002
+++ b/drivers/md/dm-ioctl.c	Thu Dec 12 17:24:06 2002
@@ -1073,7 +1073,7 @@
 /*
  * Create misc character device and link to DM_DIR/control.
  */
-int __init dm_interface_init(void)
+static int dm_interface_init(void)
 {
 	int r;
 
@@ -1105,7 +1105,7 @@
 	return r;
 }
 
-void dm_interface_exit(void)
+static void dm_interface_exit(void)
 {
 	dm_hash_exit();
 
@@ -1114,3 +1114,6 @@
 	if (misc_deregister(&_dm_misc) < 0)
 		DMERR("misc_deregister failed for control device");
 }
+
+module_init(dm_interface_init);
+module_exit(dm_interface_exit);
diff -Nru a/drivers/md/dm.c b/drivers/md/dm.c
--- a/drivers/md/dm.c	Thu Dec 12 17:24:06 2002
+++ b/drivers/md/dm.c	Thu Dec 12 17:24:06 2002
@@ -125,7 +125,6 @@
 	xx(dm_target)
 	xx(dm_linear)
 	xx(dm_stripe)
-	xx(dm_interface)
 #undef xx
 };
 
diff -Nru a/drivers/md/dm.h b/drivers/md/dm.h
--- a/drivers/md/dm.h	Thu Dec 12 17:24:06 2002
+++ b/drivers/md/dm.h	Thu Dec 12 17:24:06 2002
@@ -130,13 +130,6 @@
 }
 
 /*
- * The device-mapper can be driven through one of two interfaces;
- * ioctl or filesystem, depending which patch you have applied.
- */
-int dm_interface_init(void);
-void dm_interface_exit(void);
-
-/*
  * Targets for linear and striped mappings
  */
 int dm_linear_init(void);
