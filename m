Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSGDXua>; Thu, 4 Jul 2002 19:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSGDXsn>; Thu, 4 Jul 2002 19:48:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47117 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315222AbSGDXq4>;
	Thu, 4 Jul 2002 19:46:56 -0400
Message-ID: <3D24E067.37C94B91@zip.com.au>
Date: Thu, 04 Jul 2002 16:55:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 24/27] fix invalidate_inode_pages2() race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix a buglet in invalidate_list_pages2(): there is a small window in
which writeback could start against the page before this function locks
it.

The patch closes the race by performing the PageWriteback test inside
PageLocked.

Testing PageWriteback inside PageLocked is "definitive" - when a page
is locked, writeback cannot start against it.




 filemap.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

--- 2.5.24/mm/filemap.c~invalidate-race	Thu Jul  4 16:17:32 2002
+++ 2.5.24-akpm/mm/filemap.c	Thu Jul  4 16:17:32 2002
@@ -367,16 +367,18 @@ static int invalidate_list_pages2(struct
 	while (curr != head) {
 		page = list_entry(curr, struct page, list);
 
-		if (PageWriteback(page)) {
-			write_unlock(&mapping->page_lock);
-			wait_on_page_writeback(page);
-			unlocked = 1;
-			write_lock(&mapping->page_lock);
-			goto restart;
-		}
 		if (!TestSetPageLocked(page)) {
 			int __unlocked;
 
+			if (PageWriteback(page)) {
+				write_unlock(&mapping->page_lock);
+				wait_on_page_writeback(page);
+				unlocked = 1;
+				write_lock(&mapping->page_lock);
+				unlock_page(page);
+				goto restart;
+			}
+
 			__unlocked = invalidate_this_page2(mapping, page, curr, head);
 			unlock_page(page);
 			unlocked |= __unlocked;

-
