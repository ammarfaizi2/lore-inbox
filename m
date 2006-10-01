Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWJAAZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWJAAZd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 20:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWJAAZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 20:25:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35514 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751832AbWJAAZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 20:25:32 -0400
Date: Sat, 30 Sep 2006 17:25:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <200610010156.52675.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609301713460.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <200610010002.46634.ak@suse.de> <Pine.LNX.4.64.0609301554310.3952@g5.osdl.org>
 <200610010156.52675.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Oct 2006, Andi Kleen wrote:
> 
> On i386 it is simpler (only one interrupt stack and one process stack)
> However there can be still nasty corner cases, like the temporary NMI stacks
> that were added recently. It could be probably all handled in a state machine,
> but it would be ugly (at least I heard complaints about the x86 code that
> does it) 

No, I don't understand AT ALL why you are so hung up about this state 
machine thing. It's not true. There's simply no state machine involved, 
although from a theoretical standpoint you can obviously always implement 
just about _anything_ as a state machine.

> > Read the x86 code. Please. The one _before_ you added unwinding.
> 
> It's still the same if you disable unwinding.

I think your problem is that you think that "unwinding" needs to handle 
all the page crossing. That's incorrect, and that just results in stupid 
and unworkable code.

Instead (and this is why I was trying to point you to the original 
pre-unwinding code on i386), what you should do is to see it as two 
totally independent phases:

 - you have an outer loop that loops around the pages (since the _kernel_ 
   controls the stack nesting at that level). This is the loop I quoted at 
   you.

 - you have a _separate_ "unwinder()" for each page. It only unwinds 
   within that one page, and if the frame moves away from the page, it 
   immediately just returns that address, but it knows that it cannot be a 
   "valid" unwind address within that page.

That separate "unwind within one page" can well be using the dwarf info: 
it only really needs to verify that
 - it stays within the same page
 - the unwind info results in an aligned pointer at a strictly higher 
   address.
those two tests are trivial, and _guarantee_ that we don't access any 
half-way untrustworthy pointer.

See? No state machine. And notice how the dwarf info absolutely does _not_ 
need to know about the magic page-crossing events like interrupts, 
exceptions or anything else. Very much on purpose.

This is what we used to do with %ebp following (at least on x86), and what 
I tried to explain. Nothing complicated. And it's easy to set up, and the 
dawrf unwinder (which depends on complex data structures) can be trivially 
verified (ie it just stops immediately when it doesn't understand 
something, and "crosses a page" is such an event).

And the page-crossing events don't need to know _anything_ about the dwarf 
format (or %ebp, or any other unwinding details), and it can just depend 
on the chain of pages (which is trivial to set up - if the exception pages 
aren't already using the same format as the interrupt stack pages, it 
should at least not be hard to make them do that).

And the page-level unwinding data format is trivial. I don't think we even 
bothered verifying it on x86, but I guess some simple sanity-checking even 
there might be worth it (but unlike any dwarf unwinding, this is _not_ at 
all complicated, and there are absolutely _zero_ issues about compiler and 
linker versions etc etc).

			Linus
