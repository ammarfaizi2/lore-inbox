Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWA2Psx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWA2Psx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 10:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWA2Psx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 10:48:53 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:53519 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1751035AbWA2Psx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 10:48:53 -0500
Message-Id: <200601291548.k0TFmlIc016808@devron.myhome.or.jp>
Subject: [PATCH 2/3] Trivial optimization of ll_rw_block()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
From: hirofumi@mail.parknet.co.jp
Date: Mon, 30 Jan 2006 00:48:46 +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The ll_rw_block() needs to get ref-count only if it submits a buffer().
This patch avoids the needless get/put of ref-count.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/buffer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/buffer.c~ll_rw_block-optimize fs/buffer.c
--- linux-2.6/fs/buffer.c~ll_rw_block-optimize	2006-01-12 21:53:00.000000000 +0900
+++ linux-2.6-hirofumi/fs/buffer.c	2006-01-12 21:53:00.000000000 +0900
@@ -2866,22 +2866,22 @@ void ll_rw_block(int rw, int nr, struct 
 		else if (test_set_buffer_locked(bh))
 			continue;
 
-		get_bh(bh);
 		if (rw == WRITE || rw == SWRITE) {
 			if (test_clear_buffer_dirty(bh)) {
 				bh->b_end_io = end_buffer_write_sync;
+				get_bh(bh);
 				submit_bh(WRITE, bh);
 				continue;
 			}
 		} else {
 			if (!buffer_uptodate(bh)) {
 				bh->b_end_io = end_buffer_read_sync;
+				get_bh(bh);
 				submit_bh(rw, bh);
 				continue;
 			}
 		}
 		unlock_buffer(bh);
-		put_bh(bh);
 	}
 }
 
_
