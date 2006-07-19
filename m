Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWGSQNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWGSQNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 12:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWGSQNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 12:13:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:16613 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030188AbWGSQNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 12:13:10 -0400
Date: Wed, 19 Jul 2006 18:14:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Vishal Patil <vishpat@gmail.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Gary Funck <gary@intrepid.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Generic B-tree implementation
Message-ID: <20060719161427.GN5726@opteron.random>
References: <4745278c0607180630m39040ad7neac25c1a64399aff@mail.gmail.com> <JCEPIPKHCJGDMPOHDOIGCELEDFAA.gary@intrepid.com> <4745278c0607180822u55ffe5b4g333e2e6457b37d02@mail.gmail.com> <1153294394.13071.3.camel@imp.csi.cam.ac.uk> <4745278c0607190634l3ab43bb7t3d2a7b80c22d44c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4745278c0607190634l3ab43bb7t3d2a7b80c22d44c4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 09:34:43AM -0400, Vishal Patil wrote:
> I can get rid of recursions using loops, will need to work a little more on 
> it.

Before doing the above you may want to learn about all possible malloc
retvals too and to make sure the interface has all needed oom failure
paths that you're obviously missing.

One of the advantages of rbtree vs b-trees (and vs radixtrees too) is
the fact they require zero dynamic metadata allocations of ram. They
use the same trick of list.h to avoid it while still being mostly
generic and sharable library code. Imagine rbtrees like scalable
lists. The kernel usage is quite optimized too, the mmap path for
example does a single lookup and it stores the last "lookup" point
before restarting with an insertion while keeping the mmap_sem (or
mutex renaming of the day) on hold so to avoid the insertion operation
to start over with a second (wasteful) lookup (again very similar to
what you could do if you had list, and the rebalancing is a very
immediate operation too involving only a limited number of pointers).

> Also I will be working on developing a patch for VM management using
> B-trees instead of RB-trees.

Once you start changing those bits, you'll notice the further
requirement of the btrees due to the oom failures in code paths that
are already reasonably complex with vma oom failures.

As speed of cache raises faster than speed of ram, memory seeks tends
to cost more than they did in the past, but I doubt it worth it, most
important especially in the common case of very few vmas. I like the
common case of only a few dozen vmas to be so fast and low
overhead. The corner cases like uml and oracle already use nonlinear,
to also avoid the ram overhead of the vmas, with btree the lowmem
overhead would be even higher (the only 4/8 bytes of overhead of the
rbtrees would even be fixable with David's patch, but nobody
considered it very important so far to eliminate those 4/8 bytes
32bit/64bit per vma, though we can do that in the future). So even if
btree would be faster for those extreme corner cases, it would still
not be a replacement for the nonlinear (I wish there was a decent
replacement for nonlinear, whose only reason to exist seems to be uml
on 64bit archs).

If I would be in you, as a slightly more likely to succeed experiment,
I would be looking into replacing the pagecache radix-tree with a
btree, as long as you can leave intact the tagging properties we have
in the radix-tree needed for finding only dirty elements in the tree
etc... (we use that to avoid separate dirty lists for the pages). You
should also size the order to automatically match the cache size of
the arch (dunno if it's better at compile or run time). I'm no a
radix-tree guru but the btree may save some ram if you've all
pagecache pages scattered all over the place with random access. It
also won't require all levels to be allocated. However it will require
rebalancing, something the radix tree doesn't require, it seems a bit
of a tradeoff, and I suspect the radix-tree will still win in all
common cases. But at least all oom failure paths should already exists
for you, so that should avoid you having to touch much code externally
to your own btree files.

I wish you to have fun with the btrees, I remember I had fun back then
when I was playing with the rbtrees ;).
