Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422986AbWJFVuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422986AbWJFVuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422988AbWJFVuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:50:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31947 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422986AbWJFVuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:50:04 -0400
Message-ID: <4526CF6F.9040006@RedHat.com>
Date: Fri, 06 Oct 2006 17:49:35 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <Trond.Myklebust@netapp.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
References: <1160170629.5453.34.camel@lade.trondhjem.org>
In-Reply-To: <1160170629.5453.34.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> If try_to_release_page() is called with a zero gfp mask, then the
> filesystem is effectively denied the possibility of sleeping while
> attempting to release the page. There doesn't appear to be any valid
> reason why this should be banned, given that we're not calling this from
> a memory allocation context.
>  
> For this reason, change the gfp_mask argument of the call to GFP_KERNEL.
>     
> Note: I am less sure of what the callers of invalidate_complete_page()
> require, and so this patch does not touch that mask.
> 
> Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> ---
> diff --git a/mm/truncate.c b/mm/truncate.c
> index f4edbc1..49c1ffd 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -302,7 +302,7 @@ invalidate_complete_page2(struct address
>  	if (page->mapping != mapping)
>  		return 0;
>  
> -	if (PagePrivate(page) && !try_to_release_page(page, 0))
> +	if (PagePrivate(page) && !try_to_release_page(page, GFP_KERNEL))
>  		return 0;
>  
>  	write_lock_irq(&mapping->tree_lock);
Well I was using mapping_gfp_mask(mapping) as the argument to
try_to_release_page() which also worked... but isn't this
just plugging one of many holes? Meaning try_to_release_page is called
from a number of places with a zero gfp_mask so shouldn't those
also be fixed as well OR removed the gfp_mask as an argument as the
comment at the top of try_to_release_page() alludes to?

steved.

