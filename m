Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268208AbTBNB7K>; Thu, 13 Feb 2003 20:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268209AbTBNB7K>; Thu, 13 Feb 2003 20:59:10 -0500
Received: from dp.samba.org ([66.70.73.150]:59372 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268208AbTBNB7I>;
	Thu, 13 Feb 2003 20:59:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "Thu, 13 Feb 2003 20:16:19 -0300."
             <20030213201619.A2092@almesberger.net> 
Date: Fri, 14 Feb 2003 12:57:38 +1100
Message-Id: <20030214020901.22E6C2C002@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030213201619.A2092@almesberger.net> you write:
> m.au on Fri, Jan 17, 2003 at 01:27:56PM +1100
> 
> Sorry for the long pause ...
> 
> Rusty Russell wrote:
> > They gave us SMP.  What do we gain for your change?
> 
> Mainly a simpler interface - one that doesn't treat module unloading
> as such a special case, but just as yet another fairly regular
> synchronization problem.
> 
> This should also have a performance impact: the current approach
> puts "code locking" outside of the module, and "data locking" inside
> of it. Unifying this eliminates one layer of locking mechanisms.

Um, no.  You're special case "optimizing" it.

When you have an object which may vanish, the linux kernel idiom runs
something like this:

	write_lock()
	find available object in list
	inc object refcount
	write_unlock()

The writelock protects the infrastructure, the refcount protects the
object.  Deleting is done in two stages (mark deleted and drop
refcount, then whoever drops the refcount to 0 actually does the
free).  Usually "mark deleted" means simply remove from the list, but
not always.

The current module code uses exactly the same idiom for the code
itself: we use a heavily read-optimized lock, but that's an
implementation detail.

Now, could you instead lock all the (arbitrary, widespread, unrelated)
accesses to the object, instead of the object itself?  Sure.  It'd be
unique in the kernel, and involve changing the way every interface
works, and probably expose some of the complexity to every module
author (every workable implementation I've seen has this problem), but
you could do it.  See below for why I don't think it's worth it.

> Independent of this, we should fix the interfaces that give us
> unstoppable callbacks. These are just disasters waiting to happen,
> modules or no.

I assume you're referring to the many places where we assume that the
structure being added was not dynamically allocated, so don't bother
to protect against its deletion?

That is, of course, orthogonal.

And in general, I agree: not including a refcount is asking for
trouble.  But these reference counts are *not* free.  The module
reference counts, by comparison, can be made extremely cheap (see
implementation), because we can allocate a cacheline per cpu, and we
can bias "read" speed in preference of awful "write" speed.

In summary: the most obvious implementation is to lock to module as an
object separately from any objects it might create.  The current
implementation is extremely fast, requires neither module changes nor
(many) interface changes, and in effect canonicalizes a single
existing method of locking, which coders seem quite comfortable with.

Given these reasons, you can see why I no longer discuss new
implementation ideas with people 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

