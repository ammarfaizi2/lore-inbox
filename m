Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbRESGZX>; Sat, 19 May 2001 02:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbRESGZF>; Sat, 19 May 2001 02:25:05 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:10475 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S261658AbRESGYs>; Sat, 19 May 2001 02:24:48 -0400
Date: Sat, 19 May 2001 02:23:59 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: <torvalds@transmeta.com>
cc: <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: [RFD w/info-PATCH] device arguments from lookup, partion code in
 userspace
Message-ID: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

The work-in-progress patch for-demonstration-purposes-only below consists
of 3 major components, and is meant to start discussion about the future
direction of device naming and its interaction block layer.  The main
motivations here are the wasting of minor numbers for partitions, and the
duplication of code between user and kernel space in areas such as
partition detection, uuid location, lvm setup, mount by label, journal
replay, and so on...

1. Generic lookup method and argument parsiing (fs/lookupargs.c)

	This code implements a lookup function which is for demonstration
	purposes used in fs/block_dev.c.  The general idea is to pass
	additional parameters to device drivers on open via a comma
	seperated list of options following the device's name.  Sample
	uses:

		/dev/sda/raw		-> open sda in raw mode.
		/dev/sda/limit=102400	-> open sda with a limit of 100K
		/dev/sda/offset=1024,limit=2048
			-> open a device that gives a view of sda at an
			   offset of 1KB to 2KB

	The arguments are defined in a table (fs/block_dev.c:660), which
	defines the name and type of argument to parse.  This table is
	used at lookup time to determine if an option name is valid
	(resulting in a postive dentry) or invalid.  Potential uses for
	this are numerous: opening a control channel to a device,
	specifying a graphics mode for a framebuffer on open, replacing
	ioctls, .... lots of options.  Please seperate comments on this
	portion from the other parts of the patch.

2. Restricted block device (drivers/block/blkrestrict.c)

	This is a quick-n-dirty implementation of a simple md-like block
	device that adds an offset to sector requests and limits the
	maximum offset on the device.  The idea here is to replace the
	special case minor numbers used for the partitioning code with
	a generic runtime allocated translation node.  The idea will work
	best once its data can be stored in a kdev_t structure.  The API
	for use is simple:

		kdev_t restrict_create_dev(kdev_t dev,
				unsigned long long offset,
				unsigned long long limit)

	The associated cleanup of the startup code is not addressed here.
	Comments on this part (I know the implementation is ugly, talk
	about the ideas please)?

3. Userspace partition code proposal

	Given the above two bits, here's a brief explaination of a
	proposal to move management of the partitioning scheme into
	userspace, along with portions of raid startup, lvm, uuid and
	mount by label code needed for mounting the root filesystem.

	Consider that the device node currently known as /dev/hda5 can
	also be viewed as /dev/hda at offset 512000 with a limit of 10GB.
	With the extensions in fs/block_dev.c, you could replace /dev/hda5
	with /dev/hda/offset=512000,limit=10240000000.  Now, by putting
	the partition parsing code into a libpart and binding mount to a
	libpart, the root filesystem mounting code can be run out of an
	initrd image.  The use of mount gives us the ability to mount
	filesystems by UUID, by label or other exotic schemes without
	having to add any additional code to the kernel.

I'm going to stop writing this now.  I need sleep...

Folks, please let me know your opinions on the ideas presented herein, and
do attempt to keep the bits of code that are useful.  Cheers,

		-ben

[23:34:07] <viro> bcrl: you are sick.
[23:41:13] <viro> bcrl: you _are_ sick.
[23:43:24] <viro> bcrl: you are _fscking_ sick.

here starts v2.4.5-pre3_bdev_naming-A0.diff
diff -urN kernels/2.4/v2.4.5-pre3/Makefile bdev_naming/Makefile
--- kernels/2.4/v2.4.5-pre3/Makefile	Thu May 17 18:09:42 2001
+++ bdev_naming/Makefile	Sat May 19 01:33:39 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 5
-EXTRAVERSION =-pre3
+EXTRAVERSION =-pre3-sick-test

 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

diff -urN kernels/2.4/v2.4.5-pre3/arch/i386/boot/install.sh bdev_naming/arch/i386/boot/install.sh
--- kernels/2.4/v2.4.5-pre3/arch/i386/boot/install.sh	Tue Jan  3 06:57:26 1995
+++ bdev_naming/arch/i386/boot/install.sh	Fri May 18 20:24:36 2001
@@ -21,6 +21,7 @@

 # User may have a custom install script

