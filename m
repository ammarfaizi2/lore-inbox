Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbWBTWAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWBTWAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWBTWAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:00:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54195 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932629AbWBTWAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:00:17 -0500
Date: Tue, 21 Feb 2006 08:59:53 +1100
From: Nathan Scott <nathans@sgi.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, jeremy@sgi.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
Message-ID: <20060221085953.H9484650@wobbly.melbourne.sgi.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>; from pbadari@us.ibm.com on Mon, Feb 20, 2006 at 01:21:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:21:27PM -0800, Badari Pulavarty wrote:
> Hi,

Hi Badari,

> Following patches add support to map multiple blocks in ->get_block().
> This is will allow us to handle mapping of multiple disk blocks for
> mpage_readpages() and mpage_writepages() etc. Instead of adding new
> argument, I use "b_size" to indicate the amount of disk mapping needed
> for get_block(). And also, on success get_block() actually indicates
> the amount of disk mapping it did.

Thanks for doing this work!

> Now that get_block() can handle multiple blocks, there is no need
> for ->get_blocks() which was added for DIO. 
> 
> [PATCH 1/3] pass b_size to ->get_block()
> 
> [PATCH 2/3] map multiple blocks for mpage_readpages()
> 
> [PATCH 3/3] remove ->get_blocks() support
> 
> I noticed decent improvements (reduced sys time) on JFS, XFS and ext3. 
> (on simple "dd" read tests).
> 	
>          (rc3.mm1)	(rc3.mm1 + patches)
> real    0m18.814s	0m18.482s
> user    0m0.000s	0m0.004s
> sys     0m3.240s	0m2.912s
> 
> Andrew, Could you include it in -mm tree ?
> 
> Comments ?

I've been running these patches in my development tree for awhile
and have not seen any problems.  My one (possibly minor) concern
is that we pass get_block a size in units of bytes, e.g....

	bh->b_size = 1 << inode->i_blkbits;
	err = get_block(inode, block, bh, 1);

And b_size is a u32.  We have had the situation in the past where
people (I'm looking at you, Jeremy ;) have been issuing multiple-
gigabyte direct reads/writes through XFS.  The syscall interface
takes an (s)size_t in bytes, which on 64 bit platforms is a 64 bit
byte count.

I wonder if this change will end up ruining things for the lunatic
fringe issuing these kinds of IOs?  Maybe the get_block call could
take a block count rather than a byte count?  (I guess that would
equate to dropping get_block_t rather than get_blocks_t... which is
kinda the alternate direction to what you took here).  On the other
hand, maybe it'd be simpler to change b_size to be a size_t instead
of u32?  Although, since we are now mapping multiple blocks at once,
"get_blocks_t" does seem an appropriate name.  *shrug*, whatever ...
the main thing that'd be good to see addressed is the 32 bit size.

cheers.

-- 
Nathan
