Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUHJPo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUHJPo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUHJPo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:44:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:24294 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266220AbUHJPoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:44:24 -0400
Date: Tue, 10 Aug 2004 15:54:02 +0200
From: Olaf Hering <olh@suse.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] export legacy pty info via sysfs
Message-ID: <20040810135402.GA5459@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You missed that one last year.


export the legacy pty/tty device nodes via sysfs,
so udev has a chance to create them if /dev is in tmpfs.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.8-rc4.orig/drivers/char/tty_io.c linux-2.6.8-rc4/drivers/char/tty_io.c
--- linux-2.6.8-rc4.orig/drivers/char/tty_io.c	2004-08-10 14:01:54.000000000 +0200
+++ linux-2.6.8-rc4/drivers/char/tty_io.c	2004-08-10 14:04:53.230532914 +0200
@@ -749,6 +749,17 @@ ssize_t redirected_tty_write(struct file
 	return tty_write(file, buf, count, ppos);
 }
 
+static char ptychar[] = "pqrstuvwxyzabcde";
+
+static inline void pty_line_name(struct tty_driver *driver, int index, char *p)
+{
+	int i = index + driver->name_base;
+	/* ->name is initialized to "ttyp", but "tty" is expected */
+	sprintf(p, "%s%c%x",
+			driver->subtype == PTY_TYPE_SLAVE ? "tty" : driver->name,
+			ptychar[i >> 4 & 0xf], i & 0xf);
+}
+
 static inline void tty_line_name(struct tty_driver *driver, int index, char *p)
 {
 	sprintf(p, "%s%d", driver->name, index + driver->name_base);
@@ -2154,6 +2165,7 @@ static struct class_simple *tty_class;
 void tty_register_device(struct tty_driver *driver, unsigned index,
 			 struct device *device)
 {
+	char name[64];
 	dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
 
 	if (index >= driver->num) {
@@ -2165,13 +2177,11 @@ void tty_register_device(struct tty_driv
 	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
 			"%s%d", driver->devfs_name, index + driver->name_base);
 
-	/* we don't care about the ptys */
-	/* how nice to hide this behind some crappy interface.. */
-	if (driver->type != TTY_DRIVER_TYPE_PTY) {
-		char name[64];
+	if (driver->type == TTY_DRIVER_TYPE_PTY)
+		pty_line_name(driver, index, name);
+	else
 		tty_line_name(driver, index, name);
-		class_simple_device_add(tty_class, dev, device, name);
-	}
+	class_simple_device_add(tty_class, dev, device, name);
 }
 
 /**

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
