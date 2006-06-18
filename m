Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWFRPrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWFRPrn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWFRPrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:47:43 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751142AbWFRPrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:47:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=tSFckK3AXPzhRp6aqZASNuvMbxlcsB3OGjLyu1WRCk2BwB2ZdCyKY98qo0iecT1i/FhHXFarsJ09asrQVfJw1+vEzG1BdpBH5yBuK1gOJMFjrM26My88kDoh248G0t8AvBzz3ZenzslbbtueV9ptzyqPRM0JuLCsRcOoqkuZ6Wg=
Message-ID: <44956F1F.4030900@gmail.com>
Date: Sun, 18 Jun 2006 23:19:59 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: [PATCH 1/9] VT binding: Remove sysfs control from the tty layer
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove VT binding sysfs control from the tty layer. It will be added to the
VT layer instead.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

This is a revert of vt-binding-add-sysfs-support.patch

Tony

 drivers/char/tty_io.c |   53 +------------------------------------------------
 include/linux/tty.h   |   19 ------------------
 2 files changed, 1 insertions(+), 71 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index e23d360..a5730a6 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3231,47 +3231,6 @@ #ifdef CONFIG_VT
 static struct cdev vc0_cdev;
 #endif
 
-static ssize_t store_bind(struct class_device *class_device,
-			  const char *buf, size_t count)
-{
-	int index = simple_strtoul(buf, NULL, 0);
-
-	vt_bind(index);
-	return count;
-}
-
-static ssize_t store_unbind(struct class_device *class_device,
-			    const char *buf, size_t count)
-{
-	int index = simple_strtoul(buf, NULL, 0);
-
-	vt_unbind(index);
-	return count;
-}
-
-static ssize_t show_con_drivers(struct class_device *class_device, char *buf)
-{
-	return vt_show_drivers(buf);
-}
-
-static struct class_device_attribute class_device_attrs[] = {
-	__ATTR(bind,   S_IWUSR, NULL, store_bind),
-	__ATTR(unbind, S_IWUSR, NULL, store_unbind),
-	__ATTR(backend, S_IRUGO, show_con_drivers, NULL),
-};
-
-static struct class_device *console_class_device;
-
-static int console_init_class_device(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-		class_device_create_file(console_class_device,
-					 &class_device_attrs[i]);
-	return 0;
-}
-
 /*
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
@@ -3290,17 +3249,7 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
 		panic("Couldn't register /dev/console driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
-	console_class_device = class_device_create(tty_class, NULL,
-						   MKDEV(TTYAUX_MAJOR, 1),
-						   NULL, "console");
-	if (IS_ERR(console_class_device)) {
-		printk(KERN_WARNING "Unable to create class device "
-		       "for console; errno = %ldn",
-		       PTR_ERR(console_class_device));
-		console_class_device = NULL;
-	} else
-		console_init_class_device();
-
+	class_device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
 #ifdef CONFIG_UNIX98_PTYS
 	cdev_init(&ptmx_cdev, &ptmx_fops);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 3edaa5d..cb35ca5 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -347,25 +347,6 @@ extern void console_print(const char *);
 extern int vt_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg);
 
-#ifdef CONFIG_VT
-extern int vt_bind(int index);
-extern int vt_unbind(int index);
-extern int vt_show_drivers(char *buf);
-#else
-static inline int vt_bind(int index)
-{
-	return 0;
-}
-static inline int vt_unbind(int index)
-{
-	return 0;
-}
-static inline int vt_show_drivers(char *buf)
-{
-	return 0;
-}
-#endif
-
 static inline dev_t tty_devnum(struct tty_struct *tty)
 {
 	return MKDEV(tty->driver->major, tty->driver->minor_start) + tty->index;