+if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
 if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi

 # Default install - same as make zlilo
diff -urN kernels/2.4/v2.4.5-pre3/drivers/block/Makefile bdev_naming/drivers/block/Makefile
--- kernels/2.4/v2.4.5-pre3/drivers/block/Makefile	Fri Dec 29 17:07:21 2000
+++ bdev_naming/drivers/block/Makefile	Sat May 19 00:29:08 2001
@@ -12,7 +12,7 @@

 export-objs	:= ll_rw_blk.o blkpg.o loop.o DAC960.o

-obj-y	:= ll_rw_blk.o blkpg.o genhd.o elevator.o
+obj-y	:= ll_rw_blk.o blkpg.o genhd.o elevator.o blkrestrict.o

 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
diff -urN kernels/2.4/v2.4.5-pre3/drivers/block/blkrestrict.c bdev_naming/drivers/block/blkrestrict.c
--- kernels/2.4/v2.4.5-pre3/drivers/block/blkrestrict.c	Wed Dec 31 19:00:00 1969
+++ bdev_naming/drivers/block/blkrestrict.c	Sat May 19 01:17:36 2001
@@ -0,0 +1,105 @@
+/* driver/block/blkrestrict.c - written by Benjamin LaHaise
+ *	Block device limit enforcer.  Designed to implement partition
+ *	tables under control of other code.
+ *
+ *	Copyright 2001 Red Hat, Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ *
+ *	This program is distributed in the hope that it will be useful,
+ *	but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *	GNU General Public License for more details.
+ *
+ *	You should have received a copy of the GNU General Public License
+ *	along with this program; if not, write to the Free Software
+ *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/init.h>
+
+static char major_name[] = "restrict";
+static unsigned int major_nr;
+static unsigned int minor_nr;	/* next free minor number */
+
+static struct restrict_info {
+	unsigned long	offset;
+	unsigned long	limit;
+	kdev_t		dev;
+} restrict_info[256];	/* FIXME: stupid */
+
+static int restrict_blk_size[256];	/* grr */
+
+kdev_t restrict_create_dev(kdev_t dev, unsigned long long offset, unsigned long long limit)
+{
+	unsigned int minor = minor_nr++;	/* FIXME: overflow/smp/fish */
+	struct restrict_info *info = &restrict_info[minor];
+
+	info->offset = offset / 512;
+	info->limit = limit / 512;
+	info->dev = dev;
+
+	restrict_blk_size[minor] = info->limit - info->offset;
+
+	printk("restrict_create_dev: (0x%02x, 0x%02x) offset=0x%lx limit=0x%lx on (0x%04x)\n", major_nr, minor, info->offset, info->limit, info->dev);	/* FIXME: duh */
+
+	return MKDEV(major_nr, minor);
+}
+
+static int restrict_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int restrict_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int restrict_make_req(request_queue_t *q, int rw, struct buffer_head *bh)
+{
+	struct restrict_info *info = &restrict_info[MINOR(bh->b_rdev)];
+	unsigned long new_sector = bh->b_rsector + info->offset;
+
+	if (new_sector >= info->limit || new_sector < bh->b_rsector) {
+		printk("restrict_make_req: 0x%lx beyond limit on 0x%x (0x%lx,0x%lx)\n", bh->b_rsector, bh->b_rdev, info->offset, info->limit);
+		buffer_IO_error(bh);
+		return 0;
+	}
+
+	bh->b_rdev = info->dev;
+	bh->b_rsector += info->offset;
+
+	return 1;
+}
+
+static struct block_device_operations restrict_bdops = {
+	open:		restrict_open,
+	release:	restrict_release,
+};
+
+static int __init blkrestrict_init(void)
+{
+	major_nr = register_blkdev(0, major_name, &restrict_bdops);
+	if (major_nr < 0)
+		return major_nr;
+
+	printk("blkrestrict_init: got major %u\n", major_nr);
+
+	blk_queue_make_request(BLK_DEFAULT_QUEUE(major_nr), restrict_make_req);
+	blk_size[major_nr] = restrict_blk_size;
+
+	return 0;
+}
+
+static void __exit blkrestrict_exit(void)
+{
+	unregister_blkdev(major_nr, major_name);
+}
+
+module_init(blkrestrict_init);
+module_exit(blkrestrict_exit);
diff -urN kernels/2.4/v2.4.5-pre3/fs/Makefile bdev_naming/fs/Makefile
--- kernels/2.4/v2.4.5-pre3/fs/Makefile	Thu Apr  5 11:53:44 2001
+++ bdev_naming/fs/Makefile	Fri May 18 18:49:49 2001
@@ -12,7 +12,7 @@

 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		super.o  block_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
