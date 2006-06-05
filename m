Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751386AbWFEUFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWFEUFB (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWFEUFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:05:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:65471 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751386AbWFEUFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:05:00 -0400
Date: Mon, 5 Jun 2006 22:06:52 +0200
From: Jan Kara <jack@suse.cz>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
Message-ID: <20060605200652.GC24342@atrey.karlin.mff.cuni.cz>
References: <200606051700.k55H015q004029@turing-police.cc.vt.edu> <1149528339.3111.114.camel@laptopd505.fenrus.org> <200606051920.k55JKQGx003031@turing-police.cc.vt.edu> <20060605193552.GB24342@atrey.karlin.mff.cuni.cz> <1149537156.3111.123.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149537156.3111.123.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > following confuses the code (and I agree that it's kind of ugly from
> > quota code to do that):
> >   i_mutex of inode containing quota file is acquired after all other
> > quota locks. i_mutex of all other inodes is acquired before quota locks.
> > Quota code makes sure (by resetting inode operations and setting special
> > flag on inode) that noone tries to enter quota code while holding
> > i_mutex on a quota file...
> 
> can you point this out in a bit more detail, eg where exactly is this
> happening? I think it is in this bit
>        /* As we bypass the pagecache we must now flush the inode so that
>          * we see all the changes from userspace... */
>         write_inode_now(inode, 1);
>         /* And now flush the block cache so that kernel sees the changes
> */
>         invalidate_bdev(sb->s_bdev, 0);
>         mutex_lock(&inode->i_mutex);
>         mutex_lock(&dqopt->dqonoff_mutex);
>         if (sb_has_quota_enabled(sb, type)) {
>                 error = -EBUSY;
>                 goto out_lock;
> 
> but that doesn't quite match your description...
  This piece of code is there just because we avoid page cache when
doing quota writes. That is a different story and should cause problems
with your lock checker.
  Standard way of running quota is:
- get i_mutex for data_inode
- write some data to data_inode
  - requires allocation -> calls DQUOT_ALLOC_SPACE
  - DQUOT_ALLOC_SPACE acquires some quota locks, decides it wants to
    write out quota structure (e.g. because we are journaling quota and
    must preserve quota integrity)
    - acquires dqio_sem, calls filesystem specific quota writing
      function - e.g. ext3_quota_write()
    - this function acquires i_mutex for quota file

I think this is the type of circle your checker has found.

								Honza
