Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbTCGXR6>; Fri, 7 Mar 2003 18:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbTCGXR5>; Fri, 7 Mar 2003 18:17:57 -0500
Received: from thunk.org ([140.239.227.29]:4785 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261872AbTCGXRq>;
	Fri, 7 Mar 2003 18:17:46 -0500
Date: Fri, 7 Mar 2003 18:27:50 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Daniel Phillips <phillips@arcor.de>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
Message-ID: <20030307232749.GA24572@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Daniel Phillips <phillips@arcor.de>, Alex Tomas <bzzz@tmi.comex.ru>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <11490000.1046367063@[10.10.2.4]> <m34r6fyya8.fsf@lexa.home.net> <20030307173425.5C4D3FAAAE@mx12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307173425.5C4D3FAAAE@mx12.arcor-online.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 06:38:50PM +0100, Daniel Phillips wrote:
> > The problem is that getdents(2) returns inodes out of order and
> > du causes many head seeks. I tried to solve the problem by patch
> > I included in. The idea of the patch is pretty simple: just try
> > to sort dentries by inode number in readdir(). 

Yup, that's the problem and the fix; the only issue is the the one
which Daniel pointed out:

> The problem I see with your approach is that the traversal is no
> longer in hash order, so a leaf split in the middle of a directory
> traversal could result in a lot of duplicate dirents.  I'm not sure
> there's a way around that.

The fix in userspace would be for du and find (the two programs most
likely to care about this sort of thing) to pull into memory a large
chunks of the directory at a time, sort them by inode, and then stat
them in inode order.

The only other way around it would be to do maintain an entirely
separate B-tree on disk just for the benefit of readdir(), which could
be in inode sort order.  Readdir() could then traverse the tree in
inode sort order, thus solving the performance penalty.  (The b-tree
has to be on disk, since for large directories, we can't afford to fit
it on disk.)

> We've apparently got a simpler problem though: inode numbers aren't
> allocated densely enough in the inode table blocks.  This is the
> only thing I can think of that could cause the amount of thrashing
> we're seeing.  Spreading inode number allocations out all over a
> volume is ok, but sparse allocation within each table block is not
> ok because it multiplies the pressure on the cache.  We want a
> 30,000 entry directory to touch 1,000 - 2,000 inode table blocks,
> not the worst-case 30,000.  As above, fixing this comes down to
> tweaking the ext3_new_inode allocation goal.

Nope.  That's not it.  Inode numbers are allocated sequentially in the
inode table blocks.  You can't get any more dense that that.  Create a
bunch of inodes in a directory like this:

mke2fs -j -F -b 1024 -g 1024 -N 1200000 test.img
mount -t ext3 -o loop test.img /mnt
pushd /mnt
mkdir test test2 test3
cd test
time seq -f "%06.0f" 1 100  | xargs touch
cd ..
cd test2
time seq -f "%06.0f" 1 10000  | xargs touch
cd ..
cd test3
time seq -f "%06.0f" 1 100000  | xargs touch
cd ..
popd

Then look at the result using "ls -li".  You will see that the inode
numbers are all sequentially allocated, when you look at the inodes in
creation order (which in this particular case is in filename sort
order ).  The problem is that when you look at them in hash sort
order, the inode numbers are scattered all over the place.

> Another approach is to have the inode number correspond approximately to the 
> hash value.  That's not as hard as it sounds, it simply means that the goal 
> for ext3_new_inode should be influenced by the hash value.  (But watch out 
> for interaction with the new Orlov allocator.)  

I'm not all convinced that splattering the inodes all over the volume
is in fact a good thing, because it means splattering the block
allocation for files within the same directory all over the volume.
Arguably, read access to files in a directory is much more common than
the "du" or "find" case.  So if we need to make trade-off in one
direction or another, I'd much rather go with striving to maximize
block locality than making a readdir+stat run go fast.  This is
especially true since there *is* a user space workaround that would
speed up things for du and find.

						- Ted


