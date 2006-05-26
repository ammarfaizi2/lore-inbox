Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWEZMFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWEZMFd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWEZMES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:04:18 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:23001 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932364AbWEZLxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:00 -0400
Message-ID: <348644377.06563@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115302.278500703@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:13 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 07/33] readahead: delay page release in do_generic_mapping_read()
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
@@ -813,10 +813,12 @@ void do_generic_mapping_read(struct addr
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
@@ -855,6 +857,11 @@ find_page:
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
@@ -889,7 +896,6 @@ page_ok:
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
 		goto out;
@@ -901,7 +907,6 @@ page_not_up_to_date:
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
-			page_cache_release(page);
 			continue;
 		}
 
@@ -931,7 +936,6 @@ readpage:
 					 * invalidate_inode_pages got it
 					 */
 					unlock_page(page);
-					page_cache_release(page);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -952,7 +956,6 @@ readpage:
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			page_cache_release(page);
 			goto out;
 		}
 
@@ -961,7 +964,6 @@ readpage:
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
-				page_cache_release(page);
 				goto out;
 			}
 		}
@@ -971,7 +973,6 @@ readpage:
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
-		page_cache_release(page);
 		goto out;
 
 no_cached_page:
@@ -996,6 +997,9 @@ no_cached_page:
 		}
 		page = cached_page;
 		cached_page = NULL;
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		goto readpage;
 	}
 
@@ -1005,6 +1009,8 @@ out:
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (prev_page)
+		page_cache_release(prev_page);
 	if (filp)
 		file_accessed(filp);
 }

--
