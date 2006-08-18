Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWHRS4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWHRS4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWHRSzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:55:19 -0400
Received: from ns1.coraid.com ([65.14.39.133]:60005 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161078AbWHRSzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:55:05 -0400
Message-ID: <a6963b591178293af24ac01fca759209@coraid.com>
Date: Fri, 18 Aug 2006 13:40:04 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [11/13]: use bio->bi_idx
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Instead of starting with bio->bi_io_vec, use the offset in bio->bi_idx.

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c	2006-08-17 16:45:34.000000000 -0400
@@ -142,7 +142,8 @@ aoeblk_make_request(request_queue_t *q, 
 	buf->bio = bio;
 	buf->resid = bio->bi_size;
 	buf->sector = bio->bi_sector;
-	buf->bv = buf->bio->bi_io_vec;
+	buf->bv = &bio->bi_io_vec[bio->bi_idx];
+	WARN_ON(buf->bv->bv_len == 0);
 	buf->bv_resid = buf->bv->bv_len;
 	buf->bufaddr = page_address(buf->bv->bv_page) + buf->bv->bv_offset;
 
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
@@ -166,6 +166,7 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 		d->inprocess = NULL;
 	} else if (buf->bv_resid == 0) {
 		buf->bv++;
+		WARN_ON(buf->bv->bv_len == 0);
 		buf->bv_resid = buf->bv->bv_len;
 		buf->bufaddr = page_address(buf->bv->bv_page) + buf->bv->bv_offset;
 	}


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
