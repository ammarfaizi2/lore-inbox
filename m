Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWBTXE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWBTXE7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWBTXE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:04:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:39852 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964810AbWBTXE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:04:58 -0500
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and
	mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nathan Scott <nathans@sgi.com>
Cc: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, jeremy@sgi.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20060221085953.H9484650@wobbly.melbourne.sgi.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060221085953.H9484650@wobbly.melbourne.sgi.com>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 15:06:11 -0800
Message-Id: <1140476772.22756.28.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 08:59 +1100, Nathan Scott wrote:
> On Mon, Feb 20, 2006 at 01:21:27PM -0800, Badari Pulavarty wrote:
> > Hi,
> 
> Hi Badari,
> 
> > Following patches add support to map multiple blocks in ->get_block().
> > This is will allow us to handle mapping of multiple disk blocks for
> > mpage_readpages() and mpage_writepages() etc. Instead of adding new
> > argument, I use "b_size" to indicate the amount of disk mapping needed
> > for get_block(). And also, on success get_block() actually indicates
> > the amount of disk mapping it did.
> 
> Thanks for doing this work!
> 
> > Now that get_block() can handle multiple blocks, there is no need
> > for ->get_blocks() which was added for DIO. 
> > 
> > [PATCH 1/3] pass b_size to ->get_block()
> > 
> > [PATCH 2/3] map multiple blocks for mpage_readpages()
> > 
> > [PATCH 3/3] remove ->get_blocks() support
> > 
> > I noticed decent improvements (reduced sys time) on JFS, XFS and ext3. 
> > (on simple "dd" read tests).
> > 	
> >          (rc3.mm1)	(rc3.mm1 + patches)
> > real    0m18.814s	0m18.482s
> > user    0m0.000s	0m0.004s
> > sys     0m3.240s	0m2.912s
> > 
> > Andrew, Could you include it in -mm tree ?
> > 
> > Comments ?
> 
> I've been running these patches in my development tree for awhile
> and have not seen any problems.  My one (possibly minor) concern
> is that we pass get_block a size in units of bytes, e.g....
> 
> 	bh->b_size = 1 << inode->i_blkbits;
> 	err = get_block(inode, block, bh, 1);
> 
> And b_size is a u32.  We have had the situation in the past where
> people (I'm looking at you, Jeremy ;) have been issuing multiple-
> gigabyte direct reads/writes through XFS.  The syscall interface
> takes an (s)size_t in bytes, which on 64 bit platforms is a 64 bit
> byte count.

> I wonder if this change will end up ruining things for the lunatic
> fringe issuing these kinds of IOs?  Maybe the get_block call could
> take a block count rather than a byte count?  

Yes. I thought about it too.. I wanted to pass "block count" instead
of "byte count". Right now it does ..

	bh->b_size = 1 << inode->i_blkbits;
	call get_block();

First thing get_block() does is
	blocks = bh->b_size >> inode->i_blkbits;

All, the unnecessary shifting around for nothing :(

But, I ended up doing "byte count" just to avoid confusion of
asking in "blocks" getting back in "bytes".

I have no problem making b_size as "size_t" to handle 64-bit.
But again, if we are fiddling with buffer_head - may be its time
to look at alternative to "buffer_head" with the information exactly 
we need for getblock() ?

Thanks,
Badari

