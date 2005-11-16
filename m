Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVKPSBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVKPSBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVKPSBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:01:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030291AbVKPSBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:01:15 -0500
Date: Wed, 16 Nov 2005 10:00:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Message-Id: <20051116100053.44d81ae2.akpm@osdl.org>
In-Reply-To: <1132163057.8811.15.camel@lade.trondhjem.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	<1132163057.8811.15.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Wed, 2005-11-16 at 07:01 -0800, Kenny Simpson wrote:
> > --- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > > Anyhow, does the following patch help?
> > 
> > Unfortunately, not:
> > 
> > samples  %        symbol name
> > 545009   15.2546  find_get_pages_tag
> 
> Argh... I totally missed the point there with the last patch. We should
> be resyncing the page tag with the value of the PG_dirty flag...
> 
> OK, please back out the patch that I sent you, and try this one instead.
> 
> ...
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 8f71e76..61ec355 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -213,6 +213,7 @@ static int nfs_writepage_sync(struct nfs
>  	} while (count);
>  	/* Update file length */
>  	nfs_grow_file(page, offset, written);
> +	clear_page_dirty_tag(page);
>  	/* Set the PG_uptodate flag? */
>  	nfs_mark_uptodate(page, offset, written);
>
> ....  
> +int clear_page_dirty_tag(struct page *page)
> +{
> +	struct address_space *mapping = page_mapping(page);
> +
> +	if (mapping) {
> +		unsigned long flags;
> +
> +		write_lock_irqsave(&mapping->tree_lock, flags);
> +		if (!PageDirty(page))
> +			radix_tree_tag_clear(&mapping->page_tree,
> +						page_index(page),
> +						PAGECACHE_TAG_DIRTY);
> +		write_unlock_irqrestore(&mapping->tree_lock, flags);
> +	}
> +}

That will fix it, but the PageWriteback accounting is still wrong.

Is it not possible to use set_page_writeback()/end_page_writeback()?

Are these pages marked "unstable" at this time?
