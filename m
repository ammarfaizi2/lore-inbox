Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317318AbSFLDFq>; Tue, 11 Jun 2002 23:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317323AbSFLDFp>; Tue, 11 Jun 2002 23:05:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55704 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317318AbSFLDFp>; Tue, 11 Jun 2002 23:05:45 -0400
Date: Wed, 12 Jun 2002 04:05:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] swap 2/4 unsafe SwapCache check
In-Reply-To: <Pine.LNX.4.21.0206120359270.1036-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0206120403280.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent testing has shown that the BUG() check in try_to_unuse is unsafe.
delete_from_swap_cache does final swap_free just after removing page
from swap cache, and add_to_swap_cache does swap_duplicate just before
putting page into swap cache, therefore swapin_readahead may resurrect
a dying swap entry and assign a new page to it.  That's fine, there's
no need to change this ordering; but it does mean that try_to_unuse's
page may have left the swap cache yet its swap_map count still be set.
That BUG() has done good service for swapoff sanity, but now abandon it.

--- 2.4.19-pre10/mm/swapfile.c	Tue Jun  4 13:54:20 2002
+++ linux/mm/swapfile.c	Tue Jun 11 19:02:30 2002
@@ -671,10 +671,7 @@
 		 * private" pages, but they are handled by tmpfs files.
 		 * Note shmem_unuse already deleted its from swap cache.
 		 */
-		swcount = *swap_map;
-		if ((swcount > 0) != PageSwapCache(page))
-			BUG();
-		if ((swcount > 1) && PageDirty(page)) {
+		if ((*swap_map > 1) && PageDirty(page) && PageSwapCache(page)) {
 			rw_swap_page(WRITE, page);
 			lock_page(page);
 		}

