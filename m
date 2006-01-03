Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWACVQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWACVQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWACVQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:16:37 -0500
Received: from ns1.coraid.com ([65.14.39.133]:41161 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S964869AbWACVQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:16:17 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-rc7] aoe [2/7]: support dynamic resizing of AoE
 devices
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <87hd8l2fb4.fsf@coraid.com>
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 16:07:41 -0500
Message-ID: <87irt110ma.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Allow the driver to recognize AoE devices that have changed
size.  Devices not in use are updated automatically, and devices
that are in use are updated at user request.

Index: 2.6.15-rc7-aoe/Documentation/aoe/udev.txt
===================================================================
--- 2.6.15-rc7-aoe.orig/Documentation/aoe/udev.txt	2006-01-02 13:35:12.000000000 -0500
+++ 2.6.15-rc7-aoe/Documentation/aoe/udev.txt	2006-01-02 13:35:13.000000000 -0500
@@ -18,6 +18,7 @@
 SUBSYSTEM="aoe", KERNEL="discover",	NAME="etherd/%k", GROUP="disk", MODE="0220"
 SUBSYSTEM="aoe", KERNEL="err",		NAME="etherd/%k", GROUP="disk", MODE="0440"
 SUBSYSTEM="aoe", KERNEL="interfaces",	NAME="etherd/%k", GROUP="disk", MODE="0220"
+SUBSYSTEM="aoe", KERNEL="revalidate",	NAME="etherd/%k", GROUP="disk", MODE="0220"
 
 # aoe block devices     
 KERNEL="etherd*",       NAME="%k", GROUP="disk"
Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoeblk.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoeblk.c	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoeblk.c	2006-01-02 13:35:13.000000000 -0500
@@ -22,7 +22,9 @@
 	return snprintf(page, PAGE_SIZE,
 			"%s%s\n",
 			(d->flags & DEVFL_UP) ? "up" : "down",
-			(d->flags & DEVFL_CLOSEWAIT) ? ",closewait" : "");
+			(d->flags & DEVFL_PAUSE) ? ",paused" : 
+			(d->nopen && !(d->flags & DEVFL_UP)) ? ",closewait" : "");
+	/* I'd rather see nopen exported so we can ditch closewait */
 }
 static ssize_t aoedisk_show_mac(struct gendisk * disk, char *page)
 {
@@ -107,8 +109,7 @@
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	if (--d->nopen == 0 && (d->flags & DEVFL_CLOSEWAIT)) {
-		d->flags &= ~DEVFL_CLOSEWAIT;
+	if (--d->nopen == 0 && !(d->flags & DEVFL_UP)) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		aoecmd_cfg(d->aoemajor, d->aoeminor);
 		return 0;
@@ -158,14 +159,14 @@
 	}
 
 	list_add_tail(&buf->bufs, &d->bufq);
-	aoecmd_work(d);
 
+	aoecmd_work(d);
 	sl = d->sendq_hd;
 	d->sendq_hd = d->sendq_tl = NULL;
 
 	spin_unlock_irqrestore(&d->lock, flags);
-
 	aoenet_xmit(sl);
+
 	return 0;
 }
 
@@ -217,7 +218,7 @@
 		printk(KERN_ERR "aoe: aoeblk_gdalloc: cannot allocate disk "
 			"structure for %ld.%ld\n", d->aoemajor, d->aoeminor);
 		spin_lock_irqsave(&d->lock, flags);
-		d->flags &= ~DEVFL_WORKON;
+		d->flags &= ~DEVFL_GDALLOC;
 		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
@@ -230,7 +231,7 @@
 			"for %ld.%ld\n", d->aoemajor, d->aoeminor);
 		put_disk(gd);
 		spin_lock_irqsave(&d->lock, flags);
-		d->flags &= ~DEVFL_WORKON;
+		d->flags &= ~DEVFL_GDALLOC;
 		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
@@ -247,18 +248,13 @@
 
 	gd->queue = &d->blkq;
 	d->gd = gd;
