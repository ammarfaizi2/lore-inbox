Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWGCBAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWGCBAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWGCBAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:00:31 -0400
Received: from thunk.org ([69.25.196.29]:2244 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750948AbWGCBAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:00:25 -0400
Message-Id: <20060703010021.670350000@candygram.thunk.org>
References: <20060703005333.706556000@candygram.thunk.org>
Date: Sun, 02 Jul 2006 20:53:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Content-Disposition: inline; filename=inode-slim-1
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

Index: linux-2.6.17-mm5/include/linux/fs.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/fs.h	2006-07-02 20:25:49.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/fs.h	2006-07-02 20:27:00.000000000 -0400
@@ -549,9 +549,7 @@
 
 	atomic_t		i_writecount;
 	void			*i_security;
-	union {
-		void		*generic_ip;
-	} u;
+	void			*i_private; /* fs or device private pointer */
 #ifdef __NEED_I_SIZE_ORDERED
 	seqcount_t		i_size_seqcount;
 #endif
Index: linux-2.6.17-mm5/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/arch/powerpc/platforms/cell/spufs/inode.c	2006-07-02 20:25:20.000000000 -0400
+++ linux-2.6.17-mm5/arch/powerpc/platforms/cell/spufs/inode.c	2006-07-02 20:27:00.000000000 -0400
@@ -120,7 +120,7 @@
 	ret = 0;
 	inode->i_op = &spufs_file_iops;
 	inode->i_fop = fops;
-	inode->u.generic_ip = SPUFS_I(inode)->i_ctx = get_spu_context(ctx);
+	inode->i_private = SPUFS_I(inode)->i_ctx = get_spu_context(ctx);
 	d_add(dentry, inode);
 out:
 	return ret;
Index: linux-2.6.17-mm5/arch/s390/kernel/debug.c
===================================================================
--- linux-2.6.17-mm5.orig/arch/s390/kernel/debug.c	2006-07-02 20:25:22.000000000 -0400
+++ linux-2.6.17-mm5/arch/s390/kernel/debug.c	2006-07-02 20:27:00.000000000 -0400
@@ -603,7 +603,7 @@
 	debug_info_t *debug_info, *debug_info_snapshot;
 
 	down(&debug_lock);
-	debug_info = (struct debug_info*)file->f_dentry->d_inode->u.generic_ip;
+	debug_info = file->f_dentry->d_inode->i_private;
 	/* find debug view */
 	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
 		if (!debug_info->views[i])
Index: linux-2.6.17-mm5/drivers/i2c/chips/tps65010.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/i2c/chips/tps65010.c	2006-07-02 20:25:31.000000000 -0400
+++ linux-2.6.17-mm5/drivers/i2c/chips/tps65010.c	2006-07-02 20:27:00.000000000 -0400
@@ -306,7 +306,7 @@
 
 static int dbg_tps_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, dbg_show, inode->u.generic_ip);
+	return single_open(file, dbg_show, inode->i_private);
 }
 
 static struct file_operations debug_fops = {
Index: linux-2.6.17-mm5/drivers/infiniband/ulp/ipoib/ipoib_fs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/infiniband/ulp/ipoib/ipoib_fs.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/drivers/infiniband/ulp/ipoib/ipoib_fs.c	2006-07-02 20:27:00.000000000 -0400
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
Index: linux-2.6.17-mm5/drivers/misc/ibmasm/ibmasmfs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/misc/ibmasm/ibmasmfs.c	2006-07-02 20:25:39.000000000 -0400
+++ linux-2.6.17-mm5/drivers/misc/ibmasm/ibmasmfs.c	2006-07-02 20:27:00.000000000 -0400
@@ -175,7 +175,7 @@
 	}
 
 	inode->i_fop = fops;
-	inode->u.generic_ip = data;
+	inode->i_private = data;
 
 	d_add(dentry, inode);
 	return dentry;
@@ -244,7 +244,7 @@
 {
 	struct ibmasmfs_command_data *command_data;
 
-	if (!inode->u.generic_ip)
+	if (!inode->i_private)
 		return -ENODEV;
 
 	command_data = kmalloc(sizeof(struct ibmasmfs_command_data), GFP_KERNEL);
@@ -252,7 +252,7 @@
 		return -ENOMEM;
 
 	command_data->command = NULL;
-	command_data->sp = inode->u.generic_ip;
+	command_data->sp = inode->i_private;
 	file->private_data = command_data;
 	return 0;
 }
