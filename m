Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314025AbSEAUMZ>; Wed, 1 May 2002 16:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314034AbSEAUMY>; Wed, 1 May 2002 16:12:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24455 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314025AbSEAUMV>;
	Wed, 1 May 2002 16:12:21 -0400
Date: Wed, 1 May 2002 16:12:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] alternative API for raw devices
Message-ID: <Pine.GSO.4.21.0205011555450.12640-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


New option: CONFIG_RAW (tristate)

With that animal enabled you can say

# mount -t raw /dev/sda1 /dev/<whatever>

and get a raw device bound to sda1 visible on /dev/<whatever>.  Old
raw devices still work - drivers do not conflict.

Actual IO code is pretty much copied from old driver.  The main differences:
	* device is originally created with ownership/permissions of the
	  block device we'd used; you can chmod/chown it at any time,
	  obviously.
	* it's _not_ a character device - stat() will give you S_IFREG.
	  To check that <foo> is a new-style raw device call statfs(2) and
	  compare .f_type with rawfs magic (0x726177).  It doesn't conflict
	  with existing check for raw devices (stat(), check that it's
	  a character device and compare major with RAW_MAJOR), so existing
	  software can be taught to check for raw devices in
	  backwards-compatible way.

umount will undo the binding, obviously.  The thing works and is very small
(less than 3Kb text+data+bss).  BTW, it can be built as module.

I'm not sure if the name of config option is right - maybe CONFIG_RAW_FS
would be better (with CONFIG_RAW_DEV added when and if we would want to make
the old one conditional).

If nothing else, it's interesting as example of doing driver-exported mini-fs
instead of messing with ioctl().

Enjoy:

diff -urN C12-0/fs/Config.help C12-current/fs/Config.help
--- C12-0/fs/Config.help	Wed May  1 15:34:58 2002
+++ C12-current/fs/Config.help	Wed May  1 15:52:41 2002
@@ -6,6 +6,24 @@
   <http://www.linuxdoc.org/docs.html#howto>. Probably the quota
   support is only useful for multi user systems. If unsure, say N.
 
