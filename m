Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUABFoy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 00:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUABFoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 00:44:54 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:38277 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262925AbUABFow
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 00:44:52 -0500
Date: Fri, 2 Jan 2004 11:20:20 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-ID: <20040102055020.GA3410@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031231091828.GA4012@in.ibm.com> <20031231013521.79920efd.akpm@osdl.org> <20031231095503.GA4069@in.ibm.com> <20031231015913.34fc0176.akpm@osdl.org> <20031231100949.GA4099@in.ibm.com> <20031231021042.5975de04.akpm@osdl.org> <20031231104801.GB4099@in.ibm.com> <20031231025309.6bc8ca20.akpm@osdl.org> <20031231025410.699a3317.akpm@osdl.org> <20031231031736.0416808f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231031736.0416808f.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 03:17:36AM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Let me actually think about this a bit.
> 
> Nasty.  The same race is present in 2.4.x...
> 
> How's about we start new I/O in filemap_fdatawait() if the page is dirty?
> 

Makes sense to me.
There's a chance that this could explain why Daniel saw exposures even 
with his fix. 

Would be interesting to see his results with your patch.

Though we might as well plug this anyway ?

> 
> diff -puN mm/filemap.c~a mm/filemap.c
> --- 25/mm/filemap.c~a	2003-12-31 03:10:29.000000000 -0800
> +++ 25-akpm/mm/filemap.c	2003-12-31 03:17:05.000000000 -0800
> @@ -206,7 +206,13 @@ restart:
>  		page_cache_get(page);
>  		spin_unlock(&mapping->page_lock);
>  
> -		wait_on_page_writeback(page);
> +		lock_page(page);
> +		if (PageDirty(page) && mapping->a_ops->writepage) {
> +			write_one_page(page, 1);
> +		} else {
> +			wait_on_page_writeback(page);
> +			unlock_page(page);

Would we lose anything if we unlock_page() before wait_on_page_writeback() ?
I was thinking about the corresponding fix in sync_page_range, and it
would make life easier for retry based fs-AIO if we could move the
unlock_page before the wait.

> +		}
>  		if (PageError(page))
>  			ret = -EIO;
>  
> 
> 

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

