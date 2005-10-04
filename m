Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932732AbVJDAis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbVJDAis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 20:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVJDAis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 20:38:48 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:51840 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932736AbVJDAiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 20:38:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=dt+Gwnw+AwDtyFAzJ3tKuPbJpI7UpFba6IUOfShyDnqsyMEjhN7g9l+LxWDiDBlEIKwwswtTPYlS21PHdlqfWpiqoMhVjoifU6ajWKNtvu9UAf4fu/aTtty8IQZhkRQAtRxWcfGE49dinBwIFmEgpfNE3+Kl0x5jfXN/W5YACok=  ;
Subject: Re: [patch] zone_watermark_ok() rework
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Coywolf Qi Hunt <coywolf@sosdg.org>
Cc: kernel@kolivas.org, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051003174131.GA2865@gmail.com>
References: <20051003174131.GA2865@gmail.com>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 10:38:14 +1000
Message-Id: <1128386294.12501.7.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 01:41 +0800, Coywolf Qi Hunt wrote:
> Hello,
> 
> In zone_watermark_ok(), the original algorithm seems not logical. This is a
> rework. Comments?
> 
> 		Coywolf
> 
> 
> Signed-off-by: Coywolf Qi Hunt <coywolf@sosdg.org>
> ---
> 
>  page_alloc.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> --- 2.6.14-rc2-mm1/mm/page_alloc.c~orig	2005-09-29 20:37:07.000000000 +0800
> +++ 2.6.14-rc2-mm1/mm/page_alloc.c	2005-10-04 01:19:31.000000000 +0800
> @@ -772,7 +772,7 @@
>  int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
>  		      int classzone_idx, int can_try_harder, int gfp_high)
>  {
> -	/* free_pages my go negative - that's OK */
> +	/* free_pages may go negative - that's OK */
>  	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
>  	int o;
>  

Typo. Thanks.

> @@ -783,17 +783,12 @@
>  
>  	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
>  		return 0;
> -	for (o = 0; o < order; o++) {
> -		/* At the next order, this order's pages become unavailable */
> -		free_pages -= z->free_area[o].nr_free << o;
>  
> -		/* Require fewer higher order pages to be free */
> -		min >>= 1;
> -
> -		if (free_pages <= min)
> -			return 0;
> +	for (o = order; o < MAX_ORDER; o++) {
> +		if (z->free_area[o].nr_free)
> +			return 1;
>  	}
> -	return 1;
> +	return 0;
>  }
>  
>  static inline int

Well the original algorithm's intention is to include some watermarks
for higher order pages for eg. GFP_ATOMIC and PF_MEMALLOC. To that
goal I believe the algorithm is logical?

Yours is correct if our intention was simply to ensure _any_ higher
order page is available, however it is also redundant because rmqueue
will catch that for us. However, that is not the intention :)

Any reasons why it should be changed?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
