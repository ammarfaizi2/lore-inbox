Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSCDCNv>; Sun, 3 Mar 2002 21:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291020AbSCDCNn>; Sun, 3 Mar 2002 21:13:43 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:27791 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290965AbSCDCNc>;
	Sun, 3 Mar 2002 21:13:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
Date: Mon, 4 Mar 2002 03:08:54 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au>
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au>
Cc: Steve Lord <lord@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hhuI-0000S6-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 1, 2002 09:26 am, Andrew Morton wrote:
> A bunch of patches which implement allocate-on-flush for 2.5.6-pre1 are
> available at
> 
>   
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/dalloc-10-core.patch
>   - Core functions
> and
>   
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/dalloc-20-ext2.patch
>   - delalloc implementation for ext2.
> 
> Also,
>   
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/dalloc-30-ratcache.patch
>   - Momchil Velikov/Christoph Hellwig radix-tree pagecache ported onto 
> delalloc.

Wow, this is massive.  Why did you write [patch] instead of [PATCH]? ;-)  I'm
surprised there aren't any comments on this patch so far, that should teach 
you to post on a Friday afternoon.

> Global accounting of locked and dirty pages has been introduced.

Alan seems to be working on this as well.  Besides locked and dirty we also 
have 'pinned', i.e., pages that somebody has taken a use count on, beyond the 
number of pte+pcache references.

I'm just going to poke at a couple of inconsequential things for now, to show
I've read the post.  In general this is really important work because it
starts to move away from the vfs's current dumb filesystem orientation.

I doubt all the subproblems you've addressed are tackled in the simplest 
possible way, and because of that it's a cinch Linus isn't just going to 
apply this.  But hopefully the benchmarking team descend upon this and find 
out if it does/does't suck, and hopefully you plan to maintain it through 2.5.

> Testing is showing considerable improvements in system tractability
> under heavy load, while approximately doubling heavy dbench throughput.
> Other benchmarks are pretty much unchanged, apart from those which are
> affected by file fragmentation, which show improvement.

What is system tractability?

> With this patch, writepage() is still using the buffer layer, so lock
> contention will still be high.

Right, and buffers are going away one way or another.

> A number of functions in fs/inode.c have been renamed.  We have a huge
> and confusing array of sync_foo() functions in there.  I've attempted
> to differentiate between `writeback_foo()', which starts I/O, and
> `sync_foo()', which starts I/O and waits on it.  It's still a bit of a
> mess, and needs revisiting.

Yup.

> Within the VM, the concept of ->writepage() has been replaced with the
> concept of "write back a mapping".  This means that rather than writing
> back a single page, we write back *all* dirty pages against the mapping
> to which the LRU page belongs.

This is a good and natural step, but don't we want to go even more global 
than that and look at all the dirty data on a superblock, so the decision on 
what to write out is optimized across files for better locality.

>   Despite its crudeness, this actually works rather well.  And it's
>   important, because disk blocks are allocated at ->writepage time, and
>   we *need* to write out good chunks of data, in ascending file offset
>   order so that the files are laid out well.  Random page-at-a-time
>   sprinkliness won't cut it.

Right.

>   A simple future refinement is to change the API to be "write back N
>   pages around this one, including this one".  At present, I'll have to
>   pull a number out of the air (128 pages?).  Some additional
>   intelligence from the VM may help here.
>
>   Or not.  It could be that writing out all the mapping's pages is
>   always the right thing to do - it's what bdflush is doing at present,
>   and it *has* to have the best bandwidth.

This has the desireable result of deferring the work on how best to "write 
back N pages around this one, including this one" above.  I really think that 
if we sit back and let the vfs evolve on its own a little more, that that 
question will get much easier to answer.

>   But it may come unstuck when applied to swapcache.

You're not even trying to apply this to swap cache right now are you?

> Things which must still be done include:
>
> [...]
>
> - Remove bdflush and kupdate - use the pdflush pool to provide these
>   functions.

The main disconnect there is sub-page sized writes, you will bundle together
young and old 1K buffers.  Since it's getting harder to find a 1K blocksize
filesystem, we might not care.  There is also my nefarious plan to make 
struct pages refer to variable-binary-sized objects, including smaller than
4K PAGE_SIZE.
 
> - Expose the three writeback tunables to userspace (/proc/sys/vm/pdflush?)

/proc/sys/vm/pageflush <- we know the pages are dirty

> - Use pdflush for try_to_sync_unused_inodes(), to stop the keventd
>   abuse.

Could you explain please?

> - Verify that the new APIs and implementation are suitable for XFS.

Hey, I was going to mention that :-)  The question is, how long will it be
before vfs-level delayed allocation is in 2.5.  Steve might see that as a
way to get infinitely sidetracked.

Well, I used up way more than the time budget I have for reading your patch
and post, and I barely scratched the surface.  I hope the rest of the
filesystem gang gets involved at this point, or maybe not.  Cooks/soup.

I guess the thing to do is start thinking about parts that can be broken out 
because of obvious correctness.  The dirty/locked accounting would be one
candidate, the multiple flush threads another, and I'm sure there are more
because you don't seem to have treated much as sacred ;-)

Something tells me the vfs is going to look quite different by the end
of 2.6.

-- 
Daniel
