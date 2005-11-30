Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVK3IiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVK3IiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 03:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVK3Ih7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 03:37:59 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:14756 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751134AbVK3Ih7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 03:37:59 -0500
Message-ID: <438D6427.8060003@jp.fujitsu.com>
Date: Wed, 30 Nov 2005 17:34:47 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Cliff Wickman <cpw@sgi.com>
Subject: Re: [Lhms-devel] [PATCH 4/7] Direct Migration V5: migrate_pages()
 extension
References: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com> <20051128204304.10037.81195.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051128204304.10037.81195.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Christoph Lameter wrote:
> +int migrate_page_remove_references(struct page *newpage, struct page *page, int nr_refs)
> +{
> +	write_lock_irq(&mapping->tree_lock);
> +
> +	radix_pointer = (struct page **)radix_tree_lookup_slot(
> +						&mapping->page_tree,
> +						page_index(page));
> +
> +	if (!page->mapping ||
> +	    page_count(page) != nr_refs ||
> +	    *radix_pointer != page) {
> +		write_unlock_irq(&mapping->tree_lock);
> +		return 1;
> +	}

I'm testing memory hot removing patch based on your patch.

I found a problem around the shmem,
but I'm not sure whether it can be problem on migration or not.

Problem is:
1. a page of shmem(tmpfs)'s generic file is in page-cache. assume page is diry.
2. When it passed to migrate_page(), it reaches pageout() in the middle of migrate_page().
3. pageout calls shmem_writepage(), and the page turns to be swap-cache page.
    At this point, page->mapping becomes NULL (see move_to_swapcache())
4. pageout retunrs PAGE_SUCCESS.
5. Finaly, migrate_page() goes to redo.
6. retry
7. Because spwapper_space's  a_ops->migratepage is not NULL,
    "Avoid write back hook" in patch 7/7 is used.
+		if (mapping->a_ops->migratepage) {
+			rc = mapping->a_ops->migratepage(newpage, page);
+			goto unlock_both;
+                }
    a_ops->migrate_page points to migrate_page() in mm/vmscan.c
8. migrate_page() try to replace radix tree entry in swapper_space.
9. Becasue page->mapping is NULL(becasue of 3), migrate_page_remove_references() fails.

I avoid above situation by following code in migrate_page_remove_references() now.
But I'm not sure whether this is sane fix or not.
 > +	if ((!PageSwapCache(page) && !page->mapping) ||
 > +	    page_count(page) != nr_refs ||
 > +	    *radix_pointer != page) {
 > +		write_unlock_irq(&mapping->tree_lock);
 > +		return 1;
 > +	}



-- Kame

