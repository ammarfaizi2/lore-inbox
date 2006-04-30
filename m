Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWD3Lia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWD3Lia (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 07:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWD3Lia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 07:38:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56387 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751099AbWD3Lia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 07:38:30 -0400
Date: Sun, 30 Apr 2006 13:39:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Chinner <dgc@sgi.com>, Christoph Lameter <clameter@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060430113905.GF23137@suse.de>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261130450.19587@schroedinger.engr.sgi.com> <20060426114737.239806a2.akpm@osdl.org> <20060426184945.GL5002@suse.de> <Pine.LNX.4.64.0604261330310.20897@schroedinger.engr.sgi.com> <20060428140146.GA4657648@melbourne.sgi.com> <44548834.5050204@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44548834.5050204@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30 2006, Nick Piggin wrote:
> @@ -407,19 +422,10 @@
>  	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
>  
>  	if (error == 0) {
> -		write_lock_irq(&mapping->tree_lock);
> -		error = radix_tree_insert(&mapping->page_tree, offset, page);
> -		if (!error) {
> -			page_cache_get(page);
> -			SetPageLocked(page);
> -			page->mapping = mapping;
> -			page->index = offset;
> -			mapping->nrpages++;
> -			pagecache_acct(1);
> -		}
> -		write_unlock_irq(&mapping->tree_lock);
> +		error = __add_to_page_cache(page, mapping, offset);
>  		radix_tree_preload_end();
>  	}
> +
>  	return error;

You killed a lock too many there. I'm sure it'd help scalability,
though :-)

-- 
Jens Axboe

