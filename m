Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264519AbRFJLwg>; Sun, 10 Jun 2001 07:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264521AbRFJLw0>; Sun, 10 Jun 2001 07:52:26 -0400
Received: from juicer39.bigpond.com ([139.134.6.96]:53755 "EHLO
	mailin8.bigpond.com") by vger.kernel.org with ESMTP
	id <S264520AbRFJLwS>; Sun, 10 Jun 2001 07:52:18 -0400
Message-Id: <m1593mW-001RQEC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Dawson Engler <engler@csl.Stanford.EDU>
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8 
In-Reply-To: Your message of "Sat, 09 Jun 2001 20:33:01 +0100."
             <19317.992115181@redhat.com> 
Date: Sun, 10 Jun 2001 21:53:24 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <19317.992115181@redhat.com> you write:
> 
> torvalds@transmeta.com said:
> >  Good point. Spinlocks (with the exception of read-read locks, of
> > course) and semaphores will deadlock on recursive use, while the BKL
> > has this "process usage counter" recursion protection.
> 
> Obtaining a read lock twice can deadlock too, can't it?
> 
> 	A		B
> 	read_lock()
> 			write_lock()
> 			...sleeps...
> 	read_lock()
> 	...sleeps...
> 
> Or do we not make new readers sleep if there's a writer waiting?

We can never[1] make new readers sleep if there's a writer waiting, as
Linus guaranteed that an IRQ handler which only ever grabs a read lock
means the rest of the code doesn't need to block interrupts on its
read locks (see Documentation/spinlock.txt IIRC).

Also, netfilter will break (brlocks inherit this property from
their spinlocks constituents).

Rusty.
[1] Well, we could, but we'd have to do a special "same CPU?" check,
    which would suck badly.
--
Premature optmztion is rt of all evl. --DK
