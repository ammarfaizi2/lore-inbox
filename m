Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157081AbPJORXP>; Fri, 15 Oct 1999 13:23:15 -0400
Received: by vger.rutgers.edu id <S156917AbPJORRn>; Fri, 15 Oct 1999 13:17:43 -0400
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:59600 "EHLO mailhost.uni-koblenz.de") by vger.rutgers.edu with ESMTP id <S157043AbPJORON>; Fri, 15 Oct 1999 13:14:13 -0400
Date: Fri, 15 Oct 1999 11:58:16 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Manfred Spraul <manfreds@colorfullife.com>
Cc: Kanoj Sarcar <kanoj@google.engr.sgi.com>, "Stephen C. Tweedie" <sct@redhat.com>, viro@math.psu.edu, andrea@suse.de, linux-kernel@vger.rutgers.edu, mingo@chiara.csoma.elte.hu, linux-mm@kvack.org, linux@engr.sgi.com, linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: locking question: do_mmap(), do_munmap()
Message-ID: <19991015115816.B948@uni-koblenz.de>
References: <199910130125.SAA66579@google.engr.sgi.com> <380435A6.93B4B75A@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <380435A6.93B4B75A@colorfullife.com>; from Manfred Spraul on Wed, Oct 13, 1999 at 09:32:54AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, Oct 13, 1999 at 09:32:54AM +0200, Manfred Spraul wrote:

> Kanoj Sarcar wrote:
> > Here's a primitive patch showing the direction I am thinking of. I do not
> > have any problem with a spinning lock, but I coded this against 2.2.10,
> > where insert_vm_struct could go to sleep, hence I had to use sleeping
> > locks to protect the vma chain.
> 
> I found a few places where I don't know how to change them.
> 
> 1) arch/mips/mm/r4xx0.c:
> their flush_cache_range() function internally calls find_vma().
> flush_cache_range() is called by proc/mem.c, and it seems that this
> function cannot get the mmap semaphore.
> Currently, every caller of flush_cache_range() either owns the kernel
> lock or the mmap_sem.
> OTHO, this function contains a race anyway [src_vma can go away if
> handle_mm_fault() sleeps, src_vma is used at the end of the function.]

The sole reason for fiddling with the VMA is that we try to optimize
icache flushing for non-VM_EXEC vmas.  This optimization is broken
as the MIPS hardware doesn't make a difference between read and execute
in page permissions, so the icache might be dirty even though the vma
has no exec permission.  So I'll have to re-implement this whole things
anyway.  The other problem is an efficience problem.  A call like
flush_cache_range(some_mm_ptr, 0, TASK_SIZE) would take a minor eternity
and for MIPS64 a full eternity ...

  Ralf

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
