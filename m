Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154773AbPH0SPY>; Fri, 27 Aug 1999 14:15:24 -0400
Received: by vger.rutgers.edu id <S154420AbPH0RwE>; Fri, 27 Aug 1999 13:52:04 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:14190 "EHLO neon.transmeta.com") by vger.rutgers.edu with ESMTP id <S154442AbPH0Roh>; Fri, 27 Aug 1999 13:44:37 -0400
Date: Fri, 27 Aug 1999 10:45:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.rutgers.edu>, "David S. Miller" <davem@redhat.com>, Richard Henderson <rth@cygnus.com>
Subject: Re: Linux-2.3.15..
In-Reply-To: <Pine.LNX.4.10.9908271831030.4003-100000@laser.random>
Message-ID: <Pine.LNX.4.10.9908271040440.1013-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Fri, 27 Aug 1999, Andrea Arcangeli wrote:
> 
> I guess the problem is the pipe code since I understood the old semaphores
> completly and there weren't SMP races there.

Well, I certainly saw strange behaviour. The trylock code seemed to be the
prime culprit - it tried to decrement the "waking" count, but it could end
up doing it too late so that people had already seen a increment from a
concurrent "up()".

I'm not saying the new code is bug-free, but it works for me where the old
one did not - and your claim that it is obviously broken is also obviously
wrong, see later..

> Your new semaphores seems completly buggy to me and I am surprised your
> kernel works without crash or corruption with them.

Well, you're not counting right..

> task1	task2		task3	   -> effect ->	count		sleepers
> -----	-----		-----			-----		--------
> 						1		0
> 
> ------- task 0 does a down() ------------------	0		0
> ------- here task 1,2,3 try to get the lock ---
> 
> down()						-1		1
> (I avoided the details here)
> schedule()
> 	down()					-2		1
> 	spin_lock()
> 	sleepers++				-2		2
> 	add_neg(1)				-1???		2
> 	sleepers = 1				-1		1
> 	schedule()
> 			down()
> 			spin_lock()
> 			sleepers++		-1		2

Wrong counting. The "down()" decremented count, so you have

						-2		2

which is exactly right, and explains why there will _not_ be two users in
the critical region at the same time.

			Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
