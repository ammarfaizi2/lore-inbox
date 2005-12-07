Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVLGKc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVLGKc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVLGKc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:32:58 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:29575 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750806AbVLGKc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:32:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OrrmaXQsL116hh6U/V935RZnq/jcEak7BJFdPUA8sKldpHJe71TBcedEiXbkdnxcp+2Ca7d6+aCRxfjjjJKWQE/j1y5uixUsOjyZ0y0CMjjbie/fC8VzpYcyKRIYjkqij6AgCzPMbZn7eMVRQHCYx5rODxwScwHjeKfUCuPVDw0=  ;
Message-ID: <4396BA55.8080502@yahoo.com.au>
Date: Wed, 07 Dec 2005 21:32:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 13/16] mm: fix minor scan count bugs
References: <20051207104755.177435000@localhost.localdomain> <20051207105209.818705000@localhost.localdomain>
In-Reply-To: <20051207105209.818705000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> - in isolate_lru_pages(): reports one more scan. Fix it.
> - in shrink_cache(): 0 pages taken does not mean 0 pages scanned. Fix it.
> 

This looks good, although in the first hunk it might be nicer
to turn it into the more familiar for-loop.

   for (scan = 0; scan < nr_to_scan && !list_empty(src); scan++) {

> Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
> ---
> 
>  mm/vmscan.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> --- linux.orig/mm/vmscan.c
> +++ linux/mm/vmscan.c
> @@ -864,7 +864,8 @@ static int isolate_lru_pages(int nr_to_s
>  	struct page *page;
>  	int scan = 0;
>  
> -	while (scan++ < nr_to_scan && !list_empty(src)) {
> +	while (scan < nr_to_scan && !list_empty(src)) {
> +		scan++;
>  		page = lru_to_page(src);
>  		prefetchw_prev_lru_page(page, src, flags);
>  
> @@ -911,14 +912,15 @@ static void shrink_cache(struct zone *zo
>  	update_zone_age(zone, nr_scan);
>  	spin_unlock_irq(&zone->lru_lock);
>  
> -	if (nr_taken == 0)
> -		return;
> -
>  	sc->nr_scanned += nr_scan;
>  	if (current_is_kswapd())
>  		mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
>  	else
>  		mod_page_state_zone(zone, pgscan_direct, nr_scan);
> +
> +	if (nr_taken == 0)
> +		return;
> +
>  	nr_freed = shrink_list(&page_list, sc);
>  	if (current_is_kswapd())
>  		mod_page_state(kswapd_steal, nr_freed);
> 

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
