Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbVK3R3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbVK3R3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVK3R3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:29:08 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54672 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751474AbVK3R3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:29:06 -0500
Message-ID: <438DE141.3030206@jp.fujitsu.com>
Date: Thu, 01 Dec 2005 02:28:33 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: akpm@osdl.org, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Cliff Wickman <cpw@sgi.com>
Subject: Re: [Lhms-devel] [PATCH 4/7] Direct Migration V5: migrate_pages()
 extension
References: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com> <20051128204304.10037.81195.sendpatchset@schroedinger.engr.sgi.com> <438D6427.8060003@jp.fujitsu.com> <Pine.LNX.4.62.0511300834010.19142@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511300834010.19142@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> The current page migration functions in mempolicy.c do not migrate shmem 
> vmas to be safe. In the future we surely would like to support migration 
> of shmem. I'd be glad if you could make sure that this works.
> 
Okay, shmem is not problem now.

> 
>>Problem is:
>>1. a page of shmem(tmpfs)'s generic file is in page-cache. assume page is
>>diry.
>>2. When it passed to migrate_page(), it reaches pageout() in the middle of
>>migrate_page().
>>3. pageout calls shmem_writepage(), and the page turns to be swap-cache page.
>>   At this point, page->mapping becomes NULL (see move_to_swapcache())
> 
> 
> A swapcache page would have page->mapping pointing to swapper space. 
> move_to_swap_cache does not set page->mapping == NULL.
> 
int move_to_swap_cache(struct page *page, swp_entry_t entry)
{
         int err = __add_to_swap_cache(page, entry, GFP_ATOMIC);
         if (!err) {
                 remove_from_page_cache(page);<------------------------this
                 page_cache_release(page);       /* pagecache ref */
                 if (!swap_duplicate(entry))
                         BUG();
                 SetPageDirty(page);
                 INC_CACHE_INFO(add_total);
         } else if (err == -EEXIST)
                 INC_CACHE_INFO(exist_race);
         return err;
}

remove_from_page_cache(page) sets page->mapping == NULL.


> 
> If page->mapping would be NULL then migrate_page() could not 
> have been called. The mapping is used to obtain the address of the 
> function to call,
What you say is here.
==
                 /*
                  * Pages are properly locked and writeback is complete.
                  * Try to migrate the page.
                  */
                 mapping = page_mapping(page);
                 if (!mapping) <-------------------------------------------this check.
                         goto unlock_both;

                 if (mapping->a_ops->migratepage) {
                         rc = mapping->a_ops->migratepage(newpage, page);
                         goto unlock_both;
                 }
==
But, see page_mapping() .....
==
static inline struct address_space *page_mapping(struct page *page)
{
         struct address_space *mapping = page->mapping;

         if (unlikely(PageSwapCache(page)))
                 mapping = &swapper_space;
         else if (unlikely((unsigned long)mapping & PAGE_MAPPING_ANON))
                 mapping = NULL;
         return mapping;
}
==

Even if page->mapping == NULL, page_mapping() can return &swapper_space if PageSwapCache()
is true. (Note: a shmem page here is not page-cache, not anon, but swap-cache)

I'm now considering to add a_ops->migrate_page() to shmem is sane way...
But migration doesn't manage shmem, so this is just memory hot-remove's problem.


-- Kame




