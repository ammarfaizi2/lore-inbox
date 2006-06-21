Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWFUMyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWFUMyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWFUMyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:54:07 -0400
Received: from thunk.org ([69.25.196.29]:433 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932095AbWFUMxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:53:46 -0400
Message-Id: <20060621125216.044675000@candygram.thunk.org>
References: <20060621125146.508341000@candygram.thunk.org>
Date: Wed, 21 Jun 2006 08:51:47 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Content-Disposition: inline; filename=inode-slim-1
From: Theodore Tso <tytso@thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The filesystem or device-specific pointer in the inode is inside a
union, which is pretty pointless given that all 30+ users of this
field have been using the void pointer.  Get rid of the union and
rename it to i_private, with a comment to explain who is allowed to
use the void pointer.  This is just a cleanup, but it allows us to
reuse the union 'u' for something something where the union will
actually be used.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/include/linux/fs.h	2006-06-18 18:58:55.000000000 -0400
@@ -534,9 +534,7 @@
 
 	atomic_t		i_writecount;
 	void			*i_security;
-	union {
-		void		*generic_ip;
-	} u;
+	void			*i_private; /* fs or device private pointer */
 #ifdef __NEED_I_SIZE_ORDERED
 	seqcount_t		i_size_seqcount;
 #endif
Index: linux-2.6.17/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.17.orig/arch/powerpc/platforms/cell/spufs/inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/arch/powerpc/platforms/cell/spufs/inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -120,7 +120,7 @@
 	ret = 0;
 	inode->i_op = &spufs_file_iops;
 	inode->i_fop = fops;
-	inode->u.generic_ip = SPUFS_I(inode)->i_ctx = get_spu_context(ctx);
+	inode->i_private = SPUFS_I(inode)->i_ctx = get_spu_context(ctx);
 	d_add(dentry, inode);
 out:
 	return ret;
Index: linux-2.6.17/arch/s390/kernel/debug.c
===================================================================
--- linux-2.6.17.orig/arch/s390/kernel/debug.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/arch/s390/kernel/debug.c	2006-06-18 18:58:55.000000000 -0400
@@ -604,7 +604,7 @@
 	debug_info_t *debug_info, *debug_info_snapshot;
 
 	down(&debug_lock);
-	debug_info = (struct debug_info*)file->f_dentry->d_inode->u.generic_ip;
+	debug_info = file->f_dentry->d_inode->i_private;
 	/* find debug view */
 	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
 		if (!debug_info->views[i])
Index: linux-2.6.17/drivers/i2c/chips/tps65010.c
===================================================================
--- linux-2.6.17.orig/drivers/i2c/chips/tps65010.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/i2c/chips/tps65010.c	2006-06-18 18:58:55.000000000 -0400
@@ -307,7 +307,7 @@
 
 static int dbg_tps_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, dbg_show, inode->u.generic_ip);
+	return single_open(file, dbg_show, inode->i_private);
 }
 
 static struct file_operations debug_fops = {
Index: linux-2.6.17/drivers/infiniband/ulp/ipoib/ipoib_fs.c
===================================================================
--- linux-2.6.17.orig/drivers/infiniband/ulp/ipoib/ipoib_fs.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/infiniband/ulp/ipoib/ipoib_fs.c	2006-06-18 18:58:55.000000000 -0400
@@ -141,7 +141,7 @@
 		return ret;
 
 	seq = file->private_data;
-	seq->private = inode->u.generic_ip;
+	seq->private = inode->i_private;
 
 	return 0;
 }
@@ -247,7 +247,7 @@
 		return ret;
 
 	seq = file->private_data;
-	seq->private = inode->u.generic_ip;
+	seq->private = inode->i_private;
 
 	return 0;
 }
Index: linux-2.6.17/drivers/misc/ibmasm/ibmasmfs.c
===================================================================
--- linux-2.6.17.orig/drivers/misc/ibmasm/ibmasmfs.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/misc/ibmasm/ibmasmfs.c	2006-06-18 18:58:55.000000000 -0400
@@ -174,7 +174,7 @@
 	}
 
 	inode->i_fop = fops;
-	inode->u.generic_ip = data;
+	inode->i_private = data;
 
 	d_add(dentry, inode);
 	return dentry;
@@ -243,7 +243,7 @@
 {
 	struct ibmasmfs_command_data *command_data;
 
-	if (!inode->u.generic_ip)
+	if (!inode->i_private)
 		return -ENODEV;
 
 	command_data = kmalloc(sizeof(struct ibmasmfs_command_data), GFP_KERNEL);
@@ -251,7 +251,7 @@
 		return -ENOMEM;
 
 	command_data->command = NULL;
-	command_data->sp = inode->u.generic_ip;
+	command_data->sp = inode->i_private;
 	file->private_data = command_data;
 	return 0;
 }
