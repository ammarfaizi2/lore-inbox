Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262565AbSI0SGz>; Fri, 27 Sep 2002 14:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262566AbSI0SGy>; Fri, 27 Sep 2002 14:06:54 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:36534 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262565AbSI0SGy>;
	Fri, 27 Sep 2002 14:06:54 -0400
Date: Fri, 27 Sep 2002 21:26:41 -0400
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@conectiva.com.br
Cc: gone@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup some i386 mm init code
Message-ID: <20020927212641.B4637@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, marcelo@conectiva.com.br,
	gone@us.ibm.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup one_highpage_init() as in 2.5.  Patricia ACKed this change long
ago.


--- linux-2.4.20-pre5/arch/i386/mm/init.c	Tue Aug 20 11:36:59 2002
+++ linux/arch/i386/mm/init.c	Fri Sep  6 13:14:37 2002
@@ -449,21 +449,14 @@ static inline int page_kills_ppro(unsign
 #ifdef CONFIG_HIGHMEM
 void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
 {
-	if (!page_is_ram(pfn)) {
+	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
+		ClearPageReserved(page);
+		set_bit(PG_highmem, &page->flags);
+		set_page_count(page, 1);
+		__free_page(page);
+		totalhigh_pages++;
+	} else
 		SetPageReserved(page);
-		return;
-	}
-	
-	if (bad_ppro && page_kills_ppro(pfn)) {
-		SetPageReserved(page);
-		return;
-	}
-	
-	ClearPageReserved(page);
-	set_bit(PG_highmem, &page->flags);
-	atomic_set(&page->count, 1);
-	__free_page(page);
-	totalhigh_pages++;
 }
 #endif /* CONFIG_HIGHMEM */
 