-	d->flags &= ~DEVFL_WORKON;
+	d->flags &= ~DEVFL_GDALLOC;
 	d->flags |= DEVFL_UP;
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
 	add_disk(gd);
 	aoedisk_add_sysfs(d);
-	
-	printk(KERN_INFO "aoe: %012llx e%lu.%lu v%04x has %llu "
-		"sectors\n", (unsigned long long)mac_addr(d->addr),
-		d->aoemajor, d->aoeminor,
-		d->fw_ver, (long long)d->ssize);
 }
 
 void
Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoedev.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoedev.c	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoedev.c	2006-01-02 13:35:13.000000000 -0500
@@ -12,6 +12,24 @@
 static struct aoedev *devlist;
 static spinlock_t devlist_lock;
 
+int
+aoedev_isbusy(struct aoedev *d)
+{
+	struct frame *f, *e;
+
+	f = d->frames;
+	e = f + d->nframes;
+	do {
+		if (f->tag != FREETAG) {
+			printk(KERN_DEBUG "aoe: %ld.%ld isbusy\n",
+				d->aoemajor, d->aoeminor);
+			return 1;
+		}
+	} while (++f < e);
+
+	return 0;
+}
+
 struct aoedev *
 aoedev_by_aoeaddr(int maj, int min)
 {
@@ -44,6 +62,8 @@
 		return NULL;
 	}
 
+	INIT_WORK(&d->work, aoecmd_sleepwork, d);
+
 	d->nframes = nframes;
 	d->frames = f;
 	e = f + nframes;
@@ -92,16 +112,15 @@
 		bio_endio(bio, bio->bi_size, -EIO);
 	}
 
-	if (d->nopen)
-		d->flags |= DEVFL_CLOSEWAIT;
 	if (d->gd)
 		d->gd->capacity = 0;
 
-	d->flags &= ~DEVFL_UP;
+	d->flags &= ~(DEVFL_UP | DEVFL_PAUSE);
 }
 
+/* find it or malloc it */
 struct aoedev *
