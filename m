Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbTCYNqs>; Tue, 25 Mar 2003 08:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbTCYNqs>; Tue, 25 Mar 2003 08:46:48 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:21003 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262648AbTCYNpP>; Tue, 25 Mar 2003 08:45:15 -0500
Date: Tue, 25 Mar 2003 14:56:20 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] example driver cleanups
Message-ID: <Pine.LNX.4.44.0303251455520.16764-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch demonstrates some possible cleanups the previous patch enables.
I removed the unused num_minors argument from usb_register_dev and
usb_open is completely gone. The open function in the misc drivers
is only needed to request modules.
I included an alternative patch to let the tty layer manage regions
itself, until it's properly fixed.

bye, Roman

diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/char/misc.c linux-2.5.66-cdev4/drivers/char/misc.c
--- linux-2.5.66-cdev3/drivers/char/misc.c	2003-03-25 10:46:27.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/char/misc.c	2003-03-25 11:02:53.000000000 +0100
@@ -60,11 +60,8 @@ static DECLARE_MUTEX(misc_sem);
  * Assigned numbers, used for dynamic minors
  */
 #define DYNAMIC_MINORS 64 /* like dynamic majors */
-static unsigned char misc_minors[DYNAMIC_MINORS / 8];
 
-#ifdef CONFIG_SGI_NEWPORT_GFX
 extern void gfx_register(void);
-#endif
 extern void streamable_init(void);
 extern int rtc_DP8570A_init(void);
 extern int rtc_MK48T08_init(void);
