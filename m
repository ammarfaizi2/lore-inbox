Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263098AbVCXPqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbVCXPqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVCXPny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:43:54 -0500
Received: from geode.he.net ([216.218.230.98]:51728 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262798AbVCXPaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:30:10 -0500
From: ecashin@noserose.net
Message-Id: <1111678202.356@geode.he.net>
Date: Thu, 24 Mar 2005 07:30:02 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [11/12]: add support for disk statistics
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add support for disk statistics

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-03-10 12:19:54.000000000 -0500
+++ b/drivers/block/aoe/aoe.h	2005-03-10 12:20:02.000000000 -0500
@@ -91,6 +91,7 @@ enum {
 
 struct buf {
 	struct list_head bufs;
+	ulong start_time;	/* for disk stats */
 	ulong flags;
 	ulong nframesout;
 	char *bufaddr;
diff -uprN a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- a/drivers/block/aoe/aoeblk.c	2005-03-10 12:20:00.000000000 -0500
+++ b/drivers/block/aoe/aoeblk.c	2005-03-10 12:20:02.000000000 -0500
@@ -125,6 +125,7 @@ aoeblk_make_request(request_queue_t *q, 
 	}
 	memset(buf, 0, sizeof(*buf));
 	INIT_LIST_HEAD(&buf->bufs);
+	buf->start_time = jiffies;
 	buf->bio = bio;
 	buf->resid = bio->bi_size;
 	buf->sector = bio->bi_sector;
diff -uprN a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
--- a/drivers/block/aoe/aoecmd.c	2005-03-10 12:19:27.000000000 -0500
+++ b/drivers/block/aoe/aoecmd.c	2005-03-10 12:20:02.000000000 -0500
@@ -456,6 +456,20 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	if (buf) {
 		buf->nframesout -= 1;
 		if (buf->nframesout == 0 && buf->resid == 0) {
+			unsigned long duration = jiffies - buf->start_time;
+			unsigned long n_sect = buf->bio->bi_size >> 9;
+			struct gendisk *disk = d->gd;
+
+			if (bio_data_dir(buf->bio) == WRITE) {
+				disk_stat_inc(disk, writes);
+				disk_stat_add(disk, write_ticks, duration);
+				disk_stat_add(disk, write_sectors, n_sect);
+			} else {
+				disk_stat_inc(disk, reads);
+				disk_stat_add(disk, read_ticks, duration);
+				disk_stat_add(disk, read_sectors, n_sect);
+			}
+			disk_stat_add(disk, io_ticks, duration);
 			n = (buf->flags & BUFFL_FAIL) ? -EIO : 0;
 			bio_endio(buf->bio, buf->bio->bi_size, n);
 			mempool_free(buf, d->bufpool);


-- 
  Ed L. Cashin <ecashin@coraid.com>
