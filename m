Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTFXW4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTFXW4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:56:25 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:7624 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S263103AbTFXWz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:55:57 -0400
From: Daniel Phillips <phillips@arcor.de>
Subject: [RFC] My research agenda for 2.7
Date: Wed, 25 Jun 2003 01:11:01 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306250111.01498.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This note describes several items on my research agenda for the 2.7 kernel 
development timeframe.  First a little history.

In 2.3/2.4, the dominant change to Linux's memory management subsystem was the 
unification of the page and buffer cache, in the sense that most double 
storage was eliminated and copying from the buffer to page cache was no 
longer required on each file write.  In 2.5, the dominant change was the 
addition of reverse page mapping.  I participated actively in the latter, 
being motivated by the belief that with reverse mapping in place, a number of 
significant evolutionary improvements to the memory management subsystem 
would become possible, or indeed, easy.  Here, I list the three main projects 
I hope to complete in the 2.7 timeframe, for comment:

  1) Active memory defragmentation
  2) Variable sized page cache objects
  3) Physical block cache

These are ordered from least to most controversial.  I believe all three will 
prove to be worthwhile improvements to the Linux's memory management 
subsystem, and hopefully, I support that belief adequately in the text below.  
Of course, working code and benchmarks are the final arbiter of goodness, and 
will appear in due course.

1) Active memory defragmentation

I doubt anyone will deny that this is desirable.  Active defragmentation will 
eliminate higher order allocation failures for non-atomic allocations, and I 
hope, generally improve the efficiency and transparency of the kernel memory 
allocator.

The purpose of active memory defragmentation is to catch corner cases, rather 
than to be a complete replacement for the current allocation system.  The 
most obvious and problematic corner case is the one where all physical memory 
units of a given order are used up, in which case the allocator only has two 
options: wait or fail.  Active defragmentation introduces a third option, 
which should eliminate nearly all instances of the former and all of the 
latter, except when physical memory is genuinely exhausted for some reason 
(i.e., bona fide OOM).

The idea is to run a defragmentation daemon that kicks in whenever 
availability of some allocation order falls below a threshold.  The defrag  
daemon first scans memory for easily movable pages that can form new, free 
units of the needed order.  If this pass fails, the daemon could go as far as 
quiescing the system (a technique already used in RCU locking) and move some 
not-so-easy-to-move pages.

In order to move a page of physical memory, we need to know what is pointing 
at it.  This is often easy, for example in the common case when the only 
pointer to a page is held by the page cache and the page is not under IO.  We 
only need to hold the page cache lock and the page table lock to move such a 
page.

Moving anonymous memory is pretty easy as well, with the help of reverse page 
mapping.  We need to hold the appropriate locks, then walk a page's reverse 
map list, updating pointers to a new copy of the page.  (If we encounter 
nasty corner cases here, we could possibly fall back to a quiescing 
strategy.)

Some difficult situations may be dealt with by creating a new internal kernel 
API that provides a way of notifying some subsystem that page ownership 
information is wanted, or that certain pages should be reallocated according 
to the wishes of the defragmentation daemon.  Obviously, there is plenty of 
opportunity for over-engineering in this area, but equally, there is 
opportunity for clever design work that derives much benefit while avoiding 
most of the potential complexity.

Physical memory defragmentation is an enabler for variable-sized pages, next 
on my list.

2) Variable sized page objects

This item will no doubt seem as controversial as the first is uncontroversial.  
It may help to know that my prototype code, done under 2.4, indicates that 
the complete system actually gets smaller with this feature, and possibly 
slightly faster as well.  Essentially, if we have variable sized pages then 
we can eliminate the messy buffer lists that are (sometimes) attached to 
pages, and indeed, eliminate buffers themselves.  Traditional buffer IO and 
data operations can be trivially reexpressed in terms of pages, provided page 
objects can take on the same range of sizes as buffers currently do.  The 
block IO library also gets shorter, since much looping and state handling 
becomes redundant.

For my purpose, "variable sized" means that each struct page object can 
reference a data frame of any binary size, including smaller than a physical 
page.  To keep the implementation sane, all pages of a given address_space 
are the same size.  Also, page objects smaller than a physical page are only 
allowed for file-backed memory, not anonymous memory.  Rules for large pages 
remain to be determined, however since there is already considerable work 
being done in this area, I will not dwell on it further.

The most interesting aspect of variable sized pages is how subpages are 
handled.  This could get messy, but fortunately a simple approach is possible.
Subpage page structs do not need to reside in the mem_map; instead they can 
be dynamically allocated from slab cache.  The extra bookkeeping needed inside
the page cache operations to keep track of this is not much, and particularly, 
does not add more than a sub-cycle penalty to the case where subpages are 
not used (even so, I expect this penalty to be more than made up by shorter, 
straighter paths in the block IO library).

One benefit of subpages that may not be immediately obvious is the opportunity 
to save some space in the mem_map array: with subpages it becomes quite
attractive to use a larger PAGE_CACHE_SIZE, i.e., a filesystem that must use 
a small block size for some reason won't cause a lot of additional internal 
fragmentation.

