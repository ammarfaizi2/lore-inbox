Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWIEVTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWIEVTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWIEVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:19:44 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56212 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750792AbWIEVTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:19:42 -0400
Subject: Re: BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Badari Pulavarty <pbadari@gmail.com>, Will Simoneau <simoneau@ele.uri.edu>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <44FDDA89.7080207@us.ibm.com>
References: <20060905171049.GB27433@ele.uri.edu>
	 <1157479756.23501.18.camel@dyn9047017100.beaverton.ibm.com>
	 <1157482632.19432.6.camel@kleikamp.austin.ibm.com>
	 <44FDDA89.7080207@us.ibm.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 16:19:39 -0500
Message-Id: <1157491179.19432.11.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 13:14 -0700, Badari Pulavarty wrote:
> Dave Kleikamp wrote:

> > I'm having a hard time figuring out exactly what ext3_get_blocks_handle
> > is trying to return, but it looks to me like if it is allocating one
> > data block, and needs to allocate an indirect block as well, then it
> > will return 2 rather than 1.  Is this expected, or am I just confused?
> >
> >   
> 
> It would return "1" in that case.. (data block)
> 
>  > 0 means get_block() suceeded and indicates the number of blocks mapped
> = 0 lookup failed
> < 0 mean error case

Okay, I got confused looking through the code.  I still don't see how
ext3_get_blocks_handle() should be returning a number greater than
maxblocks.

> >> I did search for callers of ext3_get_blocks_handle() and found that
> >> ext3_readdir() seems to do wrong thing all the time with error check :(
> >> Need to take a closer look..
> >>
> >> 	err = ext3_get_blocks_handle(NULL, inode, blk, 1,
> >>                                                 &map_bh, 0, 0);
> >>         if (err > 0) {  <<<< BAD
> >>                   page_cache_readahead(sb->s_bdev->bd_inode->i_mapping,
> >>                                 &filp->f_ra,
> >>                                 filp,
> >>                                 map_bh.b_blocknr >>
> >>                                 (PAGE_CACHE_SHIFT - inode->i_blkbits),
> >>                                 1);
> >>                         bh = ext3_bread(NULL, inode, blk, 0, &err);
> >>        }
> >>     
> >
> > Bad to do what it's doing, or bad to call name the variable "err"?
> > I think if it looked like this:
> >
> > 	count = ext3_get_blocks_handle(NULL, inode, blk, 1,
> >                                                 &map_bh, 0, 0);
> >         if (count > 0) { 
> >
> > it would be a lot less confusing.
> >   
> I am sorry !! it is doing the right thing :(

Not your fault.  The variable is very badly named.
-- 
David Kleikamp
IBM Linux Technology Center

