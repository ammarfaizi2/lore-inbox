Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270164AbUJTJ01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270164AbUJTJ01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270057AbUJTJVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:21:10 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:13717 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270317AbUJTJOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:14:00 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=uMCok8qLLjjP1Yt2YmloJ3Rf1HkjnVTUeBkZGMYQLR8F9hEl2kh1+bWa4ApFkRjXiEwUIJmCVHQNKiJauANuCqQf2E8Bbjvz0z3ArJfjKvLcy/S9wnvvOTrgSiy1n7SJjN3NibquSdlXHQxUfmBwPe5hLCF1vxJAyeIgJzxsr+E
Message-ID: <2c59f00304102002135ca68dd0@mail.gmail.com>
Date: Wed, 20 Oct 2004 14:43:59 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove union u from linux/fs.h
Cc: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we need the foolish-looking union with just single entry (void
*generic_ip) in the struct inode linux/fs.h anymore? Why not remove
it?

This patch does that along with the changes in other parts of the
kernel that references the union. Its compile-tested and applies
cleanly to 2.6.9 vanilla.

AG

Signed-off-by: Amit Gud <gud@eth.net>

diff -uprN -X dontdiff linux-2.6.9/drivers/misc/ibmasm/ibmasmfs.c
tmp-2.6.9/drivers/misc/ibmasm/ibmasmfs.c
--- linux-2.6.9/drivers/misc/ibmasm/ibmasmfs.c	2004-10-19
03:24:54.000000000 +0530
+++ tmp-2.6.9/drivers/misc/ibmasm/ibmasmfs.c	2004-10-20 12:50:51.000000000 +0530
@@ -190,7 +190,7 @@ static struct dentry *ibmasmfs_create_fi
 	}
 
 	inode->i_fop = fops;
-	inode->u.generic_ip = data;
+	inode->generic_ip = data;
 
 	d_add(dentry, inode);
 	return dentry;
