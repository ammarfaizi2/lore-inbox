Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWCXGNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWCXGNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423168AbWCXGMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:36058 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161010AbWCXGLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:42 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/12] aoe [2/8]: support dynamic resizing of AoE devices
In-Reply-To: <1143180653125-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:53 -0800
Message-Id: <11431806533538-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the driver to recognize AoE devices that have changed size.
Devices not in use are updated automatically, and devices that are in
use are updated at user request.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 Documentation/aoe/mkdevs.sh |    2 
 Documentation/aoe/udev.txt  |    1 
 drivers/block/aoe/aoe.h     |   12 ++-
 drivers/block/aoe/aoeblk.c  |   22 ++---
 drivers/block/aoe/aoechr.c  |   37 +++++++++
 drivers/block/aoe/aoecmd.c  |  177 +++++++++++++++++++++++++++++--------------
 drivers/block/aoe/aoedev.c  |   69 ++++++++++++-----
 7 files changed, 223 insertions(+), 97 deletions(-)

3ae1c24e395b2b65326439622223d88d92bfa03a
diff --git a/Documentation/aoe/mkdevs.sh b/Documentation/aoe/mkdevs.sh
index ec5a6de..97374aa 100644
--- a/Documentation/aoe/mkdevs.sh
+++ b/Documentation/aoe/mkdevs.sh
@@ -27,6 +27,8 @@ rm -f $dir/discover
 mknod -m 0200 $dir/discover c $MAJOR 3
 rm -f $dir/interfaces
 mknod -m 0200 $dir/interfaces c $MAJOR 4
+rm -f $dir/revalidate
+mknod -m 0200 $dir/revalidate c $MAJOR 5
 
 export n_partitions
 mkshelf=`echo $0 | sed 's!mkdevs!mkshelf!'`
diff --git a/Documentation/aoe/udev.txt b/Documentation/aoe/udev.txt
index ab39d8b..a7ed1dc 100644
--- a/Documentation/aoe/udev.txt
+++ b/Documentation/aoe/udev.txt
@@ -18,6 +18,7 @@
 SUBSYSTEM="aoe", KERNEL="discover",	NAME="etherd/%k", GROUP="disk", MODE="0220"
 SUBSYSTEM="aoe", KERNEL="err",		NAME="etherd/%k", GROUP="disk", MODE="0440"
 SUBSYSTEM="aoe", KERNEL="interfaces",	NAME="etherd/%k", GROUP="disk", MODE="0220"
+SUBSYSTEM="aoe", KERNEL="revalidate",	NAME="etherd/%k", GROUP="disk", MODE="0220"
 
 # aoe block devices     
 KERNEL="etherd*",       NAME="%k", GROUP="disk"
diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 881c48d..bb7dd91 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -75,8 +75,9 @@ enum {
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
@@ -152,16 +153,17 @@ void aoechr_exit(void);
 void aoechr_error(char *);
 
 void aoecmd_work(struct aoedev *d);
-void aoecmd_cfg(ushort, unsigned char);
+void aoecmd_cfg(ushort aoemajor, unsigned char aoeminor);
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
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index c05ee8b..039c091 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -22,7 +22,9 @@ static ssize_t aoedisk_show_state(struct
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
@@ -107,8 +109,7 @@ aoeblk_release(struct inode *inode, stru
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	if (--d->nopen == 0 && (d->flags & DEVFL_CLOSEWAIT)) {
-		d->flags &= ~DEVFL_CLOSEWAIT;
+	if (--d->nopen == 0 && !(d->flags & DEVFL_UP)) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		aoecmd_cfg(d->aoemajor, d->aoeminor);
 		return 0;
@@ -158,14 +159,14 @@ aoeblk_make_request(request_queue_t *q, 
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
 
@@ -205,7 +206,7 @@ aoeblk_gdalloc(void *vp)
 		printk(KERN_ERR "aoe: aoeblk_gdalloc: cannot allocate disk "
 			"structure for %ld.%ld\n", d->aoemajor, d->aoeminor);
 		spin_lock_irqsave(&d->lock, flags);
-		d->flags &= ~DEVFL_WORKON;
+		d->flags &= ~DEVFL_GDALLOC;
 		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
@@ -218,7 +219,7 @@ aoeblk_gdalloc(void *vp)
 			"for %ld.%ld\n", d->aoemajor, d->aoeminor);
 		put_disk(gd);
 		spin_lock_irqsave(&d->lock, flags);
-		d->flags &= ~DEVFL_WORKON;
+		d->flags &= ~DEVFL_GDALLOC;
 		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
@@ -235,18 +236,13 @@ aoeblk_gdalloc(void *vp)
 
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
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index 41ae0ed..5327f55 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -13,6 +13,7 @@ enum {
 	MINOR_ERR = 2,
 	MINOR_DISCOVER,
 	MINOR_INTERFACES,
+	MINOR_REVALIDATE,
 	MSGSZ = 2048,
 	NARGS = 10,
 	NMSG = 100,		/* message backlog to retain */
@@ -41,6 +42,7 @@ static struct aoe_chardev chardevs[] = {
 	{ MINOR_ERR, "err" },
 	{ MINOR_DISCOVER, "discover" },
 	{ MINOR_INTERFACES, "interfaces" },
+	{ MINOR_REVALIDATE, "revalidate" },
 };
 
 static int
@@ -62,6 +64,39 @@ interfaces(const char __user *str, size_
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
@@ -114,6 +149,8 @@ aoechr_write(struct file *filp, const ch
 	case MINOR_INTERFACES:
 		ret = interfaces(buf, cnt);
 		break;
+	case MINOR_REVALIDATE:
+		ret = revalidate(buf, cnt);
 	}
 	if (ret == 0)
 		ret = cnt;
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 4ab01ce..150eb78 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/genhd.h>
 #include <asm/unaligned.h>
 #include "aoe.h"
 
@@ -189,12 +190,67 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 	}
 }
 
+/* some callers cannot sleep, and they can call this function,
+ * transmitting the packets later, when interrupts are on
+ */
+static struct sk_buff *
+aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff **tail)
+{
+	struct aoe_hdr *h;
+	struct aoe_cfghdr *ch;
+	struct sk_buff *skb, *sl, *sl_tail;
+	struct net_device *ifp;
+
+	sl = sl_tail = NULL;
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
+		if (sl_tail == NULL)
+			sl_tail = skb;
+		h = (struct aoe_hdr *) skb->mac.raw;
+		memset(h, 0, sizeof *h + sizeof *ch);
+
+		memset(h->dst, 0xff, sizeof h->dst);
+		memcpy(h->src, ifp->dev_addr, sizeof h->src);
+		h->type = __constant_cpu_to_be16(ETH_P_AOE);
+		h->verfl = AOE_HVER;
+		h->major = cpu_to_be16(aoemajor);
+		h->minor = aoeminor;
+		h->cmd = AOECMD_CFG;
+
+		skb->next = sl;
+		sl = skb;
+	}
+	read_unlock(&dev_base_lock);
+
+	if (tail != NULL)
+		*tail = sl_tail;
+	return sl;
+}
+
 /* enters with d->lock held */
 void
 aoecmd_work(struct aoedev *d)
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
@@ -306,6 +362,37 @@ tdie:		spin_unlock_irqrestore(&d->lock, 
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
+			mutex_lock(&bd->bd_inode->i_mutex);
+			i_size_write(bd->bd_inode, (loff_t)ssize<<9);
+			mutex_unlock(&bd->bd_inode->i_mutex);
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
@@ -340,21 +427,29 @@ ataid_complete(struct aoedev *d, unsigne
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
@@ -452,7 +547,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 				return;
 			}
 			ataid_complete(d, (char *) (ahin+1));
-			/* d->flags |= DEVFL_WC_UPDATE; */
+			d->flags &= ~DEVFL_PAUSE;
 			break;
 		default:
 			printk(KERN_INFO "aoe: aoecmd_ata_rsp: unrecognized "
@@ -485,51 +580,19 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	f->tag = FREETAG;
 
 	aoecmd_work(d);
-
 	sl = d->sendq_hd;
 	d->sendq_hd = d->sendq_tl = NULL;
 
 	spin_unlock_irqrestore(&d->lock, flags);
-
 	aoenet_xmit(sl);
 }
 
 void
 aoecmd_cfg(ushort aoemajor, unsigned char aoeminor)
 {
-	struct aoe_hdr *h;
-	struct aoe_cfghdr *ch;
-	struct sk_buff *skb, *sl;
-	struct net_device *ifp;
-
-	sl = NULL;
-
-	read_lock(&dev_base_lock);
-	for (ifp = dev_base; ifp; dev_put(ifp), ifp = ifp->next) {
-		dev_hold(ifp);
-		if (!is_aoe_netif(ifp))
-			continue;
-
-		skb = new_skb(ifp, sizeof *h + sizeof *ch);
-		if (skb == NULL) {
-			printk(KERN_INFO "aoe: aoecmd_cfg: skb alloc failure\n");
-			continue;
-		}
-		h = (struct aoe_hdr *) skb->mac.raw;
-		memset(h, 0, sizeof *h + sizeof *ch);
-
-		memset(h->dst, 0xff, sizeof h->dst);
-		memcpy(h->src, ifp->dev_addr, sizeof h->src);
-		h->type = __constant_cpu_to_be16(ETH_P_AOE);
-		h->verfl = AOE_HVER;
-		h->major = cpu_to_be16(aoemajor);
-		h->minor = aoeminor;
-		h->cmd = AOECMD_CFG;
+	struct sk_buff *sl;
 
-		skb->next = sl;
-		sl = skb;
-	}
-	read_unlock(&dev_base_lock);
+	sl = aoecmd_cfg_pkts(aoemajor, aoeminor, NULL);
 
 	aoenet_xmit(sl);
 }
@@ -562,9 +625,6 @@ aoecmd_ata_id(struct aoedev *d)
 	f->waited = 0;
 	f->writedatalen = 0;
 
-	/* this message initializes the device, so we reset the rttavg */
-	d->rttavg = MAXTIMER;
-
 	/* set up ata header */
 	ah->scnt = 1;
 	ah->cmdstat = WIN_IDENTIFY;
@@ -572,12 +632,8 @@ aoecmd_ata_id(struct aoedev *d)
 
 	skb = skb_prepare(d, f);
 
-	/* we now want to start the rexmit tracking */
-	d->flags &= ~DEVFL_TKILL;
-	d->timer.data = (ulong) d;
+	d->rttavg = MAXTIMER;
 	d->timer.function = rexmit_timer;
-	d->timer.expires = jiffies + TIMERTICK;
-	add_timer(&d->timer);
 
 	return skb;
 }
@@ -619,23 +675,28 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
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
 
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index ded33ba..ed4258a 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
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
@@ -28,6 +46,18 @@ aoedev_by_aoeaddr(int maj, int min)
 	return d;
 }
 
+static void
+dummy_timer(ulong vp)
+{
+	struct aoedev *d;
+
+	d = (struct aoedev *)vp;
+	if (d->flags & DEVFL_TKILL)
+		return;
+	d->timer.expires = jiffies + HZ;
+	add_timer(&d->timer);
+}
+
 /* called with devlist lock held */
 static struct aoedev *
 aoedev_newdev(ulong nframes)
@@ -44,6 +74,8 @@ aoedev_newdev(ulong nframes)
 		return NULL;
 	}
 
