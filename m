Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbRDZHjc>; Thu, 26 Apr 2001 03:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135174AbRDZHjW>; Thu, 26 Apr 2001 03:39:22 -0400
Received: from t2.redhat.com ([199.183.24.243]:6132 "EHLO
	warthog.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135170AbRDZHjS>; Thu, 26 Apr 2001 03:39:18 -0400
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rw_semaphores, optimisations try #4 
In-Reply-To: Your message of "Wed, 25 Apr 2001 22:56:21 +0200."
             <20010425225621.B13531@athlon.random> 
Date: Thu, 26 Apr 2001 08:39:16 +0100
Message-ID: <8005.988270756@warthog.cambridge.redhat.com>
From: David Howells <dhowells@warthog.cambridge.redhat.com>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
> It seems more similar to my code btw (you finally killed the useless
> chmxchg ;).

CMPXCHG ought to make things better by avoiding the XADD(+1)/XADD(-1) loop,
however, I tried various combinations and XADD beats CMPXCHG significantly.

Here's a quote from Borland assembler manual I managed to dig out, giving i486
timings on memory access:

       ADDL/SUBL	3 cycles
       XADDL		4 cycles
       CMPXCHG		8 cycles (success) / 10 cycles (failure)
       LOCK		+1 cycle minimum on this CPU

In reality, however, XADDL gives at least as good a result as ADDL/SUBL, maybe
just a little bit better, but its hard to say. However, the penalty imposed on
the other CPU (when it has to flush it's cache) probably more than makes up
for the difference.

> I only had a short low at your attached patch, but the results are quite
> suspect to my eyes beacuse we should still be equally fast in the fast
> path and I should still beat you on the write fast path because I do a
> much faster subl; js while you do movl -1; xadd ; js, while according to
> your results you beat me on both. Do you have an explanation or you
> don't know the reason either?

	MOVL $1,EDX
	SUBL EDX,(EAX)

Works out faster than:

	SUBL $1,(EAX)

as well... probably due to an avoided stall when the instruction before the
snippet loads EAX from memory. Oh yes... "STC, SUBL" may also be faster too.

> I will re-benchmark the whole thing shortly. But before re-benchmark if you
> have time could you fix the benchmark to use the variable pointer and send
> me a new tarball?  For your code it probably doesn't matter because you
> dereference the pointer by hand anyways, but it matters for mine and we want
> to benchmark real world fast path of course.

No, not till this evening now, I'm afraid.

As for real-world benchmarks, I suspect the fastpath is going to be
sufficiently few cycles that it's drowned out by whatever bit of code is
actually using it, like my Wine server module, which is where all this started
for me.

David
