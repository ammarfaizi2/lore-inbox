Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWCaAdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWCaAdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWCaAdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:33:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750890AbWCaAdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:33:25 -0500
Date: Thu, 30 Mar 2006 16:35:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] splice: add support for SPLICE_F_MOVE flag
Message-Id: <20060330163544.72e50aab.akpm@osdl.org>
In-Reply-To: <200603302109.k2UL9ET0012970@hera.kernel.org>
References: <200603302109.k2UL9ET0012970@hera.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
>
> commit 5abc97aa25b2c41413b3a520faee83f2282d9f18
> tree 4ba13ae0e91f15d02986df7cdca5e9455212d7d4
> parent 5274f052e7b3dbd81935772eb551dfd0325dfa9d
> author Jens Axboe <axboe@suse.de> Thu, 30 Mar 2006 15:16:46 +0200
> committer Linus Torvalds <torvalds@g5.osdl.org> Fri, 31 Mar 2006 04:28:18 -0800
> 
> [PATCH] splice: add support for SPLICE_F_MOVE flag
> 
> This enables the caller to migrate pages from one address space page
> cache to another.  In buzz word marketing, you can do zero-copy file
> copies!
> 
> ...
>  
> +static int page_cache_pipe_buf_steal(struct pipe_inode_info *info,
> +				     struct pipe_buffer *buf)
> +{
> +	struct page *page = buf->page;
> +
> +	WARN_ON(!PageLocked(page));
> +	WARN_ON(!PageUptodate(page));
> +
> +	if (!remove_mapping(page_mapping(page), page))
> +		return 1;
> +
> +	if (PageLRU(page)) {
> +		struct zone *zone = page_zone(page);
> +
> +		spin_lock_irq(&zone->lru_lock);
> +		BUG_ON(!PageLRU(page));
> +		__ClearPageLRU(page);
> +		del_page_from_lru(zone, page);
> +		spin_unlock_irq(&zone->lru_lock);
> +	}
> +
> +	buf->stolen = 1;
> +	return 0;
> +}

hm.  There's a reason why it is no longer necessary to recheck PG_lru after
taking the zone->lock, but I'm too lazy to go back through the changelogs
and we seem to have forgotten to add comments, so I'll cc Nick instead ;)

I worry that the page might still be under writeback when we get here. 
Probably we'll get lucky because whoever is writing the page probably holds
a ref on it (BIOs will do this), but a wait_on_page_writeback() after
locking the page might be prudent.

>  static void page_cache_pipe_buf_unmap(struct pipe_inode_info *info,
>  				      struct pipe_buffer *buf)
>  {
> -	unlock_page(buf->page);
> +	if (!buf->stolen)
> +		unlock_page(buf->page);
>  	kunmap(buf->page);
>  }

There go our chances of ever getting rid of kmap().  Is it not feasible to
use atomic kmaps throughout this code?


