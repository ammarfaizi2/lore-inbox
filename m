Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUHFK26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUHFK26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 06:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUHFK26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 06:28:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16595 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268119AbUHFK24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 06:28:56 -0400
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
From: Ram <linuxram@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <411322E8.4000503@yahoo.com.au>
References: <Pine.LNX.4.44.0408052104420.2241-100000@dyn319181.beaverton.ibm.com>
	 <411322E8.4000503@yahoo.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1091789269.1425.38.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Aug 2004 03:47:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 23:19, Nick Piggin wrote:
> Ram Pai wrote:
> 
> > 
> > there is a check in __do_page_cache_readahead()  that validates this.
> > But it is still not guaranteed to work correctly against races. 
> > 
> > The filesystem has to handle such out-of-bound requests gracefully.
> > 
> > However with Nick's fix in do_generic_mapping_read() the filesystem 
> > is gauranteed to be called with out-of-bound index, if the file size 
> > is a multiple of 4k. Without the fix, the filesystem might get
> > called with out-of-bound index only in racy conditions.
> > 
> 
> How's this?

If I understand your patch correctly: it takes care of files whose size
is 0 bytes, but not files of size 4k bytes or 8k bytes. or .. n*4k bytes

I think the original check that you removed should be reverted back and
the additional check that you introduced should remain.

RP
> 
> ---
> 
>  linux-2.6-npiggin/mm/filemap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN mm/filemap.c~fs-fix mm/filemap.c
> --- linux-2.6/mm/filemap.c~fs-fix	2004-08-06 16:16:26.000000000 +1000
> +++ linux-2.6-npiggin/mm/filemap.c	2004-08-06 16:18:22.000000000 +1000
> @@ -716,9 +716,9 @@ void do_generic_mapping_read(struct addr
>  	offset = *ppos & ~PAGE_CACHE_MASK;
>  
>  	isize = i_size_read(inode);
> -	end_index = isize >> PAGE_CACHE_SHIFT;
> -	if (index > end_index)
> +	if (*ppos >= isize)
>  		goto out;
> +	end_index = isize >> PAGE_CACHE_SHIFT;
>  
>  	for (;;) {
>  		struct page *page;
> 
> _

