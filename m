Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbREaVA3>; Thu, 31 May 2001 17:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263231AbREaVAS>; Thu, 31 May 2001 17:00:18 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:62991 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263228AbREaVAO>; Thu, 31 May 2001 17:00:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [Ext2-devel] [UPDATE] Directory index for ext2
Date: Thu, 31 May 2001 23:02:06 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
In-Reply-To: <200105311944.f4VJiIrK016421@webber.adilger.int>
In-Reply-To: <200105311944.f4VJiIrK016421@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <0105312302061N.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 May 2001 21:44, Andreas Dilger wrote:
> Daniel, you write:
> >   - Fall back to linear search in case of corrupted index
>
> OK, I have _some_ of the code needed to do this, but in one case I'm
> not sure of what your intention was - in dx_probe() you check for
> "unused_flags & 1" to signal a bad/unsupported index.  Why only check
> the low bit instead of the whole thing?

I guess it really means I've allocated the low bit to mean 
'incompatible change here, old code should give up now', so 
"unused_flags" is a misnomer.

> I currently have:

[code that kmail fsck'd completely in the quote]

I'll incorporate it.

> On lookup it is OK to fall back to linear search, but if we add an
> entry via linear we would then overwrite the root index.  We probably
> want extra logic so that if we have a bad interior node we overwrite
> that (or another leaf instead of killing the root index).  We
> probably also want to make a distinction between I/O errors and bad
> data (currently I just return NULL for both).  I think Al's idea of
> doing the validation once on the initial read is a good one.

I'm doing that in the current patch, for leaf blocks, look at 
ext2_bread.  For index blocks, ext2_bread needs help to know that a 
block is supposed to be an index block.  Add a parameter?

The checks we're doing now aren't that expensive so I decided to take 
the lazy approach and just do them every time.  It's not the same as 
the leaf block checks, which otherwise would need to be in the inner 
loop.

[I'm still thinking about your comments on magic numbers and hash 
versions]

> >   - Finalize hash function
>
> I noticed something interesting when running "mongo" with debugging
> on. It is adding filenames which are only sequential numbers, and the
> hash code is basically adding to only two blocks until those blocks
> are full, at which point (I guess) the blocks split and we add to two
> other blocks.

It's normal for it to start by putting all the entries into the first 
two blocks, but after those are split it should be pretty uniform 
across the resulting 4, and so on.  Can you confirm it's unbalanced?

I used to have a handy hash bucket-dumping function (dx_show_buckets) 
hooked into dir->read, which normally just returns an error.  To get a 
dump you'd cat the directory.  A hokey interface, for debugging only, 
but convenient for coding and using.    This is gone from the page 
cache version and I should hook it back in somehow.

> I will have to recompile and run with debugging on again to get
> actual output.
>
> To me this would _seem_ bad, as it indicates the hash is not
> uniformly distributing the files across the hash space.  However,
> skewed hashing may not necessarily be the bad for performance.  It
> may even be that because we never have to rebalance the hash index
> structure that as long as we don't get large numbers of identical
> hashes it is just fine if similar filenames produce similar hash
> values.  We just keep splitting the leaf blocks until the hash moves
> over to a different "range".  For a balanced tree-based structure a
> skewed hash would be bad, because you would have to do full-tree
> rebalancing very often then.
>
> > No known bugs, please test, thanks in advance.

So much for that ;-)

> Running mongo has shown up another bug, I see, but haven't had a
> chance to look into yet.  It involves not being able to delete files
> from an indexed directory:
>
> rm: cannot remove `/mnt/tmp/testdir1-0-0/d0/d1/d2/d3/509.r':
> Input/output error
>
> This is after the files had been renamed (.r suffix).  Do we re-hash
> directory entries if the file is renamed?  If not, then that would
> explain this problem.  It _looks_ like we do the right thing, but the
> mongo testing wipes out the filesystem after each test, and the above
> message is from a logfile only.

The rename creates the new entry via ext2_add_entry so the hash must be 
correct.  Time to get out the bug swatter.  I'll get mongo and try it.

--
Daniel
