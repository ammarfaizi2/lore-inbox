Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbULMQOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbULMQOx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbULMQOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:14:53 -0500
Received: from main.gmane.org ([80.91.229.2]:7648 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261260AbULMQFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:05:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: [PATCH] ATA over Ethernet driver for 2.6.9 (with changes)
Date: Mon, 13 Dec 2004 11:04:51 -0500
Message-ID: <87k6rmuqu4.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:iMhPAf8/j/5WUyKaeFCPnpnFHqQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

I've implemented the changes suggested here for the AoE driver for
2.6.9.  Here's a list of changes since December 6 when the 2.6.9 patch
was first submitted.  Suggestions made by more than one person are
only listed once.

Greg KH suggestions:
  * tell sysfs about our char drivers with class_simple
  * don't use typedefs
  * use list.h macros instead of our queue manipulation functions
  * get rid of our getfields function
  * remove stacked if statements (a Bell Labs-ism)
  * comment ioctl: device node permissions should be restrictive
  * return -ENOTTY for unsupported ioctls
  * return apropos errors instead of -1 in char device operations
  * remove aoeutils.c and use in-kernel functionality
  * move example scripts into Documentation/aoe

Jan-Benedict Glaw suggestions:
  * move Kconfig entry into parent dir
  * use NULL instead of nil
  * use ARRAY_SIZE instead of our nelems macro
  * remove unused device path macros
  * use C99 struct initializers
  * use __init and __exit more

Arjan van de Ven suggestions:
  * remove u.h
  * use mempool allocation in make_request_fn
  * use bdev->bd_openers instead of our own nopen

Pekka Enberg suggestions:
  * name our header aoe.h
  * only include needed headers each .c file
  * split one enum according to meaning
  * eliminate unnecessary casts from void * to typed pointer


Provide support for ATA over Ethernet devices

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=patch-2.6.9-aoe-2

diff -urNp linux-2.6.9/Documentation/aoe/aoe.txt linux-2.6.9-aoe/Documentation/aoe/aoe.txt
--- linux-2.6.9/Documentation/aoe/aoe.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/Documentation/aoe/aoe.txt	2004-12-13 10:53:18.000000000 -0500
@@ -0,0 +1,59 @@
+The EtherDrive (R) HOWTO for users of 2.6 kernels is found at ...
+
+  http://www.coraid.com/support/linux/EtherDrive-2.6-HOWTO.html
+
+  It has many tips and hints!
+
+CREATING DEVICE NODES
+
+  Users of udev should find device nodes created automatically.  Two
+  scripts are provided in Documentation/aoe as examples of static
+  device node creation for using the aoe driver.
+
+    rm -rf /dev/etherd
+    sh Documentation/aoe/mkdevs /dev/etherd
+
+  ... or to make just one shelf's worth of block device nodes ...
+
+    sh Documentation/aoe/mkshelf /dev/etherd 0
+
+  There is also an autoload script that shows how to edit
+  /etc/modprobe.conf to ensure that the aoe module is loaded when
+  necessary.
+
+USING DEVICE NODES
+
+  "cat /dev/etherd/stat" shows the status of discovered AoE devices on
+  your LAN:
+
+	root@nai root# cat /dev/etherd/stat
+	/dev/etherd/e15.3       eth0    up
+	/dev/etherd/e6.2        eth3    up
+	/dev/etherd/e6.4        eth3    up
+	/dev/etherd/e6.3        eth3    up
+	/dev/etherd/e6.9        eth3    up
+	/dev/etherd/e6.5        eth3    up
+	/dev/etherd/e6.7        eth3    up
+	/dev/etherd/e6.6        eth3    up
+	/dev/etherd/e6.8        eth3    up
+	/dev/etherd/e6.0        eth3    up
+	/dev/etherd/e6.1        eth3    up
+
+  "cat /dev/etherd/err" blocks, waiting for error diagnostic output,
+  like any retransmitted packets.
+
+  "echo interfaces eth2 eth4 > /dev/etherd/ctl" tells the aoe driver
+  to limit ATA over Ethernet traffic to eth2 and eth4.  AoE traffic
+  from untrusted networks should be ignored as a matter of security.
+
+  "echo discover > /dev/etherd/ctl" tells the driver to find out what
+  AoE devices are available.
+
+  The block devices are named like this:
+
+	e{shelf}.{slot}
+	e{shelf}.{slot}p{part}
+
+  ... so that "e0.2" is the third blade from the left (slot 2) in the
+  first shelf (shelf address zero).  That's the whole disk.  The first
+  partition on that disk would be "e0.2p1".
diff -urNp linux-2.6.9/Documentation/aoe/autoload linux-2.6.9-aoe/Documentation/aoe/autoload
--- linux-2.6.9/Documentation/aoe/autoload	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/Documentation/aoe/autoload	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,17 @@
+#!/bin/sh
+# set aoe to autoload by installing the
+# aliases in /etc/modprobe.conf
+
+f=/etc/modprobe.conf
+
+if test ! -r $f || test ! -w $f; then
+	echo "cannot configure $f for module autoloading" 1>&2
+	exit 1
+fi
+
+grep major-152 $f >/dev/null
+if [ $? = 1 ]; then
+	echo alias block-major-152 aoe >> $f
+	echo alias char-major-152 aoe >> $f
+fi
+
diff -urNp linux-2.6.9/Documentation/aoe/mkdevs linux-2.6.9-aoe/Documentation/aoe/mkdevs
--- linux-2.6.9/Documentation/aoe/mkdevs	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/Documentation/aoe/mkdevs	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+n_shelves=10
+
+if test "$#" != "1"; then
+	echo "Usage: mkdevs {dir}" 1>&2
+	exit 1
+fi
+dir=$1
+
+MAJOR=152
+
+echo "Creating AoE devnode files in $dir ..."
+
+set -e
+
+mkdir -p $dir
+
+rm -f $dir/ctl
+mknod -m 0200 $dir/ctl c $MAJOR 0
+rm -f $dir/stat
+mknod -m 0400 $dir/stat c $MAJOR 1
+rm -f $dir/err
+mknod -m 0400 $dir/err c $MAJOR 2
+
+i=0
+while test $i -lt $n_shelves; do
+	sh -xc "`dirname $0`/mkshelf $dir $i"
+	i=`expr $i + 1`
+done
diff -urNp linux-2.6.9/Documentation/aoe/mkshelf linux-2.6.9-aoe/Documentation/aoe/mkshelf
--- linux-2.6.9/Documentation/aoe/mkshelf	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/Documentation/aoe/mkshelf	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,23 @@
+#! /bin/sh
+
+if test "$#" != "2"; then
+	echo "Usage: mkshelf {dir} {shelfaddress}" 1>&2
+	exit 1
+fi
+dir=$1
+shelf=$2
+MAJOR=152
+
+set -e
+
+minor=`echo 10 \* $shelf \* 16 | bc`
+for slot in `seq 0 9`; do
+	for part in `seq 0 15`; do
+		name=e$shelf.$slot
+		test "$part" != "0" && name=${name}p$part
+		rm -f $dir/$name
+		mknod -m 0660 $dir/$name b $MAJOR $minor
+
+		minor=`expr $minor + 1`
+	done
+done
diff -urNp linux-2.6.9/MAINTAINERS linux-2.6.9-aoe/MAINTAINERS
--- linux-2.6.9/MAINTAINERS	2004-11-30 08:22:27.000000000 -0500
+++ linux-2.6.9-aoe/MAINTAINERS	2004-12-13 10:53:19.000000000 -0500
@@ -329,6 +329,12 @@ L:	linux-atm-general@lists.sourceforge.n
 W:	http://linux-atm.sourceforge.net
 S:	Maintained
 
+ATA OVER ETHERNET DRIVER
+P:	Ed L. Cashin
+M:	ecashin@coraid.com
+W:	http://www.coraid.com/support/linux
+S:	Supported
+
 ATMEL WIRELESS DRIVER
 P:	Simon Kelley
 M:	simon@thekelleys.org.uk
diff -urNp linux-2.6.9/drivers/Makefile linux-2.6.9-aoe/drivers/Makefile
--- linux-2.6.9/drivers/Makefile	2004-11-30 08:22:33.000000000 -0500
+++ linux-2.6.9-aoe/drivers/Makefile	2004-12-13 10:53:19.000000000 -0500
@@ -41,6 +41,7 @@ obj-$(CONFIG_DIO)		+= dio/
 obj-$(CONFIG_SBUS)		+= sbus/
 obj-$(CONFIG_ZORRO)		+= zorro/
 obj-$(CONFIG_MAC)		+= macintosh/
+obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
 obj-$(CONFIG_PARIDE) 		+= block/paride/
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
diff -urNp linux-2.6.9/drivers/block/Kconfig linux-2.6.9-aoe/drivers/block/Kconfig
--- linux-2.6.9/drivers/block/Kconfig	2004-11-30 08:22:33.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/Kconfig	2004-12-13 10:53:19.000000000 -0500
@@ -358,4 +358,12 @@ config LBD
 
 source "drivers/s390/block/Kconfig"
 
+config ATA_OVER_ETH
+	tristate "ATA over Ethernet support"
+	depends on NET
+	default m
+	help
+	This driver provides Support for ATA over Ethernet block
+	devices like the Coraid EtherDrive (R) Storage Blade.
+
 endmenu
diff -urNp linux-2.6.9/drivers/block/aoe/Makefile linux-2.6.9-aoe/drivers/block/aoe/Makefile
--- linux-2.6.9/drivers/block/aoe/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/Makefile	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,6 @@
+#
+# Makefile for ATA over Ethernet
+#
+
+obj-$(CONFIG_ATA_OVER_ETH)	+= aoe.o
+aoe-objs := aoeblk.o aoechr.o aoecmd.o aoedev.o aoemain.o aoenet.o
diff -urNp linux-2.6.9/drivers/block/aoe/aoe.h linux-2.6.9-aoe/drivers/block/aoe/aoe.h
--- linux-2.6.9/drivers/block/aoe/aoe.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoe.h	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,164 @@
+#define VER 3
+#define AOE_MAJOR 152
+#define MAX_ARGS 16
+#define DEVICE_NAME "aoe"
+#define DEVICE_NO_RANDOM
+#define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * 10 + (aoeminor))
+#define AOEMAJOR(sysminor) ((sysminor) / 10)
+#define AOEMINOR(sysminor) ((sysminor) % 10)
+#define WHITESPACE " \t\v\f\n"
+
+enum {
+	AOECMD_ATA,
+	AOECMD_CFG,
+
+	AOEFL_RSP = (1<<3),
+	AOEFL_ERR = (1<<2),
+
+	AOEAFL_EXT = (1<<6),
+	AOEAFL_DEV = (1<<4),
+	AOEAFL_ASYNC = (1<<1),
+	AOEAFL_WRITE = (1<<0),
+
+	AOECCMD_READ = 0,
+	AOECCMD_TEST,
+	AOECCMD_PTEST,
+	AOECCMD_SET,
+	AOECCMD_FSET,
+
+	AOE_HVER = 0x10,
+	ETH_P_AOE = 0x88a2,
+};
+
+struct Aoehdr {
+	unsigned char dst[6];
+	unsigned char src[6];
+	unsigned char type[2];
+	unsigned char verfl;
+	unsigned char err;
+	unsigned char major[2];
+	unsigned char minor;
+	unsigned char cmd;
+	unsigned char tag[4];
+};
+
+struct Aoeahdr {
+	unsigned char aflags;
+	unsigned char errfeat;
+	unsigned char scnt;
+	unsigned char cmdstat;
+	unsigned char lba0;
+	unsigned char lba1;
+	unsigned char lba2;
+	unsigned char lba3;
+	unsigned char lba4;
+	unsigned char lba5;
+	unsigned char res[2];
+};
+
+struct Aoechdr {
+	unsigned char bufcnt[2];
+	unsigned char fwver[2];
+	unsigned char res;
+	unsigned char aoeccmd;
+	unsigned char cslen[2];
+};
+
+enum {
+	DEVFL_UP = 1,	/* device is installed in system and ready for AoE->ATA commands */
+	DEVFL_TKILL = (1<<1),	/* flag for timer to know when to kill self */
+	DEVFL_EXT = (1<<2),	/* device accepts lba48 commands */
+	DEVFL_CLOSEWAIT = (1<<3), /* device is waiting for all closes to revalidate */
+	DEVFL_WC_UPDATE = (1<<4), /* this device needs to update write cache status */
+	DEVFL_WORKON = (1<<4),
+
+	BUFFL_FAIL = 1,
+};
+
+enum {
+	MAXATADATA = 1024,
+	NPERSHELF = 10,
+	FREETAG = -1,
+	MIN_BUFS = 8,
+};
+
+struct Buf {
+	struct list_head bufs;
+	ulong flags;
+	ulong nframesout;
+	char *bufaddr;
+	ulong resid;
+	ulong bv_resid;
+	sector_t sector;
+	struct bio *bio;
+	struct bio_vec *bv;
+};
+
+struct Frame {
+	int tag;
+	ulong waited;
+	struct Buf *buf;
+	char *bufaddr;
+	int writedatalen;
+	int ndata;
+
+	/* largest possible */
+	char data[sizeof(struct Aoehdr) + sizeof(struct Aoeahdr)];
+};
+
+struct Aoedev {
+	struct Aoedev *next;
+	unsigned char addr[6];	/* remote mac addr */
+	ushort flags;
+	ulong sysminor;
+	ulong aoemajor;
+	ulong aoeminor;
+	ulong rttavg;		/* round trip average of requests/responses */
+	u16 fw_ver;		/* version of blade's firmware */
+	struct work_struct work;/* disk create work struct */
+	struct gendisk *gd;
+	request_queue_t blkq;
+	struct hd_geometry geo; 
+	sector_t ssize;
+	struct timer_list timer;
+	spinlock_t lock;
+	struct net_device *ifp;	/* interface ed is attached to */
+	struct sk_buff *skblist;/* packets needing to be sent */
+	mempool_t *bufpool;	/* for deadlock-free Buf allocation */
+	struct list_head bufq;	/* queue of bios to work on */
+	struct Buf *inprocess;	/* the one we're currently working on */
+	ulong lasttag;		/* last tag sent */
+	ulong nframes;		/* number of frames below */
+	struct Frame *frames;
+};
+
+
+int aoeblk_init(void);
+void aoeblk_exit(void);
+void aoeblk_gdalloc(void *);
+
+int aoechr_init(void);
+void aoechr_exit(void);
+void aoechr_error(char *);
+void aoechr_hdump(char *, int len);
+
+void aoecmd_work(struct Aoedev *d);
+void aoecmd_cfg(ushort, unsigned char);
+void aoecmd_ata_rsp(struct sk_buff *);
+void aoecmd_cfg_rsp(struct sk_buff *);
+
+int aoedev_init(void);
+void aoedev_exit(void);
+int aoedev_stat(char *, int, loff_t);
+struct Aoedev *aoedev_bymac(unsigned char *);
+void aoedev_downdev(struct Aoedev *d);
+struct Aoedev *aoedev_set(ulong, unsigned char *, struct net_device *, ulong);
+int aoedev_busy(void);
+
+int aoenet_init(void);
+void aoenet_exit(void);
+void aoenet_xmit(struct sk_buff *);
+int is_aoe_netif(struct net_device *ifp);
+int set_aoe_iflist(char *str);
+
+u64 mac_addr(char addr[6]);
diff -urNp linux-2.6.9/drivers/block/aoe/aoeblk.c linux-2.6.9-aoe/drivers/block/aoe/aoeblk.c
--- linux-2.6.9/drivers/block/aoe/aoeblk.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoeblk.c	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,190 @@
+/*
+ * aoeblk.c
+ * block device routines
+ */
+
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/ioctl.h>
+#include <linux/genhd.h>
+#include "aoe.h"
+
+static int
+aoeblk_open(struct inode *inode, struct file *filp)
+{
+	struct Aoedev *d;
+
+	d = inode->i_bdev->bd_disk->private_data;
+	return (d->flags & DEVFL_UP) ? 0 : -ENODEV;
+}
+
+static int
+aoeblk_release(struct inode *inode, struct file *filp)
+{
+	struct Aoedev *d;
+	ulong flags;
+
+	d = inode->i_bdev->bd_disk->private_data;
+
+	spin_lock_irqsave(&d->lock, flags);
+
+	if (inode->i_bdev->bd_openers == 0 && (d->flags & DEVFL_CLOSEWAIT)) {
+		d->flags &= ~DEVFL_CLOSEWAIT;
+		spin_unlock_irqrestore(&d->lock, flags);
+		aoecmd_cfg(d->aoemajor, d->aoeminor);
+		return 0;
+	}
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	return 0;
+}
+
+static int
+aoeblk_make_request(request_queue_t *q, struct bio *bio)
+{
+	struct Aoedev *d;
+	struct Buf *buf;
+	struct sk_buff *sl;
+	ulong flags;
+
+	blk_queue_bounce(q, &bio);
+
+	d = bio->bi_bdev->bd_disk->private_data;
+	buf = mempool_alloc(d->bufpool, GFP_KERNEL);
+	if (buf == NULL) {
+		printk(KERN_INFO "aoe: aoeblk_make_request: buf allocation "
+			"failure\n");
+		bio_endio(bio, bio->bi_size, -ENOMEM);
+		return 0;
+	}
+	memset(buf, 0, sizeof(*buf));
+	INIT_LIST_HEAD(&buf->bufs);
+	buf->bio = bio;
+	buf->resid = bio->bi_size;
+	buf->sector = bio->bi_sector;
+	buf->bv = buf->bio->bi_io_vec;
+	buf->bv_resid = buf->bv->bv_len;
+	buf->bufaddr = page_address(buf->bv->bv_page) + buf->bv->bv_offset;
+
+	spin_lock_irqsave(&d->lock, flags);
+
+	if ((d->flags & DEVFL_UP) == 0) {
+		printk(KERN_INFO "aoe: aoeblk_make_request: device %ld.%ld is not up\n",
+			d->aoemajor, d->aoeminor);
+		spin_unlock_irqrestore(&d->lock, flags);
+		mempool_free(buf, d->bufpool);
+		bio_endio(bio, bio->bi_size, -ENXIO);
+		return 0;
+	}
+
+	list_add_tail(&buf->bufs, &d->bufq);
+	aoecmd_work(d);
+
+	sl = d->skblist;
+	d->skblist = NULL;
+
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	aoenet_xmit(sl);
+	return 0;
+}
+
+/* This ioctl implementation expects userland to have the device node
+ * permissions set so that only priviledged users can open an aoe
+ * block device directly.
+ */
+static int
+aoeblk_ioctl(struct inode *inode, struct file *filp, uint cmd, ulong arg)
+{
+	struct Aoedev *d;
+
+	if (!arg)
+		return -EINVAL;
+
+	d = inode->i_bdev->bd_disk->private_data;
+	if ((d->flags & DEVFL_UP) == 0) {
+		printk(KERN_ERR "aoe: aoeblk_ioctl: disk not up\n");
+		return -ENODEV;
+	}
+
+	if (cmd == HDIO_GETGEO) {
+		d->geo.start = get_start_sect(inode->i_bdev);
+		if (!copy_to_user((void *) arg, &d->geo, sizeof d->geo))
+			return 0;
+		return -EFAULT;
+	}
+	printk(KERN_INFO "aoe: aoeblk_ioctl: unknown ioctl %d\n", cmd);
+	return -EINVAL;
+}
+
+static struct block_device_operations aoe_bdops = {
+	.open = aoeblk_open,
+	.release = aoeblk_release,
+	.ioctl = aoeblk_ioctl,
+	.owner = THIS_MODULE,
+};
+
+/* alloc_disk and add_disk can sleep */
+void
+aoeblk_gdalloc(void *vp)
+{
+	struct Aoedev *d = vp;
+	struct gendisk *gd;
+	ulong flags;
+	enum { NPARTITIONS = 16 };
+
+	gd = alloc_disk(NPARTITIONS);
+
+	spin_lock_irqsave(&d->lock, flags);
+
+	if (gd == NULL) {
+		printk(KERN_CRIT "aoe: aoeblk_gdalloc: cannot allocate disk "
+			"structure for %ld.%ld\n", d->aoemajor, d->aoeminor);
+		d->flags &= ~DEVFL_WORKON;
+		spin_unlock_irqrestore(&d->lock, flags);
+		return;
+	}
+
+	blk_queue_make_request(&d->blkq, aoeblk_make_request);
+	gd->major = AOE_MAJOR;
+	gd->first_minor = d->sysminor * NPARTITIONS;
+	gd->fops = &aoe_bdops;
+	gd->private_data = d;
+	gd->capacity = d->ssize;
+	snprintf(gd->disk_name, sizeof gd->disk_name, "etherd/e%ld.%ld",
+		d->aoemajor, d->aoeminor);
+
+	gd->queue = &d->blkq;
+	d->gd = gd;
+	d->flags &= ~DEVFL_WORKON;
+	d->flags |= DEVFL_UP;
+
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	add_disk(gd);
+
+	printk(KERN_INFO "aoe: %012llx e%lu.%lu v%04x has %llu "
+		"sectors\n", mac_addr(d->addr), d->aoemajor, d->aoeminor,
+		d->fw_ver, d->ssize);
+}
+
+void __exit
+aoeblk_exit(void)
+{
+	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
+}
+
+int __init
+aoeblk_init(void)
+{
+	int n;
+
+	n = register_blkdev(AOE_MAJOR, DEVICE_NAME);
+	if (n < 0) {
+		printk(KERN_ERR "aoe: aoeblk_init: can't register major\n");
+		return n;
+	}
+	return 0;
+}
+
diff -urNp linux-2.6.9/drivers/block/aoe/aoechr.c linux-2.6.9-aoe/drivers/block/aoe/aoechr.c
--- linux-2.6.9/drivers/block/aoe/aoechr.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoechr.c	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,319 @@
+/*
+ * aoechr.c
+ * AoE character device driver for {ctl,raw,err} files
+ */
+
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include "aoe.h"
+
+enum {
+	MINOR_CTL,
+	MINOR_STAT,
+	MINOR_ERR,
+	MSGSZ = 2048,
+	NARGS = 10,
+	NMSG = 100,		/* message backlog to retain */
+};
+
+struct Cmd {
+	char *name;
+	int (*f)(char *);	/* return 0 on success */
+};
+
+enum { EMFL_VALID = 1 };
+
+struct ErrMsg {
+	short flags;
+	short len;
+	char *msg;
+};
+
+static struct ErrMsg emsgs[NMSG];
+static int emsgs_head_idx, emsgs_tail_idx;
+static struct semaphore emsgs_sema;
+static spinlock_t emsgs_lock;
+static int nblocked_emsgs_readers;
+static struct class_simple *aoe_class;
+
+static int
+discover_cmd(char *str)
+{
+	aoecmd_cfg(0xffff, 0xff);
+	return 0;
+}
+
+static int
+interfaces_cmd(char *str)
+{
+	char *p;
+
+	p = str + strcspn(str, WHITESPACE);	/* skip first field */
+	p = p + strspn(p, WHITESPACE);		/* ... and whitespace */
+
+	if (set_aoe_iflist(p)) {
+		printk(KERN_CRIT
+		       "%s: could not set inteface list: %s\n",
+		       __FUNCTION__, "too many interfaces");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int
+cmd_handler(char *str)
+{
+	struct Cmd *cmdp;
+	static struct Cmd aoe_cmds[] = {
+		{ "discover", discover_cmd },
+		{ "interfaces", interfaces_cmd },
+		{ NULL, NULL }
+	};
+
+	for (cmdp = aoe_cmds; cmdp->name; cmdp++) {
+		int len = strlen(cmdp->name);
+		
+		if (!strncmp(cmdp->name, str, len))
+			return cmdp->f(str);
+	}
+	return 0;
+}
+
+void
+aoechr_error(char *msg)
+{
+	struct ErrMsg *em;
+	char *mp;
+	ulong flags, n;
+
+	n = strlen(msg);
+
+	spin_lock_irqsave(&emsgs_lock, flags);
+
+	em = emsgs + emsgs_tail_idx;
+	if ((em->flags & EMFL_VALID)) {
+bail:		spin_unlock_irqrestore(&emsgs_lock, flags);
+		return;
+	}
+
+	mp = kmalloc(n, GFP_ATOMIC);
+	if (mp == NULL) {
+		printk(KERN_CRIT "aoe: aoechr_error: allocation failure, len=%ld\n", n);
+		goto bail;
+	}
+
+	memcpy(mp, msg, n);
+	em->msg = mp;
+	em->flags |= EMFL_VALID;
+	em->len = n;
+
+	emsgs_tail_idx++;
+	emsgs_tail_idx %= ARRAY_SIZE(emsgs);
+
+	spin_unlock_irqrestore(&emsgs_lock, flags);
+
+	if (nblocked_emsgs_readers)
+		up(&emsgs_sema);
+}
+
+#define PERLINE 16
+void
+aoechr_hdump(char *buf, int n)
+{
+	int bufsiz;
+	char *fbuf;
+	int linelen;
+	char *p, *e, *fp;
+
+	bufsiz = n * 3;			/* 2 hex digits and a space */
+	bufsiz += n / PERLINE + 1;	/* the newline characters */
+	bufsiz += 1;			/* the final '\0' */
+
+	fbuf = kmalloc(bufsiz, GFP_ATOMIC);
+	if (!fbuf) {
+		printk(KERN_INFO
+		       "%s: cannot allocate memory\n",
+		       __FUNCTION__);
+		return;
+	}
+	
+	for (p = buf; n <= 0;) {
+		linelen = n > PERLINE ? PERLINE : n;
+		n -= linelen;
+
+		fp = fbuf;
+		for (e=p+linelen; p<e; p++)
+			fp += sprintf(fp, "%2.2X ", *p & 255);
+		sprintf(fp, "\n");
+		aoechr_error(fbuf);
+	}
+
+	kfree(fbuf);
+}
+
+static ssize_t
+aoechr_write(struct file *filp, const char *buf, size_t cnt, loff_t *offp)
+{
+	char *str = kcalloc(1, cnt+1, GFP_KERNEL);
+	int ret;
+
+	if (!str) {
+		printk(KERN_CRIT "aoe: aoechr_write: cannot allocate memory\n");
+		return -ENOMEM;
+	}
+
+	ret = -EFAULT;
+	if (copy_from_user(str, buf, cnt)) {
+		printk(KERN_INFO "aoe: aoechr_write: copy from user failed\n");
+		goto out;
+	}
+
+	switch ((unsigned long) filp->private_data) {
+	default:
+		printk(KERN_INFO "aoe: aoechr_write: can't write to that file.\n");
+		break;
+	case MINOR_CTL:
+		str[cnt] = '\0';
+		ret = cmd_handler(str);
+		if (ret == 0)
+			ret = cnt;
+	}
+ out:
+	kfree(str);
+	return ret;
+}
+
+static int
+aoechr_open(struct inode *inode, struct file *filp)
+{
+	int n;
+
+	n = MINOR(inode->i_rdev);
+	filp->private_data = (void *) (unsigned long) n;
+
+	switch (n) {
+	case MINOR_CTL:
+	case MINOR_ERR:
+	case MINOR_STAT:
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int
+aoechr_rel(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static ssize_t
+aoechr_read(struct file *filp, char *buf, size_t cnt, loff_t *off)
+{
+	int n;
+	char *mp;
+	struct ErrMsg *em;
+	ssize_t len;
+	ulong flags;
+
+	n = (int) filp->private_data;
+	switch (n) {
+	case MINOR_ERR:
+		spin_lock_irqsave(&emsgs_lock, flags);
+loop:
+		em = emsgs + emsgs_head_idx;
+		if ((em->flags & EMFL_VALID) == 0) {
+			if (filp->f_flags & O_NDELAY) {
+				spin_unlock_irqrestore(&emsgs_lock, flags);
+				return -EAGAIN;
+			}
+			nblocked_emsgs_readers++;
+
+			spin_unlock_irqrestore(&emsgs_lock, flags);
+
+			n = down_interruptible(&emsgs_sema);
+
+			spin_lock_irqsave(&emsgs_lock, flags);
+
+			nblocked_emsgs_readers--;
+
+			if (n) {
+				spin_unlock_irqrestore(&emsgs_lock, flags);
+				return -ERESTARTSYS;
+			}
+			goto loop;
+		}
+		if (em->len > cnt) {
+			spin_unlock_irqrestore(&emsgs_lock, flags);
+			return -EAGAIN;
+		}
+		mp = em->msg;
+		len = em->len;
+		em->msg = NULL;
+		em->flags &= ~EMFL_VALID;
+
+		emsgs_head_idx++;
+		emsgs_head_idx %= ARRAY_SIZE(emsgs);
+
+		spin_unlock_irqrestore(&emsgs_lock, flags);
+
+		n = copy_to_user(buf, mp, len);
+		kfree(mp);
+		return n == 0 ? len : -EFAULT;
+	case MINOR_STAT:
+		n = aoedev_stat(buf, cnt, *off);
+		if (n > 0)
+			*off += n;
+		return n;
+	default:
+		return -EFAULT;
+	}
+}
+
+struct file_operations aoe_fops = {
+	.write = aoechr_write,
+	.read = aoechr_read,
+	.open = aoechr_open,
+	.release = aoechr_rel,
+	.owner = THIS_MODULE,
+};
+
+int __init
+aoechr_init(void)
+{
+	int n;
+
+	n = register_chrdev(AOE_MAJOR, "aoechr", &aoe_fops);
+	if (n < 0) { 
+		printk(KERN_ERR "aoe: aoechr_init: can't register char device\n");
+		return n;
+	}
+	sema_init(&emsgs_sema, 0);
+	spin_lock_init(&emsgs_lock);
+	aoe_class = class_simple_create(THIS_MODULE, "aoe");
+	if (IS_ERR(aoe_class)) {
+		unregister_chrdev(AOE_MAJOR, "aoechr");
+		return PTR_ERR(aoe_class);
+	}
+	class_simple_device_add(aoe_class,
+				MKDEV(AOE_MAJOR, MINOR_CTL),
+				NULL, "ctl");
+	class_simple_device_add(aoe_class,
+				MKDEV(AOE_MAJOR, MINOR_STAT),
+				NULL, "stat");
+	class_simple_device_add(aoe_class,
+				MKDEV(AOE_MAJOR, MINOR_ERR),
+				NULL, "err");
+
+	return 0;
+}
+
+void __exit
+aoechr_exit(void)
+{
+	class_simple_device_remove(MKDEV(AOE_MAJOR, MINOR_CTL));
+	class_simple_device_remove(MKDEV(AOE_MAJOR, MINOR_STAT));
+	class_simple_device_remove(MKDEV(AOE_MAJOR, MINOR_ERR));
+	class_simple_destroy(aoe_class);
+	unregister_chrdev(AOE_MAJOR, "aoechr");
+}
+
diff -urNp linux-2.6.9/drivers/block/aoe/aoecmd.c linux-2.6.9-aoe/drivers/block/aoe/aoecmd.c
--- linux-2.6.9/drivers/block/aoe/aoecmd.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoecmd.c	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,626 @@
+/*
+ * aoecmd.c
+ * Filesystem request handling methods
+ */
+
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include "aoe.h"
+
+#define TIMERTICK (HZ / 10)
+#define MINTIMER (2 * TIMERTICK)
+#define MAXTIMER (HZ << 1)
+#define MAXWAIT (60 * 3)	/* After MAXWAIT seconds, give up and fail dev */
+
+static struct sk_buff *
+new_skb(struct net_device *if_dev, ulong len)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(len, GFP_ATOMIC);
+	if (skb) {
+		skb->nh.raw = skb->mac.raw = skb->data;
+		skb->dev = if_dev;
+		skb->protocol = __constant_htons(ETH_P_AOE);
+		skb->priority = 0;
+		skb_put(skb, len);
+		skb->next = skb->prev = NULL;
+
+		/* tell the network layer not to perform IP checksums
+		 * or to get the NIC to do it
+		 */
+		skb->ip_summed = CHECKSUM_NONE;
+	}
+	return skb;
+}
+
+static struct sk_buff *
+skb_prepare(struct Aoedev *d, struct Frame *f)
+{
+	struct sk_buff *skb;
+	char *p;
+
+	skb = new_skb(d->ifp, f->ndata + f->writedatalen);
+	if (!skb) {
+		printk(KERN_INFO "aoe: skb_prepare: failure to allocate skb\n");
+		return NULL;
+	}
+
+	p = skb->mac.raw;
+	memcpy(p, f->data, f->ndata);
+
+	if (f->writedatalen) {
+		p += sizeof(struct Aoehdr) + sizeof(struct Aoeahdr);
+		memcpy(p, f->bufaddr, f->writedatalen);
+	}
+
+	return skb;
+}
+
+static struct Frame *
+getframe(struct Aoedev *d, int tag)
+{
+	struct Frame *f, *e;
+
+	f = d->frames;
+	e = f + d->nframes;
+	for (; f<e; f++)
+		if (f->tag == tag)
+			return f;
+	return NULL;
+}
+
+/*
+ * Leave the top bit clear so we have tagspace for userland.
+ * The bottom 16 bits are the xmit tick for rexmit/rttavg processing.
+ * This driver reserves tag -1 to mean "unused frame."
+ */
+static int
+newtag(struct Aoedev *d)
+{
+	register ulong n;
+
+	n = jiffies & 0xffff;
+	return n |= (++d->lasttag & 0x7fff) << 16;
+}
+
+static int
+aoehdr_atainit(struct Aoedev *d, struct Aoehdr *h)
+{
+	u16 type = __constant_cpu_to_be16(ETH_P_AOE);
+	u16 aoemajor = __cpu_to_be16(d->aoemajor);
+	u32 host_tag = newtag(d);
+	u32 tag = __cpu_to_be32(host_tag);
+
+	memcpy(h->src, d->ifp->dev_addr, sizeof h->src);
+	memcpy(h->dst, d->addr, sizeof h->dst);
+	memcpy(h->type, &type, sizeof type);
+	h->verfl = AOE_HVER;
+	memcpy(h->major, &aoemajor, sizeof aoemajor);
+	h->minor = d->aoeminor;
+	h->cmd = AOECMD_ATA;
+	memcpy(h->tag, &tag, sizeof tag);
+
+	return host_tag;
+}
+
+static void
+aoecmd_ata_rw(struct Aoedev *d, struct Frame *f)
+{
+	struct Aoehdr *h;
+	struct Aoeahdr *ah;
+	struct Buf *buf;
+	struct sk_buff *skb;
+	ulong bcnt;
+	register sector_t sector;
+	char writebit, extbit;
+
+	writebit = 0x10;
+	extbit = 0x4;
+
+	buf = d->inprocess;
+
+	sector = buf->sector;
+	bcnt = buf->bv_resid;
+	if (bcnt > MAXATADATA)
+		bcnt = MAXATADATA;
+
+	/* initialize the headers & frame */
+	h = (struct Aoehdr *) f->data;
+	ah = (struct Aoeahdr *) (h+1);
+	f->ndata = sizeof *h + sizeof *ah;
+	memset(h, 0, f->ndata);
+	f->tag = aoehdr_atainit(d, h);
+	f->waited = 0;
+	f->buf = buf;
+	f->bufaddr = buf->bufaddr;
+
+	/* set up ata header */
+	ah->scnt = bcnt >> 9;
+	ah->lba0 = sector;
+	ah->lba1 = sector >>= 8;
+	ah->lba2 = sector >>= 8;
+	ah->lba3 = sector >>= 8;
+	if (d->flags & DEVFL_EXT) {
+		ah->aflags |= AOEAFL_EXT;
+		ah->lba4 = sector >>= 8;
+		ah->lba5 = sector >>= 8;
+	} else {
+		extbit = 0;
+		ah->lba3 &= 0x0f;
+		ah->lba3 |= 0xe0;	/* LBA bit + obsolete 0xa0 */
+	}
+
+	if (bio_data_dir(buf->bio) == WRITE) {
+		ah->aflags |= AOEAFL_WRITE;
+		f->writedatalen = bcnt;
+	} else {
+		writebit = 0;
+		f->writedatalen = 0;
+	}
+
+	ah->cmdstat = WIN_READ | writebit | extbit;
+
+	/* mark all tracking fields and load out */
+	buf->nframesout += 1;
+	buf->bufaddr += bcnt;
+	buf->bv_resid -= bcnt;
+/* printk(KERN_INFO "aoe: bv_resid=%ld\n", buf->bv_resid); */
+	buf->resid -= bcnt;
+	buf->sector += bcnt >> 9;
+	if (buf->resid == 0) {
+		d->inprocess = NULL;
+	} else if (buf->bv_resid == 0) {
+		buf->bv++;
+		buf->bv_resid = buf->bv->bv_len;
+		buf->bufaddr = page_address(buf->bv->bv_page) + buf->bv->bv_offset;
+	}
+
+	skb = skb_prepare(d, f);
+	if (skb) {
+		skb->next = d->skblist;
+		d->skblist = skb;
+	}
+}
+
+/* enters with d->lock held */
+void
+aoecmd_work(struct Aoedev *d)
+{
+	struct Frame *f;
+	struct Buf *buf;
+loop:
+	f = getframe(d, FREETAG);
+	if (f == NULL)
+		return;
+	if (d->inprocess == NULL) {
+		if (list_empty(&d->bufq))
+			return;
+		buf = container_of(d->bufq.next, struct Buf, bufs);
+		list_del(d->bufq.next);
+/*printk(KERN_INFO "aoecmd_work: bi_size=%ld\n", buf->bio->bi_size); */
+		d->inprocess = buf;
+	}
+	aoecmd_ata_rw(d, f);
+	goto loop;
+}
+
+static void
+rexmit(struct Aoedev *d, struct Frame *f)
+{
+	struct sk_buff *skb;
+	struct Aoehdr *h;
+	char buf[128];
+	u32 n;
+	u32 net_tag;
+
+	n = newtag(d);
+
+	snprintf(buf, sizeof buf,
+		"%15s e%ld.%ld oldtag=%08x@%08lx newtag=%08x\n",
+		"retransmit",
+		d->aoemajor, d->aoeminor, f->tag, jiffies, n);
+	aoechr_error(buf);
+
+	h = (struct Aoehdr *) f->data;
+	f->tag = n;
+	net_tag = __cpu_to_be32(n);
+	memcpy(h->tag, &net_tag, sizeof net_tag);
+
+	skb = skb_prepare(d, f);
+	if (skb) {
+		skb->next = d->skblist;
+		d->skblist = skb;
+	}
+}
+
+static int
+tsince(int tag)
+{
+	int n;
+
+	n = jiffies & 0xffff;
+	n -= tag & 0xffff;
+	if (n < 0)
+		n += 1<<16;
+	return n;
+}
+
+static void
+rexmit_timer(ulong vp)
+{
+	struct Aoedev *d;
+	struct Frame *f, *e;
+	struct sk_buff *sl;
+	register long timeout;
+	ulong flags, n;
+
+	d = (struct Aoedev *) vp;
+	sl = NULL;
+
+	/* timeout is always ~150% of the moving average */
+	timeout = d->rttavg;
+	timeout += timeout >> 1;
+
+	spin_lock_irqsave(&d->lock, flags);
+
+	if (d->flags & DEVFL_TKILL) {
+tdie:		spin_unlock_irqrestore(&d->lock, flags);
+		return;
+	}
+	f = d->frames;
+	e = f + d->nframes;
+	for (; f<e; f++) {
+		if (f->tag != FREETAG && tsince(f->tag) >= timeout) {
+			n = f->waited += timeout;
+			n /= HZ;
+			if (n > MAXWAIT) { /* waited too long.  device failure. */
+				aoedev_downdev(d);
+				goto tdie;
+			}
+			rexmit(d, f);
+		}
+	}
+
+	sl = d->skblist;
+	d->skblist = NULL;
+	if (sl) {
+		n = d->rttavg <<= 1;
+		if (n > MAXTIMER)
+			d->rttavg = MAXTIMER;
+	}
+
+	d->timer.expires = jiffies + TIMERTICK;
+	add_timer(&d->timer);
+
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	aoenet_xmit(sl);
+}
+
+static void
+ataid_complete(struct Aoedev *d, unsigned char *id)
+{
+	u64 ssize;
+	u16 n;
+
+	/* word 83: command set supported */
+	n = __le16_to_cpu(*((u16 *) &id[83<<1]));
+
+	/* word 86: command set/feature enabled */
+	n |= __le16_to_cpu(*((u16 *) &id[86<<1]));
+
+	if (n & (1<<10)) {	/* bit 10: LBA 48 */
+		d->flags |= DEVFL_EXT;
+
+		/* word 100: number lba48 sectors */
+		ssize = __le64_to_cpu(*((u64 *) &id[100<<1]));
+
+		/* set as in ide-disk.c:init_idedisk_capacity */
+		d->geo.cylinders = ssize;
+		d->geo.cylinders /= (255 * 63);
+		d->geo.heads = 255;
+		d->geo.sectors = 63;
+	} else {
+		d->flags &= ~DEVFL_EXT;
+
+		/* number lba28 sectors */
+		ssize = __le32_to_cpu(*((u32 *) &id[60<<1]));
+
+		/* NOTE: obsolete in ATA 6 */
+		d->geo.cylinders = __le16_to_cpu(*((u16 *) &id[54<<1]));
+		d->geo.heads = __le16_to_cpu(*((u16 *) &id[55<<1]));
+		d->geo.sectors = __le16_to_cpu(*((u16 *) &id[56<<1]));
+	}
+	d->ssize = ssize;
+	d->geo.start = 0;
+	if (d->gd != NULL) {
+		d->gd->capacity = ssize;
+		d->flags |= DEVFL_UP;
+		return;
+	}
+	if (d->flags & DEVFL_WORKON) {
+		printk(KERN_INFO "aoe: ataid_complete: can't schedule work, it's already on!  "
+			"(This really shouldn't happen).\n");
+		return;
+	}
+	INIT_WORK(&d->work, aoeblk_gdalloc, d);
+	schedule_work(&d->work);
+	d->flags |= DEVFL_WORKON;
+}
+
+static void
+calc_rttavg(struct Aoedev *d, int rtt)
+{
+	register long n;
+
+	n = rtt;
+	if (n < MINTIMER)
+		n = MINTIMER;
+	else if (n > MAXTIMER)
+		n = MAXTIMER;
+
+	/* g == .25; cf. Congestion Avoidance and Control, Jacobson & Karels; 1988 */
+	n -= d->rttavg;
+	d->rttavg += n >> 2;
+}
+
+void
+aoecmd_ata_rsp(struct sk_buff *skb)
+{
+	struct Aoedev *d;
+	struct Aoehdr *hin;
+	struct Aoeahdr *ahin, *ahout;
+	struct Frame *f;
+	struct Buf *buf;
+	struct sk_buff *sl;
+	register long n;
+	ulong flags;
+	char ebuf[128];
+	
+	hin = (struct Aoehdr *) skb->mac.raw;
+	d = aoedev_bymac(hin->src);
+	if (d == NULL) {
+		snprintf(ebuf, sizeof ebuf, "aoecmd_ata_rsp: ata response "
+			"for unknown device %d.%d\n",
+			 __be16_to_cpu(*((u16 *) hin->major)),
+			hin->minor);
+		aoechr_error(ebuf);
+		return;
+	}
+
+	spin_lock_irqsave(&d->lock, flags);
+
+	f = getframe(d, __be32_to_cpu(*((u32 *) hin->tag)));
+	if (f == NULL) {
+		spin_unlock_irqrestore(&d->lock, flags);
+		snprintf(ebuf, sizeof ebuf,
+			"%15s e%d.%d    tag=%08x@%08lx\n",
+			"unexpected rsp",
+			__be16_to_cpu(*((u16 *) hin->major)),
+			hin->minor,
+			__be32_to_cpu(*((u32 *) hin->tag)),
+			jiffies);
+		aoechr_error(ebuf);
+		return;
+	}
+
+	calc_rttavg(d, tsince(f->tag));
+
+	ahin = (struct Aoeahdr *) (hin+1);
+	ahout = (struct Aoeahdr *) (f->data + sizeof(struct Aoehdr));
+	buf = f->buf;
+
+	if (ahin->cmdstat & 0xa9) {	/* these bits cleared on success */
+		printk(KERN_CRIT "aoe: aoecmd_ata_rsp: ata error cmd=%2.2Xh "
+			"stat=%2.2Xh\n", ahout->cmdstat, ahin->cmdstat);
+		if (buf)
+			buf->flags |= BUFFL_FAIL;
+	} else {
+		switch (ahout->cmdstat) {
+		case WIN_READ:
+		case WIN_READ_EXT:
+			n = ahout->scnt << 9;
+			if (skb->len - sizeof *hin - sizeof *ahin < n) {
+				printk(KERN_CRIT "aoe: aoecmd_ata_rsp: runt "
+					"ata data size in read.  skb->len=%d\n",
+					skb->len);
+				/* fail frame f?  just returning will rexmit. */
+				spin_unlock_irqrestore(&d->lock, flags);
+				return;
+			}
+			memcpy(f->bufaddr, ahin+1, n);
+		case WIN_WRITE:
+		case WIN_WRITE_EXT:
+			break;
+		case WIN_IDENTIFY:
+			if (skb->len - sizeof *hin - sizeof *ahin < 512) {
+				printk(KERN_INFO "aoe: aoecmd_ata_rsp: runt data size "
+					"in ataid.  skb->len=%d\n", skb->len);
+				spin_unlock_irqrestore(&d->lock, flags);
+				return;
+			}
+			ataid_complete(d, (char *) (ahin+1));
+			/* d->flags |= DEVFL_WC_UPDATE; */
+			break;
+		default:
+			printk(KERN_INFO "aoe: aoecmd_ata_rsp: unrecognized "
+			       "outbound ata command %2.2Xh for %d.%d\n", 
+			       ahout->cmdstat,
+			       __be16_to_cpu(*((u16 *) hin->major)),
+			       hin->minor);
+		}
+	}
+
+	if (buf) {
+		buf->nframesout -= 1;
+		if (buf->nframesout == 0 && buf->resid == 0) {
+			n = !(buf->flags & BUFFL_FAIL);
+			bio_endio(buf->bio, buf->bio->bi_size, 0);
+			mempool_free(buf, d->bufpool);
+		}
+	}
+
+	f->buf = NULL;
+	f->tag = FREETAG;
+
+	aoecmd_work(d);
+
+	sl = d->skblist;
+	d->skblist = NULL;
+
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	aoenet_xmit(sl);
+}
+
+void
+aoecmd_cfg(ushort aoemajor, unsigned char aoeminor)
+{
+	struct Aoehdr *h;
+	struct Aoechdr *ch;
+	struct sk_buff *skb, *sl;
+	struct net_device *ifp;
+	u16 aoe_type = __constant_cpu_to_be16(ETH_P_AOE);
+	u16 net_aoemajor = __cpu_to_be16(aoemajor);
+
+	sl = NULL;
+
+	read_lock(&dev_base_lock);
+	for (ifp = dev_base; ifp; dev_put(ifp), ifp = ifp->next) {
+		dev_hold(ifp);
+		if (!is_aoe_netif(ifp))
+			continue;
+
+		skb = new_skb(ifp, sizeof *h + sizeof *ch);
+		if (skb == NULL) {
+			printk(KERN_INFO "aoe: aoecmd_cfg: skb alloc failure\n");
+			continue;
+		}
+		h = (struct Aoehdr *) skb->mac.raw;
+		memset(h, 0, sizeof *h + sizeof *ch);
+
+		memset(h->dst, 0xff, sizeof h->dst);
+		memcpy(h->src, ifp->dev_addr, sizeof h->src);
+		memcpy(h->type, &aoe_type, sizeof aoe_type);
+		h->verfl = AOE_HVER;
+		memcpy(h->major, &net_aoemajor, sizeof net_aoemajor);
+		h->minor = aoeminor;
+		h->cmd = AOECMD_CFG;
+
+		skb->next = sl;
+		sl = skb;
+	}
+	read_unlock(&dev_base_lock);
+
+	aoenet_xmit(sl);
+}
+ 
+/*
+ * Since we only call this in one place (and it only prepares one frame)
+ * we just return the skb.  Usually we'd chain it up to the d->skblist.
+ */
+static struct sk_buff *
+aoecmd_ata_id(struct Aoedev *d)
+{
+	struct Aoehdr *h;
+	struct Aoeahdr *ah;
+	struct Frame *f;
+	struct sk_buff *skb;
+
+	f = getframe(d, FREETAG);
+	if (f == NULL) {
+		printk(KERN_CRIT "aoe: aoecmd_ata_id: can't get a frame.  "
+			"This shouldn't happen.\n");
+		return NULL;
+	}
+
+	/* initialize the headers & frame */
+	h = (struct Aoehdr *) f->data;
+	ah = (struct Aoeahdr *) (h+1);
+	f->ndata = sizeof *h + sizeof *ah;
+	memset(h, 0, f->ndata);
+	f->tag = aoehdr_atainit(d, h);
+	f->waited = 0;
+	f->writedatalen = 0;
+
+	/* this message initializes the device, so we reset the rttavg */
+	d->rttavg = MAXTIMER;
+
+	/* set up ata header */
+	ah->scnt = 1;
+	ah->cmdstat = WIN_IDENTIFY;
+	ah->lba3 = 0xa0;
+
+	skb = skb_prepare(d, f);
+
+	/* we now want to start the rexmit tracking */
+	d->flags &= ~DEVFL_TKILL;
+	d->timer.data = (ulong) d;
+	d->timer.function = rexmit_timer;
+	d->timer.expires = jiffies + TIMERTICK;
+	add_timer(&d->timer);
+
+	return skb;
+}
+ 
+void
+aoecmd_cfg_rsp(struct sk_buff *skb)
+{
+	struct Aoedev *d;
+	struct Aoehdr *h;
+	struct Aoechdr *ch;
+	ulong flags, bufcnt, sysminor, aoemajor;
+	struct sk_buff *sl;
+	enum { MAXFRAMES = 8, MAXSYSMINOR = 255 };
+
+	h = (struct Aoehdr *) skb->mac.raw;
+	ch = (struct Aoechdr *) (h+1);
+
+	/*
+	 * Enough people have their dip switches set backwards to
+	 * warrant a loud message for this special case.
+	 */
+	aoemajor = __be16_to_cpu(*((u16 *) h->major));
+	if (aoemajor == 0xfff) {
+		printk(KERN_CRIT "aoe: aoecmd_cfg_rsp: Warning: shelf "
+			"address is all ones.  Check shelf dip switches\n");
+		return;
+	}
+
+	sysminor = SYSMINOR(aoemajor, h->minor);
+	if (sysminor > MAXSYSMINOR) {
+		printk(KERN_INFO "aoe: aoecmd_cfg_rsp: sysminor %ld too "
+			"large\n", sysminor);
+		return;
+	}
+
+	bufcnt = __be16_to_cpu(*((u16 *) ch->bufcnt));
+	if (bufcnt > MAXFRAMES)	/* keep it reasonable */
+		bufcnt = MAXFRAMES;
+
+	d = aoedev_set(sysminor, h->src, skb->dev, bufcnt);
+	if (d == NULL) {
+		printk(KERN_INFO "aoe: aoecmd_cfg_rsp: device set failure\n");
+		return;
+	}
+
+	spin_lock_irqsave(&d->lock, flags);
+
+	if (d->flags & (DEVFL_UP | DEVFL_CLOSEWAIT)) {
+		spin_unlock_irqrestore(&d->lock, flags);
+		return;
+	}
+
+	d->fw_ver = __be16_to_cpu(*((u16 *) ch->fwver));
+
+	/* we get here only if the device is new */
+	sl = aoecmd_ata_id(d);
+
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	aoenet_xmit(sl);
+}
+
diff -urNp linux-2.6.9/drivers/block/aoe/aoedev.c linux-2.6.9-aoe/drivers/block/aoe/aoedev.c
--- linux-2.6.9/drivers/block/aoe/aoedev.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoedev.c	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,237 @@
+/*
+ * aoedev.c
+ * AoE device utility functions; maintains device list.
+ */
+
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include <linux/netdevice.h>
+#include "aoe.h"
+
+static struct Aoedev *devlist;
+static spinlock_t devlist_lock;
+static kmem_cache_t *buf_pool_cache;
+
+int
+aoedev_stat(char *ubuf, int buflen, loff_t off)
+{
+	struct Aoedev *d;
+	ulong flags;
+	char buf[64];
+	int n, nlen = 0;
+	int n_skip;
+
+	for (n_skip = 0; ; ++n_skip) {
+		int i;
+		struct Aoedev dev;
+		
+		spin_lock_irqsave(&devlist_lock, flags);
+		for (d=devlist, i=0; d; d=d->next, ++i)
+			if (i == n_skip)
+				break;
+		if (d)
+			dev = *d;
+		spin_unlock_irqrestore(&devlist_lock, flags);
+
+		if (!d)
+			break;
+		if (buflen - nlen < sizeof buf)
+			break;
+
+		n = snprintf(buf, sizeof buf,
+			     "/dev/etherd/e%ld.%ld\t%s\t%s%s\n",
+			     dev.aoemajor, dev.aoeminor, dev.ifp->name,
+			     (dev.flags & DEVFL_UP) ? "up" : "down",
+			     (dev.flags & DEVFL_CLOSEWAIT) ? ",closewait" : "");
+		if (off > 0) {
+			off -= n;
+			continue;
+		}
+		if (nlen + n > buflen)
+			break;
+		if (copy_to_user(ubuf, buf, n))
+			return -EFAULT;
+		nlen += n, ubuf += n;
+	}
+
+	return nlen;
+}
+
+struct Aoedev *
+aoedev_bymac(unsigned char *macaddr)
+{
+	struct Aoedev *d;
+	ulong flags;
+
+	spin_lock_irqsave(&devlist_lock, flags);
+
+	for (d=devlist; d; d=d->next)
+		if (!memcmp(d->addr, macaddr, 6))
+			break;
+
+	spin_unlock_irqrestore(&devlist_lock, flags);
+	return d;
+}
+
+/* called with devlist lock held */
+static struct Aoedev *
+aoedev_newdev(ulong nframes)
+{
+	struct Aoedev *d;
+	struct Frame *f, *e;
+
+	d = kcalloc(1, sizeof *d, GFP_ATOMIC);
+	if (d == NULL)
+		return NULL;
+	f = kcalloc(nframes, sizeof *f, GFP_ATOMIC);
+	if (f == NULL) {
+		kfree(d);
+		return NULL;
+	}
+
+	d->nframes = nframes;
+	d->frames = f;
+	e = f + nframes;
+	for (; f<e; f++)
+		f->tag = FREETAG;
+
+	spin_lock_init(&d->lock);
+	init_timer(&d->timer);
+	d->bufpool = mempool_create(MIN_BUFS,
+				    mempool_alloc_slab, mempool_free_slab,
+				    buf_pool_cache);
+	INIT_LIST_HEAD(&d->bufq);
+	d->next = devlist;
+	devlist = d;
+
+	return d;
+}
+
+void
+aoedev_downdev(struct Aoedev *d)
+{
+	struct Frame *f, *e;
+	struct Buf *buf;
+	struct bio *bio;
+
+	d->flags |= DEVFL_TKILL;
+	del_timer(&d->timer);
+
+	f = d->frames;
+	e = f + d->nframes;
+	for (; f<e; f->tag = FREETAG, f->buf = NULL, f++) {
+		if (f->tag == FREETAG || f->buf == NULL)
+			continue;
+		buf = f->buf;
+		bio = buf->bio;
+		if (--buf->nframesout == 0) {
+			mempool_free(buf, d->bufpool);
+			bio_endio(bio, bio->bi_size, -EIO);
+		}
+	}
+	d->inprocess = NULL;
+
+	while (!list_empty(&d->bufq)) {
+		buf = container_of(d->bufq.next, struct Buf, bufs);
+		list_del(d->bufq.next);
+		bio = buf->bio;
+		mempool_free(buf, d->bufpool);
+		bio_endio(bio, bio->bi_size, -EIO);
+	}
+
+	if (d->gd) {
+		struct block_device *bdev = bdget_disk(d->gd, 0);
+		if (bdev) {
+			if (bdev->bd_openers)
+				d->flags |= DEVFL_CLOSEWAIT;
+			bdput(bdev);
+		}
+		d->gd->capacity = 0;
+	}
+
+	d->flags &= ~DEVFL_UP;
+}
+
+struct Aoedev *
+aoedev_set(ulong sysminor, unsigned char *addr, struct net_device *ifp, ulong bufcnt)
+{
+	struct Aoedev *d;
+	ulong flags;
+
+	spin_lock_irqsave(&devlist_lock, flags);
+
+	for (d=devlist; d; d=d->next)
+		if (d->sysminor == sysminor
+		|| memcmp(d->addr, addr, sizeof d->addr) == 0)
+			break;
+
+	if (d == NULL && (d = aoedev_newdev(bufcnt)) == NULL) {
+		spin_unlock_irqrestore(&devlist_lock, flags);
+		printk(KERN_INFO "aoe: aoedev_set: aoedev_newdev failure.\n");
+		return NULL;
+	}
+
+	spin_unlock_irqrestore(&devlist_lock, flags);
+	spin_lock_irqsave(&d->lock, flags);
+
+	d->ifp = ifp;
+
+	if (d->sysminor != sysminor
+	|| memcmp(d->addr, addr, sizeof d->addr)
+	|| (d->flags & DEVFL_UP) == 0) {
+		aoedev_downdev(d); /* flushes outstanding frames */
+		memcpy(d->addr, addr, sizeof d->addr);
+		d->sysminor = sysminor;
+		d->aoemajor = AOEMAJOR(sysminor);
+		d->aoeminor = AOEMINOR(sysminor);
+	}
+
+	spin_unlock_irqrestore(&d->lock, flags);
+	return d;
+}
+
+static void
+aoedev_freedev(struct Aoedev *d)
+{
+	if (d->gd) {
+		del_gendisk(d->gd);
+		put_disk(d->gd);
+	}
+	kfree(d->frames);
+	mempool_destroy(d->bufpool);
+	kfree(d);
+}
+
+void __exit
+aoedev_exit(void)
+{
+	struct Aoedev *d;
+	ulong flags;
+
+	flush_scheduled_work();
+
+	while ((d = devlist)) {
+		devlist = d->next;
+
+		spin_lock_irqsave(&d->lock, flags);
+		aoedev_downdev(d);
+		spin_unlock_irqrestore(&d->lock, flags);
+
+		del_timer_sync(&d->timer);
+		aoedev_freedev(d);
+	}
+	kmem_cache_destroy(buf_pool_cache);
+}
+
+int __init
+aoedev_init(void)
+{
+	buf_pool_cache = kmem_cache_create("aoe_bufs", 
+					   sizeof(struct Buf),
+					   0, 0, NULL, NULL);
+	if (buf_pool_cache == NULL)
+		return -ENOMEM;
+	spin_lock_init(&devlist_lock);
+	return 0;
+}
+
diff -urNp linux-2.6.9/drivers/block/aoe/aoemain.c linux-2.6.9-aoe/drivers/block/aoe/aoemain.c
--- linux-2.6.9/drivers/block/aoe/aoemain.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoemain.c	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,89 @@
+/*
+ * aoemain.c
+ * Module initialization routines, discover timer
+ */
+
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include <linux/module.h>
+#include "aoe.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sam Hopkins <sah@coraid.com>");
+MODULE_DESCRIPTION("AoE block/char driver for 2.6.[0-9]+");
+
+enum { TINIT, TRUN, TKILL };
+
+static void
+discover_timer(ulong vp)
+{
+	static struct timer_list t;
+	static volatile ulong die;
+	static spinlock_t lock;
+	ulong flags;
+	enum { DTIMERTICK = HZ * 60 }; /* one minute */
+
+	switch (vp) {
+	case TINIT:
+		init_timer(&t);
+		spin_lock_init(&lock);
+		t.data = TRUN;
+		t.function = discover_timer;
+		die = 0;
+	case TRUN:
+		spin_lock_irqsave(&lock, flags);
+		if (!die) {
+			t.expires = jiffies + DTIMERTICK;
+			add_timer(&t);
+		}
+		spin_unlock_irqrestore(&lock, flags);
+
+		aoecmd_cfg(0xffff, 0xff);
+		return;
+	case TKILL:
+		spin_lock_irqsave(&lock, flags);
+		die = 1;
+		spin_unlock_irqrestore(&lock, flags);
+
+		del_timer_sync(&t);
+	default:
+		return;
+	}
+}
+
+static void __exit
+aoe_exit(void)
+{
+	discover_timer(TKILL);
+
+	aoenet_exit();
+	aoeblk_exit();
+	aoechr_exit();
+	aoedev_exit();
+}
+
+static int __init
+aoe_init(void)
+{
+	int n, (**p)(void);
+	int (*fns[])(void) = {
+		aoedev_init, aoechr_init, aoeblk_init, aoenet_init, NULL
+	};
+
+	for (p=fns; *p != NULL; p++) {
+		n = (*p)();
+		if (n) {
+			aoe_exit();
+			printk(KERN_INFO "aoe: aoe_init: initialisation failure.\n");
+			return n;
+		}
+	}
+	printk(KERN_INFO "aoe: aoe_init: AoE v2.6-%d initialised.\n", VER);
+
+	discover_timer(TINIT);
+	return 0;
+}
+
+module_init(aoe_init);
+module_exit(aoe_exit);
+
diff -urNp linux-2.6.9/drivers/block/aoe/aoenet.c linux-2.6.9-aoe/drivers/block/aoe/aoenet.c
--- linux-2.6.9/drivers/block/aoe/aoenet.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoenet.c	2004-12-13 10:53:19.000000000 -0500
@@ -0,0 +1,172 @@
+/*
+ * aoenet.c
+ * Ethernet portion of AoE driver
+ */
+
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include <linux/netdevice.h>
+#include "aoe.h"
+
+#define NECODES 5
+
+static char *aoe_errlist[] =
+{
+	"no such error",
+	"unrecognized command code",
+	"bad argument parameter",
+	"device unavailable",
+	"config string present",
+	"unsupported version"
+};
+
+enum {
+	IFLISTSZ = 1024,
+};
+
+static char aoe_iflist[IFLISTSZ];
+
+int
+is_aoe_netif(struct net_device *ifp)
+{
+	register char *p, *q;
+	register int len;
+
+	if (aoe_iflist[0] == '\0')
+		return 1;
+
+	for (p = aoe_iflist; *p; p = q + strspn(q, WHITESPACE)) {
+		q = p + strcspn(p, WHITESPACE);
+		if (q != p)
+			len = q - p;
+		else
+			len = strlen(p); /* last token in aoe_iflist */
+
+		if (strlen(ifp->name) == len && !strncmp(ifp->name, p, len))
+			return 1;
+		if (q == p)
+			break;
+	}
+
+	return 0;
+}
+
+int
+set_aoe_iflist(char *str)
+{
+	int len = strlen(str);
+
+	if (len >= IFLISTSZ)
+		return -EINVAL;
+
+	strcpy(aoe_iflist, str);
+	return 0;
+}
+
+u64
+mac_addr(char addr[6])
+{
+	u64 n = 0;
+	char *p = (char *) &n;
+
+	memcpy(p + 2, addr, 6);	/* (sizeof addr != 6) */
+
+	return __be64_to_cpu(n);
+}
+
+static struct sk_buff *
+skb_check(struct sk_buff *skb)
+{
+	if (skb_is_nonlinear(skb))
+	if ((skb = skb_share_check(skb, GFP_ATOMIC)))
+	if (skb_linearize(skb, GFP_ATOMIC) < 0) {
+		dev_kfree_skb(skb);
+		return NULL;
+	}
+	return skb;
+}
+
+void
+aoenet_xmit(struct sk_buff *sl)
+{
+	struct sk_buff *skb;
+
+	while ((skb = sl)) {
+		sl = sl->next;
+		skb->next = skb->prev = NULL;
+		dev_queue_xmit(skb);
+	}
+}
+
+/* 
+ * (1) i have no idea if this is redundant, but i can't figure why
+ * the ifp is passed in if it is.
+ *
+ * (2) len doesn't include the header by default.  I want this. 
+ */
+static int
+aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt)
+{
+	struct Aoehdr *h;
+	ulong n;
+
+	skb = skb_check(skb);
+	if (!skb)
+		return 0;
+
+	skb->dev = ifp;	/* (1) */
+
+	if (!is_aoe_netif(ifp))
+		goto exit;
+
+	skb->len += ETH_HLEN;	/* (2) */
+
+	h = (struct Aoehdr *) skb->mac.raw;
+	n = __be32_to_cpu(*((u32 *) h->tag));
+	if ((h->verfl & AOEFL_RSP) == 0 || (n & 1<<31))
+		goto exit;
+
+	if (h->verfl & AOEFL_ERR) {
+		n = h->err;
+		if (n > NECODES)
+			n = 0;
+		printk(KERN_CRIT "aoe: aoenet_rcv: error packet from %d.%d; "
+			"ecode=%d '%s'\n",
+		       __be16_to_cpu(*((u16 *) h->major)), h->minor, 
+			h->err, aoe_errlist[n]);
+		goto exit;
+	}
+
+	switch (h->cmd) {
+	case AOECMD_ATA:
+		aoecmd_ata_rsp(skb);
+		break;
+	case AOECMD_CFG:
+		aoecmd_cfg_rsp(skb);
+		break;
+	default:
+		printk(KERN_INFO "aoe: aoenet_rcv: unknown cmd %d\n", h->cmd);
+	}
+exit:
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+static struct packet_type aoe_pt = {
+	.type = __constant_htons(ETH_P_AOE),
+	.func = aoenet_rcv,
+};
+
+int __init
+aoenet_init(void)
+{
+	dev_add_pack(&aoe_pt);
+	return 0;
+}
+
+void __exit
+aoenet_exit(void)
+{
+	dev_remove_pack(&aoe_pt);
+}
+

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

