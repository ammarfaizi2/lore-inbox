Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUIEFu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUIEFu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 01:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUIEFus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 01:50:48 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:36207 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266208AbUIEFuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 01:50:32 -0400
Message-ID: <413AA915.9060407@yahoo.com.au>
Date: Sun, 05 Sep 2004 15:50:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 2/3] alloc-order watermarks
References: <413AA7B2.4000907@yahoo.com.au> <413AA7F8.3050706@yahoo.com.au> <413AA841.1040003@yahoo.com.au>
In-Reply-To: <413AA841.1040003@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 2/3
> 
> 
> ------------------------------------------------------------------------
> 
> 
> 
> Move the watermark checking code into a single function. Extend it to account
> for the order of the allocation and the number of free pages that could satisfy
> such a request.
> 
> Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
> 
> 
> ---
> 
>  linux-2.6-npiggin/include/linux/mmzone.h |    2 +
>  linux-2.6-npiggin/mm/page_alloc.c        |   57 ++++++++++++++++++++-----------
>  2 files changed, 40 insertions(+), 19 deletions(-)
> 
> diff -puN mm/page_alloc.c~vm-alloc-order-watermarks mm/page_alloc.c
> --- linux-2.6/mm/page_alloc.c~vm-alloc-order-watermarks	2004-09-05 14:55:46.000000000 +1000
> +++ linux-2.6-npiggin/mm/page_alloc.c	2004-09-05 15:10:07.000000000 +1000
> @@ -676,6 +676,36 @@ buffered_rmqueue(struct zone *zone, int 
>  }
>  
>  /*
> + * Return the number of pages available for order 'order' allocations.
> + */

Sorry, stale comment. It actually returns 1 if free pages are above the
watermark, 0 otherwise.

> +int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
> +		int alloc_type, int can_try_harder, int gfp_high)
