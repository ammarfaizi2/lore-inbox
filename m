Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUJWRbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUJWRbY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 13:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbUJWRbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 13:31:24 -0400
Received: from av3-2-sn1.fre.skanova.net ([81.228.11.110]:25027 "EHLO
	av3-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261253AbUJWRbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:31:21 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: [PATCH] Fix incorrect kunmap_atomic in pktcdvd
From: Peter Osterlund <petero2@telia.com>
Date: 23 Oct 2004 19:31:18 +0200
Message-ID: <m3wtxhibo9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pktcdvd driver uses kunmap_atomic() incorrectly. The function is
supposed to take an address as the first parameter, but the pktcdvd
driver passed a page pointer. Thanks to Douglas Gilbert and Jens Axboe
for discovering this.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-kmap-fix drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-kmap-fix	2004-10-23 12:04:01.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-10-23 12:07:11.000000000 +0200
@@ -621,7 +621,7 @@ static void pkt_copy_bio_data(struct bio
 
 		BUG_ON(len < 0);
 		memcpy(vto, vfrom, len);
-		kunmap_atomic(src_bvl->bv_page, KM_USER0);
+		kunmap_atomic(vfrom, KM_USER0);
 
 		seg++;
 		offs = 0;
@@ -649,7 +649,7 @@ static void pkt_make_local_copy(struct p
 			void *vfrom = kmap_atomic(pages[f], KM_USER0) + offsets[f];
 			void *vto = page_address(pkt->pages[p]) + offs;
 			memcpy(vto, vfrom, CD_FRAMESIZE);
-			kunmap_atomic(pages[f], KM_USER0);
+			kunmap_atomic(vfrom, KM_USER0);
 			pages[f] = pkt->pages[p];
 			offsets[f] = offs;
 		} else {
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
