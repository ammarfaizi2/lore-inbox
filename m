Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbTFWBOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 21:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264801AbTFWBOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 21:14:14 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41419 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264799AbTFWBNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 21:13:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 23 Jun 2003 03:27:51 +0200 (MEST)
Message-Id: <UTC200306230127.h5N1RpE13973.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] loop.c - part 1 of many
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you, Andries, are really volunteering to split the patch up,
> you're my hero :)

Below a patch for loop.[ch]. It can be applied.

This does the following:
(i) remove trailing spaces
(ii) make loop.h independent by including bio.h, blk.h, spinlock.h
(iii) replace the lock/unlock functions by module_get/module_put;
  in struct loop this is the change
-       void (*lock)(struct loop_device *);
-       void (*unlock)(struct loop_device *);
+       struct module *owner;
(iv) replace the integer lo_encrypt_type by the pointer lo_encryption;
  there was a race with loop_unregister_transfer
(v) fixed an off-by-one in loop_register_transfer

This is Step 1 of a series of half a dozen or so.

Half of the above is from Jari. Anything that is wrong is mine.
It compiles and works with my own crypto algorithm.

An unusual part is that the crypto algorithm module can be removed
any moment, even when it is in use. I am not sure I like that, will
probably change this in a subsequent patch unless people convince me
that this was done for a good reason.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Sun Jun 15 01:40:53 2003
+++ b/drivers/block/loop.c	Mon Jun 23 03:44:06 2003
@@ -2,7 +2,7 @@
  *  linux/drivers/block/loop.c
  *
  *  Written by Theodore Ts'o, 3/29/93
- * 
+ *
  * Copyright 1993 by Theodore Ts'o.  Redistribution of this file is
  * permitted under the GNU General Public License.
  *
@@ -21,12 +21,12 @@
  * Loadable modules and other fixes by AK, 1998
  *
  * Make real block number available to downstream transfer functions, enables
- * CBC (and relatives) mode encryption requiring unique IVs per data block. 
+ * CBC (and relatives) mode encryption requiring unique IVs per data block.
  * Reed H. Petty, rhp@draper.net
  *
  * Maximum number of loop devices now dynamic via max_loop module parameter.
  * Russell Kroll <rkroll@exploits.org> 19990701
- * 
+ *
  * Maximum number of loop devices when compiled-in now selectable by passing
  * max_loop=<1-255> to the kernel on boot.
  * Erik I. Bolsø, <eriki@himolde.no>, Oct 31, 1999
@@ -40,19 +40,19 @@
  * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
  *
  * Still To Fix:
- * - Advisory locking is ignored here. 
- * - Should use an own CAP_* category instead of CAP_SYS_ADMIN 
+ * - Advisory locking is ignored here.
+ * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
  *
  * WARNING/FIXME:
  * - The block number as IV passing to low level transfer functions is broken:
  *   it passes the underlying device's block number instead of the
- *   offset. This makes it change for a given block when the file is 
- *   moved/restored/copied and also doesn't work over NFS. 
+ *   offset. This makes it change for a given block when the file is
+ *   moved/restored/copied and also doesn't work over NFS.
  * AV, Feb 12, 2000: we pass the logical block number now. It fixes the
  *   problem above. Encryption modules that used to rely on the old scheme
  *   should just call ->i_mapping->bmap() to calculate the physical block
  *   number.
- */ 
+ */
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -60,12 +60,10 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/file.h>
-#include <linux/bio.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/major.h>
 #include <linux/wait.h>
-#include <linux/blk.h>
 #include <linux/blkpg.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
@@ -127,24 +125,25 @@
 	return 0;
 }
 
