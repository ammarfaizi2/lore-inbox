Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVBZAOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVBZAOs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVBZAOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:14:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:41151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261153AbVBZAOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:14:45 -0500
Date: Fri, 25 Feb 2005 16:19:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] Fix panic in 2.6 with bounced bio and dm
Message-Id: <20050225161947.5fd6d343.akpm@osdl.org>
In-Reply-To: <1109351021.5014.10.camel@markh1.pdx.osdl.net>
References: <1109351021.5014.10.camel@markh1.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Haverkamp <markh@osdl.org> wrote:
>
> 
> Last September a fix was checked in for a memory leak problem in
> bounce_end_io causing the entire bio to be checked.  This ended up
> causing some dm cloned bios that had bounce buffers to free NULL pages
> because their bi_idx can be non-zero.   This patch skips NULL pages in
> the bio's bio_vec.  I'm not sure if this is the most optimal fix but I
> think that it is safe since bvec_alloc memsets the bio_vec to zero.
> 

Thanks, we should get fixed for 2.6.11.

It seems very weird for dm to be shoving NULL page*'s into the middle of a
bio's bvec array, so your fix might end up being a workaround pending a
closer look at what's going on in there.

> 
> ===== mm/highmem.c 1.55 vs edited =====
> --- 1.55/mm/highmem.c	2005-01-07 21:44:13 -08:00
> +++ edited/mm/highmem.c	2005-02-25 07:54:21 -08:00
> @@ -319,7 +319,7 @@
>  	 */
>  	__bio_for_each_segment(bvec, bio, i, 0) {
>  		org_vec = bio_orig->bi_io_vec + i;
> -		if (bvec->bv_page == org_vec->bv_page)
> +		if (!bvec->bv_page || bvec->bv_page == org_vec->bv_page)
>  			continue;
>  
>  		mempool_free(bvec->bv_page, pool);	
> 
> -- 
> Mark Haverkamp <markh@osdl.org>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
