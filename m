Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUI0RRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUI0RRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUI0RRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:17:11 -0400
Received: from peabody.ximian.com ([130.57.169.10]:42405 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266833AbUI0ROR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:14:17 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-Dns6AgQCIwl4iVNyno59"
Date: Mon, 27 Sep 2004 13:12:57 -0400
Message-Id: <1096305177.30503.65.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Dns6AgQCIwl4iVNyno59
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-26 at 22:02 -0400, John McCutchan wrote:

Hi, John.

> Announcing the release of inotify 0.10.0. 
> Attached is a patch to 2.6.8.1.

Attached patch addresses a few misc. issues that Andrew raised:

	- Get rid of INOTIFY_VERSION.  I agree with Andrew, once
	  inotify is in the kernel, version information like this
	  is worthless and thus shunned.

	- Just open code INOTIFY_DEV_TIMER_TIME.

	- Add comment re 'bitmask'

	- Don't typecast when assigning from a void *.

	- Misc. and minor coding style fixes

Best,

	Robert Love


--=-Dns6AgQCIwl4iVNyno59
Content-Disposition: attachment; filename=inotify-rml-misc-stuff-1.patch
Content-Type: text/x-patch; name=inotify-rml-misc-stuff-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   85 +++++++++++++++++++++++--------------------------
 1 files changed, 40 insertions(+), 45 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-27 12:44:54.778623320 -0400
+++ linux/drivers/char/inotify.c	2004-09-27 13:08:22.745579808 -0400
@@ -39,14 +39,10 @@
 #include <linux/writeback.h>
 #include <linux/inotify.h>
 
-#define INOTIFY_VERSION "0.10.0"
-
 #define MAX_INOTIFY_DEVS	  8	/* max open inotify devices */
 #define MAX_INOTIFY_DEV_WATCHERS  8192	/* max total watches */
 #define MAX_INOTIFY_QUEUED_EVENTS 256	/* max events queued on the dev*/
 
-#define INOTIFY_DEV_TIMER_TIME	  (jiffies + (HZ/4))
-
 static atomic_t watcher_count;
 static kmem_cache_t *watcher_cache;
 static kmem_cache_t *kevent_cache;
@@ -63,6 +59,9 @@
  *
  * For each inotify device, we need to keep track of the events queued on it,
  * a list of the inodes that we are watching, and so on.
+ *
+ * 'bitmask' holds one bit for each possible watcher descriptor: a set bit
+ * implies that the given WD is valid, unset implies it is not.
  */
 struct inotify_device {
 	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS/BITS_PER_LONG];
@@ -751,7 +750,7 @@
 	dev = (struct inotify_device *) data;
 
 	/* reset the timer */
-	mod_timer(&dev->timer, INOTIFY_DEV_TIMER_TIME);
+	mod_timer(&dev->timer, jiffies + (HZ/4));
 
 	/* wake up anyone blocked on the device */
 	if (inotify_dev_has_events(dev))
@@ -787,7 +786,7 @@
 
 	dev->timer.data = (unsigned long) dev;
 	dev->timer.function = inotify_dev_timer;
-	dev->timer.expires = INOTIFY_DEV_TIMER_TIME;
+	dev->timer.expires = jiffies + (HZ/4);
 
 	add_timer(&dev->timer);
 
@@ -821,7 +820,7 @@
 	if (file->private_data) {
 		struct inotify_device *dev;
 
-		dev = (struct inotify_device *) file->private_data;
+		dev = file->private_data;
 		del_timer_sync(&dev->timer);
 		inotify_release_all_watchers(dev);
 		inotify_release_all_events(dev);
@@ -953,7 +952,8 @@
 }
 
 static int inotify_ioctl(struct inode *ip, struct file *fp,
-			 unsigned int cmd, unsigned long arg) {
+			 unsigned int cmd, unsigned long arg)
+{
 	int err;
 	struct inotify_device *dev;
 	struct inotify_watch_request request;
@@ -985,40 +985,37 @@
 	err = -EINVAL;
 
 	switch (cmd) {
-		case INOTIFY_WATCH:
-			iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_WATCH ioctl\n");
-			if (copy_from_user(&request, (void *) arg,
-					sizeof(struct inotify_watch_request))) {
-				err = -EFAULT;
-				goto out;
-			}
-
-			err = inotify_watch(dev, &request);
-			break;
-		case INOTIFY_IGNORE:
-			iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_IGNORE ioctl\n");
-			if (copy_from_user(&wd, (void *)arg, sizeof (int))) {
-
-				err = -EFAULT;
-				goto out;
-			}
-
-			err = inotify_ignore(dev, wd);
-			break;
-		case INOTIFY_STATS:
-			iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_STATS ioctl\n");
-			inotify_print_stats(dev);
-			err = 0;
-			break;
-		case INOTIFY_SETDEBUG:
-			iprintk(INOTIFY_DEBUG_ERRORS,
-				"INOTIFY_SETDEBUG ioctl\n");
-			if (copy_from_user(&inotify_debug_flags, (void *) arg,
-					sizeof (int))) {
-				err = -EFAULT;
-				goto out;
-			}
-			break;
+	case INOTIFY_WATCH:
+		iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_WATCH ioctl\n");
+		if (copy_from_user(&request, (void *) arg,
+				sizeof(struct inotify_watch_request))) {
+			err = -EFAULT;
+			goto out;
+		}
+		err = inotify_watch(dev, &request);
+		break;
+	case INOTIFY_IGNORE:
+		iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_IGNORE ioctl\n");
+		if (copy_from_user(&wd, (void *)arg, sizeof (int))) {
+			err = -EFAULT;
+			goto out;
+		}
+		err = inotify_ignore(dev, wd);
+		break;
+	case INOTIFY_STATS:
+		iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_STATS ioctl\n");
+		inotify_print_stats(dev);
+		err = 0;
+		break;
+	case INOTIFY_SETDEBUG:
+		iprintk(INOTIFY_DEBUG_ERRORS,
+			"INOTIFY_SETDEBUG ioctl\n");
+		if (copy_from_user(&inotify_debug_flags, (void *) arg,
+				sizeof (int))) {
+			err = -EFAULT;
+			goto out;
+		}
+		break;
 	}
 
 out:
@@ -1040,7 +1037,6 @@
 	.fops	= &inotify_fops,
 };
 
-
 static int __init inotify_init(void)
 {
 	int ret;
@@ -1059,8 +1055,7 @@
 			sizeof(struct inotify_kernel_event), 0,
 			SLAB_PANIC, NULL, NULL);
 
-	printk(KERN_ALERT "inotify %s minor=%d\n", INOTIFY_VERSION,
-			inotify_device.minor);
+	printk(KERN_INFO "inotify init: minor=%d\n", inotify_device.minor);
 out:
 	return ret;
 }

--=-Dns6AgQCIwl4iVNyno59--

