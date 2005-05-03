Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVECLOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVECLOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 07:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVECLOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 07:14:35 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:2120 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261459AbVECLNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 07:13:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=AFZkCJkBGsWkzE5gGaa5xXE78BFiFFCnKNS4IrgR7sUYm7pjD2gapI9k3S4moe0Vtdip1mLGHtuIVtqf0sXYPXaI8H2fYOmgCXIttX4HpWI+PU/n0NABW4IJVq89NKMuI4gDVYpyE06bSTIwXVZ9R7BInwxD8sJ0XhLRenVyQsw=
Message-ID: <9877cd6005050304131a74f7c1@mail.gmail.com>
Date: Tue, 3 May 2005 13:13:53 +0200
From: David Welton <davidnwelton@gmail.com>
Reply-To: David Welton <davidnwelton@gmail.com>
To: William Park <opengeometry@yahoo.ca>, Daniel Drake <dsd@gentoo.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, helge.hafting@hist.no
Subject: Re: rootdelay
Cc: "David N. Welton" <davidw@dedasys.com>, mdharm-usb@one-eyed-alien.net
In-Reply-To: <874qdkenqw.fsf@dedasys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13026_19549463.1115118833682"
References: <87wtrphuvj.fsf@dedasys.com> <424D929A.2030801@gentoo.org>
	 <87pswjur3c.fsf@dedasys.com>
	 <20050425144213.GA2293@node1.opengeometry.net>
	 <87acnmee1s.fsf@dedasys.com>
	 <20050429183411.GA1998@node1.opengeometry.net>
	 <874qdkenqw.fsf@dedasys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_13026_19549463.1115118833682
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Ok, I updated to 2.6.11.8, and indeed it does have problems that
> weren't there before - although in my case it can't mount the root
> partition because it's not quite ready yet.  In part, it seems to be
> caused by the fact that the USB start up sequence introduces a new
> thread that delays the scsi_host_scan by 5 seconds, which is long
> enough to cause problems.  I added some code to wait for not only the
> disk name to be online, but the partition, but even that doesn't seem
> to be quite enough.
=20
> Is there anyplace generic that could be hooked that will report when a
> device is actually online and ready to run?  Perhaps I was just lucky
> in the past with add_disk :-/

I "fixed" the problem by not letting storage_probe in storage/usb.c
finish until the scan_thread is done.  That doesn't seem elegant -
perhaps there is a better place to put the
wait_for_completion(&us->scsi_scan_done) call so that the scanning
thread can go off and do its thing, but will still be waited on where
it counts?

I am including a copy of the patch inline, as well as attaching it.  I
suspect that gmail will mangle the inline version some...

Thankyou,
Dave

diff -uprN -X dontdiff linux-2.6.11.8/drivers/block/genhd.c
linux-wakeup/drivers/block/genhd.c
--- linux-2.6.11.8/drivers/block/genhd.c=092005-04-30 03:27:21.000000000 +0=
200
+++ linux-wakeup/drivers/block/genhd.c=092005-05-02 19:22:13.000000000 +020=
0
@@ -14,9 +14,14 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/kobj_map.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
=20
 #define MAX_PROBE_HASH 255=09/* random */
=20
+DECLARE_WAIT_QUEUE_HEAD(disk_wait_h);
+EXPORT_SYMBOL(disk_wait_h);
+
 static struct subsystem block_subsys;
=20
 static DECLARE_MUTEX(block_subsys_sem);
@@ -58,6 +63,49 @@ int get_blkdev_list(char *p)
 }
 #endif
