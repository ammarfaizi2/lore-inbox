Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946546AbWKAFwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946546AbWKAFwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946530AbWKAFwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:52:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:27584 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1945946AbWKAFvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:51:44 -0500
Message-Id: <20061101054629.573680000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:41 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 61/61] usbfs: private mutex for open, release, and remove
Content-Disposition: inline; filename=usbfs-private-mutex-for-open-release-and-remove.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Alan Stern <stern@rowland.harvard.edu>

The usbfs code doesn't provide sufficient mutual exclusion among open,
release, and remove.  Release vs. remove is okay because they both
acquire the device lock, but open is not exclusive with either one.  All
three routines modify the udev->filelist linked list, so they must not
run concurrently.

Apparently someone gave this a minimum amount of thought in the past by
explicitly acquiring the BKL at the start of the usbdev_open routine.
Oddly enough, there's a comment pointing out that locking is unnecessary
because chrdev_open already has acquired the BKL.

But this ignores the point that the files in /proc/bus/usb/* are not
char device files; they are regular files and so they don't get any
special locking.  Furthermore it's necessary to acquire the same lock in
the release and remove routines, which the code does not do.

Yet another problem arises because the same file_operations structure is
accessible through both the /proc/bus/usb/* and /dev/usb/usbdev* file
nodes.  Even when one of them has been removed, it's still possible for
userspace to open the other.  So simple locking around the individual
remove routines is insufficient; we need to lock the entire
usb_notify_remove_device notifier chain.

Rather than rely on the BKL, this patch (as723) introduces a new private
mutex for the purpose.  Holding the BKL while invoking a notifier chain
doesn't seem like a good idea.


Cc: Dave Jones <davej@redhat.com>
[https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=212952]
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/usb/core/devio.c  |   26 +++++++++++++++-----------
 drivers/usb/core/notify.c |    3 +++
 drivers/usb/core/usb.h    |    1 +
 3 files changed, 19 insertions(+), 11 deletions(-)

--- linux-2.6.18.1.orig/drivers/usb/core/devio.c
+++ linux-2.6.18.1/drivers/usb/core/devio.c
@@ -59,6 +59,9 @@
 #define USB_DEVICE_MAX			USB_MAXBUS * 128
 static struct class *usb_device_class;
 
+/* Mutual exclusion for removal, open, and release */
+DEFINE_MUTEX(usbfs_mutex);
+
 struct async {
 	struct list_head asynclist;
 	struct dev_state *ps;
@@ -541,15 +544,13 @@ static int usbdev_open(struct inode *ino
 	struct dev_state *ps;
 	int ret;
 
-	/* 
-	 * no locking necessary here, as chrdev_open has the kernel lock
-	 * (still acquire the kernel lock for safety)
-	 */
+	/* Protect against simultaneous removal or release */
+	mutex_lock(&usbfs_mutex);
+
 	ret = -ENOMEM;
 	if (!(ps = kmalloc(sizeof(struct dev_state), GFP_KERNEL)))
-		goto out_nolock;
+		goto out;
 
-	lock_kernel();
 	ret = -ENOENT;
 	/* check if we are called from a real node or usbfs */
 	if (imajor(inode) == USB_DEVICE_MAJOR)
@@ -579,9 +580,8 @@ static int usbdev_open(struct inode *ino
 	list_add_tail(&ps->list, &dev->filelist);
 	file->private_data = ps;
  out:
-	unlock_kernel();
- out_nolock:
-        return ret;
+	mutex_unlock(&usbfs_mutex);
+	return ret;
 }
 
 static int usbdev_release(struct inode *inode, struct file *file)
@@ -591,7 +591,12 @@ static int usbdev_release(struct inode *
 	unsigned int ifnum;
 
 	usb_lock_device(dev);
+
+	/* Protect against simultaneous open */
+	mutex_lock(&usbfs_mutex);
 	list_del_init(&ps->list);
+	mutex_unlock(&usbfs_mutex);
+
 	for (ifnum = 0; ps->ifclaimed && ifnum < 8*sizeof(ps->ifclaimed);
 			ifnum++) {
 		if (test_bit(ifnum, &ps->ifclaimed))
@@ -600,9 +605,8 @@ static int usbdev_release(struct inode *
 	destroy_all_async(ps);
 	usb_unlock_device(dev);
 	usb_put_dev(dev);
-	ps->dev = NULL;
 	kfree(ps);
-        return 0;
+	return 0;
 }
 
 static int proc_control(struct dev_state *ps, void __user *arg)
--- linux-2.6.18.1.orig/drivers/usb/core/notify.c
+++ linux-2.6.18.1/drivers/usb/core/notify.c
@@ -50,8 +50,11 @@ void usb_notify_add_device(struct usb_de
 
 void usb_notify_remove_device(struct usb_device *udev)
 {
+	/* Protect against simultaneous usbfs open */
+	mutex_lock(&usbfs_mutex);
 	blocking_notifier_call_chain(&usb_notifier_list,
 			USB_DEVICE_REMOVE, udev);
+	mutex_unlock(&usbfs_mutex);
 }
 
 void usb_notify_add_bus(struct usb_bus *ubus)
--- linux-2.6.18.1.orig/drivers/usb/core/usb.h
+++ linux-2.6.18.1/drivers/usb/core/usb.h
@@ -59,6 +59,7 @@ static inline int is_active(struct usb_i
 extern const char *usbcore_name;
 
 /* usbfs stuff */
+extern struct mutex usbfs_mutex;
 extern struct usb_driver usbfs_driver;
 extern struct file_operations usbfs_devices_fops;
 extern struct file_operations usbfs_device_file_operations;

--