@@ -100,45 +97,23 @@ static int misc_read_proc(char *buf, cha
 
 static int misc_open(struct inode * inode, struct file * file)
 {
-	int minor = minor(inode->i_rdev);
-	struct miscdevice *c;
 	int err = -ENODEV;
-	struct file_operations *old_fops, *new_fops = NULL;
-	
-	down(&misc_sem);
-	
-	c = misc_list.next;
-
-	while ((c != &misc_list) && (c->minor != minor))
-		c = c->next;
-	if (c != &misc_list)
-		new_fops = fops_get(c->fops);
-	if (!new_fops) {
-		char modname[20];
-		up(&misc_sem);
-		sprintf(modname, "char-major-%d-%d", MISC_MAJOR, minor);
-		request_module(modname);
-		down(&misc_sem);
-		c = misc_list.next;
-		while ((c != &misc_list) && (c->minor != minor))
-			c = c->next;
-		if (c == &misc_list || (new_fops = fops_get(c->fops)) == NULL)
-			goto fail;
-	}
-
-	err = 0;
-	old_fops = file->f_op;
-	file->f_op = new_fops;
-	if (file->f_op->open) {
-		err=file->f_op->open(inode,file);
-		if (err) {
-			fops_put(file->f_op);
-			file->f_op = fops_get(old_fops);
-		}
+#ifdef CONFIG_KMOD
+	char modname[32];
+	struct char_device *cdev = inode->i_cdev;
+	struct file_operations *fops;
+
+	sprintf(modname, "char-major-%d-%d", MISC_MAJOR, MINOR(cdev->cd_dev));
+	request_module(modname);
+	fops = fops_get(cdev->cd_fops);
+	if (fops) {
+		err = 0;
+		fops_put(file->f_op);
+		file->f_op = fops;
+		if (fops->open)
+			err = fops->open(inode, file);
 	}
-	fops_put(old_fops);
-fail:
-	up(&misc_sem);
+#endif
 	return err;
 }
 
@@ -167,34 +142,35 @@ static struct file_operations misc_fops 
 int misc_register(struct miscdevice * misc)
 {
 	static devfs_handle_t devfs_handle, dir;
-	struct miscdevice *c;
-	
-	if (misc->next || misc->prev)
-		return -EBUSY;
-	down(&misc_sem);
-	c = misc_list.next;
-
-	while ((c != &misc_list) && (c->minor != misc->minor))
-		c = c->next;
-	if (c != &misc_list) {
-		up(&misc_sem);
-		return -EBUSY;
-	}
+	struct char_device *cdev;
 
 	if (misc->minor == MISC_DYNAMIC_MINOR) {
-		int i = DYNAMIC_MINORS;
-		while (--i >= 0)
-			if ( (misc_minors[i>>3] & (1 << (i&7))) == 0)
-				break;
-		if (i<0)
-		{
-			up(&misc_sem);
-			return -EBUSY;
+		int i;
+
+		for (i = DYNAMIC_MINORS; i > 0; i--) {
+			cdev = cdget(MKDEV(MISC_MAJOR, i));
+			down(&cdev->cd_sem);
+			if (!cdev->cd_fops)
+				goto found;
+			up(&cdev->cd_sem);
+			cdput(cdev);
 		}
-		misc->minor = i;
-	}
-	if (misc->minor < DYNAMIC_MINORS)
-		misc_minors[misc->minor >> 3] |= 1 << (misc->minor & 7);
+	} else {
+		cdev = cdget(MKDEV(MISC_MAJOR, misc->minor));
+		down(&cdev->cd_sem);
+		if (!cdev->cd_fops)
+			goto found;
+		up(&cdev->cd_sem);
+	}
+	return -EBUSY;
+
+found:
+	cdev->cd_fops = misc->fops;
+	cdev->cd_name = misc->name;
+	up(&cdev->cd_sem);
+
+	down(&misc_sem);
+
 	if (!devfs_handle)
 		devfs_handle = devfs_mk_dir("misc");
 	dir = strchr (misc->name, '/') ? NULL : devfs_handle;
@@ -204,14 +180,10 @@ int misc_register(struct miscdevice * mi
 				S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
 				misc->fops, NULL);
 
-	/*
-	 * Add it to the front, so that later devices can "override"
-	 * earlier defaults
-	 */
 	misc->prev = &misc_list;
 	misc->next = misc_list.next;
-	misc->prev->next = misc;
-	misc->next->prev = misc;
+	misc_list.next->prev = misc;
+	misc_list.next = misc;
 	up(&misc_sem);
 	return 0;
 }
@@ -228,18 +200,22 @@ int misc_register(struct miscdevice * mi
 
 int misc_deregister(struct miscdevice * misc)
 {
-	int i = misc->minor;
-	if (!misc->next || !misc->prev)
+	struct char_device *cdev;
+
+	cdev = cdget(MKDEV(MISC_MAJOR, misc->minor));
+	down(&cdev->cd_sem);
+	if (cdev->cd_fops != misc->fops) {
+		up(&cdev->cd_sem);
 		return -EINVAL;
+	}
+	cdev->cd_fops = NULL;
+	cdev->cd_name = NULL;
+	up(&cdev->cd_sem);
+
 	down(&misc_sem);
 	misc->prev->next = misc->next;
 	misc->next->prev = misc->prev;
-	misc->next = NULL;
-	misc->prev = NULL;
-	devfs_unregister (misc->devfs_handle);
-	if (i < DYNAMIC_MINORS && i>0) {
-		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
-	}
+	devfs_unregister(misc->devfs_handle);
 	up(&misc_sem);
 	return 0;
 }
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/char/tty_io.c linux-2.5.66-cdev4/drivers/char/tty_io.c
--- linux-2.5.66-cdev3/drivers/char/tty_io.c	2003-03-25 11:02:38.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/char/tty_io.c	2003-03-25 12:24:15.000000000 +0100
@@ -122,7 +122,7 @@ struct termios tty_std_termios = {	/* fo
 	.c_cc = INIT_C_CC
 };
 
-LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
+LIST_HEAD(tty_majors);			/* linked list of tty majors */
 struct tty_ldisc ldiscs[NR_LDISCS];	/* line disc dispatch table	*/
 
 #ifdef CONFIG_UNIX98_PTYS
@@ -329,28 +329,26 @@ static int tty_set_ldisc(struct tty_stru
  */
 static struct tty_driver *get_tty_driver(kdev_t device)
 {
-	int	major, minor;
+	struct char_device *cdev;
+	struct tty_major *major;
 	struct tty_driver *p;
+	int minor;
 #ifdef CONFIG_KMOD
 	char name[20] = "";
 again:
 #endif
 
 	minor = minor(device);
-	major = major(device);
-
-	list_for_each_entry(p, &tty_drivers, tty_drivers) {
-		if (p->major != major)
-			continue;
-		if (minor < p->minor_start)
-			continue;
-		if (minor >= p->minor_start + p->num)
-			continue;
-		return p;
+	cdev = cdget_major(major(device));
+	major = cdev->cd_data;
+	cdput(cdev);
+	list_for_each_entry(p, &major->drivers, tty_drivers) {
+		if (minor >= p->minor_start && minor < p->minor_start + p->num)
+			return p;
 	}
 #ifdef CONFIG_KMOD
 	if (!name[0]) {
-		sprintf(name, "char-major-%d", major);
+		sprintf(name, "char-major-%d", major(device));
 		request_module(name);
 		goto again;
 	}
@@ -2123,6 +2121,8 @@ EXPORT_SYMBOL(tty_unregister_device);
  */
 int tty_register_driver(struct tty_driver *driver)
 {
+	struct char_device *cdev;
+	struct tty_major *major;
 	int error;
 	int i;
 
@@ -2130,33 +2130,37 @@ int tty_register_driver(struct tty_drive
 		return 0;
 
 	down_tty_sem(0);
-	if (driver->major) {
-		struct char_device *cdev = cdget(MKDEV(driver->major, 0));
-		struct file_operations *fops = cdev->cd_fops;
-		cdput(cdev);
-		error = 0;
-		if (fops == &tty_fops)
-			goto skip;
-	}
 	error = register_chrdev(driver->major, driver->name, &tty_fops);
-	if (error < 0) {
-		up_tty_sem(0);
-		return error;
-	} else if (driver->major == 0)
+	if (!driver->major)
 		driver->major = error;
-skip:
+	cdev = cdget_major(driver->major);
+	if (error == -EBUSY && cdev->cd_fops == &tty_fops) {
+		error = 0;
+		major = cdev->cd_data;
+	} else if (error >= 0) {
+		cdev->cd_data = major = kmalloc(sizeof(*major), GFP_KERNEL);
+		if (!major) {
+			unregister_chrdev(driver->major, driver->name);
+			goto out;
+		}
+		INIT_LIST_HEAD(&major->drivers);
+		list_add(&major->list, &tty_majors);
+	} else
+		goto out;
 
 	if (!driver->put_char)
 		driver->put_char = tty_default_put_char;
 	
-	list_add(&driver->tty_drivers, &tty_drivers);
-	up_tty_sem(0);
+	list_add_tail(&driver->tty_drivers, &major->drivers);
 	
 	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
 		for(i = 0; i < driver->num; i++)
 		    tty_register_device(driver, driver->minor_start + i);
 	}
 	proc_tty_register_driver(driver);
+out:
+	cdput(cdev);
+	up_tty_sem(0);
 	return error;
 }
 
@@ -2165,39 +2169,28 @@ skip:
  */
 int tty_unregister_driver(struct tty_driver *driver)
 {
-	int	retval;
-	struct tty_driver *p;
-	int	i, found = 0;
+	struct char_device *cdev;
+	struct tty_major *major;
 	struct termios *tp;
-	const char *othername = NULL;
+	int i;
 	
 	if (*driver->refcount)
 		return -EBUSY;
 
 	down_tty_sem(0);
-	list_for_each_entry(p, &tty_drivers, tty_drivers) {
-		if (p == driver)
-			found++;
-		else if (p->major == driver->major)
-			othername = p->name;
+	cdev = cdget_major(driver->major);
+	major = cdev->cd_data;
+	list_del(&driver->tty_drivers);
+	if (list_empty(&major->drivers)) {
+		unregister_chrdev(driver->major, driver->name);
+		list_del(&major->list);
+		kfree(major);
+	} else if (cdev->cd_name == driver->name) {
+		struct tty_driver *p;
+		p = list_entry(major->drivers.next, struct tty_driver, tty_drivers);
+		cdev->cd_name = p->name;
 	}
-
-	if (found) {
-		if (othername) {
-			struct char_device *cdev = cdget(MKDEV(driver->major, 0));
-			cdev->cd_name = othername;
-			cdput(cdev);
-			retval = 0;
-		} else
-			retval = unregister_chrdev(driver->major, driver->name);
-	} else
-		retval = -ENOENT;
-
-	if (!retval)
-		list_del(&driver->tty_drivers);
 	up_tty_sem(0);
-	if (retval)
-		return retval;
 
 	/*
 	 * Free the termios and termios_locked structures because
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/class/usblp.c linux-2.5.66-cdev4/drivers/usb/class/usblp.c
--- linux-2.5.66-cdev3/drivers/usb/class/usblp.c	2003-03-25 10:46:55.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/class/usblp.c	2003-03-25 11:02:53.000000000 +0100
@@ -383,7 +383,7 @@ out:
 static void usblp_cleanup (struct usblp *usblp)
 {
 	devfs_unregister (usblp->devfs);
-	usb_deregister_dev (1, usblp->minor);
+	usb_deregister_dev (usblp->minor);
 	info("usblp%d: removed", usblp->minor);
 
 	usb_buffer_free (usblp->dev, USBLP_BUF_SIZE,
@@ -832,7 +832,7 @@ static int usblp_probe(struct usb_interf
 	init_waitqueue_head(&usblp->wait);
 	usblp->ifnum = intf->altsetting->desc.bInterfaceNumber;
 
-	retval = usb_register_dev(&usblp_fops, USBLP_MINOR_BASE, 1, &usblp->minor);
+	retval = usb_register_dev(&usblp_fops, USBLP_MINOR_BASE, &usblp->minor);
 	if (retval) {
 		err("Not able to get a minor for this device.");
 		goto abort;
@@ -930,7 +930,7 @@ static int usblp_probe(struct usb_interf
 	return 0;
 
 abort_minor:
-	usb_deregister_dev (1, usblp->minor);
+	usb_deregister_dev (usblp->minor);
 abort:
 	if (usblp) {
 		if (usblp->writebuf)
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/core/file.c linux-2.5.66-cdev4/drivers/usb/core/file.c
--- linux-2.5.66-cdev3/drivers/usb/core/file.c	2003-03-25 10:46:55.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/core/file.c	2003-03-25 11:02:53.000000000 +0100
@@ -31,41 +31,9 @@
 static devfs_handle_t usb_devfs_handle;	/* /dev/usb dir. */
 
 #define MAX_USB_MINORS	256
-static struct file_operations *usb_minors[MAX_USB_MINORS];
-static spinlock_t minor_lock = SPIN_LOCK_UNLOCKED;
-
-static int usb_open(struct inode * inode, struct file * file)
-{
-	int minor = minor(inode->i_rdev);
-	struct file_operations *c;
-	int err = -ENODEV;
-	struct file_operations *old_fops, *new_fops = NULL;
-
-	spin_lock (&minor_lock);
-	c = usb_minors[minor];
-
-	if (!c || !(new_fops = fops_get(c))) {
-		spin_unlock(&minor_lock);
-		return err;
-	}
-	spin_unlock(&minor_lock);
-
-	old_fops = file->f_op;
-	file->f_op = new_fops;
-	/* Curiouser and curiouser... NULL ->open() as "no device" ? */
-	if (file->f_op->open)
-		err = file->f_op->open(inode,file);
-	if (err) {
-		fops_put(file->f_op);
-		file->f_op = fops_get(old_fops);
-	}
-	fops_put(old_fops);
-	return err;
-}
 
 static struct file_operations usb_fops = {
 	.owner =	THIS_MODULE,
-	.open =		usb_open,
 };
 
 int usb_major_init(void)
@@ -106,12 +74,10 @@ void usb_major_cleanup(void)
  * device, and 0 on success, alone with a value that the driver should
  * use in start_minor.
  */
-int usb_register_dev (struct file_operations *fops, int minor, int num_minors, int *start_minor)
+int usb_register_dev (struct file_operations *fops, int minor, int *start_minor)
 {
+	struct char_device *cdev;
 	int i;
-	int j;
-	int good_spot;
-	int retval = -EINVAL;
 
 #ifdef CONFIG_USB_DYNAMIC_MINORS
 	/* 
@@ -122,37 +88,29 @@ int usb_register_dev (struct file_operat
 	minor = 0;
 #endif
 
-	dbg ("asking for %d minors, starting at %d", num_minors, minor);
+	dbg ("asking for 1 minors, starting at %d", minor);
 
 	if (fops == NULL)
-		goto exit;
+		return  -EINVAL;
 
 	*start_minor = 0; 
-	spin_lock (&minor_lock);
 	for (i = minor; i < MAX_USB_MINORS; ++i) {
-		if (usb_minors[i])
-			continue;
-
-		good_spot = 1;
-		for (j = 1; j <= num_minors-1; ++j)
-			if (usb_minors[i+j]) {
-				good_spot = 0;
-				break;
+		cdev = cdget(MKDEV(USB_MAJOR, i));
+		if (!cdev->cd_fops) {
+			down(&cdev->cd_sem);
+			if (!cdev->cd_fops) {
+				dbg("found a minor chunk free, starting at %d", i);
+				cdev->cd_fops = fops;
+				up(&cdev->cd_sem);
+				*start_minor = i;
+				return 0;
 			}
-		if (good_spot == 0)
-			continue;
-
-		*start_minor = i;
-		dbg("found a minor chunk free, starting at %d", i);
-		for (i = *start_minor; i < (*start_minor + num_minors); ++i)
-			usb_minors[i] = fops;
-
-		retval = 0;
-		goto exit;
+			up(&cdev->cd_sem);
+		}
+		cdput(cdev);
 	}
-exit:
-	spin_unlock (&minor_lock);
-	return retval;
+
+	return -EBUSY;
 }
 EXPORT_SYMBOL(usb_register_dev);
 
@@ -168,16 +126,21 @@ EXPORT_SYMBOL(usb_register_dev);
  * 
  * This should be called by all drivers that use the USB major number.
  */
-void usb_deregister_dev (int num_minors, int start_minor)
+void usb_deregister_dev (int minor)
 {
-	int i;
+	struct char_device *cdev;
 
 	dbg ("removing %d minors starting at %d", num_minors, start_minor);
 
-	spin_lock (&minor_lock);
-	for (i = start_minor; i < (start_minor + num_minors); ++i)
-		usb_minors[i] = NULL;
-	spin_unlock (&minor_lock);
+	cdev = cdget(MKDEV(USB_MAJOR, minor));
+	down(&cdev->cd_sem);
+	if (cdev->cd_fops) {
+		cdev->cd_fops = NULL;
+		cdput(cdev);
+	} else
+		printk("usb_deregister_dev: releasing invalid dev %d\n", minor);
+	up(&cdev->cd_sem);
+	cdput(cdev);
 }
 EXPORT_SYMBOL(usb_deregister_dev);
 
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/image/mdc800.c linux-2.5.66-cdev4/drivers/usb/image/mdc800.c
--- linux-2.5.66-cdev3/drivers/usb/image/mdc800.c	2003-03-11 10:57:38.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/image/mdc800.c	2003-03-25 11:02:53.000000000 +0100
@@ -478,7 +478,7 @@ static int mdc800_usb_probe (struct usb_
 
 	down (&mdc800->io_lock);
 
-	retval = usb_register_dev (&mdc800_device_ops, MDC800_DEVICE_MINOR_BASE, 1, &mdc800->minor);
+	retval = usb_register_dev (&mdc800_device_ops, MDC800_DEVICE_MINOR_BASE, &mdc800->minor);
 	if (retval && (retval != -ENODEV)) {
 		err ("Not able to get a minor for this device.");
 		return -ENODEV;
@@ -541,7 +541,7 @@ static void mdc800_usb_disconnect (struc
 		if (mdc800->state == NOT_CONNECTED)
 			return;
 
-		usb_deregister_dev (1, mdc800->minor);
+		usb_deregister_dev (mdc800->minor);
 
 		mdc800->state=NOT_CONNECTED;
 
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/image/scanner.c linux-2.5.66-cdev4/drivers/usb/image/scanner.c
--- linux-2.5.66-cdev3/drivers/usb/image/scanner.c	2003-03-25 10:46:55.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/image/scanner.c	2003-03-25 11:02:53.000000000 +0100
@@ -840,7 +840,7 @@ static void destroy_scanner (struct kobj
 
 	dbg("%s: De-allocating minor:%d", __FUNCTION__, scn->scn_minor);
 	devfs_unregister(scn->devfs);
-	usb_deregister_dev(1, scn->scn_minor);
+	usb_deregister_dev(scn->scn_minor);
 	usb_free_urb(scn->scn_irq);
 	usb_put_dev(scn->scn_dev);
 	up (&(scn->sem));
@@ -1006,7 +1006,7 @@ probe_scanner(struct usb_interface *intf
 	
 	down(&scn_mutex);
 
-	retval = usb_register_dev(&usb_scanner_fops, SCN_BASE_MNR, 1, &scn_minor);
+	retval = usb_register_dev(&usb_scanner_fops, SCN_BASE_MNR, &scn_minor);
 	if (retval) {
 		err ("Not able to get a minor for this device.");
 		up(&scn_mutex);
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/input/hiddev.c linux-2.5.66-cdev4/drivers/usb/input/hiddev.c
--- linux-2.5.66-cdev3/drivers/usb/input/hiddev.c	2003-03-25 10:46:55.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/input/hiddev.c	2003-03-25 11:02:53.000000000 +0100
@@ -230,7 +230,7 @@ static int hiddev_fasync(int fd, struct 
 static void hiddev_cleanup(struct hiddev *hiddev)
 {
 	devfs_unregister(hiddev->devfs);
-	usb_deregister_dev(1, hiddev->minor);
+	usb_deregister_dev(hiddev->minor);
 	hiddev_table[hiddev->minor] = NULL;
 	kfree(hiddev);
 }
@@ -695,14 +695,14 @@ int hiddev_connect(struct hid_device *hi
 	if (i == hid->maxcollection && (hid->quirks & HID_QUIRK_HIDDEV) == 0)
 		return -1;
 
-	retval = usb_register_dev(&hiddev_fops, HIDDEV_MINOR_BASE, 1, &minor);
+	retval = usb_register_dev(&hiddev_fops, HIDDEV_MINOR_BASE, &minor);
 	if (retval) {
 		err("Not able to get a minor for this device.");
 		return -1;
 	}
 
 	if (!(hiddev = kmalloc(sizeof(struct hiddev), GFP_KERNEL))) {
-		usb_deregister_dev (1, minor);
+		usb_deregister_dev (minor);
 		return -1;
 	}
 	memset(hiddev, 0, sizeof(struct hiddev));
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/media/dabusb.c linux-2.5.66-cdev4/drivers/usb/media/dabusb.c
--- linux-2.5.66-cdev3/drivers/usb/media/dabusb.c	2003-02-05 10:41:24.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/media/dabusb.c	2003-03-25 11:02:53.000000000 +0100
@@ -731,7 +731,7 @@ static int dabusb_probe (struct usb_inte
 	if (intf->altsetting->desc.bInterfaceNumber != _DABUSB_IF && usbdev->descriptor.idProduct == 0x9999)
 		return -ENODEV;
 
-	retval = usb_register_dev (&dabusb_fops, DABUSB_MINOR, 1, &devnum);
+	retval = usb_register_dev (&dabusb_fops, DABUSB_MINOR, &devnum);
 	if (retval)
 		return -ENOMEM;
 
@@ -778,7 +778,7 @@ static void dabusb_disconnect (struct us
 
 	usb_set_intfdata (intf, NULL);
 	if (s) {
-		usb_deregister_dev (1, s->devnum);
+		usb_deregister_dev (s->devnum);
 		s->remove_pending = 1;
 		wake_up (&s->wait);
 		if (s->state == _started)
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/misc/auerswald.c linux-2.5.66-cdev4/drivers/usb/misc/auerswald.c
--- linux-2.5.66-cdev3/drivers/usb/misc/auerswald.c	2003-03-25 10:46:55.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/misc/auerswald.c	2003-03-25 11:02:53.000000000 +0100
@@ -1956,7 +1956,7 @@ static int auerswald_probe (struct usb_i
 	init_waitqueue_head (&cp->bufferwait);
 
 	down (&dev_table_mutex);
-	ret = usb_register_dev (&auerswald_fops, AUER_MINOR_BASE, 1, &dtindex);
+	ret = usb_register_dev (&auerswald_fops, AUER_MINOR_BASE, &dtindex);
 	if (ret) {
 		err ("Not able to get a minor for this device.");
 		up (&dev_table_mutex);
@@ -2095,7 +2095,7 @@ static void auerswald_disconnect (struct
 	devfs_unregister (cp->devfs);
 
 	/* give back our USB minor number */
-	usb_deregister_dev (1, cp->dtindex);
+	usb_deregister_dev (cp->dtindex);
 
 	/* Stop the interrupt endpoint */
 	auerswald_int_release (cp);
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/misc/brlvger.c linux-2.5.66-cdev4/drivers/usb/misc/brlvger.c
--- linux-2.5.66-cdev3/drivers/usb/misc/brlvger.c	2003-03-25 10:46:55.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/misc/brlvger.c	2003-03-25 11:02:53.000000000 +0100
@@ -312,7 +312,7 @@ brlvger_probe (struct usb_interface *int
 
 	down(&reserve_sem);
 
-	retval = usb_register_dev(&brlvger_fops, BRLVGER_MINOR, 1, &i);
+	retval = usb_register_dev(&brlvger_fops, BRLVGER_MINOR, &i);
 	if (retval) {
 		err("Not able to get a minor for this device.");
 		goto error;
@@ -421,7 +421,7 @@ brlvger_disconnect(struct usb_interface 
 		info("Display %d disconnecting", priv->subminor);
 
 		devfs_unregister(priv->devfs);
-		usb_deregister_dev(1, priv->subminor);
+		usb_deregister_dev(priv->subminor);
 
 		down(&disconnect_sem);
 		display_table[priv->subminor] = NULL;
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/misc/rio500.c linux-2.5.66-cdev4/drivers/usb/misc/rio500.c
--- linux-2.5.66-cdev3/drivers/usb/misc/rio500.c	2003-03-25 10:46:55.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/misc/rio500.c	2003-03-25 11:02:53.000000000 +0100
@@ -454,7 +454,7 @@ static int probe_rio(struct usb_interfac
 
 	info("USB Rio found at address %d", dev->devnum);
 
-	retval = usb_register_dev(&usb_rio_fops, RIO_MINOR, 1, &rio->minor);
+	retval = usb_register_dev(&usb_rio_fops, RIO_MINOR, &rio->minor);
 	if (retval) {
 		err("Not able to get a minor for this device.");
 		return -ENOMEM;
@@ -497,7 +497,7 @@ static void disconnect_rio(struct usb_in
 	usb_set_intfdata (intf, NULL);
 	if (rio) {
 		devfs_unregister(rio->devfs);
-		usb_deregister_dev(1, rio->minor);
+		usb_deregister_dev(rio->minor);
 
 		down(&(rio->lock));
 		if (rio->isopen) {
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/misc/usblcd.c linux-2.5.66-cdev4/drivers/usb/misc/usblcd.c
--- linux-2.5.66-cdev3/drivers/usb/misc/usblcd.c	2003-03-11 10:57:40.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/misc/usblcd.c	2003-03-25 11:02:53.000000000 +0100
@@ -268,7 +268,7 @@ static int probe_lcd(struct usb_interfac
 		(i & 0xF000)>>12,(i & 0xF00)>>8,(i & 0xF0)>>4,(i & 0xF),
 		dev->devnum);
 
-	retval = usb_register_dev(&usb_lcd_fops, USBLCD_MINOR, 1, &lcd->minor);
+	retval = usb_register_dev(&usb_lcd_fops, USBLCD_MINOR, &lcd->minor);
 	if (retval) {
 		err("Not able to get a minor for this device.");
 		return -ENOMEM;
@@ -300,7 +300,7 @@ static void disconnect_lcd(struct usb_in
 
 	usb_set_intfdata (intf, NULL);
 	if (lcd) {
-		usb_deregister_dev(1, lcd->minor);
+		usb_deregister_dev(lcd->minor);
 
 		if (lcd->isopen) {
 			lcd->isopen = 0;
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/drivers/usb/usb-skeleton.c linux-2.5.66-cdev4/drivers/usb/usb-skeleton.c
--- linux-2.5.66-cdev3/drivers/usb/usb-skeleton.c	2003-03-25 10:46:53.000000000 +0100
+++ linux-2.5.66-cdev4/drivers/usb/usb-skeleton.c	2003-03-25 11:02:53.000000000 +0100
@@ -520,7 +520,7 @@ static int skel_probe(struct usb_interfa
 		return -ENODEV;
 	}
 
-	retval = usb_register_dev (&skel_fops, USB_SKEL_MINOR_BASE, 1, &minor);
+	retval = usb_register_dev (&skel_fops, USB_SKEL_MINOR_BASE, &minor);
 	if (retval) {
 		/* something prevented us from registering this driver */
 		err ("Not able to get a minor for this device.");
@@ -628,7 +628,7 @@ error:
 	dev = NULL;
 
 exit_minor:
-	usb_deregister_dev (1, minor);
+	usb_deregister_dev (minor);
 
 exit:
 	if (dev) {
@@ -675,7 +675,7 @@ static void skel_disconnect(struct usb_i
 	devfs_unregister (dev->devfs);
 
 	/* give back our dynamic minor */
-	usb_deregister_dev (1, minor);
+	usb_deregister_dev (minor);
 
 	/* terminate an ongoing write */
 	if (atomic_read (&dev->write_busy)) {
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/fs/proc/proc_tty.c linux-2.5.66-cdev4/fs/proc/proc_tty.c
--- linux-2.5.66-cdev3/fs/proc/proc_tty.c	2002-10-31 16:11:06.000000000 +0100
+++ linux-2.5.66-cdev4/fs/proc/proc_tty.c	2003-03-25 12:23:33.000000000 +0100
@@ -14,8 +14,6 @@
 #include <linux/tty.h>
 #include <asm/bitops.h>
 
-extern struct tty_ldisc ldiscs[];
-
 
 static int tty_drivers_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data);
@@ -35,61 +33,64 @@ static int tty_drivers_read_proc(char *p
 {
 	int	len = 0;
 	off_t	begin = 0;
+	struct tty_major *m;
 	struct tty_driver *p;
 	char	range[20], deftype[20];
 	char	*type;
 
-	list_for_each_entry(p, &tty_drivers, tty_drivers) {
-		if (p->num > 1)
-			sprintf(range, "%d-%d", p->minor_start,
-				p->minor_start + p->num - 1);
-		else
-			sprintf(range, "%d", p->minor_start);
-		switch (p->type) {
-		case TTY_DRIVER_TYPE_SYSTEM:
-			if (p->subtype == SYSTEM_TYPE_TTY)
-				type = "system:/dev/tty";
-			else if (p->subtype == SYSTEM_TYPE_SYSCONS)
-				type = "system:console";
-			else if (p->subtype == SYSTEM_TYPE_CONSOLE)
-				type = "system:vtmaster";
-			else
-				type = "system";
-			break;
-		case TTY_DRIVER_TYPE_CONSOLE:
-			type = "console";
-			break;
-		case TTY_DRIVER_TYPE_SERIAL:
-			if (p->subtype == 2)
-				type = "serial:callout";
+	list_for_each_entry(m, &tty_majors, list) {
+		list_for_each_entry(p, &m->drivers, tty_drivers) {
+			if (p->num > 1)
+				sprintf(range, "%d-%d", p->minor_start,
+					p->minor_start + p->num - 1);
 			else
-				type = "serial";
-			break;
-		case TTY_DRIVER_TYPE_PTY:
-			if (p->subtype == PTY_TYPE_MASTER)
-				type = "pty:master";
-			else if (p->subtype == PTY_TYPE_SLAVE)
-				type = "pty:slave";
-			else
-				type = "pty";
-			break;
-		default:
-			sprintf(deftype, "type:%d.%d", p->type, p->subtype);
-			type = deftype;
-			break;
-		}
-		len += sprintf(page+len, "%-20s /dev/%-8s %3d %7s %s\n",
-			       p->driver_name ? p->driver_name : "unknown",
-			       p->name, p->major, range, type);
-		if (len+begin > off+count)
-			break;
-		if (len+begin < off) {
-			begin += len;
-			len = 0;
+				sprintf(range, "%d", p->minor_start);
+			switch (p->type) {
+			case TTY_DRIVER_TYPE_SYSTEM:
+				if (p->subtype == SYSTEM_TYPE_TTY)
+					type = "system:/dev/tty";
+				else if (p->subtype == SYSTEM_TYPE_SYSCONS)
+					type = "system:console";
+				else if (p->subtype == SYSTEM_TYPE_CONSOLE)
+					type = "system:vtmaster";
+				else
+					type = "system";
+				break;
+			case TTY_DRIVER_TYPE_CONSOLE:
+				type = "console";
+				break;
+			case TTY_DRIVER_TYPE_SERIAL:
+				if (p->subtype == 2)
+					type = "serial:callout";
+				else
+					type = "serial";
+				break;
+			case TTY_DRIVER_TYPE_PTY:
+				if (p->subtype == PTY_TYPE_MASTER)
+					type = "pty:master";
+				else if (p->subtype == PTY_TYPE_SLAVE)
+					type = "pty:slave";
+				else
+					type = "pty";
+				break;
+			default:
+				sprintf(deftype, "type:%d.%d", p->type, p->subtype);
+				type = deftype;
+				break;
+			}
+			len += sprintf(page+len, "%-20s /dev/%-8s %3d %7s %s\n",
+				       p->driver_name ? p->driver_name : "unknown",
+				       p->name, p->major, range, type);
+			if (len+begin > off+count)
+				goto done;
+			if (len+begin < off) {
+				begin += len;
+				len = 0;
+			}
 		}
 	}
-	if (!p)
-		*eof = 1;
+	*eof = 1;
+done:
 	if (off >= len+begin)
 		return 0;
 	*start = page + (off-begin);
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/include/linux/tty_driver.h linux-2.5.66-cdev4/include/linux/tty_driver.h
--- linux-2.5.66-cdev3/include/linux/tty_driver.h	2003-02-05 10:42:18.000000000 +0100
+++ linux-2.5.66-cdev4/include/linux/tty_driver.h	2003-03-25 12:23:47.000000000 +0100
@@ -175,7 +175,13 @@ struct tty_driver {
 	struct list_head tty_drivers;
 };
 
-extern struct list_head tty_drivers;
+struct tty_major {
+	struct list_head list;
+	struct list_head drivers;
+};
+
+extern struct list_head tty_majors;
+extern struct tty_ldisc ldiscs[];
 
 /* tty driver magic number */
 #define TTY_DRIVER_MAGIC		0x5402
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev3/include/linux/usb.h linux-2.5.66-cdev4/include/linux/usb.h
--- linux-2.5.66-cdev3/include/linux/usb.h	2003-03-18 10:54:56.000000000 +0100
+++ linux-2.5.66-cdev4/include/linux/usb.h	2003-03-25 11:02:53.000000000 +0100
@@ -440,8 +440,8 @@ extern struct bus_type usb_bus_type;
 extern int usb_register(struct usb_driver *);
 extern void usb_deregister(struct usb_driver *);
 
-extern int usb_register_dev(struct file_operations *fops, int minor, int num_minors, int *start_minor);
-extern void usb_deregister_dev(int num_minors, int start_minor);
+extern int usb_register_dev(struct file_operations *fops, int minor, int *start_minor);
+extern void usb_deregister_dev(int minor);
 
 extern int usb_device_probe(struct device *dev);
 extern int usb_device_remove(struct device *dev);