-aoedev_set(ulong sysminor, unsigned char *addr, struct net_device *ifp, ulong bufcnt)
+aoedev_by_sysminor_m(ulong sysminor, ulong bufcnt)
 {
 	struct aoedev *d;
 	ulong flags;
@@ -112,25 +131,19 @@
 		if (d->sysminor == sysminor)
 			break;
 
-	if (d == NULL && (d = aoedev_newdev(bufcnt)) == NULL) {
-		spin_unlock_irqrestore(&devlist_lock, flags);
-		printk(KERN_INFO "aoe: aoedev_set: aoedev_newdev failure.\n");
-		return NULL;
-	} /* if newdev, (d->flags & DEVFL_UP) == 0 for below */
-
-	spin_unlock_irqrestore(&devlist_lock, flags);
-	spin_lock_irqsave(&d->lock, flags);
-
-	d->ifp = ifp;
-	memcpy(d->addr, addr, sizeof d->addr);
-	if ((d->flags & DEVFL_UP) == 0) {
-		aoedev_downdev(d); /* flushes outstanding frames */
+	if (d == NULL) {
+		d = aoedev_newdev(bufcnt);
+	 	if (d == NULL) {
+			spin_unlock_irqrestore(&devlist_lock, flags);
+			printk(KERN_INFO "aoe: aoedev_set: aoedev_newdev failure.\n");
+			return NULL;
+		}
 		d->sysminor = sysminor;
 		d->aoemajor = AOEMAJOR(sysminor);
 		d->aoeminor = AOEMINOR(sysminor);
 	}
 
-	spin_unlock_irqrestore(&d->lock, flags);
+	spin_unlock_irqrestore(&devlist_lock, flags);
 	return d;
 }
 
Index: 2.6.15-rc7-aoe/Documentation/aoe/mkdevs.sh
===================================================================
--- 2.6.15-rc7-aoe.orig/Documentation/aoe/mkdevs.sh	2006-01-02 13:35:12.000000000 -0500
+++ 2.6.15-rc7-aoe/Documentation/aoe/mkdevs.sh	2006-01-02 13:35:13.000000000 -0500
@@ -27,6 +27,8 @@
 mknod -m 0200 $dir/discover c $MAJOR 3
 rm -f $dir/interfaces
 mknod -m 0200 $dir/interfaces c $MAJOR 4
+rm -f $dir/revalidate
+mknod -m 0200 $dir/revalidate c $MAJOR 5
 
 export n_partitions
 mkshelf=`echo $0 | sed 's!mkdevs!mkshelf!'`
Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoecmd.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoecmd.c	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoecmd.c	2006-01-02 13:35:13.000000000 -0500
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/genhd.h>
 #include <asm/unaligned.h>
 #include "aoe.h"
 
@@ -195,6 +196,14 @@
 {
 	struct frame *f;
 	struct buf *buf;
+
+	if (d->flags & DEVFL_PAUSE) {
+		if (!aoedev_isbusy(d))
+			d->sendq_hd = aoecmd_cfg_pkts(d->aoemajor, 
+						d->aoeminor, &d->sendq_tl);
+		return;
+	}
+
 loop:
 	f = getframe(d, FREETAG);
 	if (f == NULL)
@@ -306,6 +315,38 @@
 	aoenet_xmit(sl);
 }
 
+/* this function performs work that has been deferred until sleeping is OK
+ */
+void
+aoecmd_sleepwork(void *vp)
+{
+	struct aoedev *d = (struct aoedev *) vp;
+
+	if (d->flags & DEVFL_GDALLOC)
+		aoeblk_gdalloc(d);
+
+	if (d->flags & DEVFL_NEWSIZE) {
+		struct block_device *bd;
+		unsigned long flags;
+		u64 ssize;
+
+		ssize = d->gd->capacity;
+		bd = bdget_disk(d->gd, 0);
+
+		if (bd) {
+			down(&bd->bd_inode->i_sem);
+			i_size_write(bd->bd_inode, (loff_t)ssize<<9);
+			up(&bd->bd_inode->i_sem);
+//??			rescan_partitions(d->gd, bd);
+			bdput(bd);
+		}
+		spin_lock_irqsave(&d->lock, flags);
+		d->flags |= DEVFL_UP;
+		d->flags &= ~DEVFL_NEWSIZE;
+		spin_unlock_irqrestore(&d->lock, flags);
+	}
+}
+
 static void
 ataid_complete(struct aoedev *d, unsigned char *id)
 {
@@ -340,21 +381,29 @@
 		d->geo.heads = le16_to_cpu(get_unaligned((__le16 *) &id[55<<1]));
 		d->geo.sectors = le16_to_cpu(get_unaligned((__le16 *) &id[56<<1]));
 	}
+
+	if (d->ssize != ssize)
+		printk(KERN_INFO "aoe: %012llx e%lu.%lu v%04x has %llu "
+			"sectors\n", (unsigned long long)mac_addr(d->addr),
+			d->aoemajor, d->aoeminor,
+			d->fw_ver, (long long)ssize);
 	d->ssize = ssize;
 	d->geo.start = 0;
 	if (d->gd != NULL) {
 		d->gd->capacity = ssize;
-		d->flags |= DEVFL_UP;
-		return;
-	}
-	if (d->flags & DEVFL_WORKON) {
-		printk(KERN_INFO "aoe: ataid_complete: can't schedule work, it's already on!  "
-			"(This really shouldn't happen).\n");
-		return;
+		d->flags |= DEVFL_NEWSIZE;
+	} else {
+		if (d->flags & DEVFL_GDALLOC) {
+			printk(KERN_INFO "aoe: %s: %s e%lu.%lu, %s\n",
+			       __FUNCTION__,
+			       "can't schedule work for",
+			       d->aoemajor, d->aoeminor,
+			       "it's already on! (This really shouldn't happen).\n");
+			return;
+		}
+		d->flags |= DEVFL_GDALLOC;
 	}
-	INIT_WORK(&d->work, aoeblk_gdalloc, d);
 	schedule_work(&d->work);
-	d->flags |= DEVFL_WORKON;
 }
 
 static void
