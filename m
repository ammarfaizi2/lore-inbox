Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422867AbWJRUMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422867AbWJRUMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422835AbWJRUJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:54 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30442 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422832AbWJRUJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:27 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 7/15] aoe: jumbo frame support 2 of 2
Date: Wed, 18 Oct 2006 13:08:58 -0700
Message-Id: <11612021682148-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021641240-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com> <11612021641240-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Add support for jumbo ethernet frames.
(This patch follows patch 5.)

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoecmd.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 63c4560..621fdbb 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -475,7 +475,7 @@ void
 aoecmd_ata_rsp(struct sk_buff *skb)
 {
 	struct aoedev *d;
-	struct aoe_hdr *hin;
+	struct aoe_hdr *hin, *hout;
 	struct aoe_atahdr *ahin, *ahout;
 	struct frame *f;
 	struct buf *buf;
@@ -515,7 +515,8 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	calc_rttavg(d, tsince(f->tag));
 
 	ahin = (struct aoe_atahdr *) (hin+1);
-	ahout = (struct aoe_atahdr *) (f->skb->mac.raw + sizeof(struct aoe_hdr));
+	hout = (struct aoe_hdr *) f->skb->mac.raw;
+	ahout = (struct aoe_atahdr *) (hout+1);
 	buf = f->buf;
 
 	if (ahout->cmdstat == WIN_IDENTIFY)
@@ -552,6 +553,9 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 					skb_fill_page_desc(f->skb, 0,
 						virt_to_page(f->bufaddr),
 						offset_in_page(f->bufaddr), n);
+				f->tag = newtag(d);
+				hout->tag = cpu_to_be32(f->tag);
+				skb->dev = d->ifp;
 				skb_get(f->skb);
 				f->skb->next = NULL;
 				spin_unlock_irqrestore(&d->lock, flags);
-- 
1.4.2.4

