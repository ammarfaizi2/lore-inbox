Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <156142-27300>; Sun, 31 Jan 1999 02:12:59 -0500
Received: by vger.rutgers.edu id <155971-27300>; Sun, 31 Jan 1999 02:12:46 -0500
Received: from dm.cobaltmicro.com ([209.133.34.35]:3065 "EHLO dm.cobaltmicro.com" ident: "davem") by vger.rutgers.edu with ESMTP id <156013-27300>; Sun, 31 Jan 1999 02:12:20 -0500
Date: Sat, 30 Jan 1999 23:25:08 -0800
Message-Id: <199901310725.XAA22226@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: lm@bitmover.com
Cc: linux-kernel@vger.rutgers.edu
In-reply-to: <199901310004.QAA01165@bitmover.com> (lm@bitmover.com)
Subject: Re: Page coloring HOWTO [ans]
References: <199901310004.QAA01165@bitmover.com>
Reply-To: davem@redhat.com
Sender: owner-linux-kernel@vger.rutgers.edu


I'll just relay my experience when I played around with this, and the
distribution scheme I found worked best.

First a clarification:

   Page coloring, in the sense that we are talking about here,
   is %99 dealing with physically indexed secondary/third-level
   etc. caches.  Virtually indexed secondary/third-level caches
   are dinosaurs and they'll die before anyone cares if we cater to
   them (the two most recent I know of were HyperSparc and aparently
   some HP cpus did this).  (and next will be N-way set assosciative
   secondary/third-level physically indexed caches, here page coloring
   in any form will become close to irrelevant)

A point in terminology/implementation:

   As far as page allocation is concerned, our granularity is
   PAGE_SIZE.  However the caches we want to "color" index with some
   lower order bits as well (that is, the cache line size is certainly
   smaller than PAGE_SIZE).  For the purposes of implementation, act
   as if the low order indexing bits did not exist (this translates in
   the end to, you don't need to know what the cache line size is to
   implement, only the total size matters).

   Assume that each architecture has indicated the cache line size to
   us in asm/cache.h in the form of:

#define L2_CACHE_SIZE	(512 * 1024)

   for example.

   We end up using the following definition in our internal
   implementation to do our work:

#define PAGE_COLOR(X)	(((X) & (L2_CACHE_SIZE - 1)) >> PAGE_SHIFT)

The following is a distribution scheme which I found to work extremely
well in practice and testing:

    Add to task_struct a member "int cur_color;"

    Add to inode a member "int cur_color"

    When giving a new address space to a process (via exec() or some
    other means, but not during fork/clone for example) set
    tsk->cur_color to zero.

    When allocating a new inode structure in the vfs, set
    inode->cur_color to zero.

    Now track page cache, page table allocation, and anonymous page
    faulting in the following way:

       a) At each anonymous page write fault, allocate a free page
          with color current->cur_color, and then increment this.

       b) At each page table page allocation, do the same as in #a

       c) At each addition of a new page into the page cache, allocate
          this page using the vfs object's inode->cur_color, and then
          increment.

(while considering the above scheme, consider the effects it has on
 mmap'd shared libraries etc.)

The only thing left is to implement:

	unsigned long get_colored_page(int gfp_flags, int *color_ptr)

Doing it efficiently and with minimal code changes in the current page
allocator is left right now as an exercise to the reader.  I have some
ideas, and after some experimentation I'll try to describe my ideas
for this here.

But right now I will say that four important issues here are:

1) It has to cost close to nothing.

2) It has to be "obviously correct".

3) It should not try too hard, this is a heuristic after all,
   the first priority is to get some page to the caller quickly.

4) It should not contribute to memory fragmentation.

(note that satisfying #3 is probably the nicest way to satisfy #4)

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
