Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTJUWCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTJUWCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:02:51 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:52751 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263423AbTJUWCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:02:23 -0400
Date: Tue, 21 Oct 2003 23:20:22 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.0-test8] MODULE_ALIAS_BLOCK
Message-ID: <20031021232022.A19672@banaan.localdomain>
Mail-Followup-To: Erik van Konijnenburg <ekonijn@xs4all.nl>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rusty,

Automatic loading of the loop device does not work under 2.6.0-test8
unless the loop device is explicitly mentioned in /etc/modules.conf.
This shows up when doing a kernel make install: mkinitrd uses the
loopback device.

This is because loop.c does not have MODULE_ALIAS_BLOCKDEV.
After adding that, the following problem shows: a mismatch between
the use of request_module in drivers/block/genhd.c:

	request_module("block-major-%d", MAJOR(dev));

and the definition of MODULE_ALIAS_BLOCK in blkdev.h:

	MODULE_ALIAS("block-major-" __stringify(major) "-*")

The following patch applies to 2.6.0-test8.  I tested under (mostly) RH9 that
automatic loading of loop.ko works with this patch but not without it.
The only other user of MODULE_ALIAS_BLOCK, floppy.c, also worked for
me with this patch, no idea whether it works without.

Regards,
Erik


diff -r -U3 2.6.0-test8/drivers/block/loop.c 2.6.0-test8-play/drivers/block/loop.c
--- 2.6.0-test8/drivers/block/loop.c	2003-10-18 10:01:44.000000000 +0200
+++ 2.6.0-test8-play/drivers/block/loop.c	2003-10-19 20:48:15.000000000 +0200
@@ -55,6 +55,7 @@
 #include <linux/errno.h>
 #include <linux/major.h>
 #include <linux/wait.h>
+#include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
@@ -1124,6 +1125,7 @@
 MODULE_PARM(max_loop, "i");
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
 int loop_register_transfer(struct loop_func_table *funcs)
 {
diff -r -U3 2.6.0-test8/include/linux/blkdev.h 2.6.0-test8-play/include/linux/blkdev.h
--- 2.6.0-test8/include/linux/blkdev.h	2003-10-18 10:00:05.000000000 +0200
+++ 2.6.0-test8-play/include/linux/blkdev.h	2003-10-19 22:52:04.000000000 +0200
@@ -678,7 +678,7 @@
 #define MODULE_ALIAS_BLOCKDEV(major,minor) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-" __stringify(minor))
 #define MODULE_ALIAS_BLOCKDEV_MAJOR(major) \
-	MODULE_ALIAS("block-major-" __stringify(major) "-*")
+	MODULE_ALIAS("block-major-" __stringify(major))
 
 
 #endif
