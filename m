Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWAWFim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWAWFim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWAWFil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:38:41 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:48263 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S964803AbWAWFil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:38:41 -0500
Date: Sun, 22 Jan 2006 22:38:38 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sho@tnes.nec.co.jp, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] ext3: Extends blocksize up to pagesize
Message-ID: <20060123053838.GM4124@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, sho@tnes.nec.co.jp,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp> <20060118185249.GN4124@schatzie.adilger.int> <20060120231016.40b40fd7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120231016.40b40fd7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 20, 2006  23:10 -0800, Andrew Morton wrote:
> Andreas Dilger <adilger@clusterfs.com> wrote:
> >
> > On Jan 18, 2006  22:06 +0900, Takashi Sato wrote:
> > > As a disk tends to get large, a disk storage has had a capacity to
> > > supply multi-TB.  But now, ext3 can't support more than 8TB filesystem
> > > when blocksize is 4KB.  That's why I think ext3 needs to be
> > > more than 8TB.
> > > 
> > > Therefore I think filesystem size can increase on architectures
> > > which has more than 4KB pagesize by extending blocksize to pagesize on
> > > ext3.  For example, the following is in case of ia64.  (Blocksize have
> > > already been supported up to pagesize on ext2. Why is the max blocksize
> > > restricted to 4KB on ext3?)
> > > 
> > > Max filesystem size on ia64:
> > > Original                                   :4096(blocksize) * 2^31 =  8TB
> > > After modification [pagesize=16KB(default)]:16384(blocksize) * 2^31 = 32TB
> > > After modification [pagesize=64KB(max)]    :65536(blocksize) * 2^31 = 128TB
> > 
> > Just for others' info - the fill_super change has been tested in the past
> > by Sonny Rao at IBM also.  e2fsprogs has supported this for a long time
> > already.
> 
> I have a vague memory that there's some piece of metadata (per-block-group
> info, I think) which will overflow at 8kb blocksize.  I say this in the
> hope that you'll remmeber what it was ;)

This is the group descriptor per-group blocks and inode free counts.  The
current mke2fs code limits the number of blocks and inodes per group to
EXT2_MAX_BLOCKS_PER_GROUP (2^16 - 8) and (2^16 - EXT2_INODES_PER_BLOCK)
so that this won't overflow.  We still get linear growth of filesystem
limits with blocksize, but not cubic growth that would otherwise be there.

Bull has a patch which enlarges the group descriptor fields to allow
more blocks and inodes per group.

> I've rewritten ext3 directory readahead to use the generic pagecache
> functions, so changes here shouldn't be needed.
> 
> But I haven't yet got around to performance-testing it.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm2/broken-out/ext3_readdir-use-generic-readahead.patch

Hmm, I'll have to take a look at that when I get a chance.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

