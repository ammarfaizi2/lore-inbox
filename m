Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758404AbWK0Q7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758404AbWK0Q7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758410AbWK0Q7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:59:14 -0500
Received: from hera.kernel.org ([140.211.167.34]:27592 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1758403AbWK0Q7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:59:12 -0500
Date: Mon, 27 Nov 2006 16:59:05 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200611271659.kARGx5qb017564@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] dm-cow: copy-on-write stackable target for device-mapper
Cc: dm-devel@redhat.com, paurea@gmail.com, ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [RFC] [PATCH] dm-cow: copy-on-write stackable target for device-mapper

This is the first cut of a device-mapper target which allows stacking of
multiple block devices and in which the top-layer of the stack is a 
copy-on-write layer.  It was originally developed in support of a cluster 
image management solution.

Existing device mapper snapshot facilities could be used to implement 
stackable block devices, as they support a copy-on-write mechanism 
for taking snapshots of logical volumes.  However, benchmarks (using
bonnie++) of such solutions showed an order of magnitude performance 
degredation.  This target was written in an attempt to provide a stacking 
and copy-on-write solution which would incur only a minimal overhead.

Detailed performance results will be available shortly in a technical-report
available via IBM's CyberDigest website -- however, initial results obtained 
with bonnie++ show dramatic performance improvements.

The code within this module was developed by an intern (Gorka
Guardiola) during his stay with us at IBM Research.  Please direct comments
both to myself and Gorka.

Signed-off-by: Eric Van Hensbegren <bergevan@us.ibm.com>
---
 Documentation/device-mapper/dm-cow.txt |   29 +
 drivers/md/Kconfig                     |   15 +
 drivers/md/Makefile                    |    1 
 drivers/md/dm-cow.c                    |  926 ++++++++++++++++++++++++++++++++
 4 files changed, 971 insertions(+), 0 deletions(-)

diff --git a/Documentation/device-mapper/dm-cow.txt b/Documentation/device-mapper/dm-cow.txt
new file mode 100644
index 0000000..2b18ee6
--- /dev/null
+++ b/Documentation/device-mapper/dm-cow.txt
@@ -0,0 +1,29 @@
+This is a target for the dm-mapper which stacks
+block devices. The base image B is a formatted block
+device. Over that go N read only block devices R
+and then 1 write device W. It does copy on write
+of the devices, and reads from the appropiate device.
+You start by formatting B. Then add a W on it.
+W consists on two parts, a block device for the bitmap
+which should start zeroed and which gets some magic number
+on it the first time it is used. The you can add another
+W and the first W turns into a R. WRB. and so on.
+
+A simple script file is included to format WB.
+The way it works is the standard dmsetup calls for
+the device mapper. The arguments are
+
+N M logdevname Bdevname Boffset Rbitmapdev Rdevname Roffset Wbitmapdev Wdevname Woffset 
+
+N and M are the offsets on the logical device /dev/mapper/logdevname
+
+Bdevname is the base image device name
+Boffset is the offset on the base image device
+Rbitmapdev is the block device for the bitmap on a read only device
+
+and so on.
+
+a real world example of BW:
+
+0 8385866 cow /dev/sdb1 0 /dev/sdb2 /dev/sdb3 0
+
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index c92c152..dc86099 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -261,6 +261,21 @@ config DM_MULTIPATH_EMC
 	---help---
 	  Multipath support for EMC CX/AX series hardware.
 
+config DM_COW
+	tristate "Copy-on-write Stackable target (EXPERIMENTAL)"
+	depends on BLK_DEV_DM && EXPERIMENTAL
+	---help---
+          This is a target for the dm-mapper which stacks
+          block devices. The base image B is a formatted block
+          device. Over that go N read only block devices R
+          and then 1 write device W. It does copy on write
+          of the devices, and reads from the appropiate device.
+          You start by formatting B. Then add a W on it.
+          W consists on two parts, a block device for the bitmap
+          which should start zeroed and which gets some magic number
+          on it the first time it is used. The you can add another
+          W and the first W turns into a R. WRB. and so on.
+
 endmenu
 
 endif
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 34957a6..8a3d79f 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_DM_MULTIPATH_EMC)	+= dm-emc
 obj-$(CONFIG_DM_SNAPSHOT)	+= dm-snapshot.o
 obj-$(CONFIG_DM_MIRROR)		+= dm-mirror.o
 obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
