Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263289AbVCEAhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbVCEAhN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbVCEA2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:28:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263183AbVCEAXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:23:35 -0500
Date: Fri, 4 Mar 2005 16:23:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11-mm1 "nobh" support for ext3 writeback mode
Message-Id: <20050304162331.4a7dfdb8.akpm@osdl.org>
In-Reply-To: <1109980952.7236.39.camel@dyn318077bld.beaverton.ibm.com>
References: <1109980952.7236.39.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> @@ -1646,13 +1659,34 @@ static int ext3_block_truncate_page(hand
>  	unsigned blocksize, iblock, length, pos;
>  	struct inode *inode = mapping->host;
>  	struct buffer_head *bh;
> -	int err;
> +	int err = 0;
>  	void *kaddr;
>  
>  	blocksize = inode->i_sb->s_blocksize;
>  	length = blocksize - (offset & (blocksize - 1));
>  	iblock = index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
>  
> +	if (test_opt(inode->i_sb, NOBH) && !page_has_buffers(page)) {
> +		if (!PageUptodate(page)) {
> +			err = mpage_readpage(page, ext3_get_block);
> +			if ((err == 0) && !PageUptodate(page))
> +				wait_on_page_locked(page);
> +			lock_page(page);
> +		}
> +		if (err == 0 && PageUptodate(page)) {
> +			kaddr = kmap_atomic(page, KM_USER0);
> +			memset(kaddr + offset, 0, length);
> +			flush_dcache_page(page);
> +			kunmap_atomic(kaddr, KM_USER0);
> +			set_page_dirty(page);
> +			goto unlock;
> +		}
> +		/* 

What's all this doing?  (It needs comments please - it's very unobvious).

Dropping and reacquiring the page lock in the middle of the truncate there
is a bit of a worry - need to think about that.

Err, yes, it's buggy - page reclaim can come in, grab the page lock and
whip the page off the mapping.  We end up with an anonymous page and we
then start trying to write it into the file and all sorts of things.


This bit:

			if ((err == 0) && !PageUptodate(page))
				wait_on_page_locked(page);

can simply be removed.  We're about to lock the page anyway.
