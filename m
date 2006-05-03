Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWECAO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWECAO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWECAO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:14:57 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:13029 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965048AbWECAO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:14:57 -0400
Date: Wed, 3 May 2006 08:14:55 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice(SPLICE_F_MOVE) problems
Message-ID: <20060503041455.GA158@oleg>
References: <20060501065953.GA289@oleg> <20060501065412.GP23137@suse.de> <20060501190625.GA174@oleg> <20060501174153.GH3814@suse.de> <20060502001118.GA88@oleg> <20060502052850.GP3814@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502052850.GP3814@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking at current fs/splice.c from
	http://kernel.org/git/?p=linux/kernel/git/torvalds/....


	pipe_to_file:

		if ((sd->flags & SPLICE_F_MOVE) && this_len == PAGE_CACHE_SIZE) {
			/*
			 * If steal succeeds, buf->page is now pruned from the vm
			 * side (page cache) and we can reuse it. The page will also
			 * be locked on successful return.
			 */
			if (buf->ops->steal(info, buf))
				goto find_page;

			page = buf->page;
			page_cache_get(page);

Isn't it better to do this after successful successful add_to_page_cache() ?
This way you don't need to do page_cache_release() if add_to_page_cache fails.

			/*
			 * page must be on the LRU for adding to the pagecache.

Is it true? (looking at add_to_page_cache_lru).

			 * Check this without grabbing the zone lock, if it isn't
			 * the do grab the zone lock, recheck, and add if necessary.
			 */
			if (!PageLRU(page)) {
				struct zone *zone = page_zone(page);

				spin_lock_irq(&zone->lru_lock);
				if (!PageLRU(page)) {
					SetPageLRU(page);
					add_page_to_inactive_list(zone, page);
				}
				spin_unlock_irq(&zone->lru_lock);

Why not lru_cache_add() ?


			if (add_to_page_cache(page, mapping, index, gfp_mask)) {
				page_cache_release(page);
				unlock_page(page);
				goto find_page;

This leaves unmapped page on ->inactive_list. page_count(page) == 1. What if
shrink_inactive_list() finds this page, increments page->count, and calls
shrink_page_list()->remove_mapping() again? Hmm... So page_cache_pipe_buf_steal()
has a reason to return a locked page (I am not an expert, please correct me).

However, user_page_pipe_buf_steal() returns unlocked page in PIPE_BUF_FLAG_GIFT
case. So, if add_to_page_cache() fails, unlock_page() will trigger BUG().


		ret = mapping->a_ops->prepare_write(file, page, offset, offset+this_len);
		if (ret == AOP_TRUNCATED_PAGE) {
			page_cache_release(page);
			goto find_page;

We also need to unlock(page) if it was stealed.

Oleg.

