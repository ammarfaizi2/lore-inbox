Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311128AbSCMTwV>; Wed, 13 Mar 2002 14:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311132AbSCMTwL>; Wed, 13 Mar 2002 14:52:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:37126 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311128AbSCMTv4>; Wed, 13 Mar 2002 14:51:56 -0500
Message-ID: <3C8FAD88.1C425F9B@zip.com.au>
Date: Wed, 13 Mar 2002 11:50:32 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
In-Reply-To: <3C8D9999.83F991DB@zip.com.au> <E16kkcq-0001rV-00@starship> <3C8E6C63.E8B72195@zip.com.au>,
		<3C8E6C63.E8B72195@zip.com.au> <E16l7Oe-0000Dk-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> That's the thrust of my current work - massaging things into a form where
> struct page can be substituted for buffer_head as the block data handle for
> the mass of filesystems that use it.
> 
> ...
> 
> For me, the missing piece of the puzzle is how to recover the semantics of
> ->b_flushtime.  The crude solution is just to put that in struct page for
> now.  At least that's a wash in terms of size because ->buffers goes out.

I'm currently doing that in struct address_space(!).  Maybe struct inode
would make more sense...

So the mapping records the time at which it was first dirtied.  So the
`kupdate' function simply writes back all files which had their
first-dirtying time between 30 and 35 seconds ago.

That works OK, but it also needs to cope with the case of a single
huge dirty file.  For that case, periodic writeback also terminates
when it has written back 1/6th of all the dirty pages in the machine.

This is all fairly arbitrary, and is basically designed to map onto
the time-honoured behaviour.  I haven't observed any surprises from
it, nor any reason to change it.

> It's not right for the long term though, because flushtime is only needed for
> cache-under-io.  It's annoying to bloat up all pages for the sake of the
> block cache.  Some kind of external structure is needed that can capture both
> flushtime ordering and physical ordering, and be readily accessible from
> struct page without costing a field in struct page.  Right now that structure
> is the buffer dirty list, though that fails the requirement of not bloating
> the struct page.  It falls short by other measures as well, such as offering
> no good way to search for physical adjacency for the purpose of clustering.
> 
> I don't know what kind of thing I'm searching for here, I thought I'd dump
> the problem on you and see what happens.

See above...

We also need to discuss writeback of metadata.  For delayed allocate
files, indirect blocks are not a problem, because I start I/O against
them *immediately*, as soon as they're dirtied.  This is because we
know that the indirect's associated data blocks are also under I/O.

Which leaves bitmaps and inode blocks.  These I am leaving on the
dirty buffer LRU, so nothing has changed there.

Now, I think it's fair to say that the ext2/ext3 inter-file fragmentation
issue is one of the three biggest performance problems in Linux.  (The
other two being excessive latency in the page allocator due to VM writeback
and read latency in the I/O scheduler).

The fix for interfile fragmentation lies inside ext2/ext3, not inside
any generic layers of the kernel.    And this really is a must-fix,
because the completion time for writeback is approximately proportional
to the size of the filesystem.  So we're getting, what? Fifty percent
slower per year?

The `tar xfz linux.tar.gz ; sync' workload can be sped up 4x-5x by
using find_group_other() for directories.  I spent a week or so
poking at this when it first came up.  Basically, *everything*
which I did to address the rapid-growth problem ended up penalising
the slow-growth fragmentation - long-term intra-file fragmentation
suffered at the expense of short-term inter-file fragmentation.

So I ended up concluding that we need online defrag to fix the
intra-file fragmentation.  Then this would *enable* the death
of find_group_dir().  I do have fully-journalled, cache-coherent,
crash-proof block relocation coded for ext3.  It's just an ioctl:

	int try_to_relocate_page(int fd, long blocks[]);

But I haven't sat down and thought about the userspace application
yet.  Which is kinda dumb, because the payback from this will be
considerable.

So.  Conclusion:  periodic writeback is based on inode-dirty-time,
with a limit on the number of pages.  Buffer LRU writeback for
bitmaps and inodes is OK, but we need to fix the directory
allocator.

-
