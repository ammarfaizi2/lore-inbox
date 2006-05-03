Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWECG4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWECG4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 02:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWECG4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 02:56:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63569 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965105AbWECG4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 02:56:02 -0400
Date: Wed, 3 May 2006 08:56:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice(SPLICE_F_MOVE) problems
Message-ID: <20060503065644.GJ9712@suse.de>
References: <20060501065953.GA289@oleg> <20060501065412.GP23137@suse.de> <20060501190625.GA174@oleg> <20060501174153.GH3814@suse.de> <20060502001118.GA88@oleg> <20060502052850.GP3814@suse.de> <20060503041455.GA158@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060503041455.GA158@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03 2006, Oleg Nesterov wrote:
> I am looking at current fs/splice.c from
> 	http://kernel.org/git/?p=linux/kernel/git/torvalds/....
> 
> 
> 	pipe_to_file:
> 
> 		if ((sd->flags & SPLICE_F_MOVE) && this_len == PAGE_CACHE_SIZE) {
> 			/*
> 			 * If steal succeeds, buf->page is now pruned from the vm
> 			 * side (page cache) and we can reuse it. The page will also
> 			 * be locked on successful return.
> 			 */
> 			if (buf->ops->steal(info, buf))
> 				goto find_page;
> 
> 			page = buf->page;
> 			page_cache_get(page);
> 
> Isn't it better to do this after successful successful add_to_page_cache() ?
> This way you don't need to do page_cache_release() if add_to_page_cache fails.

It is, I dunno why I moved the ordering around when fixing that up. I'll
move it down a block and skip the early page_cache_get.

> 			/*
> 			 * page must be on the LRU for adding to the pagecache.
> 
> Is it true? (looking at add_to_page_cache_lru).

My wording is a little confusing probably, I didn't mean to imply any
ordering contraints there. Just simply state that a page cannot be in
the pagecache and not on the LRU.

> 			if (!PageLRU(page)) {
> 				struct zone *zone = page_zone(page);
> 
> 				spin_lock_irq(&zone->lru_lock);
> 				if (!PageLRU(page)) {
> 					SetPageLRU(page);
> 					add_page_to_inactive_list(zone, page);
> 				}
> 				spin_unlock_irq(&zone->lru_lock);
> 
> Why not lru_cache_add() ?

Because for calling lru_cache_add, I have to be absolutely certain that
the page isn't on the LRU already. So I'd have to grab the zone lru_lock
first anyways, and I cannot call lru_cache_add() with that held since
__pagevec_lru_add() also grabs it. Hence the "open coding".

> 			if (add_to_page_cache(page, mapping, index, gfp_mask)) {
> 				page_cache_release(page);
> 				unlock_page(page);
> 				goto find_page;
> 
> This leaves unmapped page on ->inactive_list. page_count(page) == 1.
> What if shrink_inactive_list() finds this page, increments
> page->count, and calls shrink_page_list()->remove_mapping() again?
> Hmm... So page_cache_pipe_buf_steal() has a reason to return a locked
> page (I am not an expert, please correct me).

With the block moved above the LRU business, this disappears as well.

> However, user_page_pipe_buf_steal() returns unlocked page in
> PIPE_BUF_FLAG_GIFT case. So, if add_to_page_cache() fails,
> unlock_page() will trigger BUG().

It does, it calls generic_pipe_buf_steal() which locks it.

> 		ret = mapping->a_ops->prepare_write(file, page, offset, offset+this_len);
> 		if (ret == AOP_TRUNCATED_PAGE) {
> 			page_cache_release(page);
> 			goto find_page;
> 
> We also need to unlock(page) if it was stealed.

Are you sure that's the right test? Don't you mean if ret !=
AOP_TRUNCATED_PAGE && ret?

How about the attached?

diff --git a/fs/splice.c b/fs/splice.c
index 7fb0497..9b10ec4 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -574,12 +574,17 @@ static int pipe_to_file(struct pipe_inod
 			goto find_page;
 
 		page = buf->page;
+		if (add_to_page_cache(page, mapping, index, gfp_mask)) {
+			unlock_page(page);
+			goto find_page;
+		}
+
 		page_cache_get(page);
 
 		/*
-		 * page must be on the LRU for adding to the pagecache.
-		 * Check this without grabbing the zone lock, if it isn't
-		 * the do grab the zone lock, recheck, and add if necessary.
+		 * The page cannot reside in the pagecache and not be on
+		 * the LRU list. It should be safe to check PageLRU()
+		 * outside the zone lru_lock, as long as we recheck it inside.
 		 */
 		if (!PageLRU(page)) {
 			struct zone *zone = page_zone(page);
@@ -591,12 +596,6 @@ static int pipe_to_file(struct pipe_inod
 			}
 			spin_unlock_irq(&zone->lru_lock);
 		}
-
-		if (add_to_page_cache(page, mapping, index, gfp_mask)) {
-			page_cache_release(page);
-			unlock_page(page);
-			goto find_page;
-		}
 	} else {
 find_page:
 		page = find_lock_page(mapping, index);
@@ -647,11 +646,15 @@ find_page:
 	}
 
 	ret = mapping->a_ops->prepare_write(file, page, offset, offset+this_len);
-	if (ret == AOP_TRUNCATED_PAGE) {
+	if (unlikely(ret)) {
+		if (ret != AOP_TRUNCATED_PAGE)
+			unlock_page(page);
 		page_cache_release(page);
-		goto find_page;
-	} else if (ret)
+		if (ret == AOP_TRUNCATED_PAGE)
+			goto find_page;
+
 		goto out;
+	}
 
 	if (buf->page != page) {
 		/*

-- 
Jens Axboe

