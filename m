Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVAUQXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVAUQXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVAUQXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:23:34 -0500
Received: from gate.in-addr.de ([212.8.193.158]:52916 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262410AbVAUQXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:23:18 -0500
Date: Fri, 21 Jan 2005 17:22:50 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-bk9 crash in mdadm
Message-ID: <20050121162250.GQ25714@marowsky-bree.de>
References: <20050121161230.GN3922@fi.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050121161230.GN3922@fi.muni.cz>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2005-01-21T17:12:30, Jan Kasprzak <kas@fi.muni.cz> wrote:

> Just FWIW, I've got the following crash when trying to boot a 2.6.11-rc1-bk9
> kernel on my dual opteron Fedora Core 3 box. I will try -bk8 now.

Attached is a likely candidate for a fix.

(It's been discussed on linux-raid already.)

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=md-bio-on-stack

From: Jens Axboe <axboe@suse.de>
Subject: Fix md using bio on stack with bio clones
Patch-mainline: 
References: 49931

If md resides on top of a driver using bio_clone() (such as dm), it will
oops the kernel due to md submitting a botched bio that has a veclist but
doesn't have bio->bi_max_vecs set.

Signed-off-by: Jens Axboe <axboe@suse.de>

===== drivers/md/md.c 1.231 vs edited =====
--- 1.231/drivers/md/md.c	2004-12-01 09:13:51 +01:00
+++ edited/drivers/md/md.c	2005-01-19 13:23:30 +01:00
@@ -332,29 +332,26 @@
 static int sync_page_io(struct block_device *bdev, sector_t sector, int size,
 		   struct page *page, int rw)
 {
-	struct bio bio;
-	struct bio_vec vec;
+	struct bio *bio = bio_alloc(GFP_KERNEL, 1);
 	struct completion event;
+	int ret;
+
+	bio_get(bio);
 
 	rw |= (1 << BIO_RW_SYNC);
 
-	bio_init(&bio);
-	bio.bi_io_vec = &vec;
-	vec.bv_page = page;
-	vec.bv_len = size;
-	vec.bv_offset = 0;
-	bio.bi_vcnt = 1;
-	bio.bi_idx = 0;
-	bio.bi_size = size;
-	bio.bi_bdev = bdev;
-	bio.bi_sector = sector;
+	bio->bi_bdev = bdev;
+	bio->bi_sector = sector;
+	bio_add_page(bio, page, size, 0);
 	init_completion(&event);
-	bio.bi_private = &event;
-	bio.bi_end_io = bi_complete;
-	submit_bio(rw, &bio);
+	bio->bi_private = &event;
+	bio->bi_end_io = bi_complete;
+	submit_bio(rw, bio);
 	wait_for_completion(&event);
 
-	return test_bit(BIO_UPTODATE, &bio.bi_flags);
+	ret = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	bio_put(bio);
+	return ret;
 }
 
 static int read_disk_sb(mdk_rdev_t * rdev)

--R3G7APHDIzY6R/pk--
