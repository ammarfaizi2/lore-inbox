Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281433AbRKEXgd>; Mon, 5 Nov 2001 18:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281431AbRKEXgX>; Mon, 5 Nov 2001 18:36:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55460 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281429AbRKEXgM>;
	Mon, 5 Nov 2001 18:36:12 -0500
Date: Mon, 5 Nov 2001 18:36:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <9s75ku$7u2$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111051811150.27086-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Linus Torvalds wrote:

> I don't particularly like behaviour that changes over time, so I would
> much rather just state clearly that the current inode allocation
> strategy is obviously complete crap. Proof: simple real-world
> benchmarks, along with some trivial thinking about seek latencies.
> 
> In particular, the way it works now, it will on purpose try to spread
> out inodes over the whole disk. Every new directory will be allocated in
> the group that has the most free inodes, which obviously on average
> means that you try to fill up all groups equally.
 
> Which makes _no_ sense. There is no advantage to trying to spread things
> out, only clear disadvantages.

Wrong.  Trivial example: create skeleton homedirs for 50 new users.
You _really_ don't want all of them in one cylinder group.  Because they
will be slowly filling up with files, while directory structure is very likely
to stay more or less stable.  You want the prefered group for the file
inode to be the same as its parent directory.  _And_ you want data
close to inode if we can afford that.  Worse yet, for data allocation
we use quadratic hash.  Which works nicely _unless_ starting point for
all of them sits in the same group.

See where it's going?  The real issue is ratio of frequencies for
directory and file creation.  The "time-dependent" part is ugly, but
the thing it tries to address is very, very real.  Allocation policy
for a tree created at once is different from allocation policy for
normal use.

Ideally we would need to predict how many (and how large) files
will go into directory.  We can't - we have no time machines.  But
heuristics you've mentioned is clearly broken.  It will end up with
mostly empty trees squeezed into a single cylinder group and when
they start to get populated that will be pure hell.

And yes, it's more than realistic scenario.  Your strategy would make
sense if all directories were created by untaring a large archive.
Which may be fairly accurate for your boxen (or mine, for that matter -
most of the time), but it's not universal.

Benchmarks that try to stress that code tend to be something like
cvs co, tar x, yodda, yodda.  _All_ of them deal only with "fast-growth"
pattern.  And yes, FFS inode allocator sucks for that scenario - no
arguments here.  Unfortunately, the variant you propose will suck for
slow-growth one and that is going to hurt a lot.

The fact that Linux became a huge directory tree means that we tend
to deal with fast-growth scenario quite often.  Not everyone works
on the kernel, though ;-)

