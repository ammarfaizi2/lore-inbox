Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbVLST4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVLST4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVLST4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:56:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4745 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964925AbVLST4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:56:37 -0500
Date: Mon, 19 Dec 2005 11:55:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
In-Reply-To: <20051219192537.GC15277@kvack.org>
Message-ID: <Pine.LNX.4.64.0512191148460.4827@g5.osdl.org>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de>
 <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu>
 <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Dec 2005, Benjamin LaHaise wrote:
> 
> The only thing I can see as an improvement that a mutex can offer over 
> the current semaphore implementation is if we can perform the same 
> optimization that spinlocks perform in the unlock operation: don't use 
> a locked, serialising instruction in the up() codepath.  That might be 
> a bit tricky to implement, but it's definately a win on the P4 where the 
> cost of serialisation can be quite high.

Good point. However, it really _is_ hard, because we also need to know if 
the mutex was under contention. A spinlock doesn't care, so we can just 
overwrite the lock value. A mutex would always care, in order to know 
whether it needs to do the slow wakeup path. 

So I suspect you can't avoid serializing the unlock path for a mutex. The 
issue of "was there contention while I held it" fundamentally _is_ a 
serializing question.

> > [ Oh.  I'm looking at the semaphore code, and I realize that we have a 
> >   "wake_up(&sem->wait)" in the __down() path because we had some race long 
> >   ago that we fixed by band-aiding over it. Which means that we wake up 
> >   sleepers that shouldn't be woken up. THAT may well be part of the 
> >   performance problem.. The semaphores are really meant to wake up just 
> >   one at a time, but because of that race hack they'll wake up _two_ at a 
> >   time - once by up(), once by down().
> > 
> >   That also destroys the fairness. Does anybody remember why it's that 
> >   way? ]
> 
> History?

Oh, absolutely, I already checked the old BK history too, and that extra 
wake_up() has been there at least since before we even started using BK. 
So it's very much historical, I'm just wondering if somebody remembers far 
enough back that we'd know.

I don't see why it's needed (since we re-try the "atomic_add_negative()" 
inside the semaphore wait lock, and any up() that saw contention should 
have always been guaranteed to do a wakeup that should fill the race in 
between that atomic_add_negative() and the thing going to sleep). 

It may be that it is _purely_ historical, and simply isn't needed. That 
would be funny/sad, in the sense that we've had it there for years and 
years ;)

		Linus
