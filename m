Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbUBATMu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 14:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUBATMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 14:12:50 -0500
Received: from mx1.mail.ru ([194.67.23.21]:7442 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S265105AbUBATL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 14:11:27 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Sun, 1 Feb 2004 22:09:05 +0300
To: Andrew Morton <akpm@osdl.org>
Cc: Jim Faulkner <jfaulkne@ccs.neu.edu>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG under 2.6.1-mm5
Message-ID: <20040201190905.GA3873@localhost.localdomain>
References: <Pine.GSO.4.58.0401211708090.15123@denali.ccs.neu.edu> <20040121144804.598c2998.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20040121144804.598c2998.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 21, 2004 at 02:48:04PM -0800, Andrew Morton wrote:
> Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
> >
> > 
> > Hello,
> > 
> > I am seeing some scary looking kernel bug entries in my dmesg under
> > 2.6.1-mm5.
> > ...
> 
> > kernel BUG at fs/dcache.c:760!
> > invalid operand: 0000 [#1]
> > PREEMPT SMP
> > CPU:    0
> > EIP:    0060:[<c0179627>]    Not tainted VLI
> > EFLAGS: 00010287
> > EIP is at d_instantiate+0x17/0x90
> > eax: f7baf200   ebx: c1b8bac0   ecx: 000021a4   edx: 00000000
> > esi: f7a4f868   edi: f7baf200   ebp: f7a4f840   esp: f7a79e3c
> > ds: 007b   es: 007b   ss: 0068
> > Process hotplug (pid: 24, threadinfo=f7a78000 task=c1b06d00)
> > Stack: 00000000 f7a992e4 c1b8bac0 c1b35940 f7a78000 f7a4f840 c01ad6de
> > f7a4f840
> >        f7baf200 f7a4f840 f7a41e1c c1bbeb40 00000000 c1b06d00 c011f5b0
> > 00000000
> >        00000000 f7a96d00 c1b06d00 c011bb7d 00000000 c1b06d00 c011f5b0
> > 00000000
> > Call Trace:
> >  [<c01ad6de>] devfs_d_revalidate_wait+0xbe/0x1b0
> >  [<c011f5b0>] default_wake_function+0x0/0x20
> >  [<c011bb7d>] do_page_fault+0x32d/0x512
> >  [<c011f5b0>] default_wake_function+0x0/0x20
> >  [<c016e868>] do_lookup+0x68/0xb0
> >  [<c016ede8>] link_path_walk+0x538/0xa30
> >  [<c016fd03>] open_namei+0x83/0x420
> >  [<c011b850>] do_page_fault+0x0/0x512
> >  [<c040d4cb>] error_code+0x2f/0x38
> >  [<c015e61e>] filp_open+0x3e/0x70
> >  [<c015eb9b>] sys_open+0x5b/0x90
> >  [<c040c992>] sysenter_past_esp+0x43/0x65
> 
> hmm.  There was a patch in that area which I have subsequently dropped
> because it was really fixing devfs problems in the wrong place.
> 
> Perhaps Andrey can ask you to test a subsequent patch if he takes another
> look at this.
> 
> 

good. here is extended version that includes the same fix + some
cleanup. It removes dead code, removes long obsolete attempt to manage
module refcounting, unifies bdev and cdev - they are treated equal now.

andrew please consider for -mm for testing.

More cleanup will follow.


-andrey


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.2-rc3-devfs_cleanup-0.patch"

diff -Nrup ../tmp/linux-2.6.2-rc3/fs/devfs/base.c linux-2.6.2-rc2/fs/devfs/base.c
--- ../tmp/linux-2.6.2-rc3/fs/devfs/base.c	2004-01-28 21:35:07.000000000 +0300
+++ linux-2.6.2-rc2/fs/devfs/base.c	2004-02-01 17:03:51.557348456 +0300
@@ -676,6 +676,7 @@
 #include <linux/smp.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/namei.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -685,9 +686,7 @@
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
-#include "internal.h"
-
-#define DEVFS_VERSION            "1.22 (20021013)"
+#define DEVFS_VERSION            "2004-01-31"
 
 #define DEVFS_NAME "devfs"
 
@@ -762,18 +761,6 @@ struct directory_type
     unsigned char no_more_additions:1;
 };
 
-struct bdev_type
-{
-    dev_t dev;
-};
-
-struct cdev_type
-{
-    struct file_operations *ops;
-    dev_t dev;
-    unsigned char autogen:1;
-};
-
 struct symlink_type
 {
     unsigned int length;         /*  Not including the NULL-termimator       */
@@ -801,8 +788,7 @@ struct devfs_entry
     union 
     {
 	struct directory_type dir;
-	struct bdev_type bdev;
-	struct cdev_type cdev;
+	dev_t dev;
 	struct symlink_type symlink;
 	const char *name;        /*  Only used for (mode == 0)               */
     }
@@ -813,7 +799,7 @@ struct devfs_entry
     struct devfs_inode inode;
     umode_t mode;
     unsigned short namelen;      /*  I think 64k+ filenames are a way off... */
-    unsigned char vfs_deletable:1;/*  Whether the VFS may delete the entry   */
+    unsigned char vfs:1;/*  Whether the VFS may delete the entry   */
     char name[1];                /*  This is just a dummy: the allocated array
 				     is bigger. This is NULL-terminated      */
 };
@@ -925,8 +911,6 @@ static void devfs_put (devfs_handle_t de
 	     de->name, de, de->parent,
 	     de->parent ? de->parent->name : "no parent");
     if ( S_ISLNK (de->mode) ) kfree (de->u.symlink.linkname);
-    if ( S_ISCHR (de->mode) && de->u.cdev.autogen )
-	devfs_dealloc_devnum (de->mode, de->u.cdev.dev);
     WRITE_ENTRY_MAGIC (de, 0);
 #ifdef CONFIG_DEVFS_DEBUG
     spin_lock (&stat_lock);
@@ -1063,46 +1047,40 @@ static int _devfs_append_entry (devfs_ha
     return retval;
 }   /*  End Function _devfs_append_entry  */
 
-
 /**
  *	_devfs_get_root_entry - Get the root devfs entry.
  *
  *	Returns the root devfs entry on success, else %NULL.
+ *
+ *	TODO it must be called asynchronously due to the fact
+ *	that devfs is initialized relatively late. Proper way
+ *	is to remove module_init from init_devfs_fs and manually
+ *	call it early enough during system init
  */
 
-static struct devfs_entry *_devfs_get_root_entry (void)
+static struct devfs_entry *_devfs_get_root_entry(void)
 {
-    struct devfs_entry *new;
-    static spinlock_t root_lock = SPIN_LOCK_UNLOCKED;
+	struct devfs_entry *new;
+	static spinlock_t root_lock = SPIN_LOCK_UNLOCKED;
 
-    /*  Always ensure the root is created  */
-    if (root_entry) return root_entry;
-    if ( ( new = _devfs_alloc_entry (NULL, 0,MODE_DIR) ) == NULL ) return NULL;
-    spin_lock (&root_lock);
-    if (root_entry)
-    {
-	spin_unlock (&root_lock);
-	devfs_put (new);
-	return (root_entry);
-    }
-    root_entry = new;
-    spin_unlock (&root_lock);
-    /*  And create the entry for ".devfsd"  */
-    if ( ( new = _devfs_alloc_entry (".devfsd", 0, S_IFCHR |S_IRUSR |S_IWUSR) )
-	 == NULL ) return NULL;
-    new->u.cdev.dev = devfs_alloc_devnum (S_IFCHR |S_IRUSR |S_IWUSR);
-    new->u.cdev.ops = &devfsd_fops;
-    _devfs_append_entry (root_entry, new, NULL);
-#ifdef CONFIG_DEVFS_DEBUG
-    if ( ( new = _devfs_alloc_entry (".stat", 0, S_IFCHR | S_IRUGO | S_IWUGO) )
-	 == NULL ) return NULL;
-    new->u.cdev.dev = devfs_alloc_devnum (S_IFCHR | S_IRUGO | S_IWUGO);
-    new->u.cdev.ops = &stat_fops;
-    _devfs_append_entry (root_entry, new, NULL);
-#endif
-    return root_entry;
-}   /*  End Function _devfs_get_root_entry  */
+	if (root_entry)
+		return root_entry;
+
+	new = _devfs_alloc_entry(NULL, 0, MODE_DIR);
+	if (new == NULL )
+		return NULL;
+
+	spin_lock(&root_lock);
+	if (root_entry) {
+		spin_unlock(&root_lock);
+		devfs_put(new);
+		return root_entry;
+	}
+	root_entry = new;
+	spin_unlock(&root_lock);
 
+	return root_entry;
+}   /*  End Function _devfs_get_root_entry  */
 
 /**
  *	_devfs_descend - Descend down a tree using the next component name.
@@ -1237,6 +1215,7 @@ static devfs_handle_t _devfs_walk_path (
 	}
 	if (S_ISLNK (de->mode) && traverse_symlink)
 	{   /*  Need to follow the link: this is a stack chomper  */
