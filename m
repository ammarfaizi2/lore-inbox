Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970967-18554>; Thu, 9 Jul 1998 19:40:35 -0400
Received: from renko.ucs.ed.ac.uk ([129.215.13.3]:56923 "EHLO renko.ucs.ed.ac.uk" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <970938-18554>; Thu, 9 Jul 1998 19:40:14 -0400
Date: Fri, 10 Jul 1998 01:42:43 +0100
Message-Id: <199807100042.BAA07833@dax.dcs.ed.ac.uk>
From: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: ganesh.sittampalam@magd.ox.ac.uk
Cc: Virtual Memory problem report list <linux-kernel@vger.rutgers.edu>, mingo@valerie.inf.elte.hu, Stephen Tweedie <sct@redhat.com>, Bill Hawes <whawes@star.net>, Alan Cox <number6@the-village.bc.nu>, Linus Torvalds <torvalds@transmeta.com>, "David S. Miller" <davem@dm.cobaltmicro.com>
Subject: Progress! was: Re: Yet more VM writable swap-cached pages
In-Reply-To: <Pine.LNX.3.95.980709184611.6873C-100000@fishy>
References: <Pine.LNX.3.95.980709184611.6873C-100000@fishy>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Thu, 9 Jul 1998 18:47:10 +0100 (BST), Ganesh Sittampalam
<ganesh.sittampalam@ox.compsoc.net> said:

> Just after that last e-mail, I got a flood of them.
> Jul  9 18:27:30 munchkin kernel: VM: Found a writable swap-cached page!
> Jul  9 18:27:30 munchkin kernel: pte   6a8042, vma flags 00000070, page
> flags 0000028c, count 2
> Jul  9 18:27:30 munchkin kernel: page=c0206f80@0017da00, found=c0206f80,
> count=3

Excellent!!!!!!!!!!!!!

vma flags represent a private vma with read/write/exec-privilege but
with no rwe currently enabled.  Page flags are normal for a resident
swap-cached anonymous page with no IO in flight.  The page count, 2, is
also normal for a cached anonymous page.  The pte, 6a8042, is not normal
at all.  It is marked non-present (the lowest bit is clear) but
_PAGE_PROTNONE.  That changes everything.

Thanks --- this tells us exactly what has gone wrong, I think.
Something, somewhere, (electric fence, perhaps?) has set up a region of
memory with no access allowed.  There is a page mapped, but it is not
visible to the process: somebody has done an mprotect() to eliminate the
visibility of the page.  That clears the _PAGE_PRESENT bit on the pte
but keeps the _PAGE_PROTNONE bit set, and _PAGE_PROTNONE is an alias for
_PAGE_RW!!  That's the trouble: the pte_write() test to see if a page is
writable tests the _PAGE_RW bit but fails to first of all check whether
or not _PAGE_PRESENT is set in the first place.


I've just tried to reproduce this with the program at the end, which
creates page of local memory, allows it to be swapped out, then pages it
in and marks it PROT_NONE.  I got a slightly different end result,
exactly the same, on two attempts out of two:

	 swap_free: Trying to free nonexistent swap-page

which also quite possibly results from the swap cache code seeing this
page as writable when it is not.  Anyway, it is now clear that we can
reproduce some rather undesirable behaviour using PROT_NONE, and the pte
trace from your own report also indicates that it may be the source of
your own problems.

I _think_ that on Intel we can fix much of this by correcting the macro

  extern inline int pte_write(pte_t pte) { return pte_val(pte) & _PAGE_RW; }

to check for (_PAGE_RW && !_PAGE_PRESENT).  I'm not entirely sure yet
that this will be the end of it; tomorrow I'll have a dig around to see
if I can find any other nasties which might trip us up here.  What are
the implications for other architectures which organise their ptes
differently?

--Stephen

----------------------------------------------------------------
Run this.  When it suspends itself, force it out to swap somehow then
bring the test program back with "%" at the shell.  It will suspend
itself again; at this point, the page should back in the swap cache and
protected PROT_NONE.  Things now go wrong.

protnone.c:

/*
 * Create a page of prot-none memory
 */

#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/mman.h>

void try(const char *why, int error) 
{
	if (!error)
		return;
	perror(why);
	exit(1);
}

int main(void)
{
	int pagesize = getpagesize();
	char *page;
	volatile char a;
	
	try ("malloc", (page = malloc(2*pagesize)) == NULL);

	/* Round up to the next page boundary */
	page = (char *) (((unsigned long) page + pagesize-1) & ~(pagesize-1));
	
	/* Make a private page... */
	*page = 0;
	
	/* Give it a chance to get swapped out...  */
	kill (getpid(), SIGSTOP);

	/* Swap it back in (leaving it swap-cached of course!)... */
	a = *page;
	
	/* ... and map it prot-none. */
	try ("mprotect", mprotect (page, pagesize, PROT_NONE));

	/* Now, wait for the damage. */
	kill (getpid(), SIGSTOP);
	
	return 0;
}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
