Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153874-16160>; Mon, 21 Sep 1998 01:23:27 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:7226 "EHLO neon.transmeta.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154766-16160>; Sun, 20 Sep 1998 22:31:06 -0400
Date: Sun, 20 Sep 1998 23:17:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Michael Elizabeth Chastain <mec@shout.net>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: PTRACE_POKEDATA on PROT_NONE hangs kernel
In-Reply-To: <199809210152.UAA13294@duracef.shout.net>
Message-ID: <Pine.LNX.3.96.980920231105.26419B-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Sun, 20 Sep 1998, Michael Elizabeth Chastain wrote:
>
> First of all, if anyone else out there knows about the recent
> _PAGE_PROTNONE optimization, could you write to me please?
> I need to talk to you, if only for background information.

It's not an optimization. It's there to make things work. It essentially
has to be done that way due to the less than satisfactory intel page table
setup (there's no way to say "this page is present, but cannot be accessed
from user or kernel mode", we actuall yhave to turn off the present bit
and then use a separate bit (the _PAGE_PROTNONE bit) to keep track of the
fact that the page _is_ actually present.

> There are two pte tests in put_long:
> 
> 	/* arch/i386/kernel/ptrace.c: put_long */
> 	pgtable = pte_offset(pgmiddle, addr);
> 	if (!pte_present(*pgtable)) {
> 		handle_mm_fault(tsk, vma, addr, 1);
> 		goto repeat;
> 	}

Right. The above pages it in if it isn't present. In this case, it does
nothing, because the page _is_ present (as far as the kernel is
concerned), it's just marked non-present as far as hardware is concerned
in order to get the right PROT_NONE permissions. 

> 	page = pte_page(*pgtable);
> 	if (!pte_write(*pgtable)) {
> 		handle_mm_fault(tsk, vma, addr, 1);
> 		goto repeat;
> 	}

Ahhah. Ok, this is the buggy one. The problem is that we _should_ do a
"handle_mm_fault()" if it isn't writable, but we have no current knowledge
of that as is..

Ok, I have a simple fix, I think. 

Fix for the above, take two:

-	if (!pte_write(*pgtable)) {
+	if (!pte_dirty(*pgtable)) {
		handle_mm_fault(tsk, vma, addr, 1);
		goto repeat;
	}

The above should correctly do the proper mm fault handling whenever the
page hasn't been written to before. 

Does that finally fix it for you for all cases? 

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
