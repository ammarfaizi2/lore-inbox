Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311520AbSCTEFq>; Tue, 19 Mar 2002 23:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311504AbSCTEEq>; Tue, 19 Mar 2002 23:04:46 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:19984 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311531AbSCTEDx>; Tue, 19 Mar 2002 23:03:53 -0500
Message-ID: <3C9809D0.9FEECFDB@zip.com.au>
Date: Tue, 19 Mar 2002 20:02:24 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-180-activate_page_cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fold activate_page_nolock() into activate_page().

=====================================

--- 2.4.19-pre3/mm/swap.c~aa-180-activate_page_cleanup	Tue Mar 19 19:49:03 2002
+++ 2.4.19-pre3-akpm/mm/swap.c	Tue Mar 19 19:49:03 2002
@@ -36,18 +36,17 @@ pager_daemon_t pager_daemon = {
 /*
  * Move an inactive page to the active list.
  */
-static inline void activate_page_nolock(struct page * page)
-{
-	if (PageLRU(page) && !PageActive(page)) {
-		del_page_from_inactive_list(page);
-		add_page_to_active_list(page);
-	}
-}
-
 void activate_page(struct page * page)
 {
 	spin_lock(&pagemap_lru_lock);
-	activate_page_nolock(page);
+	if (PageLRU(page)) {
+		if  (!PageActive(page)) {
+			del_page_from_inactive_list(page);
+			add_page_to_active_list(page);
+			ClearPageReferenced(page);
+		} else
+			SetPageReferenced(page);
+	}
 	spin_unlock(&pagemap_lru_lock);
 }
 


-
