Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSFTKV0>; Thu, 20 Jun 2002 06:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSFTKVZ>; Thu, 20 Jun 2002 06:21:25 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:37102 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313314AbSFTKVZ>; Thu, 20 Jun 2002 06:21:25 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 20 Jun 2002 04:18:12 -0600
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
       Christopher Li <chrisl@gnuchina.org>,
       Alexander Viro <viro@math.psu.edu>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020620101812.GL22427@clusterfs.com>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Christopher Li <chrisl@gnuchina.org>,
	Alexander Viro <viro@math.psu.edu>, DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <E17KoGz-0000y5-00@starship> <20020620103429.A2464@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620103429.A2464@redhat.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 20, 2002  10:34 +0100, Stephen C. Tweedie wrote:
> On Thu, Jun 20, 2002 at 12:49:57AM +0200, Daniel Phillips wrote:
> > I don't have code, but let me remind you of this post:
> > 
> >    http://marc.theaimsgroup.com/?l=ext2-devel&m=102132142032096&w=2
> > 
> > A sketch of the coalescing design is at the end.  I'll formalize that.
> 
> One question --- just how stable will this be if we boot into a kernel
> that doesn't have the coalescing enabled, and start modifying
> directories?  We _could_ just teach the current code to clear those
> top 8 bits in the parent any time we touch a leaf node, but that's
> unnecessarily expensive, so we'd really need to have some way of
> either recreating the hint fields from scratch every so often, or of
> spotting when they have become badly out-of-date.

Three notes:
1) Coalescing isn't necessarily the same as just discarding empty
   blocks.  We can do the latter much more easily, and without the
   hint bits at all, but it won't work unless a block is totally
   empty, so you could still approach 0% fullness with huge directories.

2) The hint bits are meant to be intentionally vague (i.e. only a hint)
   so there is no need to keep them 100% up-to-date.  If it turns out
   that you modify a directory with a kernel that does not understand
   coalescing it is fairly benign.  The worst that would happen is that
   you get an empty leaf block (assuming you don't even have the simple
   support for dropping empty blocks), or you try to coalesce with such
   a block and find it too full to do the merge, so you update the hint
   again with the correct value.  Over the normal course of operations
   you would be updating the hints for each block anyways, so invalid
   hints would be cleaned out from the index.
   
To avoid extra overhead from writing out the parent each time you delete
an entry from the leaf, you could update the values all of the time
(you had to have read the parent to find the correct leaf block), but
not mark the block dirty, so the updated hints are only written to disk
if there is another reason to write out the block (e.g. split/coalesce
of a leaf block).

Having a large number of bits of hint info would not necessarily be
useful.  In Daniel's "1-bit hint" example, the actual worst-case fullness
could _approach_ 25%, but you would always drop 100% empty blocks
immediately, so it would never quite get there.

With 2 bits of hint, you would probably only merge if the sum of the two
neighbours was <= 3 (i.e. 75% fullness for a single block), because you
don't necessarily want to be merging blocks to be almost 100% full and
then splitting them again.  This would give a worst-case fullness between
37.5% and 75% at any time, which isn't really so bad given the performance
implications of repeated merge+truncate+allocate+split operations.

Remember also that each leaf block merge will incur a copy from the tail
block (which may need to be read from disk) and then a truncate to drop
that block.  We _could_ leave some number of empty dir blocks at the end
of the directory file if we had some sort of dir prealloc scheme happening.
There would be some amount of hysteresis there to avoid the repeated
alloc/free overhead (i.e. keep no more than 8 free blocks, but allocate
8 blocks at a time if you need more).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