@@ -263,7 +263,7 @@ static int command_file_open(struct inod
 {
 	struct ibmasmfs_command_data *command_data;
 
-	if (!inode->u.generic_ip)
+	if (!inode->generic_ip)
 		return -ENODEV;
 
 	command_data = kmalloc(sizeof(struct ibmasmfs_command_data), GFP_KERNEL);
@@ -271,7 +271,7 @@ static int command_file_open(struct inod
 		return -ENOMEM;
 
 	command_data->command = NULL;
-	command_data->sp = inode->u.generic_ip;
+	command_data->sp = inode->generic_ip;
 	file->private_data = command_data;
 	return 0;
 }
@@ -370,10 +370,10 @@ static int event_file_open(struct inode 
 	struct ibmasmfs_event_data *event_data;
 	struct service_processor *sp; 
 
-	if (!inode->u.generic_ip)
+	if (!inode->generic_ip)
 		return -ENODEV;
 
-	sp = inode->u.generic_ip;
+	sp = inode->generic_ip;
 
 	event_data = kmalloc(sizeof(struct ibmasmfs_event_data), GFP_KERNEL);
 	if (!event_data)
@@ -440,14 +440,14 @@ static int r_heartbeat_file_open(struct 
 {
 	struct ibmasmfs_heartbeat_data *rhbeat;
 
-	if (!inode->u.generic_ip)
+	if (!inode->generic_ip)
 		return -ENODEV;
 
 	rhbeat = kmalloc(sizeof(struct ibmasmfs_heartbeat_data), GFP_KERNEL);
 	if (!rhbeat)
 		return -ENOMEM;
 
-	rhbeat->sp = (struct service_processor *)inode->u.generic_ip;
+	rhbeat->sp = (struct service_processor *)inode->generic_ip;
 	rhbeat->active = 0;
 	ibmasm_init_reverse_heartbeat(rhbeat->sp, &rhbeat->heartbeat);
 	file->private_data = rhbeat;
@@ -509,7 +509,7 @@ static ssize_t r_heartbeat_file_write(st
 
 static int remote_settings_file_open(struct inode *inode, struct file *file)
 {
-	file->private_data = inode->u.generic_ip;
+	file->private_data = inode->generic_ip;
 	return 0;
 }
 
@@ -589,7 +589,7 @@ static int remote_event_file_open(struct
 	unsigned long flags;
 	struct remote_queue *q;
 	
-	file->private_data = inode->u.generic_ip;
+	file->private_data = inode->generic_ip;
 	sp = file->private_data;
 	q = &sp->remote_queue;
 
diff -uprN -X dontdiff linux-2.6.9/drivers/net/irda/vlsi_ir.h
tmp-2.6.9/drivers/net/irda/vlsi_ir.h
--- linux-2.6.9/drivers/net/irda/vlsi_ir.h	2004-10-19 03:24:37.000000000 +0530
+++ tmp-2.6.9/drivers/net/irda/vlsi_ir.h	2004-10-20 12:48:00.000000000 +0530
@@ -58,7 +58,7 @@ typedef void irqreturn_t;
 
 /* PDE() introduced in 2.5.4 */
 #ifdef CONFIG_PROC_FS
-#define PDE(inode) ((inode)->u.generic_ip)
+#define PDE(inode) ((inode)->generic_ip)
 #endif
 
 /* irda crc16 calculation exported in 2.5.42 */
diff -uprN -X dontdiff linux-2.6.9/drivers/oprofile/oprofilefs.c
tmp-2.6.9/drivers/oprofile/oprofilefs.c
--- linux-2.6.9/drivers/oprofile/oprofilefs.c	2004-10-19
03:23:51.000000000 +0530
+++ tmp-2.6.9/drivers/oprofile/oprofilefs.c	2004-10-20 12:51:31.000000000 +0530
@@ -110,8 +110,8 @@ static ssize_t ulong_write_file(struct f
 
 static int default_open(struct inode * inode, struct file * filp)
 {
-	if (inode->u.generic_ip)
-		filp->private_data = inode->u.generic_ip;
+	if (inode->generic_ip)
+		filp->private_data = inode->generic_ip;
 	return 0;
 }
 
@@ -161,7 +161,7 @@ int oprofilefs_create_ulong(struct super
 	if (!d)
 		return -EFAULT;
 
-	d->d_inode->u.generic_ip = val;
+	d->d_inode->generic_ip = val;
 	return 0;
 }
 
@@ -174,7 +174,7 @@ int oprofilefs_create_ro_ulong(struct su
 	if (!d)
 		return -EFAULT;
 
-	d->d_inode->u.generic_ip = val;
+	d->d_inode->generic_ip = val;
 	return 0;
 }
 
@@ -200,7 +200,7 @@ int oprofilefs_create_ro_atomic(struct s
 	if (!d)
 		return -EFAULT;
 
-	d->d_inode->u.generic_ip = val;
+	d->d_inode->generic_ip = val;
 	return 0;
 }
 
diff -uprN -X dontdiff linux-2.6.9/drivers/usb/core/devio.c
tmp-2.6.9/drivers/usb/core/devio.c
--- linux-2.6.9/drivers/usb/core/devio.c	2004-10-19 03:24:08.000000000 +0530
+++ tmp-2.6.9/drivers/usb/core/devio.c	2004-10-20 12:48:33.000000000 +0530
@@ -485,7 +485,7 @@ static int usbdev_open(struct inode *ino
 
 	lock_kernel();
 	ret = -ENOENT;
-	dev = usb_get_dev(inode->u.generic_ip);
+	dev = usb_get_dev(inode->generic_ip);
 	if (!dev) {
 		kfree(ps);
 		goto out;
diff -uprN -X dontdiff linux-2.6.9/drivers/usb/core/inode.c
tmp-2.6.9/drivers/usb/core/inode.c
--- linux-2.6.9/drivers/usb/core/inode.c	2004-10-19 03:23:11.000000000 +0530
+++ tmp-2.6.9/drivers/usb/core/inode.c	2004-10-20 12:49:26.000000000 +0530
@@ -407,8 +407,8 @@ static loff_t default_file_lseek (struct
 
 static int default_open (struct inode *inode, struct file *file)
 {
-	if (inode->u.generic_ip)
-		file->private_data = inode->u.generic_ip;
+	if (inode->generic_ip)
+		file->private_data = inode->generic_ip;
 
 	return 0;
 }
@@ -528,7 +528,7 @@ static struct dentry *fs_create_file (co
 	} else {
 		if (dentry->d_inode) {
 			if (data)
-				dentry->d_inode->u.generic_ip = data;
+				dentry->d_inode->generic_ip = data;
 			if (fops)
 				dentry->d_inode->i_fop = fops;
 			dentry->d_inode->i_uid = uid;
diff -uprN -X dontdiff linux-2.6.9/drivers/usb/gadget/inode.c
tmp-2.6.9/drivers/usb/gadget/inode.c
--- linux-2.6.9/drivers/usb/gadget/inode.c	2004-10-19 03:24:40.000000000 +0530
+++ tmp-2.6.9/drivers/usb/gadget/inode.c	2004-10-20 12:49:57.000000000 +0530
@@ -844,7 +844,7 @@ fail1:
 static int
 ep_open (struct inode *inode, struct file *fd)
 {
-	struct ep_data		*data = inode->u.generic_ip;
+	struct ep_data		*data = inode->generic_ip;
 	int			value = -EBUSY;
 
 	if (down_interruptible (&data->lock) != 0)
@@ -1904,7 +1904,7 @@ fail:
 static int
 dev_open (struct inode *inode, struct file *fd)
 {
-	struct dev_data		*dev = inode->u.generic_ip;
+	struct dev_data		*dev = inode->generic_ip;
 	int			value = -EBUSY;
 
 	if (dev->state == STATE_DEV_DISABLED) {
@@ -1965,7 +1965,7 @@ gadgetfs_make_inode (struct super_block 
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime
 				= CURRENT_TIME;
-		inode->u.generic_ip = data;
+		inode->generic_ip = data;
 		inode->i_fop = fops;
 	}
 	return inode;
diff -uprN -X dontdiff linux-2.6.9/fs/autofs/inode.c tmp-2.6.9/fs/autofs/inode.c
--- linux-2.6.9/fs/autofs/inode.c	2004-10-19 03:24:40.000000000 +0530
+++ tmp-2.6.9/fs/autofs/inode.c	2004-10-20 12:43:21.000000000 +0530
@@ -239,7 +239,7 @@ static void autofs_read_inode(struct ino
 		
 		inode->i_op = &autofs_symlink_inode_operations;
 		sl = &sbi->symlink[n];
-		inode->u.generic_ip = sl;
+		inode->generic_ip = sl;
 		inode->i_mode = S_IFLNK | S_IRWXUGO;
 		inode->i_mtime.tv_sec = inode->i_ctime.tv_sec = sl->mtime;
 		inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;
diff -uprN -X dontdiff linux-2.6.9/fs/autofs/symlink.c
tmp-2.6.9/fs/autofs/symlink.c
--- linux-2.6.9/fs/autofs/symlink.c	2004-10-19 03:24:55.000000000 +0530
+++ tmp-2.6.9/fs/autofs/symlink.c	2004-10-20 12:43:01.000000000 +0530
@@ -14,7 +14,7 @@
 
 static int autofs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
+	char *s=((struct autofs_symlink *)dentry->d_inode->generic_ip)->data;
 	nd_set_link(nd, s);
 	return 0;
 }
diff -uprN -X dontdiff linux-2.6.9/fs/binfmt_misc.c tmp-2.6.9/fs/binfmt_misc.c
--- linux-2.6.9/fs/binfmt_misc.c	2004-10-19 03:23:50.000000000 +0530
+++ tmp-2.6.9/fs/binfmt_misc.c	2004-10-20 12:42:32.000000000 +0530
@@ -516,7 +516,7 @@ static struct inode *bm_get_inode(struct
 
 static void bm_clear_inode(struct inode *inode)
 {
-	kfree(inode->u.generic_ip);
+	kfree(inode->generic_ip);
 }
 
 static void kill_node(Node *e)
@@ -544,7 +544,7 @@ static void kill_node(Node *e)
 static ssize_t
 bm_entry_read(struct file * file, char __user * buf, size_t nbytes,
loff_t *ppos)
 {
-	Node *e = file->f_dentry->d_inode->u.generic_ip;
+	Node *e = file->f_dentry->d_inode->generic_ip;
 	loff_t pos = *ppos;
 	ssize_t res;
 	char *page;
@@ -578,7 +578,7 @@ static ssize_t bm_entry_write(struct fil
 				size_t count, loff_t *ppos)
 {
 	struct dentry *root;
-	Node *e = file->f_dentry->d_inode->u.generic_ip;
+	Node *e = file->f_dentry->d_inode->generic_ip;
 	int res = parse_command(buffer, count);
 
 	switch (res) {
@@ -645,7 +645,7 @@ static ssize_t bm_register_write(struct 
 	}
 
 	e->dentry = dget(dentry);
-	inode->u.generic_ip = e;
+	inode->generic_ip = e;
 	inode->i_fop = &bm_entry_operations;
 
 	d_instantiate(dentry, inode);
diff -uprN -X dontdiff linux-2.6.9/fs/devfs/base.c tmp-2.6.9/fs/devfs/base.c
--- linux-2.6.9/fs/devfs/base.c	2004-10-19 03:23:24.000000000 +0530
+++ tmp-2.6.9/fs/devfs/base.c	2004-10-20 12:41:35.000000000 +0530
@@ -521,7 +521,7 @@
   v0.109
     20010807   Richard Gooch <rgooch@atnf.csiro.au>
 	       Fixed inode table races by removing it and using
-	       inode->u.generic_ip instead.
+	       inode->generic_ip instead.
 	       Moved <devfs_read_inode> into <get_vfs_inode>.
 	       Moved <devfs_write_inode> into <devfs_notify_change>.
   v0.110
@@ -1266,8 +1266,8 @@ static struct devfs_entry *get_devfs_ent
 {
 	if (inode == NULL)
 		return NULL;
-	VERIFY_ENTRY((struct devfs_entry *)inode->u.generic_ip);
-	return inode->u.generic_ip;
+	VERIFY_ENTRY((struct devfs_entry *)inode->generic_ip);
+	return inode->generic_ip;
 }				/*  End Function get_devfs_entry_from_vfs_inode  */
 
 /**
@@ -1921,7 +1921,7 @@ static struct inode *_devfs_get_vfs_inod
 		return NULL;
 	}
 	/* FIXME where is devfs_put? */
-	inode->u.generic_ip = devfs_get(de);
+	inode->generic_ip = devfs_get(de);
 	inode->i_ino = de->inode.ino;
 	DPRINTK(DEBUG_I_GET, "(%d): VFS inode: %p  devfs_entry: %p\n",
 		(int)inode->i_ino, inode, de);
diff -uprN -X dontdiff linux-2.6.9/fs/devpts/inode.c tmp-2.6.9/fs/devpts/inode.c
--- linux-2.6.9/fs/devpts/inode.c	2004-10-19 03:23:43.000000000 +0530
+++ tmp-2.6.9/fs/devpts/inode.c	2004-10-20 12:44:25.000000000 +0530
@@ -163,7 +163,7 @@ int devpts_pty_new(struct tty_struct *tt
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|config.mode, device);
 	inode->i_op = &devpts_file_inode_operations;
-	inode->u.generic_ip = tty;
+	inode->generic_ip = tty;
 
 	dentry = get_node(number);
 	if (!IS_ERR(dentry) && !dentry->d_inode)
@@ -182,7 +182,7 @@ struct tty_struct *devpts_get_tty(int nu
 	tty = NULL;
 	if (!IS_ERR(dentry)) {
 		if (dentry->d_inode)
-			tty = dentry->d_inode->u.generic_ip;
+			tty = dentry->d_inode->generic_ip;
 		dput(dentry);
 	}
 
diff -uprN -X dontdiff linux-2.6.9/fs/freevxfs/vxfs.h
tmp-2.6.9/fs/freevxfs/vxfs.h
--- linux-2.6.9/fs/freevxfs/vxfs.h	2004-10-19 03:24:20.000000000 +0530
+++ tmp-2.6.9/fs/freevxfs/vxfs.h	2004-10-20 12:45:55.000000000 +0530
@@ -253,7 +253,7 @@ enum {
  * Get filesystem private data from VFS inode.
  */
 #define VXFS_INO(ip) \
-	((struct vxfs_inode_info *)(ip)->u.generic_ip)
+	((struct vxfs_inode_info *)(ip)->generic_ip)
 
 /*
  * Get filesystem private data from VFS superblock.
diff -uprN -X dontdiff linux-2.6.9/fs/freevxfs/vxfs_inode.c
tmp-2.6.9/fs/freevxfs/vxfs_inode.c
--- linux-2.6.9/fs/freevxfs/vxfs_inode.c	2004-10-19 03:23:43.000000000 +0530
+++ tmp-2.6.9/fs/freevxfs/vxfs_inode.c	2004-10-20 12:45:29.000000000 +0530
@@ -252,7 +252,7 @@ vxfs_iinit(struct inode *ip, struct vxfs
 	ip->i_blocks = vip->vii_blocks;
 	ip->i_generation = vip->vii_gen;
 
-	ip->u.generic_ip = (void *)vip;
+	ip->generic_ip = (void *)vip;
 	
 }
 
@@ -347,5 +347,5 @@ vxfs_read_inode(struct inode *ip)
 void
 vxfs_clear_inode(struct inode *ip)
 {
-	kmem_cache_free(vxfs_inode_cachep, ip->u.generic_ip);
+	kmem_cache_free(vxfs_inode_cachep, ip->generic_ip);
 }
diff -uprN -X dontdiff linux-2.6.9/fs/inode.c tmp-2.6.9/fs/inode.c
--- linux-2.6.9/fs/inode.c	2004-10-19 03:25:29.000000000 +0530
+++ tmp-2.6.9/fs/inode.c	2004-10-20 13:44:25.000000000 +0530
@@ -164,7 +164,7 @@ static struct inode *alloc_inode(struct 
 				bdi = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 			mapping->backing_dev_info = bdi;
 		}
-		memset(&inode->u, 0, sizeof(inode->u));
+		inode->generic_ip = NULL;
 		inode->i_mapping = mapping;
 	}
 	return inode;
diff -uprN -X dontdiff linux-2.6.9/fs/jffs/inode-v23.c
tmp-2.6.9/fs/jffs/inode-v23.c
--- linux-2.6.9/fs/jffs/inode-v23.c	2004-10-19 03:24:37.000000000 +0530
+++ tmp-2.6.9/fs/jffs/inode-v23.c	2004-10-20 12:40:01.000000000 +0530
@@ -369,7 +369,7 @@ jffs_new_inode(const struct inode * dir,
 
 	f = jffs_find_file(c, raw_inode->ino);
 
-	inode->u.generic_ip = (void *)f;
+	inode->generic_ip = (void *)f;
 	insert_inode_hash(inode);
 
 	return inode;
@@ -442,7 +442,7 @@ jffs_rename(struct inode *old_dir, struc
 	});
 
 	result = -ENOTDIR;
-	if (!(old_dir_f = (struct jffs_file *)old_dir->u.generic_ip)) {
+	if (!(old_dir_f = (struct jffs_file *)old_dir->generic_ip)) {
 		D(printk("jffs_rename(): Old dir invalid.\n"));
 		goto jffs_rename_end;
 	}
@@ -456,7 +456,7 @@ jffs_rename(struct inode *old_dir, struc
 
 	/* Find the new directory.  */
 	result = -ENOTDIR;
-	if (!(new_dir_f = (struct jffs_file *)new_dir->u.generic_ip)) {
+	if (!(new_dir_f = (struct jffs_file *)new_dir->generic_ip)) {
 		D(printk("jffs_rename(): New dir invalid.\n"));
 		goto jffs_rename_end;
 	}
@@ -593,7 +593,7 @@ jffs_readdir(struct file *filp, void *di
 		}
 		else {
 			ddino = ((struct jffs_file *)
-				 inode->u.generic_ip)->pino;
+				 inode->generic_ip)->pino;
 		}
 		D3(printk("jffs_readdir(): \"..\" %u\n", ddino));
 		if (filldir(dirent, "..", 2, filp->f_pos, ddino, DT_DIR) < 0) {
@@ -604,7 +604,7 @@ jffs_readdir(struct file *filp, void *di
 		}
 		filp->f_pos++;
 	}
-	f = ((struct jffs_file *)inode->u.generic_ip)->children;
+	f = ((struct jffs_file *)inode->generic_ip)->children;
 
 	j = 2;
 	while(f && (f->deleted || j++ < filp->f_pos )) {
@@ -668,7 +668,7 @@ jffs_lookup(struct inode *dir, struct de
 	}
 
 	r = -EACCES;
-	if (!(d = (struct jffs_file *)dir->u.generic_ip)) {
+	if (!(d = (struct jffs_file *)dir->generic_ip)) {
 		D(printk("jffs_lookup(): No such inode! (%lu)\n",
 			 dir->i_ino));
 		goto jffs_lookup_end;
@@ -739,7 +739,7 @@ jffs_do_readpage_nolock(struct file *fil
 	unsigned long read_len;
 	int result;
 	struct inode *inode = (struct inode*)page->mapping->host;
-	struct jffs_file *f = (struct jffs_file *)inode->u.generic_ip;
+	struct jffs_file *f = (struct jffs_file *)inode->generic_ip;
 	struct jffs_control *c = (struct jffs_control *)inode->i_sb->s_fs_info;
 	int r;
 	loff_t offset;
@@ -828,7 +828,7 @@ jffs_mkdir(struct inode *dir, struct den
 	});
 
 	lock_kernel();
-	dir_f = (struct jffs_file *)dir->u.generic_ip;
+	dir_f = (struct jffs_file *)dir->generic_ip;
 
 	ASSERT(if (!dir_f) {
 		printk(KERN_ERR "jffs_mkdir(): No reference to a "
@@ -972,7 +972,7 @@ jffs_remove(struct inode *dir, struct de
 		kfree(_name);
 	});
 
-	dir_f = (struct jffs_file *) dir->u.generic_ip;
+	dir_f = (struct jffs_file *) dir->generic_ip;
 	c = dir_f->c;
 
 	result = -ENOENT;
@@ -1082,7 +1082,7 @@ jffs_mknod(struct inode *dir, struct den
 	if (!old_valid_dev(rdev))
 		return -EINVAL;
 	lock_kernel();
-	dir_f = (struct jffs_file *)dir->u.generic_ip;
+	dir_f = (struct jffs_file *)dir->generic_ip;
 	c = dir_f->c;
 
 	D3(printk (KERN_NOTICE "mknod(): down biglock\n"));
@@ -1186,7 +1186,7 @@ jffs_symlink(struct inode *dir, struct d
 		kfree(_symname);
 	});
 
-	dir_f = (struct jffs_file *)dir->u.generic_ip;
+	dir_f = (struct jffs_file *)dir->generic_ip;
 	ASSERT(if (!dir_f) {
 		printk(KERN_ERR "jffs_symlink(): No reference to a "
 		       "jffs_file struct in inode.\n");
@@ -1289,7 +1289,7 @@ jffs_create(struct inode *dir, struct de
 		kfree(s);
 	});
 
-	dir_f = (struct jffs_file *)dir->u.generic_ip;
+	dir_f = (struct jffs_file *)dir->generic_ip;
 	ASSERT(if (!dir_f) {
 		printk(KERN_ERR "jffs_create(): No reference to a "
 		       "jffs_file struct in inode.\n");
@@ -1403,9 +1403,9 @@ jffs_file_write(struct file *filp, const
 		goto out_isem;
 	}
 
-	if (!(f = (struct jffs_file *)inode->u.generic_ip)) {
-		D(printk("jffs_file_write(): inode->u.generic_ip = 0x%p\n",
-				inode->u.generic_ip));
+	if (!(f = (struct jffs_file *)inode->generic_ip)) {
+		D(printk("jffs_file_write(): inode->generic_ip = 0x%p\n",
+				inode->generic_ip));
 		goto out_isem;
 	}
 
@@ -1696,7 +1696,7 @@ jffs_read_inode(struct inode *inode)
 		up(&c->fmc->biglock);
 		return;
 	}
-	inode->u.generic_ip = (void *)f;
+	inode->generic_ip = (void *)f;
 	inode->i_mode = f->mode;
 	inode->i_nlink = f->nlink;
 	inode->i_uid = f->uid;
@@ -1750,7 +1750,7 @@ jffs_delete_inode(struct inode *inode)
 	lock_kernel();
 	inode->i_size = 0;
 	inode->i_blocks = 0;
-	inode->u.generic_ip = NULL;
+	inode->generic_ip = NULL;
 	clear_inode(inode);
 	if (inode->i_nlink == 0) {
 		c = (struct jffs_control *) inode->i_sb->s_fs_info;
diff -uprN -X dontdiff linux-2.6.9/fs/openpromfs/inode.c
tmp-2.6.9/fs/openpromfs/inode.c
--- linux-2.6.9/fs/openpromfs/inode.c	2004-10-19 03:24:07.000000000 +0530
+++ tmp-2.6.9/fs/openpromfs/inode.c	2004-10-20 12:47:16.000000000 +0530
@@ -70,9 +70,9 @@ static ssize_t nodenum_read(struct file 
 	struct inode *inode = file->f_dentry->d_inode;
 	char buffer[10];
 	
-	if (count < 0 || !inode->u.generic_ip)
+	if (count < 0 || !inode->generic_ip)
 		return -EINVAL;
-	sprintf (buffer, "%8.8x\n", (u32)(long)(inode->u.generic_ip));
+	sprintf (buffer, "%8.8x\n", (u32)(long)(inode->generic_ip));
 	if (file->f_pos >= 9)
 		return 0;
 	if (count > 9 - file->f_pos)
@@ -97,9 +97,9 @@ static ssize_t property_read(struct file
 	if (*ppos >= 0xffffff || count >= 0xffffff)
 		return -EINVAL;
 	if (!filp->private_data) {
-		node = nodes[(u16)((long)inode->u.generic_ip)].node;
-		i = ((u32)(long)inode->u.generic_ip) >> 16;
-		if ((u16)((long)inode->u.generic_ip) == aliases) {
+		node = nodes[(u16)((long)inode->generic_ip)].node;
+		i = ((u32)(long)inode->generic_ip) >> 16;
+		if ((u16)((long)inode->generic_ip) == aliases) {
 			if (i >= aliases_nodes)
 				p = NULL;
 			else
@@ -113,7 +113,7 @@ static ssize_t property_read(struct file
 			return -EIO;
 		i = prom_getproplen (node, p);
 		if (i < 0) {
-			if ((u16)((long)inode->u.generic_ip) == aliases)
+			if ((u16)((long)inode->generic_ip) == aliases)
 				i = 0;
 			else
 				return -EIO;
@@ -539,8 +539,8 @@ int property_release (struct inode *inod
 	if (!op)
 		return 0;
 	lock_kernel();
-	node = nodes[(u16)((long)inode->u.generic_ip)].node;
-	if ((u16)((long)inode->u.generic_ip) == aliases) {
+	node = nodes[(u16)((long)inode->generic_ip)].node;
+	if ((u16)((long)inode->generic_ip) == aliases) {
 		if ((op->flag & OPP_DIRTY) && (op->flag & OPP_STRING)) {
 			char *p = op->name;
 			int i = (op->value - op->name) - strlen (op->name) - 1;
@@ -743,7 +743,7 @@ static struct dentry *openpromfs_lookup(
 		inode->i_mode = S_IFREG | S_IRUGO;
 		inode->i_fop = &openpromfs_nodenum_ops;
 		inode->i_nlink = 1;
-		inode->u.generic_ip = (void *)(long)(n);
+		inode->generic_ip = (void *)(long)(n);
 		break;
 	case OPFSL_PROPERTY:
 		if ((dirnode == options) && (len == 17)
@@ -760,7 +760,7 @@ static struct dentry *openpromfs_lookup(
 		inode->i_nlink = 1;
 		if (inode->i_size < 0)
 			inode->i_size = 0;
-		inode->u.generic_ip = (void *)(long)(((u16)dirnode) | 
+		inode->generic_ip = (void *)(long)(((u16)dirnode) | 
 			(((u16)(ino - NODEP2INO(NODE(dir->i_ino).first_prop) - 1)) << 16));
 		break;
 	}
@@ -886,7 +886,7 @@ static int openpromfs_create (struct ino
 	inode->i_fop = &openpromfs_prop_ops;
 	inode->i_nlink = 1;
 	if (inode->i_size < 0) inode->i_size = 0;
-	inode->u.generic_ip = (void *)(long)(((u16)aliases) | 
+	inode->generic_ip = (void *)(long)(((u16)aliases) | 
 			(((u16)(aliases_nodes - 1)) << 16));
 	unlock_kernel();
 	d_instantiate(dentry, inode);
diff -uprN -X dontdiff linux-2.6.9/include/linux/fs.h
tmp-2.6.9/include/linux/fs.h
--- linux-2.6.9/include/linux/fs.h	2004-10-19 03:23:44.000000000 +0530
+++ tmp-2.6.9/include/linux/fs.h	2004-10-20 12:52:46.000000000 +0530
@@ -469,9 +469,8 @@ struct inode {
 
 	atomic_t		i_writecount;
 	void			*i_security;
-	union {
-		void		*generic_ip;
-	} u;
+	void			*generic_ip;
+	
 #ifdef __NEED_I_SIZE_ORDERED
 	seqcount_t		i_size_seqcount;
 #endif
