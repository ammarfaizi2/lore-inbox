Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267432AbUHDWJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267432AbUHDWJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267455AbUHDWJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:09:49 -0400
Received: from smtp-4.hut.fi ([130.233.228.94]:33156 "EHLO smtp-4.hut.fi")
	by vger.kernel.org with ESMTP id S267432AbUHDWJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:09:24 -0400
Date: Thu, 5 Aug 2004 01:09:21 +0300 (EEST)
From: Heikki Linnakangas <hlinnaka@iki.fi>
X-X-Sender: hlinnaka@kosh.hut.fi
To: linux-kernel@vger.kernel.org
cc: davidw@dedasys.com
Subject: Re: [PATCH] speedy boot from usb devices
Message-ID: <Pine.OSF.4.60.0408050051240.412680@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (smtp-4.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David N. Welton wrote:
> where you can get blkdev_wakeup.patch
> 
>         Works like so: whenever a block device comes on line, it
>         signals this fact to a wait queue, so that the init process
>         can stop and wait for slow devices, in particular things such
>         as USB storage devices, which are much slower than IDE
>         devices.  The init process checks the list of available
>         devices and compares it with the desired root device, and if
>         there is a match, proceeds with the initialization process,
>         secure in the knowledge that the device in question has been
>         brought up.  This is useful if one wants to boot quickly from
>         a USB storage device without a trimmed-down kernel, and
>         without going through the whole initrd slog.

I tried the patch, it looks good to me in principle. Thanks! However, it 
didn't work for me :(.

The problem seems to be that the wait is too late. I start my kernel with 
"root=/dev/sda1", and that is parsed to major/minor numbers in the 
name_to_dev_t function which is in turn called by prepare_namespace. The 
call to name_to_dev_t returns 0 because the device isn't attached yet, 
and the mount fails later because of that.

The obvious solution is to move the wait earlier in the chain. Here's a 
modified patch that works for me. I also eliminated the get_blkdevs and 
match_root stuff, and rely on name_to_dev_t succeeding or failing instead.

This is still not perfect. It doesn't work correctly if you try to give 
the major/minor numbers directly in the kernel command line, as 
in "root=8:1". I guess the final solution would be to retry the whole 
mount process from the call to name_to_dev to a successful mount every 
time we get woke up by the wait queue.

- Heikki

[Please CC replies]


diff -ru --exclude='.*' linux-2.6.8-rc2-mm1-orig/drivers/block/genhd.c linux-2.6.8-rc2-mm1/drivers/block/genhd.c
--- linux-2.6.8-rc2-mm1-orig/drivers/block/genhd.c	2004-08-04 23:37:56.000000000 +0300
+++ linux-2.6.8-rc2-mm1/drivers/block/genhd.c	2004-08-04 23:51:09.000000000 +0300
@@ -14,9 +14,14 @@
  #include <linux/slab.h>
  #include <linux/kmod.h>
  #include <linux/kobj_map.h>
+#include <linux/wait.h>
+#include <linux/sched.h>

  #define MAX_PROBE_HASH 255	/* random */

+DECLARE_WAIT_QUEUE_HEAD(disk_wait_h);
+EXPORT_SYMBOL(disk_wait_h);
+
  static struct subsystem block_subsys;

  /*
@@ -197,6 +202,11 @@
  			    disk->minors, NULL, exact_match, exact_lock, disk);
  	register_disk(disk);
  	blk_register_queue(disk);
+
+	/* Wake up queue in init/main.c. */
+	printk("Waking up queue on %s\n",
+	       disk->disk_name);
+	wake_up_interruptible(&disk_wait_h);
  }

  EXPORT_SYMBOL(add_disk);
diff -ru --exclude='.*' linux-2.6.8-rc2-mm1-orig/include/linux/genhd.h linux-2.6.8-rc2-mm1/include/linux/genhd.h
--- linux-2.6.8-rc2-mm1-orig/include/linux/genhd.h	2004-08-04 23:40:29.000000000 +0300
+++ linux-2.6.8-rc2-mm1/include/linux/genhd.h	2004-08-05 00:02:53.543231776 +0300
@@ -16,6 +16,10 @@
  #include <linux/smp.h>
  #include <linux/string.h>
  #include <linux/fs.h>
+#include <linux/wait.h>
+
+/* Wait queue to wait on disks coming online. */
+extern wait_queue_head_t disk_wait_h;

  enum {
  /* These three have identical behaviour; use the second one if DOS FDISK gets
diff -ru --exclude='.*' linux-2.6.8-rc2-mm1-orig/init/do_mounts.c linux-2.6.8-rc2-mm1/init/do_mounts.c
--- linux-2.6.8-rc2-mm1-orig/init/do_mounts.c	2004-06-16 08:19:13.000000000 +0300
+++ linux-2.6.8-rc2-mm1/init/do_mounts.c	2004-08-04 23:07:23.000000000 +0300
@@ -11,6 +11,8 @@
  #include <linux/nfs_fs_sb.h>
  #include <linux/nfs_mount.h>

+#include <linux/genhd.h>
+
  #include "do_mounts.h"

  extern int get_filesystem_list(char * buf);
@@ -390,7 +392,14 @@

  	if (saved_root_name[0]) {
  		root_device_name = saved_root_name;
-		ROOT_DEV = name_to_dev_t(root_device_name);
+
+		/* Here, we wait for the root device to show up, or if it's
+		 * already there, we just go on. */
+		while ((ROOT_DEV = name_to_dev_t(root_device_name)) == 0) {
+			printk("Waiting for root device to wake us up\n");
+			interruptible_sleep_on(&disk_wait_h);
+		}
+
  		if (strncmp(root_device_name, "/dev/", 5) == 0)
  			root_device_name += 5;
  	}
