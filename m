Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUEQIjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUEQIjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 04:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUEQIjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 04:39:45 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:6294 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S264934AbUEQIjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 04:39:41 -0400
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
	s->tree' failed: The saga continues.)
From: Vladimir Saveliev <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040517004626.4377a496.akpm@osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
	 <20040517022816.GA14939@work.bitmover.com>
	 <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
	 <200405162136.24441.elenstev@mesatop.com>
	 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
	 <20040517002506.34022cb8.akpm@osdl.org>
	 <20040517004626.4377a496.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1084783179.1430.37.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 17 May 2004 12:39:40 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Mon, 2004-05-17 at 11:46, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> >  If an application does mmap(MAP_SHARED) of, say, a 2048 byte file and then
> >  extends it:
> > 
> >  	p = mmap(..., fd, ...);
> >  	ftructate(fd, 4096);
> >  	p[3000] = 1;
> > 
> >  A racing block_write_full_page() could fail to notice the extended i_size
> >  and would decide to zap those 2048 bytes anyway.
> 
> This should plug it.
> 
> diff -puN mm/memory.c~ftruncate-vs-block_write_full_page mm/memory.c
> --- 25/mm/memory.c~ftruncate-vs-block_write_full_page	2004-05-17 00:33:07.060231368 -0700
> +++ 25-akpm/mm/memory.c	2004-05-17 00:41:00.924193096 -0700
> @@ -1208,6 +1208,8 @@ int vmtruncate(struct inode * inode, lof
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	unsigned long limit;
> +	loff_t i_size;
> +	struct page *page;
>  
>  	if (inode->i_size < offset)
>  		goto do_expand;
> @@ -1222,8 +1224,22 @@ do_expand:
>  		goto out_sig;
>  	if (offset > inode->i_sb->s_maxbytes)
>  		goto out;
> -	i_size_write(inode, offset);
>  
> +	/*
> +	 * If there is a pagecache page at the current i_size we need to lock
> +	 * it while modifying i_size to synchronise against
> +	 * block_write_full_page()'s sampling of i_size.  Otherwise
> +	 * block_write_full_page may decide to memset part of this page after
> +	 * the application extended the file size.
> +	 */

Don't down-ings i_sem in do_truncate and in generic_file_write take care
of this kind of race?

> +	i_size = inode->i_size;	/* don't need i_size_read() due to i_sem */
> +	page = NULL;
> +	if (i_size & (PAGE_CACHE_SIZE - 1))
> +		page = find_lock_page(inode->i_mapping,
> +				i_size >> PAGE_CACHE_SHIFT);
> +	i_size_write(inode, offset);
> +	if (page)
> +		unlock_page(page);
>  out_truncate:
>  	if (inode->i_op && inode->i_op->truncate)
>  		inode->i_op->truncate(inode);
> 
> _
> 
> The same could happen with a pwrite() in place of ftruncate:
> 
> 	fd = open("2048-byte-file");
> 	p = mmap(..., MAP_SHARED, fd, ...);
> 	pwrite(fd, buf, 1, 4096);
> 	p[3000] = 1;
> 
> But I doubt that bk does extending writes() against a file which is
> concurrently being modified via MAP_SHARED.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

