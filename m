Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317202AbSFBWor>; Sun, 2 Jun 2002 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317221AbSFBWoq>; Sun, 2 Jun 2002 18:44:46 -0400
Received: from holomorphy.com ([66.224.33.161]:39586 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317202AbSFBWoq>;
	Sun, 2 Jun 2002 18:44:46 -0400
Date: Sun, 2 Jun 2002 15:44:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: remove mixture of non-atomic operations with page->flags which requires atomic operations to access
Message-ID: <20020602224422.GP14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

page->flags is effectively a lock word as its various bits are updatable
and accessible only by atomic operations. This patch removes the update
of page->flags in __free_pages_ok() with non-atomic operations in favor
of using atomic bit operations to update the bits to be cleared.


Against 2.5.19.


Cheers,
Bill


diff -Nru a/include/linux/page-flags.h b/include/linux/page-flags.h
--- a/include/linux/page-flags.h	Sun Jun  2 15:42:49 2002
+++ b/include/linux/page-flags.h	Sun Jun  2 15:42:49 2002
@@ -169,6 +169,7 @@
 
 #define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
+#define ClearPageChecked(page)	clear_bit(PG_checked, &(page)->flags)
 
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 #define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Sun Jun  2 15:42:49 2002
+++ b/mm/page_alloc.c	Sun Jun  2 15:42:49 2002
@@ -91,8 +91,12 @@
 	BUG_ON(PageLRU(page));
 	BUG_ON(PageActive(page));
 	BUG_ON(PageWriteback(page));
+
 	ClearPageDirty(page);
-	page->flags &= ~(1<<PG_referenced);
+	ClearPageUptodate(page);
+	ClearPageSlab(page);
+	ClearPageNosave(page);
+	ClearPageChecked(page);
 
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