+	INIT_WORK(&d->work, aoecmd_sleepwork, d);
+
 	d->nframes = nframes;
 	d->frames = f;
 	e = f + nframes;
@@ -52,6 +84,10 @@ aoedev_newdev(ulong nframes)
 
 	spin_lock_init(&d->lock);
 	init_timer(&d->timer);
+	d->timer.data = (ulong) d;
+	d->timer.function = dummy_timer;
+	d->timer.expires = jiffies + HZ;
+	add_timer(&d->timer);
 	d->bufpool = NULL;	/* defer to aoeblk_gdalloc */
 	INIT_LIST_HEAD(&d->bufq);
 	d->next = devlist;
@@ -67,9 +103,6 @@ aoedev_downdev(struct aoedev *d)
 	struct buf *buf;
 	struct bio *bio;
 
-	d->flags |= DEVFL_TKILL;
-	del_timer(&d->timer);
-
 	f = d->frames;
 	e = f + d->nframes;
 	for (; f<e; f->tag = FREETAG, f->buf = NULL, f++) {
@@ -92,16 +125,15 @@ aoedev_downdev(struct aoedev *d)
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
@@ -112,25 +144,19 @@ aoedev_set(ulong sysminor, unsigned char
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
 
@@ -161,6 +187,7 @@ aoedev_exit(void)
 
 		spin_lock_irqsave(&d->lock, flags);
 		aoedev_downdev(d);
+		d->flags |= DEVFL_TKILL;
 		spin_unlock_irqrestore(&d->lock, flags);
 
 		del_timer_sync(&d->timer);
-- 
1.2.4


