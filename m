Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUCLUPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUCLUOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:14:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19099 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262493AbUCLUDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:03:02 -0500
Date: Fri, 12 Mar 2004 21:02:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040312200253.GA16880@suse.de>
References: <20040311083619.GH6955@suse.de> <1079121113.4181.189.camel@watt.suse.com> <20040312120322.0108a437.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312120322.0108a437.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12 2004, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > During a mixed load test including fsx-linux and a bunch of procs
> > running cp/read/rm loops, I got a null pointer deref with the call
> > trace:
> > 
> > __lock_page->sync_page->block_sync_page
> > 
> > I don't see how we can trust page->mapping in this path, can't it
> > disappear?  If so, it would be a bug without Jens' patch too, just
> > harder to hit.
> 
> yup.  I wonder why you hit it now.
> 
> diff -puN fs/buffer.c~per-backing_dev-unplugging-block_sync_page-fix fs/buffer.c
> --- 25/fs/buffer.c~per-backing_dev-unplugging-block_sync_page-fix	Fri Mar 12 11:59:37 2004
> +++ 25-akpm/fs/buffer.c	Fri Mar 12 12:00:20 2004
> @@ -2928,7 +2928,10 @@ EXPORT_SYMBOL(try_to_free_buffers);
>  
>  int block_sync_page(struct page *page)
>  {
> -	blk_run_address_space(page->mapping);
> +	struct address_space *mapping = page->mapping;
> +
> +	if (mapping)
> +		blk_run_address_space(mapping);
>  	return 0;
>  }
>  
> 
> This should be sufficient.  All callers of lock_page() should have a ref on
> the inode so ->mapping should be stable even if truncate whips the page off
> the inode.

blk_run_address_space() already checks for mapping == NULL, so the above
cannot make any difference.

-- 
Jens Axboe

