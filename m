Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWJTD0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWJTD0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWJTD0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:26:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:19862 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946135AbWJTDZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:25:57 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 20 Oct 2006 13:25:47 +1000
Message-Id: <1061020032547.1716@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 4] md: Endian annotations for the bitmap superblock
References: <20061020120612.29297.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And a couple of bug fixes found by sparse.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c         |   10 +++++-----
 ./include/linux/raid/bitmap.h |   20 ++++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff .prev/drivers/md/bitmap.c ./drivers/md/bitmap.c
--- .prev/drivers/md/bitmap.c	2006-10-20 11:49:19.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-10-20 12:00:58.000000000 +1000
@@ -536,7 +536,7 @@ static int bitmap_read_sb(struct bitmap 
 		printk(KERN_INFO "%s: bitmap file is out of date (%llu < %llu) "
 			"-- forcing full recovery\n", bmname(bitmap), events,
 			(unsigned long long) bitmap->mddev->events);
-		sb->state |= BITMAP_STALE;
+		sb->state |= cpu_to_le32(BITMAP_STALE);
 	}
 success:
 	/* assign fields using values from superblock */
@@ -544,11 +544,11 @@ success:
 	bitmap->daemon_sleep = daemon_sleep;
 	bitmap->daemon_lastrun = jiffies;
 	bitmap->max_write_behind = write_behind;
-	bitmap->flags |= sb->state;
+	bitmap->flags |= le32_to_cpu(sb->state);
 	if (le32_to_cpu(sb->version) == BITMAP_MAJOR_HOSTENDIAN)
 		bitmap->flags |= BITMAP_HOSTENDIAN;
 	bitmap->events_cleared = le64_to_cpu(sb->events_cleared);
-	if (sb->state & BITMAP_STALE)
+	if (sb->state & cpu_to_le32(BITMAP_STALE))
 		bitmap->events_cleared = bitmap->mddev->events;
 	err = 0;
 out:
@@ -578,9 +578,9 @@ static void bitmap_mask_state(struct bit
 	spin_unlock_irqrestore(&bitmap->lock, flags);
 	sb = (bitmap_super_t *)kmap_atomic(bitmap->sb_page, KM_USER0);
 	switch (op) {
-		case MASK_SET: sb->state |= bits;
+		case MASK_SET: sb->state |= cpu_to_le32(bits);
 				break;
-		case MASK_UNSET: sb->state &= ~bits;
+		case MASK_UNSET: sb->state &= cpu_to_le32(~bits);
 				break;
 		default: BUG();
 	}

diff .prev/include/linux/raid/bitmap.h ./include/linux/raid/bitmap.h
--- .prev/include/linux/raid/bitmap.h	2006-10-20 11:41:01.000000000 +1000
+++ ./include/linux/raid/bitmap.h	2006-10-20 12:00:58.000000000 +1000
@@ -146,16 +146,16 @@ enum bitmap_state {
 
 /* the superblock at the front of the bitmap file -- little endian */
 typedef struct bitmap_super_s {
-	__u32 magic;        /*  0  BITMAP_MAGIC */
-	__u32 version;      /*  4  the bitmap major for now, could change... */
-	__u8  uuid[16];     /*  8  128 bit uuid - must match md device uuid */
-	__u64 events;       /* 24  event counter for the bitmap (1)*/
-	__u64 events_cleared;/*32  event counter when last bit cleared (2) */
-	__u64 sync_size;    /* 40  the size of the md device's sync range(3) */
-	__u32 state;        /* 48  bitmap state information */
-	__u32 chunksize;    /* 52  the bitmap chunk size in bytes */
-	__u32 daemon_sleep; /* 56  seconds between disk flushes */
-	__u32 write_behind; /* 60  number of outstanding write-behind writes */
+	__le32 magic;        /*  0  BITMAP_MAGIC */
+	__le32 version;      /*  4  the bitmap major for now, could change... */
+	__u8  uuid[16];      /*  8  128 bit uuid - must match md device uuid */
+	__le64 events;       /* 24  event counter for the bitmap (1)*/
+	__le64 events_cleared;/*32  event counter when last bit cleared (2) */
+	__le64 sync_size;    /* 40  the size of the md device's sync range(3) */
+	__le32 state;        /* 48  bitmap state information */
+	__le32 chunksize;    /* 52  the bitmap chunk size in bytes */
+	__le32 daemon_sleep; /* 56  seconds between disk flushes */
+	__le32 write_behind; /* 60  number of outstanding write-behind writes */
 
 	__u8  pad[256 - 64]; /* set to zero */
 } bitmap_super_t;