-		ioctl.o readdir.o select.o fifo.o locks.o \
+		ioctl.o readdir.o select.o fifo.o locks.o lookupargs.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o

diff -urN kernels/2.4/v2.4.5-pre3/fs/block_dev.c bdev_naming/fs/block_dev.c
--- kernels/2.4/v2.4.5-pre3/fs/block_dev.c	Thu May 17 18:09:42 2001
+++ bdev_naming/fs/block_dev.c	Sat May 19 01:31:51 2001
@@ -14,9 +14,12 @@
 #include <linux/major.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/lookupargs.h>

 #include <asm/uaccess.h>

+extern kdev_t restrict_create_dev(kdev_t dev, unsigned long long offset, unsigned long long limit);
+
 extern int *blk_size[];
 extern int *blksize_size[];

@@ -648,10 +651,52 @@
 	return ret;
 }

+struct blkdev_param {
+	unsigned long long	offset,
+				limit;
+	int			raw;
+};
+
+arg_format_t blkdev_arg_fmt[] = {
+	{ "offset",	Arg_ull,	offsetof(struct blkdev_param, offset) },
+	{ "limit",	Arg_ull,	offsetof(struct blkdev_param, limit) },
+	{ "raw",	Arg_bool,	offsetof(struct blkdev_param, raw) },
+	{ NULL }
+};
+
+static struct dentry *blkdev_lookup(struct inode *inode, struct dentry *dentry)
+{
+	return generic_parse_lookup(inode, dentry, blkdev_arg_fmt);
+}
+
 int blkdev_open(struct inode * inode, struct file * filp)
 {
-	int ret = -ENXIO;
+	int ret;
 	struct block_device *bdev = inode->i_bdev;
+	struct dentry *dentry = filp->f_dentry;
+	struct blkdev_param param = { 0ULL, ~0ULL, 0 };
+
+	if (dentry && dentry->d_parent &&
+	    dentry->d_inode == dentry->d_parent->d_inode) {
+		printk("blkdev_open: args='%*s'\n", dentry->d_name.len, dentry->d_name.name);
+		ret = generic_parse_args(&dentry->d_name, blkdev_arg_fmt, &param);
+		if (ret)
+			return ret;
+		printk("blkdev_open: offset=0x%Lx limit=0x%Lx raw=%d",
+			param.offset, param.limit, param.raw);
+
+		if (param.offset || ~param.limit) {
+			struct inode *old_inode = inode;
+			inode = get_empty_inode();
+			inode->i_rdev = restrict_create_dev(old_inode->i_rdev, param.offset, param.limit);
+			bdev = inode->i_bdev = bdget(inode->i_rdev);
+			filp->f_dentry = d_alloc_root(inode);
+			/* FIXME: error handling, dangling dentry/inode */
+		}
+	}
+
+	ret = -ENXIO;
+
 	down(&bdev->bd_sem);
 	lock_kernel();
 	if (!bdev->bd_op)
@@ -721,6 +766,10 @@
 	write:		block_write,
 	fsync:		block_fsync,
 	ioctl:		blkdev_ioctl,
+};
+
+struct inode_operations def_blk_iops = {
+	lookup:		blkdev_lookup,
 };

 const char * bdevname(kdev_t dev)
diff -urN kernels/2.4/v2.4.5-pre3/fs/devices.c bdev_naming/fs/devices.c
--- kernels/2.4/v2.4.5-pre3/fs/devices.c	Sun Oct  1 23:35:16 2000
+++ bdev_naming/fs/devices.c	Fri May 18 18:41:00 2001
@@ -205,6 +205,7 @@
 		inode->i_rdev = to_kdev_t(rdev);
 	} else if (S_ISBLK(mode)) {
 		inode->i_fop = &def_blk_fops;
+		inode->i_op = &def_blk_iops;
 		inode->i_rdev = to_kdev_t(rdev);
 		inode->i_bdev = bdget(rdev);
 	} else if (S_ISFIFO(mode))
