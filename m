Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVLST25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVLST25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVLST25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:28:57 -0500
Received: from kanga.kvack.org ([66.96.29.28]:48617 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S964891AbVLST24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:28:56 -0500
Date: Mon, 19 Dec 2005 14:25:37 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219192537.GC15277@kvack.org>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 11:11:03AM -0800, Linus Torvalds wrote:
> On Mon, 19 Dec 2005, Ingo Molnar wrote:
> > 
> > in fact, generic mutexes are _more_ fair than struct semaphore in their 
> > wait logic. In the stock semaphore implementation, when a waiter is 
> > woken up, it will retry the lock, and if it fails, it goes back to the 
> > _tail_ of the queue again - waiting one full cycle again.
> 
> Ingo, I don't think that is true.
> 
> It shouldn't be true, at least. The whole point with the "sleeper" count 
> was to not have that happen. Of course, bugs happen, so I won't guarantee 
> that's actually true, but ..

The only thing I can see as an improvement that a mutex can offer over 
the current semaphore implementation is if we can perform the same 
optimization that spinlocks perform in the unlock operation: don't use 
a locked, serialising instruction in the up() codepath.  That might be 
a bit tricky to implement, but it's definately a win on the P4 where the 
cost of serialisation can be quite high.

> [ Oh.  I'm looking at the semaphore code, and I realize that we have a 
>   "wake_up(&sem->wait)" in the __down() path because we had some race long 
>   ago that we fixed by band-aiding over it. Which means that we wake up 
>   sleepers that shouldn't be woken up. THAT may well be part of the 
>   performance problem.. The semaphores are really meant to wake up just 
>   one at a time, but because of that race hack they'll wake up _two_ at a 
>   time - once by up(), once by down().
> 
>   That also destroys the fairness. Does anybody remember why it's that 
>   way? ]

History?  I think that code is very close to what was done in the pre-SMP 
version of semaphores.  It is certainly possible to get rid of the separate 
sleepers -- parisc seems to have such an implementation.  It updates 
sem->count in the wakeup path of __down().

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
