Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbRFCASW>; Sat, 2 Jun 2001 20:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262606AbRFCASM>; Sat, 2 Jun 2001 20:18:12 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:27397 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262581AbRFCARz>; Sat, 2 Jun 2001 20:17:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [Ext2-devel] [UPDATE] Directory index for ext2
Date: Sun, 3 Jun 2001 02:19:50 +0200
X-Mailer: KMail [version 1.2]
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200105311944.f4VJiIrK016421@webber.adilger.int>
In-Reply-To: <200105311944.f4VJiIrK016421@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01060302195004.07058@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 May 2001 21:44, Andreas Dilger wrote:
> I noticed something interesting when running "mongo" with debugging
> on. It is adding filenames which are only sequential numbers, and the
> hash code is basically adding to only two blocks until those blocks
> are full, at which point (I guess) the blocks split and we add to two
> other blocks.
>
> I haven't looked at it closely, but for _example_ it something like:
>
> 65531 to block 113
> 65532 to block 51
> 65533 to block 51
> 65534 to block 113
> 65535 to block 113
> (repeats)
> 65600 to block 21
> 65601 to block 96
> 65602 to block 96
> 65603 to block 21
> 65604 to block 21
> (repeats)
>
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

A skewed hash doesn't hurt the fixed-depth tree in the obvious way - it 
just tends to leave a lot of half-full buckets around, which wastes 
about 1/3 of the leaf space.  The reason for this behaviour is, when 
you create a lot of sequentially-related names a skewed hash will tend 
to dump a lot them into a tiny sliver of the hash space, and after 
splitting the little sliver it's quite unlikely that later entries will 
hit the same small range.  The only good protection against this is to 
make the hash function vary wildly if even one bit in the string 
changes.  This is what crc does, and that's why I'm interested in it.

I've rehabilitated the hack_show_dir code, which is enabled by 
#defining DX_HACK.  To kprint a dump of hash buckets and statistics do:

    cat /test_partition/indexed_dir

This dump is extremely helpful in judging the effectiveness of hash 
functions, just take a look at how the range of hash values that gets 
mapped into each leaf block.  Ideally, there should not be too much 
variance.

The format of the dump is:

   bucketnumber:blocknumber hashstart/range (entrycount)

Yusuf Goolamabbas sent me a pointer to some new work on hash functions:

   http://www.isthe.com/chongo/tech/comp/fnv/

I coded up the fnv_hash and included it in today's patch - there is a 
define to select which to use; dx_hack_hash is still the default.

fnv_hash is only a little wose than dx_hack_hash, which still produces 
the most uniform distribution of all the hash functions I've tested.   
But I can see from the dumps that it's still not optimal, it's just 
that all the others are worse.

I still have quite a few leads to follow up on the hashing question.
Next week I hope I'll get time to try crc32 as a hashing function.  I 
hope it doesn't win because I'll need a 1K table to evaluate it, and 
that would be 20% of the whole code size.

The patch:

    http://nl.linux.org/~phillips/htree/dx.pcache-2.4.5-2

--
Daniel
