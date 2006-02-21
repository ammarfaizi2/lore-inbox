Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWBUQCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWBUQCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWBUQCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:02:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:15005 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932145AbWBUQCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:02:41 -0500
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and
	mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Nathan Scott <nathans@sgi.com>, christoph <hch@lst.de>, mcao@us.ibm.com,
       akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20060221024108.GA251337@sgi.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060221085953.H9484650@wobbly.melbourne.sgi.com>
	 <20060221024108.GA251337@sgi.com>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 08:03:54 -0800
Message-Id: <1140537834.22756.42.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 18:41 -0800, Jeremy Higdon wrote:
> On Tue, Feb 21, 2006 at 08:59:53AM +1100, Nathan Scott wrote:
> > On Mon, Feb 20, 2006 at 01:21:27PM -0800, Badari Pulavarty wrote:
> > 
> > I've been running these patches in my development tree for awhile
> > and have not seen any problems.  My one (possibly minor) concern
> > is that we pass get_block a size in units of bytes, e.g....
> > 
> > 	bh->b_size = 1 << inode->i_blkbits;
> > 	err = get_block(inode, block, bh, 1);
> > 
> > And b_size is a u32.  We have had the situation in the past where
> > people (I'm looking at you, Jeremy ;) have been issuing multiple-
> > gigabyte direct reads/writes through XFS.  The syscall interface
> > takes an (s)size_t in bytes, which on 64 bit platforms is a 64 bit
> > byte count.
> > 
> > I wonder if this change will end up ruining things for the lunatic
> > fringe issuing these kinds of IOs?  Maybe the get_block call could
> 
> Hey!  Lunatic fringe indeed.  Harumph!  :-)
> 
> Yes, there are a few people out there who will need to issue really
> large I/O reads or writes to get maximum I/O bandwidth on large
> stripes.  The largest I've done so far is 4GiB, but I expect that
> number will likely increase this year, and more likely next year,
> if not.

Thinking more about it, currently (without my patches) only DIO
code can request for large chunks of mapping through get_blocks().
Since b_size is only u32, you can only map 4GB max. Isn't it ?
With my patches, now mpage_readpages() also can request large
chunks. (through readahead). So, my patches are not adding any
extra limitation. Its carrying the same existing limitation. 

In order to handle larger chunks of disk mapping, changing b_size 
to u64 is required and we should request for it irrespective of my
patches.

Thanks,
Badari