@@ -351,10 +351,10 @@
 	struct ibmasmfs_event_data *event_data;
 	struct service_processor *sp; 
 
-	if (!inode->u.generic_ip)
+	if (!inode->i_private)
 		return -ENODEV;
 
-	sp = inode->u.generic_ip;
+	sp = inode->i_private;
 
 	event_data = kmalloc(sizeof(struct ibmasmfs_event_data), GFP_KERNEL);
 	if (!event_data)
@@ -439,14 +439,14 @@
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
@@ -508,7 +508,7 @@
 
 static int remote_settings_file_open(struct inode *inode, struct file *file)
 {
-	file->private_data = inode->u.generic_ip;
+	file->private_data = inode->i_private;
 	return 0;
 }
 
Index: linux-2.6.17-mm5/drivers/net/irda/vlsi_ir.h
===================================================================
--- linux-2.6.17-mm5.orig/drivers/net/irda/vlsi_ir.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/drivers/net/irda/vlsi_ir.h	2006-07-02 20:27:00.000000000 -0400
@@ -58,7 +58,7 @@
 
 /* PDE() introduced in 2.5.4 */
 #ifdef CONFIG_PROC_FS
-#define PDE(inode) ((inode)->u.generic_ip)
+#define PDE(inode) ((inode)->i_private)
 #endif
 
 /* irda crc16 calculation exported in 2.5.42 */
Index: linux-2.6.17-mm5/drivers/oprofile/oprofilefs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/oprofile/oprofilefs.c	2006-07-02 20:25:42.000000000 -0400
+++ linux-2.6.17-mm5/drivers/oprofile/oprofilefs.c	2006-07-02 20:27:00.000000000 -0400
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
 
