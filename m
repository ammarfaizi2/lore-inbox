Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129625AbQKVSjp>; Wed, 22 Nov 2000 13:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129787AbQKVSjf>; Wed, 22 Nov 2000 13:39:35 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:54535 "HELO ms2.inr.ac.ru")
        by vger.kernel.org with SMTP id <S129625AbQKVSjR>;
        Wed, 22 Nov 2000 13:39:17 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011221809.VAA20851@ms2.inr.ac.ru>
Subject: Re: [BUG] 2.2.1[78] : RTNETLINK lock not properly locking ?
To: willy.LKml@free.FR (Willy Tarreau)
Date: Wed, 22 Nov 2000 21:09:03 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <974885943.3a1b9437847da@imp.free.fr> from "Willy Tarreau" at Nov 22, 0 12:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>    - it will nearly never allow concurrent accesses (seems to be what was
>      intented when it was written)

Never, to be more exact. Concurrent accesses are allowed only with rtnetlink.

In 2.4 it is always exclusive, because shared access turned out to
be mostly useless.


>    - it will not always prevent concurrent accesses, which is weird because
>      rtnl_lock() only relies on rtnl_shlock() (and exlock, which is empty) to
>      protect sensible areas

It is linux-2.2, guy. 8) "threads" are not threaded there.

Semaphores (rtnl_lock, particularly) protects only areas, which
are going to _schedule_ excplicitly or implicitly.


> ok, Dave. But the code in dev_ioctl() actually is :
> 
>   rtnl_lock();
>   ret = dev_ifsioc(&ifr, cmd);
>   rtnl_unlock();
> 
> if only these lock/unlock guarantee this atomicity, then I can't
> see why my A,B,C case could not work. If this is because the
> kernel has been locked somewhere else, then why are the locks
> still needed ?

Please, read comments. People used to consider comments as something
decorative, but they are not. 

The first group of ioctls (no lock!):

		/*
		 *	These ioctl calls:
		 *	- can be done by all.
		 *	- atomic and do not require locking.
		 *	- return a value
		 */


The second group of ioctls (locked):

		/*
		 *	These ioctl calls:
		 *	- require superuser power.
		 *	- require strict serialization.
		 *	- do not return a value
		 */

Any questions?


>	 The author of rtnetlink.h has been very precautious
> about the atomicity of these locks when CONFIG_RTNETLINK is set.

Sorry...

/* NOTE: these locks are not interrupt safe, are not SMP safe,
 * they are even not atomic. 8)8)8) ... and it is not a bug.
etc.

Do you call this "very precautios"? 8)

I would say that I was absolutely careless about their atomicity
because it is useless before BKL has been removed.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
