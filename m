Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVDYVma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVDYVma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVDYVma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:42:30 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:42162 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S261225AbVDYVhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:37:24 -0400
To: William Park <opengeometry@yahoo.ca>
Cc: Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, helge.hafting@hist.no
Subject: Re: rootdelay
References: <87wtrphuvj.fsf@dedasys.com> <424D929A.2030801@gentoo.org>
	<87pswjur3c.fsf@dedasys.com>
	<20050425144213.GA2293@node1.opengeometry.net>
From: davidw@dedasys.com (David N. Welton)
Date: 25 Apr 2005 23:34:23 +0200
Message-ID: <87acnmee1s.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

William Park <opengeometry@yahoo.ca> writes:

> > > > was wondering if there were any interest in my own efforts in that
> > > > direction:
> > 
> > > > http://dedasys.com/freesoftware/patches/blkdev_wakeup.patch which

...

> > Thanks!  I don't wish to be a pest, but not having heard a "no",
> > I'll send another ping out.  Perhaps a simple description is
> > better than the patch for busy people:

> >     In init/do_mounts.c, mount_root does an interruptible_sleep_on
> >     a wait queue, and goes on about its business after
> >     register_blkdev in drivers/block/genhd.c does a
> >     wake_up_interruptible on it, so that mounting the root device
> >     happens exactly when it needs to, no sooner, no later, and
> >     doesn't depend on any fiddly timing issues.

> Post your patch to the list, and I'll get it from a newsgroup.

I sent the URL to the patch so as to avoid sending it around, but
since I don't know the etiquette of this list, I will attach the patch
for your perusal.

Thankyou once again,
-- 
David N. Welton
 - http://www.dedasys.com/davidw/

Apache, Linux, Tcl Consulting
 - http://www.dedasys.com/


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=blkdev_wakeup.patch

diff -ur -X dontdiff /usr/local/src/linux/arch/i386/kernel/reboot.c kernel/arch/i386/kernel/reboot.c
Only in /usr/local/src/linux/: config-2.6.5-1-686
Only in kernel/: do_mounts.patch
diff -ur -X dontdiff /usr/local/src/linux/drivers/block/genhd.c kernel/drivers/block/genhd.c
--- /usr/local/src/linux/drivers/block/genhd.c	2004-06-17 11:42:01.000000000 +0200
+++ kernel/drivers/block/genhd.c	2004-07-30 16:19:21.000000000 +0200
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
@@ -57,6 +62,47 @@
 	return len;
 }
 
