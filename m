Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVAHH1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVAHH1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVAHHZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:25:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:61317 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261894AbVAHFsb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:31 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163259187@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:39 -0800
Message-Id: <1105163259475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.9, 2004/12/17 14:50:31-08:00, ecashin@coraid.com

[PATCH] add ATA over Ethernet driver

Provide support for ATA over Ethernet devices

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/aoe/aoe.txt     |   75 +++++
 Documentation/aoe/autoload.sh |   17 +
 Documentation/aoe/mkdevs.sh   |   33 ++
 Documentation/aoe/mkshelf.sh  |   23 +
 Documentation/aoe/status.sh   |   15 +
 MAINTAINERS                   |    6 
 drivers/Makefile              |    1 
 drivers/block/Kconfig         |    8 
 drivers/block/aoe/Makefile    |    6 
 drivers/block/aoe/aoe.h       |  163 ++++++++++
 drivers/block/aoe/aoeblk.c    |  251 ++++++++++++++++
 drivers/block/aoe/aoechr.c    |  295 +++++++++++++++++++
 drivers/block/aoe/aoecmd.c    |  627 ++++++++++++++++++++++++++++++++++++++++++
 drivers/block/aoe/aoedev.c    |  194 ++++++++++++
 drivers/block/aoe/aoemain.c   |   93 ++++++
 drivers/block/aoe/aoenet.c    |  173 +++++++++++
 16 files changed, 1980 insertions(+)


diff -Nru a/Documentation/aoe/aoe.txt b/Documentation/aoe/aoe.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/aoe/aoe.txt	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,75 @@
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
+    sh Documentation/aoe/mkdevs.sh /dev/etherd
+
+  ... or to make just one shelf's worth of block device nodes ...
+
+    sh Documentation/aoe/mkshelf.sh /dev/etherd 0
+
+  There is also an autoload script that shows how to edit
+  /etc/modprobe.conf to ensure that the aoe module is loaded when
+  necessary.
+
+USING DEVICE NODES
+
+  "cat /dev/etherd/err" blocks, waiting for error diagnostic output,
+  like any retransmitted packets.
+
+  "echo eth2 eth4 > /dev/etherd/interfaces" tells the aoe driver to
+  limit ATA over Ethernet traffic to eth2 and eth4.  AoE traffic from
+  untrusted networks should be ignored as a matter of security.
+
+  "echo > /dev/etherd/discover" tells the driver to find out what AoE
+  devices are available.
+
+  The block devices are named like this:
+
+	e{shelf}.{slot}
+	e{shelf}.{slot}p{part}
+
+  ... so that "e0.2" is the third blade from the left (slot 2) in the
+  first shelf (shelf address zero).  That's the whole disk.  The first
+  partition on that disk would be "e0.2p1".
+
+USING SYSFS
+
+  Each aoe block device in /sys/block has the extra attributes of
+  state, mac, and netif.  The state attribute is "up" when the device
+  is ready for I/O and "down" if detected but unusable.  The
+  "down,closewait" state shows that the device is still open and
+  cannot come up again until it has been closed.
+
+  The mac attribute is the ethernet address of the remote AoE device.
+  The netif attribute is the network interface on the localhost
+  through which we are communicating with the remote AoE device.
+
+  There is a script in this directory that formats this information
+  in a convenient way.
+
+  root@makki linux# sh Documentation/aoe/status.sh 
+    device                 mac       netif           state
+      e6.0        0010040010c6        eth0              up
+      e6.1        001004001067        eth0              up
+      e6.2        001004001068        eth0              up
+      e6.3        001004001065        eth0              up
+      e6.4        001004001066        eth0              up
+      e6.5        0010040010c7        eth0              up
+      e6.6        0010040010c8        eth0              up
+      e6.7        0010040010c9        eth0              up
+      e6.8        0010040010ca        eth0              up
+      e6.9        0010040010cb        eth0              up
+      e9.0        001004000020        eth1              up
+      e9.5        001004000025        eth1              up
+      e9.9        001004000029        eth1              up
+
diff -Nru a/Documentation/aoe/autoload.sh b/Documentation/aoe/autoload.sh
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/aoe/autoload.sh	2005-01-07 15:45:50 -08:00
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
diff -Nru a/Documentation/aoe/mkdevs.sh b/Documentation/aoe/mkdevs.sh
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/aoe/mkdevs.sh	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+n_shelves=10
+
+if test "$#" != "1"; then
+	echo "Usage: sh mkdevs.sh {dir}" 1>&2
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
+# (Status info is in sysfs.  See status.sh.)
+# rm -f $dir/stat
+# mknod -m 0400 $dir/stat c $MAJOR 1
+rm -f $dir/err
+mknod -m 0400 $dir/err c $MAJOR 2
+rm -f $dir/discover
+mknod -m 0200 $dir/discover c $MAJOR 3
+rm -f $dir/interfaces
+mknod -m 0200 $dir/interfaces c $MAJOR 4
+
+i=0
+while test $i -lt $n_shelves; do
+	sh -xc "sh `dirname $0`/mkshelf.sh $dir $i"
+	i=`expr $i + 1`
+done
diff -Nru a/Documentation/aoe/mkshelf.sh b/Documentation/aoe/mkshelf.sh
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/aoe/mkshelf.sh	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,23 @@
+#! /bin/sh
+
+if test "$#" != "2"; then
+	echo "Usage: sh mkshelf.sh {dir} {shelfaddress}" 1>&2
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
diff -Nru a/Documentation/aoe/status.sh b/Documentation/aoe/status.sh
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/aoe/status.sh	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,15 @@
+# collate and present sysfs information about AoE storage
+
+set -e
+format="%8s\t%12s\t%8s\t%8s\n"
+
+printf "$format" device mac netif state
+
+for d in `ls -d /sys/block/etherd* | grep -v p`; do
+	dev=`echo "$d" | sed 's/.*!//'`
+	printf "$format" \
+		"$dev" \
+		"`cat \"$d/mac\"`" \
+		"`cat \"$d/netif\"`" \
+		"`cat \"$d/state\"`"
+done | sort
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-01-07 15:45:50 -08:00
+++ b/MAINTAINERS	2005-01-07 15:45:50 -08:00
@@ -328,6 +328,12 @@
 W:	http://julien.lerouge.free.fr
 S:	Maintained
 