@@ -452,7 +501,7 @@
 				return;
 			}
 			ataid_complete(d, (char *) (ahin+1));
-			/* d->flags |= DEVFL_WC_UPDATE; */
+			d->flags &= ~DEVFL_PAUSE;
 			break;
 		default:
 			printk(KERN_INFO "aoe: aoecmd_ata_rsp: unrecognized "
@@ -485,24 +534,25 @@
 	f->tag = FREETAG;
 
 	aoecmd_work(d);
-
 	sl = d->sendq_hd;
 	d->sendq_hd = d->sendq_tl = NULL;
 
 	spin_unlock_irqrestore(&d->lock, flags);
-
 	aoenet_xmit(sl);
 }
 
-void
-aoecmd_cfg(ushort aoemajor, unsigned char aoeminor)
+/* some callers cannot sleep, and they can call this function,
+ * transmitting the packets later, when interrupts are on
+ */
+struct sk_buff *
+aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff **tail)
 {
 	struct aoe_hdr *h;
 	struct aoe_cfghdr *ch;
-	struct sk_buff *skb, *sl;
+	struct sk_buff *skb, *sl, *sl_tail;
 	struct net_device *ifp;
 
-	sl = NULL;
+	sl = sl_tail = NULL;
 
 	read_lock(&dev_base_lock);
 	for (ifp = dev_base; ifp; dev_put(ifp), ifp = ifp->next) {
@@ -515,6 +565,8 @@
 			printk(KERN_INFO "aoe: aoecmd_cfg: skb alloc failure\n");
 			continue;
 		}
+		if (sl_tail == NULL)
+			sl_tail = skb;
 		h = (struct aoe_hdr *) skb->mac.raw;
 		memset(h, 0, sizeof *h + sizeof *ch);
 
@@ -531,6 +583,18 @@
 	}
 	read_unlock(&dev_base_lock);
 
+	if (tail != NULL)
+		*tail = sl_tail;
+	return sl;
+}
+
+void
+aoecmd_cfg(ushort aoemajor, unsigned char aoeminor)
+{
+	struct sk_buff *sl;
+
+	sl = aoecmd_cfg_pkts(aoemajor, aoeminor, NULL);
+
 	aoenet_xmit(sl);
 }
  
@@ -619,23 +683,28 @@
 	if (bufcnt > MAXFRAMES)	/* keep it reasonable */
 		bufcnt = MAXFRAMES;
 
-	d = aoedev_set(sysminor, h->src, skb->dev, bufcnt);
+	d = aoedev_by_sysminor_m(sysminor, bufcnt);
 	if (d == NULL) {
-		printk(KERN_INFO "aoe: aoecmd_cfg_rsp: device set failure\n");
+		printk(KERN_INFO "aoe: aoecmd_cfg_rsp: device sysminor_m failure\n");
 		return;
 	}
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	if (d->flags & (DEVFL_UP | DEVFL_CLOSEWAIT)) {
+	/* permit device to migrate mac and network interface */
+	d->ifp = skb->dev;
+	memcpy(d->addr, h->src, sizeof d->addr);
+
+	/* don't change users' perspective */
+	if (d->nopen && !(d->flags & DEVFL_PAUSE)) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
-
+	d->flags |= DEVFL_PAUSE;	/* force pause */
 	d->fw_ver = be16_to_cpu(ch->fwver);
 
-	/* we get here only if the device is new */
-	sl = aoecmd_ata_id(d);
+	/* check for already outstanding ataid */
+	sl = aoedev_isbusy(d) == 0 ? aoecmd_ata_id(d) : NULL;
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoe.h
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoe.h	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoe.h	2006-01-02 13:35:13.000000000 -0500
@@ -75,8 +75,9 @@
 	DEVFL_TKILL = (1<<1),	/* flag for timer to know when to kill self */
 	DEVFL_EXT = (1<<2),	/* device accepts lba48 commands */
 	DEVFL_CLOSEWAIT = (1<<3), /* device is waiting for all closes to revalidate */
-	DEVFL_WC_UPDATE = (1<<4), /* this device needs to update write cache status */
-	DEVFL_WORKON = (1<<4),
+	DEVFL_GDALLOC = (1<<4),	/* need to alloc gendisk */
+	DEVFL_PAUSE = (1<<5),
+	DEVFL_NEWSIZE = (1<<6),	/* need to update dev size in block layer */
 
 	BUFFL_FAIL = 1,
 };
