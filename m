Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132957AbRAKWq1>; Thu, 11 Jan 2001 17:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135322AbRAKWqR>; Thu, 11 Jan 2001 17:46:17 -0500
Received: from [62.172.234.2] ([62.172.234.2]:50270 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132957AbRAKWqH>; Thu, 11 Jan 2001 17:46:07 -0500
Date: Thu, 11 Jan 2001 22:45:30 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] free_page(0) freed pagenr 0x40000
Message-ID: <Pine.LNX.4.21.0101112240280.1033-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_mount(), and probably others, calls free_page(0) when
no page was got.  free_pages() allows for this explicitly if
CONFIG_DISCONTIGMEM, and _appears_ to allow for it generally
by testing VALID_PAGE() - but that test is inadequate, if
over 1GB of memory then pagenr 0x40000 can be wrongly freed
(in i386 case).  Complicate the test, for what? or simply...

--- linux-2.4.1-pre2/mm/page_alloc.c	Thu Jan 11 13:44:43 2001
+++ linux/mm/page_alloc.c	Thu Jan 11 21:41:39 2001
@@ -542,14 +542,8 @@
 
 void free_pages(unsigned long addr, unsigned long order)
 {
-	struct page *fpage;
-
-#ifdef CONFIG_DISCONTIGMEM
-	if (addr == 0) return;
-#endif
-	fpage = virt_to_page(addr);
-	if (VALID_PAGE(fpage))
-		__free_pages(fpage, order);
+	if (addr != 0)
+		__free_pages(virt_to_page(addr), order);
 }
 
 /*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