Index: linux-2.6.17-mm5/drivers/pci/hotplug/cpqphp_sysfs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/pci/hotplug/cpqphp_sysfs.c	2006-07-02 20:25:42.000000000 -0400
+++ linux-2.6.17-mm5/drivers/pci/hotplug/cpqphp_sysfs.c	2006-07-02 20:27:00.000000000 -0400
@@ -140,7 +140,7 @@
 
 static int open(struct inode *inode, struct file *file)
 {
-	struct controller *ctrl = inode->u.generic_ip;
+	struct controller *ctrl = inode->i_private;
 	struct ctrl_dbg *dbg;
 	int retval = -ENOMEM;
 
Index: linux-2.6.17-mm5/drivers/usb/core/devio.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/usb/core/devio.c	2006-07-02 20:25:44.000000000 -0400
+++ linux-2.6.17-mm5/drivers/usb/core/devio.c	2006-07-02 20:27:00.000000000 -0400
@@ -555,7 +555,7 @@
 	if (imajor(inode) == USB_DEVICE_MAJOR)
 		dev = usbdev_lookup_minor(iminor(inode));
 	if (!dev)
-		dev = inode->u.generic_ip;
+		dev = inode->i_private;
 	if (!dev) {
 		kfree(ps);
 		goto out;
Index: linux-2.6.17-mm5/drivers/usb/core/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/usb/core/inode.c	2006-07-02 20:25:44.000000000 -0400
+++ linux-2.6.17-mm5/drivers/usb/core/inode.c	2006-07-02 20:27:00.000000000 -0400
@@ -402,8 +402,8 @@
 
 static int default_open (struct inode *inode, struct file *file)
 {
-	if (inode->u.generic_ip)
-		file->private_data = inode->u.generic_ip;
+	if (inode->i_private)
+		file->private_data = inode->i_private;
 
 	return 0;
 }
@@ -509,7 +509,7 @@
 	} else {
 		if (dentry->d_inode) {
 			if (data)
-				dentry->d_inode->u.generic_ip = data;
+				dentry->d_inode->i_private = data;
 			if (fops)
 				dentry->d_inode->i_fop = fops;
 			dentry->d_inode->i_uid = uid;
Index: linux-2.6.17-mm5/drivers/usb/gadget/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/usb/gadget/inode.c	2006-07-02 20:25:44.000000000 -0400
+++ linux-2.6.17-mm5/drivers/usb/gadget/inode.c	2006-07-02 20:27:00.000000000 -0400
@@ -844,7 +844,7 @@
 static int
 ep_open (struct inode *inode, struct file *fd)
 {
-	struct ep_data		*data = inode->u.generic_ip;
+	struct ep_data		*data = inode->i_private;
 	int			value = -EBUSY;
 
 	if (down_interruptible (&data->lock) != 0)
@@ -1909,7 +1909,7 @@
 static int
 dev_open (struct inode *inode, struct file *fd)
 {
-	struct dev_data		*dev = inode->u.generic_ip;
+	struct dev_data		*dev = inode->i_private;
 	int			value = -EBUSY;
 
 	if (dev->state == STATE_DEV_DISABLED) {
@@ -1970,7 +1970,7 @@
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime
 				= CURRENT_TIME;
-		inode->u.generic_ip = data;
+		inode->i_private = data;
 		inode->i_fop = fops;
 	}
 	return inode;
Index: linux-2.6.17-mm5/drivers/usb/host/isp116x-hcd.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/usb/host/isp116x-hcd.c	2006-07-02 20:25:45.000000000 -0400
+++ linux-2.6.17-mm5/drivers/usb/host/isp116x-hcd.c	2006-07-02 20:27:00.000000000 -0400
@@ -1204,7 +1204,7 @@
 
 static int isp116x_open_seq(struct inode *inode, struct file *file)
 {
-	return single_open(file, isp116x_show_dbg, inode->u.generic_ip);
+	return single_open(file, isp116x_show_dbg, inode->i_private);
 }
 
 static struct file_operations isp116x_debug_fops = {
Index: linux-2.6.17-mm5/drivers/usb/host/uhci-debug.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/usb/host/uhci-debug.c	2006-07-02 20:25:45.000000000 -0400
+++ linux-2.6.17-mm5/drivers/usb/host/uhci-debug.c	2006-07-02 20:27:00.000000000 -0400
@@ -428,7 +428,7 @@
 
 static int uhci_debug_open(struct inode *inode, struct file *file)
 {
-	struct uhci_hcd *uhci = inode->u.generic_ip;
+	struct uhci_hcd *uhci = inode->i_private;
 	struct uhci_debug *up;
 	int ret = -ENOMEM;
 	unsigned long flags;
Index: linux-2.6.17-mm5/drivers/usb/mon/mon_stat.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/usb/mon/mon_stat.c	2006-07-02 20:25:45.000000000 -0400
+++ linux-2.6.17-mm5/drivers/usb/mon/mon_stat.c	2006-07-02 20:27:00.000000000 -0400
@@ -28,7 +28,7 @@
 	if ((sp = kmalloc(sizeof(struct snap), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 
-	mbus = inode->u.generic_ip;
+	mbus = inode->i_private;
 
 	sp->slen = snprintf(sp->str, STAT_BUF_SIZE,
 	    "nreaders %d events %u text_lost %u\n",
Index: linux-2.6.17-mm5/drivers/usb/mon/mon_text.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/usb/mon/mon_text.c	2006-07-02 20:25:45.000000000 -0400
+++ linux-2.6.17-mm5/drivers/usb/mon/mon_text.c	2006-07-02 20:27:00.000000000 -0400
@@ -238,7 +238,7 @@
 	int rc;
 
 	mutex_lock(&mon_lock);
-	mbus = inode->u.generic_ip;
+	mbus = inode->i_private;
 	ubus = mbus->u_bus;
 
 	rp = kzalloc(sizeof(struct mon_reader_text), GFP_KERNEL);
@@ -401,7 +401,7 @@
 	struct mon_event_text *ep;
 
 	mutex_lock(&mon_lock);
-	mbus = inode->u.generic_ip;
+	mbus = inode->i_private;
 
 	if (mbus->nreaders <= 0) {
 		printk(KERN_ERR TAG ": consistency error on close\n");
Index: linux-2.6.17-mm5/fs/autofs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/autofs/inode.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/autofs/inode.c	2006-07-02 20:27:00.000000000 -0400
@@ -241,7 +241,7 @@
 		
 		inode->i_op = &autofs_symlink_inode_operations;
 		sl = &sbi->symlink[n];
-		inode->u.generic_ip = sl;
+		inode->i_private = sl;
 		inode->i_mode = S_IFLNK | S_IRWXUGO;
 		inode->i_mtime.tv_sec = inode->i_ctime.tv_sec = sl->mtime;
 		inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;
Index: linux-2.6.17-mm5/fs/autofs/symlink.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/autofs/symlink.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/fs/autofs/symlink.c	2006-07-02 20:27:00.000000000 -0400
@@ -15,7 +15,7 @@
 /* Nothing to release.. */
 static void *autofs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
+	char *s=((struct autofs_symlink *)dentry->d_inode->i_private)->data;
 	nd_set_link(nd, s);
 	return NULL;
 }
Index: linux-2.6.17-mm5/fs/binfmt_misc.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/binfmt_misc.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/binfmt_misc.c	2006-07-02 20:27:00.000000000 -0400
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
Index: linux-2.6.17-mm5/fs/debugfs/file.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/debugfs/file.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/debugfs/file.c	2006-07-02 20:27:00.000000000 -0400
@@ -32,8 +32,8 @@
 
 static int default_open(struct inode *inode, struct file *file)
 {
-	if (inode->u.generic_ip)
-		file->private_data = inode->u.generic_ip;
+	if (inode->i_private)
+		file->private_data = inode->i_private;
 
 	return 0;
 }
Index: linux-2.6.17-mm5/fs/debugfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/debugfs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/debugfs/inode.c	2006-07-02 20:27:00.000000000 -0400
@@ -169,7 +169,7 @@
  *          directory dentry if set.  If this paramater is NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @data: a pointer to something that the caller will want to get to later
- *        on.  The inode.u.generic_ip pointer will point to this value on
+ *        on.  The inode.i_private pointer will point to this value on
  *        the open() call.
  * @fops: a pointer to a struct file_operations that should be used for
  *        this file.
@@ -210,7 +210,7 @@
 
 	if (dentry->d_inode) {
 		if (data)
-			dentry->d_inode->u.generic_ip = data;
+			dentry->d_inode->i_private = data;
 		if (fops)
 			dentry->d_inode->i_fop = fops;
 	}
Index: linux-2.6.17-mm5/fs/devpts/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/devpts/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/devpts/inode.c	2006-07-02 20:27:00.000000000 -0400
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
 
Index: linux-2.6.17-mm5/fs/freevxfs/vxfs.h
===================================================================
--- linux-2.6.17-mm5.orig/fs/freevxfs/vxfs.h	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/freevxfs/vxfs.h	2006-07-02 20:27:00.000000000 -0400
@@ -252,7 +252,7 @@
  * Get filesystem private data from VFS inode.
  */
 #define VXFS_INO(ip) \
-	((struct vxfs_inode_info *)(ip)->u.generic_ip)
+	((struct vxfs_inode_info *)(ip)->i_private)
 
 /*
  * Get filesystem private data from VFS superblock.
Index: linux-2.6.17-mm5/fs/freevxfs/vxfs_inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/freevxfs/vxfs_inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/freevxfs/vxfs_inode.c	2006-07-02 20:27:00.000000000 -0400
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
Index: linux-2.6.17-mm5/fs/jffs/inode-v23.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/jffs/inode-v23.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/jffs/inode-v23.c	2006-07-02 20:27:00.000000000 -0400
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
Index: linux-2.6.17-mm5/fs/libfs.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/libfs.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/libfs.c	2006-07-02 20:27:00.000000000 -0400
@@ -547,7 +547,7 @@
 
 	attr->get = get;
 	attr->set = set;
-	attr->data = inode->u.generic_ip;
+	attr->data = inode->i_private;
 	attr->fmt = fmt;
 	mutex_init(&attr->mutex);
 
Index: linux-2.6.17-mm5/fs/ocfs2/dlmglue.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ocfs2/dlmglue.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ocfs2/dlmglue.c	2006-07-02 20:27:00.000000000 -0400
@@ -1995,7 +1995,7 @@
 		mlog_errno(ret);
 		goto out;
 	}
-	osb = (struct ocfs2_super *) inode->u.generic_ip;
+	osb = inode->i_private;
 	ocfs2_get_dlm_debug(osb->osb_dlm_debug);
 	priv->p_dlm_debug = osb->osb_dlm_debug;
 	INIT_LIST_HEAD(&priv->p_iter_res.l_debug_list);
Index: linux-2.6.17-mm5/security/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/security/inode.c	2006-07-02 20:25:50.000000000 -0400
+++ linux-2.6.17-mm5/security/inode.c	2006-07-02 20:27:00.000000000 -0400
@@ -44,8 +44,8 @@
 
 static int default_open(struct inode *inode, struct file *file)
 {
-	if (inode->u.generic_ip)
-		file->private_data = inode->u.generic_ip;
+	if (inode->i_private)
+		file->private_data = inode->i_private;
 
 	return 0;
 }
@@ -194,7 +194,7 @@
  *          directory dentry if set.  If this paramater is NULL, then the
  *          file will be created in the root of the securityfs filesystem.
  * @data: a pointer to something that the caller will want to get to later
- *        on.  The inode.u.generic_ip pointer will point to this value on
+ *        on.  The inode.i_private pointer will point to this value on
  *        the open() call.
  * @fops: a pointer to a struct file_operations that should be used for
  *        this file.
@@ -240,7 +240,7 @@
 		if (fops)
 			dentry->d_inode->i_fop = fops;
 		if (data)
-			dentry->d_inode->u.generic_ip = data;
+			dentry->d_inode->i_private = data;
 	}
 exit:
 	return dentry;
Index: linux-2.6.17-mm5/fs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/inode.c	2006-07-02 20:27:00.000000000 -0400
@@ -163,7 +163,7 @@
 				bdi = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 			mapping->backing_dev_info = bdi;
 		}
-		memset(&inode->u, 0, sizeof(inode->u));
+		inode->i_private = 0;
 		inode->i_mapping = mapping;
 	}
 	return inode;
Index: linux-2.6.17-mm5/block/blktrace.c
===================================================================
--- linux-2.6.17-mm5.orig/block/blktrace.c	2006-07-02 20:25:26.000000000 -0400
+++ linux-2.6.17-mm5/block/blktrace.c	2006-07-02 20:27:00.000000000 -0400
@@ -214,7 +214,7 @@
 
 static int blk_dropped_open(struct inode *inode, struct file *filp)
 {
-	filp->private_data = inode->u.generic_ip;
+	filp->private_data = inode->i_private;
 
 	return 0;
 }
Index: linux-2.6.17-mm5/drivers/infiniband/hw/ipath/ipath_fs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/infiniband/hw/ipath/ipath_fs.c	2006-07-02 20:25:32.000000000 -0400
+++ linux-2.6.17-mm5/drivers/infiniband/hw/ipath/ipath_fs.c	2006-07-02 20:27:00.000000000 -0400
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
Index: linux-2.6.17-mm5/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c	2006-07-02 20:25:41.000000000 -0400
+++ linux-2.6.17-mm5/drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c	2006-07-02 20:27:00.000000000 -0400
@@ -54,7 +54,7 @@
 
 static int open_file_generic(struct inode *inode, struct file *file)
 {
-	file->private_data = inode->u.generic_ip;
+	file->private_data = inode->i_private;
 	return 0;
 }
 
Index: linux-2.6.17-mm5/kernel/relay.c
===================================================================
--- linux-2.6.17-mm5.orig/kernel/relay.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17-mm5/kernel/relay.c	2006-07-02 20:27:00.000000000 -0400
@@ -669,7 +669,7 @@
  */
 static int relay_file_open(struct inode *inode, struct file *filp)
 {
-	struct rchan_buf *buf = inode->u.generic_ip;
+	struct rchan_buf *buf = inode->i_private;
 	kref_get(&buf->kref);
 	filp->private_data = buf;
 
Index: linux-2.6.17-mm5/arch/s390/hypfs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/arch/s390/hypfs/inode.c	2006-07-02 20:25:22.000000000 -0400
+++ linux-2.6.17-mm5/arch/s390/hypfs/inode.c	2006-07-02 20:27:00.000000000 -0400
@@ -104,13 +104,13 @@
 
 static void hypfs_drop_inode(struct inode *inode)
 {
-	kfree(inode->u.generic_ip);
+	kfree(inode->i_private);
 	generic_delete_inode(inode);
 }
 
 static int hypfs_open(struct inode *inode, struct file *filp)
 {
-	char *data = filp->f_dentry->d_inode->u.generic_ip;
+	char *data = filp->f_dentry->d_inode->i_private;
 	struct hypfs_sb_info *fs_info;
 
 	if (filp->f_mode & FMODE_WRITE) {
@@ -350,7 +350,7 @@
 		parent->d_inode->i_nlink++;
 	} else
 		BUG();
-	inode->u.generic_ip = data;
+	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return dentry;
Index: linux-2.6.17-mm5/fs/dlm/debug_fs.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/dlm/debug_fs.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/dlm/debug_fs.c	2006-07-02 20:27:00.000000000 -0400
@@ -254,7 +254,7 @@
 		return ret;
 
 	seq = file->private_data;
-	seq->private = inode->u.generic_ip;
+	seq->private = inode->i_private;
 
 	return 0;
 }
Index: linux-2.6.17-mm5/fs/ecryptfs/ecryptfs_kernel.h
===================================================================
--- linux-2.6.17-mm5.orig/fs/ecryptfs/ecryptfs_kernel.h	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ecryptfs/ecryptfs_kernel.h	2006-07-02 20:27:00.000000000 -0400
@@ -288,25 +288,25 @@
 static inline struct ecryptfs_inode_info *
 ecryptfs_inode_to_private(struct inode *inode)
 {
-	return (struct ecryptfs_inode_info *)inode->u.generic_ip;
+	return (struct ecryptfs_inode_info *)inode->i_private;
 }
 
 static inline void
 ecryptfs_set_inode_private(struct inode *inode,
 			   struct ecryptfs_inode_info *inode_info)
 {
-	inode->u.generic_ip = inode_info;
+	inode->i_private = inode_info;
 }
 
 static inline struct inode *ecryptfs_inode_to_lower(struct inode *inode)
 {
-	return ((struct ecryptfs_inode_info *)inode->u.generic_ip)->wii_inode;
+	return ((struct ecryptfs_inode_info *)inode->i_private)->wii_inode;
 }
 
 static inline void
 ecryptfs_set_inode_lower(struct inode *inode, struct inode *lower_inode)
 {
-	((struct ecryptfs_inode_info *)inode->u.generic_ip)->wii_inode =
+	((struct ecryptfs_inode_info *)inode->i_private)->wii_inode =
 		lower_inode;
 }
 
Index: linux-2.6.17-mm5/fs/ecryptfs/super.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/ecryptfs/super.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/ecryptfs/super.c	2006-07-02 20:27:00.000000000 -0400
@@ -86,7 +86,7 @@
 static void ecryptfs_read_inode(struct inode *inode)
 {
 	/* This is where we setup the self-reference in the vfs_inode's
-	 * u.generic_ip. That way we don't have to walk the list again. */
+	 * i_private. That way we don't have to walk the list again. */
 	ecryptfs_set_inode_private(inode,
 				   list_entry(inode, struct ecryptfs_inode_info,
 					      vfs_inode));
Index: linux-2.6.17-mm5/fs/fuse/control.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/fuse/control.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/fuse/control.c	2006-07-02 20:27:00.000000000 -0400
@@ -23,7 +23,7 @@
 {
 	struct fuse_conn *fc;
 	mutex_lock(&fuse_mutex);
-	fc = file->f_dentry->d_inode->u.generic_ip;
+	fc = file->f_dentry->d_inode->i_private;
 	if (fc)
 		fc = fuse_conn_get(fc);
 	mutex_unlock(&fuse_mutex);
@@ -98,7 +98,7 @@
 		inode->i_op = iop;
 	inode->i_fop = fop;
 	inode->i_nlink = nlink;
-	inode->u.generic_ip = fc;
+	inode->i_private = fc;
 	d_add(dentry, inode);
 	return dentry;
 }
@@ -150,7 +150,7 @@
 
 	for (i = fc->ctl_ndents - 1; i >= 0; i--) {
 		struct dentry *dentry = fc->ctl_dentry[i];
-		dentry->d_inode->u.generic_ip = NULL;
+		dentry->d_inode->i_private = NULL;
 		d_drop(dentry);
 		dput(dentry);
 	}
Index: linux-2.6.17-mm5/fs/gfs2/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/gfs2/inode.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/gfs2/inode.c	2006-07-02 20:27:00.000000000 -0400
@@ -169,7 +169,7 @@
 	if (inode->i_state & I_NEW) {
 		struct gfs2_sbd *sdp = GFS2_SB(inode);
 		umode_t mode = DT2IF(type);
-		inode->u.generic_ip = ip;
+		inode->i_private = ip;
 		inode->i_mode = mode;
 
 		if (S_ISREG(mode)) {
Index: linux-2.6.17-mm5/fs/gfs2/meta_io.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/gfs2/meta_io.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/gfs2/meta_io.c	2006-07-02 20:27:00.000000000 -0400
@@ -186,7 +186,7 @@
 		mapping_set_gfp_mask(aspace->i_mapping, GFP_KERNEL);
 		aspace->i_mapping->a_ops = &aspace_aops;
 		aspace->i_size = ~0ULL;
-		aspace->u.generic_ip = NULL;
+		aspace->i_private = NULL;
 		insert_inode_hash(aspace);
 	}
 	return aspace;
Index: linux-2.6.17-mm5/fs/gfs2/ops_super.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/gfs2/ops_super.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/gfs2/ops_super.c	2006-07-02 20:27:00.000000000 -0400
@@ -55,7 +55,7 @@
 	struct gfs2_inode *ip = GFS2_I(inode);
 
 	/* Check this is a "normal" inode */
-	if (inode->u.generic_ip) {
+	if (inode->i_private) {
 		if (current->flags & PF_MEMALLOC)
 			return 0;
 		if (sync)
@@ -283,7 +283,7 @@
 	 * serves to contain an address space (see rgrp.c, meta_io.c)
 	 * which therefore doesn't have its own glocks.
 	 */
-	if (inode->u.generic_ip) {
+	if (inode->i_private) {
 		struct gfs2_inode *ip = GFS2_I(inode);
 		gfs2_glock_inode_squish(inode);
 		gfs2_assert(inode->i_sb->s_fs_info, ip->i_gl->gl_state == LM_ST_UNLOCKED);
@@ -384,7 +384,7 @@
 	struct gfs2_holder gh;
 	int error;
 
-	if (!inode->u.generic_ip)
+	if (!inode->i_private)
 		goto out;
 
 	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, LM_FLAG_TRY_1CB | GL_NOCACHE, &gh);
Index: linux-2.6.17-mm5/fs/reiser4/inode.h
===================================================================
--- linux-2.6.17-mm5.orig/fs/reiser4/inode.h	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/reiser4/inode.h	2006-07-02 20:27:00.000000000 -0400
@@ -41,7 +41,7 @@
 	REISER4_IMMUTABLE = 2,
 	/* inode was read from storage */
 	REISER4_LOADED = 3,
-	/* this bit is set for symlinks. inode->u.generic_ip points to target
+	/* this bit is set for symlinks. inode->i_private points to target
 	   name of symlink. */
 	REISER4_GENERIC_PTR_USED = 4,
 	/* set if size of stat-data item for this inode is known. If this is
Index: linux-2.6.17-mm5/fs/reiser4/plugin/file/symlink.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/reiser4/plugin/file/symlink.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/reiser4/plugin/file/symlink.c	2006-07-02 20:27:00.000000000 -0400
@@ -42,8 +42,8 @@
 	 */
 	reiser4_inode_data(symlink)->extmask |= (1 << SYMLINK_STAT);
 
-	assert("vs-838", symlink->u.generic_ip == NULL);
-	symlink->u.generic_ip = (void *)data->name;
+	assert("vs-838", symlink->i_private == NULL);
+	symlink->i_private = (void *)data->name;
 
 	assert("vs-843", symlink->i_size == 0);
 	INODE_SET_FIELD(symlink, i_size, strlen(data->name));
@@ -51,14 +51,14 @@
 	/* insert stat data appended with data->name */
 	result = inode_file_plugin(symlink)->write_sd_by_inode(symlink);
 	if (result) {
-		/* FIXME-VS: Make sure that symlink->u.generic_ip is not attached
+		/* FIXME-VS: Make sure that symlink->i_private is not attached
 		   to kmalloced data */
 		INODE_SET_FIELD(symlink, i_size, 0);
 	} else {
-		assert("vs-849", symlink->u.generic_ip
+		assert("vs-849", symlink->i_private
 		       && inode_get_flag(symlink, REISER4_GENERIC_PTR_USED));
 		assert("vs-850",
-		       !memcmp((char *)symlink->u.generic_ip, data->name,
+		       !memcmp((char *)symlink->i_private, data->name,
 			       (size_t) symlink->i_size + 1));
 	}
 	return result;
@@ -76,8 +76,8 @@
 	assert("edward-801", inode_get_flag(inode, REISER4_GENERIC_PTR_USED));
 	assert("vs-839", S_ISLNK(inode->i_mode));
 
-	kfree(inode->u.generic_ip);
-	inode->u.generic_ip = NULL;
+	kfree(inode->i_private);
+	inode->i_private = NULL;
 	inode_clr_flag(inode, REISER4_GENERIC_PTR_USED);
 }
 
Index: linux-2.6.17-mm5/fs/reiser4/plugin/inode_ops.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/reiser4/plugin/inode_ops.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/reiser4/plugin/inode_ops.c	2006-07-02 20:27:00.000000000 -0400
@@ -389,16 +389,16 @@
  *
  * This is common implementation of vfs's followlink method of struct
  * inode_operations.
- * Assumes that inode's generic_ip points to the content of symbolic link.
+ * Assumes that inode's i_private points to the content of symbolic link.
  */
 void *follow_link_common(struct dentry *dentry, struct nameidata *nd)
 {
 	assert("vs-851", S_ISLNK(dentry->d_inode->i_mode));
 
-	if (!dentry->d_inode->u.generic_ip
+	if (!dentry->d_inode->i_private
 	    || !inode_get_flag(dentry->d_inode, REISER4_GENERIC_PTR_USED))
 		return ERR_PTR(RETERR(-EINVAL));
-	nd_set_link(nd, dentry->d_inode->u.generic_ip);
+	nd_set_link(nd, dentry->d_inode->i_private);
 	return NULL;
 }
 
Index: linux-2.6.17-mm5/fs/reiser4/plugin/item/static_stat.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/reiser4/plugin/item/static_stat.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/reiser4/plugin/item/static_stat.c	2006-07-02 20:27:00.000000000 -0400
@@ -430,21 +430,21 @@
 
 /* symlink stat data extension */
 
-/* allocate memory for symlink target and attach it to inode->u.generic_ip */
+/* allocate memory for symlink target and attach it to inode->i_private */
 static int
 symlink_target_to_inode(struct inode *inode, const char *target, int len)
 {
-	assert("vs-845", inode->u.generic_ip == NULL);
+	assert("vs-845", inode->i_private == NULL);
 	assert("vs-846", !inode_get_flag(inode, REISER4_GENERIC_PTR_USED));
 
 	/* FIXME-VS: this is prone to deadlock. Not more than other similar
 	   places, though */
-	inode->u.generic_ip = kmalloc((size_t) len + 1, get_gfp_mask());
-	if (!inode->u.generic_ip)
+	inode->i_private = kmalloc((size_t) len + 1, get_gfp_mask());
+	if (!inode->i_private)
 		return RETERR(-ENOMEM);
 
-	memcpy((char *)(inode->u.generic_ip), target, (size_t) len);
-	((char *)(inode->u.generic_ip))[len] = 0;
+	memcpy((char *)(inode->i_private), target, (size_t) len);
+	((char *)(inode->i_private))[len] = 0;
 	inode_set_flag(inode, REISER4_GENERIC_PTR_USED);
 	return 0;
 }
@@ -499,8 +499,8 @@
 	if (!inode_get_flag(inode, REISER4_GENERIC_PTR_USED)) {
 		const char *target;
 
-		target = (const char *)(inode->u.generic_ip);
-		inode->u.generic_ip = NULL;
+		target = (const char *)(inode->i_private);
+		inode->i_private = NULL;
 
 		result = symlink_target_to_inode(inode, target, length);
 
@@ -510,7 +510,7 @@
 	} else {
 		/* there is nothing to do in update but move area */
 		assert("vs-844",
-		       !memcmp(inode->u.generic_ip, sd->body,
+		       !memcmp(inode->i_private, sd->body,
 			       (size_t) length + 1));
 	}
 
Index: linux-2.6.17-mm5/lib/statistic.c
===================================================================
--- linux-2.6.17-mm5.orig/lib/statistic.c	2006-07-02 20:25:49.000000000 -0400
+++ linux-2.6.17-mm5/lib/statistic.c	2006-07-02 20:27:00.000000000 -0400
@@ -666,7 +666,7 @@
 		struct file *file, struct statistic_interface **interface,
 		struct statistic_file_private **private)
 {
-	*interface = inode->u.generic_ip;
+	*interface = inode->i_private;
 	BUG_ON(!interface);
 	*private = kzalloc(sizeof(struct statistic_file_private), GFP_KERNEL);
 	if (unlikely(!*private))
@@ -749,7 +749,7 @@
 
 static int statistic_def_close(struct inode *inode, struct file *file)
 {
-	struct statistic_interface *interface = inode->u.generic_ip;
+	struct statistic_interface *interface = inode->i_private;
 	struct statistic_file_private *private = file->private_data;
 	struct sgrb_seg *seg, *seg_nl;
 	int offset;

--
