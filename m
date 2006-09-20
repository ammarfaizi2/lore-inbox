Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWITS7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWITS7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWITS5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:57:22 -0400
Received: from ns1.coraid.com ([65.14.39.133]:46968 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932263AbWITS5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:57:08 -0400
Message-ID: <c350eda74ba5de1243f5719b1d3daca8@coraid.com>
Date: Wed, 20 Sep 2006 14:36:50 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [11/14]: use bio->bi_idx
References: <E1GQ6uv-0001qi-00@kokone>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of starting with bio->bi_io_vec, use the offset in bio->bi_idx.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
---

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c	2006-09-20 14:29:35.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c	2006-09-20 14:29:36.000000000 -0400
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
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-09-20 14:29:36.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-09-20 14:29:36.000000000 -0400
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
