Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUB0Uma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbUB0Uma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:42:30 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:49319 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263095AbUB0Um2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:42:28 -0500
Date: Fri, 27 Feb 2004 18:36:47 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: torvalds@osdl.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty_io: Do not register NULL /dev entries on devfs
Message-ID: <Pine.LNX.4.58L.0402271831080.19454@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Faced this problem where "/dev/<NULL>x" entries got created while loading
the cyclades driver with devfs.

Several drivers do not set driver->devfs_name, so better skip registration
for those.

--- linux-2.6.3/drivers/char/tty_io.c.orig	2004-02-27 18:29:16.641482744 -0300
+++ linux-2.6.3/drivers/char/tty_io.c	2004-02-27 18:30:08.437608536 -0300
@@ -2099,7 +2099,8 @@
 		return;
 	}

-	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
+	if (driver->devfs_name)
+		devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
 			"%s%d", driver->devfs_name, index + driver->name_base);

 	/* we don't care about the ptys */
@@ -2121,7 +2122,8 @@
  */
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
-	devfs_remove("%s%d", driver->devfs_name, index + driver->name_base);
+	if (driver->devfs_name)
+		devfs_remove("%s%d", driver->devfs_name, index + driver->name_base);
 	class_simple_device_remove(MKDEV(driver->major, driver->minor_start) + index);
 }

