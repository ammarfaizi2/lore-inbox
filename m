Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbSKRSek>; Mon, 18 Nov 2002 13:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSKRSek>; Mon, 18 Nov 2002 13:34:40 -0500
Received: from picante.ne.client2.attbi.com ([24.91.80.18]:14071 "EHLO
	habanero.picante.com") by vger.kernel.org with ESMTP
	id <S263281AbSKRSei>; Mon, 18 Nov 2002 13:34:38 -0500
Message-Id: <200211181840.gAIIehmU026723@habanero.picante.com>
From: Grant Taylor <gtaylor+lkml_cgeaa111802@picante.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
Date: Mon, 18 Nov 2002 13:40:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This is sort of a rehash of a private email or two; Davide asked me
  to air my objections... ]

Davide Libenzi writes:

> I received quite a few request to extend the event structure to have
> space for an opaque user data object. The eventpoll event structure
> will turn to be:
> 
> struct epollfd {
>        int fd;
>        unsigned short int events, revents;
>        unsigned long obj;
> };

NOOOO!!!!!

As it stands, it's very easy to write an event dispatching layer that
runs over both epoll and poll.  You write a little function that,
somehow, gathers events from the kernel in the form of a "struct
pollfd" array, and then the same code can process these events for
both poll and epoll.  If epoll deviates from returning pollfd's, then
there needs to be mapping code or duplicate event dispatch logic for
two different yet substantively similar structures.

More importantly, the whole notion of userspace storing pointers (and
don't kid yourself, that's what people will use it for) in the kernel
is a little suspect.  At best you get some slightly awkward caveats.
For example, when userspace decides to free or move something, it has
to tell the kernel via a syscall AND manually scrub the epollfd's
present in the userspace-owned part of the event mapping.

I also don't think there is a performance argument for this feature.
The usual thing is an array lookup indexed on the fd, and that should
be entirely workable for at least as long as the kernel keeps fd's in
an array.

I'm open to epoll returning non-pollfd records if we find that there
is useful information that should be passed to userspace that way, but
I don't think this is it.

> I was talking to Ulrich Drepper about adding epoll bits inside
> glibc. His first objection was to store epoll bits inside poll.h,
> that IMHO is wrong because epoll semantics are completely different
> from poll(). 

> My idea of the <sys/epoll.h> include file would be this:

> #ifndef _SYS_EPOLL_H
> #define _SYS_EPOLL_H 1
> 
> #include <bits/poll.h>
> [...]

> But he does not like epoll to include <bits/poll.h> and he would
> like epoll to redefine POLLIN, POLLOUT, ... to EPOLLIN, EPOLLOUT,
> ...

> In my opinion it is right for epoll to include <bits/poll.h> because
> those are bits that f_op->poll() returns, and renaming those bits
> inside another include file will require more maintainance. If the
> kernel will be extended to support more POLL* bits, they will have
> to go only inside <bits/poll.h> w/out having another file to be
> updated IMHO.

I'm with you on this one, mostly for the same reasons I disagree with
the userdata thing.  It just adds work to have to do things
differently.

The various flavors of signals for event delivery all give you normal
poll bits and not oddball "SIGPOLLFOO" mechanism-specific bits.  If we
continue adding new mechanisms with new bits, we'll rapidly run out,
at least on 32 bit machines.

I appreciate the interface cleanliness direction the library people
are coming from, but I don't think it's useful here.  The meaning of
the event is a function of both the event (the struct pollfd) and the
event arrival (via epoll, poll, sigio, sig32+, etc).

-- 
Grant Taylor - gtaylor<at>picante.com - http://www.picante.com/~gtaylor/
   Linux Printing Website and HOWTO:  http://www.linuxprinting.org/