diff -urN kernels/2.4/v2.4.5-pre3/fs/lookupargs.c bdev_naming/fs/lookupargs.c
--- kernels/2.4/v2.4.5-pre3/fs/lookupargs.c	Wed Dec 31 19:00:00 1969
+++ bdev_naming/fs/lookupargs.c	Sat May 19 00:26:31 2001
@@ -0,0 +1,156 @@
+/* fs/lookupargs.c - written by Benjamin LaHaise
+ *	Support for comma seperated argument lists via a lookup method.
+ *	Useful for device drivers and other filesystem entities.
+ *
+ *	Copyright 2001 Red Hat, Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation; either version 2 of
+ *	the License, or (at your option) any later version.
+ *
+ *	This program is distributed in the hope that it will be useful,
+ *	but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *	GNU General Public License for more details.
+ *
+ *	You should have received a copy of the GNU General Public License
+ *	along with this program; if not, write to the Free Software
+ *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <linux/fs.h>
+#include <linux/lookupargs.h>
+
+/* Returns the format if arg is in the list of options */
+static const struct parsed_arg_format *find_arg_fmt(
+	const struct parsed_arg *arg, arg_format_t *fmt)
+{
+	if (fmt)
+	for (; fmt->name; fmt++) {
+		const char *opt = fmt->name;
+
+		if (!memcmp(arg->arg_start, opt, arg->arg_len) &&
+		    strlen(opt) == arg->arg_len) {
+			return fmt;
+		}
+	}
+
+	return NULL;
+}
+
+/* TODO: fix it to actually validate the argument */
+int generic_check_arg(const struct parsed_arg *arg, arg_format_t *fmt)
+{
+	return !find_arg_fmt(arg, fmt);
+}
+
+static int parse_arg(const struct qstr *qstr, int offset, struct parsed_arg *arg)
+{
+	const char *str = qstr->name + offset;
+	int left = qstr->len - offset;
+
+	arg->arg_start = NULL;
+	arg->arg_len = 0;
+	arg->option_start = NULL;
+	arg->option_len = 0;
+
+	if (offset < 0)
+		return -1;
+
+	if (left <= 0)
+		return -1;
+
+	/* First off, scan for the argument name -> ends at end of string,
+	 * an equals sign or comma.
+	 */
+	arg->arg_start = str;
+	for (; left > 0 && (*str != '=') && (*str != ',');
+	     left--,str++)
+		;
+
+	arg->arg_len = str - arg->arg_start;
+
+	/* This argument ends if therer's nothing left or we've hit a comma. */
+	if (left <= 0)
+		goto out;
+
+	left--;
+	if (*str++ == ',')
+		goto out;
+
+	/* Second part: scan the option looking for the end: ends at
+	 * end of string or a comma.
+	 */
+	arg->option_start = str;
+	for (; left > 0 && (*str != ',');
+	     left--,str++) {
+		/* Eat the escaped character */
+		if (*str == '\\' && left > 1)
+			left--, str++;
+	}
+
+	arg->option_len = str - arg->arg_start;
+
+out:
+	return str - (const char *)qstr->name;
+}
+
+/* TODO: FIXME: proper range checking!!! */
+static int fill_arg_data(const struct parsed_arg *arg, arg_format_t *fmt, char *data)
+{
+	char *end;
+
+	data += fmt->offset;
+
+	switch (fmt->type) {
+	case Arg_bool:
+		*(int *)data = 1;
+		return 0;
+	case Arg_ull:
+		if (!arg->option_start || !arg->option_len)
+			break;
+		*(unsigned long long *)data = simple_strtoull(arg->option_start, &end, 10);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+int generic_parse_args(const struct qstr *str, arg_format_t *fmt_list, void *data)
+{
+	int ret = 0;
+	for_each_parsed_arg(str) {
+		arg_format_t *fmt = find_arg_fmt(&arg, fmt_list);
+		ret = -EINVAL;
+		if (!fmt)
+			break;
+		ret = fill_arg_data(&arg, fmt, (char *)data);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+struct dentry *generic_parse_lookup(
+	struct inode *inode,
+	struct dentry *dentry,
+	arg_format_t *fmt_list)
+{
+	/* Application compatibility: report -ENOTDIR on "." and ".." */
+	if (dentry->d_name.name[0] == '.' &&
+	    ((dentry->d_name.len == 1) ||
+	     (dentry->d_name.name[1] == '.' && dentry->d_name.len == 2)))
+		return ERR_PTR(-ENOTDIR);
+
+	/* Make sure all the arguments are okay */
+	{ for_each_parsed_arg(&dentry->d_name) {
+		arg_format_t *fmt = find_arg_fmt(&arg, fmt_list);
+		if (!fmt || generic_check_arg(&arg, fmt)) {
+			inode = NULL;
+			break;
+		}
+	}}
+
+	d_add(dentry, inode);
+	return NULL;
+}
+
diff -urN kernels/2.4/v2.4.5-pre3/fs/namei.c bdev_naming/fs/namei.c
--- kernels/2.4/v2.4.5-pre3/fs/namei.c	Thu May  3 11:22:16 2001
+++ bdev_naming/fs/namei.c	Fri May 18 22:38:50 2001
@@ -470,7 +470,8 @@
 		 * to be able to know about the current root directory and
 		 * parent relationships.
 		 */
-		if (this.name[0] == '.') switch (this.len) {
+		if (this.name[0] == '.' && S_ISDIR(nd->dentry->d_inode->i_mode))
+			switch (this.len) {
 			default:
 				break;
 			case 2:
@@ -538,7 +539,8 @@
 last_component:
 		if (lookup_flags & LOOKUP_PARENT)
 			goto lookup_parent;
-		if (this.name[0] == '.') switch (this.len) {
+		if (this.name[0] == '.' && S_ISDIR(nd->dentry->d_inode->i_mode))
+			switch (this.len) {
 			default:
 				break;
 			case 2:
@@ -593,7 +595,7 @@
 lookup_parent:
 		nd->last = this;
 		nd->last_type = LAST_NORM;
-		if (this.name[0] != '.')
+		if (this.name[0] != '.' || !S_ISDIR(nd->dentry->d_inode->i_mode))
 			goto return_base;
 		if (this.len == 1)
 			nd->last_type = LAST_DOT;
diff -urN kernels/2.4/v2.4.5-pre3/include/linux/fs.h bdev_naming/include/linux/fs.h
--- kernels/2.4/v2.4.5-pre3/include/linux/fs.h	Thu May 17 18:09:42 2001
+++ bdev_naming/include/linux/fs.h	Fri May 18 20:10:50 2001
@@ -984,6 +984,7 @@
 extern void bdput(struct block_device *);
 extern int blkdev_open(struct inode *, struct file *);
 extern struct file_operations def_blk_fops;
+extern struct inode_operations def_blk_iops;
 extern struct file_operations def_fifo_fops;
 extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *, mode_t, unsigned, int);
diff -urN kernels/2.4/v2.4.5-pre3/include/linux/lookupargs.h bdev_naming/include/linux/lookupargs.h
--- kernels/2.4/v2.4.5-pre3/include/linux/lookupargs.h	Wed Dec 31 19:00:00 1969
+++ bdev_naming/include/linux/lookupargs.h	Fri May 18 23:06:56 2001
@@ -0,0 +1,48 @@
+/* include/linux/lookupargs.h
+ */
+struct parsed_arg {
+	const char	*arg_start;
+	const char	*option_start;
+	int		arg_len;
+	int		option_len;
+};
+
+enum parsed_arg_type {
+	Arg_bool,	/* really an int */
+	Arg_ull,
+#if 0
+	//Arg_str,	/* really a char */
+	Arg_c,
+	Arg_uc,
+	Arg_s,
+	Arg_us,
+	Arg_i,
+	Arg_ui,
+	Arg_l,
+	Arg_ul,
+	Arg_ll,
+	Arg_u32,
+	Arg_u64,
+#endif
+};
+
+typedef const struct parsed_arg_format {
+	const char		*name;
+	enum parsed_arg_type	type;
+	size_t			offset;
+} arg_format_t;
+
+#define for_each_parsed_arg(str)\
+	struct parsed_arg arg;	\
+	int __offset = 0;		\
+	while ((__offset = parse_arg((str), __offset, &arg)) > 0)
+
+struct dentry;
+struct inode;
+struct qstr;
+
+extern int generic_parse_args(
+	const struct qstr *str, arg_format_t *fmt, void *data);
+extern struct dentry *generic_parse_lookup(
+	struct inode *inode, struct dentry *dentry, arg_format_t *fmt);
+
diff -urN kernels/2.4/v2.4.5-pre3/include/linux/raid/md_k.h bdev_naming/include/linux/raid/md_k.h
--- kernels/2.4/v2.4.5-pre3/include/linux/raid/md_k.h	Thu May 17 18:09:42 2001
+++ bdev_naming/include/linux/raid/md_k.h	Sat May 19 01:13:18 2001
@@ -36,6 +36,7 @@
 		case RAID5:		return 5;
 	}
 	panic("pers_to_level()");
+	return 0;
 }

 extern inline int level_to_pers (int level)

