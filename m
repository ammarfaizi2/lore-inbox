Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbUDNKh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbUDNKh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:37:27 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:59304 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264030AbUDNKgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:36:55 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 2/9] USB usbfs: replace the per-file semaphore with the per-device semaphore
Date: Wed, 14 Apr 2004 12:36:52 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141236.52823.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 devio.c		|   43 +++++++++++++++++++++++--------------------
 usbdevice_fs.h	|    1 -
 2 files changed, 23 insertions(+), 21 deletions(-)


diff -Nru a/include/linux/usbdevice_fs.h b/include/linux/usbdevice_fs.h
--- a/include/linux/usbdevice_fs.h	Wed Apr 14 12:34:00 2004
+++ b/include/linux/usbdevice_fs.h	Wed Apr 14 12:34:00 2004
@@ -154,7 +154,6 @@
 
 struct dev_state {
 	struct list_head list;      /* state list */
-	struct rw_semaphore devsem; /* protects modifications to dev (dev == NULL indicating disconnect) */ 
 	struct usb_device *dev;
 	struct file *file;
 	spinlock_t lock;            /* protects the async urb lists */
diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Apr 14 12:17:29 2004
+++ b/drivers/usb/core/devio.c	Wed Apr 14 12:17:29 2004
@@ -92,14 +92,15 @@
 static ssize_t usbdev_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
 	struct dev_state *ps = (struct dev_state *)file->private_data;
+	struct usb_device *dev = ps->dev;
 	ssize_t ret = 0;
 	unsigned len;
 	loff_t pos;
 	int i;
 
 	pos = *ppos;
-	down_read(&ps->devsem);
-	if (!connected(ps->dev)) {
+	down(&dev->serialize);
+	if (!connected(dev)) {
 		ret = -ENODEV;
 		goto err;
 	} else if (pos < 0) {
@@ -111,7 +112,7 @@
 		len = sizeof(struct usb_device_descriptor) - pos;
 		if (len > nbytes)
 			len = nbytes;
-		if (copy_to_user(buf, ((char *)&ps->dev->descriptor) + pos, len)) {
+		if (copy_to_user(buf, ((char *)&dev->descriptor) + pos, len)) {
 			ret = -EFAULT;
 			goto err;
 		}
@@ -123,9 +124,9 @@
 	}
 
 	pos = sizeof(struct usb_device_descriptor);
-	for (i = 0; nbytes && i < ps->dev->descriptor.bNumConfigurations; i++) {
+	for (i = 0; nbytes && i < dev->descriptor.bNumConfigurations; i++) {
 		struct usb_config_descriptor *config =
-			(struct usb_config_descriptor *)ps->dev->rawdescriptors[i];
+			(struct usb_config_descriptor *)dev->rawdescriptors[i];
 		unsigned int length = le16_to_cpu(config->wTotalLength);
 
 		if (*ppos < pos + length) {
@@ -133,7 +134,7 @@
 			/* The descriptor may claim to be longer than it
 			 * really is.  Here is the actual allocated length. */
 			unsigned alloclen =
-				ps->dev->config[i].desc.wTotalLength;
+				dev->config[i].desc.wTotalLength;
 
 			len = length - (*ppos - pos);
 			if (len > nbytes)
@@ -143,7 +144,7 @@
 			if (alloclen > (*ppos - pos)) {
 				alloclen -= (*ppos - pos);
 				if (copy_to_user(buf,
-				    ps->dev->rawdescriptors[i] + (*ppos - pos),
+				    dev->rawdescriptors[i] + (*ppos - pos),
 				    min(len, alloclen))) {
 					ret = -EFAULT;
 					goto err;
@@ -160,7 +161,7 @@
 	}
 
 err:
-	up_read(&ps->devsem);
+	up(&dev->serialize);
 	return ret;
 }
 
@@ -521,7 +522,6 @@
 	INIT_LIST_HEAD(&ps->async_pending);
 	INIT_LIST_HEAD(&ps->async_completed);
 	init_waitqueue_head(&ps->wait);
-	init_rwsem(&ps->devsem);
 	ps->discsignr = 0;
 	ps->disctask = current;
 	ps->disccontext = NULL;
@@ -538,19 +538,20 @@
 static int usbdev_release(struct inode *inode, struct file *file)
 {
 	struct dev_state *ps = (struct dev_state *)file->private_data;
+	struct usb_device *dev = ps->dev;
 	unsigned int i;
 
-	lock_kernel();
+	down(&dev->serialize);
 	list_del_init(&ps->list);
 
-	if (connected(ps->dev)) {
+	if (connected(dev)) {
 		for (i = 0; ps->ifclaimed && i < 8*sizeof(ps->ifclaimed); i++)
 			if (test_bit(i, &ps->ifclaimed))
 				releaseintf(ps, i);
 		destroy_all_async(ps);
 	}
-	unlock_kernel();
-	usb_put_dev(ps->dev);
+	up(&dev->serialize);
+	usb_put_dev(dev);
 	ps->dev = NULL;
 	kfree(ps);
         return 0;
@@ -1017,18 +1018,19 @@
         DECLARE_WAITQUEUE(wait, current);
 	struct async *as = NULL;
 	void __user *addr;
+	struct usb_device *dev = ps->dev;
 	int ret;
 
 	add_wait_queue(&ps->wait, &wait);
-	while (connected(ps->dev)) {
+	while (connected(dev)) {
 		__set_current_state(TASK_INTERRUPTIBLE);
 		if ((as = async_getcompleted(ps)))
 			break;
 		if (signal_pending(current))
 			break;
-		up_read(&ps->devsem);
+		up(&dev->serialize);
 		schedule();
-		down_read(&ps->devsem);
+		down(&dev->serialize);
 	}
 	remove_wait_queue(&ps->wait, &wait);
 	set_current_state(TASK_RUNNING);
@@ -1195,13 +1197,14 @@
 static int usbdev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct dev_state *ps = (struct dev_state *)file->private_data;
+	struct usb_device *dev = ps->dev;
 	int ret = -ENOTTY;
 
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EPERM;
-	down_read(&ps->devsem);
-	if (!connected(ps->dev)) {
-		up_read(&ps->devsem);
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		up(&dev->serialize);
 		return -ENODEV;
 	}
 	switch (cmd) {
@@ -1283,7 +1286,7 @@
 		ret = proc_ioctl(ps, (void __user *) arg);
 		break;
 	}
-	up_read(&ps->devsem);
+	up(&dev->serialize);
 	if (ret >= 0)
 		inode->i_atime = CURRENT_TIME;
 	return ret;
