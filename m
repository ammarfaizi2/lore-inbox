Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270426AbTHQQj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270430AbTHQQj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:39:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38548 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S270426AbTHQQj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:39:57 -0400
Date: Sun, 17 Aug 2003 17:40:54 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@localhost.localdomain>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Wrong assumption in set_bh_page()
Message-ID: <Pine.LNX.4.33.0308171729130.1203-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  set_bh_page() assumes page_address() will always return NULL for a
highmem page.  This assumption is wrong - the highmem page could be
kmap()ped.

  Luckily, no code I've looked at assumes that b_data contains a _pure_
offset for a highmem page, but this is a bug waiting to happen.

  Patch is against 2.4.21-rc1.

Mark


diff -urN linux-2.4.21-rc1/fs/buffer.c linux-2.4.21-rc1-bh/fs/buffer.c
--- linux-2.4.21-rc1/fs/buffer.c	2003-08-17 15:55:40.000000000 +0100
+++ linux-2.4.21-rc1-bh/fs/buffer.c	2003-08-17 18:15:13.000000000 +0100
@@ -1231,10 +1231,11 @@
 	if (offset >= PAGE_SIZE)
 		BUG();

-	/*
-	 * page_address will return NULL anyways for highmem pages
-	 */
-	bh->b_data = page_address(page) + offset;
+	if (PageHighMem(page)) {
+		bh->b_data = (char *)offset;
+	} else {
+		bh->b_data = page_address(page) + offset;
+	}
 	bh->b_page = page;
 }
 EXPORT_SYMBOL(set_bh_page);



