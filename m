Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVAJRxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVAJRxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVAJRuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:50:19 -0500
Received: from main.gmane.org ([80.91.229.2]:60315 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262361AbVAJRZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:25:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: [PATCH] for 2.6 usb: aoe: don't sleep with interrupts on
Date: Mon, 10 Jan 2005 12:25:29 -0500
Message-ID: <87brbxryba.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
Cc: Greg KH <greg@kroah.com>
X-Gmane-NNTP-Posting-Host: adsl-214-28-36.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:INL0+vC6nJupRYVKOSRCHBYsrD8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

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


--=-=-=
Content-Disposition: inline; filename=patch-usb-2.6-20050110

diff -uprN usb-2.6-export-a/Documentation/aoe/aoe.txt usb-2.6-export-b/Documentation/aoe/aoe.txt
--- usb-2.6-export-a/Documentation/aoe/aoe.txt	2005-01-10 11:15:18.000000000 -0500
+++ usb-2.6-export-b/Documentation/aoe/aoe.txt	2005-01-10 11:53:00.000000000 -0500
@@ -33,6 +33,10 @@ USING DEVICE NODES
   "echo > /dev/etherd/discover" tells the driver to find out what AoE
   devices are available.
 
+  These character devices may disappear and be replaced by sysfs
+  counterparts, so distribution maintainers are encouraged to create
+  scripts that use these devices.
+
   The block devices are named like this:
 
 	e{shelf}.{slot}
@@ -57,19 +61,24 @@ USING SYSFS
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
diff -uprN usb-2.6-export-a/Documentation/aoe/mkdevs.sh usb-2.6-export-b/Documentation/aoe/mkdevs.sh
--- usb-2.6-export-a/Documentation/aoe/mkdevs.sh	2005-01-10 11:15:02.000000000 -0500
+++ usb-2.6-export-b/Documentation/aoe/mkdevs.sh	2005-01-10 11:53:00.000000000 -0500
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
@@ -26,8 +27,10 @@ mknod -m 0200 $dir/discover c $MAJOR 3
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
diff -uprN usb-2.6-export-a/Documentation/aoe/mkshelf.sh usb-2.6-export-b/Documentation/aoe/mkshelf.sh
--- usb-2.6-export-a/Documentation/aoe/mkshelf.sh	2005-01-10 11:17:42.000000000 -0500
+++ usb-2.6-export-b/Documentation/aoe/mkshelf.sh	2005-01-10 11:53:00.000000000 -0500
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
diff -uprN usb-2.6-export-a/Documentation/aoe/status.sh usb-2.6-export-b/Documentation/aoe/status.sh
--- usb-2.6-export-a/Documentation/aoe/status.sh	2005-01-10 11:14:58.000000000 -0500
+++ usb-2.6-export-b/Documentation/aoe/status.sh	2005-01-10 11:53:00.000000000 -0500
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
diff -uprN usb-2.6-export-a/drivers/block/aoe/aoe.h usb-2.6-export-b/drivers/block/aoe/aoe.h
--- usb-2.6-export-a/drivers/block/aoe/aoe.h	2005-01-10 11:17:44.000000000 -0500
+++ usb-2.6-export-b/drivers/block/aoe/aoe.h	2005-01-10 11:53:00.000000000 -0500
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
@@ -101,7 +104,7 @@ struct frame {
 	int ndata;
 
 	/* largest possible */
-	char data[sizeof(struct aoe_hdr) + sizeof(struct aoe_atahdr)];
+	unsigned char data[sizeof(struct aoe_hdr) + sizeof(struct aoe_atahdr)];
 };
 
 struct aoedev {
@@ -111,6 +114,7 @@ struct aoedev {
 	ulong sysminor;
 	ulong aoemajor;
 	ulong aoeminor;
+	ulong nopen;		/* (bd_openers isn't available without sleeping) */
 	ulong rttavg;		/* round trip average of requests/responses */
 	u16 fw_ver;		/* version of blade's firmware */
 	struct work_struct work;/* disk create work struct */
diff -uprN usb-2.6-export-a/drivers/block/aoe/aoeblk.c usb-2.6-export-b/drivers/block/aoe/aoeblk.c
--- usb-2.6-export-a/drivers/block/aoe/aoeblk.c	2005-01-10 11:15:46.000000000 -0500
+++ usb-2.6-export-b/drivers/block/aoe/aoeblk.c	2005-01-10 11:53:00.000000000 -0500
@@ -12,6 +12,8 @@
 #include <linux/netdevice.h>
 #include "aoe.h"
 
+static kmem_cache_t *buf_pool_cache;
+
 /* add attributes for our block devices in sysfs
  * (see drivers/block/genhd.c:disk_attr_show, etc.)
  */
@@ -74,9 +76,18 @@ static int
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
@@ -89,7 +100,7 @@ aoeblk_release(struct inode *inode, stru
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	if (inode->i_bdev->bd_openers == 0 && (d->flags & DEVFL_CLOSEWAIT)) {
+	if (--d->nopen == 0 && (d->flags & DEVFL_CLOSEWAIT)) {
 		d->flags &= ~DEVFL_CLOSEWAIT;
 		spin_unlock_irqrestore(&d->lock, flags);
 		aoecmd_cfg(d->aoemajor, d->aoeminor);
@@ -192,23 +203,34 @@ aoeblk_gdalloc(void *vp)
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
@@ -233,7 +255,7 @@ aoeblk_gdalloc(void *vp)
 void __exit
 aoeblk_exit(void)
 {
-	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
+	kmem_cache_destroy(buf_pool_cache);
 }
 
 int __init
@@ -241,6 +263,12 @@ aoeblk_init(void)
 {
 	int n;
 
+	buf_pool_cache = kmem_cache_create("aoe_bufs", 
+					   sizeof(struct buf),
+					   0, 0, NULL, NULL);
+	if (buf_pool_cache == NULL)
+		return -ENOMEM;
+
 	n = register_blkdev(AOE_MAJOR, DEVICE_NAME);
 	if (n < 0) {
 		printk(KERN_ERR "aoe: aoeblk_init: can't register major\n");
diff -uprN usb-2.6-export-a/drivers/block/aoe/aoedev.c usb-2.6-export-b/drivers/block/aoe/aoedev.c
--- usb-2.6-export-a/drivers/block/aoe/aoedev.c	2005-01-10 11:14:45.000000000 -0500
+++ usb-2.6-export-b/drivers/block/aoe/aoedev.c	2005-01-10 11:53:00.000000000 -0500
@@ -11,7 +11,6 @@
 
 static struct aoedev *devlist;
 static spinlock_t devlist_lock;
-static kmem_cache_t *buf_pool_cache;
 
 struct aoedev *
 aoedev_bymac(unsigned char *macaddr)
@@ -53,9 +52,7 @@ aoedev_newdev(ulong nframes)
 
 	spin_lock_init(&d->lock);
 	init_timer(&d->timer);
-	d->bufpool = mempool_create(MIN_BUFS,
-				    mempool_alloc_slab, mempool_free_slab,
-				    buf_pool_cache);
+	d->bufpool = NULL;	/* defer to aoeblk_gdalloc */
 	INIT_LIST_HEAD(&d->bufq);
 	d->next = devlist;
 	devlist = d;
@@ -95,15 +92,10 @@ aoedev_downdev(struct aoedev *d)
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
@@ -177,17 +169,11 @@ aoedev_exit(void)
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
diff -uprN usb-2.6-export-a/drivers/block/aoe/aoemain.c usb-2.6-export-b/drivers/block/aoe/aoemain.c
--- usb-2.6-export-a/drivers/block/aoe/aoemain.c	2005-01-10 11:18:35.000000000 -0500
+++ usb-2.6-export-b/drivers/block/aoe/aoemain.c	2005-01-10 11:53:00.000000000 -0500
@@ -59,9 +59,10 @@ aoe_exit(void)
 	discover_timer(TKILL);
 
 	aoenet_exit();
-	aoeblk_exit();
+	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
 	aoechr_exit();
 	aoedev_exit();
+	aoeblk_exit();		/* free cache after de-allocating bufs */
 }
 
 static int __init
diff -uprN usb-2.6-export-a/drivers/block/aoe/aoenet.c usb-2.6-export-b/drivers/block/aoe/aoenet.c
--- usb-2.6-export-a/drivers/block/aoe/aoenet.c	2005-01-10 11:16:08.000000000 -0500
+++ usb-2.6-export-b/drivers/block/aoe/aoenet.c	2005-01-10 11:53:00.000000000 -0500
@@ -102,10 +102,7 @@ aoenet_xmit(struct sk_buff *sl)
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
@@ -117,12 +114,11 @@ aoenet_rcv(struct sk_buff *skb, struct n
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
@@ -133,10 +129,11 @@ aoenet_rcv(struct sk_buff *skb, struct n
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
 

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

