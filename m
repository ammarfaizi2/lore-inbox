Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWCSCmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWCSCmF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWCSClu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:41:50 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:35266 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751260AbWCSCee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:34 -0500
Message-Id: <20060319023450.785211000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:18 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 05/23] readahead: refactor do_generic_mapping_read()
Content-Disposition: inline; filename=readahead-refactor-do_generic_mapping_read.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In do_generic_mapping_read(), release accessed pages some time later,
so that it can be passed to and used by the adaptive read-ahead code.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/filemap.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

--- linux-2.6.16-rc6-mm2.orig/mm/filemap.c
+++ linux-2.6.16-rc6-mm2/mm/filemap.c
@@ -799,10 +799,12 @@ void do_generic_mapping_read(struct addr
 	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
+	struct page *prev_page;
 	int error;
 	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
+	prev_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
 	prev_index = ra.prev_page;
@@ -841,6 +843,11 @@ find_page:
 			handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
+
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
+
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -875,7 +882,6 @@ page_ok:
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
 		goto out;
@@ -887,7 +893,6 @@ page_not_up_to_date:
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
-			page_cache_release(page);
 			continue;
 		}
 
@@ -917,7 +922,6 @@ readpage:
 					 * invalidate_inode_pages got it
 					 */
 					unlock_page(page);
-					page_cache_release(page);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -938,7 +942,6 @@ readpage:
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			page_cache_release(page);
 			goto out;
 		}
 
@@ -947,7 +950,6 @@ readpage:
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
-				page_cache_release(page);
 				goto out;
 			}
 		}
@@ -957,7 +959,6 @@ readpage:
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
-		page_cache_release(page);
 		goto out;
 
 no_cached_page:
@@ -982,6 +983,9 @@ no_cached_page:
 		}
 		page = cached_page;
 		cached_page = NULL;
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		goto readpage;
 	}
 
@@ -991,6 +995,8 @@ out:
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (prev_page)
+		page_cache_release(prev_page);
 	if (filp)
 		file_accessed(filp);
 }

--
