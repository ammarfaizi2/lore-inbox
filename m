Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261904AbSIYDRp>; Tue, 24 Sep 2002 23:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261885AbSIYDRl>; Tue, 24 Sep 2002 23:17:41 -0400
Received: from dp.samba.org ([66.70.73.150]:41344 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261884AbSIYDQq>;
	Tue, 24 Sep 2002 23:16:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: [PATCH] Module rewrite 20/20: try_inc_mod_count() -> try_module_get()
Date: Wed, 25 Sep 2002 13:19:58 +1000
Message-Id: <20020925032201.78E702C095@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: try_inc_mod_count Renaming
Author: Rusty Russell
Status: Trivial
Depends: Module/module-bound-removal.patch.gz

D: This s/try_inc_mod_count/try_get_module/ everywhere, since this is
D: a better name for what is now the primary module ref operation.  It
D: also cleans up those callers to use "module_put(owner)" instead of the
D: more clumsy "if (owner) __MOD_DEC_USE_COUNT(owner)".

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/Documentation/filesystems/driverfs.txt .10026-2.5.38-try_inc_mod_count-removal/Documentation/filesystems/driverfs.txt
--- .10026-2.5.38-try_inc_mod_count-removal.pre/Documentation/filesystems/driverfs.txt	2002-08-28 09:29:39.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/Documentation/filesystems/driverfs.txt	2002-09-25 10:23:59.000000000 +1000
@@ -320,7 +320,7 @@ open() callback, the reference count for
 incremented. 
 
 For drivers, we can put a struct module * owner in struct driver_dir_entry 
-and do try_inc_mod_count() when we open a file. However, this won't
+and do try_module_get() when we open a file. However, this won't
 work for devices, that aren't tied to a module. And, it is still not
 guaranteed to solve the race. 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/char/busmouse.c .10026-2.5.38-try_inc_mod_count-removal/drivers/char/busmouse.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/char/busmouse.c	2002-05-24 15:20:17.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/drivers/char/busmouse.c	2002-09-25 10:23:58.000000000 +1000
@@ -175,8 +175,7 @@ static int busmouse_release(struct inode
 	if (--mse->active == 0) {
 		if (mse->ops->release)
 			ret = mse->ops->release(inode, file);
-	   	if (mse->ops->owner)
-			__MOD_DEC_USE_COUNT(mse->ops->owner);
+		module_put(mse->ops->owner);
 		mse->ready = 0;
 	}
 	unlock_kernel();
@@ -201,14 +200,14 @@ static int busmouse_open(struct inode *i
 	if (!mse || !mse->ops)	/* shouldn't happen, but... */
 		goto end;
 
-	if (mse->ops->owner && !try_inc_mod_count(mse->ops->owner))
+	if (!try_module_get(mse->ops->owner))
 		goto end;
 
 	ret = 0;
 	if (mse->ops->open) {
 		ret = mse->ops->open(inode, file);
-		if (ret && mse->ops->owner)
-			__MOD_DEC_USE_COUNT(mse->ops->owner);
+		if (ret)
+			module_put(mse->ops->owner);
 	}
 
 	if (ret)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/ide/ide.c .10026-2.5.38-try_inc_mod_count-removal/drivers/ide/ide.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/ide/ide.c	2002-09-25 10:23:50.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/drivers/ide/ide.c	2002-09-25 10:23:58.000000000 +1000
@@ -2446,17 +2446,15 @@ int ata_attach(ide_drive_t *drive)
 	spin_lock(&drivers_lock);
 	list_for_each(p, &drivers) {
 		ide_driver_t *driver = list_entry(p, ide_driver_t, drivers);
-		if (!try_inc_mod_count(driver->owner))
+		if (!try_module_get(driver->owner))
 			continue;
 		spin_unlock(&drivers_lock);
 		if (driver->attach(drive) == 0) {
-			if (driver->owner)
-				__MOD_DEC_USE_COUNT(driver->owner);
+			module_put(driver->owner);
 			return 0;
 		}
 		spin_lock(&drivers_lock);
-		if (driver->owner)
-			__MOD_DEC_USE_COUNT(driver->owner);
+		module_put(driver->owner);
 	}
 	spin_unlock(&drivers_lock);
 	spin_lock(&drives_lock);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/ieee1394/ieee1394_core.c .10026-2.5.38-try_inc_mod_count-removal/drivers/ieee1394/ieee1394_core.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/ieee1394/ieee1394_core.c	2002-09-18 16:04:38.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/drivers/ieee1394/ieee1394_core.c	2002-09-25 10:23:58.000000000 +1000
@@ -889,8 +889,7 @@ static int ieee1394_get_chardev(int bloc
 	if(*file_ops == NULL)
 		goto out;
 
-	/* don't need try_inc_mod_count if the driver is non-modular */
-	if(*module && (try_inc_mod_count(*module) == 0))
+	if(!try_module_get(*module))
 		goto out;
 
 	/* success! */
@@ -972,8 +971,7 @@ static int ieee1394_dispatch_open(struct
 		   extra reference we gave to the task-specific
 		   driver */
 		
-		if(module)
-			__MOD_DEC_USE_COUNT(module);
+		module_put(module);
 	
 		/* point the file's f_ops back to ieee1394. The VFS will then
 		   decrement ieee1394's reference count immediately after this
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/isdn/capi/kcapi.c .10026-2.5.38-try_inc_mod_count-removal/drivers/isdn/capi/kcapi.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/isdn/capi/kcapi.c	2002-05-29 16:36:36.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/drivers/isdn/capi/kcapi.c	2002-09-25 10:23:58.000000000 +1000
@@ -78,7 +78,7 @@ static inline struct capi_ctr *
 capi_ctr_get(struct capi_ctr *card)
 {
 	if (card->owner) {
-		if (try_inc_mod_count(card->owner)) {
+		if (try_module_get(card->owner)) {
 			DBG("MOD_COUNT INC");
 			return card;
 		} else
@@ -91,8 +91,7 @@ capi_ctr_get(struct capi_ctr *card)
 static inline void
 capi_ctr_put(struct capi_ctr *card)
 {
-	if (card->owner)
-		__MOD_DEC_USE_COUNT(card->owner);
+	module_put(card->owner);
 	DBG("MOD_COUNT DEC");
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/mtd/chips/chipreg.c .10026-2.5.38-try_inc_mod_count-removal/drivers/mtd/chips/chipreg.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/mtd/chips/chipreg.c	2002-02-05 18:49:33.000000000 +1100
+++ .10026-2.5.38-try_inc_mod_count-removal/drivers/mtd/chips/chipreg.c	2002-09-25 10:23:58.000000000 +1000
@@ -44,7 +44,7 @@ static struct mtd_chip_driver *get_mtd_c
 			break;
 		}
 	}
-	if (ret && !try_inc_mod_count(ret->module)) {
+	if (ret && !try_module_get(ret->module)) {
 		/* Eep. Failed. */
 		ret = NULL;
 	}
@@ -71,15 +71,13 @@ struct mtd_info *do_map_probe(char *name
 		return NULL;
 
 	ret = drv->probe(map);
-#ifdef CONFIG_MODULES
+
 	/* We decrease the use count here. It may have been a 
 	   probe-only module, which is no longer required from this
 	   point, having given us a handle on (and increased the use
 	   count of) the actual driver code.
 	*/
-	if(drv->module)
-		__MOD_DEC_USE_COUNT(drv->module);
-#endif
+	module_put(drv->module);
 
 	if (ret)
 		return ret;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/s390/block/dasd.c .10026-2.5.38-try_inc_mod_count-removal/drivers/s390/block/dasd.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/s390/block/dasd.c	2002-09-18 16:03:28.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/drivers/s390/block/dasd.c	2002-09-25 10:23:58.000000000 +1000
@@ -2133,7 +2133,7 @@ dasd_open(struct inode *inp, struct file
 	spin_lock(&discipline_lock);
 	if (atomic_inc_return(&device->open_count) == 1 &&
 	    device->discipline->owner != NULL) {
-		if (!try_inc_mod_count(device->discipline->owner)) {
+		if (!try_module_get(device->discipline->owner)) {
 			/* Discipline is currently unloaded! */
 			atomic_dec(&device->open_count);
 			rc = -ENODEV;
@@ -2169,8 +2169,7 @@ dasd_release(struct inode *inp, struct f
 	}
 	if (atomic_dec_return(&device->open_count) == 0) {
 		invalidate_buffers(inp->i_rdev);
-		if (device->discipline->owner)
-			__MOD_DEC_USE_COUNT(device->discipline->owner);
+		module_put(device->discipline->owner);
 	}
 	dasd_put_device(devmap);
 	return 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/serial/core.c .10026-2.5.38-try_inc_mod_count-removal/drivers/serial/core.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/serial/core.c	2002-08-02 11:15:09.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/drivers/serial/core.c	2002-09-25 10:23:58.000000000 +1000
@@ -1228,8 +1228,7 @@ static void uart_close(struct tty_struct
 	wake_up_interruptible(&info->open_wait);
 
  done:
-	if (drv->owner)
-		__MOD_DEC_USE_COUNT(drv->owner);
+	module_put(drv->owner);
 }
 
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
@@ -1519,7 +1518,7 @@ static int uart_open(struct tty_struct *
 	 * is about to be unloaded).  Therefore, it is safe to set
 	 * tty->driver_data to be NULL, so uart_close() doesn't bite us.
 	 */
-	if (!try_inc_mod_count(drv->owner)) {
+	if (!try_module_get(drv->owner)) {
 		tty->driver_data = NULL;
 		goto fail;
 	}
@@ -1598,8 +1597,7 @@ static int uart_open(struct tty_struct *
 	return retval;
 
  out:
-	if (drv->owner)
-		__MOD_DEC_USE_COUNT(drv->owner);
+	module_put(drv->owner);
  fail:
 	return retval;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/usb/core/usb.c .10026-2.5.38-try_inc_mod_count-removal/drivers/usb/core/usb.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/drivers/usb/core/usb.c	2002-09-18 16:04:38.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/drivers/usb/core/usb.c	2002-09-25 10:23:58.000000000 +1000
@@ -75,18 +75,14 @@ int usb_device_probe(struct device *dev)
 	struct usb_driver * driver = to_usb_driver(dev->driver);
 	const struct usb_device_id *id;
 	int error = -ENODEV;
-	int m;
 
 	dbg("%s", __FUNCTION__);
 
 	if (!driver->probe)
 		return error;
 
-	if (driver->owner) {
-		m = try_inc_mod_count(driver->owner);
-		if (m == 0)
-			return error;
-	}
+	if (!try_module_get(driver->owner))
+		return error;
 
 	id = usb_match_id (intf, driver->id_table);
 	if (id) {
@@ -98,8 +94,7 @@ int usb_device_probe(struct device *dev)
 	if (!error)
 		intf->driver = driver;
 
-	if (driver->owner)
-		__MOD_DEC_USE_COUNT(driver->owner);
+	module_put(driver->owner);
 
 	return error;
 }
@@ -108,7 +103,6 @@ int usb_device_remove(struct device *dev
 {
 	struct usb_interface *intf;
 	struct usb_driver *driver;
-	int m;
 
 	intf = list_entry(dev,struct usb_interface,dev);
 	driver = to_usb_driver(dev->driver);
@@ -119,12 +113,9 @@ int usb_device_remove(struct device *dev
 		return -ENODEV;
 	}
 
-	if (driver->owner) {
-		m = try_inc_mod_count(driver->owner);
-		if (m == 0) {
-			err("Dieing driver still bound to device.\n");
-			return -EIO;
-		}
+	if (!try_module_get(driver->owner)) {
+		err("Dieing driver still bound to device.\n");
+		return -EIO;
 	}
 
 	/* if we sleep here on an umanaged driver 
@@ -140,8 +131,7 @@ int usb_device_remove(struct device *dev
 		usb_driver_release_interface(driver, intf);
 
 	up(&driver->serialize);
-	if (driver->owner)
-		__MOD_DEC_USE_COUNT(driver->owner);
+	module_put(driver->owner);
 
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/fs/devfs/base.c .10026-2.5.38-try_inc_mod_count-removal/fs/devfs/base.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/fs/devfs/base.c	2002-09-25 10:23:50.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/fs/devfs/base.c	2002-09-25 10:23:57.000000000 +1000
@@ -2044,8 +2044,8 @@ void *devfs_get_ops (devfs_handle_t de)
     else if ( S_ISCHR (de->mode) || S_ISREG (de->mode) )
 	owner = ( (struct file_operations *) de->u.fcb.ops )->owner;
     else owner = ( (struct block_device_operations *) de->u.fcb.ops )->owner;
-    if ( (de->next == de) || !try_inc_mod_count (owner) )
-    {   /*  Entry is already unhooked or module is unloading  */
+    if ( (de->next == de) || !try_module_get (owner) )
+    {   /*  Entry is already unhooked or module is loading/unloading  */
 	read_unlock (&de->parent->u.dir.lock);
 	return NULL;
     }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/fs/dquot.c .10026-2.5.38-try_inc_mod_count-removal/fs/dquot.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/fs/dquot.c	2002-09-21 13:55:15.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/fs/dquot.c	2002-09-25 10:23:57.000000000 +1000
@@ -100,7 +100,7 @@ static struct quota_format_type *find_qu
 
 	lock_kernel();
 	for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = actqf->qf_next);
-	if (actqf && !try_inc_mod_count(actqf->qf_owner))
+	if (actqf && !try_module_get(actqf->qf_owner))
 		actqf = NULL;
 	unlock_kernel();
 	return actqf;
@@ -108,8 +108,7 @@ static struct quota_format_type *find_qu
 
 static void put_quota_format(struct quota_format_type *fmt)
 {
-	if (fmt->qf_owner)
-		__MOD_DEC_USE_COUNT(fmt->qf_owner);
+	module_put(fmt->qf_owner);
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/fs/exec.c .10026-2.5.38-try_inc_mod_count-removal/fs/exec.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/fs/exec.c	2002-09-21 13:55:15.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/fs/exec.c	2002-09-25 10:23:57.000000000 +1000
@@ -97,8 +97,7 @@ int unregister_binfmt(struct linux_binfm
 
 static inline void put_binfmt(struct linux_binfmt * fmt)
 {
-	if (fmt->module)
-		__MOD_DEC_USE_COUNT(fmt->module);
+	module_put(fmt->module);
 }
 
 /*
@@ -138,7 +137,7 @@ asmlinkage long sys_uselib(const char * 
 		for (fmt = formats ; fmt ; fmt = fmt->next) {
 			if (!fmt->load_shlib)
 				continue;
-			if (!try_inc_mod_count(fmt->module))
+			if (!try_module_get(fmt->module))
 				continue;
 			read_unlock(&binfmt_lock);
 			error = fmt->load_shlib(file);
@@ -943,7 +942,7 @@ int search_binary_handler(struct linux_b
 			int (*fn)(struct linux_binprm *, struct pt_regs *) = fmt->load_binary;
 			if (!fn)
 				continue;
-			if (!try_inc_mod_count(fmt->module))
+			if (!try_module_get(fmt->module))
 				continue;
 			read_unlock(&binfmt_lock);
 			retval = fn(bprm, regs);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/fs/filesystems.c .10026-2.5.38-try_inc_mod_count-removal/fs/filesystems.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/fs/filesystems.c	2002-04-04 14:48:30.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/fs/filesystems.c	2002-09-25 10:23:57.000000000 +1000
@@ -20,7 +20,7 @@
  *	We can access the fields of list element if:
  *		1) spinlock is held or
  *		2) we hold the reference to the module.
- *	The latter can be guaranteed by call of try_inc_mod_count(); if it
+ *	The latter can be guaranteed by call of try_module_get(); if it
  *	returned 0 we must skip the element, otherwise we got the reference.
  *	Once the reference is obtained we can drop the spinlock.
  */
@@ -145,7 +145,7 @@ static int fs_name(unsigned int index, c
 
 	read_lock(&file_systems_lock);
 	for (tmp = file_systems; tmp; tmp = tmp->next, index--)
-		if (index <= 0 && try_inc_mod_count(tmp->owner))
+		if (index <= 0 && try_module_get(tmp->owner))
 				break;
 	read_unlock(&file_systems_lock);
 	if (!tmp)
@@ -216,13 +216,13 @@ struct file_system_type *get_fs_type(con
 
 	read_lock(&file_systems_lock);
 	fs = *(find_filesystem(name));
-	if (fs && !try_inc_mod_count(fs->owner))
+	if (fs && !try_module_get(fs->owner))
 		fs = NULL;
 	read_unlock(&file_systems_lock);
 	if (!fs && (request_module(name) == 0)) {
 		read_lock(&file_systems_lock);
 		fs = *(find_filesystem(name));
-		if (fs && !try_inc_mod_count(fs->owner))
+		if (fs && !try_module_get(fs->owner))
 			fs = NULL;
 		read_unlock(&file_systems_lock);
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/fs/nls/nls_base.c .10026-2.5.38-try_inc_mod_count-removal/fs/nls/nls_base.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/fs/nls/nls_base.c	2002-09-01 12:23:05.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/fs/nls/nls_base.c	2002-09-25 10:23:57.000000000 +1000
@@ -207,7 +207,7 @@ static struct nls_table *find_nls(char *
 	for (nls = tables; nls; nls = nls->next)
 		if (! strcmp(nls->charset, charset))
 			break;
-	if (nls && !try_inc_mod_count(nls->owner))
+	if (nls && !try_module_get(nls->owner))
 		nls = NULL;
 	spin_unlock(&nls_lock);
 	return nls;
@@ -245,8 +245,7 @@ struct nls_table *load_nls(char *charset
 
 void unload_nls(struct nls_table *nls)
 {
-	if (nls->owner)
-		__MOD_DEC_USE_COUNT(nls->owner);
+	module_put(nls->owner);
 }
 
 wchar_t charset2uni[256] = {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/include/linux/fs.h .10026-2.5.38-try_inc_mod_count-removal/include/linux/fs.h
--- .10026-2.5.38-try_inc_mod_count-removal.pre/include/linux/fs.h	2002-09-21 13:55:18.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/include/linux/fs.h	2002-09-25 10:23:58.000000000 +1000
@@ -985,14 +985,12 @@ struct super_block *get_sb_pseudo(struct
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \
-	(((fops) && (fops)->owner)	\
-		? ( try_inc_mod_count((fops)->owner) ? (fops) : NULL ) \
-		: (fops))
+	(((fops) && try_module_get((fops)->owner)) ? (fops) : NULL)
 
-#define fops_put(fops) \
-do {	\
-	if ((fops) && (fops)->owner) \
-		__MOD_DEC_USE_COUNT((fops)->owner);	\
+#define fops_put(fops)				\
+do {						\
+	if (fops)				\
+		module_put((fops)->owner);	\
 } while(0)
 
 extern int register_filesystem(struct file_system_type *);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/include/linux/module.h .10026-2.5.38-try_inc_mod_count-removal/include/linux/module.h
--- .10026-2.5.38-try_inc_mod_count-removal.pre/include/linux/module.h	2002-09-25 10:23:53.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/include/linux/module.h	2002-09-25 10:23:58.000000000 +1000
@@ -357,7 +357,6 @@ struct obsolete_modparm __parm_##var __a
 	do { (void)try_module_get(THIS_MODULE); __unsafe(THIS_MODULE); } while (0)
 #endif
 #define MOD_DEC_USE_COUNT module_put(THIS_MODULE)
-#define try_inc_mod_count(mod) try_module_get(mod)
 #define EXPORT_NO_SYMBOLS
 extern int module_dummy_usage;
 #define GET_USE_COUNT(module) (module_dummy_usage)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/include/linux/mtd/mtd.h .10026-2.5.38-try_inc_mod_count-removal/include/linux/mtd/mtd.h
--- .10026-2.5.38-try_inc_mod_count-removal.pre/include/linux/mtd/mtd.h	2001-11-10 18:34:41.000000000 +1100
+++ .10026-2.5.38-try_inc_mod_count-removal/include/linux/mtd/mtd.h	2002-09-25 10:23:58.000000000 +1000
@@ -216,7 +216,7 @@ static inline struct mtd_info *get_mtd_d
 	
 	ret = __get_mtd_device(mtd, num);
 
-	if (ret && ret->module && !try_inc_mod_count(ret->module))
+	if (ret && !try_module_get(ret->module))
 		return NULL;
 
 	return ret;
@@ -224,8 +224,7 @@ static inline struct mtd_info *get_mtd_d
 
 static inline void put_mtd_device(struct mtd_info *mtd)
 {
-       if (mtd->module)
-	       __MOD_DEC_USE_COUNT(mtd->module);
+	module_put(mtd->module);
 }
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/kernel/exec_domain.c .10026-2.5.38-try_inc_mod_count-removal/kernel/exec_domain.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/kernel/exec_domain.c	2002-09-25 10:23:47.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/kernel/exec_domain.c	2002-09-25 10:23:57.000000000 +1000
@@ -82,7 +82,7 @@ lookup_exec_domain(u_long personality)
 	read_lock(&exec_domains_lock);
 	for (ep = exec_domains; ep; ep = ep->next) {
 		if (pers >= ep->pers_low && pers <= ep->pers_high)
-			if (try_inc_mod_count(ep->module))
+			if (try_module_get(ep->module))
 				goto out;
 	}
 
@@ -97,7 +97,7 @@ lookup_exec_domain(u_long personality)
 
 	for (ep = exec_domains; ep; ep = ep->next) {
 		if (pers >= ep->pers_low && pers <= ep->pers_high)
-			if (try_inc_mod_count(ep->module))
+			if (try_module_get(ep->module))
 				goto out;
 	}
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/net/core/dev.c .10026-2.5.38-try_inc_mod_count-removal/net/core/dev.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/net/core/dev.c	2002-09-25 10:23:50.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/net/core/dev.c	2002-09-25 10:23:58.000000000 +1000
@@ -695,14 +695,13 @@ int dev_open(struct net_device *dev)
 	/*
 	 *	Call device private open method
 	 */
-	if (try_inc_mod_count(dev->owner)) {
+	if (try_module_get(dev->owner)) {
 		set_bit(__LINK_STATE_START, &dev->state);
 		if (dev->open) {
 			ret = dev->open(dev);
 			if (ret) {
 				clear_bit(__LINK_STATE_START, &dev->state);
-				if (dev->owner)
-					__MOD_DEC_USE_COUNT(dev->owner);
+				module_put(dev->owner);
 			}
 		}
 	} else {
@@ -834,8 +833,7 @@ int dev_close(struct net_device *dev)
 	/*
 	 * Drop the module refcount
 	 */
-	if (dev->owner)
-		__MOD_DEC_USE_COUNT(dev->owner);
+	module_put(dev->owner);
 
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/control.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/control.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/control.c	2002-06-21 09:41:57.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/control.c	2002-09-25 10:23:59.000000000 +1000
@@ -40,12 +40,6 @@ typedef struct _snd_kctl_ioctl {
 static rwlock_t snd_ioctl_rwlock = RW_LOCK_UNLOCKED;
 static LIST_HEAD(snd_control_ioctls);
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 static int snd_ctl_open(struct inode *inode, struct file *file)
 {
 	int cardnum = SNDRV_MINOR_CARD(minor(inode->i_rdev));
@@ -62,8 +56,8 @@ static int snd_ctl_open(struct inode *in
 		err = -ENODEV;
 		goto __error1;
 	}
-	if (!try_inc_mod_count(card->module)) {
-		err = -EFAULT;
+	if (!try_module_get(card->module)) {
+		err = -ENODEV;
 		goto __error1;
 	}
 	ctl = snd_magic_kcalloc(snd_ctl_file_t, 0, GFP_KERNEL);
@@ -83,7 +77,7 @@ static int snd_ctl_open(struct inode *in
 	return 0;
 
       __error:
-      	dec_mod_count(card->module);
+      	module_put(card->module);
       __error1:
 #ifdef LINUX_2_2
       	MOD_DEC_USE_COUNT;
@@ -128,7 +122,7 @@ static int snd_ctl_release(struct inode 
 	write_unlock(&card->control_owner_lock);
 	snd_ctl_empty_read_queue(ctl);
 	snd_magic_kfree(ctl);
-	dec_mod_count(card->module);
+	module_put(card->module);
 #ifdef LINUX_2_2
 	MOD_DEC_USE_COUNT;
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/info.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/info.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/info.c	2002-08-02 11:15:11.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/info.c	2002-09-25 10:23:59.000000000 +1000
@@ -39,12 +39,6 @@
  *
  */
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 int snd_info_check_reserved_words(const char *str)
 {
 	static char *reserved[] =
@@ -305,8 +299,8 @@ static int snd_info_entry_open(struct in
 #ifdef LINUX_2_2
 	MOD_INC_USE_COUNT;
 #endif
-	if (entry->module && !try_inc_mod_count(entry->module)) {
-		err = -EFAULT;
+	if (!try_module_get(entry->module)) {
+		err = -ENODEV;
 		goto __error1;
 	}
 	mode = file->f_flags & O_ACCMODE;
@@ -410,7 +404,7 @@ static int snd_info_entry_open(struct in
 	return 0;
 
       __error:
-	dec_mod_count(entry->module);
+	module_put(entry->module);
       __error1:
 #ifdef LINUX_2_2
 	MOD_DEC_USE_COUNT;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/oss/mixer_oss.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/oss/mixer_oss.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/oss/mixer_oss.c	2002-05-24 15:20:36.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/oss/mixer_oss.c	2002-09-25 10:23:59.000000000 +1000
@@ -34,12 +34,6 @@ MODULE_AUTHOR("Jaroslav Kysela <perex@su
 MODULE_DESCRIPTION("Mixer OSS emulation for ALSA.");
 MODULE_LICENSE("GPL");
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 static int snd_mixer_oss_open(struct inode *inode, struct file *file)
 {
 	int cardnum = SNDRV_MINOR_OSS_CARD(minor(inode->i_rdev));
@@ -59,7 +53,7 @@ static int snd_mixer_oss_open(struct ino
 #ifdef LINUX_2_2
 	MOD_INC_USE_COUNT;
 #endif
-	if (!try_inc_mod_count(card->module)) {
+	if (!try_get_module(card->module)) {
 		kfree(fmixer);
 #ifdef LINUX_2_2
 		MOD_DEC_USE_COUNT;
@@ -75,7 +69,7 @@ static int snd_mixer_oss_release(struct 
 
 	if (file->private_data) {
 		fmixer = (snd_mixer_oss_file_t *) file->private_data;
-		dec_mod_count(fmixer->card->module);
+		module_put(fmixer->card->module);
 #ifdef LINUX_2_2
 		MOD_DEC_USE_COUNT;
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/oss/pcm_oss.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/oss/pcm_oss.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/oss/pcm_oss.c	2002-06-21 09:41:57.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/oss/pcm_oss.c	2002-09-25 10:23:59.000000000 +1000
@@ -71,12 +71,6 @@ static inline void snd_leave_user(mm_seg
 	set_fs(fs);
 }
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 int snd_pcm_oss_plugin_clear(snd_pcm_substream_t *substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
@@ -1545,8 +1539,8 @@ static int snd_pcm_oss_open(struct inode
 		err = -ENODEV;
 		goto __error1;
 	}
-	if (!try_inc_mod_count(pcm->card->module)) {
-		err = -EFAULT;
+	if (!try_module_get(pcm->card->module)) {
+		err = -ENODEV;
 		goto __error1;
 	}
 	if (snd_task_name(current, task_name, sizeof(task_name)) < 0) {
@@ -1604,7 +1598,7 @@ static int snd_pcm_oss_open(struct inode
 	return err;
 
       __error:
-      	dec_mod_count(pcm->card->module);
+      	module_put(pcm->card->module);
       __error1:
 #ifdef LINUX_2_2
 	MOD_DEC_USE_COUNT;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/pcm_native.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/pcm_native.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/pcm_native.c	2002-06-21 09:41:57.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/pcm_native.c	2002-09-25 10:23:59.000000000 +1000
@@ -46,12 +46,6 @@ static inline void snd_leave_user(mm_seg
 	set_fs(fs);
 }
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 int snd_pcm_info(snd_pcm_substream_t * substream, snd_pcm_info_t *info)
 {
 	snd_pcm_runtime_t * runtime;
@@ -1755,8 +1749,8 @@ int snd_pcm_open(struct inode *inode, st
 		err = -ENODEV;
 		goto __error1;
 	}
-	if (!try_inc_mod_count(pcm->card->module)) {
-		err = -EFAULT;
+	if (!try_module_get(pcm->card->module)) {
+		err = -ENODEV;
 		goto __error1;
 	}
 	init_waitqueue_entry(&wait, current);
@@ -1789,7 +1783,7 @@ int snd_pcm_open(struct inode *inode, st
 	return err;
 
       __error:
-	dec_mod_count(pcm->card->module);
+	module_put(pcm->card->module);
       __error1:
 #ifdef LINUX_2_2
       	MOD_DEC_USE_COUNT;
@@ -1819,7 +1813,7 @@ int snd_pcm_release(struct inode *inode,
 	snd_pcm_release_file(pcm_file);
 	up(&pcm->open_mutex);
 	wake_up(&pcm->open_wait);
-	dec_mod_count(pcm->card->module);
+	module_put(pcm->card->module);
 #ifdef LINUX_2_2
 	MOD_DEC_USE_COUNT;
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/rawmidi.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/rawmidi.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/rawmidi.c	2002-06-21 09:41:57.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/rawmidi.c	2002-09-25 10:23:59.000000000 +1000
@@ -57,12 +57,6 @@ snd_rawmidi_t *snd_rawmidi_devices[SNDRV
 
 static DECLARE_MUTEX(register_mutex);
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 static inline unsigned short snd_rawmidi_file_flags(struct file *file)
 {
 	switch (file->f_mode & (FMODE_READ | FMODE_WRITE)) {
@@ -194,7 +188,7 @@ int snd_rawmidi_kernel_open(int cardnum,
 		err = -ENODEV;
 		goto __error1;
 	}
-	if (!try_inc_mod_count(rmidi->card->module)) {
+	if (!try_module_get(rmidi->card->module)) {
 		err = -EFAULT;
 		goto __error1;
 	}
@@ -344,7 +338,7 @@ int snd_rawmidi_kernel_open(int cardnum,
 		snd_rawmidi_done_buffer(output);
 		kfree(output);
 	}
-	dec_mod_count(rmidi->card->module);
+	module_put(rmidi->card->module);
 	up(&rmidi->open_mutex);
       __error1:
 #ifdef LINUX_2_2
@@ -497,7 +491,7 @@ int snd_rawmidi_kernel_release(snd_rawmi
 		rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT].substream_opened--;
 	}
 	up(&rmidi->open_mutex);
-	dec_mod_count(rmidi->card->module);
+	module_put(rmidi->card->module);
 #ifdef LINUX_2_2
 	MOD_DEC_USE_COUNT;
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/seq/oss/seq_oss_synth.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/seq/oss/seq_oss_synth.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/seq/oss/seq_oss_synth.c	2002-05-24 15:20:36.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/seq/oss/seq_oss_synth.c	2002-09-25 10:23:59.000000000 +1000
@@ -84,12 +84,6 @@ static spinlock_t register_lock = SPIN_L
 static seq_oss_synth_t *get_synthdev(seq_oss_devinfo_t *dp, int dev);
 static void reset_channels(seq_oss_synthinfo_t *info);
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 /*
  * global initialization
  */
@@ -233,12 +227,12 @@ snd_seq_oss_synth_setup(seq_oss_devinfo_
 		else
 			info->arg.event_passing = SNDRV_SEQ_OSS_PASS_EVENTS;
 		info->opened = 0;
-		if (!try_inc_mod_count(rec->oper.owner)) {
+		if (!try_module_get(rec->oper.owner)) {
 			snd_use_lock_free(&rec->use_lock);
 			continue;
 		}
 		if (rec->oper.open(&info->arg, rec->private_data) < 0) {
-			dec_mod_count(rec->oper.owner);
+			module_put(rec->oper.owner);
 			snd_use_lock_free(&rec->use_lock);
 			continue;
 		}
@@ -315,7 +309,7 @@ snd_seq_oss_synth_cleanup(seq_oss_devinf
 			if (rec->opened) {
 				debug_printk(("synth %d closed\n", i));
 				rec->oper.close(&info->arg);
-				dec_mod_count(rec->oper.owner);
+				module_put(rec->oper.owner);
 				rec->opened--;
 			}
 			snd_use_lock_free(&rec->use_lock);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/seq/seq_ports.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/seq/seq_ports.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/seq/seq_ports.c	2002-05-24 15:20:36.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/seq/seq_ports.c	2002-09-25 10:23:59.000000000 +1000
@@ -56,12 +56,6 @@ much elements are in array.
 
 */
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 /* return pointer to port structure - port is locked if found */
 client_port_t *snd_seq_port_use_ptr(client_t *client, int num)
 {
@@ -408,13 +402,13 @@ static int subscribe_port(client_t *clie
 {
 	int err = 0;
 
-	if (!try_inc_mod_count(port->owner))
-		return -EFAULT;
+	if (!try_module_get(port->owner))
+		return -ENODEV;
 	grp->count++;
 	if (grp->open && (port->callback_all || grp->count == 1)) {
 		err = grp->open(port->private_data, info);
 		if (err < 0) {
-			dec_mod_count(port->owner);
+			module_put(port->owner);
 			grp->count--;
 		}
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/seq/seq_virmidi.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/seq/seq_virmidi.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/seq/seq_virmidi.c	2002-05-24 15:20:36.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/seq/seq_virmidi.c	2002-09-25 10:23:59.000000000 +1000
@@ -53,12 +53,6 @@ MODULE_AUTHOR("Takashi Iwai <tiwai@suse.
 MODULE_DESCRIPTION("Virtual Raw MIDI client on Sequencer");
 MODULE_LICENSE("GPL");
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 /*
  * initialize an event record
  */
@@ -275,8 +269,8 @@ static int snd_virmidi_subscribe(void *p
 	snd_virmidi_dev_t *rdev;
 
 	rdev = snd_magic_cast(snd_virmidi_dev_t, private_data, return -EINVAL);
-	if (!try_inc_mod_count(rdev->card->module))
-		return -EFAULT;
+	if (!try_module_get(rdev->card->module))
+		return -ENODEV;
 	rdev->flags |= SNDRV_VIRMIDI_SUBSCRIBE;
 	return 0;
 }
@@ -290,7 +284,7 @@ static int snd_virmidi_unsubscribe(void 
 
 	rdev = snd_magic_cast(snd_virmidi_dev_t, private_data, return -EINVAL);
 	rdev->flags &= ~SNDRV_VIRMIDI_SUBSCRIBE;
-	dec_mod_count(rdev->card->module);
+	module_put(rdev->card->module);
 	return 0;
 }
 
@@ -303,8 +297,8 @@ static int snd_virmidi_use(void *private
 	snd_virmidi_dev_t *rdev;
 
 	rdev = snd_magic_cast(snd_virmidi_dev_t, private_data, return -EINVAL);
-	if (!try_inc_mod_count(rdev->card->module))
-		return -EFAULT;
+	if (!try_module_get(rdev->card->module))
+		return -ENODEV;
 	rdev->flags |= SNDRV_VIRMIDI_USE;
 	return 0;
 }
@@ -318,7 +312,7 @@ static int snd_virmidi_unuse(void *priva
 
 	rdev = snd_magic_cast(snd_virmidi_dev_t, private_data, return -EINVAL);
 	rdev->flags &= ~SNDRV_VIRMIDI_USE;
-	dec_mod_count(rdev->card->module);
+	module_put(rdev->card->module);
 	return 0;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/timer.c .10026-2.5.38-try_inc_mod_count-removal/sound/core/timer.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/core/timer.c	2002-06-21 09:41:57.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/core/timer.c	2002-09-25 10:23:59.000000000 +1000
@@ -74,12 +74,6 @@ static int snd_timer_dev_unregister(snd_
 
 static void snd_timer_reschedule(snd_timer_t * timer, unsigned long ticks_left);
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 /*
  * create a timer instance with the given owner string.
  * when timer is not NULL, increments the module counter
@@ -102,7 +96,7 @@ static snd_timer_instance_t *snd_timer_i
 	timeri->in_use = (atomic_t)ATOMIC_INIT(0);
 
 	timeri->timer = timer;
-	if (timer && timer->card && !try_inc_mod_count(timer->card->module)) {
+	if (timer && timer->card && !try_module_get(timer->card->module)) {
 		kfree(timeri->owner);
 		kfree(timeri);
 		return NULL;
@@ -315,7 +309,7 @@ int snd_timer_close(snd_timer_instance_t
 		kfree(timeri->owner);
 	kfree(timeri);
 	if (timer && timer->card)
-		dec_mod_count(timer->card->module);
+		module_put(timer->card->module);
 	return 0;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/drivers/opl3/opl3_seq.c .10026-2.5.38-try_inc_mod_count-removal/sound/drivers/opl3/opl3_seq.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/drivers/opl3/opl3_seq.c	2002-06-21 09:41:57.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/drivers/opl3/opl3_seq.c	2002-09-25 10:23:59.000000000 +1000
@@ -35,23 +35,17 @@ int use_internal_drums = 0;
 MODULE_PARM(use_internal_drums, "i");
 MODULE_PARM_DESC(use_internal_drums, "Enable internal OPL2/3 drums.");
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 int snd_opl3_synth_use_inc(opl3_t * opl3)
 {
-	if (!try_inc_mod_count(opl3->card->module))
-		return -EFAULT;
+	if (!try_module_get(opl3->card->module))
+		return -ENODEV;
 	return 0;
 
 }
 
 void snd_opl3_synth_use_dec(opl3_t * opl3)
 {
-	dec_mod_count(opl3->card->module);
+	module_put(opl3->card->module);
 }
 
 int snd_opl3_synth_setup(opl3_t * opl3)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/isa/gus/gus_main.c .10026-2.5.38-try_inc_mod_count-removal/sound/isa/gus/gus_main.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/isa/gus/gus_main.c	2002-05-24 15:20:36.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/isa/gus/gus_main.c	2002-09-25 10:23:59.000000000 +1000
@@ -37,16 +37,12 @@ MODULE_LICENSE("GPL");
 
 static int snd_gus_init_dma_irq(snd_gus_card_t * gus, int latches);
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
+/* FIXME: This doesn't make sense.  To find this symbol, they have a
+   reference, so why inc outselves here? --RR */
 int snd_gus_use_inc(snd_gus_card_t * gus)
 {
 	MOD_INC_USE_COUNT;
-	if (!try_inc_mod_count(gus->card->module)) {
+	if (!try_module_get(gus->card->module)) {
 		MOD_DEC_USE_COUNT;
 		return 0;
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/isa/wavefront/wavefront_fx.c .10026-2.5.38-try_inc_mod_count-removal/sound/isa/wavefront/wavefront_fx.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/isa/wavefront/wavefront_fx.c	2002-05-24 15:20:36.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/isa/wavefront/wavefront_fx.c	2002-09-25 10:23:59.000000000 +1000
@@ -34,13 +34,6 @@
 #define FX_MSB_TRANSFER 0x02    /* transfer after DSP MSB byte written */
 #define FX_AUTO_INCR    0x04    /* auto-increment DSP address after transfer */
 
-static inline void
-dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 static int
 wavefront_fx_idle (snd_wavefront_t *dev) 
     
@@ -148,12 +141,14 @@ snd_wavefront_fx_detect (snd_wavefront_t
 	return 0;
 }	
 
+/* FIXME: This doesn't make sense.  To find this symbol, they have a
+   reference, so why inc outselves here? --RR */
 int 
 snd_wavefront_fx_open (snd_hwdep_t *hw, struct file *file)
 
 {
 	MOD_INC_USE_COUNT;
-	if (!try_inc_mod_count(hw->card->module)) {
+	if (!try_module_get(hw->card->module)) {
 		MOD_DEC_USE_COUNT;
 		return -EFAULT;
 	}
@@ -165,7 +160,7 @@ int 
 snd_wavefront_fx_release (snd_hwdep_t *hw, struct file *file)
 
 {
-	dec_mod_count(hw->card->module);
+	module_put(hw->card->module);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/isa/wavefront/wavefront_synth.c .10026-2.5.38-try_inc_mod_count-removal/sound/isa/wavefront/wavefront_synth.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/isa/wavefront/wavefront_synth.c	2002-05-24 15:20:36.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/isa/wavefront/wavefront_synth.c	2002-09-25 10:23:59.000000000 +1000
@@ -234,13 +234,6 @@ static wavefront_command wavefront_comma
 	{ 0x00 }
 };
 
-static inline void
-dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 static const char *
 wavefront_errorstr (int errnum)
 
@@ -1607,12 +1600,14 @@ wavefront_synth_control (snd_wavefront_c
 	return 0;
 }
 
+/* FIXME: This doesn't make sense.  To find this symbol, they have a
+   reference, so why inc outselves here? --RR */
 int 
 snd_wavefront_synth_open (snd_hwdep_t *hw, struct file *file)
 
 {
 	MOD_INC_USE_COUNT;
-	if (!try_inc_mod_count(hw->card->module)) {
+	if (!try_module_get(hw->card->module)) {
 		MOD_DEC_USE_COUNT;
 		return -EFAULT;
 	}
@@ -1624,7 +1619,7 @@ int 
 snd_wavefront_synth_release (snd_hwdep_t *hw, struct file *file)
 
 {
-	dec_mod_count(hw->card->module);
+	module_put(hw->card->module);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10026-2.5.38-try_inc_mod_count-removal.pre/sound/synth/emux/emux_seq.c .10026-2.5.38-try_inc_mod_count-removal/sound/synth/emux/emux_seq.c
--- .10026-2.5.38-try_inc_mod_count-removal.pre/sound/synth/emux/emux_seq.c	2002-05-24 15:20:37.000000000 +1000
+++ .10026-2.5.38-try_inc_mod_count-removal/sound/synth/emux/emux_seq.c	2002-09-25 10:23:59.000000000 +1000
@@ -62,12 +62,6 @@ static snd_midi_op_t emux_ops = {
 /*
  */
 
-static inline void dec_mod_count(struct module *module)
-{
-	if (module)
-		__MOD_DEC_USE_COUNT(module);
-}
-
 /*
  * Initialise the EMUX Synth by creating a client and registering
  * a series of ports.
@@ -281,10 +275,10 @@ int
 snd_emux_inc_count(snd_emux_t *emu)
 {
 	emu->used++;
-	if (!try_inc_mod_count(emu->ops.owner))
+	if (!try_module_get(emu->ops.owner))
 		goto __error;
-	if (!try_inc_mod_count(emu->card->module)) {
-		dec_mod_count(emu->ops.owner);
+	if (!try_module_get(emu->card->module)) {
+		module_put(emu->ops.owner);
 	      __error:
 		emu->used--;
 		return 0;
@@ -299,11 +293,11 @@ snd_emux_inc_count(snd_emux_t *emu)
 void
 snd_emux_dec_count(snd_emux_t *emu)
 {
-	dec_mod_count(emu->ops.owner);
+	module_put(emu->ops.owner);
 	emu->used--;
 	if (emu->used <= 0)
 		snd_emux_terminate_all(emu);
-	dec_mod_count(emu->card->module);
+	module_put(emu->card->module);
 }
 
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
