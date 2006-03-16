Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbWCPTnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWCPTnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWCPTnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:43:46 -0500
Received: from silver.veritas.com ([143.127.12.111]:32678 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932683AbWCPTnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:43:45 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,198,1139212800"; 
   d="scan'208"; a="35988970:sNHT22912540"
Date: Thu, 16 Mar 2006 19:44:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Race in pagevec_strip?
In-Reply-To: <Pine.LNX.4.64.0603161056270.2518@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0603161934220.24837@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0603161033120.2395@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603161056270.2518@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 19:43:45.0335 (UTC) FILETIME=[EFE0CC70:01C64931]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Christoph Lameter wrote:
> Sigh. TestSetPackLocked works just opposite of spin_trylock. So add an !
> 
> 
> Seems that we can call try_to_release_page with PagePrivate off and a 
> valid mapping? This may cause all sorts of trouble for the 
> filesystem *_releasepage() handlers. XFS bombs out in that case.

I think you're right, and you are consistent with the sequence when
try_to_release_page is called from elsewhere.

But the last time I had anything to do with try_to_release_page was
way back in 2.5.mid, I don't think there was a pagevec_strip then.
Andrew will know better.

I can't see what protects the default drop_buffers case against this,
so can't argue that it's an XFS problem.

But wouldn't you, on balance, be better off repeating the
PagePrivate test within the lock?

		if (PagePrivate(page) && !TestSetPageLocked(page)) {
			if (PagePrivate(page))
				try_to_release_page(page, 0);
			unlock_page(page);
		}

>  
> Lock the page before checking for page private.
>  
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.16-rc6/mm/swap.c
> ===================================================================
> --- linux-2.6.16-rc6.orig/mm/swap.c	2006-03-11 14:12:55.000000000 -0800
> +++ linux-2.6.16-rc6/mm/swap.c	2006-03-16 10:15:23.000000000 -0800
> @@ -392,8 +392,9 @@ void pagevec_strip(struct pagevec *pvec)
>  	for (i = 0; i < pagevec_count(pvec); i++) {
>  		struct page *page = pvec->pages[i];
>  
> -		if (PagePrivate(page) && !TestSetPageLocked(page)) {
> -			try_to_release_page(page, 0);
> +		if (!TestSetPageLocked(page)) {
> +			if (PagePrivate(page))
> +				try_to_release_page(page, 0);
>  			unlock_page(page);
>  		}
>  	}