@@ -350,10 +350,10 @@
 	struct ibmasmfs_event_data *event_data;
 	struct service_processor *sp; 
 
-	if (!inode->u.generic_ip)
+	if (!inode->i_private)
 		return -ENODEV;
 
-	sp = inode->u.generic_ip;
+	sp = inode->i_private;
 
 	event_data = kmalloc(sizeof(struct ibmasmfs_event_data), GFP_KERNEL);
 	if (!event_data)
@@ -438,14 +438,14 @@
 {
 	struct ibmasmfs_heartbeat_data *rhbeat;
 
-	if (!inode->u.generic_ip)
+	if (!inode->i_private)
 		return -ENODEV;
 
 	rhbeat = kmalloc(sizeof(struct ibmasmfs_heartbeat_data), GFP_KERNEL);
 	if (!rhbeat)
 		return -ENOMEM;
 
-	rhbeat->sp = (struct service_processor *)inode->u.generic_ip;
+	rhbeat->sp = inode->i_private;
 	rhbeat->active = 0;
 	ibmasm_init_reverse_heartbeat(rhbeat->sp, &rhbeat->heartbeat);
 	file->private_data = rhbeat;
@@ -507,7 +507,7 @@
 
 static int remote_settings_file_open(struct inode *inode, struct file *file)
 {
-	file->private_data = inode->u.generic_ip;
+	file->private_data = inode->i_private;
 	return 0;
 }
 
Index: linux-2.6.17/drivers/net/irda/vlsi_ir.h
===================================================================
--- linux-2.6.17.orig/drivers/net/irda/vlsi_ir.h	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/net/irda/vlsi_ir.h	2006-06-18 18:58:55.000000000 -0400
@@ -58,7 +58,7 @@
 
 /* PDE() introduced in 2.5.4 */
 #ifdef CONFIG_PROC_FS
-#define PDE(inode) ((inode)->u.generic_ip)
+#define PDE(inode) ((inode)->i_private)
 #endif
 
 /* irda crc16 calculation exported in 2.5.42 */
Index: linux-2.6.17/drivers/oprofile/oprofilefs.c
===================================================================
--- linux-2.6.17.orig/drivers/oprofile/oprofilefs.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/oprofile/oprofilefs.c	2006-06-18 18:58:55.000000000 -0400
@@ -110,8 +110,8 @@
 
 static int default_open(struct inode * inode, struct file * filp)
 {
-	if (inode->u.generic_ip)
-		filp->private_data = inode->u.generic_ip;
+	if (inode->i_private)
+		filp->private_data = inode->i_private;
 	return 0;
 }
 
@@ -158,7 +158,7 @@
 	if (!d)
 		return -EFAULT;
 
-	d->d_inode->u.generic_ip = val;
+	d->d_inode->i_private = val;
 	return 0;
 }
 
@@ -171,7 +171,7 @@
 	if (!d)
 		return -EFAULT;
 
-	d->d_inode->u.generic_ip = val;
+	d->d_inode->i_private = val;
 	return 0;
 }
 
@@ -197,7 +197,7 @@
 	if (!d)
 		return -EFAULT;
 
-	d->d_inode->u.generic_ip = val;
+	d->d_inode->i_private = val;
 	return 0;
 }
 
