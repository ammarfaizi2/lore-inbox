Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291965AbSBYBmG>; Sun, 24 Feb 2002 20:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292600AbSBYBlz>; Sun, 24 Feb 2002 20:41:55 -0500
Received: from [202.135.142.194] ([202.135.142.194]:17425 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S291965AbSBYBlq>; Sun, 24 Feb 2002 20:41:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mingo@elte.hu, Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Date: Mon, 25 Feb 2002 12:41:35 +1100
Message-Id: <E16fA92-0007en-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [PATCH] Lightweight userspace semaphores... 
In-reply-to: Your message of "Sun, 24 Feb 2002 17:23:59 -0800."
             <Pine.LNX.4.33.0202241719330.1420-100000@home.transmeta.com> 

In message <Pine.LNX.4.33.0202241719330.1420-100000@home.transmeta.com> you wri
te:
> 
> 
> On Mon, 25 Feb 2002, Rusty Russell wrote:
> >
> > Bugger.  How about:
> >
> > 	sys_sem_area(void *pagestart, size_t len)
> > 	sys_unsem_area(void *pagestart, size_t len)
> >
> > Is that sufficient?  Is sys_unsem_area required at all?
> 
> The above is sufficient, but I would personally actually prefer an
> interface more like
> 
> 	fd = sem_initialize();
> 	mmap(fd, ...)
> 	..
> 	munmap(..)
> 
> which gives you a handle for the semaphore.

No no no!  Implemented exactly that (and posted to l-k IIRC), and it's
*horrible* to use.

> Note that getting a file descriptor is really quite useful - it means that
> you can pass the file descriptor around through unix domain sockets, for
> example, and allow sharing of the semaphore across unrelated processes
> that way.

First, fd passing sucks: you can't leave an fd somewhere and wait for
someone to pick it up, and they vanish when you exit.  Secondly, you
have some arbitrary limit on the number of semaphores.  Thirdly,
someone has to own them.

Consider tdb, the Trivial Database.  There is no "master locking
daemon".  There is no way for the first opener (who then has to create
the semaphores in your model) to pass them to other openers: this is a
library.

With this interface, I can use them on the stack with clone().

Most importantly, I can place the semaphores in a file and have them
persistant.

lock(1), unlock(1) => fast semaphores in shell scripts!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
