Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318339AbSHEIem>; Mon, 5 Aug 2002 04:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318340AbSHEIem>; Mon, 5 Aug 2002 04:34:42 -0400
Received: from ns.suse.de ([213.95.15.193]:32523 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318339AbSHEIel>;
	Mon, 5 Aug 2002 04:34:41 -0400
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode linux]
References: <1028294887.18635.71.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <Pine.LNX.4.44.0208031332120.7531-100000@localhost.localdomain.suse.lists.linux.kernel> <m3u1mb5df3.fsf@averell.firstfloor.org.suse.lists.linux.kernel> <ail2qh$bf0$1@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Aug 2002 10:38:16 +0200
In-Reply-To: torvalds@transmeta.com's message of "5 Aug 2002 07:36:55 +0200"
Message-ID: <p73ado1k8ef.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:


> >This is because the signal save/restore does a lot of unnecessary stuff.
> >One optimization I implemented at one time was adding a SA_NOFP signal
> >bit that told the kernel that the signal handler did not intend 
> >to modify floating point state (few signal handlers need FP) It would 
> >not save the FPU state then and reached quite some speedup in signal
> >latency. 
> >
> >Linux got a lot slower in signal delivery when the SSE2 support was
> >added. That got this speed back.
> 
> This will break _horribly_ when (if) glibc starts using SSE2 for things
> like memcpy() etc.
> 
> I agree that it is really sad that we have to save/restore FP on
> signals, but I think it's unavoidable. Your hack may work for you, but
> it just gets really dangerous in general. having signals randomly
> subtly corrupt some SSE2 state just because the signal handler uses
> something like memcpy (without even realizing that that could lead to
> trouble) is bad, bad, bad.

I think the possibility at least for memcpy is rather remote. Any sane
SSE memcpy would only kick in for really big arguments (for small
memcpys it doesn't make any sense at all because of the context save/possible
reformatting penalty overhead). So only people doing really
big memcpys could be possibly hurt, and that is rather unlikely.

But your point stands, one definitely needs to be very careful with it.

Also for special things like UML who can ensure their environment is sane it 
could be still an useful optimization. I did it originally for async IO 
handling in some project. At least offering the choice does not hurt.
If it wcould speed up UML I think it would be certainly worth it.

After all Linux should give you enough rope to shot yourself in the foot ;)

> 
> In other words, "not intending to" does not imply "will not".  It's just
> potentially too easy to change SSE2 state by mistake. 
> 
> And yes, this signal handler thing is clearly visible on benchmarks. 
> MUCH too clearly visible.  I just didn't see any safe alternatives
> (and I still don't ;( )

In theory you could do a superhack: put the FP context into an unmapped
page on the stack and only save with lazy FPU or access to the unmapped
page. Unfortunately the details get too nasty
(where to find the unmapped page? is the tlb manipulation worth it if the
page was mapped? how to store the address of the unmapped page for nested 
signal handlers for the page fault handler?) so I discarded this idea.

-Andi


