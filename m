Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311509AbSCTES3>; Tue, 19 Mar 2002 23:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311523AbSCTEQu>; Tue, 19 Mar 2002 23:16:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:60431 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311509AbSCTECs>; Tue, 19 Mar 2002 23:02:48 -0500
Message-ID: <3C980990.1C6B232A@zip.com.au>
Date: Tue, 19 Mar 2002 20:01:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-160-lru_release_check
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hugh's much-discussed check for releasing pages which are still on the LRU.


=====================================

--- 2.4.19-pre3/mm/page_alloc.c~aa-160-lru_release_check	Tue Mar 19 19:49:02 2002
+++ 2.4.19-pre3-akpm/mm/page_alloc.c	Tue Mar 19 19:49:02 2002
@@ -102,8 +102,11 @@ static void __free_pages_ok (struct page
 	/* Yes, think what happens when other parts of the kernel take 
 	 * a reference to a page in order to pin it for io. -ben
 	 */
-	if (PageLRU(page))
+	if (PageLRU(page)) {
+		if (unlikely(in_interrupt()))
+			BUG();
 		lru_cache_del(page);
+	}
 
 	if (page->buffers)
 		BUG();

-
