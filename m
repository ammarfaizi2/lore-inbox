Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTB0XEq>; Thu, 27 Feb 2003 18:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbTB0XEp>; Thu, 27 Feb 2003 18:04:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13583 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267153AbTB0XEi>; Thu, 27 Feb 2003 18:04:38 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] New dcache / inode hash tuning patch
Date: Thu, 27 Feb 2003 23:10:05 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b3m5sd$1ad$1@penguin.transmeta.com>
References: <20030226164904.GA21342@wotan.suse.de>
X-Trace: palladium.transmeta.com 1046387690 16972 127.0.0.1 (27 Feb 2003 23:14:50 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Feb 2003 23:14:50 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030226164904.GA21342@wotan.suse.de>,
Andi Kleen  <ak@suse.de> wrote:
>
>Unlike the previous version this one should actually compile.
>
>The purpose of the patch is to address the excessive cache misses
>observed on some boxes when accessing the dcache hash table.

I don't think that the hash-list approach is really worth it.

There are two things the hash-list helps with:

 - memory usage

   But quite frankly, if the hash list heads are actually noticeable
   memory users, the hash is likely to be _way_ too big. The list heads
   are _much_ smaller than the entries they point to, the hash list just
   shouldn't be big enough that it really matters.

 - hash list cache footprint

   Again: the hash head array itself is at least dense in the cache, and
   each entry is _much_ smaller than the actual data structures it
   points to.  So even if you improve the hash heads to be better from a
   cache standpoint, you're only getting a very small percentage of the
   real cache costs. 

   So let's say that the cache costs of the dcache is 4% (according to
   the oprofile run), then saving a few procent of that is not actually
   going to be noticeable at a user level.

And the downsides of the hash list is that addition/removal is costlier
due to the conditionals, and a non-conditional version (a common
optimization using a special "tail marker entry" that is shared across
the different chains) has absolutely _horrible_ false sharing
characteristics on SMP systems. 

In other words: it may be that our current dentry hashes are too big,
and that is certainly worth fixing if so.  But the "hlist" approach very
fundamentally cannot really help the _real_ problem very much, and it
will (slightly) hurt the case where the hashes are actually cached. 

So I really think that the only longterm fix is to make the lookup data
structures be "local" to the base of the lookup, in order to get away
from the inherently non-local nature of the current hash lookups. 

That "local" thing doesn't have to be on a direct per-directory level
either, btw.  A fairly simple scheme might be to _force_ some locality
by having some of the hash bits always come from the parent directory,
rather than trying to get a "perfect distribution".

For example, one approach might be to just change the "d_hash()"
function, to something more like

	#define HASHBITS_DENTRY 5	// just an example value
	#define HASHBITS_PARENT 5	// just an example value
	#define HASHBITS_TOTAL (HASHBITS_DENTRY + HASHBITS_PARENT)

	static inline struct list_head * d_hash(struct dentry * parent, unsigned long hash)
	{
		unsigned long parenthash = (unsigned long) parent / L1_CACHE_BYTES;
		parenthash ^= parent->d_hash;

		parenthash = parenthash ^ (parenthash >> HASHBITS_TOTAL);
		parenthash &= (1 << HASHBITS_TOTAL)-1;
		hash = hash ^ (hash >> HASHBITS_DENRY);
		hash &= (1 << HASHBITS_DENTRY)-1;
		return parenthash ^ hash;
	}

ie the high bits are _solely_ based on the parent, while the low bits
are based on some hash of the parent and the dentry itself.

(Yeah, don't tell me the hash for the parent sucks.  I'm a retard, and
the point is really more to try to make the hash "worse" by actually
giving it more locality, so that lookups within one directory won't blow
the whole cache).

Will this help? I dunno.  It's kind of a "cheap hash partitioning"
thing.  It will obviously result in huge hash chain imbalances if you
for example have only one directory with millions of entries, and
because of the above that directory will only populate 5% of the whole
hash list.

And traditionally a hash imbalance has always been considered a bad
thing.  I'm claiming that _maybe_ the hash imbalance can actually be a
good thing too, as long as we try to make sure it's not _too_ extreme.

I'd frankly prefer truly local lookups (ie each dentry has it's own
rbtree associated with it), since that would also potentially help
locking a lot (ability to use private locks rather than a global dcache
lock), but I don't see any good low-cost algorithms for something like
the dcache that is _extremely_ performance-sensitive.

			Linus
