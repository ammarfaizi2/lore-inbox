Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268335AbTCAAjY>; Fri, 28 Feb 2003 19:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268364AbTCAAjY>; Fri, 28 Feb 2003 19:39:24 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:57293 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S268335AbTCAAjW>; Fri, 28 Feb 2003 19:39:22 -0500
Date: Fri, 28 Feb 2003 19:49:43 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New dcache / inode hash tuning patch
Message-ID: <20030301004942.GA16973@delft.aura.cs.cmu.edu>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <p73n0kg7qi7.fsf@amdsimf.suse.de> <Pine.LNX.4.44.0302281039570.3177-100000@home.transmeta.com> <20030228185910.GA5694@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228185910.GA5694@wotan.suse.de>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 07:59:10PM +0100, Andi Kleen wrote:
> > Quite frankly, right now the only report I've seen about your patch is 
> > that it made things slightly _slower_.
> 
> Actually that's not quite true. The report had a completely different
> profile (lots of other functions had different percentages), so it likely
> wasn't a comparable workload. I also don't think the NUMAQs are a good test

Did you read any of the comments on your patch?

Look at slabinfo to see how much space those objects are actually using.

Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
inode_cache        33977  82901    512 11810 11843    1 :  124   62
dentry_cache       14490  14490    128  483  483    1 :  252  126

So the actual amount of memory used by f.i. the inodes is about 47MB
(11810 * 4KB).

The dentry cache hashtable currently has a fill-rate of about 10%, but
I've been running a lot of compilations and updatedb hasn't been around
for a long time. The VM has already aggressivly pruned it, which is to be
expected. The inode cache hash table is at about 50%. So if the hash
function is good we can assume that most hash chains are either empty or
only contain a single object and any hit will give us either a pointer
to the likely candidate or we know that the object isn't cached.

Now from what I read of your patch, it limits the size of the inode hash
table to 64KB, but with single pointers it can still address about 16000
hash chains. Assuming the same perfect hash distribution, all chains
will contain about 2 objects. So although the hash table fits much
better, each time we are looking for an uncached object we need to walk
2 objects that are spread across that 47MB chunk of allocated inodes,
instead of basically having a 'yes or no' answer pretty much from
looking at the hash table.

> platform for this because they have 2MB of fast cache per CPU, while
> the typical linux multiprocessor machine has much less. Yes you can 
> fit an 1MB hash table into a 2 MB cache....

Yes but you will never fit 47MB worth of inodes into that same 2MB
cache. And I realize that you can align things so that you don't have
to pull in more than a few cache-lines per object, but traversing ~0.5
pointers versus 2 pointers for every L1/L2 cache miss will be felt
because each traversal will hit another L2 cache-line.

It is probably far more useful to restrain the sizes of the inode and
dentry caches. Why would my system need 2-3 times the number of inodes
compared to dentries, while you pretty much always need to go through
the dentry cache to find the inodes. So a lot of those inodes are likely
unreferenced and we already have to hit the disk for the dentry lookup
anyways.

Jan

