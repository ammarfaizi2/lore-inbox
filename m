Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313596AbSEEU5J>; Sun, 5 May 2002 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSEEUzu>; Sun, 5 May 2002 16:55:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43785 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313559AbSEEUy2>;
	Sun, 5 May 2002 16:54:28 -0400
Message-ID: <3CD59C8F.A228F2E2@zip.com.au>
Date: Sun, 05 May 2002 13:56:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 6/10] Fix SMP race in truncate
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Closes a small race window: testing PageWriteback() outside the page
lock introduces the possibility that page could be redirtied and have
writeback started after we've inspected PageWriteback.


=====================================

--- 2.5.13/mm/filemap.c~truncate-race	Sun May  5 13:32:00 2002
+++ 2.5.13-akpm/mm/filemap.c	Sun May  5 13:32:35 2002
@@ -201,18 +201,18 @@ static int truncate_list_pages(struct ad
 			int failed;
 
 			page_cache_get(page);
-			if (PageWriteback(page)) {
-				/*
-				 * urgggh. This function is utterly foul,
-				 * and this addition doesn't help.  Kill.
-				 */
+			failed = TestSetPageLocked(page);
+			if (!failed && PageWriteback(page)) {
+				unlock_page(page);
+				list_del(head);
+				list_add_tail(head, curr);
 				write_unlock(&mapping->page_lock);
 				wait_on_page_writeback(page);
+				page_cache_release(page);
 				unlocked = 1;
 				write_lock(&mapping->page_lock);
 				goto restart;
 			}
-			failed = TestSetPageLocked(page);
 
 			list_del(head);
 			if (!failed)

-
