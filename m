Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVJOGS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVJOGS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 02:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVJOGS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 02:18:28 -0400
Received: from silver.veritas.com ([143.127.12.111]:62470 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751085AbVJOGS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 02:18:28 -0400
Date: Sat, 15 Oct 2005 07:17:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible memory ordering bug in page reclaim?
In-Reply-To: <4350776D.1060304@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0510150705240.22534@goblin.wat.veritas.com>
References: <4350776D.1060304@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Oct 2005 06:18:23.0515 (UTC) FILETIME=[3F0A36B0:01C5D150]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2005, Nick Piggin wrote:
> 
> Is there anything that prevents PageDirty from theoretically being
> speculatively loaded before page_count here? (see patch)
> 
> It would result in pagecache corruption in the following situation:
> 
> 1                                2
> find_get_page();
> write to page                    write_lock(tree_lock);
> SetPageDirty();                  if (page_count != 2
> put_page();                          || PageDirty())
> 
> Now I'm worried that 2 might see PageDirty *before* SetPageDirty in
                                  page->flags
> 1, and page_count *after* put_page in 1.

I think you're right.  But I'm the last person to ask
barrier/ordering questions of.  CC'ed Ben and Andrea.

Hugh

> --- linux-2.6.orig/mm/vmscan.c
> +++ linux-2.6/mm/vmscan.c
> @@ -511,7 +511,12 @@ static int shrink_list(struct list_head 
>  		 * PageDirty _after_ making sure that the page is freeable and
>  		 * not in use by anybody. 	(pagecache + us == 2)
>  		 */
> -		if (page_count(page) != 2 || PageDirty(page)) {
> +		if (page_count(page) != 2) {
> +			write_unlock_irq(&mapping->tree_lock);
> +			goto keep_locked;
> +		}
> +		smp_rmb();
> +		if (PageDirty(page)) {
>  			write_unlock_irq(&mapping->tree_lock);
>  			goto keep_locked;
>  		}
