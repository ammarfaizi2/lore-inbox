Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSFTNrA>; Thu, 20 Jun 2002 09:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSFTNq7>; Thu, 20 Jun 2002 09:46:59 -0400
Received: from dsl-213-023-043-172.arcor-ip.net ([213.23.43.172]:30876 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314475AbSFTNq6>;
	Thu, 20 Jun 2002 09:46:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Date: Thu, 20 Jun 2002 15:45:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christopher Li <chrisl@gnuchina.org>, Alexander Viro <viro@math.psu.edu>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <20020620103429.A2464@redhat.com> <20020620101812.GL22427@clusterfs.com>
In-Reply-To: <20020620101812.GL22427@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17L2G0-00019Q-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 June 2002 12:18, Andreas Dilger wrote:
> On Jun 20, 2002  10:34 +0100, Stephen C. Tweedie wrote:
> > One question --- just how stable will this be if we boot into a kernel
> > that doesn't have the coalescing enabled, and start modifying
> > directories?  We _could_ just teach the current code to clear those
> > top 8 bits in the parent any time we touch a leaf node, but that's
> > unnecessarily expensive, so we'd really need to have some way of
> > either recreating the hint fields from scratch every so often, or of
> > spotting when they have become badly out-of-date.
> 
> Three notes:
> 1) Coalescing isn't necessarily the same as just discarding empty
>    blocks.  We can do the latter much more easily, and without the
>    hint bits at all, but it won't work unless a block is totally
>    empty, so you could still approach 0% fullness with huge directories.

And in the accidental-untar case that started this thread, Raul would
have the same complaint: a directory bloats up and never unbloats
until completely emptied.

> 2) The hint bits are meant to be intentionally vague (i.e. only a hint)
>    so there is no need to keep them 100% up-to-date.  If it turns out
>    that you modify a directory with a kernel that does not understand
>    coalescing it is fairly benign.  The worst that would happen is that
>    you get an empty leaf block (assuming you don't even have the simple
>    support for dropping empty blocks), or you try to coalesce with such
>    a block and find it too full to do the merge, so you update the hint
>    again with the correct value.  Over the normal course of operations
>    you would be updating the hints for each block anyways, so invalid
>    hints would be cleaned out from the index.

To state it another way: when the fullness hint is wrong, it's an
underestimate.  The self-correcting mechanism you described is exactly
what I had in mind.

> To avoid extra overhead from writing out the parent each time you delete
> an entry from the leaf, you could update the values all of the time
> (you had to have read the parent to find the correct leaf block), but
> not mark the block dirty, so the updated hints are only written to disk
> if there is another reason to write out the block (e.g. split/coalesce
> of a leaf block).

Hmm, so if the VM discards the unmarked dirty index block then on
reread the fullness estimate becomes an overestimate and we could, in
rare circumstances, end up with mergable blocks that never get merged.
Since we're touching the index block (set PG_Referenced), this might
be a very rare occurance indeed.

Another way to achieve a similar effect is to set the fullness to an
underestimate on delete, by rounding down to some smaller number of
hint bits than we actually have available, and set it to an accurate
estimate only on a failed merge (to prevent repeated unsuccessful
merge attempts).  This way, several deletes can take place before we
need to update the index block.  Say we round down to 5 bits on delete,
then on a 4K block we can delete 128 bytes, or 6-7 entries, before
having to update the estimate.  This gives us 85% of the benefit in
terms of reducing index block dirties while only slightly increasing
the chance of a failed merge.

So let me see, the purpose of recording the fullness bits in the
index block in the first place is to save CPU (probing the index
and scanning dirent blocks) and the occasional read.  The cost is
extra complexity in the algorithm, and some extra index block writes.
Did we win?  I think we did, and significantly, but the analysis
isn't good enough yet to quantify that.

> Having a large number of bits of hint info would not necessarily be
> useful.  In Daniel's "1-bit hint" example, the actual worst-case fullness
> could _approach_ 25%, but you would always drop 100% empty blocks
> immediately, so it would never quite get there.
>
> With 2 bits of hint, you would probably only merge if the sum of the two
> neighbours was <= 3 (i.e. 75% fullness for a single block), because you
> don't necessarily want to be merging blocks to be almost 100% full and
> then splitting them again.  This would give a worst-case fullness between
> 37.5% and 75% at any time, which isn't really so bad given the performance
> implications of repeated merge+truncate+allocate+split operations.

Yes, provably containing worst case fullness at 50% would be entirely
satisfactory.  The current worst case, however rare it may be, is 0%.
I'm hoping for an average steady state fullness in the 70% range.

> Remember also that each leaf block merge will incur a copy from the tail
> block (which may need to be read from disk) and then a truncate to drop
> that block.  We _could_ leave some number of empty dir blocks at the end
> of the directory file if we had some sort of dir prealloc scheme happening.
> There would be some amount of hysteresis there to avoid the repeated
> alloc/free overhead (i.e. keep no more than 8 free blocks, but allocate
> 8 blocks at a time if you need more).

We could hope that the block allocation policy eventually improves to
the point where the preallocation is taken care of without the directory
subsystem needing to know about it.  On the other hand, if we do want
explicit preallocation at some point then we probably have to anticipate
it now for forward compatibility reasons.  I think we will be ok just by
building in enough split-merge hysteresis.

-- 
Daniel
