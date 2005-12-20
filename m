Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbVLTTqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVLTTqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVLTTqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:46:15 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:41407 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751047AbVLTTqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:46:14 -0500
Date: Tue, 20 Dec 2005 14:43:30 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nicolas Pitre <nico@cam.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
In-Reply-To: <20051220192018.GB24199@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0512201437120.11245@gandalf.stny.rr.com>
References: <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au>
 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain> <43A81DD4.30906@yahoo.com.au>
 <Pine.LNX.4.64.0512201049310.26663@localhost.localdomain>
 <20051220192018.GB24199@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2005, Russell King wrote:

> On Tue, Dec 20, 2005 at 11:35:22AM -0500, Nicolas Pitre wrote:
> > So 14 instructions total with preemption disabling, and that's with the
> > best implementation possible by open coding everything instead of
> > relying on generic functions/macros.
>
> I agree with your analysis Nicolas.
>
> However, don't forget to compare this with our existing semaphore
> implementation which is 9 instructions, or 8 for the SMP version.
>
> In total, this means that mutexes will be _FAR MORE EXPENSIVE_ on ARM
> than our semaphores.
>
> Forcing architectures down the "lets make everything generic" path
> does not always hack it.  It can't do by its very nature.  Generic
> implementations are *always* sub-optimal and it is pretty clear
> that any gain that mutexes _may_ give is completely wasted on ARM
> by the overhead of having a generic framework imposed upon us.
>
> So, to sum up, if this path is persued, mutexes will be a bloody
> disaster on ARM.  We'd be far better off sticking to semaphores
> and ignoring this mutex stuff.
>

So what's wrong with having the generic code, and for those with a fast
semapore add an arch specific?

#define mutex_lock down
#define mutex_unlock up
#define mutex_trylock(x) (!down_trylock(x))

Until the mutex code is updated to a fast arch specific implementation.

Let me restate, that the generic code should not be this, but each arch
can have this if they already went through great lengths in making a fast
semaphore.

Heck put the above defines in the generic code, with a define

linux/mutex.h:

#ifdef HAVE_ARCH_MUTEX
#include <asm/mutex.h>
#else

#ifdef HAVE_FAST_SEMAPHORE

#define <defines here>

#else

generic code here

#endif /* HAVE_FAST_SEMAPHORE */

#endif /* HAVE_ARCH_MUTEX */

-- Steve

