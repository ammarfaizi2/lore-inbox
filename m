Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311277AbSCLRTJ>; Tue, 12 Mar 2002 12:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311278AbSCLRSu>; Tue, 12 Mar 2002 12:18:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31502 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311277AbSCLRSj>; Tue, 12 Mar 2002 12:18:39 -0500
Date: Tue, 12 Mar 2002 09:17:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <frankeh@watson.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: <E16kgaz-0007ry-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0203120905280.19167-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Mar 2002, Rusty Russell wrote:
> > 
> > You've convinced me.
> 
> Damn.  Because now I've been playing with a different approach.

I don't think your current patch is very useful.

It's obviously slower, and while it is an interesting approach for not 
just lock generation but also for synchronization points, it doesn't seem 
to actually _buy_ you anything. And since the cookie isn't guaranteed to 
be unique, you can't actually use it as a synchronization point on its 
own, but must always still have some shared memory location as a 
confirmation for whatever the synchronization was.

Finally, waitqueue's (to me) always were about two big points:

 - natural race condition avoidance through ordering:

	current->state = sleeping;
	add_wait_queue();
	if (test)
		schedule();

   which you basically emulate with the "zero cookie" thing.

 - ability to wait on multiple events concurrently

   which you don't take any advantage of at all.

So you kind of missed the second big point of waitqueues, so the end
result really isn't any more fundamentally powerful than the (faster)  
specialized semaphore system call as far as I can tell.

In short, I would argue that this approach, while interesting, doesn't 
actually _buy_ you anything. 

Now, if you want to wake on any of N events, then a "add_wait_queue*N +
wait" approach actually makes sense. But quite frankly, once you are there 
you should really instead do full events, and go away and work together 
with Ben on the aio stuff instead of this.

So: interesting approach, but in its current form pointless as far as I 
can see.

		Linus