-struct loop_func_table none_funcs = { 
+struct loop_func_table none_funcs = {
 	.number = LO_CRYPT_NONE,
 	.transfer = transfer_none,
 }; 	
 
-struct loop_func_table xor_funcs = { 
+struct loop_func_table xor_funcs = {
 	.number = LO_CRYPT_XOR,
 	.transfer = transfer_xor,
 	.init = xor_status
 }; 	
 
-/* xfer_funcs[0] is special - its release function is never called */ 
+/* xfer_funcs[0] is special - its release function is never called */
 struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
 	&none_funcs,
-	&xor_funcs  
+	&xor_funcs
 };
 
-static int figure_loop_size(struct loop_device *lo)
+static int
+figure_loop_size(struct loop_device *lo)
 {
 	loff_t size = lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
 	sector_t x;
@@ -154,15 +153,17 @@
 	 */
 	size = (size - lo->lo_offset) >> 9;
 	x = (sector_t)size;
+
 	if ((loff_t)x != size)
 		return -EFBIG;
 
-	set_capacity(disks[lo->lo_number], size);
+	set_capacity(disks[lo->lo_number], x);
 	return 0;					
 }
 
-static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
-				 char *lbuf, int size, sector_t rblock)
+static inline int
+lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
+	       char *lbuf, int size, sector_t rblock)
 {
 	if (!lo->transfer)
 		return 0;
@@ -614,9 +615,12 @@
 
 	daemonize("loop%d", lo->lo_number);
 
-	current->flags |= PF_IOTHREAD;	/* loop can be used in an encrypted device
-					   hence, it mustn't be stopped at all because it could
-					   be indirectly used during suspension */
+	/*
+	 * loop can be used in an encrypted device,
+	 * hence, it mustn't be stopped at all
+	 * because it could be indirectly used during suspension
+	 */
+	current->flags |= PF_IOTHREAD;
 
 	set_user_nice(current, -20);
 
@@ -771,36 +775,42 @@
 	return error;
 }
 
