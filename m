Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbVAQXta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVAQXta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVAQV6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:58:02 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:16288 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262908AbVAQVtV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:21 -0500
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: don't sleep with interrupts on
In-Reply-To: <11059983001705@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:45:00 -0800
Message-Id: <11059983001178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2332, 2005/01/14 12:03:48-08:00, ecashin@coraid.com

[PATCH] aoe: don't sleep with interrupts on

Changes:

  * get rid of sleeping with interrupts off
    (I had to re-add the (struct aoedev *)->nopen member because I
    can't get to bdev->bd_openers without sleeping.)

  * Scott Feldman suggestions:
    don't do needless assignment of skb->dev in aoenet_rcv.
    use skb_push instead of just adding to skb->len.
    also trivial: make data in struct frame unsigned char array.

  * Alan Cox suggestion: use net_ratelimit to avoid flooding syslog

  * documentation updates and corrections

  * support one-partition per device for compatibility with systems
    having poor support for large minor device numbers


Don't sleep with interrupts on; support no-partition devices.

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/aoe/aoe.txt    |   41 ++++++++++++++++++++++--------------
 Documentation/aoe/mkdevs.sh  |    9 +++++---
 Documentation/aoe/mkshelf.sh |    8 ++++---
 Documentation/aoe/status.sh  |   21 +++++++++++++++---
 drivers/block/aoe/aoe.h      |    8 +++++--
 drivers/block/aoe/aoeblk.c   |   48 ++++++++++++++++++++++++++++++++++---------
 drivers/block/aoe/aoedev.c   |   22 +++----------------
 drivers/block/aoe/aoemain.c  |    3 +-
 drivers/block/aoe/aoenet.c   |   19 +++++++----------
 9 files changed, 111 insertions(+), 68 deletions(-)


diff -Nru a/Documentation/aoe/aoe.txt b/Documentation/aoe/aoe.txt
--- a/Documentation/aoe/aoe.txt	2005-01-17 13:35:13 -08:00
+++ b/Documentation/aoe/aoe.txt	2005-01-17 13:35:13 -08:00
@@ -33,6 +33,10 @@
   "echo > /dev/etherd/discover" tells the driver to find out what AoE
   devices are available.
 
+  These character devices may disappear and be replaced by sysfs
+  counterparts, so distribution maintainers are encouraged to create
+  scripts that use these devices.
+
   The block devices are named like this:
 
 	e{shelf}.{slot}
@@ -57,19 +61,24 @@
   There is a script in this directory that formats this information
   in a convenient way.
 
-  root@makki linux# sh Documentation/aoe/status.sh 
-    device                 mac       netif           state
-      e6.0        0010040010c6        eth0              up
-      e6.1        001004001067        eth0              up
-      e6.2        001004001068        eth0              up
-      e6.3        001004001065        eth0              up
-      e6.4        001004001066        eth0              up
-      e6.5        0010040010c7        eth0              up
-      e6.6        0010040010c8        eth0              up
-      e6.7        0010040010c9        eth0              up
-      e6.8        0010040010ca        eth0              up
-      e6.9        0010040010cb        eth0              up
-      e9.0        001004000020        eth1              up
-      e9.5        001004000025        eth1              up
-      e9.9        001004000029        eth1              up
-
+  root@makki root# sh Documentation/aoe/status.sh 
+     e10.0            eth3              up
+     e10.1            eth3              up
+     e10.2            eth3              up
+     e10.3            eth3              up
+     e10.4            eth3              up
+     e10.5            eth3              up
+     e10.6            eth3              up
+     e10.7            eth3              up
+     e10.8            eth3              up
+     e10.9            eth3              up
+      e4.0            eth1              up
+      e4.1            eth1              up
+      e4.2            eth1              up
+      e4.3            eth1              up
+      e4.4            eth1              up
+      e4.5            eth1              up
+      e4.6            eth1              up
+      e4.7            eth1              up
+      e4.8            eth1              up
+      e4.9            eth1              up
diff -Nru a/Documentation/aoe/mkdevs.sh b/Documentation/aoe/mkdevs.sh
--- a/Documentation/aoe/mkdevs.sh	2005-01-17 13:35:13 -08:00
+++ b/Documentation/aoe/mkdevs.sh	2005-01-17 13:35:13 -08:00
@@ -1,9 +1,10 @@
 #!/bin/sh
 
-n_shelves=10
+n_shelves=${n_shelves:-10}
+n_partitions=${n_partitions:-16}
 
 if test "$#" != "1"; then
-	echo "Usage: sh mkdevs.sh {dir}" 1>&2
+	echo "Usage: sh `basename $0` {dir}" 1>&2
 	exit 1
 fi
 dir=$1
@@ -26,8 +27,10 @@
 rm -f $dir/interfaces
 mknod -m 0200 $dir/interfaces c $MAJOR 4
 
+export n_partitions
+mkshelf=`echo $0 | sed 's!mkdevs!mkshelf!'`
 i=0
 while test $i -lt $n_shelves; do
-	sh -xc "sh `dirname $0`/mkshelf.sh $dir $i"
+	sh -xc "sh $mkshelf $dir $i"
 	i=`expr $i + 1`
 done
diff -Nru a/Documentation/aoe/mkshelf.sh b/Documentation/aoe/mkshelf.sh
--- a/Documentation/aoe/mkshelf.sh	2005-01-17 13:35:13 -08:00
+++ b/Documentation/aoe/mkshelf.sh	2005-01-17 13:35:13 -08:00
@@ -1,18 +1,20 @@
 #! /bin/sh
 
 if test "$#" != "2"; then
-	echo "Usage: sh mkshelf.sh {dir} {shelfaddress}" 1>&2
+	echo "Usage: sh `basename $0` {dir} {shelfaddress}" 1>&2
 	exit 1
 fi
+n_partitions=${n_partitions:-16}
 dir=$1
 shelf=$2
 MAJOR=152
 
 set -e
 
-minor=`echo 10 \* $shelf \* 16 | bc`
+minor=`echo 10 \* $shelf \* $n_partitions | bc`
+endp=`echo $n_partitions - 1 | bc`
 for slot in `seq 0 9`; do
-	for part in `seq 0 15`; do
+	for part in `seq 0 $endp`; do
 		name=e$shelf.$slot
 		test "$part" != "0" && name=${name}p$part
 		rm -f $dir/$name
diff -Nru a/Documentation/aoe/status.sh b/Documentation/aoe/status.sh
--- a/Documentation/aoe/status.sh	2005-01-17 13:35:13 -08:00
+++ b/Documentation/aoe/status.sh	2005-01-17 13:35:13 -08:00
@@ -1,15 +1,28 @@
+#! /bin/sh
 # collate and present sysfs information about AoE storage
 
 set -e
-format="%8s\t%12s\t%8s\t%8s\n"
+format="%8s\t%8s\t%8s\n"
+me=`basename $0`
 
-printf "$format" device mac netif state
+# printf "$format" device mac netif state
+
+test -z "`mount | grep sysfs`" && {
+	echo "$me Error: sysfs is not mounted" 1>&2
+	exit 1
+}
+test -z "`lsmod | grep '^aoe'`" && {
+	echo  "$me Error: aoe module is not loaded" 1>&2
+	exit 1
+}
+
+for d in `ls -d /sys/block/etherd* 2>/dev/null | grep -v p` end; do
+	# maybe ls comes up empty, so we use "end"
+	test $d = end && continue
 
-for d in `ls -d /sys/block/etherd* | grep -v p`; do
 	dev=`echo "$d" | sed 's/.*!//'`
 	printf "$format" \
 		"$dev" \
-		"`cat \"$d/mac\"`" \
 		"`cat \"$d/netif\"`" \
 		"`cat \"$d/state\"`"
 done | sort
diff -Nru a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-01-17 13:35:13 -08:00
+++ b/drivers/block/aoe/aoe.h	2005-01-17 13:35:13 -08:00
@@ -1,7 +1,10 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "4"
+#define VERSION "5"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
+#ifndef AOE_PARTITIONS
+#define AOE_PARTITIONS 16
+#endif
 #define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * 10 + (aoeminor))
 #define AOEMAJOR(sysminor) ((sysminor) / 10)
 #define AOEMINOR(sysminor) ((sysminor) % 10)
@@ -101,7 +104,7 @@
 	int ndata;
 
 	/* largest possible */
-	char data[sizeof(struct aoe_hdr) + sizeof(struct aoe_atahdr)];
+	unsigned char data[sizeof(struct aoe_hdr) + sizeof(struct aoe_atahdr)];
 };
 
 struct aoedev {
@@ -111,6 +114,7 @@
 	ulong sysminor;
 	ulong aoemajor;
 	ulong aoeminor;
+	ulong nopen;		/* (bd_openers isn't available without sleeping) */
 	ulong rttavg;		/* round trip average of requests/responses */
 	u16 fw_ver;		/* version of blade's firmware */
 	struct work_struct work;/* disk create work struct */
diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- a/drivers/block/aoe/aoeblk.c	2005-01-17 13:35:13 -08:00
+++ b/drivers/block/aoe/aoeblk.c	2005-01-17 13:35:13 -08:00
@@ -12,6 +12,8 @@
 #include <linux/netdevice.h>
 #include "aoe.h"
 
+static kmem_cache_t *buf_pool_cache;
+
 /* add attributes for our block devices in sysfs */
 static ssize_t aoedisk_show_state(struct gendisk * disk, char *page)
 {
@@ -67,9 +69,18 @@
 aoeblk_open(struct inode *inode, struct file *filp)
 {
 	struct aoedev *d;
+	ulong flags;
 
 	d = inode->i_bdev->bd_disk->private_data;
-	return (d->flags & DEVFL_UP) ? 0 : -ENODEV;
+
+	spin_lock_irqsave(&d->lock, flags);
+	if (d->flags & DEVFL_UP) {
+		d->nopen++;
+		spin_unlock_irqrestore(&d->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&d->lock, flags);
+	return -ENODEV;
 }
 
 static int
@@ -82,7 +93,7 @@
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	if (inode->i_bdev->bd_openers == 0 && (d->flags & DEVFL_CLOSEWAIT)) {
+	if (--d->nopen == 0 && (d->flags & DEVFL_CLOSEWAIT)) {
 		d->flags &= ~DEVFL_CLOSEWAIT;
 		spin_unlock_irqrestore(&d->lock, flags);
 		aoecmd_cfg(d->aoemajor, d->aoeminor);
@@ -185,23 +196,34 @@
 	struct aoedev *d = vp;
 	struct gendisk *gd;
 	ulong flags;
-	enum { NPARTITIONS = 16 };
-
-	gd = alloc_disk(NPARTITIONS);
-
-	spin_lock_irqsave(&d->lock, flags);
 
+	gd = alloc_disk(AOE_PARTITIONS);
 	if (gd == NULL) {
-		printk(KERN_CRIT "aoe: aoeblk_gdalloc: cannot allocate disk "
+		printk(KERN_ERR "aoe: aoeblk_gdalloc: cannot allocate disk "
 			"structure for %ld.%ld\n", d->aoemajor, d->aoeminor);
+		spin_lock_irqsave(&d->lock, flags);
 		d->flags &= ~DEVFL_WORKON;
 		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
 
+	d->bufpool = mempool_create(MIN_BUFS,
+				    mempool_alloc_slab, mempool_free_slab,
+				    buf_pool_cache);
+	if (d->bufpool == NULL) {
+		printk(KERN_ERR "aoe: aoeblk_gdalloc: cannot allocate bufpool "
+			"for %ld.%ld\n", d->aoemajor, d->aoeminor);
+		put_disk(gd);
+		spin_lock_irqsave(&d->lock, flags);
+		d->flags &= ~DEVFL_WORKON;
+		spin_unlock_irqrestore(&d->lock, flags);
+		return;
+	}
+
+	spin_lock_irqsave(&d->lock, flags);
 	blk_queue_make_request(&d->blkq, aoeblk_make_request);
 	gd->major = AOE_MAJOR;
-	gd->first_minor = d->sysminor * NPARTITIONS;
+	gd->first_minor = d->sysminor * AOE_PARTITIONS;
 	gd->fops = &aoe_bdops;
 	gd->private_data = d;
 	gd->capacity = d->ssize;
@@ -226,13 +248,19 @@
 void __exit
 aoeblk_exit(void)
 {
-	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
+	kmem_cache_destroy(buf_pool_cache);
 }
 
 int __init
 aoeblk_init(void)
 {
 	int n;
+
+	buf_pool_cache = kmem_cache_create("aoe_bufs", 
+					   sizeof(struct buf),
+					   0, 0, NULL, NULL);
+	if (buf_pool_cache == NULL)
+		return -ENOMEM;
 
 	n = register_blkdev(AOE_MAJOR, DEVICE_NAME);
 	if (n < 0) {
diff -Nru a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
--- a/drivers/block/aoe/aoedev.c	2005-01-17 13:35:13 -08:00
+++ b/drivers/block/aoe/aoedev.c	2005-01-17 13:35:13 -08:00
@@ -11,7 +11,6 @@
 
 static struct aoedev *devlist;
 static spinlock_t devlist_lock;
-static kmem_cache_t *buf_pool_cache;
 
 struct aoedev *
 aoedev_bymac(unsigned char *macaddr)
@@ -53,9 +52,7 @@
 
 	spin_lock_init(&d->lock);
 	init_timer(&d->timer);
-	d->bufpool = mempool_create(MIN_BUFS,
-				    mempool_alloc_slab, mempool_free_slab,
-				    buf_pool_cache);
+	d->bufpool = NULL;	/* defer to aoeblk_gdalloc */
 	INIT_LIST_HEAD(&d->bufq);
 	d->next = devlist;
 	devlist = d;
@@ -95,15 +92,10 @@
 		bio_endio(bio, bio->bi_size, -EIO);
 	}
 
-	if (d->gd) {
-		struct block_device *bdev = bdget_disk(d->gd, 0);
-		if (bdev) {
-			if (bdev->bd_openers)
-				d->flags |= DEVFL_CLOSEWAIT;
-			bdput(bdev);
-		}
+	if (d->nopen)
+		d->flags |= DEVFL_CLOSEWAIT;
+	if (d->gd)
 		d->gd->capacity = 0;
-	}
 
 	d->flags &= ~DEVFL_UP;
 }
@@ -177,17 +169,11 @@
 		del_timer_sync(&d->timer);
 		aoedev_freedev(d);
 	}
-	kmem_cache_destroy(buf_pool_cache);
 }
 
 int __init
 aoedev_init(void)
 {
-	buf_pool_cache = kmem_cache_create("aoe_bufs", 
-					   sizeof(struct buf),
-					   0, 0, NULL, NULL);
-	if (buf_pool_cache == NULL)
-		return -ENOMEM;
 	spin_lock_init(&devlist_lock);
 	return 0;
 }
diff -Nru a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
--- a/drivers/block/aoe/aoemain.c	2005-01-17 13:35:13 -08:00
+++ b/drivers/block/aoe/aoemain.c	2005-01-17 13:35:13 -08:00
@@ -59,9 +59,10 @@
 	discover_timer(TKILL);
 
 	aoenet_exit();
-	aoeblk_exit();
+	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
 	aoechr_exit();
 	aoedev_exit();
+	aoeblk_exit();		/* free cache after de-allocating bufs */
 }
 
 static int __init
diff -Nru a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
--- a/drivers/block/aoe/aoenet.c	2005-01-17 13:35:13 -08:00
+++ b/drivers/block/aoe/aoenet.c	2005-01-17 13:35:13 -08:00
@@ -102,10 +102,7 @@
 }
 
 /* 
- * (1) i have no idea if this is redundant, but i can't figure why
- * the ifp is passed in if it is.
- *
- * (2) len doesn't include the header by default.  I want this. 
+ * (1) len doesn't include the header by default.  I want this. 
  */
 static int
 aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt)
@@ -117,12 +114,11 @@
 	if (!skb)
 		return 0;
 
-	skb->dev = ifp;	/* (1) */
-
 	if (!is_aoe_netif(ifp))
 		goto exit;
 
-	skb->len += ETH_HLEN;	/* (2) */
+	//skb->len += ETH_HLEN;	/* (1) */
+	skb_push(skb, ETH_HLEN);	/* (1) */
 
 	h = (struct aoe_hdr *) skb->mac.raw;
 	n = __be32_to_cpu(*((u32 *) h->tag));
@@ -133,10 +129,11 @@
 		n = h->err;
 		if (n > NECODES)
 			n = 0;
-		printk(KERN_CRIT "aoe: aoenet_rcv: error packet from %d.%d; "
-			"ecode=%d '%s'\n",
-		       __be16_to_cpu(*((u16 *) h->major)), h->minor, 
-			h->err, aoe_errlist[n]);
+		if (net_ratelimit())
+			printk(KERN_ERR "aoe: aoenet_rcv: error packet from %d.%d; "
+			       "ecode=%d '%s'\n",
+			       __be16_to_cpu(*((u16 *) h->major)), h->minor, 
+			       h->err, aoe_errlist[n]);
 		goto exit;
 	}
 

