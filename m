Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSKSASI>; Mon, 18 Nov 2002 19:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSKSASI>; Mon, 18 Nov 2002 19:18:08 -0500
Received: from picante.ne.client2.attbi.com ([24.91.80.18]:9209 "EHLO
	habanero.picante.com") by vger.kernel.org with ESMTP
	id <S265276AbSKSASG>; Mon, 18 Nov 2002 19:18:06 -0500
Message-Id: <200211190023.gAJ0NZmU001209@habanero.picante.com>
From: Grant Taylor <gtaylor+lkml_abbje111802@picante.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ... 
In-reply-to: Your message of "Mon, 18 Nov 2002 17:31:25 EST."
             <20021118223125.GB14649@mark.mielke.cc> 
Date: Mon, 18 Nov 2002 19:23:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Mark Mielke <mark@mark.mielke.cc> writes:

>> OTOH, I really hate the "user pointer in struct epollfd" thing...

> Are you saying you see no way of using the 'user pointer in struct
> epollfd' to accelerate event dispatching?

No, I'm saying that's it's a tricky and unusual thing, and I'm not
convinced that eliminating an fd array will make a substantial
difference, cache or no.

> For a perfectly good example of a use for it that has nothing to do
> with pointers, consider the possibility that the structure could
> hold a priority number [...] to sort high priority events before low
> priority events without having to dereference every single fd?

Sure, but...

> I would even tend to delay executing low priority events until
> epoll_wait(0) stopped telling me about high priority events.

...for this to work, you have to stow events over epoll calls.  The
sensible place to store these is in your per-fd structure.  So you
still don't save the access to your per-event structure, just the one
array index lookup.

If you do priorities, you *must* do this; otherwise you will be
processing all events as they arrive in userspace.  Merely doing them
in priority order will produce a slightly reduced but still O(n)
latency for high priority events, rather than roughly bounded latency
as is usually the intent.

BTW it is also possible to implement event prioritization in
kernelspace.  You just [e]poll several sets of epolled fd's and take
the most interesting set of events each time.  Unless, that is, the
new syscall interface broke this...

> An opaque field gives me, the event loop designer, freedom. No
> opaque field because a few event loop designers are convinced that
> it will be used as a data pointer, and they believe this to be
> wrong, is a limitation. 

Bah.  Freedom causes holes in feet.

Flexible interfaces are invariably a pain for the users or the
developers or both.  Inflexible interfaces are less painful - they
either work or they don't.  As long as you avoid the nonworking sort,
life is wonderful.

> epoll provides a very efficient alternative to poll.  Forcing epoll
> to look like poll somewhat defeats the purpose. I don't mind having

No argument here; it might even be handy for epoll to do other things,
but this hinting feature just feels wrong.  (Even "other things" would
probably be better implemented through standard poll or some other
non-specialized mechanism).

To the coder go the spoils; we'll see what Davide does.  And what
Linus lets in...

--
Grant Taylor - gtaylor<at>picante.com - http://www.picante.com/~gtaylor/
  Linux Printing Website and HOWTO:  http://www.linuxprinting.org/
