Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264259AbTCXP63>; Mon, 24 Mar 2003 10:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264260AbTCXP63>; Mon, 24 Mar 2003 10:58:29 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:26892 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264259AbTCXP60>; Mon, 24 Mar 2003 10:58:26 -0500
Date: Mon, 24 Mar 2003 17:09:21 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Christoph Hellwig <hch@infradead.org>
cc: Andries Brouwer <aebr@win.tue.nl>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
In-Reply-To: <20030324150458.A19789@infradead.org>
Message-ID: <Pine.LNX.4.44.0303241701150.5042-100000@serv>
References: <Pine.LNX.4.44.0303240023420.9053-100000@serv>
 <20030324142515.GA10462@win.tue.nl> <20030324150458.A19789@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Mar 2003, Christoph Hellwig wrote:

> If you look at Roman's patches they don't even hinder your dev_t enlargement
> but they provide a singificant benefit.   Now I'm personally not yet
> completly happy with his interface either because he still uses the
> major/minor split, but I'm working on fixing this properly.

BTW I have an updated patch, which stores the major char_device at 
(0,major), so the remaining space is free for whatever you need.
Below is a patch which shows how drivers/usb/core/file.c could look 
after this. There are of course further cleanups possible. :)

bye, Roman

diff -Nurp -X /home/roman/nodiff linux-2.5.65-bk4-cdev3/drivers/usb/core/file.c linux-2.5.65-bk4-cdev4/drivers/usb/core/file.c
--- linux-2.5.65-bk4-cdev3/drivers/usb/core/file.c	2003-03-24 10:26:47.000000000 +0100
+++ linux-2.5.65-bk4-cdev4/drivers/usb/core/file.c	2003-03-24 14:13:37.000000000 +0100
@@ -32,41 +32,9 @@ devfs_handle_t usb_devfs_handle;	/* /dev
 EXPORT_SYMBOL(usb_devfs_handle);
 
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
@@ -107,12 +75,9 @@ void usb_major_cleanup(void)
  * device, and 0 on success, alone with a value that the driver should
  * use in start_minor.
  */
-int usb_register_dev (struct file_operations *fops, int minor, int num_minors, int *start_minor)
+int usb_register_dev (struct file_operations *fops, int minor, int *start_minor)
 {
 	int i;
-	int j;
-	int good_spot;
-	int retval = -EINVAL;
 
 #ifdef CONFIG_USB_DYNAMIC_MINORS
 	/* 
@@ -123,37 +88,29 @@ int usb_register_dev (struct file_operat
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
+				start_minor = i;
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
 
@@ -169,16 +126,21 @@ EXPORT_SYMBOL(usb_register_dev);
  * 
  * This should be called by all drivers that use the USB major number.
  */
-void usb_deregister_dev (int num_minors, int start_minor)
+void usb_deregister_dev (int minor)
 {
 	int i;
 
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
 

