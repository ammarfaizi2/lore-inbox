Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbVCEAns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbVCEAns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbVCEAiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:38:05 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:26576 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263524AbVCEAcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:32:00 -0500
Subject: Re: [PATCH] 2.6.11-mm1 "nobh" support for ext3 writeback mode
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304162331.4a7dfdb8.akpm@osdl.org>
References: <1109980952.7236.39.camel@dyn318077bld.beaverton.ibm.com>
	 <20050304162331.4a7dfdb8.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1109982557.7236.65.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Mar 2005 16:29:17 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 16:23, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > @@ -1646,13 +1659,34 @@ static int ext3_block_truncate_page(hand
> >  	unsigned blocksize, iblock, length, pos;
> >  	struct inode *inode = mapping->host;
> >  	struct buffer_head *bh;
> > -	int err;
> > +	int err = 0;
> >  	void *kaddr;
> >  
> >  	blocksize = inode->i_sb->s_blocksize;
> >  	length = blocksize - (offset & (blocksize - 1));
> >  	iblock = index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
> >  
> > +	if (test_opt(inode->i_sb, NOBH) && !page_has_buffers(page)) {
> > +		if (!PageUptodate(page)) {
> > +			err = mpage_readpage(page, ext3_get_block);
> > +			if ((err == 0) && !PageUptodate(page))
> > +				wait_on_page_locked(page);
> > +			lock_page(page);
> > +		}
> > +		if (err == 0 && PageUptodate(page)) {
> > +			kaddr = kmap_atomic(page, KM_USER0);
> > +			memset(kaddr + offset, 0, length);
> > +			flush_dcache_page(page);
> > +			kunmap_atomic(kaddr, KM_USER0);
> > +			set_page_dirty(page);
> > +			goto unlock;
> > +		}
> > +		/* 
> 
> What's all this doing?  (It needs comments please - it's very unobvious).

All its trying to do is - to make sure the page is uptodate so that
it can zero out the portion thats needed. 

I can do getblock() and ll_rw_block(READ) instead. I was
trying to re-use the code and mpage_readpage() drops the lock.
What do you think ?


> 
> Dropping and reacquiring the page lock in the middle of the truncate there
> is a bit of a worry - need to think about that.
> 
> Err, yes, it's buggy - page reclaim can come in, grab the page lock and
> whip the page off the mapping.  We end up with an anonymous page and we
> then start trying to write it into the file and all sorts of things.
> 
> 
> This bit:
> 
> 			if ((err == 0) && !PageUptodate(page))
> 				wait_on_page_locked(page);
> 
> can simply be removed.  We're about to lock the page anyway.


Thanks,
Badari

