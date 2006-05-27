Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWE0PxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWE0PxK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWE0Pwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:52:40 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:47323 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751562AbWE0Pvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:31 -0400
Message-ID: <348745087.27363@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155128.472551240@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:48:55 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 06/32] readahead: delay page release in do_generic_mapping_read()
Content-Disposition: inline; filename=readahead-delay-page-release-in-do_generic_mapping_read.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In do_generic_mapping_read(), release accessed pages some time later,
so that it can be passed to and used by the adaptive read-ahead code.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/filemap.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/mm/filemap.c
+++ linux-2.6.17-rc4-mm3/mm/filemap.c
@@ -835,10 +835,12 @@ void do_generic_mapping_read(struct addr
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
@@ -877,6 +879,11 @@ find_page:
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
@@ -911,7 +918,6 @@ page_ok:
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
 		goto out;
@@ -923,7 +929,6 @@ page_not_up_to_date:
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
-			page_cache_release(page);
 			continue;
 		}
 
@@ -953,7 +958,6 @@ readpage:
 					 * invalidate_inode_pages got it
 					 */
 					unlock_page(page);
-					page_cache_release(page);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -974,7 +978,6 @@ readpage:
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			page_cache_release(page);
 			goto out;
 		}
 
@@ -983,7 +986,6 @@ readpage:
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
-				page_cache_release(page);
 				goto out;
 			}
 		}
@@ -993,7 +995,6 @@ readpage:
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
-		page_cache_release(page);
 		goto out;
 
 no_cached_page:
@@ -1018,6 +1019,9 @@ no_cached_page:
 		}
 		page = cached_page;
 		cached_page = NULL;
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		goto readpage;
 	}
 
@@ -1027,6 +1031,8 @@ out:
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (prev_page)
+		page_cache_release(prev_page);
 	if (filp)
 		file_accessed(filp);
 }

--