-static int loop_release_xfer(struct loop_device *lo)
+static int
+loop_release_xfer(struct loop_device *lo)
 {
-	int err = 0; 
-	if (lo->lo_encrypt_type) {
-		struct loop_func_table *xfer= xfer_funcs[lo->lo_encrypt_type]; 
-		if (xfer && xfer->release)
-			err = xfer->release(lo); 
-		if (xfer && xfer->unlock)
-			xfer->unlock(lo); 
-		lo->lo_encrypt_type = 0;
+	int err = 0;
+	struct loop_func_table *xfer = lo->lo_encryption;
+
+	if (xfer) {
+		if (xfer->release)
+			err = xfer->release(lo);
+		lo->transfer = NULL;
+		lo->lo_encryption = NULL;
+		module_put(xfer->owner);
 	}
 	return err;
 }
 
 static int
-loop_init_xfer(struct loop_device *lo, int type, const struct loop_info64 *i)
+loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
+	       const struct loop_info64 *i)
 {
-	int err = 0; 
-	if (type) {
-		struct loop_func_table *xfer = xfer_funcs[type]; 
+	int err = 0;
+
+	if (xfer) {
+		struct module *owner = xfer->owner;
+
+		if (!try_module_get(owner))
+			return -EINVAL;
 		if (xfer->init)
 			err = xfer->init(lo, i);
-		if (!err) { 
-			lo->lo_encrypt_type = type;
-			if (xfer->lock)
-				xfer->lock(lo);
-		}
+		if (err)
+			module_put(owner);
+		else
+			lo->lo_encryption = xfer;
 	}
 	return err;
-}  
+}
 
 static int loop_clr_fd(struct loop_device *lo, struct block_device *bdev)
 {
@@ -809,9 +819,11 @@
 
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
+
 	if (lo->lo_refcnt > 1)	/* we needed one fd for the ioctl */
 		return -EBUSY;
-	if (filp==NULL)
+
+	if (filp == NULL)
 		return -EINVAL;
 
 	spin_lock_irq(&lo->lo_lock);
@@ -828,7 +840,7 @@
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
 	lo->lo_device = NULL;
-	lo->lo_encrypt_type = 0;
+	lo->lo_encryption = NULL;
 	lo->lo_offset = 0;
 	lo->lo_encrypt_key_size = 0;
 	lo->lo_flags = 0;
@@ -849,49 +861,55 @@
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	int err;
-	unsigned int type;
-	loff_t offset;
+	struct loop_func_table *xfer;
 
-	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid && 
+	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid &&
 	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
-	type = info->lo_encrypt_type; 
-	if (type >= MAX_LO_CRYPT || xfer_funcs[type] == NULL)
-		return -EINVAL;
-	if (type == LO_CRYPT_XOR && info->lo_encrypt_key_size == 0)
-		return -EINVAL;
 
 	err = loop_release_xfer(lo);
-	if (!err) 
-		err = loop_init_xfer(lo, type, info);
+	if (err)
+		return err;
 
-	offset = lo->lo_offset;
-	if (offset != info->lo_offset) {
-		lo->lo_offset = info->lo_offset;
-		if (figure_loop_size(lo)){
-			err = -EFBIG;
-			lo->lo_offset = offset;
-		}
-	}
+	if (info->lo_encrypt_type) {
+		unsigned int type = info->lo_encrypt_type;
+
+		if (type >= MAX_LO_CRYPT)
+			return -EINVAL;
+		xfer = xfer_funcs[type];
+		if (xfer == NULL)
+			return -EINVAL;
+	} else
+		xfer = NULL;
 
+	err = loop_init_xfer(lo, xfer, info);
 	if (err)
-		return err;	
+		return err;
+
+	if (lo->lo_offset != info->lo_offset) {
+		lo->lo_offset = info->lo_offset;
+		if (figure_loop_size(lo))
+			return -EFBIG;
+	}
 
 	strlcpy(lo->lo_name, info->lo_name, LO_NAME_SIZE);
 
-	lo->transfer = xfer_funcs[type]->transfer;
-	lo->ioctl = xfer_funcs[type]->ioctl;
+	if (!xfer)
+		xfer = &none_funcs;
+	lo->transfer = xfer->transfer;
+	lo->ioctl = xfer->ioctl;
+
 	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
 	lo->lo_init[0] = info->lo_init[0];
 	lo->lo_init[1] = info->lo_init[1];
 	if (info->lo_encrypt_key_size) {
-		memcpy(lo->lo_encrypt_key, info->lo_encrypt_key, 
+		memcpy(lo->lo_encrypt_key, info->lo_encrypt_key,
 		       info->lo_encrypt_key_size);
-		lo->lo_key_owner = current->uid; 
+		lo->lo_key_owner = current->uid;
 	}	
 
 	return 0;
@@ -917,7 +935,8 @@
 	info->lo_offset = lo->lo_offset;
 	info->lo_flags = lo->lo_flags;
 	strlcpy(info->lo_name, lo->lo_name, LO_NAME_SIZE);
-	info->lo_encrypt_type = lo->lo_encrypt_type;
+	info->lo_encrypt_type =
+		lo->lo_encryption ? lo->lo_encryption->number : 0;
 	if (lo->lo_encrypt_key_size && capable(CAP_SYS_ADMIN)) {
 		info->lo_encrypt_key_size = lo->lo_encrypt_key_size;
 		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
@@ -1060,30 +1079,22 @@
 static int lo_open(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
-	int type;
 
 	down(&lo->lo_ctl_mutex);
-
-	type = lo->lo_encrypt_type; 
-	if (type && xfer_funcs[type] && xfer_funcs[type]->lock)
-		xfer_funcs[type]->lock(lo);
 	lo->lo_refcnt++;
 	up(&lo->lo_ctl_mutex);
+
 	return 0;
 }
 
 static int lo_release(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
-	int type;
 
 	down(&lo->lo_ctl_mutex);
-	type = lo->lo_encrypt_type;
 	--lo->lo_refcnt;
-	if (xfer_funcs[type] && xfer_funcs[type]->unlock)
-		xfer_funcs[type]->unlock(lo);
-
 	up(&lo->lo_ctl_mutex);
+
 	return 0;
 }
 
@@ -1103,34 +1114,41 @@
 
 int loop_register_transfer(struct loop_func_table *funcs)
 {
-	if ((unsigned)funcs->number > MAX_LO_CRYPT || xfer_funcs[funcs->number])
+	unsigned int n = funcs->number;
+
+	if (n >= MAX_LO_CRYPT || xfer_funcs[n])
 		return -EINVAL;
-	xfer_funcs[funcs->number] = funcs;
-	return 0; 
+	xfer_funcs[n] = funcs;
+	return 0;
 }
 
 int loop_unregister_transfer(int number)
 {
-	struct loop_device *lo; 
+	unsigned int n = number;
+	struct loop_device *lo;
+	struct loop_func_table *xfer;
 
-	if ((unsigned)number >= MAX_LO_CRYPT)
-		return -EINVAL; 
-	for (lo = &loop_dev[0]; lo < &loop_dev[max_loop]; lo++) { 
-		int type = lo->lo_encrypt_type;
-		if (type == number) { 
-			xfer_funcs[type]->release(lo);
-			lo->transfer = NULL; 
-			lo->lo_encrypt_type = 0; 
-		}
+	if (n == 0 || n >= MAX_LO_CRYPT || (xfer = xfer_funcs[n]) == NULL)
+		return -EINVAL;
+
+	xfer_funcs[n] = NULL;
+
+	for (lo = &loop_dev[0]; lo < &loop_dev[max_loop]; lo++) {
+		down(&lo->lo_ctl_mutex);
+
+		if (lo->lo_encryption == xfer)
+			loop_release_xfer(lo);
+
+		up(&lo->lo_ctl_mutex);
 	}
-	xfer_funcs[number] = NULL; 
-	return 0; 
+
+	return 0;
 }
 
 EXPORT_SYMBOL(loop_register_transfer);
 EXPORT_SYMBOL(loop_unregister_transfer);
 
-int __init loop_init(void) 
+int __init loop_init(void)
 {
 	int	i;
 
@@ -1190,9 +1208,10 @@
 	return -ENOMEM;
 }
 
-void loop_exit(void) 
+void loop_exit(void)
 {
 	int i;
+
 	for (i = 0; i < max_loop; i++) {
 		del_gendisk(disks[i]);
 		put_disk(disks[i]);
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/loop.h b/include/linux/loop.h
--- a/include/linux/loop.h	Sun Jun 15 01:41:06 2003
+++ b/include/linux/loop.h	Mon Jun 23 03:42:22 2003
@@ -14,6 +14,9 @@
 #define LO_KEY_SIZE	32
 
 #ifdef __KERNEL__
+#include <linux/bio.h>
+#include <linux/blk.h>
+#include <linux/spinlock.h>
 
 /* Possible states of device */
 enum {
@@ -22,18 +25,20 @@
 	Lo_rundown,
 };
 
+struct loop_func_table;
+
 struct loop_device {
 	int		lo_number;
 	int		lo_refcnt;
 	int		lo_offset;
-	int		lo_encrypt_type;
-	int		lo_encrypt_key_size;
 	int		lo_flags;
 	int		(*transfer)(struct loop_device *, int cmd,
 				    char *raw_buf, char *loop_buf, int size,
 				    sector_t real_block);
 	char		lo_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
+	int		lo_encrypt_key_size;
+	struct loop_func_table *lo_encryption;
 	__u32           lo_init[2];
 	uid_t		lo_key_owner;	/* Who set the key */
 	int		(*ioctl)(struct loop_device *, int cmd, 
@@ -129,9 +134,7 @@
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *); 
 	int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
-	/* lock and unlock manage the module use counts */ 
-	void (*lock)(struct loop_device *);
-	void (*unlock)(struct loop_device *);
+	struct module *owner;
 }; 
 
 int loop_register_transfer(struct loop_func_table *funcs);
