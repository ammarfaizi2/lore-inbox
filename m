Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbTCJUdy>; Mon, 10 Mar 2003 15:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbTCJUdy>; Mon, 10 Mar 2003 15:33:54 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:52608 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261441AbTCJUdv>; Mon, 10 Mar 2003 15:33:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC] Improved inode number allocation for HTree
Date: Mon, 10 Mar 2003 21:48:36 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger@clusterfs.com>,
       Christopher Li <chrisl@vmware.com>, Alex Tomas <bzzz@tmi.comex.ru>
References: <11490000.1046367063@[10.10.2.4]> <20030309184755.ACC80FCA8C@mx12.arcor-online.net> <m3u1ecl5h8.fsf@lexa.home.net>
In-Reply-To: <m3u1ecl5h8.fsf@lexa.home.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030310204431.9C72D103F6D@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of the problem:

HTree's random relationship between directory entry order and inode order has 
been observed to cause increased cache pressure, affecting performance under 
certain conditions.  Most of this pressure is due to inode table usage, which 
is normally several times larger than the directory itself.  Even when the 
inode table usage is much less than available cache, it may still exceed the 
size of the journal file (8 MB by default).  Though the journal only becomes 
involved when blocks are modified, unfortunately, because of atime updates, 
this includes all directory operations.  We could suggest to users that they 
should disable atime updating if they care about performance, but we ought to 
be able to do better than that.

To reduce this cache pressure, what we need to do is make the directory entry 
order correspond more closely to the inode number order.  It doesn't have to 
correspond perfectly in order to show substantial improvement, as Tomas 
demonstrated with his recent getdents sorting patch.

Analysis:

To understand why sorting relatively small sections of the directory entries 
reduces the cache pressure, we can think about the lifetime of an inode table 
block over the course of a directory traversal.  This traversal lifetime 
extends from when it is first accessed (always a write as noted above) to 
when it is last accessed, or the directory traversal finishes.  Each inode 
table block contains multiple inodes, so if those inodes are accessed 
randomly, the traversal lifetime of every inode table block will tend to be 
from nearly the beginning of the traversal to nearly the end, and so the load 
on the cache will be nearly the same as the number of inode table blocks.  If 
this load is greater than available cache, various blocks will have to be 
written out and reloaded later for further processing.  We can call the 
period between loading and evicting an inode table block, its "cache period".

The number of times a block must be written/reloaded depends not only on the 
number of inode table blocks covered by the directory and the availablity of 
cache memory, but on the probable number of the inodes within the block that 
will be written during each of the block's cache period.  By sorting the 
directory chunkwise, the probable number of inodes processed in one cache 
period increases, reducing the number of cache periods, in turn reducing disk 
seeking and transfer overhead.

To apply the above model to the journal, just substitute "journal period" for 
"cache period", where journal period is defined as the time from when a dirty 
block first enters the journal to when it is written out to disk. 

We can see that local sorting or directory chunks has hardly any effect on 
the traversal lifetime of a block; it only reduces the number of cache 
periods.  The size of the chunk of directory that we sort locally presumably 
stays constant, so the probable number of inodes on each inode table block 
processed in each cache period approaches one as the directory size 
increases.  At some point, there is no longer any benefit from sorting, andwe 
arrive at that point at rather realistic directory sizes.

We can always do the job perfectly by sorting the whole directory.  This 
would require changes in every getdents-using application that cares about 
performance, to either make the getdents window as big as the directory or to 
do the sort in user space.  A spinoff benefit of doing the full sort is that 
it becomes trivial to detect and eliminate duplicate entries.  Higher memory 
load is a drawback, as is the work required to update user space programs.  
There will also be noticable latency introduced by the sort, which didn't 
appear before.  If sorting is to be done in user space then we impose the 
requirement on all filesystems - even those that do not use inode numbers 
internally - that they supply an inode key for sorting, and that the supplied 
sorting key be meaningful in terms of cache locality.

Proposed Solution:

What if we could maintain the inodes in the inode table in the same order as 
the directory entries, permanently, so that no sorting is required?  If we 
could do this, the traversal lifetime of each inode table block would be the 
same as the number of inodes it contains, and the cache load due to the inode 
table would be exactly one block.  That is, the directory traversal would 
process each inode table block completely before moving on to the next one. 
Though the current Ext3 filesystem structure does not support this directly, 
we can approximate the effect quite closely within the existing framework.

Due to Ted's recent work, we are already traversing the directory in hash 
order, as opposed to physical allocation order, because of the particular 
approach adopted to address the telldir/seekdir problem.  This is relatively 
inexpensive.  So now, what we would like to do is make the inode number of 
each directory entry increase monotonically, corresponding to monotonically 
increasing hash values.  We also want to allocate those inode numbers densely 
in the inode table, to minimize seeking.  If we know beforehand how many 
entries the directory will have, this is easy: when we create an entry, we 
multiply its hash value by the total number of entries divided by the total 
hash range (2**31), add in a base target, and use that as the goal to 
allocate a new inode.  Due to the randomness of the hash value, we will 
sometimes be forced to allocate an inode number out of order, but hopefully 
there won't be too many of those, and they won't be very far out of order.  
We may also end up with some gaps in the inode table.  In fact, we may 
intentionally leave some slack in order to reduce the number of out-of-order 
allocations.  These problems are not serious.

The big problem is that we don't know the number of directory entries ahead 
of time.  To get around this, we can use the current size of the directory, 
rounded up to a power of two as the size estimate.  Each time the directory
increases to a new binary size we establish a new region in the inode table, 
which will map to the to-be-created half of directory entries, roughly in 
order.

Now, consider what happens to a group of directory entries created when the 
directory was so small that it mapped to a single inode table block.  After a 
series of leaf splits, these former neighbors will end up far apart in the 
hash order, but their inode numbers will still be ordered monotonically over 
a traversal.  The traversal lifetime of that group of entries will be nearly 
the entire directory traversal, but there is only one such block.

When the directory became larger, some newly created entries were mapped to 
two new inode table blocks, the traversal lifetimes of which are roughly half 
the entire traversal.  There are only two such blocks, and their lifetimes do 
not overlap, so these two blocks only generate one block worth of cache load.

So it goes, with each new set of entries of size 2**i generating only one 
additional block of cache load.  The final cache load is O log2(N), a 
pleasingly small number.

A very nice property of this inode allocation strategy is that the ordering 
will tend to be reinforced as a directory ages, as opposed to slowly decaying 
towards randomness as happens with linear directories.

So this approach is attractive, especially as it can be implemented in a 
small number of lines of code.  The main outstanding issue I have not 
addressed is how to arrange things so that the inode allocation patterns of 
neighbouring directories don't interfere with each other too much.  I expect 
that each time the directory grows to a new power of two size, we need to 
scan the inode allocation map for a relatively unpopulated region of that 
size and store the region's base in the directory header.  Would we need to 
store the entire history of allocation bases?  Probably not.  This aspect 
requires further consideration.

Regards,

Daniel