But to my mind, the biggest benefit to subpages is the opportunity to 
eliminate some redundant state information that is currently shared between 
pages and buffer_heads.  To be sure, I've been less than successful to date 
at communicating the importance of this simplification, but in this case, the 
code should be the proof.

Variable-size pages will deliver immediate benefits to filesystems such as 
Ext2 and Ext3, in the form of larger volume size limits and more efficient 
transfers.  As a side effect, we will probably need to implement tail merging 
in Ext2/3 to control the resulting increased internal fragmentation, but that 
is another story, for another mailing list.

Variable size pages should fit together nicely with the current work being 
done on large (2 and 4 MB) page handling, and especially, it will be nice for 
architectures like MIPS that can optimize variable sized pages in 
hardware.

Some bullet points:

  - Rationalize state info: state represented only in struct page, not struct
    page + list of struct buffer_head

  - 1K filesystems aren't a special case any more

  - More efficient IO path, esp for 1K fs

  - Net removal of code by simplifying the vfs block IO library (new code
    is added to page cache access functions).

  - Makes the page locking unit match the filesystem locking unit for most
    filesystems

  - Generalizes to superpages

  - Performance.  It's a little more efficient.  Eliminates one class of
    objects, allowing us to concentrate more on the remaining class.

  - Large file blocks (multiple physical pages)

  - Eliminate buffer heads.  Final use of buffer heads is as data handle for
    filesystem metadata (IO function of buffer heads will be taken over by
    BIO).  Basically, we can just substitute struct page for struct
    buffer_head.  Can make this transition gradual, after establishing
    one buffer head per page.

  - Memory pressure now acts on only one class of object, making balancing
    more even.

Relies on:

  - Active defragmentation

How it works:

  - Page size is represented on a per-address space basis with a shift count.
    In practice, the smallest is 9 (512 byte sector), could imagine 7 (each
    ext2 inode is separate page) or 8 (actual hardsect size on some drives).
    12 will be the most common size.  13 gives 8K blocksize for, e.g., alpha.
    21 and 22 give 2M and 4M page size, matching hardware capabilities of
    x86, and other sizes are possible on machines like MIPS, where page size
    is software controllable

  - Implemented only for file-backed memory (page cache)

  - Special case these ops in page cache access layer instead of having the
    messy code in the block IO library

  - Subpage struct pages are dynamically allocated.  But buffer_heads are gone
    so this is a lateral change.

3) Physical block cache

This item is not strictly concerned with memory management, but as it impacts 
the same subsystems, I have included it in this note.

In brief, a physical block cache lets the vfs efficiently answer the question: 
"given a physical data block, tell me if and where it is mapped into any 
address_space on the same volume".  This need not be a big change to the 
existing strategy: the normal lookup and other operations remain available.  
However, the vfs gets the additional responsibility of maintaining a special 
per-volume address_space coherently with the multiple file-backed 
address_spaces on the volume.  

In fact, we already have such per-volume address spaces, and there really 
isn't that much work to do here, in order to test the effects of making the 
two types of address_space coherent with one another.  One way of looking at 
this is, full coherence in this area would complete the work of unifying the 
page and buffer caches, started some years ago.

Having discussed this idea with a few developers, I've been warned that 
difficult issues will arise with some of the more complex filesystems, such 
as Ext3.  Fortunately, a prototype physical block cache can be adequately 
tested with Ext2 alone, which doesn't have a lot of issues.  If this proves 
to deliver the performance benefits I expect, further work would be justified 
to extend the functionality to other filesystems.

So what are the anticpated performance benefits?  I've identified two so far:

 1. Physical readahead.  That is, we can load a block into the page cache
    before we know which address_space, if any, it actually belongs to.
    Later, when we do know, additionally entering it into its proper
    address space is efficient.  This will help with the traversal of
    many small files case, which Linux currently handles poorly.

 2. Raid 5.  The biggest performance problem with Raid 5 stems from the
    fact that for small, isolated writes it is forced to read a few blocks
    to compute every new parity block, and in the process suffers large
    amounts of rotational latency.  A big cache helps with this a great,
    however, the size of cache we could expect to find in, e.g., a high
    end scsi drive, is not adequate to eliminate the bad effects, and in
    any event, bus saturation becomes a very real problem.  We could also
    have a separate, physical block cache, but this wastes memory and
    causes unnecessary copying.  Being able to implement the big cache
    directly in the page cache is thus a big advantage in terms of memory
    savings, and reduced data copying.  There is also a latency advantage,

Summary

Please note that all of the above is unofficial, experimental work.  However, 
I do believe that all three of these items have the potential to deliver 
substantial improvements in terms of reliability, efficiency and obvious 
correctness.

Thankyou for your indulgence in reading all the way down to here.  The 
timeframe for this work is:

  - Starts as soon as 2.5 closes
  - Prototypes to be posted shortly thereafter

Regards,

Daniel


