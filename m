Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269327AbUINM6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269327AbUINM6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269330AbUINM6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:58:34 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:1646 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269327AbUINMzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:55:32 -0400
Message-ID: <4146EA3E.4010804@yahoo.com.au>
Date: Tue, 14 Sep 2004 22:55:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
References: <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu>
In-Reply-To: <20040914114228.GD2804@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> --- linux/mm/vmscan.c.orig	
> +++ linux/mm/vmscan.c	
> @@ -361,6 +361,8 @@ static int shrink_list(struct list_head 
>  		int may_enter_fs;
>  		int referenced;
>  
> +		cond_resched();
> +
>  		page = lru_to_page(page_list);
>  		list_del(&page->lru);
>  
> @@ -710,6 +712,7 @@ refill_inactive_zone(struct zone *zone, 
>  		reclaim_mapped = 1;
>  
>  	while (!list_empty(&l_hold)) {
> +		cond_resched();
>  		page = lru_to_page(&l_hold);
>  		list_del(&page->lru);
>  		if (page_mapped(page)) {


Could these ones go up a level? We break down scanning into 32 page
chunks, so I don't think it needs to be checked every page.

in shrink_zone(), maybe stick them:

         while (nr_active || nr_inactive) {
                 if (nr_active) {
---> here
                         sc->nr_to_scan = min(nr_active,
                                         (unsigned long)SWAP_CLUSTER_MAX);
                         nr_active -= sc->nr_to_scan;
                         refill_inactive_zone(zone, sc);
                 }

                 if (nr_inactive) {
---> and here
                         sc->nr_to_scan = min(nr_inactive,
                                         (unsigned long)SWAP_CLUSTER_MAX);
                         nr_inactive -= sc->nr_to_scan;
                         shrink_cache(zone, sc);
                         if (sc->nr_to_reclaim <= 0)
                                 break;
                 }
         }

Does that work for you?
