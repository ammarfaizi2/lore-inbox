Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbTIKA53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbTIKA53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:57:29 -0400
Received: from amdext2.amd.com ([163.181.251.1]:50138 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S265958AbTIKA5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:57:23 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
From: richard.brunner@amd.com
To: linux-kernel@vger.kernel.org
Subject: Update on AMD Athlon/Opteron/Athlon64 Prefetch Errata
Date: Wed, 10 Sep 2003 19:56:56 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 134117D31917888-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear LKML,

Continuing my yearly tradition of posting just one long
novel to LKML every year, here is the literary update on the
Prefetch Errata that the early 2.6 Kernels hit on AMD Athlon
Processors.

This previously published errata can occur infrequently and
is present in all AMD Athlon processors and earlier AMD
Opteron/Athlon64 processors.  See [1] and [2].

The full details are below, but the key point is that under
certain circumstances, prefetch instructions can get memory
management faults for addresses which would fault if they
were accessed by a load or store instruction.  We plan to
revise our published errata with the new information below.

The errata requires a kernel workaround, but the good news
is that it is:

  - Harmless in most cases where it could occur. Most of the
    time the prefetch will be targeting memory that is
    accessible under the current privilege mode. So the page
    will simply be "faulted in" slightly earlier than
    needed.

  - Rare and Infrequent. AMD Athlon processors have been
    available for years running numerous Operating Systems
    and only recently have we hit this errata outside of
    code specifically designed to target the errata --
    requiring tens of thousands of iterations to cause it.

  - It can be worked around. Andi Kleen has a 2.6 and a 2.4
    Kernel patches that we have tested at AMD on a large
    number of AMD Athlon processors and AMD Opteron/Athlon64
    processors (both legacy x86 and x86-64 long mode).  It
    works just fine. (Andi will be posting them soon when he 
    wakes up ;-)

  - AMD is fixing this in future revisions of AMD
    Opteron/Athlon64 processors.

  - Andi's kernel patches will not be needed on future
    AMD processors but it is forward compatible and so
    won't break on them either.
 


The Details
===========
Software prefetch instructions are defined to ignore page
faults. Under highly specific and detailed internal
circumstances, the following conditions may cause the
PREFETCH instruction to report a page fault.

+ The target address of the PREFETCH would cause a page
  fault if the address was accessed by an actual memory load
  or store instruction under the current privilege mode.

+ The instruction is a PREFETCH or PREFETCHNTA/0/1/2
  followed in execution-order by an actual or speculative
  byte-sized load to the same address.

  In this case, the page fault exception error code bits for
  the faulting PREFETCH would be identical to that for a
  byte-sized load to the same address.

+ The instruction is a PREFETCHW followed in execution-order
  by an actual or speculative byte-sized store to the same
  address.
  
  In this case, the page fault exception error code bits for
  the faulting PREFETCHW would be identical to that for a
  byte-sized store to the same address.

Note that some misaligned accesses can be broken up by the
processor into multiple accesses where at least one of the
accesses is a byte-sized access.

If the target address of the subsequent memory load or store
is aligned and not byte-sized, this errata does not occur
and no work-around is needed.

So the net effect is that an unexpected page fault may occur
infrequently on a PREFETCH instruction.


Kernel Work-around
=================
The kernel can work around the errata by modifying the Page
Fault Handler in the following way.  This is what Andi
Kleen's patches do.  Because the actual errata is infrequent
it does not produce an excessive number of page faults that
affect system performance.
   
+ Continue to allow the page fault handler to satisfy the
  page fault.  If the faulting instruction is permitted
  access to the page, return to it as usual.

+ If the faulting instruction is not permitted access to the
  page, scan the instruction stream bytes at the faulting
  Instruction Pointer to determine if the instruction is a
  PREFETCH. 

+ If it is not a PREFETCH instruction, generate the
  appropriate memory access control violation as
  appropriate.

+ If the faulting instruction is a PREFETCH instruction,
  simply return back to it; the internal hardware conditions
  that caused the PREFETCH to fault should be removed and
  operation should continue normally.


General Work-around
===================
If the page-fault handler for a kernel can be patched as
described above, no further action by software is
required. The following general work-arounds should only be
considered for kernels where the page-fault handler can not
be patched and a PREFETCH instruction could end up targeting
an address in an "inaccessible" page. (An "inaccessible"
page is one for which memory accesses are not allowed under
the current privilege mode.)

Because the actual errata is infrequent, it does not produce
an excessive number of page faults that affect system
performance.  Therefore a page fault from a PREFETCH
instruction for an address within an "accessible" page does
not require any general work-around.  (An "accessible" page
is one for which memory accesses are allowed under the
current privilege mode once the page is resident in memory)

Software can minimize the occurrence of the errata by
issuing only one PREFETCH instruction per cache-line (a
naturally-aligned 64-byte quantity on AMD Athlon and AMD
Opteron/Athlon64) and ensuring one of the following:

+ In many cases, if a particular target address of a
  prefetch is known to encounter this errata, simply change
  the prefetch to target the next byte.

+ Avoid prefetching inaccessible memory locations, when
  possible.

+ In the general case, ensure that the address used by the
  PREFETCH is offset into the middle of an aligned quadword
  near the end of the cache-line. For example, if the
  address desired to be prefetched is "ADDR", use an offset
  of 0x33 to compute the address used by the actual PREFETCH
  instruction as: "(ADDR & ~0x3f) + 0x33"




Footnotes
=========
[1] AMD Athlon(tm) Processor Model 6 Revision Guide 24332F June 2003.
    
www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24332.pdf


[2] Revision Guide for AMD Opteron(tm) Processors 25759 Rev. 3.07 Aug 2003

www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/25759.PDF


] -Rich ...
] AMD Fellow

