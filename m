Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269181AbUI3ViY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbUI3ViY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269506AbUI3ViY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:38:24 -0400
Received: from peabody.ximian.com ([130.57.169.10]:20932 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269181AbUI3ViQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:38:16 -0400
Subject: [patch] inotify: ioctl makeover
From: Robert Love <rml@ximian.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096410792.4365.3.camel@vertex>
References: <1096410792.4365.3.camel@vertex>
Content-Type: multipart/mixed; boundary="=-fOxlxga1NEdAkg6lyJ8k"
Date: Thu, 30 Sep 2004 17:36:53 -0400
Message-Id: <1096580213.4203.70.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fOxlxga1NEdAkg6lyJ8k
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached patch greatly cleans up inotify's ioctl method.  Oh my.

Net loss of 36 lines.

Main thing is removing all of the access_ok() checks and _IOC macros.
We don't need them.  We can just fall off the end of the switch and
return -EINVAL if the cmd does not match.  Any other access control is
handled by the device node itself or the copy_from_user() calls.

Also, other misc. changes.

Patch is on top of 0.11.0.

Best,

	Robert Love


--=-fOxlxga1NEdAkg6lyJ8k
Content-Disposition: attachment; filename=inotify-0.11.0-rml-ioctl-cleanup-1.patch
Content-Type: text/x-patch; name=inotify-0.11.0-rml-ioctl-cleanup-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

inotify, not your mom's notify, gets an ioctl makeover

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   66 +++++++++++--------------------------------------
 1 files changed, 15 insertions(+), 51 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-30 16:53:45.223669616 -0400
+++ linux/drivers/char/inotify.c	2004-09-30 17:30:17.283425880 -0400
@@ -920,73 +920,37 @@
 static int inotify_ioctl(struct inode *ip, struct file *fp,
 			 unsigned int cmd, unsigned long arg)
 {
-	int err;
 	struct inotify_device *dev;
 	struct inotify_watch_request request;
+	void __user *p;
 	int wd;
 
 	dev = fp->private_data;
-	err = 0;
-
-	if (_IOC_TYPE(cmd) != INOTIFY_IOCTL_MAGIC)
-		return -EINVAL;
-	if (_IOC_NR(cmd) > INOTIFY_IOCTL_MAXNR)
-		return -EINVAL;
-
-	if (_IOC_DIR(cmd) & _IOC_READ)
-		err = !access_ok(VERIFY_READ, (void *) arg, _IOC_SIZE(cmd));
-
-	if (err) {
-		err = -EFAULT;
-		goto out;
-	}
-
-	if (_IOC_DIR(cmd) & _IOC_WRITE)
-		err = !access_ok(VERIFY_WRITE, (void *)arg, _IOC_SIZE(cmd));
-
-	if (err) {
-		err = -EFAULT;
-		goto out;
-	}
-
-	err = -EINVAL;
+	p = (void __user *) arg;
 
 	switch (cmd) {
 	case INOTIFY_WATCH:
 		iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_WATCH ioctl\n");
-		if (copy_from_user(&request, (void *) arg,
-				sizeof(struct inotify_watch_request))) {
-			err = -EFAULT;
-			goto out;
-		}
-		err = inotify_watch(dev, &request);
-		break;
+		if (copy_from_user(&request, p, sizeof (request)))
+			return -EFAULT;
+		return inotify_watch(dev, &request);
 	case INOTIFY_IGNORE:
 		iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_IGNORE ioctl\n");
-		if (copy_from_user(&wd, (void *)arg, sizeof (int))) {
-			err = -EFAULT;
-			goto out;
-		}
-		err = inotify_ignore(dev, wd);
-		break;
+		if (copy_from_user(&wd, p, sizeof (wd)))
+			return -EFAULT;
+		return inotify_ignore(dev, wd);
 	case INOTIFY_STATS:
 		iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_STATS ioctl\n");
 		inotify_print_stats(dev);
-		err = 0;
-		break;
+		return 0;
 	case INOTIFY_SETDEBUG:
-		iprintk(INOTIFY_DEBUG_ERRORS,
-			"INOTIFY_SETDEBUG ioctl\n");
-		if (copy_from_user(&inotify_debug_flags, (void *) arg,
-				sizeof (int))) {
-			err = -EFAULT;
-			goto out;
-		}
-		break;
+		iprintk(INOTIFY_DEBUG_ERRORS, "INOTIFY_SETDEBUG ioctl\n");
+		if (copy_from_user(&inotify_debug_flags, p, sizeof (int)))
+			return -EFAULT;
+		return 0;
+	default:
+		return -EINVAL;
 	}
-
-out:
-	return err;
 }
 
 static struct file_operations inotify_fops = {

--=-fOxlxga1NEdAkg6lyJ8k--

