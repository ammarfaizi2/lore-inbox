Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971080-15443>; Sun, 19 Jul 1998 01:31:42 -0400
Received: from noc.nyx.net ([206.124.29.3]:2426 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <971108-15443>; Sun, 19 Jul 1998 01:31:28 -0400
Date: Sun, 19 Jul 1998 00:51:37 -0600 (MDT)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199807190651.AAA26297@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Sun Jul 19 00:51:37 1998, Sender=colin, Recipient=linux-kernel@vger.rutgers.edu, Valsender=colin@localhost
To: linux-kernel@vger.rutgers.edu
Subject: Re: current pointer question/suggestion
Sender: owner-linux-kernel@vger.rutgers.edu

Okay, here's the scoop:
We need some way for processor to tell themselves apart.
Since they all share memory, the only way to do it is with some
per-processor register.  We could, in theory, use something
in the APIC, but that's slow ans cumbersome.

Currently onm Intel it's stored in the Task Register.
This holds the TSS segement selector, which points to
the TSS, which holds the holds the ring 0 stack pointer,
which tells us where the current process structure is, which
contains the processor number.  (Whew!)

The advantage is that the stack pointer is already loaded on
entry to kernel space, so only the last part of the dereferencing chain
needs to be done.

If we could only get a processor number, it would be possible to use
that as an offset in a table of "what's that processor running" to get
the current process, so finding the current process and the current
processor are really the same problem.  It's just that finding the
current process is more common.

The use of the stack pointer has the wonderful advantage of portability
across a considerable number of platforms.  The hack doesn't depend on
the existence of a task register or whatever, just some mechanism
to load a unique per-process kernel stack pointer on entry to kernel
space.  Most processors have some provision for doing this, so this
piggybacks on that existing mechanism.

Another possibility that some people are mentioning is to use the
memory management system.  These are independent per-processor
(and thus making a coordinated change is hard), so seem like
an obvious place to hide per-processor information.

Changing memory mappings, while faster than file access, is
expensive when compared to a simple system call like getpid().
It's one of the biggest costs of task switching.  It's Bad.

However, one possibility is to have a per-processor page at
a fixed kernel virtual address that can contain a pointer to the
current task and any other desired per-processor information.

The only costs are:
- This steals a TLB slot if it's used, or requires a TLB walk if it's not.
- Before switching to each task, you need to update its in-memory page
  tables to point to the current processor's local page.  Note that
  this does *not* require a TLB flush.
- On a PPro, you can use the globla bit to prevent the mapping being
  flushed on a context switch, but otherwise, this will incur
  a TLM miss the first time it's used.

The somewhere on the per-processor page you can install a current
pointer and finding the current process becomes a pretty simple matter.

Still, the advantages over the current sp-based scheme are unclear,
and the costs, while low, are not zero.
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
