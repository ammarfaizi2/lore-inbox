Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154561-16160>; Sun, 20 Sep 1998 19:47:01 -0400
Received: from duracef.shout.net ([204.253.184.12]:23161 "EHLO duracef.shout.net" ident: "mec") by vger.rutgers.edu with ESMTP id <153962-16160>; Sun, 20 Sep 1998 18:08:30 -0400
Date: Sun, 20 Sep 1998 20:52:48 -0500
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <199809210152.UAA13294@duracef.shout.net>
To: torvalds@transmeta.com
Subject: Re: PTRACE_POKEDATA on PROT_NONE hangs kernel
Cc: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

Hello Linus and linux-kernel,

First of all, if anyone else out there knows about the recent
_PAGE_PROTNONE optimization, could you write to me please?
I need to talk to you, if only for background information.

Linus wrote:
> I suspect the _correct_ fix is to change the test
> 
> 	if (!pte_write(*pgtable))
> 
> to
> 
> 	if (!(pte_val(*pgtable) & _PAGE_RW))
> 
> (What the above does is checks that the page is just writable, even if it
> is marked _PAGE_PROTNONE).
> 
> Does this fix it for you? If so, send me email, and I'll do it in my
> kernel.

I tried this and the kernel doesn't hang with my test program any more.
It also works with my real application.  But it fails with another test
program (see below).

I am real dubious about this line of code.  Please don't patch it
in yet, and bear with me as I am a novice in the mm code.

First, take another look at these definitions:

	/* include/asm-i386/pgtable.h */
	#define _PAGE_PRESENT	0x001
	#define _PAGE_PROTNONE	0x002		/* If not present */
	#define _PAGE_RW	0x002		/* If present */

I am seeing a pte value of 0x0067c062 right now.  Meditate on the
last two bits of that, that is where the problem is.

It's bogus to test for _PAGE_RW on pages that may not be present.  Your
test as written actually behaves as: if (!_PAGE_RW && !_PAGE_PROTNONE),
which works, by coincidence or on purpose, I don't really know.

There are two pte tests in put_long:

	/* arch/i386/kernel/ptrace.c: put_long */
	pgtable = pte_offset(pgmiddle, addr);
	if (!pte_present(*pgtable)) {
		handle_mm_fault(tsk, vma, addr, 1);
		goto repeat;
	}
	page = pte_page(*pgtable);
	if (!pte_write(*pgtable)) {
		handle_mm_fault(tsk, vma, addr, 1);
		goto repeat;
	}

Here is some trace output from my instrumented kernel:

    put_long: addr: 0x40008000 count: 1
    put_long: pmd_none(*pgmiddle)
    handle_mm_fault: address: 0x40008000 *pte: 0x00000000
    handle_pte_fault: address: 0x40008000 entry: 0x00000000
    handle_pte_fault: !pte_present
    do_no_page: address: 0x40008000 entry: 0x00000000
    do_no_page: anonymous_page
    do_no_page: entry: 0x00819062
    handle_mm_fault: address: 0x40008000 *pte: 0x00819062

    put_long: addr: 0x40008000 count: 2
    put_long: pte_val(*pgtable): 0x00819062
    put_long: return

You can probably follow this trace as easily as I can explain it.  :)
Basically, put_long does call handle_mm_fault earlier, and that calls
handle_pte_fault, and that calls do_no_page, which binds a page to
that address.  Then on the second iteration of the main put_long loop,
the pte still has _PAGE_PRESENT false and _PAGE_PROTNONE true, but now
there really is a page underneath it.  With your strange test in place,
the pte passes both of these tests, and falls through to actually
perform the write.

But I think it's a nasty patch because someone wrote mm/memory.c with
the idea that _PAGE_PROTNONE pages are never present.  And now ptrace
can make it present (but without setting the _PAGE_PRESENT bit) and who
knows what other code path is going to go haywire.

I think _PAGE_PROTNONE should have its own bit assigned (if possible).
It definitely needs some re-design with consideration for ptrace.
You could change the ptrace specification so that it returns an error when
reading or writing such a page.  But this feature did work correctly
from 1.3.XX to 2.1.108 so I'd like it to keep working.

Here is the kind of nasty problem that the existing code runs into,
with your first patch applied:

    child mmap's page with PROT_NONE and gets a _PAGE_PROTNONE page
    parent calls PTRACE_PEEKUSER on this address
    parent calls PTRACE_POKEUSER on this address

I wrote a test program to do this.  The PTRACE_PEEKUSER causes the child's
_PAGE_PROTNONE page to get bound to the common read-only zero page.
Then PTRACE_POKEUSER bypasses do_wp_page and writes its value directly
onto the common read-only zero page, where it appears to anybody who
thinks they are getting a page of zeros, including the bss segment of
unrelated programs !!

So, what do you think?  Shall I continue studying the mm code and look
for a cleaner solution?

Michael Elizabeth Chastain
<mailto:mec@shout.net>
"love without fear"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
