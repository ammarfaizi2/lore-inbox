Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266804AbSKKSAa>; Mon, 11 Nov 2002 13:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266880AbSKKSAa>; Mon, 11 Nov 2002 13:00:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:56881 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S266804AbSKKSA1>; Mon, 11 Nov 2002 13:00:27 -0500
Date: Mon, 11 Nov 2002 18:08:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unlock_page when get_swap_bio fails
Message-ID: <Pine.LNX.4.44.0211111802360.1236-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swap_readpage and swap_writepage forgot
to unlock_page if get_swap_bio failed.

Patch applies to 2.5.47 or 2.5.47-mm1.

--- 2.5.47/mm/page_io.c	Mon Oct  7 20:37:50 2002
+++ linux/mm/page_io.c	Mon Nov 11 17:01:27 2002
@@ -97,6 +97,7 @@
 	bio = get_swap_bio(GFP_NOIO, page, end_swap_bio_write);
 	if (bio == NULL) {
 		set_page_dirty(page);
+		unlock_page(page);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -116,6 +117,7 @@
 	ClearPageUptodate(page);
 	bio = get_swap_bio(GFP_KERNEL, page, end_swap_bio_read);
 	if (bio == NULL) {
+		unlock_page(page);
 		ret = -ENOMEM;
 		goto out;
 	}