+obj-$(CONFIG_DM_COW)		+= dm-cow.o
 
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \
diff --git a/drivers/md/dm-cow.c b/drivers/md/dm-cow.c
new file mode 100644
index 0000000..e77060e
--- /dev/null
+++ b/drivers/md/dm-cow.c
@@ -0,0 +1,926 @@
+/*
+ * dm-cow.c
+ * Device mapper target for block-level disk caching
+ * 
+ * Copyright (C) International Business Machines Corp., 2006
+ * Author: Gorka Guardiola and Eric Van Hensbergen (bergevan@us.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include "dm.h"
+#define DM_MSG_PREFIX "cow"
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/swap.h>
+#include <linux/buffer_head.h>
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+#include <linux/bit_spinlock.h>
+#include "kcopyd.h"
+
+/*
+ *
+ *	Cow: maps various block devices as cows
+ *	1)  There is a separate device for a bitmap saying where the cow is.
+ *	- To start using, zero the bitmap device first. 
+ *
+ *	2) if write, set bitmap, do the write.
+ *		if read, get bitmap of each till i get lucky
+ *		the device comes from
+ *			cc->dev->bdev;
+ *	    NO NEED TO COPY ON WRITE: either you write directly or you
+ *	    read to cache and  then write. The read comes from
+ *	    source, the write sets bitmap and goes to dest.
+ *
+ *	3) To make the bitmap I have to access the device using directly using
+ *	    sector functions which go through the cache. 
+ *	    Maybe write ordered for the bitmap would be good to (a la journal).
+ *
+ */
+
+/* portable way of adding and picking 64 bits sector length. */
+#define	PBIT64(p,v) (p)[0]=(v);(p)[1]=(v)>>8;(p)[2]=(v)>>16;(p)[3]=(v)>>24; \
+		    (p)[4]=(v)>>32;(p)[5]=(v)>>40;(p)[6]=(v)>>48;(p)[7]=(v)>>56
+
+#define GBIT64(p) ((u32)((p)[0]|((p)[1]<<8)|((p)[2]<<16)|((p)[3]<<24)) |\
+		   ((u64)((p)[4]|((p)[5]<<8)|((p)[6]<<16)|((p)[7]<<24)) << 32))
+
+#define	BYTE_SHIFT 3LL
+#define	SECT_SHIFT 9LL		//512 bytes per sector.
+#define	BYTEMSK  ((1LL << BYTE_SHIFT) - 1LL)
+#define	SECTMSK (((1LL << (SECT_SHIFT+BYTE_SHIFT)) - 1LL))
+#define	SECTSZ  (1LL << SECT_SHIFT)
+#define	READMSK (1LL<<BIO_RW)
+#define	MAGIC 0x00BABE0EAABABE11ULL
+
+#ifdef DEBUGCOW
+#define DPRINTK(S ...) printk(KERN_DEBUG "dm-cow:" S)
+#else
+#define DPRINTK(S ...)
+#endif
+
+#undef LOGBMAP
+#ifdef LOGBMAP
+#define DPRINTB(S ...) printk(KERN_DEBUG "dm-cow:" S)
+#else
+#define DPRINTB(S ...)
+#endif
+
+#undef LOGBLOCK
+#ifdef LOGBLOCK
+#define DPRINTBL(S ...) printk(KERN_DEBUG "dm-cow:" S)
+#else
+#define DPRINTBL(S ...)
+#endif
+
+#undef LOGPART
+#ifdef LOGPART
+#define DPRINTPART(S ...) printk(KERN_DEBUG "dm-cow:" S)
+#else
+#define DPRINTPART(S ...)
+#endif
+
+enum {
+	MAXBLKSIZEINSECT = 64,	//has to be 2^N, is in sectors.
+	DMU_PAGES = 256,
+	MAXDEV = 10,
+	MAXNAME = 25,
+	CACHESZ = 10,
+	BIT64SZ = 8,
+};
+
+struct cow_c {
+	char devname[MAXNAME + 1];
+	struct dm_dev *dev;
+	char bmapdevname[MAXNAME + 1];
+	struct dm_dev *bmap_dev;
+	long isset;
+	sector_t start;
+	sector_t bmap_len;
+	atomic_t nclients; 
+	/* just in use in the base, 1, not in use 0 means cleanup. */
+};
+
+static atomic_t nstacks;
+static atomic_t nmaps;
+static atomic_t nclients_preparing;
+static atomic_t nclients_sending;
+static atomic_t outreqs;
+static atomic_t outbytes;
+
+/*
+	this should be rewritten using the bitmap interface?, 
+	as it is now works and is fairly portable...
+*/
+
+static inline sector_t blksize2shift(sector_t block_size)
+{
+	sector_t cnt, sectinblk;
+
+	cnt = SECTOR_SHIFT;
+	sectinblk = block_size >> SECT_SHIFT;
+	while (!(sectinblk & 0x1)) {
+		if (cnt > 30) {	//paranoid
+			printk(KERN_ALERT
+			       "block size spurious, sectinblk, %lld \n",
+			       sectinblk);
+			cnt = 8;
+			break;
+		}
+		cnt++;
+		sectinblk >>= 1;
+	}
+	return cnt;
+}
+
+sector_t sect2bmapblk(sector_t nsect, struct block_device * bdev)
+{
+	sector_t bmapblk, blkmsk, blksz;
+
+	blksz = bdev->bd_block_size;
+	blkmsk = blksz - 1;
+	bmapblk = nsect >> (BYTE_SHIFT + blksize2shift(blksz));
+	return bmapblk;
+}
+
+/*
+ * our bitmap is composed of blocks(due to bread)/bytes/bits 
+ */
+
+static inline struct buffer_head *getbmapst(struct block_device *bdev,
+					    sector_t nsect)
+{
+	sector_t bmapblk;
+
+	bmapblk = sect2bmapblk(nsect, bdev);
+	DPRINTK("bitmap for block: %lld", bmapblk);
+
+	return __bread(bdev, bmapblk, bdev->bd_block_size);
+
+}
+
+static inline int issectbmset(struct block_device *bdev, sector_t nsect)
+{
+	char byte;
+	struct buffer_head *bh;
+	sector_t byteoffset, bitoffset, blkmsk;
+
+	DPRINTB("GET  nsect: %lld\n", nsect);
+	blkmsk = bdev->bd_block_size - 1;
+	byteoffset = (nsect & blkmsk) >> BYTE_SHIFT;
+	bitoffset = nsect & BYTEMSK;
+	bh = getbmapst(bdev, nsect);
+	if (!bh) {
+		printk(KERN_ALERT "I/O error, bitmap cannot be trusted\n");
+		return -1;
+	}
+
+	lock_page(bh->b_page);
+	mark_page_accessed(bh->b_page);
+	byte = bh->b_data[byteoffset];
+	unlock_page(bh->b_page);
+
+	put_bh(bh);
+	DPRINTB("GOT  %d in nsect: %lld\n", (byte >> bitoffset) & 1, nsect);
+	return (byte >> bitoffset) & 1;
+}
+
+static inline int sectbmset(struct block_device *bdev, sector_t nsect)
+{
+	char *byte;
+	struct buffer_head *bh;
+	sector_t byteoffset, bitoffset, blkmsk;
+
+	blkmsk = bdev->bd_block_size - 1;
+
+	byteoffset = (nsect & blkmsk) >> BYTE_SHIFT;
+	bitoffset = nsect & BYTEMSK;
+	DPRINTB("SET nsect: %lld\n", nsect);
+
+	bh = getbmapst(bdev, nsect);
+	if (!bh) {
+		printk(KERN_ALERT "I/O error, bitmap cannot be trusted\n");
+		return -1;
+	}
+
+	lock_page(bh->b_page);
+	lock_buffer(bh);
+	byte = bh->b_data + byteoffset;
+	*byte |= 1 << bitoffset;
+	mark_buffer_dirty(bh);
+	__set_page_dirty_nobuffers(bh->b_page);
+	unlock_buffer(bh);
+	flush_dcache_page(page);
+	unlock_page(bh->b_page);
+	put_bh(bh);
+	DPRINTB("SOT nsect: %lld\n", nsect);
+	return 0;
+}
+
+static inline void
+sectbmsetchk(struct block_device *bdev, sector_t nsect, sector_t chksz)
+{
+	sector_t i;
+
+	for (i = 0; i < chksz; i++) {
+		sectbmset(bdev, nsect + i);
+	}
+}
+
+/*
+ * This is cheap. simple enough
+ */
+
+static sector_t ccispresent(struct cow_c **cc, sector_t nsect, int ndevs)
+{
+	sector_t res;
+	int i, issect;
+
+	res = 0;
+
+	/* from up to down till I find it. */
+	for (i = ndevs - 1; i > 0; i--) {
+		BUG_ON(sect2bmapblk(nsect, cc[i]->bmap_dev->bdev) >
+		       cc[i]->bmap_len);
+		issect = issectbmset(cc[i]->bmap_dev->bdev, nsect);
+
+		if (issect < 0)
+			return -1;
+		if (issect) {
+			res = i;
+			break;
+		}
+	}
+
+	return res;
+}
+
+static void printcow(struct dm_target *ti, struct cow_c *cc, char cmode)
+{
+	printk(KERN_INFO "dm-cow: setting Cow %p\n", cc);
+	printk(KERN_INFO "dm-cow: devname: %s\n", cc->devname);
+
+	if (cc->bmapdevname[0])
+		printk(KERN_INFO "dm-cow: bmapdev: %s\n", cc->bmapdevname);
+	else
+		printk(KERN_INFO
+		       "dm-cow: bmapdev: setting base image, no bmap\n");
+	printk(KERN_INFO
+	       "dm-cow: bmap_len: %lld, ti->len: %lld, ti->begin: %lld\n",
+	       cc->bmap_len, ti->len, ti->begin);
+	printk(KERN_INFO "dm-cow: block size, %ud, mode %c\n",
+	       cc->dev->bdev->bd_block_size, cmode);
+}
+
+/*
+ * 	Either it is first time, so the bitmap is zero or it is
+ * 	the second time, then the sizes have to fit.
+ * 	bmapwholelen is aligned to MAXBLK, which should be a block
+ */
+
+static inline int
+bmapmagic(struct block_device *bdev, sector_t bmap_len, sector_t bmapwholelen)
+{
+	struct buffer_head *bh;
+	u64 magic, blen, newmagic;
+	sector_t sblen, blk, blkinsect;
+
+	blen = (u64) bmap_len;
+	blkinsect = (bmapwholelen & ~(MAXBLKSIZEINSECT - 1)) + MAXBLKSIZEINSECT;
+	blk = (blkinsect << SECT_SHIFT) >> blksize2shift(bdev->bd_block_size);
+	bh = __bread(bdev, blk, bdev->bd_block_size);
+	if (!bh) {
+		printk(KERN_ALERT "I/O error, bitmap cannot be trusted\n");
+		return -1;
+	}
+
+	lock_page(bh->b_page);
+
+	magic = GBIT64( ((unsigned char *) bh->b_data) );
+	if (magic && (magic != MAGIC)) {
+		printk(KERN_ALERT "dm-cow: bad magic: %llx, blk: %lld\n",
+		       magic, blk);
+		return -1;
+	}
+
+	if (!magic) {
+		newmagic = MAGIC;
+		lock_buffer(bh);
+		PBIT64(((u8 *) bh->b_data), newmagic);
+		PBIT64(((u8 *) bh->b_data) + BIT64SZ, blen);
+		mark_buffer_dirty(bh);
+		unlock_buffer(bh);
+		flush_dcache_page(page);
+		unlock_page(bh->b_page);
+		/* write the magic synchronously */
+		ll_rw_block(WRITE, 1, &bh);
+	} else {
+		lock_buffer(bh);
+		blen = GBIT64(((u8 *) bh->b_data) + BIT64SZ);
+		unlock_buffer(bh);
+		unlock_page(bh->b_page);
+	}
+
+	put_bh(bh);
+	if (!magic) {
+		sblen = (sector_t) blen;
+		if (sblen != bmap_len) {
+			printk(KERN_ALERT
+			       "dm-cow: bad len in bitmap: %llx, blk: %lld",
+			       magic, blk);
+			return -1;
+		} else {
+			printk(KERN_INFO
+			       "dm-cow: no magic: %llx, setting magic in bitmap, blk: %lld, blen: %llu\n",
+			       magic, blk, blen);
+		}
+	} else {
+		printk(KERN_INFO
+		       "dm-cow: read magic %llx blk: %lld, blen: %llu \n",
+		       magic, blk, blen);
+	}
+
+	return 0;
+}
+
+static void set_cow(struct dm_target *ti, struct cow_c *cc, int mode)
+{
+	char cmode;
+	int bmapmode, res;
+	sector_t bmapwholelen;
+
+	if (mode & FMODE_WRITE) {
+		cmode = 'w';
+	} else {
+		cmode = 'r';
+	}
+
+	bmapmode = mode;
+
+	res =
+	    dm_get_device(ti, cc->devname, cc->start, ti->len, mode, &cc->dev);
+	if (res) {
+		ti->error = "dm-cow: Device lookup failed";
+		return;
+	}
+
+	cc->bmap_len = 1LL + (ti->len >> (SECT_SHIFT + BYTE_SHIFT));
+
+	/*
+	 * we dont know block size yet, so we align to maximum.
+	 * one for alignment and another for the magic
+	 */
+
+	bmapwholelen = (cc->bmap_len & ~(MAXBLKSIZEINSECT - 1)) + 2
+	    * MAXBLKSIZEINSECT;
+	printk(KERN_ALERT "bmapwholelen: %llu\n", bmapwholelen);
+	if (cc->bmapdevname[0] &&
+	    dm_get_device(ti, cc->bmapdevname, 0, cc->bmap_len, bmapmode,
+			  &cc->bmap_dev)) {
+		ti->error = "dm-cow: Bitmap lookup failed";
+		goto err1;
+	}
+
+	if (cc->bmapdevname[0]) {
+		res = bmapmagic(cc->bmap_dev->bdev, cc->bmap_len, bmapwholelen);
+		if (res) {
+			printk(KERN_ALERT
+			       "dm-cow: error, bad magic in bitmap %s\n",
+			       cc->bmapdevname);
+			ti->error = "dm-cow: Bad magic in bitmap";
+			goto err2;
+		}
+	}
+	cc->isset++;
+	printcow(ti, cc, cmode);
+	return;
+
+      err2:
+	dm_put_device(ti, cc->bmap_dev);
+      err1:
+	dm_put_device(ti, cc->dev);
+	return;
+}
+
+static struct cow_c *new_cow(void)
+{
+	struct cow_c *cc;
+
+	cc = kzalloc(sizeof(struct cow_c), GFP_KERNEL);
+	atomic_set(&cc->nclients, 1);
+	return cc;
+}
+
+static void free_cow(struct cow_c *cc, struct dm_target *ti)
+{
+	if (cc->isset) {
+		dm_put_device(ti, cc->dev);
+		if (cc->bmapdevname[0])
+			dm_put_device(ti, cc->bmap_dev);
+	}
+
+	kfree(cc);
+}
+
+static int parseargs(int argc, char **argv, char **err, struct cow_c **cc)
+{
+	int i;
+
+	DPRINTK("cow_ctr: argc: %d\n", argc);
+	argc++;			/* the base doesnt have bitmap */
+
+	if (argc < 3 || argc > 3 * MAXDEV) {
+		*err = "dm-cow: Insufficient arguments";
+		return -EINVAL;
+	}
+
+	if (!argc % 3) {
+		*err =
+		    "dm-cow: arguments should come in threes bmapdev/dev/offset";
+		return -EINVAL;
+	}
+
+	for (i = 0; i < argc / 3; i++) {
+		cc[i] = new_cow();
+		if (!cc[i])
+			return -ENOMEM;
+	}
+
+	/* we start at -1 because the base has no bmap. */
+	i = -1;
+	while (argc) {
+		if (i > 0)
+			strncpy(cc[(i + 1) / 3]->bmapdevname, argv[i], MAXNAME);
+		strncpy(cc[(i + 1) / 3]->devname, argv[i + 1], MAXNAME);
+		if (sscanf(argv[i + 2], "%lld", &cc[(i + 1) / 3]->start) != 1) {
+			*err = "dm-cow: Invalid device sector";
+			return -EINVAL;
+		}
+		argc -= 3;
+		i += 3;
+	}
+	return 0;
+}
+
+/*
+ * Construct a cow mapping: (<dev_path> <bmapdev_path> <offset>)+
+ * tried only on two layers, but written for N
+ */
+
+static int cow_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct cow_c **cc;
+	int i, mode, res;
+
+	res = 0;
+	ti->error = NULL;
+	printk(KERN_INFO "cow: new cow stack\n");
+
+	cc = kzalloc((MAXDEV + 1) * sizeof(struct cow_c *), GFP_KERNEL);
+	if (cc == NULL) {
+		ti->error = "dm-cow: Cannot allocate cow context pointers";
+		return -ENOMEM;
+	}
+
+	atomic_inc(&nstacks);
+
+	printk(KERN_INFO "cow: new cow stack\n");
+	res = parseargs(argc, argv, &ti->error, cc);
+	if (ti->error)
+		return res;
+	mode = FMODE_READ;
+	for (i = 0; cc[i]; i++) {
+		if (!cc[i + 1])
+			mode |= FMODE_WRITE;	//just the last one is writable.
+		set_cow(ti, cc[i], mode);
+		if (ti->error) {
+			res = -EINVAL;
+			goto bad;
+		}
+	}
+
+	ti->private = cc;
+
+	return 0;
+
+      bad:
+	for (i = 0; i < MAXDEV + 1; i++) {
+		if (!cc[i])
+			break;
+		free_cow(cc[i], ti);
+	}
+
+	kfree(cc);
+
+	return res;
+}
+
+static void cleanup(struct dm_target *ti)
+{
+	int i;
+	struct cow_c **cc = (struct cow_c **)ti->private;
+
+	printk(KERN_INFO "cow: cleaning up\n");
+	atomic_dec(&nstacks);
+	for (i = 0; i < MAXDEV; i++) {
+		if (cc[i])
+			free_cow(cc[i], ti);
+	}
+
+	kfree(cc);
+}
+
+static void cow_dtr(struct dm_target *ti)
+{
+	struct cow_c **cc = (struct cow_c **)ti->private;
+	if (atomic_dec_and_test(&cc[0]->nclients)) {
+		cleanup(ti);
+	} else {
+		printk(KERN_INFO
+		       "cow: pending operations, not cleaning up yet %d\n",
+		       cc[0]->nclients.counter);
+	}
+}
+
+static inline sector_t
+bv_gotosectpage(struct bio_vec *bv, sector_t sidx, short max, short *pgcons)
+{
+	sector_t consm;
+	short i;
+
+	consm = 0;
+
+	for (i = 0; i < max; i++) {	/* go to page */
+		if (consm + (bv[i].bv_len >> SECT_SHIFT) > sidx) {
+			*pgcons = i;
+			return consm;
+		}
+		consm += bv[i].bv_len >> SECT_SHIFT;
+	}
+	printk(KERN_ALERT "Error going to sect page");
+	return consm;
+}
+
+static int endpartial(struct bio *bio, unsigned int nbytes, int error)
+{
+	struct bio *bioparen;
+
+	bioparen = (struct bio *)bio->bi_private;
+
+	DPRINTPART("ENDPART[%p] %p chunk, dev %p st %lld csz %d\n",
+		   bioparen, bio, bio->bi_bdev, bio->bi_sector, nbytes);
+	if (error)
+		printk(KERN_ALERT "cow, I/O error, %d\n", error);
+	if (!bio->bi_size)	/* only one gets here. */
+		DPRINTPART("PARTIAL REQ[%p] COMPLETE\n", bio);
+	else
+		return 1;
+	if (!bioparen->bi_size) {
+		DPRINTPART("TOTAL REQ[%p] COMPLETE\n", bio);
+	}
+	atomic_sub(nbytes, &outbytes);
+	bio_endio(bioparen, nbytes, error);
+
+	if ((atomic_read(&bioparen->bi_cnt) == 1) && bioparen->bi_size) {
+		printk(KERN_ALERT "cow: strange bio error nomem\n");
+		bio_endio(bioparen, bioparen->bi_size, -ENOMEM);	//IO?
+	}
+	if (!bio->bi_size) {
+		atomic_dec(&outreqs);
+		bio_put(bio);
+		bio_put(bioparen);
+	}
+	return 0;
+}
+
+static inline void bvsubset(struct bio_vec *bv, int npages, int offset)
+{
+	bv[npages].bv_offset += offset << SECT_SHIFT;
+	bv[npages].bv_len -= offset << SECT_SHIFT;
+
+	return;
+}
+
+/* PAGE OFFSET PROBLEM, ugly solution */
+static struct bio *do_op(struct cow_c *dst, struct bio *bio, sector_t st,
+			 sector_t idx, sector_t chunksz)
+{
+	struct bio *bioc;
+	sector_t consm;
+	short pgcons;
+
+	pgcons = 0;
+
+	bio_get(bio);
+	consm = bv_gotosectpage(bio->bi_io_vec, idx, bio->bi_vcnt, &pgcons);
+
+	bioc = bio_clone(bio, GFP_NOIO);
+	if (!bioc) {
+		printk(KERN_ALERT "cow: erro cloning bio\n");
+		return NULL;
+	}
+	bioc->bi_flags &= ~(1 << BIO_SEG_VALID);
+	bvsubset(bioc->bi_io_vec, pgcons, idx - consm);
+	bioc->bi_idx = pgcons;
+	bioc->bi_bdev = dst->dev->bdev;
+	bioc->bi_sector = st + dst->start - (idx - consm);
+	bioc->bi_size = chunksz << SECT_SHIFT;
+	bioc->bi_private = bio;
+	bioc->bi_end_io = endpartial;
+	DPRINTPART("STARTPART[%p] %p chunk %d, dev %p st %lld csz %d from %d\n",
+		   bio, bioc, pgcons, bioc->bi_bdev, bioc->bi_sector,
+		   bioc->bi_size, bio->bi_size);
+	return bioc;
+}
+
+/* BUG: too many parameters... */
+static struct bio *pushchunk(struct cow_c *src, struct cow_c *dst,
+			     struct bio *bio, sector_t st, sector_t begidx,
+			     sector_t chunksz)
+{
+	struct cow_c *dest;
+	dest = NULL;
+
+	if (bio_data_dir(bio) == READ) {
+		if (src == dst)
+			DPRINTK("already copied %lld\n", begidx);
+		DPRINTK("reading\n");
+		dest = src;
+	} else if (bio_data_dir(bio) == WRITE) {
+		DPRINTK("writing\n");
+		dest = dst;
+		if (src == dst) {
+			DPRINTK("already copied %lld\n", begidx);
+		} else {
+			DPRINTK("copying (no need to copy, cache does it)\n");
+			if (dst->bmap_dev)
+				sectbmsetchk(dst->bmap_dev->bdev, st + begidx,
+					     chunksz);
+			/* lock around sect+doop? */
+		}
+	}
+	return do_op(dest, bio, st, begidx, chunksz);
+}
+
+static struct bio *lastbio(struct bio *bio)
+{
+	struct bio *prevbio, *lastbio;
+
+	prevbio = NULL;
+	if (!bio)
+		return bio;
+	for (lastbio = bio; lastbio->bi_next; lastbio = lastbio->bi_next)
+		prevbio = lastbio;
+	if (prevbio)
+		prevbio->bi_next = NULL;
+	return lastbio;
+}
+
+static void insbio(struct bio **reqbio, struct bio *chunkbio)
+{
+	if (chunkbio)
+		chunkbio->bi_next = *reqbio;
+	*reqbio = chunkbio;
+}
+
+static sector_t sendreqs(struct bio *reqbio)
+{
+	struct bio *lreqbio, *chunkbio;
+	sector_t sent;
+
+	lreqbio = reqbio;
+	chunkbio = lastbio(lreqbio);
+	if (lreqbio == chunkbio)
+		lreqbio = NULL;
+	sent = 0;
+	while (chunkbio) {
+		sent += chunkbio->bi_size >> SECT_SHIFT;
+		atomic_inc(&outreqs);
+		generic_make_request(chunkbio);
+		chunkbio = lastbio(lreqbio);
+		if (lreqbio == chunkbio)
+			lreqbio = NULL;
+	}
+	return sent;
+}
+
+/*
+ * BUG: function too big
+ * all is in 512 sectors
+ */
+
+static int
+cow_map(struct dm_target *ti, struct bio *bio, union map_info *map_context)
+{
+	struct cow_c *src, *dst, **cc;
+	sector_t chunksz, count, st, beginst, sent;
+	int i, nmaxdev, lastccidx, bidx, ccidx, res, nchunks;
+	struct bio *reqbio, *chunkbio;
+
+	res = 0;
+	chunkbio = reqbio = NULL;
+
+	if (unlikely(bio_barrier(bio)))
+		return -EOPNOTSUPP;
+	if (unlikely(bio_failfast(bio)))
+		return -EOPNOTSUPP;
+
+	cc = (struct cow_c **)ti->private;
+	if (!atomic_inc_not_zero(&cc[0]->nclients)) {
+		printk(KERN_INFO "Entered after cleanup\n");
+		bio->bi_size = 0;
+		return -1;
+	}
+	atomic_inc(&nmaps);
+	atomic_inc(&nclients_preparing);
+	bio_get(bio);
+
+	st = (bio->bi_sector - ti->begin);
+	count = bio->bi_size >> SECT_SHIFT;
+
+	src = dst = NULL;
+	atomic_add(bio->bi_size, &outbytes);
+	chunksz = count;
+	lastccidx = -1;
+	for (i = 0; cc[i]; i++) {
+		if (st + count > ti->begin + ti->len) {
+			/* BAD BAD BAD ERROR */
+			printk(KERN_ALERT
+			       "request over the edge for sector: %lld end: %lld\n",
+			       st + count, ti->begin + ti->len);
+			res = -1;
+			goto exit;
+		}
+	}
+	nmaxdev = i;
+	DPRINTK("New map %d devices- st:%lld-cnt:%lld-blen[0]:%lld\n",
+		nmaxdev, st, count, cc[0]->bmap_len);
+
+	dst = cc[nmaxdev - 1];
+	chunksz = 0;
+	bidx = 0;
+	ccidx = ccispresent(cc, st, nmaxdev);
+	if (ccidx < 0) {
+		res = -1;
+		goto exit;	/* BAD ERROR */
+	}
+	nchunks = 0;
+
+	if (bio_data_dir(bio) == WRITE) {	//if it is a write, just write.
+		beginst = 0;
+		chunksz = count;
+		nchunks++;
+		src = cc[ccidx];
+		DPRINTBL("WRITE chunk, %p->%p st %lld beg %lld csz %lld\n",
+			 src, dst, st, beginst, chunksz);
+		chunkbio = pushchunk(src, dst, bio, st, beginst, chunksz);
+		insbio(&reqbio, chunkbio);
+		goto exit;
+	}
+
+	while (bidx < count) {	//if it is a read, try to group chunks.
+		beginst = bidx;	//next chunk
+		lastccidx = ccidx;
+		chunksz = 1;	//eat one, the start of the chunk.
+		bidx++;
+		nchunks++;
+		for (; bidx < count; bidx++) {
+			ccidx = ccispresent(cc, st + bidx, nmaxdev);
+			if (ccidx < 0) {
+				res = -1;
+				goto exit;	//BAD ERROR
+			}
+			if (ccidx != lastccidx)	//finish chunk
+				break;
+			chunksz++;	//if the same continue the chunk
+			DPRINTK("increment of bidx\n");
+		}
+
+		src = cc[lastccidx];
+		DPRINTBL("READ chunk, %p->%p st %lld beg %lld csz %lld\n",
+			 src, dst, st, beginst, chunksz);
+		chunkbio = pushchunk(src, dst, bio, st, beginst, chunksz);
+		insbio(&reqbio, chunkbio);
+	}
+
+      exit:
+	atomic_dec(&nclients_preparing);
+	atomic_inc(&nclients_sending);
+	bio_put(bio);
+	sent = sendreqs(reqbio);
+	BUG_ON(sent != count);
+	atomic_dec(&nclients_sending);
+	atomic_dec(&nmaps);
+	if (atomic_dec_and_test(&cc[0]->nclients)) {	//disable on error by setting 0 on cnt can also be good.
+		printk(KERN_ALERT "cow: error on map\n");
+		cleanup(ti);
+	}
+	return res;
+}
+
+static int
+cow_status(struct dm_target *ti, status_type_t type,
+	   char *result, unsigned int maxlen)
+{
+	struct cow_c **cc = (struct cow_c **)ti->private;
+	int off, i;
+
+	off = 0;
+	switch (type) {
+	case STATUSTYPE_INFO:
+		result[0] = '\0';
+		break;
+
+	case STATUSTYPE_TABLE:
+		for (i = 0; i < MAXDEV; i++) {
+			if (cc[i])
+				off +=
+				    snprintf(result + off, maxlen - off,
+					     "%s " "%s " "%lld",
+					     cc[i]->dev->name,
+					     cc[i]->bmap_dev->name,
+					     cc[i]->start);
+		}
+		break;
+	}
+	return 0;
+}
+
+static struct target_type cow_target = {
+	.name = "cow",
+	.version = {1, 0, 1},
+	.module = THIS_MODULE,
+	.ctr = cow_ctr,
+	.dtr = cow_dtr,
+	.map = cow_map,
+	.status = cow_status,
+};
+
+int
+cow_proc_read(char *buf, char **start, off_t offset, int count, int *eof,
+	      void *data)
+{
+	int len;
+	len = 0;
+	len += sprintf(buf + len, "nstacks: %d, ", atomic_read(&nstacks));
+	len += sprintf(buf + len, "nmaps: %d, ", atomic_read(&nmaps));
+	len +=
+	    sprintf(buf + len, "clients_preparing: %d, ",
+		    atomic_read(&nclients_preparing));
+	len +=
+	    sprintf(buf + len, "clients_sending: %d, ",
+		    atomic_read(&nclients_sending));
+	len += sprintf(buf + len, "noutreqs: %d, ", atomic_read(&outreqs));
+	len += sprintf(buf + len, "noutbytes: %d\n", atomic_read(&outbytes));
+	*eof = 1;
+	return len;
+}
+
+int __init dm_cow_init(void)
+{
+	int r = dm_register_target(&cow_target);
+
+	if (r < 0)
+		DMERR("register failed %d", r);
+
+	/* 
+	 * dont worry about errors, if it doesnt work, 
+	 * you cant see debug info, not critical
+	 */
+
+	create_proc_read_entry("driver/dm-cow", 0, NULL, cow_proc_read, NULL);
+	return r;
+}
+
+void dm_cow_exit(void)
+{
+	int r = dm_unregister_target(&cow_target);
+	remove_proc_entry("driver/dm-cow", NULL);
+	if (r < 0)
+		DMERR("unregister failed %d", r);
+}
+
+module_init(dm_cow_init);
+module_exit(dm_cow_exit);
+
+MODULE_DESCRIPTION(DM_NAME " cow target");
+MODULE_AUTHOR("Gorka Guardiola");
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("dm-cow");
-- 
1.4.1

