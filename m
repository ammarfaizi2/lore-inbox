Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317323AbSFLDJC>; Tue, 11 Jun 2002 23:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317324AbSFLDJB>; Tue, 11 Jun 2002 23:09:01 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29604 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317323AbSFLDJB>; Tue, 11 Jun 2002 23:09:01 -0400
Date: Wed, 12 Jun 2002 04:08:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Todd R. Eigenshink" <todd@tekinteractive.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] swap 3/4 unsafe Dirty check
In-Reply-To: <Pine.LNX.4.21.0206120359270.1036-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0206120405480.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd reported swapoff kernel BUG at filemap.c:122 to LKML 24 May.
Other problems on that system may have contributed, but yes, despite
__delete_from_swap_cache doing ClearPageDirty before __remove_inode_page
to avoid the BUG(), a concurrent __free_pte might race to SetPageDirty.
So skip that oops in PageSwapCache case (please, if someone wants to use
unlikely or BUG_ON there, do so in your later patch).  Remove the prior
ClearPageDirty? maybe but not without deeper thought: let stay for now.

--- 2.4.19-pre10/mm/filemap.c	Tue Jun  4 13:54:19 2002
+++ linux/mm/filemap.c	Tue Jun 11 19:02:30 2002
@@ -119,7 +119,8 @@
  */
 void __remove_inode_page(struct page *page)
 {
-	if (PageDirty(page)) BUG();
+	if (PageDirty(page) && !PageSwapCache(page))
+		BUG();
 	remove_page_from_inode_queue(page);
 	remove_page_from_hash_queue(page);
 }

