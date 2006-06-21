Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWFUT4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWFUT4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWFUT4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:56:46 -0400
Received: from ns1.suse.de ([195.135.220.2]:9905 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030234AbWFUTtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:24 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/22] [PATCH] TTY: return class device pointer from tty_register_device()
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:48 -0700
Message-Id: <11509191781796-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1150919175882-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hansjoerg Lipp <hjlipp@web.de>

Let tty_register_device() return a pointer to the class device it creates.
This allows registrants to add their own sysfs files under the class
device node.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/tty_io.c |   11 +++++++----
 include/linux/tty.h   |    4 +++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index a88b94a..8b2a599 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -2961,12 +2961,14 @@ static struct class *tty_class;
  *	This field is optional, if there is no known struct device for this
  *	tty device it can be set to NULL safely.
  *
+ * Returns a pointer to the class device (or ERR_PTR(-EFOO) on error).
+ *
  * This call is required to be made to register an individual tty device if
  * the tty driver's flags have the TTY_DRIVER_NO_DEVFS bit set.  If that
  * bit is not set, this function should not be called.
  */
-void tty_register_device(struct tty_driver *driver, unsigned index,
-			 struct device *device)
+struct class_device *tty_register_device(struct tty_driver *driver,
+					 unsigned index, struct device *device)
 {
 	char name[64];
 	dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
@@ -2974,7 +2976,7 @@ void tty_register_device(struct tty_driv
 	if (index >= driver->num) {
 		printk(KERN_ERR "Attempt to register invalid tty line number "
 		       " (%d).\n", index);
-		return;
+		return ERR_PTR(-EINVAL);
 	}
 
 	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
@@ -2984,7 +2986,8 @@ void tty_register_device(struct tty_driv
 		pty_line_name(driver, index, name);
 	else
 		tty_line_name(driver, index, name);
-	class_device_create(tty_class, NULL, dev, device, "%s", name);
+
+	return class_device_create(tty_class, NULL, dev, device, "%s", name);
 }
 
 /**
diff --git a/include/linux/tty.h b/include/linux/tty.h
index e898eeb..cb35ca5 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -290,7 +290,9 @@ extern int tty_register_ldisc(int disc, 
 extern int tty_unregister_ldisc(int disc);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
-extern void tty_register_device(struct tty_driver *driver, unsigned index, struct device *dev);
+extern struct class_device *tty_register_device(struct tty_driver *driver,
+						unsigned index,
+						struct device *dev);
 extern void tty_unregister_device(struct tty_driver *driver, unsigned index);
 extern int tty_read_raw_data(struct tty_struct *tty, unsigned char *bufp,
 			     int buflen);
-- 
1.4.0