+/*
+ *-----------------------------------------------------------------------------
+ *
+ * get_blkdevs --
+ *
+ * 	Returns an array of all the block device names.
+ *
+ *-----------------------------------------------------------------------------
+ */
+
+char **get_blkdevs(void)
+{
+    int i = 0;
+    int len = 0;
+    struct list_head *p;
+    char **names = NULL;
+    struct gendisk *sgp;
+    char buf[BDEVNAME_SIZE];
+
+    down_read(&block_subsys.rwsem);
+
+    list_for_each(p, &block_subsys.kset.list) {
+	len ++;
+    }
+
+    names = kmalloc(sizeof(char *) * len + 1, GFP_KERNEL);
+
+    list_for_each(p, &block_subsys.kset.list) {
+	sgp = list_entry(p, struct gendisk, kobj.entry);
+	names[i] = kmalloc(strlen(disk_name(sgp, 0, buf)), GFP_KERNEL);
+	strcpy(names[i], disk_name(sgp, 0, buf));
+	i ++;
+    }
+    names[i] = NULL;
+    up_read(&block_subsys.rwsem);
+
+    return names;
+}
+
+EXPORT_SYMBOL(get_blkdevs);
+
 int register_blkdev(unsigned int major, const char *name)
 {
 	struct blk_major_name **n, *p;
@@ -197,6 +243,11 @@
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
diff -ur -X dontdiff /usr/local/src/linux/drivers/isdn/hardware/mISDN/hfc_multi.c kernel/drivers/isdn/hardware/mISDN/hfc_multi.c
Only in kernel/drivers/scsi: #sd.c#
diff -ur -X dontdiff /usr/local/src/linux/drivers/scsi/sd.c kernel/drivers/scsi/sd.c
diff -ur -X dontdiff /usr/local/src/linux/drivers/usb/storage/usb.c kernel/drivers/usb/storage/usb.c
diff -ur -X dontdiff /usr/local/src/linux/include/asm-i386/mach-default/mach_reboot.h kernel/include/asm-i386/mach-default/mach_reboot.h
Only in kernel/include/linux: #list.h#
diff -ur -X dontdiff /usr/local/src/linux/include/linux/genhd.h kernel/include/linux/genhd.h
--- /usr/local/src/linux/include/linux/genhd.h	2004-04-26 15:08:54.000000000 +0200
+++ kernel/include/linux/genhd.h	2004-07-30 16:29:45.000000000 +0200
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
+extern char **get_blkdevs(void);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk);
diff -ur -X dontdiff /usr/local/src/linux/init/do_mounts.c kernel/init/do_mounts.c
--- /usr/local/src/linux/init/do_mounts.c	2004-05-19 10:22:22.000000000 +0200
+++ kernel/init/do_mounts.c	2004-07-30 16:32:26.000000000 +0200
@@ -11,6 +11,8 @@
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
 
+#include <linux/genhd.h>
+
 #include "do_mounts.h"
 
 extern int get_filesystem_list(char * buf);
@@ -350,8 +360,41 @@
 }
 #endif
 
+/*
+ *-----------------------------------------------------------------------------
+ *
+ * match_root_name --
+ *
+ * 	Returns 1 if the root_device_name appears amongst the list of
+ * 	block devices, 0 otherwise.
+ *
+ *-----------------------------------------------------------------------------
+ */
+
+static int __init match_root_name(void) {
+    char **names = NULL;
+    int i = 0;
+    int match = 0;
+
+    names = get_blkdevs();
+    while (names[i] != NULL) {
+	if (match == 0 && strncmp(names[i],
+				  root_device_name,
+				  strlen(names[i])) == 0) {
+	    match = 1;
+	    printk("Block device %s matches %s root_device_name, continuing\n",
+		   names[i], root_device_name);
+	}
+	kfree(names[i]);
+	i ++;
+    }
+    kfree(names);
+    return match;
+}
+
 void __init mount_root(void)
 {
+
 #ifdef CONFIG_ROOT_NFS
 	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
 		if (mount_nfs_root())
@@ -373,6 +416,14 @@
 			change_floppy("root floppy");
 	}
 #endif
+
+	/* Here, we wait for the root device to show up, or if it's
+	 * already there, we just go on. */
+	while (match_root_name() == 0) {
+	    printk("Waiting for root device to wake us up\n");
+	    interruptible_sleep_on(&disk_wait_h);
+	}
+
 	create_dev("/dev/root", ROOT_DEV, root_device_name);
 	mount_block_root("/dev/root", root_mountflags);
 }
diff -ur -X dontdiff /usr/local/src/linux/init/main.c kernel/init/main.c
--- /usr/local/src/linux/init/main.c	2004-06-17 11:42:42.000000000 +0200
+++ kernel/init/main.c	2004-07-30 11:43:48.000000000 +0200
@@ -44,6 +44,11 @@
 #include <linux/unistd.h>
 #include <linux/rmap.h>
 
+#include <linux/genhd.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+
+
 #include <asm/io.h>
 #include <asm/bugs.h>
 
diff -ur -X dontdiff /usr/local/src/linux/kernel/printk.c kernel/kernel/printk.c
diff -ur -X dontdiff /usr/local/src/linux/kernel/sys.c kernel/kernel/sys.c

--=-=-=--
