Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUDNK3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbUDNK3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:29:35 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:4748 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263616AbUDNK3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:29:31 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 1/9] USB usbfs: take a reference to the usb device
Date: Wed, 14 Apr 2004 12:29:26 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141229.26677.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, this is the first of a series of patches that replace the
per-file semaphore ps->devsem with the per-device semaphore
ps->dev->serialize.  The role of devsem was to protect against
device disconnection.  This can be done equally well using
ps->dev->serialize.  On the other hand, ps->dev->serialize
protects against configuration and other changes, and has
already been introduced into usbfs in several places.  Using
just one semaphore simplifies the code and removes some
remaining race conditions.  It should also fix the oopses some
people have been seeing.  In this first patch, a reference is
taken to the usb device as long as the usbfs file is open.  That
way we can use ps->dev->serialize for as long as ps exists.

 devio.c |   27 ++++++++++++++++-----------
 inode.c |    3 ---
 2 files changed, 16 insertions(+), 14 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Apr 14 12:15:29 2004
+++ b/drivers/usb/core/devio.c	Wed Apr 14 12:15:29 2004
@@ -60,6 +60,11 @@
 	struct urb *urb;
 };
 
+static inline int connected (struct usb_device *dev)
+{
+	return dev->state != USB_STATE_NOTATTACHED;
+}
+
 static loff_t usbdev_lseek(struct file *file, loff_t offset, int orig)
 {
 	loff_t ret;
@@ -94,7 +99,7 @@
 
 	pos = *ppos;
 	down_read(&ps->devsem);
-	if (!ps->dev) {
+	if (!connected(ps->dev)) {
 		ret = -ENODEV;
 		goto err;
 	} else if (pos < 0) {
@@ -343,8 +348,6 @@
 	 * all pending I/O requests; 2.6 does that.
 	 */
 
-	/* prevent new I/O requests */
-	ps->dev = 0;
 	clear_bit(intf->cur_altsetting->desc.bInterfaceNumber, &ps->ifclaimed);
 	usb_set_intfdata (intf, NULL);
 
@@ -365,7 +368,7 @@
 	struct usb_interface *iface;
 	int err;
 
-	if (intf >= 8*sizeof(ps->ifclaimed) || !dev
+	if (intf >= 8*sizeof(ps->ifclaimed)
 			|| intf >= dev->actconfig->desc.bNumInterfaces)
 		return -EINVAL;
 	/* already claimed */
@@ -506,7 +509,7 @@
 
 	lock_kernel();
 	ret = -ENOENT;
-	dev = inode->u.generic_ip;
+	dev = usb_get_dev(inode->u.generic_ip);
 	if (!dev) {
 		kfree(ps);
 		goto out;
@@ -540,13 +543,15 @@
 	lock_kernel();
 	list_del_init(&ps->list);
 
-	if (ps->dev) {
+	if (connected(ps->dev)) {
 		for (i = 0; ps->ifclaimed && i < 8*sizeof(ps->ifclaimed); i++)
 			if (test_bit(i, &ps->ifclaimed))
 				releaseintf(ps, i);
+		destroy_all_async(ps);
 	}
 	unlock_kernel();
-	destroy_all_async(ps);
+	usb_put_dev(ps->dev);
+	ps->dev = NULL;
 	kfree(ps);
         return 0;
 }
@@ -1015,7 +1020,7 @@
 	int ret;
 
 	add_wait_queue(&ps->wait, &wait);
-	while (ps->dev) {
+	while (connected(ps->dev)) {
 		__set_current_state(TASK_INTERRUPTIBLE);
 		if ((as = async_getcompleted(ps)))
 			break;
@@ -1125,7 +1130,7 @@
 		}
 	}
 
-	if (!ps->dev) {
+	if (!connected(ps->dev)) {
 		if (buf)
 			kfree(buf);
 		return -ENODEV;
@@ -1195,7 +1200,7 @@
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EPERM;
 	down_read(&ps->devsem);
-	if (!ps->dev) {
+	if (!connected(ps->dev)) {
 		up_read(&ps->devsem);
 		return -ENODEV;
 	}
@@ -1293,7 +1298,7 @@
 	poll_wait(file, &ps->wait, wait);
 	if (file->f_mode & FMODE_WRITE && !list_empty(&ps->async_completed))
 		mask |= POLLOUT | POLLWRNORM;
-	if (!ps->dev)
+	if (!connected(ps->dev))
 		mask |= POLLERR | POLLHUP;
 	return mask;
 }
diff -Nru a/drivers/usb/core/inode.c b/drivers/usb/core/inode.c
--- a/drivers/usb/core/inode.c	Wed Apr 14 12:15:29 2004
+++ b/drivers/usb/core/inode.c	Wed Apr 14 12:15:29 2004
@@ -717,9 +717,6 @@
 	while (!list_empty(&dev->filelist)) {
 		ds = list_entry(dev->filelist.next, struct dev_state, list);
 		list_del_init(&ds->list);
-		down_write(&ds->devsem);
-		ds->dev = NULL;
-		up_write(&ds->devsem);
 		if (ds->discsignr) {
 			sinfo.si_signo = SIGPIPE;
 			sinfo.si_errno = EPIPE;
