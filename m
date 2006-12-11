Return-Path: <linux-kernel-owner+w=401wt.eu-S1762568AbWLKGRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762568AbWLKGRx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 01:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762575AbWLKGRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 01:17:53 -0500
Received: from science.horizon.com ([192.35.100.1]:11320 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762568AbWLKGRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 01:17:52 -0500
Date: 11 Dec 2006 01:17:51 -0500
Message-ID: <20061211061751.22553.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <457CDEDE.9080804@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  atomic_ll() / atomic_sc() with the restriction that they cannot be
>  nested, you cannot write any C code between them, and may only call
>  into some specific set of atomic_llsc_xxx primitives, operating on
>  the address given to ll, and must not have more than a given number
>  of instructions between them. Also, the atomic_sc won't always fail
>  if there were interleaving stores.

I'm not entirely sure what you're talking about.  You generally want
to keep the amount of code between ll and sc to an absolute minimum
to avoid interference which causes livelock.  Processor timeouts
are generally much longer than any reasonable code sequence.

I hear you and Linus say that loads and stores are not allowed.
I'm trying to find that documented somewhere.  Let's see... Wikipedia
says that LL/SC is implemented on Alpha, MIPS, PowerPC, and ARM.


Generally, LL loads the line into cache, makes a note of what it is,
and sets an "atomic bit".  In particular, the atomic bit is cleared if
that cache line is evicted, or an interrupt happens.


MIPS clears the LLbit if:
- There's an external (another processor) update or invalidate of the
  affected cache line.  (There are three cases of this, but they are
  all implementation-specific details.)
- Or an ERET (return from exception) is executed.

I see no restriction in internal accesses, even to the same cache line.


Wikipedia says that the PowerPC implementation is particularly
strong, and the IBM compiler has C builtins to perform the operations
(http://publib.boulder.ibm.com/infocenter/pseries/v5r3/topic/com.ibm.xlcpp8a.doc/compiler/ref/bif_misc.htm),
so I don't think it breaks on memory access.  Double-checking with the
"PowerPC Microprocessor Family: Programming Environments Manual for 64 and
32-bit Microprocessors" (4.2.6 Memory Synchronization Instructions--UISA,
pp. 173-174) confirms that only a modification by ANOTHER processor,
or a return from exception, breaks the reservation.


The ARM implementation is hard to find documentation on.  The best
I managed is U.S. patent 6892257, which describes the implementation.
In particular, the "external access monitor" that rmk has been describing
appears to only apply to uncacheable accesses, where it behaves as
described.

# At step 28, a check is made as to whether or not the semaphore value
# being sought is cacheable. If the semaphore value is not cacheable, as
# indicated within an associated MMU (not illustrated), then processing
# proceeds to step 30. If the semaphore value is cacheable, then
# processing proceeds to step 32.

# At step 30, the semaphore value corresponding to the address indicated
# by the Rm register value is stored into a register Rd specified within
# the LDREX instruction. Furthermore, the physical address of the
# semaphore value together with a processor identifying number for the
# processor executing the LDREX instruction is stored within the main
# memory monitor circuit 22. The bus arbiter 20 is triggered to provide
# this processor identifying number to the main memory monitor circuit 22
# by the decoding of an LDREX instruction by one of the processors 4, 6.
# At step 30, the physical address of the semaphore data is also stored
# within the local semaphore identifying data store 24, 26 of the
# processor executing the LDREX instruction.

# If processing from step 28 proceeds to step 32, instead of step 30, then
# no data is written into the main memory monitor circuit 22, but the
# physical address of the semaphore value being returned from address Rm
# to register Rd is written into the appropriate local semaphore
# identifying data store 24, 26.

In the cacheable case (which is the onle of interest), then it works
the same as the others, being triggered primarily by the eviction of
the cache line.  Wading through the patentese is painful, but I
assume there's a similar exception return case.


It appears that the problem is on Alpha.  From the architecture handbook:
"· If any other memory access (ECB, LDx, LDQ_U, STx, STQ_U, WH64) is executed on
   the given processor between the LDx_L and the STx_C, the sequence above may
   always fail on some implementations; hence, no useful program should do this.
 · If a branch is taken between the LDx_L and the STx_C, the sequence above may
   always fail on some implementations; hence, no useful program should do this.
   (CMOVxx may be used to avoid branching.)"

Okay, so Alpha is the special case; write those primitives directly
in asm.  It's still possible to get three out of four.


In truth, however, realizing that we're only talking about three
architectures (wo of which have 32 & 64-bit versions) it's probably not
worth it.  If there were five, it would probably be a savings, but 3x
code duplication of some small, well-defined primitives is a fair price
to pay for avoiding another layer of abstraction (a.k.a. obfuscation).

And it lets you optimize them better.

I apologize for not having counted them before.
