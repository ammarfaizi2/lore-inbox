Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUHYWuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUHYWuC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUHYWsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:48:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:35739 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266291AbUHYWhB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:37:01 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <1093473387435@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:27 -0700
Message-Id: <10934733873593@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1803.64.3, 2004/08/10 14:47:24-07:00, olh@suse.de

[PATCH] export legacy pty info via sysfs

You missed that one last year.


export the legacy pty/tty device nodes via sysfs,
so udev has a chance to create them if /dev is in tmpfs.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/tty_io.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	2004-08-25 14:56:56 -07:00
+++ b/drivers/char/tty_io.c	2004-08-25 14:56:56 -07:00
@@ -766,6 +766,17 @@
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
@@ -2170,6 +2181,7 @@
 void tty_register_device(struct tty_driver *driver, unsigned index,
 			 struct device *device)
 {
+	char name[64];
 	dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
 
 	if (index >= driver->num) {
@@ -2181,13 +2193,11 @@
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