+ATA OVER ETHERNET DRIVER
+P:	Ed L. Cashin
+M:	ecashin@coraid.com
+W:	http://www.coraid.com/support/linux
+S:	Supported
+
 ATM
 P:	Chas Williams
 M:	chas@cmf.nrl.navy.mil
diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2005-01-07 15:45:50 -08:00
+++ b/drivers/Makefile	2005-01-07 15:45:50 -08:00
@@ -42,6 +42,7 @@
 obj-$(CONFIG_SBUS)		+= sbus/
 obj-$(CONFIG_ZORRO)		+= zorro/
 obj-$(CONFIG_MAC)		+= macintosh/
+obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
 obj-$(CONFIG_PARIDE) 		+= block/paride/
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
diff -Nru a/drivers/block/Kconfig b/drivers/block/Kconfig
--- a/drivers/block/Kconfig	2005-01-07 15:45:50 -08:00
+++ b/drivers/block/Kconfig	2005-01-07 15:45:50 -08:00
@@ -429,4 +429,12 @@
 
 source "drivers/block/Kconfig.iosched"
 
+config ATA_OVER_ETH
+	tristate "ATA over Ethernet support"
+	depends on NET
+	default m
+	help
+	This driver provides Support for ATA over Ethernet block
+	devices like the Coraid EtherDrive (R) Storage Blade.
+
 endmenu
