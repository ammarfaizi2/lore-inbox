Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131976AbQLVQEX>; Fri, 22 Dec 2000 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132005AbQLVQED>; Fri, 22 Dec 2000 11:04:03 -0500
Received: from monza.monza.org ([209.102.105.34]:27142 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131976AbQLVQDy>;
	Fri, 22 Dec 2000 11:03:54 -0500
Date: Fri, 22 Dec 2000 07:33:19 -0800
From: Tim Wright <timw@splhi.com>
To: Daniel Phillips <phillips@innominate.de>
Cc: Paul Cassella <pwc@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
Message-ID: <20001222073319.A2190@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Daniel Phillips <phillips@innominate.de>,
	Paul Cassella <pwc@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A42B353.D0D249C1@innominate.de> <Pine.LNX.4.21.0012212221220.32526-100000@mindy.americas.sgi.com> <3A433F14.3F3871A5@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A433F14.3F3871A5@innominate.de>; from phillips@innominate.de on Fri, Dec 22, 2000 at 12:46:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 12:46:28PM +0100, Daniel Phillips wrote:
[...]
> Granted, it's just an example, but it doesn't make sense to wake up more
> dmabuf_alloc waiters than you actually have buffers for.  You do one
> up() per freed buffer, and the semaphore's wait queue better be fifo or
> have some other way of ensuring a task doesn't languish there.  (I don't
> know, does it?)
>  

Sorry, I could have picked a clearer example. You are correct - it doesn't
make sense to wake up more waiters than you can satify if you know this at
the time. As Paul mentioned, the idea here is that we may have freed
multiple buffers, and so we wake all the consumers and let them fight it out.
At least in DYNIX/ptx, semaphores are exclusively FIFO. This gives wake-one
semantics by default, and prevents starvation.

> > The example wasn't meant to be an ideal use of sv's, but merely as an
> > example of how they could be used to achieve the same behavior as the code
> > that was posted.
> 
> Yes, and a third example of the 'unlock/wakeup_and_sleep' kind of
> primitive - there seems to be a pattern.  I should at least take a look
> and see if up_down is easy or hard to implement.
> 

One general rule to remember is that if you need to take multiple locks, then
you need to always take them in the same order to avoid deadlocks. One
simple, if crude way of doing this if they're not two fixed locks is to
always take the lock with the lower address first. I don't know if this
will help in this case, but it looks like you probably have to play with
the rw locks for the wait queues to make this atomic.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
