Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSHJA6i>; Fri, 9 Aug 2002 20:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSHJA5o>; Fri, 9 Aug 2002 20:57:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27410 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316530AbSHJA5M>;
	Fri, 9 Aug 2002 20:57:12 -0400
Message-ID: <3D54653F.59964CA7@zip.com.au>
Date: Fri, 09 Aug 2002 17:58:39 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 12/12] fix a race between set_page_dirty and truncate
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix a race between set_page_dirty() and truncate.

The page could have been removed from the mapping while this CPU is
spinning on the lock.  __free_pages_ok() will go BUG.

This has not been observed in practice - most callers of
set_page_dirty() hold the page lock which gives exclusion from
truncate.  But zap_pte_range() does not.

A fix for this has been sent to Marcelo also.



 page-writeback.c |   12 ++++++++----
 1 files changed, 8 insertions, 4 deletions

--- 2.5.30/mm/page-writeback.c~set_page_dirty-race	Fri Aug  9 17:36:48 2002
+++ 2.5.30-akpm/mm/page-writeback.c	Fri Aug  9 17:36:48 2002
@@ -477,8 +477,10 @@ int __set_page_dirty_buffers(struct page
 
 	if (!TestSetPageDirty(page)) {
 		write_lock(&mapping->page_lock);
-		list_del(&page->list);
-		list_add(&page->list, &mapping->dirty_pages);
+		if (page->mapping) {	/* Race with truncate? */
+			list_del(&page->list);
+			list_add(&page->list, &mapping->dirty_pages);
+		}
 		write_unlock(&mapping->page_lock);
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
@@ -511,8 +513,10 @@ int __set_page_dirty_nobuffers(struct pa
 
 		if (mapping) {
 			write_lock(&mapping->page_lock);
-			list_del(&page->list);
-			list_add(&page->list, &mapping->dirty_pages);
+			if (page->mapping) {	/* Race with truncate? */
+				list_del(&page->list);
+				list_add(&page->list, &mapping->dirty_pages);
+			}
 			write_unlock(&mapping->page_lock);
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 		}

.