diff -Nru a/drivers/block/aoe/Makefile b/drivers/block/aoe/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/block/aoe/Makefile	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,6 @@
+#
+# Makefile for ATA over Ethernet
+#
+
+obj-$(CONFIG_ATA_OVER_ETH)	+= aoe.o
+aoe-objs := aoeblk.o aoechr.o aoecmd.o aoedev.o aoemain.o aoenet.o
diff -Nru a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/block/aoe/aoe.h	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,163 @@
+/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+#define VERSION "4"
+#define AOE_MAJOR 152
+#define DEVICE_NAME "aoe"
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
+struct aoe_hdr {
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
+struct aoe_atahdr {
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
+struct aoe_cfghdr {
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
+struct buf {
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
+struct frame {
+	int tag;
+	ulong waited;
+	struct buf *buf;
+	char *bufaddr;
+	int writedatalen;
+	int ndata;
+
+	/* largest possible */
+	char data[sizeof(struct aoe_hdr) + sizeof(struct aoe_atahdr)];
+};
+
+struct aoedev {
+	struct aoedev *next;
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
+	struct buf *inprocess;	/* the one we're currently working on */
+	ulong lasttag;		/* last tag sent */
+	ulong nframes;		/* number of frames below */
+	struct frame *frames;
+};
+
+
+int aoeblk_init(void);
+void aoeblk_exit(void);
+void aoeblk_gdalloc(void *);
+void aoedisk_rm_sysfs(struct aoedev *d);
+
+int aoechr_init(void);
+void aoechr_exit(void);
+void aoechr_error(char *);
+void aoechr_hdump(char *, int len);
+
+void aoecmd_work(struct aoedev *d);
+void aoecmd_cfg(ushort, unsigned char);
+void aoecmd_ata_rsp(struct sk_buff *);
+void aoecmd_cfg_rsp(struct sk_buff *);
+
+int aoedev_init(void);
+void aoedev_exit(void);
+struct aoedev *aoedev_bymac(unsigned char *);
+void aoedev_downdev(struct aoedev *d);
+struct aoedev *aoedev_set(ulong, unsigned char *, struct net_device *, ulong);
+int aoedev_busy(void);
+
+int aoenet_init(void);
+void aoenet_exit(void);
+void aoenet_xmit(struct sk_buff *);
+int is_aoe_netif(struct net_device *ifp);
+int set_aoe_iflist(char *str);
+
+u64 mac_addr(char addr[6]);
diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/block/aoe/aoeblk.c	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,251 @@
+/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
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
+#include <linux/netdevice.h>
+#include "aoe.h"
+
+/* add attributes for our block devices in sysfs
+ * (see drivers/block/genhd.c:disk_attr_show, etc.)
+ */
+struct disk_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct gendisk *, char *);
+};
+
+static ssize_t aoedisk_show_state(struct gendisk * disk, char *page)
+{
+	struct aoedev *d = disk->private_data;
+
+	return snprintf(page, PAGE_SIZE,
+			"%s%s\n",
+			(d->flags & DEVFL_UP) ? "up" : "down",
+			(d->flags & DEVFL_CLOSEWAIT) ? ",closewait" : "");
+}
+static ssize_t aoedisk_show_mac(struct gendisk * disk, char *page)
+{
+	struct aoedev *d = disk->private_data;
+
+	return snprintf(page, PAGE_SIZE, "%012llx\n", mac_addr(d->addr));
+}
+static ssize_t aoedisk_show_netif(struct gendisk * disk, char *page)
+{
+	struct aoedev *d = disk->private_data;
+
+	return snprintf(page, PAGE_SIZE, "%s\n", d->ifp->name);
+}
+
+static struct disk_attribute disk_attr_state = {
+	.attr = {.name = "state", .mode = S_IRUGO },
+	.show = aoedisk_show_state
+};
+static struct disk_attribute disk_attr_mac = {
+	.attr = {.name = "mac", .mode = S_IRUGO },
+	.show = aoedisk_show_mac
+};
+static struct disk_attribute disk_attr_netif = {
+	.attr = {.name = "netif", .mode = S_IRUGO },
+	.show = aoedisk_show_netif
+};
+
+static void
+aoedisk_add_sysfs(struct aoedev *d)
+{
+	sysfs_create_file(&d->gd->kobj, &disk_attr_state.attr);
+	sysfs_create_file(&d->gd->kobj, &disk_attr_mac.attr);
+	sysfs_create_file(&d->gd->kobj, &disk_attr_netif.attr);
+}
+void
+aoedisk_rm_sysfs(struct aoedev *d)
+{
+	sysfs_remove_link(&d->gd->kobj, "state");
+	sysfs_remove_link(&d->gd->kobj, "mac");
+	sysfs_remove_link(&d->gd->kobj, "netif");
+}
+
+static int
+aoeblk_open(struct inode *inode, struct file *filp)
+{
+	struct aoedev *d;
+
+	d = inode->i_bdev->bd_disk->private_data;
+	return (d->flags & DEVFL_UP) ? 0 : -ENODEV;
+}
+
+static int
+aoeblk_release(struct inode *inode, struct file *filp)
+{
+	struct aoedev *d;
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
+	struct aoedev *d;
+	struct buf *buf;
+	struct sk_buff *sl;
+	ulong flags;
+
+	blk_queue_bounce(q, &bio);
+
+	d = bio->bi_bdev->bd_disk->private_data;
+	buf = mempool_alloc(d->bufpool, GFP_NOIO);
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
+	struct aoedev *d;
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
+	struct aoedev *d = vp;
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
+	aoedisk_add_sysfs(d);
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
diff -Nru a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/block/aoe/aoechr.c	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,295 @@
+/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/*
+ * aoechr.c
+ * AoE character device driver
+ */
+
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include "aoe.h"
+
+enum {
+	//MINOR_STAT = 1, (moved to sysfs)
+	MINOR_ERR = 2,
+	MINOR_DISCOVER,
+	MINOR_INTERFACES,
+	MSGSZ = 2048,
+	NARGS = 10,
+	NMSG = 100,		/* message backlog to retain */
+};
+
+struct aoe_chardev {
+	ulong minor;
+	char name[32];
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
+static struct aoe_chardev chardevs[] = {
+	{ MINOR_ERR, "err" },
+	{ MINOR_DISCOVER, "discover" },
+	{ MINOR_INTERFACES, "interfaces" },
+};
+
+static int
+discover(void)
+{
+	aoecmd_cfg(0xffff, 0xff);
+	return 0;
+}
+
+static int
+interfaces(char *str)
+{
+	if (set_aoe_iflist(str)) {
+		printk(KERN_CRIT
+		       "%s: could not set interface list: %s\n",
+		       __FUNCTION__, "too many interfaces");
+		return -EINVAL;
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
+	str[cnt] = '\0';
+	ret = -EINVAL;
+	switch ((unsigned long) filp->private_data) {
+	default:
+		printk(KERN_INFO "aoe: aoechr_write: can't write to that file.\n");
+		break;
+	case MINOR_DISCOVER:
+		ret = discover();
+		break;
+	case MINOR_INTERFACES:
+		ret = interfaces(str);
+		break;
+	}
+	if (ret == 0)
+		ret = cnt;
+ out:
+	kfree(str);
+	return ret;
+}
+
+static int
+aoechr_open(struct inode *inode, struct file *filp)
+{
+	int n, i;
+
+	n = MINOR(inode->i_rdev);
+	filp->private_data = (void *) (unsigned long) n;
+
+	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
+		if (chardevs[i].minor == n)
+			return 0;
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
+	int n, i;
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
+	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
+		class_simple_device_add(aoe_class,
+					MKDEV(AOE_MAJOR, chardevs[i].minor),
+					NULL, chardevs[i].name);
+
+	return 0;
+}
+
+void __exit
+aoechr_exit(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
+		class_simple_device_remove(MKDEV(AOE_MAJOR, chardevs[i].minor));
+	class_simple_destroy(aoe_class);
+	unregister_chrdev(AOE_MAJOR, "aoechr");
+}
+
diff -Nru a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/block/aoe/aoecmd.c	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,627 @@
+/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
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
+skb_prepare(struct aoedev *d, struct frame *f)
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
+		p += sizeof(struct aoe_hdr) + sizeof(struct aoe_atahdr);
+		memcpy(p, f->bufaddr, f->writedatalen);
+	}
+
+	return skb;
+}
+
+static struct frame *
+getframe(struct aoedev *d, int tag)
+{
+	struct frame *f, *e;
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
+newtag(struct aoedev *d)
+{
+	register ulong n;
+
+	n = jiffies & 0xffff;
+	return n |= (++d->lasttag & 0x7fff) << 16;
+}
+
+static int
+aoehdr_atainit(struct aoedev *d, struct aoe_hdr *h)
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
+aoecmd_ata_rw(struct aoedev *d, struct frame *f)
+{
+	struct aoe_hdr *h;
+	struct aoe_atahdr *ah;
+	struct buf *buf;
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
+	h = (struct aoe_hdr *) f->data;
+	ah = (struct aoe_atahdr *) (h+1);
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
+aoecmd_work(struct aoedev *d)
+{
+	struct frame *f;
+	struct buf *buf;
+loop:
+	f = getframe(d, FREETAG);
+	if (f == NULL)
+		return;
+	if (d->inprocess == NULL) {
+		if (list_empty(&d->bufq))
+			return;
+		buf = container_of(d->bufq.next, struct buf, bufs);
+		list_del(d->bufq.next);
+/*printk(KERN_INFO "aoecmd_work: bi_size=%ld\n", buf->bio->bi_size); */
+		d->inprocess = buf;
+	}
+	aoecmd_ata_rw(d, f);
+	goto loop;
+}
+
+static void
+rexmit(struct aoedev *d, struct frame *f)
+{
+	struct sk_buff *skb;
+	struct aoe_hdr *h;
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
+	h = (struct aoe_hdr *) f->data;
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
+	struct aoedev *d;
+	struct frame *f, *e;
+	struct sk_buff *sl;
+	register long timeout;
+	ulong flags, n;
+
+	d = (struct aoedev *) vp;
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
+ataid_complete(struct aoedev *d, unsigned char *id)
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
+calc_rttavg(struct aoedev *d, int rtt)
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
+	struct aoedev *d;
+	struct aoe_hdr *hin;
+	struct aoe_atahdr *ahin, *ahout;
+	struct frame *f;
+	struct buf *buf;
+	struct sk_buff *sl;
+	register long n;
+	ulong flags;
+	char ebuf[128];
+	
+	hin = (struct aoe_hdr *) skb->mac.raw;
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
+	ahin = (struct aoe_atahdr *) (hin+1);
+	ahout = (struct aoe_atahdr *) (f->data + sizeof(struct aoe_hdr));
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
+	struct aoe_hdr *h;
+	struct aoe_cfghdr *ch;
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
+		h = (struct aoe_hdr *) skb->mac.raw;
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
+aoecmd_ata_id(struct aoedev *d)
+{
+	struct aoe_hdr *h;
+	struct aoe_atahdr *ah;
+	struct frame *f;
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
+	h = (struct aoe_hdr *) f->data;
+	ah = (struct aoe_atahdr *) (h+1);
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
+	struct aoedev *d;
+	struct aoe_hdr *h;
+	struct aoe_cfghdr *ch;
+	ulong flags, bufcnt, sysminor, aoemajor;
+	struct sk_buff *sl;
+	enum { MAXFRAMES = 8, MAXSYSMINOR = 255 };
+
+	h = (struct aoe_hdr *) skb->mac.raw;
+	ch = (struct aoe_cfghdr *) (h+1);
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
diff -Nru a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/block/aoe/aoedev.c	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,194 @@
+/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
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
+static struct aoedev *devlist;
+static spinlock_t devlist_lock;
+static kmem_cache_t *buf_pool_cache;
+
+struct aoedev *
+aoedev_bymac(unsigned char *macaddr)
+{
+	struct aoedev *d;
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
+static struct aoedev *
+aoedev_newdev(ulong nframes)
+{
+	struct aoedev *d;
+	struct frame *f, *e;
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
+aoedev_downdev(struct aoedev *d)
+{
+	struct frame *f, *e;
+	struct buf *buf;
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
+		buf = container_of(d->bufq.next, struct buf, bufs);
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
+struct aoedev *
+aoedev_set(ulong sysminor, unsigned char *addr, struct net_device *ifp, ulong bufcnt)
+{
+	struct aoedev *d;
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
+aoedev_freedev(struct aoedev *d)
+{
+	if (d->gd) {
+		aoedisk_rm_sysfs(d);
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
+	struct aoedev *d;
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
+					   sizeof(struct buf),
+					   0, 0, NULL, NULL);
+	if (buf_pool_cache == NULL)
+		return -ENOMEM;
+	spin_lock_init(&devlist_lock);
+	return 0;
+}
+
diff -Nru a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/block/aoe/aoemain.c	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,93 @@
+/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
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
+MODULE_VERSION(VERSION);
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
+	printk(KERN_INFO
+	       "aoe: aoe_init: AoE v2.6-%s initialised.\n",
+	       VERSION);
+
+	discover_timer(TINIT);
+	return 0;
+}
+
+module_init(aoe_init);
+module_exit(aoe_exit);
+
diff -Nru a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/block/aoe/aoenet.c	2005-01-07 15:45:50 -08:00
@@ -0,0 +1,173 @@
+/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
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
+	struct aoe_hdr *h;
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
+	h = (struct aoe_hdr *) skb->mac.raw;
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