=20
+/*
+ * Returns an array of all the block device names and partitions.
+ */
+
+char **get_blkdevs(void)
+{
+=09int i =3D 0;
+=09int n =3D 0;
+=09int len =3D 0;
+=09struct list_head *p;
+=09char **names =3D NULL;
+=09struct gendisk *sgp;
+=09char buf[BDEVNAME_SIZE];
+
+=09down_read(&block_subsys.rwsem);
+=09
+=09list_for_each(p, &block_subsys.kset.list) {
+=09=09len ++;
+=09}
+=09
+=09names =3D kmalloc(sizeof(char *) * len + 1, GFP_KERNEL);
+
+=09list_for_each(p, &block_subsys.kset.list) {
+=09=09sgp =3D list_entry(p, struct gendisk, kobj.entry);
+=09=09names[i] =3D kmalloc(strlen(disk_name(sgp, 0, buf)), GFP_KERNEL);
+=09=09strcpy(names[i], disk_name(sgp, 0, buf));
+=09=09
+=09=09for (n =3D 0; n < sgp->minors - 1; n++) {
+=09=09=09struct hd_struct *hd =3D sgp->part[n];
+=09=09=09if (hd && hd->nr_sects) {
+=09=09=09=09names[i] =3D kmalloc(strlen(disk_name(sgp, n+1, buf)), GFP_KER=
NEL);
+=09=09=09=09strcpy(names[i], disk_name(sgp, n+1, buf));
+=09=09=09=09i ++;
+=09=09=09}
+=09=09}
+=09}
+=09names[i] =3D NULL;
+=09up_read(&block_subsys.rwsem);
+=09return names;
+}
+
+EXPORT_SYMBOL(get_blkdevs);
+
 int register_blkdev(unsigned int major, const char *name)
 {
 =09struct blk_major_name **n, *p;
@@ -192,6 +240,11 @@ void add_disk(struct gendisk *disk)
 =09=09=09    disk->minors, NULL, exact_match, exact_lock, disk);
 =09register_disk(disk);
 =09blk_register_queue(disk);
+
+=09/* Wake up queue in init/main.c. */
+=09printk("Waking up queue on %s\n",
+=09       disk->disk_name);
+=09wake_up_interruptible(&disk_wait_h);
 }
=20
 EXPORT_SYMBOL(add_disk);
