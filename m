Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWBTTIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWBTTIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWBTTIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:08:04 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:17280 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932628AbWBTTID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:08:03 -0500
Date: Mon, 20 Feb 2006 20:08:55 +0100
From: Mattia Dongili <malattia@linux.it>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH] mm: Implement swap prefetching
Message-ID: <20060220190855.GB4414@inferi.kami.home>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
References: <200602210044.52424.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602210044.52424.kernel@kolivas.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc3-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Con,

On Tue, Feb 21, 2006 at 12:44:51AM +1100, Con Kolivas wrote:
> Unchanged heavily tested v27 implementation of swap prefetching resynced with
> 2.6.16-rc4-mm1.

I used your patches in the last 2 or 3 -mm kernels (since s-p-v24). It's
been working good until now.

> Please consider for -mm.

Just one minor note:
[...]
> Index: linux-2.6.16-rc4-mm1/mm/swap.c
> ===================================================================
> --- linux-2.6.16-rc4-mm1.orig/mm/swap.c	2006-02-21 00:38:56.000000000 +1100
> +++ linux-2.6.16-rc4-mm1/mm/swap.c	2006-02-21 00:39:25.000000000 +1100
> @@ -384,6 +384,46 @@ void __pagevec_lru_add_active(struct pag
>  	pagevec_reinit(pvec);
>  }
>  
> +static inline void __pagevec_lru_add_tail(struct pagevec *pvec)
> +{
> +	int i;
> +	struct zone *zone = NULL;
> +
> +	for (i = 0; i < pagevec_count(pvec); i++) {
> +		struct page *page = pvec->pages[i];
> +		struct zone *pagezone = page_zone(page);
> +
> +		if (pagezone != zone) {
> +			if (zone)
> +				spin_unlock_irq(&zone->lru_lock);
> +			zone = pagezone;
> +			spin_lock_irq(&zone->lru_lock);
> +		}
> +		if (TestSetPageLRU(page))
> +			BUG();

TestSetPageLRU is gone in -mm (see mm-pagelru-no-testset.patch), you
should probably change it to

		BUG_ON(PageLRU(page));
		SetPageLRU(page);

ciao
-- 
mattia
:wq!
