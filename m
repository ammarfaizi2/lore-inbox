Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268476AbTCABHD>; Fri, 28 Feb 2003 20:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268481AbTCABHD>; Fri, 28 Feb 2003 20:07:03 -0500
Received: from ns.suse.de ([213.95.15.193]:17162 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268476AbTCABHB>;
	Fri, 28 Feb 2003 20:07:01 -0500
Date: Sat, 1 Mar 2003 02:17:23 +0100
From: Andi Kleen <ak@suse.de>
To: jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New dcache / inode hash tuning patch
Message-ID: <20030301011723.GA31126@wotan.suse.de>
References: <p73n0kg7qi7.fsf@amdsimf.suse.de> <Pine.LNX.4.44.0302281039570.3177-100000@home.transmeta.com> <20030228185910.GA5694@wotan.suse.de> <20030301004942.GA16973@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301004942.GA16973@delft.aura.cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The dentry cache hashtable currently has a fill-rate of about 10%, but
> I've been running a lot of compilations and updatedb hasn't been around
> for a long time. The VM has already aggressivly pruned it, which is to be
> expected. The inode cache hash table is at about 50%. So if the hash
> function is good we can assume that most hash chains are either empty or

The hash function isn't good and the hash chains are far from evenly
distributed. There are typically 30-40% empty buckets, while some
others are rather long.

In addition I think only a small fraction of the dentries are actually hot.
(no numbers on that, sorry) 

Your 47MB number doesn't make much sense for lookup tuning because these 
are not walked all the time. Only a few cache lines of the dentry are accessed
for a lookup.

If you think you have a better concept than me to tune it then feel
free to post a patch. 


> Now from what I read of your patch, it limits the size of the inode hash
> table to 64KB, but with single pointers it can still address about 16000
> hash chains. Assuming the same perfect hash distribution, all chains
> will contain about 2 objects. So although the hash table fits much
> better, each time we are looking for an uncached object we need to walk
> 2 objects that are spread across that 47MB chunk of allocated inodes,
> instead of basically having a 'yes or no' answer pretty much from
> looking at the hash table.

Apply the latest hash patch  and run some statistics over the bucket
distributions from /proc/dcache. You'll quickly see that your ideal model 
does not match reality at all.

> Yes but you will never fit 47MB worth of inodes into that same 2MB
> cache. And I realize that you can align things so that you don't have

The overall cached inodes are not too interesting - it is a long known
problem of linux that it caches too many inodes. But it doesn't matter
here because the dcache does all the hard lookup work and it hash
direct pointers to the inodes (no inode hash lookup needed). Most of them
are just wasted memory, but luckily not wasted cache.

What's interesting is to make the dentry lookup as fast as possible.

> to pull in more than a few cache-lines per object, but traversing ~0.5
> pointers versus 2 pointers for every L1/L2 cache miss will be felt
> because each traversal will hit another L2 cache-line.

Sorry but the average 2 bucket length number is completely unrealistic.
It doesn't make any sense to use it in an argument.


> 
> It is probably far more useful to restrain the sizes of the inode and
> dentry caches. Why would my system need 2-3 times the number of inodes

Limiting inode caches is probably a good idea. It's a long standing known
bug. At least definitely do prune inodes not referenced by the dcache
I believe some 2.4 trees fixed that in fact, but these fixes have
likely not moved to 2.5 yet. But really, it makes no difference
for these benchmarks, which have enough memory.

Limiting dcache is probably a bad idea. Recreating the dcache is far 
slower than any hash lookup. And a lot of Linux's good interactive
performance comes from the aggressive dcache caching.

-Andi

