Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbULFP4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbULFP4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbULFP4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:56:05 -0500
Received: from ns1.coraid.com ([65.14.39.133]:46827 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261543AbULFPxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:53:01 -0500
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ATA over Ethernet driver for 2.6.9
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 06 Dec 2004 10:51:46 -0500
Message-ID: <87acsrqval.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

The included patch allows the Linux kernel to use the ATA over
Ethernet (AoE) network protocol to communicate with any block device
that handles the AoE protocol.  The Coraid EtherDrive (R) Storage
Blade is the first hardware using AoE.

AoE devices on the LAN are accessable as block devices and can be used
with filesystems, Software RAID, LVM, etc.

Like IP, AoE is an ethernet-level network protocol, registered with
the IEEE.  Unlike IP, AoE is not routable.

This patch is released under the terms of the GPL.

(We also have an AoE driver for the 2.4 kernel that we plan to release
soon.)


Provide support for ATA over Ethernet devices

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=patch-aoe-2.6-2

diff -urpN linux-2.6.9/Documentation/aoe.txt linux-2.6.9-aoe/Documentation/aoe.txt
--- linux-2.6.9/Documentation/aoe.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/Documentation/aoe.txt	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,58 @@
+The EtherDrive (R) HOWTO for users of 2.6 kernels is found at ...
+
+  http://www.coraid.com/support/linux/EtherDrive-2.6-HOWTO.html
+
+  It has many tips and hints!
+
+CREATING DEVICE NODES
+
+  Two scripts are in scripts/aoe for assisting in creating device
+  nodes for using the aoe driver.  Usage is as follows.
+
+    rm -rf /dev/etherd
+    sh scripts/mkdevs /dev/etherd
+
+  ... or to make just one shelf's worth of block device nodes ...
+
+    sh mkshelf /dev/etherd 0
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
diff -urpN linux-2.6.9/MAINTAINERS linux-2.6.9-aoe/MAINTAINERS
--- linux-2.6.9/MAINTAINERS	2004-11-30 08:22:27.000000000 -0500
+++ linux-2.6.9-aoe/MAINTAINERS	2004-12-06 10:40:00.000000000 -0500
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
diff -urpN linux-2.6.9/drivers/Makefile linux-2.6.9-aoe/drivers/Makefile
--- linux-2.6.9/drivers/Makefile	2004-11-30 08:22:33.000000000 -0500
+++ linux-2.6.9-aoe/drivers/Makefile	2004-12-06 10:40:00.000000000 -0500
@@ -41,6 +41,7 @@ obj-$(CONFIG_DIO)		+= dio/
 obj-$(CONFIG_SBUS)		+= sbus/
 obj-$(CONFIG_ZORRO)		+= zorro/
 obj-$(CONFIG_MAC)		+= macintosh/
+obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
 obj-$(CONFIG_PARIDE) 		+= block/paride/
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
diff -urpN linux-2.6.9/drivers/block/Kconfig linux-2.6.9-aoe/drivers/block/Kconfig
--- linux-2.6.9/drivers/block/Kconfig	2004-11-30 08:22:33.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/Kconfig	2004-12-06 10:40:00.000000000 -0500
@@ -357,5 +357,6 @@ config LBD
 	  bigger than 2TB.  Otherwise say N.
 
 source "drivers/s390/block/Kconfig"
+source "drivers/block/aoe/Kconfig"
 
 endmenu
diff -urpN linux-2.6.9/drivers/block/aoe/Kconfig linux-2.6.9-aoe/drivers/block/aoe/Kconfig
--- linux-2.6.9/drivers/block/aoe/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/Kconfig	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,10 @@
+#
+# ATA over Ethernet configuration
+#
+config ATA_OVER_ETH
+	tristate "ATA over Ethernet support"
+	depends on NET
+	default m
+	help
+	This driver provides Support for ATA over Ethernet block
+	devices like the Coraid EtherDrive (R) Storage Blade.
diff -urpN linux-2.6.9/drivers/block/aoe/Makefile linux-2.6.9-aoe/drivers/block/aoe/Makefile
--- linux-2.6.9/drivers/block/aoe/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/Makefile	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,6 @@
+#
+# Makefile for ATA over Ethernet
+#
+
+obj-$(CONFIG_ATA_OVER_ETH)	+= aoe.o
+aoe-objs := aoeblk.o aoechr.o aoecmd.o aoedev.o aoemain.o aoenet.o aoeutils.o
diff -urpN linux-2.6.9/drivers/block/aoe/all.h linux-2.6.9-aoe/drivers/block/aoe/all.h
--- linux-2.6.9/drivers/block/aoe/all.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/all.h	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,156 @@
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/blkpg.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/ioctl.h>
+#include <linux/if.h>
+#include <linux/netdevice.h>
+#include <linux/kdev_t.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/timer.h>
+#include <linux/genhd.h>
+#include <asm/uaccess.h>
+#include <asm/namei.h>
+#include <asm/semaphore.h>
+#include "u.h"
+#include "if_aoe.h"
+
+#define VER 2
+#define nil NULL
+#define nelem(A) (sizeof (A) / sizeof (A)[0])
+#define AOE_MAJOR 152
+#define ROOT_PATH "/dev/etherd/"
+#define PATHLEN (strlen(ROOT_PATH) + 8)
+#define MAX_ARGS 16
+#define DEVICE_NAME "aoe"
+#define DEVICE_NO_RANDOM
+#define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * 10 + (aoeminor))
+#define AOEMAJOR(sysminor) ((sysminor) / 10)
+#define AOEMINOR(sysminor) ((sysminor) % 10)
+
+enum {
+	DEVFL_UP = 1,		/* device is installed in system and ready for AoE->ATA commands */
+	DEVFL_TKILL = (1<<1),	/* flag for timer to know when to kill self */
+	DEVFL_EXT = (1<<2),	/* device accepts lba48 commands */
+	DEVFL_CLOSEWAIT = (1<<3),	/* device is waiting for all closes to revalidate */
+	DEVFL_WC_UPDATE = (1<<4),	/* this device needs to update write cache status */
+	DEVFL_WORKON = (1<<4),
+
+	BUFFL_FAIL = 1,
+
+	MAXATADATA = 1024,
+	NPERSHELF = 10,
+	FREETAG = -1,
+};
+
+typedef struct Buf Buf;
+struct Buf {
+	Buf *next;
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
+typedef struct Bufq Bufq;
+struct Bufq {
+	Buf *head, *tail;
+};
+
+typedef struct Frame Frame;
+struct Frame {
+	int tag;
+	ulong waited;
+	Buf *buf;
+	char *bufaddr;
+	int writedatalen;
+	int ndata;
+	char data[sizeof (Aoehdr) + sizeof (Aoeahdr)];	/* largest possible */
+};
+
+typedef struct Aoedev Aoedev;
+struct Aoedev {
+	Aoedev *next;
+	uchar addr[6];		/* remote mac addr */
+	ushort flags;
+	ulong sysminor;
+	ulong aoemajor;
+	ulong aoeminor;
+	ulong nopen;		/* user count */
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
+	Bufq bufq;		/* queue of bh work */
+	Buf *inprocess;		/* the one we're currently working on */
+	ulong lasttag;		/* last tag sent */
+	ulong nframes;		/* number of frames below */
+	Frame *frames;
+};
+
+int aoeblk_init(void);
+void aoeblk_exit(void);
+int aoeblk_make_request(request_queue_t *, struct bio *);
+void aoeblk_gdalloc(void *);
+
+int aoechr_init(void);
+void aoechr_exit(void);
+void aoechr_error(char *);
+void aoechr_hdump(char *, int len);
+
+void aoecmd_work(Aoedev *d);
+void aoecmd_cfg(ushort, uchar);
+void aoecmd_ata_rsp(struct sk_buff *);
+void aoecmd_cfg_rsp(struct sk_buff *);
+
+int aoedev_init(void);
+void aoedev_exit(void);
+int aoedev_stat(char *, int, loff_t);
+Aoedev *aoedev_bymac(uchar *);
+Aoedev *aoedev_byminor(ulong);
+void aoedev_downdev(Aoedev *d);
+Aoedev *aoedev_set(ulong, uchar *, struct net_device *, ulong);
+int aoedev_busy(void);
+void aoedev_freedev(Aoedev *);
+
+int aoenet_init(void);
+void aoenet_exit(void);
+void aoenet_xmit(struct sk_buff *);
+int is_aoe_netif(struct net_device *ifp);
+int set_aoe_iflist(int argc, char **argv);
+
+void bufq_enqueue(Bufq *, Buf *);
+Buf *bufq_dequeue(Bufq *);
+struct sk_buff *new_skb(struct net_device *, ulong);
+u64 mac_addr(char addr[6]);
+void *kallocz(ulong, ulong);
+u16 nhget16(uchar *);
+u32 nhget32(uchar *);
+void hnput16(uchar *, u16);
+void hnput32(uchar *, u32);
+u16 lhget16(uchar *);
+u32 lhget32(uchar *);
+u64 lhget64(uchar *);
+
+enum { FQUOTE = (1<<0), FEMPTY = (1<<1) };
+int getfields(char *, char **, int, char *, int);
+#define tokenize(A, B, C) getfields(A, B, C, " \t\r\n", FQUOTE)
diff -urpN linux-2.6.9/drivers/block/aoe/aoeblk.c linux-2.6.9-aoe/drivers/block/aoe/aoeblk.c
--- linux-2.6.9/drivers/block/aoe/aoeblk.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoeblk.c	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,194 @@
+/*
+ * aoeblk.c
+ * block device routines
+ */
+
+#include "all.h"
+
+static int
+aoeblk_open(struct inode *inode, struct file *filp)
+{
+	Aoedev *d;
+	ulong flags;
+
+	d = (Aoedev *) inode->i_bdev->bd_disk->private_data;
+	spin_lock_irqsave(&d->lock, flags);
+	if (d->flags & DEVFL_UP) {
+		d->nopen++;
+		spin_unlock_irqrestore(&d->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&d->lock, flags);
+	return -ENODEV;
+}
+
+static int
+aoeblk_release(struct inode *inode, struct file *filp)
+{
+	Aoedev *d;
+	ulong flags;
+
+	d = (Aoedev *) inode->i_bdev->bd_disk->private_data;
+
+	spin_lock_irqsave(&d->lock, flags);
+	if (--d->nopen == 0)
+	if ((d->flags & DEVFL_CLOSEWAIT)) {
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
+int
+aoeblk_make_request(request_queue_t *q, struct bio *bio)
+{
+	Aoedev *d;
+	Buf *buf;
+	struct sk_buff *sl;
+	ulong flags;
+
+	blk_queue_bounce(q, &bio);
+
+	buf = kallocz(sizeof *buf, GFP_KERNEL);
+	if (buf == nil) {
+		printk(KERN_INFO "aoe: aoeblk_make_request: buf allocation "
+			"failure\n");
+		bio_endio(bio, bio->bi_size, -ENOMEM);
+		return 0;
+	}
+	buf->bio = bio;
+	buf->resid = bio->bi_size;
+	buf->sector = bio->bi_sector;
+	buf->bv = buf->bio->bi_io_vec;
+	buf->bv_resid = buf->bv->bv_len;
+	buf->bufaddr = page_address(buf->bv->bv_page) + buf->bv->bv_offset;
+
+	d = (Aoedev *) bio->bi_bdev->bd_disk->private_data;
+
+	spin_lock_irqsave(&d->lock, flags);
+
+	if ((d->flags & DEVFL_UP) == 0) {
+		printk(KERN_INFO "aoe: aoeblk_make_request: device %ld.%ld is not up\n",
+			d->aoemajor, d->aoeminor);
+		spin_unlock_irqrestore(&d->lock, flags);
+		kfree(buf);
+		bio_endio(bio, bio->bi_size, -ENXIO);
+		return 0;
+	}
+
+	bufq_enqueue(&d->bufq, buf);
+	aoecmd_work(d);
+
+	sl = d->skblist;
+	d->skblist = nil;
+
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	aoenet_xmit(sl);
+	return 0;
+}
+
+static int
+aoeblk_ioctl(struct inode *inode, struct file *filp, uint cmd, ulong arg)
+{
+	Aoedev *d;
+
+	if (!arg)
+		return -EINVAL;
+
+	d = (Aoedev *) inode->i_bdev->bd_disk->private_data;
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
+
+	/* We should return -ENOTTY for unrecognized ioctls later
+	 * when everyone's running kernels that support it.  See,
+                * e.g., BLKFLSBUF in ioctl.c:blkdev_ioctl.
+                */
+	return -EINVAL;
+
+}
+
+static struct block_device_operations aoe_bdops = {
+	open:			aoeblk_open,
+	release:		aoeblk_release,
+	ioctl:			aoeblk_ioctl,
+	owner:			THIS_MODULE,
+};
+
+/* alloc_disk and add_disk can sleep */
+void
+aoeblk_gdalloc(void *vp)
+{
+	Aoedev *d = vp;
+	struct gendisk *gd;
+	ulong flags;
+	enum { NPARTITIONS = 16 };
+
+	gd = alloc_disk(NPARTITIONS);
+
+	spin_lock_irqsave(&d->lock, flags);
+
+	if (gd == nil) {
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
+void
+aoeblk_exit(void)
+{
+	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
+}
+
+int
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
diff -urpN linux-2.6.9/drivers/block/aoe/aoechr.c linux-2.6.9-aoe/drivers/block/aoe/aoechr.c
--- linux-2.6.9/drivers/block/aoe/aoechr.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoechr.c	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,293 @@
+/*
+ * aoechr.c
+ * AoE character device driver for {ctl,raw,err} files
+ */
+
+#include "all.h"
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
+typedef struct {
+	char *name;
+	int (*f)(int, char **);
+} Cmd;
+
+enum { EMFL_VALID = 1 };
+
+typedef struct ErrMsg ErrMsg;
+struct ErrMsg {
+	short flags;
+	short len;
+	char *msg;
+};
+
+static ErrMsg emsgs[NMSG];
+static int emsgs_head_idx, emsgs_tail_idx;
+static struct semaphore emsgs_sema;
+static spinlock_t emsgs_lock;
+static int nblocked_emsgs_readers;
+
+static int
+discover_cmd(int n, char **p)
+{
+	aoecmd_cfg(0xffff, 0xff);
+	return 0;
+}
+
+static int
+interfaces_cmd(int argc, char **argv)
+{
+	if (set_aoe_iflist(argc, argv)) {
+		printk(KERN_CRIT
+		       "%s: could not set inteface list: %s\n",
+		       __FUNCTION__, "too many interfaces");
+		return -1;
+	}
+	return 0;
+}
+
+static int
+cmd_handler(int argc, char *argv[])
+{
+	Cmd *cmdp;
+	static Cmd aoe_cmds[] = {
+		{ "discover", discover_cmd },
+		{ "interfaces", interfaces_cmd },
+		{ nil, nil }
+	};
+
+	for (cmdp = aoe_cmds; cmdp->name; cmdp++)
+		if (!strcmp(cmdp->name, *argv))
+			return cmdp->f(argc, argv);
+	return 0;
+}
+
+void
+aoechr_error(char *msg)
+{
+	ErrMsg *em;
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
+	if (mp == nil) {
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
+	emsgs_tail_idx %= nelem(emsgs);
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
+ssize_t
+aoechr_write(struct file *filp, const char *buf, size_t cnt, loff_t *offp)
+{
+	char *argv[NARGS];
+	char *str = kallocz(cnt+1, GFP_KERNEL);
+	int argc;
+	int ret = -1;
+
+	if (!str) {
+		printk(KERN_CRIT "aoe: aoechr_write: cannot allocate memory\n");
+		return ret;
+	}
+
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
+		argc = tokenize(str, argv, NARGS);
+		if (!argc) 
+			printk(KERN_INFO "aoe: aoechr_write: parse error\n");
+		else if (cmd_handler(argc, argv))
+			ret = cnt;
+	}
+ out:
+	kfree(str);
+	return ret;
+}
+
+int
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
+	return -1;
+}
+
+int
+aoechr_rel(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+ssize_t
+aoechr_read(struct file *filp, char *buf, size_t cnt, loff_t *off)
+{
+	int n;
+	char *mp;
+	ErrMsg *em;
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
+		em->msg = nil;
+		em->flags &= ~EMFL_VALID;
+
+		emsgs_head_idx++;
+		emsgs_head_idx %= nelem(emsgs);
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
+	write:		aoechr_write,
+	read: 		aoechr_read,
+	open:		aoechr_open,
+	release:  	aoechr_rel,
+	owner:		THIS_MODULE,
+};
+
+int
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
+	return 0;
+}
+
+void
+aoechr_exit(void)
+{
+	unregister_chrdev(AOE_MAJOR, "aoechr");
+}
+
diff -urpN linux-2.6.9/drivers/block/aoe/aoecmd.c linux-2.6.9-aoe/drivers/block/aoe/aoecmd.c
--- linux-2.6.9/drivers/block/aoe/aoecmd.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoecmd.c	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,583 @@
+/*
+ * aoecmd.c
+ * Filesystem request handling methods
+ */
+
+#include "all.h"
+
+#define TIMERTICK (HZ / 10)
+#define MINTIMER (2 * TIMERTICK)
+#define MAXTIMER (HZ << 1)
+#define MAXWAIT (60 * 3)	/* After MAXWAIT seconds, give up and fail dev */
+
+static struct sk_buff *
+skb_prepare(Aoedev *d, Frame *f)
+{
+	struct sk_buff *skb;
+	char *p;
+
+	skb = new_skb(d->ifp, f->ndata + f->writedatalen);
+	if (!skb) {
+		printk(KERN_INFO "aoe: skb_prepare: failure to allocate skb\n");
+		return nil;
+	}
+
+	p = skb->mac.raw;
+	memcpy(p, f->data, f->ndata);
+
+	if (f->writedatalen) {
+		p += sizeof(Aoehdr) + sizeof(Aoeahdr);
+		memcpy(p, f->bufaddr, f->writedatalen);
+	}
+
+	return skb;
+}
+
+static Frame *
+getframe(Aoedev *d, int tag)
+{
+	Frame *f, *e;
+
+	f = d->frames;
+	e = f + d->nframes;
+	for (; f<e; f++)
+		if (f->tag == tag)
+			return f;
+	return nil;
+}
+
+/*
+ * Leave the top bit clear so we have tagspace for userland.
+ * The bottom 16 bits are the xmit tick for rexmit/rttavg processing.
+ * This driver reserves tag -1 to mean "unused frame."
+ */
+static int
+newtag(Aoedev *d)
+{
+	register ulong n;
+
+	n = jiffies & 0xffff;
+	return n |= (++d->lasttag & 0x7fff) << 16;
+}
+
+static int
+aoehdr_atainit(Aoedev *d, Aoehdr *h)
+{
+	int n;
+
+	memcpy(h->src, d->ifp->dev_addr, sizeof h->src);
+	memcpy(h->dst, d->addr, sizeof h->dst);
+	hnput16(h->type, ETH_P_AOE);
+	h->verfl = AOE_HVER;
+	hnput16(h->major, d->aoemajor);
+	h->minor = d->aoeminor;
+	h->cmd = AOECMD_ATA;
+	hnput32(h->tag, n = newtag(d));
+	return n;
+}
+
+static void
+aoecmd_ata_rw(Aoedev *d, Frame *f)
+{
+	Aoehdr *h;
+	Aoeahdr *ah;
+	Buf *buf;
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
+	h = (Aoehdr *) f->data;
+	ah = (Aoeahdr *) (h+1);
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
+		d->inprocess = nil;
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
+aoecmd_work(Aoedev *d)
+{
+	Frame *f;
+	Buf *buf;
+loop:
+	f = getframe(d, FREETAG);
+	if (f == nil)
+		return;
+	if (d->inprocess == nil) {
+		buf = bufq_dequeue(&d->bufq);
+		if (buf == nil)
+			return;
+/*printk(KERN_INFO "aoecmd_work: bi_size=%ld\n", buf->bio->bi_size); */
+		d->inprocess = buf;
+	}
+	aoecmd_ata_rw(d, f);
+	goto loop;
+}
+
+static void
+rexmit(Aoedev *d, Frame *f)
+{
+	struct sk_buff *skb;
+	Aoehdr *h;
+	char buf[128];
+	int n;
+
+	n = newtag(d);
+
+	snprintf(buf, sizeof buf,
+		"%15s e%ld.%ld oldtag=%08x@%08lx newtag=%08x\n",
+		"retransmit",
+		d->aoemajor, d->aoeminor, f->tag, jiffies, n);
+	aoechr_error(buf);
+
+	h = (Aoehdr *) f->data;
+	hnput32(h->tag, f->tag = n);
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
+	Aoedev *d;
+	Frame *f, *e;
+	struct sk_buff *sl;
+	register long timeout;
+	ulong flags, n;
+
+	d = (Aoedev *) vp;
+	sl = nil;
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
+		if (f->tag != FREETAG)
+		if (tsince(f->tag) >= timeout) {
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
+	d->skblist = nil;
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
+ataid_complete(Aoedev *d, uchar *id)
+{
+	u64 ssize;
+	u16 n;
+
+	n = lhget16(id + (83<<1)); /* word 83: command set supported */
+	n |= lhget16(id + (86<<1)); /* word 86: command set/feature enabled */
+
+	if (n & (1<<10)) {	/* bit 10: LBA 48 */
+		d->flags |= DEVFL_EXT;
+
+		ssize = lhget64(id + (100<<1));	/* n lba48 sectors */
+
+		/* set as in ide-disk.c:init_idedisk_capacity */
+		d->geo.cylinders = ssize;
+		d->geo.cylinders /= (255 * 63);
+		d->geo.heads = 255;
+		d->geo.sectors = 63;
+	} else {
+		d->flags &= ~DEVFL_EXT;
+
+		ssize = lhget32(id + (60<<1));	/* n lba28 sectors */
+
+		/* NOTE: obsolete in ATA 6 */
+		d->geo.cylinders = lhget16(id + (54<<1));
+		d->geo.heads = lhget16(id + (55<<1));
+		d->geo.sectors = lhget16(id + (56<<1));
+	}
+	d->ssize = ssize;
+	d->geo.start = 0;
+	if (d->gd != nil) {
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
+calc_rttavg(Aoedev *d, int rtt)
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
+	Aoedev *d;
+	Aoehdr *hin;
+	Aoeahdr *ahin, *ahout;
+	Frame *f;
+	Buf *buf;
+	struct sk_buff *sl;
+	register long n;
+	ulong flags;
+	char ebuf[128];
+	
+	hin = (Aoehdr *) skb->mac.raw;
+	d = aoedev_bymac(hin->src);
+	if (d == nil) {
+		snprintf(ebuf, sizeof ebuf, "aoecmd_ata_rsp: ata response "
+			"for unknown device %d.%d\n", nhget16(hin->major),
+			hin->minor);
+		aoechr_error(ebuf);
+		return;
+	}
+
+	spin_lock_irqsave(&d->lock, flags);
+
+	f = getframe(d, nhget32(hin->tag));
+	if (f == nil) {
+		spin_unlock_irqrestore(&d->lock, flags);
+		snprintf(ebuf, sizeof ebuf,
+			"%15s e%d.%d    tag=%08x@%08lx\n",
+			"unexpected rsp",
+			nhget16(hin->major), hin->minor,
+			nhget32(hin->tag),
+			jiffies);
+		aoechr_error(ebuf);
+		return;
+	}
+
+	calc_rttavg(d, tsince(f->tag));
+
+	ahin = (Aoeahdr *) (hin+1);
+	ahout = (Aoeahdr *) (f->data + sizeof (Aoehdr));
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
+				"outbound ata command %2.2Xh for %d.%d\n", 
+				ahout->cmdstat, nhget16(hin->major), hin->minor);
+		}
+	}
+
+	if (buf) {
+		buf->nframesout -= 1;
+		if (buf->nframesout == 0)
+		if (buf->resid == 0) {
+			n = !(buf->flags & BUFFL_FAIL);
+			bio_endio(buf->bio, buf->bio->bi_size, 0);
+			kfree(buf);
+		}
+	}
+
+	f->buf = nil;
+	f->tag = FREETAG;
+
+	aoecmd_work(d);
+
+	sl = d->skblist;
+	d->skblist = nil;
+
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	aoenet_xmit(sl);
+}
+
+void
+aoecmd_cfg(ushort aoemajor, uchar aoeminor)
+{
+	Aoehdr *h;
+	Aoechdr *ch;
+	struct sk_buff *skb, *sl;
+	struct net_device *ifp;
+
+	sl = nil;
+
+	read_lock(&dev_base_lock);
+	for (ifp = dev_base; ifp; dev_put(ifp), ifp = ifp->next) {
+		dev_hold(ifp);
+		if (!is_aoe_netif(ifp))
+			continue;
+
+		skb = new_skb(ifp, sizeof *h + sizeof *ch);
+		if (skb == nil) {
+			printk(KERN_INFO "aoe: aoecmd_cfg: skb alloc failure\n");
+			continue;
+		}
+		h = (Aoehdr *) skb->mac.raw;
+		memset(h, 0, sizeof *h + sizeof *ch);
+
+		memset(h->dst, 0xff, sizeof h->dst);
+		memcpy(h->src, ifp->dev_addr, sizeof h->src);
+		hnput16(h->type, ETH_P_AOE);
+		h->verfl = AOE_HVER;
+		hnput16(h->major, aoemajor);
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
+aoecmd_ata_id(Aoedev *d)
+{
+	Aoehdr *h;
+	Aoeahdr *ah;
+	Frame *f;
+	struct sk_buff *skb;
+
+	f = getframe(d, FREETAG);
+	if (f == nil) {
+		printk(KERN_CRIT "aoe: aoecmd_ata_id: can't get a frame.  "
+			"This shouldn't happen.\n");
+		return nil;
+	}
+
+	/* initialize the headers & frame */
+	h = (Aoehdr *) f->data;
+	ah = (Aoeahdr *) (h+1);
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
+	Aoedev *d;
+	Aoehdr *h;
+	Aoechdr *ch;
+	ulong flags, bufcnt, sysminor, aoemajor;
+	struct sk_buff *sl;
+	enum { MAXFRAMES = 8, MAXSYSMINOR = 255 };
+
+	h = (Aoehdr *) skb->mac.raw;
+	ch = (Aoechdr *) (h+1);
+
+	/*
+	 * Enough people have their dip switches set backwards to
+	 * warrant a loud message for this special case.
+	 */
+	aoemajor = nhget16(h->major);
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
+	bufcnt = nhget16(ch->bufcnt);
+	if (bufcnt > MAXFRAMES)	/* keep it reasonable */
+		bufcnt = MAXFRAMES;
+
+	d = aoedev_set(sysminor, h->src, skb->dev, bufcnt);
+	if (d == nil) {
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
+	d->fw_ver = nhget16(ch->fwver);
+
+	/* we get here only if the device is new */
+	sl = aoecmd_ata_id(d);
+
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	aoenet_xmit(sl);
+}
+
diff -urpN linux-2.6.9/drivers/block/aoe/aoedev.c linux-2.6.9-aoe/drivers/block/aoe/aoedev.c
--- linux-2.6.9/drivers/block/aoe/aoedev.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoedev.c	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,233 @@
+/*
+ * aoedev.c
+ * AoE device utility functions; maintains device list.
+ */
+
+#include "all.h"
+
+static Aoedev *devlist;
+static spinlock_t devlist_lock;
+
+int
+aoedev_stat(char *ubuf, int buflen, loff_t off)
+{
+	Aoedev *d;
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
+Aoedev *
+aoedev_byminor(ulong sysminor)
+{
+	Aoedev *d;
+	ulong flags;
+
+	spin_lock_irqsave(&devlist_lock, flags);
+
+	for (d=devlist; d; d=d->next)
+		if (d->sysminor == sysminor)
+			break;
+
+	spin_unlock_irqrestore(&devlist_lock, flags);
+	return d;
+}
+
+Aoedev *
+aoedev_bymac(uchar *macaddr)
+{
+	Aoedev *d;
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
+static Aoedev *
+aoedev_newdev(ulong nframes)
+{
+	Aoedev *d;
+	Frame *f, *e;
+
+	d = (Aoedev *) kallocz(sizeof *d, GFP_ATOMIC);
+	if (d == nil)
+		return nil;
+	f = (Frame *) kallocz(nframes * sizeof *f, GFP_ATOMIC);
+	if (f == nil) {
+		kfree(d);
+		return nil;
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
+
+	d->next = devlist;
+	devlist = d;
+
+	return d;
+}
+
+void
+aoedev_downdev(Aoedev *d)
+{
+	Frame *f, *e;
+	Buf *buf;
+	struct bio *bio;
+
+	d->flags |= DEVFL_TKILL;
+	del_timer(&d->timer);
+
+	f = d->frames;
+	e = f + d->nframes;
+	for (; f<e; f->tag = FREETAG, f->buf = nil, f++) {
+		if (f->tag == FREETAG || f->buf == nil)
+			continue;
+		buf = f->buf;
+		bio = buf->bio;
+		if (--buf->nframesout == 0) {
+			kfree(buf);
+			bio_endio(bio, bio->bi_size, -EIO);
+		}
+	}
+	d->inprocess = nil;
+
+	while ((buf = bufq_dequeue(&d->bufq))) {
+		bio = buf->bio;
+		kfree(buf);
+		bio_endio(bio, bio->bi_size, -EIO);
+	}
+
+	if (d->nopen)
+		d->flags |= DEVFL_CLOSEWAIT;
+	if (d->gd)
+		d->gd->capacity = 0;
+
+	d->flags &= ~DEVFL_UP;
+}
+
+Aoedev *
+aoedev_set(ulong sysminor, uchar *addr, struct net_device *ifp, ulong bufcnt)
+{
+	Aoedev *d;
+	ulong flags;
+
+	spin_lock_irqsave(&devlist_lock, flags);
+
+	for (d=devlist; d; d=d->next)
+		if (d->sysminor == sysminor
+		|| memcmp(d->addr, addr, sizeof d->addr) == 0)
+			break;
+
+	if (d == nil)
+	if ((d = aoedev_newdev(bufcnt)) == nil) {
+		spin_unlock_irqrestore(&devlist_lock, flags);
+		printk(KERN_INFO "aoe: aoedev_set: aoedev_newdev failure.\n");
+		return nil;
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
+void
+aoedev_freedev(Aoedev *d)
+{
+	if (d->gd) {
+		del_gendisk(d->gd);
+		put_disk(d->gd);
+	}
+	kfree(d->frames);
+	kfree(d);
+}
+
+void
+aoedev_exit(void)
+{
+	Aoedev *d;
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
+}
+
+int
+aoedev_init(void)
+{
+	spin_lock_init(&devlist_lock);
+	return 0;
+}
+
diff -urpN linux-2.6.9/drivers/block/aoe/aoemain.c linux-2.6.9-aoe/drivers/block/aoe/aoemain.c
--- linux-2.6.9/drivers/block/aoe/aoemain.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoemain.c	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,84 @@
+/*
+ * aoemain.c
+ * Module initialization routines, discover timer
+ */
+
+#include "all.h"
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
+	int (*fns[])(void) = { aoedev_init, aoechr_init, aoeblk_init, aoenet_init, nil };
+
+	for (p=fns; *p != nil; p++) {
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
diff -urpN linux-2.6.9/drivers/block/aoe/aoenet.c linux-2.6.9-aoe/drivers/block/aoe/aoenet.c
--- linux-2.6.9/drivers/block/aoe/aoenet.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoenet.c	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,168 @@
+/*
+ * aoenet.c
+ * Ethernet portion of AoE driver
+ */
+
+#include "all.h"
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
+	register char *p, *r;
+	register int len;
+
+	if (aoe_iflist[0] == '\0')
+		return 1;
+
+	for (p = aoe_iflist; p && *p; p = r) {
+		r = strchr(p, ' ');
+		if (r)
+			len = r++ - p;
+		else
+			len = strlen(p);
+
+		if (strlen(ifp->name) == len
+		    && strncmp(ifp->name, p, len) == 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+int
+set_aoe_iflist(int argc, char **argv)
+{
+	int i;
+	char *p = aoe_iflist;
+	char *end = p + IFLISTSZ;
+	int len;
+
+	for (i = 0; i < argc; p += len + 1, ++i) {
+		char *ifnam = argv[i];
+
+		len = strlen(ifnam);
+
+		if (p + len + 1 >= end) {
+			*p = '\0';
+			return -1;
+		}
+		strcpy(p, ifnam);
+		p[len] = ' ';
+	}
+
+	return 0;
+}
+
+static struct sk_buff *
+skb_check(struct sk_buff *skb)
+{
+	if (skb_is_nonlinear(skb))
+	if ((skb = skb_share_check(skb, GFP_ATOMIC)))
+	if (skb_linearize(skb, GFP_ATOMIC) < 0) {
+		dev_kfree_skb(skb);
+		return nil;
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
+		skb->next = skb->prev = nil;
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
+	Aoehdr *h;
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
+	h = (Aoehdr *) skb->mac.raw;
+	n = nhget32(h->tag);
+	if ((h->verfl & AOEFL_RSP) == 0 || (n & 1<<31))
+		goto exit;
+
+	if (h->verfl & AOEFL_ERR) {
+		n = h->err;
+		if (n > NECODES)
+			n = 0;
+		printk(KERN_CRIT "aoe: aoenet_rcv: error packet from %d.%d; "
+			"ecode=%d '%s'\n", nhget16(h->major), h->minor, 
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
+	type:	__constant_htons(ETH_P_AOE),
+	func:	aoenet_rcv,
+};
+
+int
+aoenet_init(void)
+{
+	dev_add_pack(&aoe_pt);
+	return 0;
+}
+
+void
+aoenet_exit(void)
+{
+	dev_remove_pack(&aoe_pt);
+}
+
diff -urpN linux-2.6.9/drivers/block/aoe/aoeutils.c linux-2.6.9-aoe/drivers/block/aoe/aoeutils.c
--- linux-2.6.9/drivers/block/aoe/aoeutils.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/aoeutils.c	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,183 @@
+/*
+ * utils.c
+ * utility functions that have no place in other modules.
+ */
+
+#include "all.h"
+
+void
+bufq_enqueue(Bufq *bufq, Buf *buf)
+{
+	if (bufq->tail)
+		bufq->tail->next = buf;
+	else
+		bufq->head = buf;
+	bufq->tail = buf;
+}
+
+Buf *
+bufq_dequeue(Bufq *bufq)
+{
+	Buf *buf;
+
+	buf = bufq->head;
+	if (buf == bufq->tail)
+		bufq->head = bufq->tail = nil;
+	else
+		bufq->head = buf->next;
+	return buf;
+}
+
+struct sk_buff *
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
+		skb->next = skb->prev = nil;
+
+		/* tell the network layer not to perform IP checksums
+		 * or to get the NIC to do it
+		 */
+		skb->ip_summed = CHECKSUM_NONE;
+	}
+	return skb;
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
+/* rc style quoting and/or empty fields */
+int
+getfields(char *p, char **argv, int max, char *delims, int flags)
+{
+	uint n;
+
+	n=0;
+loop:
+	if (n >= max || *p == '\0')
+		return n;
+	if (!(flags & FEMPTY)) {
+		while (strchr(delims, *p))
+			p++;
+	} else if (strchr(delims, *p)) {
+		*p = '\0';
+		argv[n++] = p++;
+		goto loop;
+	}
+
+	switch (*p) {
+	case '\'':
+		if (flags & FQUOTE) {
+			argv[n++] = ++p;
+unq:
+			p = strchr(p, '\'');
+			if (p == NULL)
+				return n;
+			if (p[1] == '\'') {
+				strcpy(p, p+1);	/* too inefficient? */
+				p++;
+				goto unq;
+			}
+			break;
+		}
+	default:
+		argv[n++] = p;
+		do {
+			if (*++p == '\0')
+				return n;
+		} while (!strchr(delims, *p));
+	}
+	*p++ = '\0';
+	goto loop;
+}
+
+void *
+kallocz(ulong sz, ulong kmem)
+{
+	void *d;
+
+	d = kmalloc(sz, kmem);
+	if (d)
+		memset(d, 0, sz);
+	return d;
+}
+
+u16
+nhget16(uchar *p)
+{
+	u16 n;
+
+	n = p[0];
+	n <<= 8;
+	return n |= p[1];
+}
+
+u32
+nhget32(uchar *p)
+{
+	u32 n;
+
+	n = nhget16(p);
+	n <<= 16;
+	return n |= nhget16(p+2);
+}
+
+void
+hnput16(uchar *p, u16 n)
+{
+	p[1] = n;
+	p[0] = n >>= 8;
+}
+
+void
+hnput32(uchar *p, u32 n)
+{
+	hnput16(p+2, n);
+	hnput16(p, n >>= 16);
+}
+
+u16
+lhget16(uchar *p)
+{
+	u16 n;
+
+	n = p[1];
+	n <<= 8;
+	return n |= p[0];
+}
+
+u32
+lhget32(uchar *p)
+{
+	u32 n;
+
+	n = lhget16(p+2);
+	n <<= 16;
+	return n |= lhget16(p);
+}
+
+u64
+lhget64(uchar *p)
+{
+	u64 n;
+
+	n = lhget32(p+4);
+	n <<= 32;
+	return n |= lhget32(p);
+}
+
diff -urpN linux-2.6.9/drivers/block/aoe/if_aoe.h linux-2.6.9-aoe/drivers/block/aoe/if_aoe.h
--- linux-2.6.9/drivers/block/aoe/if_aoe.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/if_aoe.h	2004-12-06 10:40:00.000000000 -0500
@@ -0,0 +1,64 @@
+
+enum
+{
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
+typedef struct Aoehdr Aoehdr;
+struct Aoehdr
+{
+	uchar dst[6];
+	uchar src[6];
+	uchar type[2];
+	uchar verfl;
+	uchar err;
+	uchar major[2];
+	uchar minor;
+	uchar cmd;
+	uchar tag[4];
+};
+
+typedef struct Aoeahdr Aoeahdr;
+struct Aoeahdr
+{
+	uchar aflags;
+	uchar errfeat;
+	uchar scnt;
+	uchar cmdstat;
+	uchar lba0;
+	uchar lba1;
+	uchar lba2;
+	uchar lba3;
+	uchar lba4;
+	uchar lba5;
+	uchar res[2];
+};
+
+typedef struct Aoechdr Aoechdr;
+struct Aoechdr
+{
+	uchar bufcnt[2];
+	uchar fwver[2];
+	uchar res;
+	uchar aoeccmd;
+	uchar cslen[2];
+};
+
diff -urpN linux-2.6.9/drivers/block/aoe/u.h linux-2.6.9-aoe/drivers/block/aoe/u.h
--- linux-2.6.9/drivers/block/aoe/u.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/drivers/block/aoe/u.h	2004-12-06 10:40:01.000000000 -0500
@@ -0,0 +1,10 @@
+
+/*
+typedef unsigned short ushort;
+typedef unsigned int uint;
+typedef unsigned long ulong;
+typedef long long vlong;
+typedef unsigned long long uvlong;
+*/
+typedef unsigned char uchar;
+
diff -urpN linux-2.6.9/scripts/aoe/autoload linux-2.6.9-aoe/scripts/aoe/autoload
--- linux-2.6.9/scripts/aoe/autoload	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/scripts/aoe/autoload	2004-12-06 10:40:01.000000000 -0500
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
diff -urpN linux-2.6.9/scripts/aoe/mkdevs linux-2.6.9-aoe/scripts/aoe/mkdevs
--- linux-2.6.9/scripts/aoe/mkdevs	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/scripts/aoe/mkdevs	2004-12-06 10:40:01.000000000 -0500
@@ -0,0 +1,31 @@
+#!/bin/sh
+# create all the device nodes for using the aoe driver
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
diff -urpN linux-2.6.9/scripts/aoe/mkshelf linux-2.6.9-aoe/scripts/aoe/mkshelf
--- linux-2.6.9/scripts/aoe/mkshelf	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9-aoe/scripts/aoe/mkshelf	2004-12-06 10:40:01.000000000 -0500
@@ -0,0 +1,24 @@
+#! /bin/sh
+# create one shelf's worth of device nodes
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

--=-=-=


-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

