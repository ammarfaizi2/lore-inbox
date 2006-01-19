Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbWASSKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWASSKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWASSKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:10:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:30412 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161093AbWASSKU (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Thu, 19 Jan 2006 13:10:20 -0500
Date: Thu, 19 Jan 2006 19:10:07 +0100
From: Nick Piggin <npiggin@suse.de>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 2/4] mm: PageLRU no testset
Message-ID: <20060119181007.GC6564@wotan.suse.de>
References: <20060118024106.10241.69438.sendpatchset@linux.site> <20060118024128.10241.82524.sendpatchset@linux.site> <17359.53508.481749.294382@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17359.53508.481749.294382@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 08:48:52PM +0300, Nikita Danilov wrote:
> Nick Piggin writes:
>  > PG_lru is protected by zone->lru_lock. It does not need TestSet/TestClear
>  > operations.
>  > 
>  > Signed-off-by: Nick Piggin <npiggin@suse.de>
>  > 
>  > Index: linux-2.6/mm/vmscan.c
>  > ===================================================================
>  > --- linux-2.6.orig/mm/vmscan.c
>  > +++ linux-2.6/mm/vmscan.c
>  > @@ -775,9 +775,10 @@ int isolate_lru_page(struct page *page)
>  >  	if (PageLRU(page)) {
>  >  		struct zone *zone = page_zone(page);
>  >  		spin_lock_irq(&zone->lru_lock);
>  > -		if (TestClearPageLRU(page)) {
>  > +		if (PageLRU(page)) {
>  >  			ret = 1;
>  >  			get_page(page);
>  > +			ClearPageLRU(page);
> 
> Why is that better? ClearPageLRU() is also "atomic" operation (in the
> sense of using LOCK_PREFIX on x86), so it seems this change strictly
> adds cycles to the hot-path when page is on LRU.
> 

Less restrictive memory ordering requirements.

Nick
 
