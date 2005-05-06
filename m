Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVEFKOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVEFKOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 06:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVEFKOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 06:14:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34003 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261201AbVEFKOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 06:14:38 -0400
Date: Fri, 6 May 2005 12:14:34 +0200
From: Jan Kara <jack@suse.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Cliff White <cliffw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2 + rc3: reaim with ext3 - system stalls.
Message-ID: <20050506101434.GC25677@atrey.karlin.mff.cuni.cz>
References: <20050421152345.6b87aeae@es175> <20050503144325.GF4501@atrey.karlin.mff.cuni.cz> <1115132463.26913.828.camel@dyn318077bld.beaverton.ibm.com> <E1DTMKq-00043x-BO@es175> <1115315827.26913.907.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115315827.26913.907.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Badari!

> I have an extremely simple patch to fix the problem.
> Basically, move the journal_start_handle from writepages()
> to ext3_writepages_get_block() (which gets called after locking
> the page). What am I missing here ? The patch can't
> be that simple :(
  Umm. I think this change does not help much - you solve the problem
for the first page but then you unlock that page and you'd like to lock
the next one and you're again in trouble (trying to acquire PageLock
wile holding transaction open).
  I can see three solutions of the problem:
Either do ext3_journal_start/stop for each page - you should be actually
getting the handle of the same transaction until the transaction gets
filled. But still you'll have some overhead of the calls in JBD. I
actually don't see much difference to the approach we used before your
patch but probably there's some.
  Or rewrite __mpage_writepages() to lock a page range (e.g. lock pages
until we find some on which we'd block) and then call some filesystem
routine to write-out all the locked pages (which would start a
transaction and so on). But this is more work.
  Finally there's the theoretical ;) possibility to rewrite all the
write-out code and change the lock ordering to journal->PageLock...

								Honza

> On Wed, 2005-05-04 at 09:02, Cliff White wrote:
> > > 
> > > --=-LBuZsEP+un6vb/N1S6Yo
> > > Content-Type: text/plain
> > > Content-Transfer-Encoding: 7bit
> > > 
> > > On Tue, 2005-05-03 at 07:43, Jan Kara wrote:
> > > >   Hello,
> > > > 
> > > > > Started seeing some odd behaviour with recent kernels, haven't been able 
> > > to
> > > > > run it down, could use some suggestions/help.
> > > > > 
> > > > > Running re-aim7 with 2.6.12-rc2 and rc3, if I use xfs, jfs, or
> > > > > reiserfs things work just fine.
> > > > > 
> > > > > With ext3, the  test stalls, such that:
> > > > > CPU is 50% idle, 50% waiting IO (top)
> > > > > vmstat shows one process blocked wio
> > > >   I've looked through your dumps and I spotted where is the problem -
> > > > it's our well known and beloved lock inversion between PageLock and
> > > > transaction start (giving CC to Badari who's the author of the patch
> > > > that introduced it AFAIK).
> > > 
> > > Yuck. It definitely not intentional.
> > > 
> > > >   The correct order is: first get PageLock and *then* start transaction.
> > > > But in ext3_writeback_writepages() first ext3_journal_start() is called
> > > > and then __mpage_writepages is called that tries to do LockPage and
> > > > deadlock is there. Badari, could you please fix that (sadly I think that
> > > > would not be easy)? Maybe we should back out those changes until it gets
> > > > fixed...
> > > 
> > > Hmm.. let me take a closer look. You are right, its not going to be
> > > simple fix.
> > > 
> > > Cliff, here is the patch to backout writepages() for ext3. Can you
> > > verify that problems goes away with this patch ?
> > > 
> > I can now verify that the problem is not there with Badari's no-writepages
> > patch  - all the runs last night completed, performance is about what it was
> > for 2.6.12-rc1.
> > cliffw
> 

> --- linux-2.6.12-rc3.org/fs/ext3/inode.c	2005-05-02 22:28:30.000000000 -0700
> +++ linux-2.6.12-rc3/fs/ext3/inode.c	2005-05-05 00:09:59.000000000 -0700
> @@ -869,6 +869,14 @@ get_block:
>  static int ext3_writepages_get_block(struct inode *inode, sector_t iblock,
>  			struct buffer_head *bh, int create)
>  {
> +	handle_t *handle = journal_current_handle();
> +
> +	if (!handle) {
> +		handle = ext3_journal_start(inode, 
> +				ext3_writepage_trans_blocks(inode));
> +		if (IS_ERR(handle)) 
> +			return PTR_ERR(handle);
> +	}
>  	return ext3_direct_io_get_blocks(inode, iblock, 1, bh, create);
>  }
>  
> @@ -1360,24 +1368,10 @@ ext3_writeback_writepages(struct address
>  	handle_t *handle = NULL;
>  	int err, ret = 0;
>  
> -	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> -		return ret;
> -
> -	handle = ext3_journal_start(inode, ext3_writepage_trans_blocks(inode));
> -	if (IS_ERR(handle)) {
> -		ret = PTR_ERR(handle);
> -		return ret;
> -	}
> -
>          ret = __mpage_writepages(mapping, wbc, ext3_writepages_get_block,
>  					ext3_writeback_writepage_helper);
>  
> -	/*
> -	 * Need to reaquire the handle since ext3_writepages_get_block()
> -	 * can restart the handle
> -	 */
>  	handle = journal_current_handle();
> -
>  	err = ext3_journal_stop(handle);
>  	if (!ret)
>  		ret = err;

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
