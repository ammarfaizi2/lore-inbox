Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUCLUnJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbUCLUfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:35:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9380 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262454AbUCLUe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:34:59 -0500
Date: Fri, 12 Mar 2004 21:34:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040312203452.GD16880@suse.de>
References: <20040311083619.GH6955@suse.de> <1079121113.4181.189.camel@watt.suse.com> <20040312120322.0108a437.akpm@osdl.org> <20040312200253.GA16880@suse.de> <1079123647.4186.211.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079123647.4186.211.camel@watt.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12 2004, Chris Mason wrote:
> On Fri, 2004-03-12 at 15:02, Jens Axboe wrote:
> > On Fri, Mar 12 2004, Andrew Morton wrote:
> > > Chris Mason <mason@suse.com> wrote:
> > > >
> > > > During a mixed load test including fsx-linux and a bunch of procs
> > > > running cp/read/rm loops, I got a null pointer deref with the call
> > > > trace:
> > > > 
> > > > __lock_page->sync_page->block_sync_page
> > > > 
> > > > I don't see how we can trust page->mapping in this path, can't it
> > > > disappear?  If so, it would be a bug without Jens' patch too, just
> > > > harder to hit.
> 
> Here's my guess, it took a few hours to trigger the first time, so it'll
> be a while before I can say if it makes a difference.  I'm not convinced
> this will help, but it's all I can think of so far...
> 
> -chris
> 
> Index: linux.t/fs/buffer.c
> ===================================================================
> --- linux.t.orig/fs/buffer.c	2004-03-12 13:13:45.000000000 -0500
> +++ linux.t/fs/buffer.c	2004-03-12 15:21:44.635262192 -0500
> @@ -2939,7 +2939,10 @@ EXPORT_SYMBOL(try_to_free_buffers);
>  
>  int block_sync_page(struct page *page)
>  {
> -	blk_run_address_space(page->mapping);
> +	struct address_space *mapping;
> +	smp_mb();
> +	mapping = page->mapping;
> +	blk_run_address_space(mapping);
>  	return 0;
>  }
>  
> Index: linux.t/mm/filemap.c
> ===================================================================
> --- linux.t.orig/mm/filemap.c	2004-03-12 13:13:45.000000000 -0500
> +++ linux.t/mm/filemap.c	2004-03-12 15:23:00.216089824 -0500
> @@ -121,8 +121,10 @@ void remove_from_page_cache(struct page 
>  
>  static inline int sync_page(struct page *page)
>  {
> -	struct address_space *mapping = page->mapping;
> -
> +	struct address_space *mapping;
> +	
> +	smp_mb();
> +	mapping = page->mapping;
>  	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
>  		return mapping->a_ops->sync_page(page);
>  	return 0;

I don't see how this can make too much of a difference, aside of perhaps
just moving the window a little. If page->mapping can disappear here,
that's still a possibility.

-- 
Jens Axboe

