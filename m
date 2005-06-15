Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVFOGib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVFOGib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 02:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVFOGib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 02:38:31 -0400
Received: from [210.76.108.235] ([210.76.108.235]:43013 "EHLO in")
	by vger.kernel.org with ESMTP id S261513AbVFOGiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 02:38:18 -0400
Subject: Re: one question about LRU mechanism
From: "liyu@LAN" <liyu@ccoss.com.cn>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050615052530.GA3913@holomorphy.com>
References: <1118812376.32766.4.camel@liyu.ccoss.com.cn>
	 <20050615052530.GA3913@holomorphy.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jun 2005 14:46:30 +0800
Message-Id: <1118817991.5828.23.camel@liyu.ccoss.com.cn>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-CoCreate.36) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.11.11, mm do not have function isolate_lru_pages(), but I
downloaded linux-2.6.11.12.tar.bz2 source tarball, and apply follow two
patches in order:

patch-2.6.12-rc6
2.6.12-rc6-mm1

Oh, Have any error in this process? patch program say it can not change
some files , and save some *.rej files. but these *rej do not include
mm/vmscan.c.

This new function called two times in shrink_cache() and
refill_inactive_zone(). 

The main part of isolate_lru_pages() is 

/************************************************************/
        while (scan++ < nr_to_scan && !list_empty(src)) {
                page = lru_to_page(src);
                prefetchw_prev_lru_page(page, src, flags);
                                                                                                    
                if (!TestClearPageLRU(page))
                        BUG();
                list_del(&page->lru);
                if (get_page_testone(page)) {
                        /*
                         * It is being freed elsewhere
                         */
                        __put_page(page);
                        SetPageLRU(page);
                        list_add(&page->lru, src);
                        continue;
                } else {
                        list_add(&page->lru, dst);
                        nr_taken++;
                }
        }
/************************************************************/

I think, this change that new function isolate_lru_pages() is one kind
of refactoring (method extract ??), not one essence change. 

the call:
                list_del(&page->lru);

as I known, just delete its argument from list, but not its previous
element. so, It is most newest page that just be appended to
active_list.

I think, may be, codes like this will be better.

/***************************************************/
        while (scan++ < nr_to_scan && !list_empty(src->prev)) {
                page = lru_to_page(src->prev);
                prefetchw_prev_lru_page(page, src->prev, flags);
                                                                                                    
                if (!TestClearPageLRU(page))
                        BUG();
                list_del(&page->lru);
        ......
/**************************************************/


This is just my flimsy perspective.



在 2005-06-14二的 22:25 -0700，William Lee Irwin III wrote：
> On Wed, Jun 15, 2005 at 01:12:56PM +0800, liyu@WAN wrote:
> > 	I am reading memory managment code of kernel 2.6.11.11.
> > I found LRU is implement as linked-stack in linux, include two important
> > data structure linked-list :
> > zone->active_list and zone->inactive_list. when kernel need reclaim some
> > pages, it will call function refiil_inactive_list() ultimately to move
> > some page from active_list to inactive_list.
> 
> The "LRU" bits there don't actually describe the homebrew algorithm.
> 
> 
> On Wed, Jun 15, 2005 at 01:12:56PM +0800, liyu@WAN wrote:
> > 	It's OK, but I have one question in my mind:
> > I found all function that append page to active_list, it just append
> > page to head of active_list (use inline function list_add() ), but
> > refill_inactive_list() also start scanning from head of active_list, I
> > think the better way scan active_list is start from rear of active_list
> > and scan though prev member of list_head at reclaim pages. Scanning
> > start from head of active_list may make thrashing more possibly, I
> > think. and, in my view, "head of active_list" is zone->active_list,
> > "rear of active_list" is zone->active_list.prev .
> > 	May be, I am failed understand mm? or what's wrong?
> 
> I'm looking at 2.6.12-rc6-mm1.
> 
> As far as I can tell new active pages are added to the ->next component
> of the head of the active list in lru_cache_add_active() and the ->next
> component of the head of the inactive list in lru_cache_add(). Then
> isolate_lru_pages() dequeues from ->prev of the head of the inactive
> list in shrink_cache() and isolate_lru_pages() dequeues from the ->prev
> of the active list in refill_inactive_zone().
> 
> 
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