diff -uprN -X dontdiff linux-2.6.11.8/drivers/usb/storage/usb.c
linux-wakeup/drivers/usb/storage/usb.c
--- linux-2.6.11.8/drivers/usb/storage/usb.c=092005-04-30 03:25:25.00000000=
0 +0200
+++ linux-wakeup/drivers/usb/storage/usb.c=092005-05-03 12:15:29.000000000 =
+0200
@@ -1009,6 +1009,7 @@ static int storage_probe(struct usb_inte
=20
 =09/* Start up the thread for delayed SCSI-device scanning */
 =09result =3D kernel_thread(usb_stor_scan_thread, us, CLONE_VM);
+
 =09if (result < 0) {
 =09=09printk(KERN_WARNING USB_STORAGE=20
 =09=09       "Unable to start the device-scanning thread\n");
@@ -1016,6 +1017,8 @@ static int storage_probe(struct usb_inte
 =09=09goto BadDevice;
 =09}
=20
+=09wait_for_completion(&us->scsi_scan_done);
+
 =09return 0;
=20
 =09/* We come here if there are any problems */
diff -uprN -X dontdiff linux-2.6.11.8/include/linux/genhd.h
linux-wakeup/include/linux/genhd.h
--- linux-2.6.11.8/include/linux/genhd.h=092005-04-30 03:24:13.000000000 +0=
200
+++ linux-wakeup/include/linux/genhd.h=092005-05-02 12:04:50.000000000 +020=
0
@@ -16,6 +16,10 @@
 #include <linux/smp.h>
 #include <linux/string.h>
 #include <linux/fs.h>
+#include <linux/wait.h>
+
+/* Wait queue to wait on disks coming online. */
+extern wait_queue_head_t disk_wait_h;
=20
 enum {
 /* These three have identical behaviour; use the second one if DOS FDISK g=
ets
@@ -232,6 +236,7 @@ extern struct gendisk *get_gendisk(dev_t
=20
 extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
+extern char **get_blkdevs(void);
=20
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk);
diff -uprN -X dontdiff linux-2.6.11.8/init/do_mounts.c
linux-wakeup/init/do_mounts.c
--- linux-2.6.11.8/init/do_mounts.c=092005-04-30 03:26:32.000000000 +0200
+++ linux-wakeup/init/do_mounts.c=092005-05-02 19:22:51.000000000 +0200
@@ -12,6 +12,8 @@
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
=20
+#include <linux/genhd.h>
+
 #include "do_mounts.h"
=20
 extern int get_filesystem_list(char * buf);
@@ -360,8 +362,35 @@ void __init change_floppy(char *fmt, ...
 }
 #endif
=20
+/*
+ * match_root_name - Returns 1 if the root_device_name appears amongst
+ * the list of block devices, 0 otherwise.
+ */
+
+static int __init match_root_name(void) {
+=09char **names =3D NULL;
+=09int i =3D 0;
+=09int match =3D 0;
+=09
+=09names =3D get_blkdevs();
+=09while (names[i] !=3D NULL) {
+=09=09if (match =3D=3D 0 && strncmp(names[i],
+=09=09=09=09=09  root_device_name,
+=09=09=09=09=09  strlen(root_device_name)) =3D=3D 0) {
+=09=09=09match =3D 1;
+=09=09=09printk("Block device %s matches %s root_device_name, continuing\n=
",
+=09=09=09       names[i], root_device_name);
+=09=09}
+=09=09kfree(names[i]);
+=09=09i ++;
+=09}
+=09kfree(names);
+=09return match;
+}
+
 void __init mount_root(void)
 {
+
 #ifdef CONFIG_ROOT_NFS
 =09if (MAJOR(ROOT_DEV) =3D=3D UNNAMED_MAJOR) {
 =09=09if (mount_nfs_root())
@@ -383,6 +412,14 @@ void __init mount_root(void)
 =09=09=09change_floppy("root floppy");
 =09}
 #endif
+
+=09/* Here, we wait for the root device to show up, or if it's
+=09 * already there, we just go on. */
+=09while (!match_root_name()) {
+=09=09printk("Waiting for root device to wake us up\n");
+=09=09interruptible_sleep_on(&disk_wait_h);
+=09}
+=20
 =09create_dev("/dev/root", ROOT_DEV, root_device_name);
 =09mount_block_root("/dev/root", root_mountflags);
 }
diff -uprN -X dontdiff linux-2.6.11.8/init/main.c linux-wakeup/init/main.c
--- linux-2.6.11.8/init/main.c=092005-04-30 03:24:18.000000000 +0200
+++ linux-wakeup/init/main.c=092005-05-02 12:04:50.000000000 +0200
@@ -47,6 +47,11 @@
 #include <linux/mempolicy.h>
 #include <linux/key.h>
=20
+#include <linux/genhd.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+
+
 #include <asm/io.h>
 #include <asm/bugs.h>
 #include <asm/setup.h>

------=_Part_13026_19549463.1115118833682
Content-Type: text/x-patch; name=blkdev_wakeup.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="blkdev_wakeup.patch"

diff -uprN -X dontdiff linux-2.6.11.8/drivers/block/genhd.c linux-wakeup/drivers/block/genhd.c
--- linux-2.6.11.8/drivers/block/genhd.c	2005-04-30 03:27:21.000000000 +0200
+++ linux-wakeup/drivers/block/genhd.c	2005-05-02 19:22:13.000000000 +0200
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
 
 static DECLARE_MUTEX(block_subsys_sem);
@@ -58,6 +63,49 @@ int get_blkdev_list(char *p)
 }
 #endif
 
+/*
+ * Returns an array of all the block device names and partitions.
+ */
+
+char **get_blkdevs(void)
+{
+	int i = 0;
+	int n = 0;
+	int len = 0;
+	struct list_head *p;
+	char **names = NULL;
+	struct gendisk *sgp;
+	char buf[BDEVNAME_SIZE];
+
+	down_read(&block_subsys.rwsem);
+	
+	list_for_each(p, &block_subsys.kset.list) {
+		len ++;
+	}
+	
+	names = kmalloc(sizeof(char *) * len + 1, GFP_KERNEL);
+
+	list_for_each(p, &block_subsys.kset.list) {
+		sgp = list_entry(p, struct gendisk, kobj.entry);
+		names[i] = kmalloc(strlen(disk_name(sgp, 0, buf)), GFP_KERNEL);
+		strcpy(names[i], disk_name(sgp, 0, buf));
+		
+		for (n = 0; n < sgp->minors - 1; n++) {
+			struct hd_struct *hd = sgp->part[n];
+			if (hd && hd->nr_sects) {
+				names[i] = kmalloc(strlen(disk_name(sgp, n+1, buf)), GFP_KERNEL);
+				strcpy(names[i], disk_name(sgp, n+1, buf));
+				i ++;
+			}
+		}
+	}
+	names[i] = NULL;
+	up_read(&block_subsys.rwsem);
+	return names;
+}
+
+EXPORT_SYMBOL(get_blkdevs);
+
 int register_blkdev(unsigned int major, const char *name)
 {
 	struct blk_major_name **n, *p;
@@ -192,6 +240,11 @@ void add_disk(struct gendisk *disk)
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
diff -uprN -X dontdiff linux-2.6.11.8/drivers/usb/storage/usb.c linux-wakeup/drivers/usb/storage/usb.c
--- linux-2.6.11.8/drivers/usb/storage/usb.c	2005-04-30 03:25:25.000000000 +0200
+++ linux-wakeup/drivers/usb/storage/usb.c	2005-05-03 12:15:29.000000000 +0200
@@ -1009,6 +1009,7 @@ static int storage_probe(struct usb_inte
 
 	/* Start up the thread for delayed SCSI-device scanning */
 	result = kernel_thread(usb_stor_scan_thread, us, CLONE_VM);
+
 	if (result < 0) {
 		printk(KERN_WARNING USB_STORAGE 
 		       "Unable to start the device-scanning thread\n");
@@ -1016,6 +1017,8 @@ static int storage_probe(struct usb_inte
 		goto BadDevice;
 	}
 
+	wait_for_completion(&us->scsi_scan_done);
+
 	return 0;
 
 	/* We come here if there are any problems */
diff -uprN -X dontdiff linux-2.6.11.8/include/linux/genhd.h linux-wakeup/include/linux/genhd.h
--- linux-2.6.11.8/include/linux/genhd.h	2005-04-30 03:24:13.000000000 +0200
+++ linux-wakeup/include/linux/genhd.h	2005-05-02 12:04:50.000000000 +0200
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
@@ -232,6 +236,7 @@ extern struct gendisk *get_gendisk(dev_t
 
 extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
+extern char **get_blkdevs(void);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk);
diff -uprN -X dontdiff linux-2.6.11.8/init/do_mounts.c linux-wakeup/init/do_mounts.c
--- linux-2.6.11.8/init/do_mounts.c	2005-04-30 03:26:32.000000000 +0200
+++ linux-wakeup/init/do_mounts.c	2005-05-02 19:22:51.000000000 +0200
@@ -12,6 +12,8 @@
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
 
+#include <linux/genhd.h>
+
 #include "do_mounts.h"
 
 extern int get_filesystem_list(char * buf);
@@ -360,8 +362,35 @@ void __init change_floppy(char *fmt, ...
 }
 #endif
 
+/*
+ * match_root_name - Returns 1 if the root_device_name appears amongst
+ * the list of block devices, 0 otherwise.
+ */
+
+static int __init match_root_name(void) {
+	char **names = NULL;
+	int i = 0;
+	int match = 0;
+	
+	names = get_blkdevs();
+	while (names[i] != NULL) {
+		if (match == 0 && strncmp(names[i],
+					  root_device_name,
+					  strlen(root_device_name)) == 0) {
+			match = 1;
+			printk("Block device %s matches %s root_device_name, continuing\n",
+			       names[i], root_device_name);
+		}
+		kfree(names[i]);
+		i ++;
+	}
+	kfree(names);
+	return match;
+}
+
 void __init mount_root(void)
 {
+
 #ifdef CONFIG_ROOT_NFS
 	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
 		if (mount_nfs_root())
@@ -383,6 +412,14 @@ void __init mount_root(void)
 			change_floppy("root floppy");
 	}
 #endif
+
+	/* Here, we wait for the root device to show up, or if it's
+	 * already there, we just go on. */
+	while (!match_root_name()) {
+		printk("Waiting for root device to wake us up\n");
+		interruptible_sleep_on(&disk_wait_h);
+	}
+ 
 	create_dev("/dev/root", ROOT_DEV, root_device_name);
 	mount_block_root("/dev/root", root_mountflags);
 }
diff -uprN -X dontdiff linux-2.6.11.8/init/main.c linux-wakeup/init/main.c
--- linux-2.6.11.8/init/main.c	2005-04-30 03:24:18.000000000 +0200
+++ linux-wakeup/init/main.c	2005-05-02 12:04:50.000000000 +0200
@@ -47,6 +47,11 @@
 #include <linux/mempolicy.h>
 #include <linux/key.h>
 
+#include <linux/genhd.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+
+
 #include <asm/io.h>
 #include <asm/bugs.h>
 #include <asm/setup.h>

------=_Part_13026_19549463.1115118833682--
