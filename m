Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUDORsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbUDORpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:45:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:26294 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263160AbUDORmO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:14 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509122054@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:52 -0700
Message-Id: <10820509121457@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.5, 2004/03/19 16:39:16-08:00, hannal@us.ibm.com

[PATCH] QIC-02 tape drive hookup to classes in sysfs

Here is a patch to hook up the qic02 tape device to have class
support in sysfs. I have verified it compiles. I do not have access to
the hardware to test. Could someone who does please verify?

 From the file:
 * This is a driver for the Wangtek 5150 tape drive with
 * a QIC-02 controller for ISA-PC type computers.
 * Hopefully it will work with other QIC-02 tape drives as well.


 drivers/char/tpqic02.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)


diff -Nru a/drivers/char/tpqic02.c b/drivers/char/tpqic02.c
--- a/drivers/char/tpqic02.c	Thu Apr 15 10:21:08 2004
+++ b/drivers/char/tpqic02.c	Thu Apr 15 10:21:08 2004
@@ -94,6 +94,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #include <asm/dma.h>
 #include <asm/system.h>
@@ -229,6 +230,8 @@
 	"600"			/* untested. */
 };
 
+static struct class_simple *tpqic02_class;
+
 
 /* `exception_list' is needed for exception status reporting.
  * Exceptions 1..14 are defined by QIC-02 rev F.
@@ -2696,23 +2699,32 @@
 		return -ENODEV;
 	}
 
+	tpqic02_class = class_simple_create(THIS_MODULE, TPQIC02_NAME);
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 2), NULL, "ntpqic11");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 2),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "ntpqic11");
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 3), NULL, "tpqic11");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 3),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "tpqic11");
 
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 4), NULL, "ntpqic24");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 4),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "ntpqic24");
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 5), NULL, "tpqic24");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 5),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "tpqic24");
 
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 6), NULL, "ntpqic20");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 6),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "ntpqic120");
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 7), NULL, "tpqic20");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 7),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "tpqic120");
 
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 8), NULL, "ntpqic50");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 8),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "ntpqic150");
+	class_simple_device_add(tpqic02_class, MKDEV(QIC02_TAPE_MAJOR, 9), NULL, "tpqic50");
 	devfs_mk_cdev(MKDEV(QIC02_TAPE_MAJOR, 9),
 		       S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP, "tpqic150");
 
@@ -2757,13 +2769,23 @@
 		qic02_release_resources();
 		
 	devfs_remove("ntpqic11");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 2));
 	devfs_remove("tpqic11");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 3));
 	devfs_remove("ntpqic24");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 4));
 	devfs_remove("tpqic24");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 5));
 	devfs_remove("ntpqic120");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 6));
 	devfs_remove("tpqic120");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 7));
 	devfs_remove("ntpqic150");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 8));
 	devfs_remove("tpqic150");
+	class_simple_device_remove(MKDEV(QIC02_TAPE_MAJOR, 9));
+
+	class_simple_destroy(tpqic02_class);
 }
 
 static int qic02_module_init(void)

