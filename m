Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422808AbWJRUKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWJRUKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422824AbWJRUKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:10:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:20658 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422842AbWJRUJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:41 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/15] aoe: use bio->bi_idx
Date: Wed, 18 Oct 2006 13:09:02 -0700
Message-Id: <11612021821994-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161202179462-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com> <11612021641240-git-send-email-greg@kroah.com> <11612021682148-git-send-email-greg@kroah.com> <1161202171977-git-send-email-greg@kroah.com> <11612021753859-git-send-email-greg@kroah.com> <1161202179462-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Instead of starting with bio->bi_io_vec, use the offset in bio->bi_idx.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoeblk.c |    3 ++-
 drivers/block/aoe/aoecmd.c |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index a7dbe6f..196ae7a 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -142,7 +142,8 @@ aoeblk_make_request(request_queue_t *q, 
 	buf->bio = bio;
 	buf->resid = bio->bi_size;
 	buf->sector = bio->bi_sector;
-	buf->bv = buf->bio->bi_io_vec;
+	buf->bv = &bio->bi_io_vec[bio->bi_idx];
+	WARN_ON(buf->bv->bv_len == 0);
 	buf->bv_resid = buf->bv->bv_len;
 	buf->bufaddr = page_address(buf->bv->bv_page) + buf->bv->bv_offset;
 
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index f2b8f55..2d0bcdd 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -166,6 +166,7 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 		d->inprocess = NULL;
 	} else if (buf->bv_resid == 0) {
 		buf->bv++;
+		WARN_ON(buf->bv->bv_len == 0);
 		buf->bv_resid = buf->bv->bv_len;
 		buf->bufaddr = page_address(buf->bv->bv_page) + buf->bv->bv_offset;
 	}
-- 
1.4.2.4

