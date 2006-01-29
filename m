Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWA2Psv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWA2Psv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWA2Psv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 10:48:51 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:53007 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1751033AbWA2Psv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 10:48:51 -0500
Message-Id: <200601291548.k0TFmf04016672@devron.myhome.or.jp>
Subject: [PATCH 1/3] fat: Replace an own implementation with ll_rw_block(SWRITE,)
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
From: hirofumi@mail.parknet.co.jp
Date: Mon, 30 Jan 2006 00:48:39 +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch replaces an own implementation with LL_RW_BLOCK(SWRITE,)
which was newly added.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/misc.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff -puN fs/fat/misc.c~fat_use-ll_rw_block-SWRITE fs/fat/misc.c
--- linux-2.6/fs/fat/misc.c~fat_use-ll_rw_block-SWRITE	2006-01-11 06:19:14.000000000 +0900
+++ linux-2.6-hirofumi/fs/fat/misc.c	2006-01-11 06:19:14.000000000 +0900
@@ -197,19 +197,9 @@ EXPORT_SYMBOL_GPL(fat_date_unix2dos);
 
 int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
 {
-	int i, e, err = 0;
+	int i, err = 0;
 
-	for (i = 0; i < nr_bhs; i++) {
-		lock_buffer(bhs[i]);
-		if (test_clear_buffer_dirty(bhs[i])) {
-			get_bh(bhs[i]);
-			bhs[i]->b_end_io = end_buffer_write_sync;
-			e = submit_bh(WRITE, bhs[i]);
-			if (!err && e)
-				err = e;
-		} else
-			unlock_buffer(bhs[i]);
-	}
+	ll_rw_block(SWRITE, nr_bhs, bhs);
 	for (i = 0; i < nr_bhs; i++) {
 		wait_on_buffer(bhs[i]);
 		if (buffer_eopnotsupp(bhs[i])) {
_
