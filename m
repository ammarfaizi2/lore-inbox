Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263924AbUDFRoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUDFRoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:44:20 -0400
Received: from web40511.mail.yahoo.com ([66.218.78.128]:55850 "HELO
	web40511.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263924AbUDFRoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:44:16 -0400
Message-ID: <20040406174412.7850.qmail@web40511.mail.yahoo.com>
Date: Tue, 6 Apr 2004 10:44:12 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040406133246.GA19091@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If stack will shrink - i'll come up with something.
Rearchitecture of LISP interpreter - is too much work.
(and I'm lazy - I prefer computer to do a work, not me
:-)

I checked what is going on with the stack - it is used
to pass parameters, some functions have one or two
local variables (4 bytes each) and that's it.

I like to develop tools and general solutions :-) To
solve the stack problem in a way which will not cause
big changes in any existing code - I can make stack
virtualization. API can be different, but idea is the
same. Task has some memory allocated by malloc
(vstack) which is used for saving data from real
stack. One of the APIs - scall function:

scall(pointer_to_vstack, number_of_arguments,
pointer_to_function_to_call, arg1, arg2,...)

scall checks if real stack is full enough - it stores
it's content in the vstack and moves %esp to the
bottom of the real stack. When user function returns -
information from vstack moves to the real one (one
movl instruction at Intel x86).

In case of LISP there is only one place where it will
be enough to use scall - eval function.

In other subsystems - it can be needed to call in a
few places. But in such way a new 4K stack could be
used without serious rewriting of existing code.

vstack can grow dynamically if needed (within defined
limit).

Serge.

--- Helge Hafting <helgehaf@aitel.hist.no> wrote:
> On Mon, Apr 05, 2004 at 10:05:37AM -0700, Sergiy
> Lozovsky wrote:
> > > Consider rewriting your function to use
> allocated
> > > memory instead of stack, this isn't all that
> hard.
> > 
> > I put LISP interpreter inside the Kernel -
> > http://vxe.quercitron.com
> > 
> > It works, but it use a lot of stack memory. It's
> > impossible to rewrite it easily, though I'll
> > investigate why exactly it uses so much of stack
> > memory (though it's nature of LISP). There are no
> > serious kernel memory allocation (as of my
> interpreter
> > code review, only function calls; recursions in
> LISP
> > application itself are eliminated for sure), but
> I'll
> > trace stack usage more thouroughly.
> > 
> Consider this.  We're currently experimenting with a
> transition from 8k to 4k stacks on x86, and that is
> considered a very good thing.  Allocating a single-
> page stack is easy, two (contigous) pages might
> fail.
> 
> So a bigger kernel stack is out.
> 
> As for rewriting code so it doesn't use stack - it
> _is_ easy, but it might be a lot of _work_.
> 
> The simple approach is to replace all (big) stack
> allocations with an explicit stack structure that
> you manages
> on the heap. There'll be more code, but it won't be
> slower
> because all the extra code is stuff that happen
> automatically
> with the hw stack. (I.e. stuff the compiler normally
> take
> care of.)
> 
> There is some more work if your interpreter also
> does deep recursion.
> It involves making one big function of those that do
> the recursion
> and manage the "calls" yourself with an array and a
> switch statement.
> Again, not particularly hard, but it could take some
> time to implement.
> 
> Helge Hafting  


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