+		/* FIXME what if it puts outside of mounted tree? */
 	    link = _devfs_walk_path (dir, de->u.symlink.linkname,
 				     de->u.symlink.length, TRUE);
 	    devfs_put (de);
@@ -1444,27 +1423,19 @@ static void devfsd_notify (struct devfs_
 			 current->egid, &fs_info);
 } 
 
-int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
+static int devfs_mk_dev(dev_t dev, umode_t mode, const char *fmt, va_list args)
 {
 	struct devfs_entry *dir = NULL, *de;
 	char buf[64];
-	va_list args;
 	int error, n;
 
-	va_start(args, fmt);
-	n = vsnprintf(buf, 64, fmt, args);
-	if (n >= 64 || !buf[0]) {
-		printk(KERN_WARNING "%s: invalid format string\n",
-				__FUNCTION__);
+	n = vsnprintf(buf, sizeof(buf), fmt, args);
+	if (n >= sizeof(buf) || !buf[0]) {
+		printk(KERN_WARNING "%s: invalid format string %s\n",
+				__FUNCTION__, fmt);
 		return -EINVAL;
 	}
 	
-	if (!S_ISBLK(mode)) {
-		printk(KERN_WARNING "%s: invalide mode (%u) for %s\n",
-				__FUNCTION__, mode, buf);
-		return -EINVAL;
-	}
-
 	de = _devfs_prepare_leaf(&dir, buf, mode);
 	if (!de) {
 		printk(KERN_WARNING "%s: could not prepare leaf for %s\n",
@@ -1472,7 +1443,7 @@ int devfs_mk_bdev(dev_t dev, umode_t mod
 		return -ENOMEM;		/* could be more accurate... */
 	}
 
-	de->u.bdev.dev = dev;
+	de->u.dev = dev;
 
 	error = _devfs_append_entry(dir, de, NULL);
 	if (error) {
@@ -1487,50 +1458,35 @@ int devfs_mk_bdev(dev_t dev, umode_t mod
 	return error;
 }
 
+int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!S_ISBLK(mode)) {
+		printk(KERN_WARNING "%s: invalide mode (%u) for %s\n",
+				__FUNCTION__, mode, fmt);
+		return -EINVAL;
+	}
+
+	va_start(args, fmt);
+	return devfs_mk_dev(dev, mode, fmt, args);
+}
+
 EXPORT_SYMBOL(devfs_mk_bdev);
 
 
 int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
 {
-	struct devfs_entry *dir = NULL, *de;
-	char buf[64];
 	va_list args;
-	int error, n;
-
-	va_start(args, fmt);
-	n = vsnprintf(buf, 64, fmt, args);
-	if (n >= 64 || !buf[0]) {
-		printk(KERN_WARNING "%s: invalid format string\n",
-				__FUNCTION__);
-		return -EINVAL;
-	}
 
 	if (!S_ISCHR(mode)) {
 		printk(KERN_WARNING "%s: invalide mode (%u) for %s\n",
-				__FUNCTION__, mode, buf);
+				__FUNCTION__, mode, fmt);
 		return -EINVAL;
 	}
 
-	de = _devfs_prepare_leaf(&dir, buf, mode);
-	if (!de) {
-		printk(KERN_WARNING "%s: could not prepare leaf for %s\n",
-				__FUNCTION__, buf);
-		return -ENOMEM;		/* could be more accurate... */
-	}
-
-	de->u.cdev.dev = dev;
-
-	error = _devfs_append_entry(dir, de, NULL);
-	if (error) {
-		printk(KERN_WARNING "%s: could not append to parent for %s\n",
-				__FUNCTION__, buf);
-		goto out;
-	}
-
-	devfsd_notify(de, DEVFSD_NOTIFY_REGISTERED);
- out:
-	devfs_put(dir);
-	return error;
+	va_start(args, fmt);
+	return devfs_mk_dev(dev, mode, fmt, args);
 }
 
 EXPORT_SYMBOL(devfs_mk_cdev);
@@ -1663,7 +1619,7 @@ int devfs_mk_symlink(const char *from, c
 
 	err = devfs_do_symlink(NULL, from, to, &de);
 	if (!err) {
-		de->vfs_deletable = TRUE;
+		de->vfs = TRUE;
 		devfsd_notify(de, DEVFSD_NOTIFY_REGISTERED);
 	}
 
@@ -1732,8 +1688,8 @@ void devfs_remove(const char *fmt, ...)
 	int n;
 
 	va_start(args, fmt);
-	n = vsnprintf(buf, 64, fmt, args);
-	if (n < 64 && buf[0]) {
+	n = vsnprintf(buf, sizeof(buf), fmt, args);
+	if (n < sizeof(buf) && buf[0]) {
 		devfs_handle_t de = _devfs_find_entry(NULL, buf, 0);
 
 		if (!de) {
@@ -1784,33 +1740,6 @@ static int devfs_generate_path (devfs_ha
     return pos;
 }   /*  End Function devfs_generate_path  */
 
-
-/**
- *	devfs_get_ops - Get the device operations for a devfs entry.
- *	@de: The handle to the device entry.
- *
- *	Returns a pointer to the device operations on success, else NULL.
- *	The use count for the module owning the operations will be incremented.
- */
-
-static struct file_operations *devfs_get_ops (devfs_handle_t de)
-{
-    struct file_operations *ops = de->u.cdev.ops;
-    struct module *owner;
-
-    if (!ops)
-	return NULL;
-    owner = ops->owner;
-    read_lock (&de->parent->u.dir.lock);  /*  Prevent module from unloading  */
-    if ( (de->next == de) || !try_module_get (owner) )
-    {   /*  Entry is already unhooked or module is unloading  */
-	read_unlock (&de->parent->u.dir.lock);
-	return NULL;
-    }
-    read_unlock (&de->parent->u.dir.lock);  /*  Module can continue unloading*/
-    return ops;
-}   /*  End Function devfs_get_ops  */
-
 /**
  *	devfs_setup - Process kernel boot options.
  *	@str: The boot options after the "devfs=".
@@ -1876,7 +1805,6 @@ static int __init devfs_setup (char *str
 
 __setup("devfs=", devfs_setup);
 
-EXPORT_SYMBOL(devfs_put);
 EXPORT_SYMBOL(devfs_mk_symlink);
 EXPORT_SYMBOL(devfs_mk_dir);
 EXPORT_SYMBOL(devfs_remove);
@@ -1996,6 +1924,7 @@ static struct inode *_devfs_get_vfs_inod
 	iput (inode);
 	return NULL;
     }
+    /* FIXME where is devfs_put? */
     inode->u.generic_ip = devfs_get (de);
     inode->i_ino = de->inode.ino;
     DPRINTK (DEBUG_I_GET, "(%d): VFS inode: %p  devfs_entry: %p\n",
@@ -2003,26 +1932,25 @@ static struct inode *_devfs_get_vfs_inod
     inode->i_blocks = 0;
     inode->i_blksize = FAKE_BLOCK_SIZE;
     inode->i_op = &devfs_iops;
-    inode->i_fop = &devfs_fops;
-    if ( S_ISCHR (de->mode) )
-    {
-	inode->i_rdev = de->u.cdev.dev;
-    }
-    else if ( S_ISBLK (de->mode) )
-	init_special_inode(inode, de->mode, de->u.bdev.dev);
-    else if ( S_ISFIFO (de->mode) )
-    	inode->i_fop = &def_fifo_fops;
-    else if ( S_ISDIR (de->mode) )
-    {
-	inode->i_op = &devfs_dir_iops;
-    	inode->i_fop = &devfs_dir_fops;
-    }
-    else if ( S_ISLNK (de->mode) )
-    {
-	inode->i_op = &devfs_symlink_iops;
-	inode->i_size = de->u.symlink.length;
-    }
     inode->i_mode = de->mode;
+	if (S_ISDIR(de->mode)) {
+		inode->i_op = &devfs_dir_iops;
+		inode->i_fop = &devfs_dir_fops;
+	} else if (S_ISLNK(de->mode)) {
+		inode->i_op = &devfs_symlink_iops;
+		inode->i_size = de->u.symlink.length;
+	} else if (S_ISCHR(de->mode) || S_ISBLK(de->mode)) {
+		init_special_inode(inode, de->mode, de->u.dev);
+	} else if (S_ISFIFO(de->mode) || S_ISSOCK(de->mode)) {
+		init_special_inode(inode, de->mode, 0);
+	} else {
+		PRINTK("(%s): unknown mode %o de: %p\n",
+			de->name, de->mode, de);
+		iput(inode);
+		devfs_put(de);
+		return NULL;
+	}
+
     inode->i_uid = de->inode.uid;
     inode->i_gid = de->inode.gid;
     inode->i_atime = de->inode.atime;
@@ -2098,29 +2026,37 @@ static int devfs_readdir (struct file *f
     return stored;
 }   /*  End Function devfs_readdir  */
 
+/* Open devfs specific special files */
 static int devfs_open (struct inode *inode, struct file *file)
 {
-    int err = -ENODEV;
-    struct devfs_entry *de;
-    struct file_operations *ops;
+	int err;
+	int minor = MINOR(inode->i_rdev);
+	struct file_operations *old_fops, *new_fops;
 
-    de = get_devfs_entry_from_vfs_inode (inode);
-    if (de == NULL) return -ENODEV;
-    if ( S_ISDIR (de->mode) ) return 0;
-    file->private_data = de->info;
-    if (S_ISCHR(inode->i_mode)) {
-	ops = devfs_get_ops (de);  /*  Now have module refcount  */
-	file->f_op = ops;
-	if (file->f_op)
-	{
-	    lock_kernel ();
-	    err = file->f_op->open ? (*file->f_op->open) (inode, file) : 0;
-	    unlock_kernel ();
+	switch (minor) {
+	case 0: /* /dev/.devfsd */
+		new_fops = fops_get(&devfsd_fops);
+		break;
+#ifdef CONFIG_DEVFS_DEBUG
+	case 1: /* /dev/.stat */
+		new_fops = fops_get(&stat_fops);
+		break;
+#endif
+	default:
+		return -ENODEV;
 	}
-	else
-	    err = chrdev_open (inode, file);
-    }
-    return err;
+
+	if (new_fops == NULL)
+		return -ENODEV;
+	old_fops = file->f_op;
+	file->f_op = new_fops;
+	err = new_fops->open ? new_fops->open(inode, file) : 0;
+	if (err) {
+		file->f_op = old_fops;
+		fops_put(new_fops);
+	} else
+		fops_put(old_fops);
+	return err;
 }   /*  End Function devfs_open  */
 
 static struct file_operations devfs_fops =
@@ -2132,7 +2068,6 @@ static struct file_operations devfs_dir_
 {
     .read    = generic_read_dir,
     .readdir = devfs_readdir,
-    .open    = devfs_open,
 };
 
 
@@ -2223,6 +2158,34 @@ static int devfs_d_revalidate_wait (stru
     devfs_handle_t parent = get_devfs_entry_from_vfs_inode (dir);
     struct devfs_lookup_struct *lookup_info = dentry->d_fsdata;
     DECLARE_WAITQUEUE (wait, current);
+    int need_lock;
+
+    /*
+     * FIXME HACK
+     *
+     * make sure that
+     *   d_instantiate always runs under lock
+     *   we release i_sem lock before going to sleep
+     *
+     * unfortunately sometimes d_revalidate is called with
+     * and sometimes without i_sem lock held. The following checks
+     * attempt to deduce when we need to add (and drop resp.) lock
+     * here. This relies on current (2.6.2) calling coventions:
+     *
+     *   lookup_hash is always run under i_sem and is passing NULL
+     *   as nd
+     *
+     *   open(...,O_CREATE,...) calls _lookup_hash under i_sem
+     *   and sets flags to LOOKUP_OPEN|LOOKUP_CREATE
+     *
+     *   all other invocations of ->d_revalidate seem to happen
+     *   outside of i_sem
+     */
+    need_lock = nd &&
+		(!(nd->flags & LOOKUP_CREATE) || (nd->flags & LOOKUP_PARENT));
+
+    if (need_lock)
+	down(&dir->i_sem);
 
     if ( is_devfsd_or_child (fs_info) )
     {
@@ -2233,33 +2196,40 @@ static int devfs_d_revalidate_wait (stru
 		 "(%s): dentry: %p inode: %p de: %p by: \"%s\"\n",
 		 dentry->d_name.name, dentry, dentry->d_inode, de,
 		 current->comm);
-	if (dentry->d_inode) return 1;
+	if (dentry->d_inode)
+	    goto out;
 	if (de == NULL)
 	{
 	    read_lock (&parent->u.dir.lock);
 	    de = _devfs_search_dir (parent, dentry->d_name.name,
 				    dentry->d_name.len);
 	    read_unlock (&parent->u.dir.lock);
-	    if (de == NULL) return 1;
+	    if (de == NULL)
+		goto out;
 	    lookup_info->de = de;
 	}
 	/*  Create an inode, now that the driver information is available  */
 	inode = _devfs_get_vfs_inode (dir->i_sb, de, dentry);
-	if (!inode) return 1;
+	if (!inode)
+	    goto out;
 	DPRINTK (DEBUG_I_LOOKUP,
 		 "(%s): new VFS inode(%u): %p de: %p by: \"%s\"\n",
 		 de->name, de->inode.ino, inode, de, current->comm);
 	d_instantiate (dentry, inode);
-	return 1;
+	goto out;
     }
-    if (lookup_info == NULL) return 1;  /*  Early termination  */
+    if (lookup_info == NULL)
+	goto out;  /*  Early termination  */
     read_lock (&parent->u.dir.lock);
     if (dentry->d_fsdata)
     {
 	set_current_state (TASK_UNINTERRUPTIBLE);
 	add_wait_queue (&lookup_info->wait_queue, &wait);
 	read_unlock (&parent->u.dir.lock);
+	/* at this point it is always (hopefully) locked */
+	up(&dir->i_sem);
 	schedule ();
+	down(&dir->i_sem);
 	/*
 	 * This does not need nor should remove wait from wait_queue.
 	 * Wait queue head is never reused - nothing is ever added to it
@@ -2271,6 +2241,10 @@ static int devfs_d_revalidate_wait (stru
 
     }
     else read_unlock (&parent->u.dir.lock);
+
+out:
+    if (need_lock)
+	up(&dir->i_sem);
     return 1;
 }   /*  End Function devfs_d_revalidate_wait  */
 
@@ -2320,6 +2294,7 @@ static struct dentry *devfs_lookup (stru
 	revalidation  */
     up (&dir->i_sem);
     wait_for_devfsd_finished (fs_info);  /*  If I'm not devfsd, must wait  */
+    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     de = lookup_info.de;
     /*  If someone else has been so kind as to make the inode, we go home
 	early  */
@@ -2349,7 +2324,6 @@ out:
     dentry->d_fsdata = NULL;
     wake_up (&lookup_info.wait_queue);
     write_unlock (&parent->u.dir.lock);
-    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     devfs_put (de);
     return retval;
 }   /*  End Function devfs_lookup  */
@@ -2364,7 +2338,7 @@ static int devfs_unlink (struct inode *d
     de = get_devfs_entry_from_vfs_inode (inode);
     DPRINTK (DEBUG_I_UNLINK, "(%s): de: %p\n", dentry->d_name.name, de);
     if (de == NULL) return -ENOENT;
-    if (!de->vfs_deletable) return -EPERM;
+    if (!de->vfs) return -EPERM;
     write_lock (&de->parent->u.dir.lock);
     unhooked = _devfs_unhook (de);
     write_unlock (&de->parent->u.dir.lock);
@@ -2392,7 +2366,7 @@ static int devfs_symlink (struct inode *
     DPRINTK (DEBUG_DISABLED, "(%s): errcode from <devfs_do_symlink>: %d\n",
 	     dentry->d_name.name, err);
     if (err < 0) return err;
-    de->vfs_deletable = TRUE;
+    de->vfs = TRUE;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
     de->inode.atime = CURRENT_TIME;
@@ -2421,7 +2395,7 @@ static int devfs_mkdir (struct inode *di
     if (parent == NULL) return -ENOENT;
     de = _devfs_alloc_entry (dentry->d_name.name, dentry->d_name.len, mode);
     if (!de) return -ENOMEM;
-    de->vfs_deletable = TRUE;
+    de->vfs = TRUE;
     if ( ( err = _devfs_append_entry (parent, de, NULL) ) != 0 )
 	return err;
     de->inode.uid = current->euid;
@@ -2451,7 +2425,7 @@ static int devfs_rmdir (struct inode *di
     de = get_devfs_entry_from_vfs_inode (inode);
     if (de == NULL) return -ENOENT;
     if ( !S_ISDIR (de->mode) ) return -ENOTDIR;
-    if (!de->vfs_deletable) return -EPERM;
+    if (!de->vfs) return -EPERM;
     /*  First ensure the directory is empty and will stay that way  */
     write_lock (&de->u.dir.lock);
     if (de->u.dir.first) err = -ENOTEMPTY;
@@ -2485,11 +2459,9 @@ static int devfs_mknod (struct inode *di
     if (parent == NULL) return -ENOENT;
     de = _devfs_alloc_entry (dentry->d_name.name, dentry->d_name.len, mode);
     if (!de) return -ENOMEM;
-    de->vfs_deletable = TRUE;
-    if (S_ISCHR (mode))
-	de->u.cdev.dev = rdev;
-    else if (S_ISBLK (mode))
-	de->u.bdev.dev = rdev;
+    de->vfs = TRUE;
+    if (S_ISCHR(mode) || S_ISBLK(mode))
+	de->u.dev = rdev;
     if ( ( err = _devfs_append_entry (parent, de, NULL) ) != 0 )
 	return err;
     de->inode.uid = current->euid;
@@ -2642,12 +2614,9 @@ static ssize_t devfsd_read (struct file 
     info->uid = entry->uid;
     info->gid = entry->gid;
     de = entry->de;
-    if (S_ISCHR(de->mode)) {
-	info->major = MAJOR(de->u.cdev.dev);
-	info->minor = MINOR(de->u.cdev.dev);
-    } else if (S_ISBLK (de->mode)) {
-	info->major = MAJOR(de->u.bdev.dev);
-	info->minor = MINOR(de->u.bdev.dev);
+    if (S_ISCHR(de->mode) || S_ISBLK(de->mode)) {
+	info->major = MAJOR(de->u.dev);
+	info->minor = MINOR(de->u.dev);
     }
     pos = devfs_generate_path (de, info->devname, DEVFS_PATHLEN);
     if (pos < 0) return pos;
@@ -2809,30 +2778,53 @@ static ssize_t stat_read (struct file *f
 }   /*  End Function stat_read  */
 #endif
 
-
-static int __init init_devfs_fs (void)
+static int __init init_devfs_fs(void)
 {
-    int err;
+	int err;
+	int major;
+	struct devfs_entry *devfsd;
+#ifdef CONFIG_DEVFS_DEBUG
+	struct devfs_entry *stat;
+#endif
+
+	if (_devfs_get_root_entry() == NULL)
+		return -ENOMEM;
 
-    printk (KERN_INFO "%s: v%s Richard Gooch (rgooch@atnf.csiro.au)\n",
-	    DEVFS_NAME, DEVFS_VERSION);
-    devfsd_buf_cache = kmem_cache_create ("devfsd_event",
+	printk(KERN_INFO "%s: %s Richard Gooch (rgooch@atnf.csiro.au)\n",
+	       DEVFS_NAME, DEVFS_VERSION);
+	devfsd_buf_cache = kmem_cache_create("devfsd_event",
 					  sizeof (struct devfsd_buf_entry),
 					  0, 0, NULL, NULL);
-    if (!devfsd_buf_cache) OOPS ("(): unable to allocate event slab\n");
+	if (!devfsd_buf_cache)
+		OOPS("(): unable to allocate event slab\n");
 #ifdef CONFIG_DEVFS_DEBUG
-    devfs_debug = devfs_debug_init;
-    printk (KERN_INFO "%s: devfs_debug: 0x%0x\n", DEVFS_NAME, devfs_debug);
+	devfs_debug = devfs_debug_init;
+	printk(KERN_INFO "%s: devfs_debug: 0x%0x\n", DEVFS_NAME, devfs_debug);
 #endif
-    printk (KERN_INFO "%s: boot_options: 0x%0x\n", DEVFS_NAME, boot_options);
-    err = register_filesystem (&devfs_fs_type);
-    if (!err)
-    {
-	struct vfsmount *devfs_mnt = kern_mount (&devfs_fs_type);
-	err = PTR_ERR (devfs_mnt);
-	if ( !IS_ERR (devfs_mnt) ) err = 0;
-    }
-    return err;
+	printk(KERN_INFO "%s: boot_options: 0x%0x\n", DEVFS_NAME, boot_options);
+
+	/* register special device for devfsd communication */
+	major = register_chrdev(0, "devfs", &devfs_fops);
+	if (major < 0)
+		return major;
+	
+	/*  And create the entry for ".devfsd"  */
+	devfsd = _devfs_alloc_entry(".devfsd", 0, S_IFCHR|S_IRUSR|S_IWUSR);
+	if (devfsd == NULL )
+		return -ENOMEM;
+	devfsd->u.dev = MKDEV(major, 0);
+	_devfs_append_entry(root_entry, devfsd, NULL);
+
+#ifdef CONFIG_DEVFS_DEBUG
+	stat = _devfs_alloc_entry(".stat", 0, S_IFCHR|S_IRUGO);
+	if (stat == NULL )
+		return -ENOMEM;
+	stat->u.dev = MKDEV(major, 1);
+	_devfs_append_entry (root_entry, stat, NULL);
+#endif
+
+	err = register_filesystem(&devfs_fs_type);
+	return err;
 }   /*  End Function init_devfs_fs  */
 
 void __init mount_devfs_fs (void)
diff -Nrup ../tmp/linux-2.6.2-rc3/fs/devfs/internal.h linux-2.6.2-rc2/fs/devfs/internal.h
--- ../tmp/linux-2.6.2-rc3/fs/devfs/internal.h	2003-12-18 05:59:25.000000000 +0300
+++ linux-2.6.2-rc2/fs/devfs/internal.h	1970-01-01 03:00:00.000000000 +0300
@@ -1,3 +0,0 @@
-
-extern dev_t devfs_alloc_devnum(umode_t mode);
-extern void devfs_dealloc_devnum(umode_t mode, dev_t devnum);
diff -Nrup ../tmp/linux-2.6.2-rc3/fs/devfs/util.c linux-2.6.2-rc2/fs/devfs/util.c
--- ../tmp/linux-2.6.2-rc3/fs/devfs/util.c	2003-12-18 05:58:56.000000000 +0300
+++ linux-2.6.2-rc2/fs/devfs/util.c	2004-02-01 16:59:55.105294632 +0300
@@ -72,7 +72,6 @@
 #include <linux/vmalloc.h>
 #include <linux/genhd.h>
 #include <asm/bitops.h>
-#include "internal.h"
 
 
 int devfs_register_tape(const char *name)
@@ -96,161 +95,3 @@ void devfs_unregister_tape(int num)
 }
 
 EXPORT_SYMBOL(devfs_unregister_tape);
-
-struct major_list
-{
-    spinlock_t lock;
-    unsigned long bits[256 / BITS_PER_LONG];
-};
-#if BITS_PER_LONG == 32
-#  define INITIALISER64(low,high) (low), (high)
-#else
-#  define INITIALISER64(low,high) ( (unsigned long) (high) << 32 | (low) )
-#endif
-
-/*  Block majors already assigned:
-    0-3, 7-9, 11-63, 65-99, 101-113, 120-127, 199, 201, 240-255
-    Total free: 122
-*/
-static struct major_list block_major_list =
-{SPIN_LOCK_UNLOCKED,
-    {INITIALISER64 (0xfffffb8f, 0xffffffff),  /*  Majors 0-31,    32-63    */
-     INITIALISER64 (0xfffffffe, 0xff03ffef),  /*  Majors 64-95,   96-127   */
-     INITIALISER64 (0x00000000, 0x00000000),  /*  Majors 128-159, 160-191  */
-     INITIALISER64 (0x00000280, 0xffff0000),  /*  Majors 192-223, 224-255  */
-    }
-};
-
-/*  Char majors already assigned:
-    0-7, 9-151, 154-158, 160-211, 216-221, 224-230, 240-255
-    Total free: 19
-*/
-static struct major_list char_major_list =
-{SPIN_LOCK_UNLOCKED,
-    {INITIALISER64 (0xfffffeff, 0xffffffff),  /*  Majors 0-31,    32-63    */
-     INITIALISER64 (0xffffffff, 0xffffffff),  /*  Majors 64-95,   96-127   */
-     INITIALISER64 (0x7cffffff, 0xffffffff),  /*  Majors 128-159, 160-191  */
-     INITIALISER64 (0x3f0fffff, 0xffff007f),  /*  Majors 192-223, 224-255  */
-    }
-};
-
-
-/**
- *	devfs_alloc_major - Allocate a major number.
- *	@mode: The file mode (must be block device or character device).
- *	Returns the allocated major, else -1 if none are available.
- *	This routine is thread safe and does not block.
- */
-
-
-struct minor_list
-{
-    int major;
-    unsigned long bits[256 / BITS_PER_LONG];
-    struct minor_list *next;
-};
-
-static struct device_list {
-	struct minor_list	*first;
-	struct minor_list	*last;
-	int			none_free;
-} block_list, char_list;
-
-static DECLARE_MUTEX(device_list_mutex);
-
-
-/**
- *	devfs_alloc_devnum - Allocate a device number.
- *	@mode: The file mode (must be block device or character device).
- *
- *	Returns the allocated device number, else NODEV if none are available.
- *	This routine is thread safe and may block.
- */
-
-dev_t devfs_alloc_devnum(umode_t mode)
-{
-	struct device_list *list;
-	struct major_list *major_list;
-	struct minor_list *entry;
-	int minor;
-
-	if (S_ISCHR(mode)) {
-		major_list = &char_major_list;
-		list = &char_list;
-	} else {
-		major_list = &block_major_list;
-		list = &block_list;
-	}
-
-	down(&device_list_mutex);
-	if (list->none_free)
-		goto out_unlock;
-
-	for (entry = list->first; entry; entry = entry->next) {
-		minor = find_first_zero_bit (entry->bits, 256);
-		if (minor >= 256)
-			continue;
-		goto out_done;
-	}
-	
-	/*  Need to allocate a new major  */
-	entry = kmalloc (sizeof *entry, GFP_KERNEL);
-	if (!entry)
-		goto out_full;
-	memset(entry, 0, sizeof *entry);
-
-	spin_lock(&major_list->lock);
-	entry->major = find_first_zero_bit(major_list->bits, 256);
-	if (entry->major >= 256) {
-		spin_unlock(&major_list->lock);
-		kfree(entry);
-		goto out_full;
-	}
-	__set_bit(entry->major, major_list->bits);
-	spin_unlock(&major_list->lock);
-
-	if (!list->first)
-		list->first = entry;
-	else
-		list->last->next = entry;
-	list->last = entry;
-
-	minor = 0;
- out_done:
-	__set_bit(minor, entry->bits);
-	up(&device_list_mutex);
-	return MKDEV(entry->major, minor);
- out_full:
-	list->none_free = 1;
- out_unlock:
-	up(&device_list_mutex);
-	return 0;
-}
-
-
-/**
- *	devfs_dealloc_devnum - Dellocate a device number.
- *	@mode: The file mode (must be block device or character device).
- *	@devnum: The device number.
- *
- *	This routine is thread safe and may block.
- */
-
-void devfs_dealloc_devnum(umode_t mode, dev_t devnum)
-{
-	struct device_list *list = S_ISCHR(mode) ? &char_list : &block_list;
-	struct minor_list *entry;
-
-	if (!devnum)
-		return;
-
-	down(&device_list_mutex);
-	for (entry = list->first; entry; entry = entry->next) {
-		if (entry->major == MAJOR(devnum)) {
-			if (__test_and_clear_bit(MINOR(devnum), entry->bits))
-				list->none_free = 0;
-			break;
-		}
-	}
-	up(&device_list_mutex);
-}

--+HP7ph2BbKc20aGI--
