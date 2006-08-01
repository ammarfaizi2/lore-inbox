Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422782AbWHALwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422782AbWHALwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbWHALwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:52:24 -0400
Received: from mx2.mail.ru ([194.67.23.122]:15725 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1422780AbWHALwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:52:23 -0400
Date: Tue, 1 Aug 2006 16:00:20 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]: ufs: ufs_change_blocknr: skip truncated pages
Message-ID: <20060801120020.GA24263@rain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060731125702.GA5094@rain> <20060731230251.3b149902.akpm@osdl.org> <20060801073043.GA17186@rain> <20060801003958.c628455f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801003958.c628455f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 12:39:58AM -0700, Andrew Morton wrote:
> I'm not sure that the `goto repeat' is needed if truncate got there first,
> really - if truncate took the page down then it's now outside i_size and
> shouldn't be coming back.
> 
> If the page _can_ come back then this code is all rather problematic. 
> Because this means that the page can come back (via an extending write())
> one nanosecond after ufs_get_locked_page() returns NULL.  Won't the callers
> of ufs_get_locked_page() get confused by that?

ufs_get_locked_page is called twice in ufs code, 
one time in ufs_truncate path(we allocated last block), 
and another time when fragments are reallocated.
In ideal world in the second case on allocation/free block layer we
should not know that things like `truncate' exists, but now with
such crutch like ufs_get_locked_page we can (or should?) skip truncated pages.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.18-rc2-mm1/fs/ufs/balloc.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/fs/ufs/balloc.c
+++ linux-2.6.18-rc2-mm1/fs/ufs/balloc.c
@@ -248,7 +248,7 @@ static void ufs_change_blocknr(struct in
 
 		if (likely(cur_index != index)) {
 			page = ufs_get_locked_page(mapping, index);
-			if (IS_ERR(page))
+			if (!page || IS_ERR(page)) /* it was truncated or EIO */
 				continue;
 		} else
 			page = locked_page;
Index: linux-2.6.18-rc2-mm1/fs/ufs/util.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/fs/ufs/util.c
+++ linux-2.6.18-rc2-mm1/fs/ufs/util.c
@@ -251,7 +251,6 @@ struct page *ufs_get_locked_page(struct 
 {
 	struct page *page;
 
-try_again:
 	page = find_lock_page(mapping, index);
 	if (!page) {
 		page = read_cache_page(mapping, index,
@@ -271,7 +270,8 @@ try_again:
 			/* Truncate got there first */
 			unlock_page(page);
 			page_cache_release(page);
-			goto try_again;
+			page = NULL;
+			goto out;
 		}
 
 		if (!PageUptodate(page) || PageError(page)) {

-- 
/Evgeniy