Index: linux-2.6.17/drivers/pci/hotplug/cpqphp_sysfs.c
===================================================================
--- linux-2.6.17.orig/drivers/pci/hotplug/cpqphp_sysfs.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/pci/hotplug/cpqphp_sysfs.c	2006-06-18 18:58:55.000000000 -0400
@@ -141,7 +141,7 @@
 
 static int open(struct inode *inode, struct file *file)
 {
-	struct controller *ctrl = inode->u.generic_ip;
+	struct controller *ctrl = inode->i_private;
 	struct ctrl_dbg *dbg;
 	int retval = -ENOMEM;
 
Index: linux-2.6.17/drivers/usb/core/devio.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/core/devio.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/usb/core/devio.c	2006-06-18 18:58:55.000000000 -0400
@@ -553,7 +553,7 @@
 	if (imajor(inode) == USB_DEVICE_MAJOR)
 		dev = usbdev_lookup_minor(iminor(inode));
 	if (!dev)
-		dev = inode->u.generic_ip;
+		dev = inode->i_private;
 	if (!dev) {
 		kfree(ps);
 		goto out;
Index: linux-2.6.17/drivers/usb/core/inode.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/core/inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/usb/core/inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -403,8 +403,8 @@
 
 static int default_open (struct inode *inode, struct file *file)
 {
-	if (inode->u.generic_ip)
-		file->private_data = inode->u.generic_ip;
+	if (inode->i_private)
+		file->private_data = inode->i_private;
 
 	return 0;
 }
@@ -510,7 +510,7 @@
 	} else {
 		if (dentry->d_inode) {
 			if (data)
-				dentry->d_inode->u.generic_ip = data;
+				dentry->d_inode->i_private = data;
 			if (fops)
 				dentry->d_inode->i_fop = fops;
 			dentry->d_inode->i_uid = uid;
Index: linux-2.6.17/drivers/usb/gadget/inode.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/gadget/inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/usb/gadget/inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -845,7 +845,7 @@
 static int
 ep_open (struct inode *inode, struct file *fd)
 {
-	struct ep_data		*data = inode->u.generic_ip;
+	struct ep_data		*data = inode->i_private;
 	int			value = -EBUSY;
 
 	if (down_interruptible (&data->lock) != 0)
@@ -1908,7 +1908,7 @@
 static int
 dev_open (struct inode *inode, struct file *fd)
 {
-	struct dev_data		*dev = inode->u.generic_ip;
+	struct dev_data		*dev = inode->i_private;
 	int			value = -EBUSY;
 
 	if (dev->state == STATE_DEV_DISABLED) {
@@ -1969,7 +1969,7 @@
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime
 				= CURRENT_TIME;
-		inode->u.generic_ip = data;
+		inode->i_private = data;
 		inode->i_fop = fops;
 	}
 	return inode;
Index: linux-2.6.17/drivers/usb/host/isp116x-hcd.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/host/isp116x-hcd.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/usb/host/isp116x-hcd.c	2006-06-18 18:58:55.000000000 -0400
@@ -1204,7 +1204,7 @@
 
 static int isp116x_open_seq(struct inode *inode, struct file *file)
 {
-	return single_open(file, isp116x_show_dbg, inode->u.generic_ip);
+	return single_open(file, isp116x_show_dbg, inode->i_private);
 }
 
 static struct file_operations isp116x_debug_fops = {
Index: linux-2.6.17/drivers/usb/host/uhci-debug.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/host/uhci-debug.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/usb/host/uhci-debug.c	2006-06-18 18:58:55.000000000 -0400
@@ -406,7 +406,7 @@
 
 static int uhci_debug_open(struct inode *inode, struct file *file)
 {
-	struct uhci_hcd *uhci = inode->u.generic_ip;
+	struct uhci_hcd *uhci = inode->i_private;
 	struct uhci_debug *up;
 	int ret = -ENOMEM;
 	unsigned long flags;
Index: linux-2.6.17/drivers/usb/mon/mon_stat.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/mon/mon_stat.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/usb/mon/mon_stat.c	2006-06-18 18:58:55.000000000 -0400
@@ -28,7 +28,7 @@
 	if ((sp = kmalloc(sizeof(struct snap), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 
-	mbus = inode->u.generic_ip;
+	mbus = inode->i_private;
 
 	sp->slen = snprintf(sp->str, STAT_BUF_SIZE,
 	    "nreaders %d text_lost %u\n",
Index: linux-2.6.17/drivers/usb/mon/mon_text.c
===================================================================
--- linux-2.6.17.orig/drivers/usb/mon/mon_text.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/usb/mon/mon_text.c	2006-06-18 18:58:55.000000000 -0400
@@ -210,7 +210,7 @@
 	int rc;
 
 	mutex_lock(&mon_lock);
-	mbus = inode->u.generic_ip;
+	mbus = inode->i_private;
 	ubus = mbus->u_bus;
 
 	rp = kzalloc(sizeof(struct mon_reader_text), GFP_KERNEL);
@@ -372,7 +372,7 @@
 	struct mon_event_text *ep;
 
 	mutex_lock(&mon_lock);
-	mbus = inode->u.generic_ip;
+	mbus = inode->i_private;
 
 	if (mbus->nreaders <= 0) {
 		printk(KERN_ERR TAG ": consistency error on close\n");
Index: linux-2.6.17/fs/autofs/inode.c
===================================================================
--- linux-2.6.17.orig/fs/autofs/inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/autofs/inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -241,7 +241,7 @@
 		
 		inode->i_op = &autofs_symlink_inode_operations;
 		sl = &sbi->symlink[n];
-		inode->u.generic_ip = sl;
+		inode->i_private = sl;
 		inode->i_mode = S_IFLNK | S_IRWXUGO;
 		inode->i_mtime.tv_sec = inode->i_ctime.tv_sec = sl->mtime;
 		inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;
Index: linux-2.6.17/fs/autofs/symlink.c
===================================================================
--- linux-2.6.17.orig/fs/autofs/symlink.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/autofs/symlink.c	2006-06-18 18:58:55.000000000 -0400
@@ -15,7 +15,7 @@
 /* Nothing to release.. */
 static void *autofs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
+	char *s=((struct autofs_symlink *)dentry->d_inode->i_private)->data;
 	nd_set_link(nd, s);
 	return NULL;
 }
Index: linux-2.6.17/fs/binfmt_misc.c
===================================================================
--- linux-2.6.17.orig/fs/binfmt_misc.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/binfmt_misc.c	2006-06-18 18:58:55.000000000 -0400
@@ -517,7 +517,7 @@
 
 static void bm_clear_inode(struct inode *inode)
 {
-	kfree(inode->u.generic_ip);
+	kfree(inode->i_private);
 }
 
 static void kill_node(Node *e)
@@ -545,7 +545,7 @@
 static ssize_t
 bm_entry_read(struct file * file, char __user * buf, size_t nbytes, loff_t *ppos)
 {
-	Node *e = file->f_dentry->d_inode->u.generic_ip;
+	Node *e = file->f_dentry->d_inode->i_private;
 	loff_t pos = *ppos;
 	ssize_t res;
 	char *page;
@@ -579,7 +579,7 @@
 				size_t count, loff_t *ppos)
 {
 	struct dentry *root;
-	Node *e = file->f_dentry->d_inode->u.generic_ip;
+	Node *e = file->f_dentry->d_inode->i_private;
 	int res = parse_command(buffer, count);
 
 	switch (res) {
@@ -646,7 +646,7 @@
 	}
 
 	e->dentry = dget(dentry);
-	inode->u.generic_ip = e;
+	inode->i_private = e;
 	inode->i_fop = &bm_entry_operations;
 
 	d_instantiate(dentry, inode);
Index: linux-2.6.17/fs/debugfs/file.c
===================================================================
--- linux-2.6.17.orig/fs/debugfs/file.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/debugfs/file.c	2006-06-18 18:58:55.000000000 -0400
@@ -33,8 +33,8 @@
 
 static int default_open(struct inode *inode, struct file *file)
 {
-	if (inode->u.generic_ip)
-		file->private_data = inode->u.generic_ip;
+	if (inode->i_private)
+		file->private_data = inode->i_private;
 
 	return 0;
 }
Index: linux-2.6.17/fs/debugfs/inode.c
===================================================================
--- linux-2.6.17.orig/fs/debugfs/inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/debugfs/inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -170,7 +170,7 @@
  *          directory dentry if set.  If this paramater is NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @data: a pointer to something that the caller will want to get to later
- *        on.  The inode.u.generic_ip pointer will point to this value on
+ *        on.  The inode.i_private pointer will point to this value on
  *        the open() call.
  * @fops: a pointer to a struct file_operations that should be used for
  *        this file.
@@ -211,7 +211,7 @@
 
 	if (dentry->d_inode) {
 		if (data)
-			dentry->d_inode->u.generic_ip = data;
+			dentry->d_inode->i_private = data;
 		if (fops)
 			dentry->d_inode->i_fop = fops;
 	}
Index: linux-2.6.17/fs/devfs/base.c
===================================================================
--- linux-2.6.17.orig/fs/devfs/base.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/devfs/base.c	2006-06-18 18:58:55.000000000 -0400
@@ -26,7 +26,7 @@
                Original version.
   v0.1
     19980111   Richard Gooch <rgooch@atnf.csiro.au>
-               Created per-fs inode table rather than using inode->u.generic_ip
+               Created per-fs inode table rather than using inode->i_private
   v0.2
     19980111   Richard Gooch <rgooch@atnf.csiro.au>
                Created .epoch inode which has a ctime of 0.
@@ -521,7 +521,7 @@
   v0.109
     20010807   Richard Gooch <rgooch@atnf.csiro.au>
 	       Fixed inode table races by removing it and using
-	       inode->u.generic_ip instead.
+	       inode->i_private instead.
 	       Moved <devfs_read_inode> into <get_vfs_inode>.
 	       Moved <devfs_write_inode> into <devfs_notify_change>.
   v0.110
@@ -1266,8 +1266,8 @@
 {
 	if (inode == NULL)
 		return NULL;
-	VERIFY_ENTRY((struct devfs_entry *)inode->u.generic_ip);
-	return inode->u.generic_ip;
+	VERIFY_ENTRY((struct devfs_entry *)inode->i_private);
+	return inode->i_private;
 }				/*  End Function get_devfs_entry_from_vfs_inode  */
 
 /**
@@ -1920,7 +1920,7 @@
 		return NULL;
 	}
 	/* FIXME where is devfs_put? */
-	inode->u.generic_ip = devfs_get(de);
+	inode->i_private = devfs_get(de);
 	inode->i_ino = de->inode.ino;
 	DPRINTK(DEBUG_I_GET, "(%d): VFS inode: %p  devfs_entry: %p\n",
 		(int)inode->i_ino, inode, de);
Index: linux-2.6.17/fs/devpts/inode.c
===================================================================
--- linux-2.6.17.orig/fs/devpts/inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/devpts/inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -177,7 +177,7 @@
 	inode->i_gid = config.setgid ? config.gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|config.mode, device);
-	inode->u.generic_ip = tty;
+	inode->i_private = tty;
 
 	dentry = get_node(number);
 	if (!IS_ERR(dentry) && !dentry->d_inode)
@@ -196,7 +196,7 @@
 	tty = NULL;
 	if (!IS_ERR(dentry)) {
 		if (dentry->d_inode)
-			tty = dentry->d_inode->u.generic_ip;
+			tty = dentry->d_inode->i_private;
 		dput(dentry);
 	}
 
Index: linux-2.6.17/fs/freevxfs/vxfs.h
===================================================================
--- linux-2.6.17.orig/fs/freevxfs/vxfs.h	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/freevxfs/vxfs.h	2006-06-18 18:58:55.000000000 -0400
@@ -252,7 +252,7 @@
  * Get filesystem private data from VFS inode.
  */
 #define VXFS_INO(ip) \
-	((struct vxfs_inode_info *)(ip)->u.generic_ip)
+	((struct vxfs_inode_info *)(ip)->i_private)
 
 /*
  * Get filesystem private data from VFS superblock.
Index: linux-2.6.17/fs/freevxfs/vxfs_inode.c
===================================================================
--- linux-2.6.17.orig/fs/freevxfs/vxfs_inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/freevxfs/vxfs_inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -243,7 +243,7 @@
 	ip->i_blocks = vip->vii_blocks;
 	ip->i_generation = vip->vii_gen;
 
-	ip->u.generic_ip = (void *)vip;
+	ip->i_private = vip;
 	
 }
 
@@ -338,5 +338,5 @@
 void
 vxfs_clear_inode(struct inode *ip)
 {
-	kmem_cache_free(vxfs_inode_cachep, ip->u.generic_ip);
+	kmem_cache_free(vxfs_inode_cachep, ip->i_private);
 }
Index: linux-2.6.17/fs/jffs/inode-v23.c
===================================================================
--- linux-2.6.17.orig/fs/jffs/inode-v23.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/jffs/inode-v23.c	2006-06-18 18:58:55.000000000 -0400
@@ -369,7 +369,7 @@
 
 	f = jffs_find_file(c, raw_inode->ino);
 
-	inode->u.generic_ip = (void *)f;
+	inode->i_private = (void *)f;
 	insert_inode_hash(inode);
 
 	return inode;
@@ -442,7 +442,7 @@
 	});
 
 	result = -ENOTDIR;
-	if (!(old_dir_f = (struct jffs_file *)old_dir->u.generic_ip)) {
+	if (!(old_dir_f = old_dir->i_private)) {
 		D(printk("jffs_rename(): Old dir invalid.\n"));
 		goto jffs_rename_end;
 	}
@@ -456,7 +456,7 @@
 
 	/* Find the new directory.  */
 	result = -ENOTDIR;
-	if (!(new_dir_f = (struct jffs_file *)new_dir->u.generic_ip)) {
+	if (!(new_dir_f = new_dir->i_private)) {
 		D(printk("jffs_rename(): New dir invalid.\n"));
 		goto jffs_rename_end;
 	}
@@ -593,7 +593,7 @@
 		}
 		else {
 			ddino = ((struct jffs_file *)
-				 inode->u.generic_ip)->pino;
+				 inode->i_private)->pino;
 		}
 		D3(printk("jffs_readdir(): \"..\" %u\n", ddino));
 		if (filldir(dirent, "..", 2, filp->f_pos, ddino, DT_DIR) < 0) {
@@ -604,7 +604,7 @@
 		}
 		filp->f_pos++;
 	}
-	f = ((struct jffs_file *)inode->u.generic_ip)->children;
+	f = ((struct jffs_file *)inode->i_private)->children;
 
 	j = 2;
 	while(f && (f->deleted || j++ < filp->f_pos )) {
@@ -668,7 +668,7 @@
 	}
 
 	r = -EACCES;
-	if (!(d = (struct jffs_file *)dir->u.generic_ip)) {
+	if (!(d = (struct jffs_file *)dir->i_private)) {
 		D(printk("jffs_lookup(): No such inode! (%lu)\n",
 			 dir->i_ino));
 		goto jffs_lookup_end;
@@ -739,7 +739,7 @@
 	unsigned long read_len;
 	int result;
 	struct inode *inode = (struct inode*)page->mapping->host;
-	struct jffs_file *f = (struct jffs_file *)inode->u.generic_ip;
+	struct jffs_file *f = (struct jffs_file *)inode->i_private;
 	struct jffs_control *c = (struct jffs_control *)inode->i_sb->s_fs_info;
 	int r;
 	loff_t offset;
@@ -828,7 +828,7 @@
 	});
 
 	lock_kernel();
-	dir_f = (struct jffs_file *)dir->u.generic_ip;
+	dir_f = dir->i_private;
 
 	ASSERT(if (!dir_f) {
 		printk(KERN_ERR "jffs_mkdir(): No reference to a "
@@ -972,7 +972,7 @@
 		kfree(_name);
 	});
 
-	dir_f = (struct jffs_file *) dir->u.generic_ip;
+	dir_f = dir->i_private;
 	c = dir_f->c;
 
 	result = -ENOENT;
@@ -1082,7 +1082,7 @@
 	if (!old_valid_dev(rdev))
 		return -EINVAL;
 	lock_kernel();
-	dir_f = (struct jffs_file *)dir->u.generic_ip;
+	dir_f = dir->i_private;
 	c = dir_f->c;
 
 	D3(printk (KERN_NOTICE "mknod(): down biglock\n"));
@@ -1186,7 +1186,7 @@
 		kfree(_symname);
 	});
 
-	dir_f = (struct jffs_file *)dir->u.generic_ip;
+	dir_f = dir->i_private;
 	ASSERT(if (!dir_f) {
 		printk(KERN_ERR "jffs_symlink(): No reference to a "
 		       "jffs_file struct in inode.\n");
@@ -1289,7 +1289,7 @@
 		kfree(s);
 	});
 
-	dir_f = (struct jffs_file *)dir->u.generic_ip;
+	dir_f = dir->i_private;
 	ASSERT(if (!dir_f) {
 		printk(KERN_ERR "jffs_create(): No reference to a "
 		       "jffs_file struct in inode.\n");
@@ -1403,9 +1403,9 @@
 		goto out_isem;
 	}
 
-	if (!(f = (struct jffs_file *)inode->u.generic_ip)) {
-		D(printk("jffs_file_write(): inode->u.generic_ip = 0x%p\n",
-				inode->u.generic_ip));
+	if (!(f = inode->i_private)) {
+		D(printk("jffs_file_write(): inode->i_private = 0x%p\n",
+				inode->i_private));
 		goto out_isem;
 	}
 
@@ -1693,7 +1693,7 @@
 		mutex_unlock(&c->fmc->biglock);
 		return;
 	}
-	inode->u.generic_ip = (void *)f;
+	inode->i_private = f;
 	inode->i_mode = f->mode;
 	inode->i_nlink = f->nlink;
 	inode->i_uid = f->uid;
@@ -1748,7 +1748,7 @@
 	lock_kernel();
 	inode->i_size = 0;
 	inode->i_blocks = 0;
-	inode->u.generic_ip = NULL;
+	inode->i_private = NULL;
 	clear_inode(inode);
 	if (inode->i_nlink == 0) {
 		c = (struct jffs_control *) inode->i_sb->s_fs_info;
Index: linux-2.6.17/fs/libfs.c
===================================================================
--- linux-2.6.17.orig/fs/libfs.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/libfs.c	2006-06-18 18:58:55.000000000 -0400
@@ -549,7 +549,7 @@
 
 	attr->get = get;
 	attr->set = set;
-	attr->data = inode->u.generic_ip;
+	attr->data = inode->i_private;
 	attr->fmt = fmt;
 	mutex_init(&attr->mutex);
 
Index: linux-2.6.17/fs/ocfs2/dlmglue.c
===================================================================
--- linux-2.6.17.orig/fs/ocfs2/dlmglue.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/ocfs2/dlmglue.c	2006-06-18 18:58:55.000000000 -0400
@@ -1995,7 +1995,7 @@
 		mlog_errno(ret);
 		goto out;
 	}
-	osb = (struct ocfs2_super *) inode->u.generic_ip;
+	osb = inode->i_private;
 	ocfs2_get_dlm_debug(osb->osb_dlm_debug);
 	priv->p_dlm_debug = osb->osb_dlm_debug;
 	INIT_LIST_HEAD(&priv->p_iter_res.l_debug_list);
Index: linux-2.6.17/fs/openpromfs/inode.c
===================================================================
--- linux-2.6.17.orig/fs/openpromfs/inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/openpromfs/inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -70,9 +70,9 @@
 	struct inode *inode = file->f_dentry->d_inode;
 	char buffer[10];
 	
-	if (count < 0 || !inode->u.generic_ip)
+	if (count < 0 || !inode->i_private)
 		return -EINVAL;
-	sprintf (buffer, "%8.8x\n", (u32)(long)(inode->u.generic_ip));
+	sprintf (buffer, "%8.8x\n", (u32)(long)(inode->i_private));
 	if (file->f_pos >= 9)
 		return 0;
 	if (count > 9 - file->f_pos)
@@ -95,9 +95,9 @@
 	char buffer[64];
 	
 	if (!filp->private_data) {
-		node = nodes[(u16)((long)inode->u.generic_ip)].node;
-		i = ((u32)(long)inode->u.generic_ip) >> 16;
-		if ((u16)((long)inode->u.generic_ip) == aliases) {
+		node = nodes[(u16)((long)inode->i_private)].node;
+		i = ((u32)(long)inode->i_private) >> 16;
+		if ((u16)((long)inode->i_private) == aliases) {
 			if (i >= aliases_nodes)
 				p = NULL;
 			else
@@ -111,7 +111,7 @@
 			return -EIO;
 		i = prom_getproplen (node, p);
 		if (i < 0) {
-			if ((u16)((long)inode->u.generic_ip) == aliases)
+			if ((u16)((long)inode->i_private) == aliases)
 				i = 0;
 			else
 				return -EIO;
@@ -539,8 +539,8 @@
 	if (!op)
 		return 0;
 	lock_kernel();
-	node = nodes[(u16)((long)inode->u.generic_ip)].node;
-	if ((u16)((long)inode->u.generic_ip) == aliases) {
+	node = nodes[(u16)((long)inode->i_private)].node;
+	if ((u16)((long)inode->i_private) == aliases) {
 		if ((op->flag & OPP_DIRTY) && (op->flag & OPP_STRING)) {
 			char *p = op->name;
 			int i = (op->value - op->name) - strlen (op->name) - 1;
@@ -743,7 +743,7 @@
 		inode->i_mode = S_IFREG | S_IRUGO;
 		inode->i_fop = &openpromfs_nodenum_ops;
 		inode->i_nlink = 1;
-		inode->u.generic_ip = (void *)(long)(n);
+		inode->i_private = (void *)(long)(n);
 		break;
 	case OPFSL_PROPERTY:
 		if ((dirnode == options) && (len == 17)
@@ -760,7 +760,7 @@
 		inode->i_nlink = 1;
 		if (inode->i_size < 0)
 			inode->i_size = 0;
-		inode->u.generic_ip = (void *)(long)(((u16)dirnode) | 
+		inode->i_private = (void *)(long)(((u16)dirnode) |
 			(((u16)(ino - NODEP2INO(NODE(dir->i_ino).first_prop) - 1)) << 16));
 		break;
 	}
@@ -886,7 +886,7 @@
 	inode->i_fop = &openpromfs_prop_ops;
 	inode->i_nlink = 1;
 	if (inode->i_size < 0) inode->i_size = 0;
-	inode->u.generic_ip = (void *)(long)(((u16)aliases) | 
+	inode->i_private = (void *)(long)(((u16)aliases) |
 			(((u16)(aliases_nodes - 1)) << 16));
 	unlock_kernel();
 	d_instantiate(dentry, inode);
Index: linux-2.6.17/security/inode.c
===================================================================
--- linux-2.6.17.orig/security/inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/security/inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -45,8 +45,8 @@
 
 static int default_open(struct inode *inode, struct file *file)
 {
-	if (inode->u.generic_ip)
-		file->private_data = inode->u.generic_ip;
+	if (inode->i_private)
+		file->private_data = inode->i_private;
 
 	return 0;
 }
@@ -195,7 +195,7 @@
  *          directory dentry if set.  If this paramater is NULL, then the
  *          file will be created in the root of the securityfs filesystem.
  * @data: a pointer to something that the caller will want to get to later
- *        on.  The inode.u.generic_ip pointer will point to this value on
+ *        on.  The inode.i_private pointer will point to this value on
  *        the open() call.
  * @fops: a pointer to a struct file_operations that should be used for
  *        this file.
@@ -241,7 +241,7 @@
 		if (fops)
 			dentry->d_inode->i_fop = fops;
 		if (data)
-			dentry->d_inode->u.generic_ip = data;
+			dentry->d_inode->i_private = data;
 	}
 exit:
 	return dentry;
Index: linux-2.6.17/fs/inode.c
===================================================================
--- linux-2.6.17.orig/fs/inode.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/fs/inode.c	2006-06-18 18:58:55.000000000 -0400
@@ -164,7 +164,7 @@
 				bdi = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 			mapping->backing_dev_info = bdi;
 		}
-		memset(&inode->u, 0, sizeof(inode->u));
+		inode->i_private = 0;
 		inode->i_mapping = mapping;
 	}
 	return inode;
Index: linux-2.6.17/block/blktrace.c
===================================================================
--- linux-2.6.17.orig/block/blktrace.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/block/blktrace.c	2006-06-18 18:58:55.000000000 -0400
@@ -215,7 +215,7 @@
 
 static int blk_dropped_open(struct inode *inode, struct file *filp)
 {
-	filp->private_data = inode->u.generic_ip;
+	filp->private_data = inode->i_private;
 
 	return 0;
 }
Index: linux-2.6.17/drivers/infiniband/hw/ipath/ipath_fs.c
===================================================================
--- linux-2.6.17.orig/drivers/infiniband/hw/ipath/ipath_fs.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/infiniband/hw/ipath/ipath_fs.c	2006-06-18 18:58:55.000000000 -0400
@@ -64,7 +64,7 @@
 	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks = 0;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	inode->u.generic_ip = data;
+	inode->i_private = data;
 	if ((mode & S_IFMT) == S_IFDIR) {
 		inode->i_op = &simple_dir_inode_operations;
 		inode->i_nlink++;
@@ -119,7 +119,7 @@
 	u16 i;
 	struct ipath_devdata *dd;
 
-	dd = file->f_dentry->d_inode->u.generic_ip;
+	dd = file->f_dentry->d_inode->i_private;
 
 	for (i = 0; i < NUM_COUNTERS; i++)
 		counters[i] = ipath_snap_cntr(dd, i);
@@ -139,7 +139,7 @@
 	struct ipath_devdata *dd;
 	u64 guid;
 
-	dd = file->f_dentry->d_inode->u.generic_ip;
+	dd = file->f_dentry->d_inode->i_private;
 
 	guid = be64_to_cpu(dd->ipath_guid);
 
@@ -178,7 +178,7 @@
 	u32 tmp, tmp2;
 	struct ipath_devdata *dd;
 
-	dd = file->f_dentry->d_inode->u.generic_ip;
+	dd = file->f_dentry->d_inode->i_private;
 
 	/* so we only initialize non-zero fields. */
 	memset(portinfo, 0, sizeof portinfo);
@@ -325,7 +325,7 @@
 		goto bail;
 	}
 
-	dd = file->f_dentry->d_inode->u.generic_ip;
+	dd = file->f_dentry->d_inode->i_private;
 	if (ipath_eeprom_read(dd, pos, tmp, count)) {
 		ipath_dev_err(dd, "failed to read from flash\n");
 		ret = -ENXIO;
@@ -381,7 +381,7 @@
 		goto bail_tmp;
 	}
 
-	dd = file->f_dentry->d_inode->u.generic_ip;
+	dd = file->f_dentry->d_inode->i_private;
 	if (ipath_eeprom_write(dd, pos, tmp, count)) {
 		ret = -ENXIO;
 		ipath_dev_err(dd, "failed to write to flash\n");
Index: linux-2.6.17/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c
===================================================================
--- linux-2.6.17.orig/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c	2006-06-18 18:58:55.000000000 -0400
@@ -54,7 +54,7 @@
 
 static int open_file_generic(struct inode *inode, struct file *file)
 {
-	file->private_data = inode->u.generic_ip;
+	file->private_data = inode->i_private;
 	return 0;
 }
 
Index: linux-2.6.17/kernel/relay.c
===================================================================
--- linux-2.6.17.orig/kernel/relay.c	2006-06-18 18:58:51.000000000 -0400
+++ linux-2.6.17/kernel/relay.c	2006-06-18 18:58:55.000000000 -0400
@@ -669,7 +669,7 @@
  */
 static int relay_file_open(struct inode *inode, struct file *filp)
 {
-	struct rchan_buf *buf = inode->u.generic_ip;
+	struct rchan_buf *buf = inode->i_private;
 	kref_get(&buf->kref);
 	filp->private_data = buf;
 

--
