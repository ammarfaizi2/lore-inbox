Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVGZXDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVGZXDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVGZW4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:56:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27615 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262318AbVGZWzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:55:43 -0400
Subject: Re: [RFC] [PATCH 2/4]delayed allocation for ext3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, ext2-devel@lists.sourceforge.net, sct@redhat.com,
       lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       suparna@in.ibm.com, tytso@mit.edu
In-Reply-To: <20050726155212.750200d3.akpm@osdl.org>
References: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
	 <1121622041.4609.25.camel@localhost.localdomain>
	 <20050726155212.750200d3.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 15:55:27 -0700
Message-Id: <1122418527.6433.66.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 15:52 -0700, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > Here is the updated patch from Badari for delayed allocation for ext3.
> > Delayed allocation defers block allocation from prepare-write time to
> > page writeout time. 
> 
> For data=writeback only, yes?

Yes.

> 
> > ...
> > --- linux-2.6.12/fs/ext3/inode.c~ext3-delalloc	2005-07-14 23:15:34.866752480 -0700
> > +++ linux-2.6.12-ming/fs/ext3/inode.c	2005-07-14 23:15:34.889748984 -0700
> > @@ -1340,6 +1340,9 @@ static int ext3_prepare_write(struct fil
> >  	handle_t *handle;
> >  	int retries = 0;
> >  
> > +
> > +	if (test_opt(inode->i_sb, DELAYED_ALLOC))
> > +		return __nobh_prepare_write(page, from, to, ext3_get_block, 0);
> 
> Rather than performing this test on each ->prepare_write(), would it not be
> better to set up a new set of address_space_operations for this mode?
> 
> __nobh_prepare_write() seems like a poor choice of name?

You are correct. I was trying to minimize the changes to interfaces.
Once we get it working, I will do it as part of cleanups.

> 
> >  retry:
> >  	handle = ext3_journal_start(inode, needed_blocks);
> >  	if (IS_ERR(handle)) {
> > @@ -1439,6 +1442,9 @@ static int ext3_writeback_commit_write(s
> >  	else
> >  		ret = generic_commit_write(file, page, from, to);
> >  
> > +	if (test_opt(inode->i_sb, DELAYED_ALLOC))
> > +		return ret;
> > +
> 
> Here too, perhaps.
> 
> > +		}
> > +	}
> >  	/*
> >  	 * The journal_load will have done any necessary log recovery,
> >  	 * so we can safely mount the rest of the filesystem now.
> > diff -puN fs/buffer.c~ext3-delalloc fs/buffer.c
> > --- linux-2.6.12/fs/buffer.c~ext3-delalloc	2005-07-14 23:15:34.875751112 -0700
> > +++ linux-2.6.12-ming/fs/buffer.c	2005-07-14 23:15:34.903746856 -0700
> > @@ -2337,8 +2337,8 @@ static void end_buffer_read_nobh(struct 
> >   * On entry, the page is fully not uptodate.
> >   * On exit the page is fully uptodate in the areas outside (from,to)
> >   */
> > -int nobh_prepare_write(struct page *page, unsigned from, unsigned to,
> > -			get_block_t *get_block)
> > +int __nobh_prepare_write(struct page *page, unsigned from, unsigned to,
> > +			get_block_t *get_block, int create)
> 
> Suggest you make this static and update the comment.
> 

Sure.

> >  {
> >  	struct inode *inode = page->mapping->host;
> >  	const unsigned blkbits = inode->i_blkbits;
> > @@ -2370,10 +2370,8 @@ int nobh_prepare_write(struct page *page
> >  		  block_start < PAGE_CACHE_SIZE;
> >  		  block_in_page++, block_start += blocksize) {
> >  		unsigned block_end = block_start + blocksize;
> > -		int create;
> >  
> >  		map_bh.b_state = 0;
> > -		create = 1;
> >  		if (block_start >= to)
> >  			create = 0;
> >  		ret = get_block(inode, block_in_file + block_in_page,
> 
> What's going on here?  Seems that we'll call get_block() with `create=0'. 
> Is there any point in doing that?  For delayed allocation we shuld be able
> to skip get_block() altogether here and, err, delay it.

For delayed allocation, I need to delay the block allocation - but I
still need to do get_block(READ) and read the data from the block - if
the block already exists.

> 
> > +int nobh_prepare_write(struct page *page, unsigned from, unsigned
> > + 				get_block_t *get_block)
> > +{
> > +	return __nobh_prepare_write(page, from, to, get_block, 1);
> > +}
> > +
> > EXPORT_SYMBOL(nobh_prepare_write);
> 
> Here you add nobh_dalloc_prepare_write() and remember to export it to
> modules this time ;)
> 

Will do.

Thanks,
Badari

