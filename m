Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbVCEBmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbVCEBmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 20:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263512AbVCEBf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 20:35:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:20177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263630AbVCEBQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:16:53 -0500
Date: Fri, 4 Mar 2005 17:16:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11-mm1 "nobh" support for ext3 writeback mode
Message-Id: <20050304171651.013ff333.akpm@osdl.org>
In-Reply-To: <1109984528.7236.72.camel@dyn318077bld.beaverton.ibm.com>
References: <1109980952.7236.39.camel@dyn318077bld.beaverton.ibm.com>
	<20050304162331.4a7dfdb8.akpm@osdl.org>
	<1109982557.7236.65.camel@dyn318077bld.beaverton.ibm.com>
	<20050304164553.29811e8f.akpm@osdl.org>
	<1109984528.7236.72.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>  	iblock = index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);

It would still be nice to add a comment in here...

> +	if (test_opt(inode->i_sb, NOBH) && !page_has_buffers(page)) {
> +		if (!PageUptodate(page)) {
> +			struct buffer_head map_bh;
> +			bh = &map_bh;
> +			bh->b_state = 0;
> +			clear_buffer_mapped(bh);
> +			ext3_get_block(inode, iblock, bh, 0);
> +			if (!buffer_mapped(bh)) 
> +				goto unlock;
> +			err = -EIO;
> +			set_bh_page(bh, page, 0);
> +			bh->b_this_page = 0;
> +			bh->b_size = 1 << inode->i_blkbits;
> +			ll_rw_block(READ, 1, &bh);
> +			wait_on_buffer(bh);
> +			if (!buffer_uptodate(bh))
> +				goto unlock;
> +			SetPageMappedToDisk(page);
> +		}
> +		kaddr = kmap_atomic(page, KM_USER0);
> +		memset(kaddr + offset, 0, length);
> +		flush_dcache_page(page);
> +		kunmap_atomic(kaddr, KM_USER0);
> +		set_page_dirty(page);
> +		err = 0;
> +		goto unlock;
> +	}
> +	
>  	if (!page_has_buffers(page))
>  		create_empty_buffers(page, blocksize, 0);

Given that we're about to go add buffers to the page, why not do that
first, and use the page's own buffer_head rather than cooking up a local
one?  Then we can simply use sb_bread().

