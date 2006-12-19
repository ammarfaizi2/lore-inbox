Return-Path: <linux-kernel-owner+w=401wt.eu-S1753011AbWLSHXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbWLSHXQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754801AbWLSHXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:23:16 -0500
Received: from amsfep19-int.chello.nl ([62.179.120.14]:60991 "EHLO
	amsfep19-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbWLSHXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:23:16 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <45876C65.7010301@yahoo.com.au>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <45876C65.7010301@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 08:22:03 +0100
Message-Id: <1166512923.10372.114.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 15:36 +1100, Nick Piggin wrote:

> plain text document attachment (fs-fix.patch)
> Index: linux-2.6/fs/buffer.c
> ===================================================================
> --- linux-2.6.orig/fs/buffer.c	2006-12-19 15:15:46.000000000 +1100
> +++ linux-2.6/fs/buffer.c	2006-12-19 15:36:01.000000000 +1100
> @@ -2852,7 +2852,17 @@ int try_to_free_buffers(struct page *pag
>  		 * This only applies in the rare case where try_to_free_buffers
>  		 * succeeds but the page is not freed.
>  		 */
> -		clear_page_dirty(page);
> +
> +		/*
> +		 * If the page has been dirtied via the user mappings, then
> +		 * clean buffers does not indicate the page data is actually
> +		 * clean! Only clear the page dirty bit if there are no dirty
> +		 * ptes either.
> +		 *
> +		 * If there are dirty ptes, then the page must be uptodate, so
> +		 * the above concern does not apply.
> +		 */
> +		clear_page_dirty_sync_ptes(page);
>  	}
>  out:
>  	if (buffers_to_free) {
> Index: linux-2.6/include/linux/page-flags.h
> ===================================================================
> --- linux-2.6.orig/include/linux/page-flags.h	2006-12-19 15:17:18.000000000 +1100
> +++ linux-2.6/include/linux/page-flags.h	2006-12-19 15:34:24.000000000 +1100
> @@ -254,6 +254,7 @@ static inline void SetPageUptodate(struc
>  struct page;	/* forward declaration */
>  
>  int test_clear_page_dirty(struct page *page);
> +int test_clear_page_dirty_sync_ptes(struct page *page);
>  int test_clear_page_writeback(struct page *page);
>  int test_set_page_writeback(struct page *page);
>  
> @@ -262,6 +263,11 @@ static inline void clear_page_dirty(stru
>  	test_clear_page_dirty(page);
>  }
>  
> +static inline void clear_page_dirty_sync_ptes(struct page *page)
> +{
> +	test_clear_page_dirty_sync_ptes(page);
> +}
> +
>  static inline void set_page_writeback(struct page *page)
>  {
>  	test_set_page_writeback(page);
> Index: linux-2.6/mm/page-writeback.c
> ===================================================================
> --- linux-2.6.orig/mm/page-writeback.c	2006-12-19 15:17:53.000000000 +1100
> +++ linux-2.6/mm/page-writeback.c	2006-12-19 15:33:29.000000000 +1100
> @@ -844,9 +844,10 @@ EXPORT_SYMBOL(set_page_dirty_lock);
>  
>  /*
>   * Clear a page's dirty flag, while caring for dirty memory accounting. 
> + * Does not clear pte dirty bits.
>   * Returns true if the page was previously dirty.
>   */
> -int test_clear_page_dirty(struct page *page)
> +static int test_clear_page_dirty_leave_ptes(struct page *page)
>  {
>  	struct address_space *mapping = page_mapping(page);
>  	unsigned long flags;
> @@ -862,10 +863,8 @@ int test_clear_page_dirty(struct page *p
>  			 * We can continue to use `mapping' here because the
>  			 * page is locked, which pins the address_space
>  			 */
> -			if (mapping_cap_account_dirty(mapping)) {
> -				page_mkclean(page);
> +			if (mapping_cap_account_dirty(mapping))
>  				dec_zone_page_state(page, NR_FILE_DIRTY);
> -			}
>  			return 1;
>  		}
>  		write_unlock_irqrestore(&mapping->tree_lock, flags);
> @@ -873,9 +872,43 @@ int test_clear_page_dirty(struct page *p
>  	}
>  	return TestClearPageDirty(page);
>  }
> +
> +/*
> + * As above, but does clear dirty bits from ptes
> + */
> +int test_clear_page_dirty(struct page *page)
> +{
> +	struct address_space *mapping = page_mapping(page);
> +
> +	if (test_clear_page_dirty_leave_ptes(page)) {
> +		if (mapping_cap_account_dirty(mapping))
> +			page_mkclean(page);
> +		return 1;
> +	}
> +	return 0;
> +}
>  EXPORT_SYMBOL(test_clear_page_dirty);
>  
>  /*
> + * As above, but redirties page if any dirty ptes are found (and then only
> + * if the mapping accounts dirty pages, otherwise dirty ptes are left dirty
> + * but the page is cleaned).
> + */
> +int test_clear_page_dirty_sync_ptes(struct page *page)
> +{
> +	struct address_space *mapping = page_mapping(page);
> +
> +	if (test_clear_page_dirty_leave_ptes(page)) {
> +		if (mapping_cap_account_dirty(mapping)) {
> +			if (page_mkclean(page))
> +				set_page_dirty(page);
> +		}
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +/*
>   * Clear a page's dirty flag, while caring for dirty memory accounting.
>   * Returns true if the page was previously dirty.
>   *

Hmm, not quite; It certainly look better than the extra ,[01] tagged to
test_clear_page_dirty() though. Although I would have expected it the
other way around - test_clear_pages_dirty_sync_ptes to be the default
case and test_clear_pages_dirty_clean_ptes to be used in
clear_page_dirty_for_io().

Anyway it has the same issues as the others. See what happens when you
run two test_clear_page_dirty_sync_ptes() consecutively, you still loose
PG_dirty even though the page might actually be dirty.