@@ -152,16 +153,18 @@
 void aoechr_error(char *);
 
 void aoecmd_work(struct aoedev *d);
-void aoecmd_cfg(ushort, unsigned char);
+void aoecmd_cfg(ushort aoemajor, unsigned char aoeminor);
+struct sk_buff *aoecmd_cfg_pkts(ushort, unsigned char, struct sk_buff **);
 void aoecmd_ata_rsp(struct sk_buff *);
 void aoecmd_cfg_rsp(struct sk_buff *);
+void aoecmd_sleepwork(void *vp);
 
 int aoedev_init(void);
 void aoedev_exit(void);
 struct aoedev *aoedev_by_aoeaddr(int maj, int min);
+struct aoedev *aoedev_by_sysminor_m(ulong sysminor, ulong bufcnt);
 void aoedev_downdev(struct aoedev *d);
-struct aoedev *aoedev_set(ulong, unsigned char *, struct net_device *, ulong);
-int aoedev_busy(void);
+int aoedev_isbusy(struct aoedev *d);
 
 int aoenet_init(void);
 void aoenet_exit(void);
Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoechr.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoechr.c	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoechr.c	2006-01-02 13:35:13.000000000 -0500
@@ -13,6 +13,7 @@
 	MINOR_ERR = 2,
 	MINOR_DISCOVER,
 	MINOR_INTERFACES,
+	MINOR_REVALIDATE,
 	MSGSZ = 2048,
 	NARGS = 10,
 	NMSG = 100,		/* message backlog to retain */
@@ -41,6 +42,7 @@
 	{ MINOR_ERR, "err" },
 	{ MINOR_DISCOVER, "discover" },
 	{ MINOR_INTERFACES, "interfaces" },
+	{ MINOR_REVALIDATE, "revalidate" },
 };
 
 static int
@@ -62,6 +64,39 @@
 	return 0;
 }
 
+static int
+revalidate(const char __user *str, size_t size)
+{
+	int major, minor, n;
+	ulong flags;
+	struct aoedev *d;
+	char buf[16];
+
+	if (size >= sizeof buf)
+		return -EINVAL;
+	buf[sizeof buf - 1] = '\0';
+	if (copy_from_user(buf, str, size))
+		return -EFAULT;
+
+	/* should be e%d.%d format */
+	n = sscanf(buf, "e%d.%d", &major, &minor);
+	if (n != 2) {
+		printk(KERN_ERR "aoe: %s: invalid device specification\n",
+			__FUNCTION__);
+		return -EINVAL;
+	}
+	d = aoedev_by_aoeaddr(major, minor);
+	if (!d)
+		return -EINVAL;
+
+	spin_lock_irqsave(&d->lock, flags);
+	d->flags |= DEVFL_PAUSE;
+	spin_unlock_irqrestore(&d->lock, flags);
+	aoecmd_cfg(major, minor);
+
+	return 0;
+}
+
 void
 aoechr_error(char *msg)
 {
@@ -114,6 +149,8 @@
 	case MINOR_INTERFACES:
 		ret = interfaces(buf, cnt);
 		break;
+	case MINOR_REVALIDATE:
+		ret = revalidate(buf, cnt);
 	}
 	if (ret == 0)
 		ret = cnt;


-- 
  Ed L. Cashin <ecashin@coraid.com>

