Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135617AbRDSK7Y>; Thu, 19 Apr 2001 06:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135619AbRDSK7P>; Thu, 19 Apr 2001 06:59:15 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:21514 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S135617AbRDSK7K>; Thu, 19 Apr 2001 06:59:10 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: phillips@nl.linux.org, riel@conectiva.com.br
Subject: Re: Ext2 Directory Index - Delete Performance
Cc: adilger@turbolinux.com, ext2-devel@lists.sourceforge.net,
        jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Message-Id: <20010419105540Z92314-11602+5@humbolt.nl.linux.org>
Date: Thu, 19 Apr 2001 12:55:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Thu, 19 Apr 2001, Daniel Phillips wrote:
> > Jan Harkes wrote:
> > > On Thu, Apr 19, 2001 at 02:27:48AM +0200, Daniel Phillips wrote:
> > > > more memory.  If you have enough memory, the inode cache won't thrash,
> > > > and even when it does, it does so gracefully - performance falls off
> > > > nice and slowly.  For example, 250 Meg of inode cache will handle 2
> > > > million inodes with no thrashing at all.
> > >
> > > What inode cache are you talking about? According to the slabinfo output
> > > on my machine every inode takes up 480 bytes in the inode_cache slab. So
> > > 250MB is only able to hold about half a million inodes in memory.
> >
> > Sorry, I was a little loose with terminology there.  I should have
> > said "inode blocks in cache".  The inode cache is related.  When an
> > Ext2 inode is pushed out of the inode cache it gets transfered to a
> > dirty block in memory, where it shrinks to 128 bytes and shares the
> > block with 31 other inodes.  These blocks are in the buffer cache, and
> > this is the cache I'm talking about.
> 
> Hmmm, considering this, it may be wise to limit the amount of
> inodes in the inode cache to, say, 10% of RAM ... because we
> can cache MORE inodes if we store them in the buffer cache
> instead!

Yes, one struct inode is worth 3.5 buffer cache inodes.  The expense of
converting the inode via read_inode and update_inode is pretty small.  To
come up with a balancing formula, we should consider:

  - Ratio between struct inode size and inode disk image size
  - CPU cost of converting an inode disk image to struct inode
  - CPU cost of converting a struct inode to a disk image
  - average time to read, write a block of N inodes.
  - Load on memory
  - Bandwidth of disk, heaviness of disk traffic
  - Other factors I forgot

Or we could just set the inode cache size lower and see what happens. :-)

--
Daniel
