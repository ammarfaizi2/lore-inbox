Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136173AbRD0TBi>; Fri, 27 Apr 2001 15:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136170AbRD0TB2>; Fri, 27 Apr 2001 15:01:28 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:45363 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136173AbRD0TBT>; Fri, 27 Apr 2001 15:01:19 -0400
Date: Fri, 27 Apr 2001 15:01:14 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Atrocious icache/dcache in 2.4.2
Message-ID: <20010427150114.A23960@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

My box here slows down dramatically after a while, and starts
behaving as if it has very little memory, e.g. programs page
each other out. It turns out that out of 40MB total, about
35MB is used for dcache and icache, and system basically
runs in 5MB of RAM.

When I tried to discuss it with riel, viro, and others,
I got an immediate and very strong knee jerk reaction "we fixed
it in 2.4.4-pre4!" "we gotta call prune_dcache more!".
That just does not sound persuasive to me.

After a little thinking it seems apparent to me that it
may be a good thing to have VM taking pages from dentry and
inode pools directly. This sounds almost what slab does,
so let me speculate about it (it is a bad idea, but it is
interesting _why_).

Suppose that we do this: when inode gets clean (e.g. unlocked,
written to disk if was changed), drop it into kmem_cache_free(),
but retain on hash (forget about poisoning for a momemt).
Then, if memory is needed, VM may ask slab, slab calls our
destructors, and destructors take inode off hash. The idea
solves the problem, but has two marks agains it. First, when
we look up an inode, we either hit dirty or "clean", which
is free. Then we have to do kmem_cache_alloc() and that will
return wrong inode, which we have to drop from hash, then do
memcpy from old "really free one", etc. It still saves disk
I/O, but messy. Another thing is a fragmentation: suppose we
have bunch of slabs, every one has a single dirty inode in it
(tar xf -). Memory pressure will be powerless to do anything
about them.

So, I have a better crackpot idea: create a fake filesystem,
say "inodefs". When inodes are needed, we pretend to read
pages from that filesystem, but in fact we just zero most
of them and put inodes there, also every one needs a "used"
counter, like slab has.  When an inode is dirty, we mark
those pages locked or dirty, if only clean - mark pages
as dirty. VM will automatically try to get pages, and
write out those that are "dirty". At that moment,
we have an option to look, if any used (clean or dirty) inodes
are inside the page. If they are, we either move them in
some other (fragmented) pages, or just remove them from
hashes and pretend that the page is written.

The bad part is that inode cache code and inodefs will have
part of slab machinery replicated in them. Dunno if that is
bad enough to bury the thing.

If you have read to this point, let me know what you think.

-- Pete
