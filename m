Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVLTUMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVLTUMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVLTUMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:12:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751050AbVLTUMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:12:39 -0500
Date: Tue, 20 Dec 2005 12:10:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nicolas Pitre <nico@cam.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
In-Reply-To: <20051220193423.GC24199@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0512201202200.4827@g5.osdl.org>
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au>
 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org> <20051220193423.GC24199@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, Russell King wrote:
> 
> Also, Nico has an alternative idea for mutexes which does not
> involve decrementing or incrementing - it's an atomic swap.
> That works out at about the same cycle count on non-Intel ARM
> CPUs as the present semaphore path.  I'm willing to bet that
> it will be faster than the present semaphore path on Intel ARM
> CPUs.

Don't be so sure, especially not in the future.

An atomic "swap" operation is, from a CPU design standpoint, fundamentally 
more expensive that a "load + store".

Now, most ARM architectures don't notice this, because they are all 
in-order, and not SMP-aware anyway. No suble memory ordering, no nothing. 
Which is the only case when "swap" basically becomes a cheap "load+store".

What I'm trying to say is that a plain "load + store" is almost always 
going to be the best option in the long run.

It's also almost certainly always the best option for UP + non-preempt, 
for both present and future CPU's. The reason is simply that a 
microarchitecture will _always_ be optimized for that case, since it's 
pretty much by definition the common situation.

Is preemption even the common case on ARM? I'd assume not. Why are people 
so interested in the preemption case? IOW, why don't you just do

	ldr  lr,[%0]
	subs lr, lr, %1
	str  lr,[%0]
	blmi failure

as the _base_ timings, since that should be the common case. That's the 
drop-dead fastest UP case.

There's an additional advantage of the regular load/store case: if some 
CPU has scheduling issues, you can actually write this out as C code (with 
an extra empty ASM to make sure that the compiler doesn't move anything 
out of the critical region). Again, that probably doesn't matter on most 
ARM chips, but in the general case it sure does matter.

(Btw, inlining _any_ of these except perhaps the above trivial case, is 
probably wrong. None of the ARM chips tend to have caches all that big, I 
bet).

			Linus
