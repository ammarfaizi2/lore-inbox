Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156934AbPJORxY>; Fri, 15 Oct 1999 13:53:24 -0400
Received: by vger.rutgers.edu id <S156833AbPJORxI>; Fri, 15 Oct 1999 13:53:08 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:22461 "EHLO deliverator.sgi.com") by vger.rutgers.edu with ESMTP id <S156934AbPJORwP>; Fri, 15 Oct 1999 13:52:15 -0400
From: kanoj@google.engr.sgi.com (Kanoj Sarcar)
Message-Id: <199910151750.KAA99441@google.engr.sgi.com>
Subject: Re: locking question: do_mmap(), do_munmap()
To: ralf@oss.sgi.com (Ralf Baechle)
Date: Fri, 15 Oct 1999 10:50:11 -0700 (PDT)
Cc: manfreds@colorfullife.com, sct@redhat.com, viro@math.psu.edu, andrea@suse.de, linux-kernel@vger.rutgers.edu, mingo@chiara.csoma.elte.hu, linux-mm@kvack.org, linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
In-Reply-To: <19991015115816.B948@uni-koblenz.de> from "Ralf Baechle" at Oct 15, 99 11:58:16 am
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

> 
> On Wed, Oct 13, 1999 at 09:32:54AM +0200, Manfred Spraul wrote:
> 
> > Kanoj Sarcar wrote:
> > > Here's a primitive patch showing the direction I am thinking of. I do not
> > > have any problem with a spinning lock, but I coded this against 2.2.10,
> > > where insert_vm_struct could go to sleep, hence I had to use sleeping
> > > locks to protect the vma chain.
> > 
> > I found a few places where I don't know how to change them.
> > 
> > 1) arch/mips/mm/r4xx0.c:
> > their flush_cache_range() function internally calls find_vma().
> > flush_cache_range() is called by proc/mem.c, and it seems that this
> > function cannot get the mmap semaphore.
> > Currently, every caller of flush_cache_range() either owns the kernel
> > lock or the mmap_sem.
> > OTHO, this function contains a race anyway [src_vma can go away if
> > handle_mm_fault() sleeps, src_vma is used at the end of the function.]
> 
> The sole reason for fiddling with the VMA is that we try to optimize
> icache flushing for non-VM_EXEC vmas.  This optimization is broken
> as the MIPS hardware doesn't make a difference between read and execute
> in page permissions, so the icache might be dirty even though the vma
> has no exec permission.  So I'll have to re-implement this whole things
> anyway.  The other problem is an efficience problem.  A call like
> flush_cache_range(some_mm_ptr, 0, TASK_SIZE) would take a minor eternity
> and for MIPS64 a full eternity ...
> 
>   Ralf

Ralf,

Looking in 2.3.21, all the find_vma's in arch/mips/mm/r4xx0.c are used to 
set a flag called "text" which is not used at all. Also, if the find_vma
returns null, the code basically does nothing. So the optimized icache
flushing is probably not implemented yet? Then, the only reason to 
do the flush_vma currently is to check whether the lower level flush 
routine should be called. Without holding some locks, this is always
tricky to do on a third party mm.

Btw, this probably belongs to linux-mips, but what do you mean by saying
the icache might be dirty? Its been a while since I worked on the
older mips chips, but as far as I remember, the icache can not hold 
dirty lines.

Kanoj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
