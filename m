Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUHDWgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUHDWgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267485AbUHDWfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:35:50 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:19098 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S267481AbUHDWeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:34:44 -0400
To: Heikki Linnakangas <hlinnaka@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speedy boot from usb devices
References: <Pine.OSF.4.60.0408050051240.412680@kosh.hut.fi>
From: davidw@dedasys.com (David N. Welton)
Date: 05 Aug 2004 00:32:44 +0200
Message-ID: <87acxailf7.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heikki Linnakangas <hlinnaka@iki.fi> writes:

[ Please CC replies to me. ]

> I tried the patch, it looks good to me in principle. Thanks!
> However, it didn't work for me :(.

Yes, I wasn't able to test it on the devices I wanted to untill after
I released it.  Sorry 'bout that.

> The problem seems to be that the wait is too late. I start my kernel
> with "root=/dev/sda1", and that is parsed to major/minor numbers in
> the name_to_dev_t function which is in turn called by
> prepare_namespace. The call to name_to_dev_t returns 0 because the
> device isn't attached yet, and the mount fails later because of
> that.

Right.

> The obvious solution is to move the wait earlier in the
> chain. Here's a modified patch that works for me. I also eliminated
> the get_blkdevs and match_root stuff, and rely on name_to_dev_t
> succeeding or failing instead.

> This is still not perfect. It doesn't work correctly if you try to
> give the major/minor numbers directly in the kernel command line, as
> in "root=8:1". I guess the final solution would be to retry the
> whole mount process from the call to name_to_dev to a successful
> mount every time we get woke up by the wait queue.

We also need to consider 'rdev'ed devices (for lack of a better term)
where there is a "built-in" dev_t, but no name (afaik).

I like your use of name_to_dev_t, that seems maybe more efficient than
what I have even here.  In this version, I consider "built in" root
devices (and the patch works, too:-).

Hrm... maybe the best approach is to create the root_device_name if it
doesn't exist from the ROOT_DEV, if it does, and use that with
name_to_dev_t...

At this point I will probably have to wait till next week to look into
it further.

-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/

diff -ru linux-2.6.7/drivers/block/genhd.c hacked/drivers/block/genhd.c
--- linux-2.6.7/drivers/block/genhd.c	2004-06-16 07:19:22.000000000 +0200
+++ hacked/drivers/block/genhd.c	2004-08-04 18:26:32.000000000 +0200
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
@@ -57,6 +62,58 @@
 	return len;
 }
 
+/*
+ *-----------------------------------------------------------------------------
+ *
+ * blkdev_is_online --
+ *
+ * 	Checks whether a named device is online or not.  Returns 1 if
+ * 	it is, 0 if not.  name is NULL if we already have a root
+ * 	device 'built in' to the kernel, and we use rootdev to compare
+ * 	with, rather than comparing the strings.
+ *
+ *-----------------------------------------------------------------------------
+ */
+
+int blkdev_is_online(char *name, dev_t rootdev)
+{
+    char buf[BDEVNAME_SIZE];
+    char *devname = NULL;
+    int retval = 0;
+    int major = 0;
+    int minor = 0;
+    struct gendisk *sgp = NULL;
+    struct list_head *p;
+
+    major = MAJOR(rootdev);
+    minor = MINOR(rootdev);
+
+    down_read(&block_subsys.rwsem);
+    list_for_each(p, &block_subsys.kset.list) {
+	sgp = list_entry(p, struct gendisk, kobj.entry);
+	devname = disk_name(sgp, 0, buf);
+	if (name != NULL) {
+	    /* We have a name, use that for the comparison.  */
+	    if (strncmp(devname,
+			name,
+			strlen(devname)) == 0) {
+		retval = 1;
+		break;
+	    }
+	} else {
+	    /* Compare with device numbers. */
+	    if (sgp->major == major && sgp->first_minor == minor) {
+		retval = 1;
+		break;
+	    }
+	}
+    }
+    up_read(&block_subsys.rwsem);
+    return retval;
+}
+
+EXPORT_SYMBOL(blkdev_is_online);
+
 int register_blkdev(unsigned int major, const char *name)
 {
 	struct blk_major_name **n, *p;
@@ -197,6 +254,11 @@
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
Only in hacked/drivers/block: genhd.c~
diff -ru linux-2.6.7/include/linux/genhd.h hacked/include/linux/genhd.h
--- linux-2.6.7/include/linux/genhd.h	2004-06-16 07:18:59.000000000 +0200
+++ hacked/include/linux/genhd.h	2004-08-04 18:28:05.000000000 +0200
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
@@ -191,6 +195,7 @@
 
 extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
+extern int blkdev_is_online(char *name, dev_t rootdev);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk);
Only in hacked/include/linux: genhd.h~
diff -ru linux-2.6.7/init/do_mounts.c hacked/init/do_mounts.c
--- linux-2.6.7/init/do_mounts.c	2004-06-16 07:19:13.000000000 +0200
+++ hacked/init/do_mounts.c	2004-08-04 18:25:49.000000000 +0200
@@ -11,6 +11,8 @@
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
 
+#include <linux/genhd.h>
+
 #include "do_mounts.h"
 
 extern int get_filesystem_list(char * buf);
@@ -373,6 +375,34 @@
 			change_floppy("root floppy");
 	}
 #endif
+
+	/* Here, we wait for the root device to show up, or if it's
+	 * already there, we just go on. */
+
+	if (root_device_name != NULL) {
+	    /* Its name has been passed on the command line, so we
+	     * have to check it by name. */
+	    while (blkdev_is_online(root_device_name, 0) == 0) {
+		printk("Waiting for root device %s to wake us up\n",
+		       root_device_name);
+		interruptible_sleep_on(&disk_wait_h);
+	    }
+	    if (saved_root_name[0]) {
+		root_device_name = saved_root_name;
+		ROOT_DEV = name_to_dev_t(root_device_name);
+		if (strncmp(root_device_name, "/dev/", 5) == 0)
+		    root_device_name += 5;
+	    }
+	} else {
+	    /* No name, so we are going to have to check on it by ROOT_DEV. */
+	    while (blkdev_is_online(NULL, ROOT_DEV) == 0) {
+		printk("Waiting for root device %d:%d to wake us up\n",
+		       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
+		interruptible_sleep_on(&disk_wait_h);
+	    }
+	}
+
+
 	create_dev("/dev/root", ROOT_DEV, root_device_name);
 	mount_block_root("/dev/root", root_mountflags);
 }
@@ -393,6 +423,8 @@
 		ROOT_DEV = name_to_dev_t(root_device_name);
 		if (strncmp(root_device_name, "/dev/", 5) == 0)
 			root_device_name += 5;
+	} else {
+	    root_device_name = NULL;
 	}
 
 	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
Only in hacked/init: do_mounts.c~
