Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVLSTMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVLSTMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVLSTMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:12:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964885AbVLSTL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:11:58 -0500
Date: Mon, 19 Dec 2005 11:11:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
In-Reply-To: <20051219155010.GA7790@elte.hu>
Message-ID: <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de>
 <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Dec 2005, Ingo Molnar wrote:
> 
> in fact, generic mutexes are _more_ fair than struct semaphore in their 
> wait logic. In the stock semaphore implementation, when a waiter is 
> woken up, it will retry the lock, and if it fails, it goes back to the 
> _tail_ of the queue again - waiting one full cycle again.

Ingo, I don't think that is true.

It shouldn't be true, at least. The whole point with the "sleeper" count 
was to not have that happen. Of course, bugs happen, so I won't guarantee 
that's actually true, but ..

If you are woken up as a waiter on a semaphore, you shouldn't fail to get 
it. You will be woken first, and nobody else will get at it, because the 
count has been kept negative or zero even by the waiters, so that a 
fast-path user shouldn't be able to get the lock without going through the 
slow path and adding itself (last) to the list.

But hey, somebody should test it with <n> kernel threads that just do 
down()/up() and some make-believe work in between to make sure there 
really is contention, and count how many times they actually get the 
semaphore. That code has been changed so many times that it may not work 
the way it is advertized ;)

[ Oh.  I'm looking at the semaphore code, and I realize that we have a 
  "wake_up(&sem->wait)" in the __down() path because we had some race long 
  ago that we fixed by band-aiding over it. Which means that we wake up 
  sleepers that shouldn't be woken up. THAT may well be part of the 
  performance problem.. The semaphores are really meant to wake up just 
  one at a time, but because of that race hack they'll wake up _two_ at a 
  time - once by up(), once by down().

  That also destroys the fairness. Does anybody remember why it's that 
  way? ]

Ho humm.. That's interesting. 

		Linus
