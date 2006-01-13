Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161483AbWAMP0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbWAMP0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161552AbWAMPYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:49 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:52135 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161373AbWAMPY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=LyrIjc+1CWPUN6RjfDIScmbOE0JrtmwzA6OHwYSK4vMUj1/Dlb/eo7sbS/KbSiHFz8k+BO/ArgVhWtWJenRG/NQkhldJ0E3X8+QLXLHM2clz12SMIlQEFlp8PCfbdOwmp28KqXMk/nr5NQYmhfEyfYrDCqXEcw9LzlgUJjS+Lgg=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/8] block: convert md to use blk_kmap helpers
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 14 Jan 2006 00:24:17 +0900
Message-Id: <11371658572750-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert direct uses of kmap/unmap to blk_kmap/unmap in md.  This
combined with the previous bio helper change fixes PIO cache coherency
bugs on architectures with aliased caches.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/md/raid1.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

c781a8f9320246a13cdc62610b314dcd3678266d
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a06ff91..6a940a1 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -714,13 +714,19 @@ static struct page **alloc_behind_pages(
 		goto do_sync_io;
 
 	bio_for_each_segment(bvec, bio, i) {
+		void *src, *dst;
+
 		pages[i] = alloc_page(GFP_NOIO);
 		if (unlikely(!pages[i]))
 			goto do_sync_io;
-		memcpy(kmap(pages[i]) + bvec->bv_offset,
-			kmap(bvec->bv_page) + bvec->bv_offset, bvec->bv_len);
+
+		src = blk_kmap(bvec->bv_page, DMA_TO_DEVICE) + bvec->bv_offset;
+		dst = kmap(pages[i]) + bvec->bv_offset;
+
+		memcpy(dst, src, bvec->bv_len);
+
+		blk_kunmap(bvec->bv_page, DMA_TO_DEVICE);
 		kunmap(pages[i]);
-		kunmap(bvec->bv_page);
 	}
 
 	return pages;
-- 
1.0.6


