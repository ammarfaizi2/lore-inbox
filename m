Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUH1FDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUH1FDz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 01:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUH1FDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 01:03:54 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:10374 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266650AbUH1FDu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 01:03:50 -0400
Subject: Re: data loss in 2.6.9-rc1-mm1
From: Ram Pai <linuxram@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Gergely Tamas <dice@mfa.kfki.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <41300B82.8080203@yahoo.com.au>
References: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain>
	 <1093640668.11648.50.camel@dyn319181.beaverton.ibm.com>
	 <41300B82.8080203@yahoo.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1093669312.11648.80.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Aug 2004 22:01:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 21:35, Nick Piggin wrote:
> Ram Pai wrote:
> > 
> > got it!  Everything got changed to the new convention except that
> > the calculation of 'nr' just before the check "nr <= offset" .
> > 
> > I have generated this patch which takes care of that and hence fixes the
> > data loss problem as well. I guess it is cleaner too. 
> > 
> > This patch is generated w.r.t 2.6.8.1. If everybody blesses this patch I
> > will forward it to Andrew.
> 
> It looks like it should be OK... but at what point does it become
> simpler to use my patch which just moves the original calculation
> up, and does it again if we have to ->readpage()?
> 
> (assuming you agree that it solves the problem)

I agree your patch also solves the problem.

Either way is fine. Even Hugh's patch almost does the same thing as
yours. The only advantage with my page is it does the calculation in
only one place and does not repeat it. Also I feel its more intuitive to
assume that index 0 covers range 0 to 4095 i.e index n covers range
n*PAGE_SIZE to ((n+1)*PAGE_SIZE)-1.  Currently the code assumes index 0
covers range 1 to 4096  i.e index n covers range (n*PAGE_SIZE)+1 to
(n+1)*PAGE_SIZE. 

this is the 4th time we are trying to nail down the same thing. We
better get it right this time. So any correct patch is ok with me.

RP 

 
> 
> 
> ______________________________________________________________________
> 
> 
> ---
> 
>  linux-2.6-npiggin/mm/filemap.c |   29 ++++++++++++++++++-----------
>  1 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff -puN mm/filemap.c~mm-gmr-fix mm/filemap.c
> --- linux-2.6/mm/filemap.c~mm-gmr-fix	2004-08-28 14:14:02.000000000 +1000
> +++ linux-2.6-npiggin/mm/filemap.c	2004-08-28 14:32:59.000000000 +1000
> @@ -724,6 +724,15 @@ void do_generic_mapping_read(struct addr
>  		struct page *page;
>  		unsigned long nr, ret;
>  
> +		/* nr is the maximum number of bytes to copy from this page */
> +		nr = PAGE_CACHE_SIZE;
> +		if (index == end_index) {
> +			nr = isize & ~PAGE_CACHE_MASK;
> +			if (nr <= offset)
> +				goto out;
> +		}
> +		nr = nr - offset;
> +
>  		cond_resched();
>  		page_cache_readahead(mapping, &ra, filp, index);
>  
> @@ -736,17 +745,6 @@ find_page:
>  		if (!PageUptodate(page))
>  			goto page_not_up_to_date;
>  page_ok:
> -		/* nr is the maximum number of bytes to copy from this page */
> -		nr = PAGE_CACHE_SIZE;
> -		if (index == end_index) {
> -			nr = isize & ~PAGE_CACHE_MASK;
> -			if (nr <= offset) {
> -				page_cache_release(page);
> -				goto out;
> -			}
> -		}
> -		nr = nr - offset;
> -
>  		/* If users can be writing to this page using arbitrary
>  		 * virtual addresses, take care about potential aliasing
>  		 * before reading the page on the kernel side.
> @@ -826,6 +824,15 @@ readpage:
>  			page_cache_release(page);
>  			goto out;
>  		}
> +		nr = PAGE_CACHE_SIZE;
> +		if (index == end_index) {
> +			nr = isize & ~PAGE_CACHE_MASK;
> +			if (nr <= offset) {
> +				page_cache_release(page);
> +				goto out;
> +			}
> +		}
> +		nr = nr - offset;
>  		goto page_ok;
>  
>  readpage_error:
> 
> _

