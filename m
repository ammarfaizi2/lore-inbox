Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSGZCDy>; Thu, 25 Jul 2002 22:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSGZCDy>; Thu, 25 Jul 2002 22:03:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9388 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316684AbSGZCDw>;
	Thu, 25 Jul 2002 22:03:52 -0400
Date: Thu, 25 Jul 2002 19:35:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>, Richard Henderson <rth@redhat.com>
Subject: [announce, patch] Thread-Local Storage (TLS) support for Linux,
 2.5.28
Message-ID: <Pine.LNX.4.44.0207251857220.3732-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the following patch implements proper x86 TLS support in the Linux kernel,
via a new system-call, sys_set_thread_area():

   http://redhat.com/~mingo/tls-patches/tls-2.5.28-C6

a TLS test utility can be downloaded from:

    http://redhat.com/~mingo/tls-patches/tls_test.c

what is TLS? Thread Local Storage is a concept used by threading
abstractions - fast an efficient way to store per-thread local (but not
on-stack local) data. The __thread extension is already supported by gcc.

proper TLS support in compilers (and glibc/pthreads) is a bit problematic
on the x86 platform. There's only 8 general purpose registers available,
so on x86 we have to use segments to access the TLS. The approach used by
glibc so far was to set up a per-thread LDT entry to describe the TLS.
Besides the generic unrobustness of LDTs, this also introduced a limit:
the maximum number of LDT entries is 8192, so the maximum number of
threads per application is 8192.

this patch does it differently - the kernel keeps a specific per-thread
GDT entry that can be set up and modified by each thread:

     asmlinkage int sys_set_thread_area(unsigned int base,
               unsigned int limit, unsigned int flags)

the kernel, upon context-switch, modifies this GDT entry to match that of
the thread's TLS setting. This way user-space threaded code can access
per-thread data via this descriptor - by using the same, constant %gs (or
%gs) selector. The number of TLS areas is unlimited, and there is no
additional allocation overhead associated with TLS support.


the biggest problem preventing the introduction of this concept was
Linux's global shared GDT on SMP systems. The patch fixes this by
implementing a per-CPU GDT, which is also a nice context-switch speedup,
2-task lat_ctx context-switching got faster by about 5% on a dual Celeron
testbox. [ Could it be that a shared GDT is fundamentally suboptimal on
SMP? perhaps updating the 'accessed' bit in the DS/CS descriptors causes
some sort locked memory cycle overhead? ]

the GDT layout got simplified:

 *   0 - null
 *   1 - Thread-Local Storage (TLS) segment
 *   2 - kernel code segment
 *   3 - kernel data segment
 *   4 - user code segment              <==== new cacheline
 *   5 - user data segment
 *   6 - TSS
 *   7 - LDT
 *   8 - APM BIOS support               <==== new cacheline
 *   9 - APM BIOS support
 *  10 - APM BIOS support
 *  11 - APM BIOS support
 *  12 - PNPBIOS support                <==== new cacheline
 *  13 - PNPBIOS support
 *  14 - PNPBIOS support
 *  15 - PNPBIOS support
 *  16 - PNPBIOS support                <==== new cacheline
 *  17 - not used
 *  18 - not used
 *  19 - not used

set_thread_area() currently recognizes the following flags:

  #define TLS_FLAG_LIMIT_IN_PAGES         0x00000001
  #define TLS_FLAG_WRITABLE               0x00000002
  #define TLS_FLAG_CLEAR                  0x00000004

- in theory we could avoid the 'limit in pages' bit, but i wanted to
  preserve the flexibility to potentially enable the setting of
  byte-granularity stack segments for example. And unlimited segments 
  (granularity = pages, limit = 0xfffff) might have a performance
  advantage on some CPUs. We could also automatically figure out the best
  possible granularity for a given limit - but i wanted to avoid this kind
  of guesswork. Some CPUs might have a plus for page-limit segments - who
  knows.

- The 'writable' flag is straightforward and could be useful to some
  applications.

- The 'clear' flag clears the TLS. [note that a base 0 limit 0 TLS is in
  fact legal, it's a single-byte segment at address 0.]

(the system-call does not expose any other segment options to user-space,
priviledge level is 3, the segment is 32-bit, etc. - it's using safe and
sane defaults.)

NOTE: the interface does not allow the changing of the TLS of another
thread on purpose - that would just complicate the interface (and
implementation) unnecesserily. Is there any good reason to allow the
setting of another thread's TLS?

NOTE2: non-pthreads glibc applications can call set_thread_area() to set
up a GDT entry just below the end of stack. We could use some sort of
default TLS area as well, but that would hard-code a given segment.

i fixed a number of unclean items in our GDT/IDT handling as well:

 - the 'gdt' pointer is completely unnecessery, it introduces an 
   additional redirection.

 - ditto the 'idt' pointer.

 - this also enabled simpler setting of the GDT/IDT descriptors.

 - on UP the GDT got smaller in fact, by a few bytes :-)

 - cleaned up LDT loading: load_LDT_desc() now loads the (constant) LDT 
   selector. A pity that we have to do this - but it's necessery to flush
   the LDT shadow descriptors.

 - the thread context-switching hotpath included a call to a non-inlined 
   function - set_ldt_desc() - this function is inlined now.

the patch compiles, boots & works just fine on UP and SMP x86 boxes.  
Comments and suggestions are welcome,

	Ingo