+CONFIG_RAW
+  If you say Y here, you will be able to work with raw devices without
+  any special tools - mount -t raw <block device> <file> will bind
+  a raw device with the block one and put it on top of file and umount <file>
+  will undo that.  No magic control devices, no ioctls, just plain mount(2).
+  Old raw devices are still there - these drivers are completely independent.
+  If unsure, say Y.
+
+  Note: to check that <file> is a new-style raw device you need either
+  look for raw mounted on <file> (in /proc/mounts or /etc/mtab) or
+  call statfs(<file>, &stat_buf) and compare stat_buf.f_type with
+  rawfs magic (0x726177).
+
+  If you want to compile this as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here and read <file:Documentation/modules.txt>. The module
+  will be called raw.o.
+
 CONFIG_MINIX_FS
   Minix is a simple operating system used in many classes about OS's.
   The minix file system (method to organize files on a hard disk
diff -urN C12-0/fs/Config.in C12-current/fs/Config.in
--- C12-0/fs/Config.in	Wed May  1 15:34:58 2002
+++ C12-current/fs/Config.in	Wed May  1 15:45:22 2002
@@ -5,6 +5,7 @@
 comment 'File systems'
 
 bool 'Quota support' CONFIG_QUOTA
+tristate 'Filesystem interface to raw devices' CONFIG_RAW
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
 
diff -urN C12-0/fs/Makefile C12-current/fs/Makefile
--- C12-0/fs/Makefile	Wed May  1 15:34:58 2002
+++ C12-current/fs/Makefile	Wed May  1 15:45:22 2002
@@ -71,6 +71,7 @@
 subdir-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs
 subdir-$(CONFIG_JFS_FS)		+= jfs
 
+obj-$(CONFIG_RAW)		+= raw.o
 
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
 obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
diff -urN C12-0/fs/raw.c C12-current/fs/raw.c
--- C12-0/fs/raw.c	Wed Dec 31 19:00:00 1969
+++ C12-current/fs/raw.c	Wed May  1 15:51:43 2002
@@ -0,0 +1,310 @@
+/*
+ * fs/raw.c
+ *
+ * raw devices without a barf-bag
+ *
+ * derived from drivers/char/raw.c - actual IO operations are almost exact
+ * copy, API for controlling that beast replaced with sane one.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/iobuf.h>
+#include <linux/blkdev.h>
+#include <linux/seq_file.h>
+
+struct raw_dev {
+	struct block_device *bdev;
+	int count;
+};
+
+static inline struct raw_dev *raw_dev(struct super_block *s)
+{
+	return s->u.generic_sbp;
+}
+
+static spinlock_t count_lock = SPIN_LOCK_UNLOCKED;
+
+static int raw_open(struct inode *inode, struct file *filp)
+{
+	struct super_block *s = inode->i_sb;
+	struct block_device *bdev = raw_dev(s)->bdev;
+	int sector_size;
+	int err;
+
+	if (!filp->f_iobuf) {
+		err = alloc_kiovec(1, &filp->f_iobuf);
+		if (err)
+			return err;
+	}
+
+	atomic_inc(&bdev->bd_count);
+	err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
+	if (err)
+		return err;
+
+	sector_size = bdev_hardsect_size(bdev);
+	
+	spin_lock(&count_lock);
+	if (!raw_dev(s)->count++) {
+		int bits;
+
+		s->s_blocksize = sector_size;
+		for (bits = 0; !(sector_size & 1); sector_size>>=1, bits++)
+			;
+		s->s_blocksize_bits = bits;
+		inode->i_size = bdev->bd_inode->i_size;
+	}
+	spin_unlock(&count_lock);
+	return 0;
+}
+
+static int raw_release(struct inode *inode, struct file *filp)
+{
+	struct raw_dev *p = raw_dev(inode->i_sb);
+	spin_lock(&count_lock);
+	p->count--;
+	spin_unlock(&count_lock);
+	blkdev_put(p->bdev, BDEV_RAW);
+	return 0;
+}
+
+static ssize_t rw_raw_dev(int rw, struct file *filp, char *buf, 
+			   size_t size, loff_t *offp)
+{
+	struct super_block *s = filp->f_dentry->d_inode->i_sb;
+	struct kiobuf *iobuf = filp->f_iobuf;
+	struct block_device *bdev = raw_dev(s)->bdev;
+	int sector_size = s->s_blocksize;
+	int sector_bits = s->s_blocksize_bits;
+	int sector_mask = sector_size - 1;
+	unsigned long limit = bdev->bd_inode->i_size >> sector_bits;
+	sector_t blocknr = *offp >> sector_bits;
+	size_t transferred = 0;
+	int new_iobuf = 0;
+	int err;
+	
+	/*
+	 * First, a few checks on device size limits 
+	 */
+
+	if (test_and_set_bit(0, &filp->f_iobuf_lock)) {
+		/*
+		 * A parallel read/write is using the preallocated iobuf
+		 * so just run slow and allocate a new one.
+		 */
+		err = alloc_kiovec(1, &iobuf);
+		if (err)
+			goto out;
+		new_iobuf = 1;
+	}
+	
+	err = -EINVAL;
+	if ((*offp & sector_mask) || (size & sector_mask))
+		goto out_free;
+	err = 0;
+	if (size)
+		err = -ENXIO;
+	if ((*offp >> sector_bits) >= limit)
+		goto out_free;
+
+	while (size > 0) {
+		unsigned long blocks = size >> sector_bits;
+		int iosize;
+
+		if (blocks > limit - blocknr)
+			blocks = limit - blocknr;
+		if (!blocks)
+			break;
+
+		iosize = blocks << sector_bits;
+
+		err = map_user_kiobuf(rw, iobuf, (unsigned long) buf, iosize);
+		if (err)
+			break;
+
+		err = brw_kiovec(rw, 1, &iobuf, bdev, &blocknr, sector_size);
+
+		if (rw == READ && err > 0)
+			mark_dirty_kiobuf(iobuf, err);
+		
+		if (err >= 0) {
+			transferred += err;
+			size -= err;
+			buf += err;
+		}
+
+		blocknr += blocks;
+
+		unmap_kiobuf(iobuf);
+
+		if (err != iosize)
+			break;
+	}
+	
+	if (transferred) {
+		*offp += transferred;
+		err = transferred;
+	}
+
+out_free:
+	if (!new_iobuf)
+		clear_bit(0, &filp->f_iobuf_lock);
+	else
+		free_kiovec(1, &iobuf);
+out:	
+	return err;
+}
+
+static ssize_t raw_read(struct file *filp, char * buf, 
+		 size_t size, loff_t *offp)
+{
+	return rw_raw_dev(READ, filp, buf, size, offp);
+}
+
+static ssize_t raw_write(struct file *filp, const char *buf, 
+		  size_t size, loff_t *offp)
+{
+	return rw_raw_dev(WRITE, filp, (char *) buf, size, offp);
+}
+
+static struct file_operations raw_fops = {
+	open:		raw_open,
+	release:	raw_release,
+	read:		raw_read,
+	write:		raw_write,
+};
+
+static int raw_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	dev_t dev = raw_dev(mnt->mnt_sb)->bdev->bd_dev;
+	seq_printf(m, " dev=%d:%d", MAJOR(dev), MINOR(dev));
+	return 0;
+}
+
+static struct super_operations s_ops = {
+	statfs:		simple_statfs,
+	show_options:	raw_show_options,
+};
+
+static struct super_block *raw_get_sb(struct file_system_type *fs_type,
+	int flags, char *dev_name, void *data)
+{
+	struct inode *inode, *root;
+	struct super_block *s;
+	struct nameidata nd;
+	struct raw_dev *p = kmalloc(sizeof(struct raw_dev), GFP_KERNEL);
+	int error = -ENOMEM;
+
+	if (!p)
+		goto out;
+
+	/* sanity check for device name */
+	error = -EINVAL;
+	if (!dev_name || !*dev_name)
+		goto out1;
+
+	/* find it */
+	error = path_lookup(dev_name, LOOKUP_FOLLOW, &nd);
+	if (error)
+		goto out1;
+
+	/* is it a block device? */
+	inode = nd.dentry->d_inode;
+	error = -ENOTBLK;
+	if (!S_ISBLK(inode->i_mode))
+		goto out2;
+
+	/* do we have it on nodev filesystem? */
+	error = -EACCES;
+	if (nd.mnt->mnt_flags & MNT_NODEV)
+		goto out2;
+
+	/* get struct block_device */
+	error = bd_acquire(inode);
+	if (error)
+		goto out2;
+
+	/* allocate superblock */
+	s = sget(fs_type, NULL, set_anon_super, NULL);
+	if (IS_ERR(s)) {
+		bdput(inode->i_bdev);
+		path_release(&nd);
+		kfree(p);
+		return s;
+	}
+
+	/* set it up */
+	s->s_blocksize = PAGE_CACHE_SIZE;
+	s->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	s->s_magic = 0x726177;
+	s->s_op = &s_ops;
+	s->u.generic_sbp = p;
+	p->bdev = inode->i_bdev;
+	p->count = 0;
+
+	/* allocate (the only) inode */
+	error = -ENOMEM;
+	root = new_inode(s);
+	if (!root)
+		goto out3;
+
+	/* set it up */
+	root->i_mode = S_IFREG | (inode->i_mode & S_IRWXUGO);
+	root->i_uid = inode->i_uid;
+	root->i_gid = inode->i_gid;
+	root->i_blksize = PAGE_CACHE_SIZE;
+	root->i_blocks = 0;
+	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
+	root->i_fop = &raw_fops;
+
+	/* make it root */
+	s->s_root = d_alloc_root(root);
+	if (!s->s_root)
+		goto out4;
+	s->s_flags |= MS_ACTIVE;
+	path_release(&nd);
+	return s;
+
+out4:
+	iput(root);
+out3:
+	up_write(&s->s_umount);
+	deactivate_super(s);
+out2:
+	path_release(&nd);
+out1:
+	kfree(p);
+out:
+	return ERR_PTR(error);
+}
+
+static void raw_kill_sb(struct super_block *s)
+{
+	struct raw_dev *p = raw_dev(s);
+	kill_anon_super(s);
+	bdput(p->bdev);
+	kfree(p);
+}
+
+static struct file_system_type raw_fs_type = {
+	owner:		THIS_MODULE,
+	name:		"raw",
+	get_sb:		raw_get_sb,
+	kill_sb:	raw_kill_sb,
+};
+
+static int __init init_rawfs(void)
+{
+	return register_filesystem(&raw_fs_type);
+}
+
+static void __exit exit_rawfs(void)
+{
+	unregister_filesystem(&raw_fs_type);
+}
+
+EXPORT_NO_SYMBOLS;
+MODULE_LICENSE("GPL");	/* fair is fair - derived from GPLed code */
+module_init(init_rawfs)
+module_exit(exit_rawfs)

