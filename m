Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVBXTBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVBXTBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVBXTBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:01:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:56776 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261645AbVBXTB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:01:27 -0500
Subject: Re: [PATCH 4/4][RESEND] readahead: cleanup
	blockable_page_cache_readahead()
From: Ram <linuxram@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <421E2CE9.8B5E4DE7@tv-sign.ru>
References: <421E2CE9.8B5E4DE7@tv-sign.ru>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1109271683.6140.120.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Feb 2005 11:01:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, 
	I have verified the patches against my standard benchmarks
	and did not see any bad effects.

	Also I have reviewd the patch and it looked clean and correct.

RP

On Thu, 2005-02-24 at 11:37, Oleg Nesterov wrote:
> I think that do_page_cache_readahead() can be inlined
> in blockable_page_cache_readahead(), this makes the
> code a bit more readable in my opinion.
> 
> Also makes check_ra_success() static inline.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.11-rc5/mm/readahead.c~	2005-01-29 15:51:04.000000000 +0300
> +++ 2.6.11-rc5/mm/readahead.c	2005-01-29 16:37:05.000000000 +0300
> @@ -348,8 +348,8 @@ int force_page_cache_readahead(struct ad
>   * readahead isn't helping.
>   *
>   */
> -int check_ra_success(struct file_ra_state *ra, unsigned long nr_to_read,
> -				 unsigned long actual)
> +static inline int check_ra_success(struct file_ra_state *ra,
> +			unsigned long nr_to_read, unsigned long actual)
>  {
>  	if (actual == 0) {
>  		ra->cache_hit += nr_to_read;
> @@ -394,15 +394,11 @@ blockable_page_cache_readahead(struct ad
>  {
>  	int actual;
>  
> -	if (block) {
> -		actual = __do_page_cache_readahead(mapping, filp,
> -						offset, nr_to_read);
> -	} else {
> -		actual = do_page_cache_readahead(mapping, filp,
> -						offset, nr_to_read);
> -		if (actual == -1)
> -			return 0;
> -	}
> +	if (!block && bdi_read_congested(mapping->backing_dev_info))
> +		return 0;
> +
> +	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
> +
>  	return check_ra_success(ra, nr_to_read, actual);
>  }

