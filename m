Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317313AbSFLDDT>; Tue, 11 Jun 2002 23:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317317AbSFLDDS>; Tue, 11 Jun 2002 23:03:18 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27791 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317313AbSFLDDS>; Tue, 11 Jun 2002 23:03:18 -0400
Date: Wed, 12 Jun 2002 04:03:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Burton Windle <bwindle@fint.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] swap 1/4 swapon memleak
In-Reply-To: <Pine.LNX.4.21.0206120343290.1036-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0206120359270.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton reported Kernel memory leak with swapon/swapoff? LKML 31 May.
swapon uses rw_swap_page_nolock to read swap_header page (peculiar!
should probably rework that sometime), nothing freed the buffers
from the page, and thus the page was also never freed.

--- 2.4.19-pre10/mm/page_io.c	Mon Nov 19 23:19:42 2001
+++ linux/mm/page_io.c	Tue Jun 11 19:02:30 2002
@@ -120,8 +120,10 @@
 		PAGE_BUG(page);
 	/* needs sync_page to wait I/O completation */
 	page->mapping = &swapper_space;
-	if (!rw_swap_page_base(rw, entry, page))
-		UnlockPage(page);
-	wait_on_page(page);
+	if (rw_swap_page_base(rw, entry, page))
+		lock_page(page);
+	if (!block_flushpage(page, 0))
+		PAGE_BUG(page);
 	page->mapping = NULL;
+	UnlockPage(page);
 }

