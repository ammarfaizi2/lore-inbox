Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbTFEWMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbTFEWMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:12:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30158 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265224AbTFEWMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:12:47 -0400
Date: Thu, 5 Jun 2003 15:28:23 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TTY changes for 2.5.70
Message-ID: <20030605222823.GD7717@kroah.com>
References: <20030605222731.GA7717@kroah.com> <20030605222753.GB7717@kroah.com> <20030605222806.GC7717@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605222806.GC7717@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315, 2003/06/05 15:19:41-07:00, greg@kroah.com

TTY: release function should be set in the class, not the class_device.


 drivers/char/tty_io.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Thu Jun  5 15:21:03 2003
+++ b/drivers/char/tty_io.c	Thu Jun  5 15:21:03 2003
@@ -2093,10 +2093,6 @@
 # define tty_unregister_devfs(driver, index)	do { } while (0)
 #endif /* CONFIG_DEVFS_FS */
 
-static struct class tty_class = {
-	.name	= "tty",
-};
-
 struct tty_dev {
 	struct list_head node;
 	dev_t dev;
@@ -2104,6 +2100,17 @@
 };
 #define to_tty_dev(d) container_of(d, struct tty_dev, class_dev)
 
+static void release_tty_dev(struct class_device *class_dev)
+{
+	struct tty_dev *tty_dev = to_tty_dev(class_dev);
+	kfree(tty_dev);
+}
+
+static struct class tty_class = {
+	.name		= "tty",
+	.release	= &release_tty_dev,
+};
+
 static LIST_HEAD(tty_dev_list);
 static spinlock_t tty_dev_list_lock = SPIN_LOCK_UNLOCKED;
 
@@ -2114,12 +2121,6 @@
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
-static void release_tty_dev(struct class_device *class_dev)
-{
-	struct tty_dev *tty_dev = to_tty_dev(class_dev);
-	kfree(tty_dev);
-}
-
 static void tty_add_class_device(char *name, dev_t dev, struct device *device)
 {
 	struct tty_dev *tty_dev = NULL;
@@ -2140,7 +2141,6 @@
 
 	tty_dev->class_dev.dev = device;
 	tty_dev->class_dev.class = &tty_class;
-	tty_dev->class_dev.release = &release_tty_dev;
 	snprintf(tty_dev->class_dev.class_id, BUS_ID_SIZE, "%s", temp);
 	retval = class_device_register(&tty_dev->class_dev);
 	if (retval)
