Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVBKAMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVBKAMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 19:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVBKAMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 19:12:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28823 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261960AbVBKALr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 19:11:47 -0500
Date: Thu, 10 Feb 2005 16:11:44 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: USB 2.4.30: fix modem_run
Message-ID: <20050210161144.708cb96f@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I entered a patch which adds "exclusive_access" lock into 2.4.29, to fix
devices which cannot handle simultaneous accesses. This caused a regression
with European ADSL modems. An ioctl USBDEVFS_REAPURB allows a process to enter
the kernel and wait for USB I/O to finish. Naturally, this should not take
exclusive_access, or nothing will ever finish.

This patch is essentially the patch by Sergey Vlasov with my additions
a) to allow ENOTTY returned without taking a lock and b) to filter ENOIOCTLCMD,
which is improper to leak to userspace.

diff -urpN -X dontdiff linux-2.4.30-pre1/drivers/usb/devio.c linux-2.4.30-pre1-usb/drivers/usb/devio.c
--- linux-2.4.30-pre1/drivers/usb/devio.c	2004-11-22 23:04:18.000000000 -0800
+++ linux-2.4.30-pre1-usb/drivers/usb/devio.c	2005-02-10 11:18:08.000000000 -0800
@@ -1132,6 +1132,8 @@ static int proc_ioctl (struct dev_state 
 			/* ifno might usefully be passed ... */
                        retval = driver->ioctl (ps->dev, ctrl.ioctl_code, buf);
 			/* size = min_t(int, size, retval)? */
+			if (retval == -ENOIOCTLCMD)
+				retval = -ENOTTY;
                }
 	}
 
@@ -1146,24 +1148,10 @@ static int proc_ioctl (struct dev_state 
 	return retval;
 }
 
-static int usbdev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int usbdev_ioctl_exclusive(struct dev_state *ps, struct inode *inode,
+				  unsigned int cmd, unsigned long arg)
 {
-	struct dev_state *ps = (struct dev_state *)file->private_data;
-	int ret = -ENOIOCTLCMD;
-
-	if (!(file->f_mode & FMODE_WRITE))
-		return -EPERM;
-	down_read(&ps->devsem);
-	if (!ps->dev) {
-		up_read(&ps->devsem);
-		return -ENODEV;
-	}
-
-	/*
-	 * grab device's exclusive_access mutex to prevent its driver from
-	 * using this device while it is being accessed by us.
-	 */
-	down(&ps->dev->exclusive_access);
+	int ret;
 
 	switch (cmd) {
 	case USBDEVFS_CONTROL:
@@ -1194,14 +1182,6 @@ static int usbdev_ioctl(struct inode *in
 			inode->i_mtime = CURRENT_TIME;
 		break;
 
-	case USBDEVFS_GETDRIVER:
-		ret = proc_getdriver(ps, (void *)arg);
-		break;
-
-	case USBDEVFS_CONNECTINFO:
-		ret = proc_connectinfo(ps, (void *)arg);
-		break;
-
 	case USBDEVFS_SETINTERFACE:
 		ret = proc_setintf(ps, (void *)arg);
 		break;
@@ -1220,6 +1200,53 @@ static int usbdev_ioctl(struct inode *in
 		ret = proc_unlinkurb(ps, (void *)arg);
 		break;
 
+	case USBDEVFS_CLAIMINTERFACE:
+		ret = proc_claiminterface(ps, (void *)arg);
+		break;
+
+	case USBDEVFS_RELEASEINTERFACE:
+		ret = proc_releaseinterface(ps, (void *)arg);
+		break;
+
+	case USBDEVFS_IOCTL:
+		ret = proc_ioctl(ps, (void *) arg);
+		break;
+
+	default:
+		ret = -ENOTTY;
+	}
+	return ret;
+}
+
+static int usbdev_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	struct dev_state *ps = file->private_data;
+	int ret;
+
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EPERM;
+	down_read(&ps->devsem);
+	if (!ps->dev) {
+		up_read(&ps->devsem);
+		return -ENODEV;
+	}
+
+	/*
+	 * Some ioctls don't touch the device and can be called without
+	 * grabbing its exclusive_access mutex; they are handled in this
+	 * switch.  Other ioctls which need exclusive_access are handled in
+	 * usbdev_ioctl_exclusive().
+	 */
+	switch (cmd) {
+	case USBDEVFS_GETDRIVER:
+		ret = proc_getdriver(ps, (void *)arg);
+		break;
+
+	case USBDEVFS_CONNECTINFO:
+		ret = proc_connectinfo(ps, (void *)arg);
+		break;
+
 	case USBDEVFS_REAPURB:
 		ret = proc_reapurb(ps, (void *)arg);
 		break;
@@ -1232,19 +1259,28 @@ static int usbdev_ioctl(struct inode *in
 		ret = proc_disconnectsignal(ps, (void *)arg);
 		break;
 
+	case USBDEVFS_CONTROL:
+	case USBDEVFS_BULK:
+	case USBDEVFS_RESETEP:
+	case USBDEVFS_RESET:
+	case USBDEVFS_CLEAR_HALT:
+	case USBDEVFS_SETINTERFACE:
+	case USBDEVFS_SETCONFIGURATION:
+	case USBDEVFS_SUBMITURB:
+	case USBDEVFS_DISCARDURB:
 	case USBDEVFS_CLAIMINTERFACE:
-		ret = proc_claiminterface(ps, (void *)arg);
-		break;
-
 	case USBDEVFS_RELEASEINTERFACE:
-		ret = proc_releaseinterface(ps, (void *)arg);
-		break;
-
 	case USBDEVFS_IOCTL:
-		ret = proc_ioctl(ps, (void *) arg);
+		ret = -ERESTARTSYS;
+		if (down_interruptible(&ps->dev->exclusive_access) == 0) {
+			ret = usbdev_ioctl_exclusive(ps, inode, cmd, arg);
+			up(&ps->dev->exclusive_access);
+		}
 		break;
+
+	default:
+		ret = -ENOTTY;
 	}
-	up(&ps->dev->exclusive_access);
 	up_read(&ps->devsem);
 	if (ret >= 0)
 		inode->i_atime = CURRENT_TIME;
