Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130687AbQKWWyN>; Thu, 23 Nov 2000 17:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130849AbQKWWyD>; Thu, 23 Nov 2000 17:54:03 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:31344 "EHLO
        medusa.sparta.lu.se") by vger.kernel.org with ESMTP
        id <S130687AbQKWWx4>; Thu, 23 Nov 2000 17:53:56 -0500
Date: Thu, 23 Nov 2000 22:04:18 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Address translation
In-Reply-To: <20001123212315.C4886@storm.local>
Message-ID: <Pine.LNX.3.96.1001123214139.14437A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000, Andreas Bombe wrote:
> > I may be wrong on this, but I thought that copy_{to,from}_user are
> > only necessary if the address range you are accessing might cause a
> > fault which Linux cannot handle (ie. one which would cause the
> > application to segfault if it accessed that memory). If it is only a
> 
> It is wrong.  copy_*_user handle the page faults, whether they are good
> faults (swapped out, copy on write) or bad faults (illegal access).
> Without these macros you get the "unable to handle kernel page fault"
> oops message if a fault occurs.

Yes but only if it's a real fault, not if the address range actually is
a valid VMA which needs paging, COW'ing or related OS ops. copy_*_user
does not do the access in any different way than a "manual" access or
memcpy does, it just adds a .fixup section that tells the do_page_fault
handler that it should not segfault the kernel itself if the copy takes a
big fault at any point, instead it should jump to the fixup which makes
the copy routine return an error message.

However, the fixup stuff is not in-line with the copy code so there should
be absolutely no penalty using copy_*_user instead of a memcpy
(provided the copy_*_user is as optimized as the memcpy code), and it's
dangerous to assume anything about pages visible in user-space, they might
be unmapped by another thread while you're doing that memcpy etc.

> >  (1) In a "top half" thread, can I now access this memory without the
> >      access macros (since I know the address range is valid)?
> 
> The address is valid, the pages probably aren't.  In fact, extending the
> address space only creates read-only mappings to the global zeroed page
> if I remember right.

But it does not matter that the pages aren't there physically, any kind of
access (including an access from kernel-mode) will bring about the same
COW/change-on-write mechanism as copy_to_user or a user-mode access would.

The problem is rather that between your do_brk and when you access the
pages, a thread in the process might do an unmap or brk to remove the
mapping, then you crash the kernel.

> >  (2) Can I also access this memory from an interrupt/exception
> >      context, or must I lock it? (ie. can faults be handled from such
> >      a context) 
> 
> You can't even use copy_*_user in this context (since the current user
> space might be any process, even kernel threads that have no user space
> at all).
> 
> For access to user memory from interrupt context at all and to access
> user memory without the uaccess macros, you have to lock them down in
> memory, with map_user_kiobuf().  This is only recommended if you want
> hardware to DMA to/from buffers provided by user space.

Yup, if you are in the wrong context or in an interrupt context you'll die
horribly if you try to access user-pages that aren't there:

        if (in_interrupt() || !mm)
                goto no_context;

So you need to 1) make sure the pages are in physical memory and 2) make
sure the pages won't get removed from under your feet at any time and 3)
access them using their physical address

> >  (3) Is the above code sensible at all, or barking? It took me a while
> >      to figure that the above would work, and I think/hope it is the
> >      most elegant way to share memory between kernel and a process.
> 
> It will fail quickly, probably taking the kernel down with it.
> 
> The most elegant way to share memory between user and kernel is to
> allocate the memory in the kernel and map it to user space (by
> implementing mmap  on the kernel side for the file used for
> communication).

Agreed, but that does not cut it for some applications. For example, let's
say you want to grab 16 MB of video frames without copying them from that
mmap area to your malloc'ed 16 MB (let's say your CPU takes a pretty big
hit doing that extra memcpy) and you'd like to DMA directly into the
user-pages. 

You can of course make the kernel grab 16 MB worth of pages for you and
then mmap them into the process, but the kernel driver would be pretty
hooked to that demanding user process then.. 

Actually I'm trying to figure out the best way to do a similar thing for
some hardware we have - I have incoming DMA data containing JPG grabs, and
I want to cache images in a user-mode daemon, which will send pictures
from the cache out on TCP. The images might be generated with many
different JPG settings so they need right tags in the cache etc. 

Before when we ran on a chip without MMU this was easy - that user-mode
buffer was a contigous physical area which I could DMA directly in. But
now when we're going to a CPU with MMU, it gets more complicated of course
:) 

I have figured the options are

1) let the kernel driver have a buffer big enough for a single grab, mmap
this into user-space and do the memcpy into the cache (might be fast
enough, but our chip isn't super on memcpy's..)

2) let the kernel driver lock down the user-pages in an access and DMA
directly into them, and take abuse from QA when we get a race in the
driver vs VM system and it freaks out

3) let the kernel driver handle the complete cache including tags for the
frames in it, and make a more advanced interface between the driver and
the user-mode daemon

I think 3 would be easier to get stable than 2, if 1 is not fast enough..
oh well I'll just have to try all of them out :) 

-BW

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
