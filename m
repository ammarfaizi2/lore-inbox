Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQJZSJi>; Thu, 26 Oct 2000 14:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQJZSJ1>; Thu, 26 Oct 2000 14:09:27 -0400
Received: from smtp05.primenet.com ([206.165.6.135]:31930 "EHLO
	smtp05.primenet.com") by vger.kernel.org with ESMTP
	id <S129112AbQJZSJR>; Thu, 26 Oct 2000 14:09:17 -0400
From: Terry Lambert <tlambert@primenet.com>
Message-Id: <200010261808.LAA00925@usr08.primenet.com>
Subject: Re: kqueue microbenchmark results
To: tlambert@primenet.com (Terry Lambert)
Date: Thu, 26 Oct 2000 18:08:51 +0000 (GMT)
Cc: bright@wintelcom.net (Alfred Perlstein),
        davids@webmaster.com (David Schwartz),
        jlemon@flugsvamp.com (Jonathan Lemon), chat@FreeBSD.ORG,
        linux-kernel@vger.kernel.org
In-Reply-To: <200010260610.XAA11949@usr08.primenet.com> from "Terry Lambert" at Oct 26, 2000 06:10:52 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a long posting, with a humble beginning, but it has
a point.  I'm being complete so that no one is left in the
dark, or in any doubt as to what that point is.  That means
rehashing some history.

This posting is not really about select or Linux: it's about
interfaces.  Like cached state, interfaces can often be
harmful.

NB: I really should redirect this to FreeBSD, as well, since
there are people in that camp who haven't learned the lesson,
either, but I'll leave it in -chat, for now.

---

[ ... kqueue discussion ... ]

> Linux also thought it was OK to modify the contents of the
> timeval structure before returning it.

It's been pointed out that I should provide more context
for this statement, before people look at me strangely and
make circling motions with their index fingers around
their ears (or whatever the international sign for "crazy"
is these days).  So I'll start with a brief history.

The context is this: the select API was designed with the
idea that one might wish to do non-I/O related background
processing.  Toward this end, one could have several ways
of using the API:

1)	The (struct timeval *) could be NULL.  This means
	"block until a signal or until a condition on
	which you are selecting is true"; select is a BSD
	interface, and, until BSD 4.x and POSIX signals,
	the signal would actually call the handler and
	restart the select call, so in effect, this really
	meant "block until you longjmp out of a signal
	handler or until a condition on which you are
	selecting is true".

2)	The (struct timeval *) could point to the address
	of a real timeval structure (i.e. not be NULL); in
	that case, the result depended on the contents:

	a)	If the timeval struct was zero valued, it
		meant that the select should poll for one
		of the conditions being selected for in
		the descriptor set, and return a 0 if no
		conditions were true.  The contents of
		the bitmaps and timeval struct were left
		alone.

	b)	If the timeval struct was not zero valued,
		it meant that the select should wait until
		the time specified had expired since the
		system call was first started, or one of
		the conditions being selected for was true.
		If the timeout expired, then a 0 would be
		returned, but if one or more of the conditions
		were true, the number of descriptors on which
		true conditions existed would be returned.

Wedging so much into a single interface was fraught with peril:
it was undefined as to what would happen if the timeval specified
an interval of 5 seconds, yet there was a persistently rescheduled
alarm every 2 seconds, resulting in a signal handler call that did
_not_ longjmp... would the timer expire after 5 seconds, or would
the timer be considered to have been restarted along with the call?
Implementations that went both ways existed.  Mostly, programmers
used longjmp in signal handlers, and it wasn't a portability issue.

More perilous, the question of what to do with a partially
satisfied request that was interrupted with a timer or signal
handler and longjump (later, siginterrupt(2), and later POSIX
non-restart default behaviour).  This meant that the bitmap of
select events might have been modified already, after the
wakeup, but before the process was rescheduled to run.

Finally, the select manual page specifically reserved the right
to modify the contents of the timeval struct; this was presumably
so that you could either do accurate timekeeping by maintaining
a running tally using the timeval deficit (a lot of math, that),
or, more likely, to deal with the system call restart, and ensure
that signals would not prevent the select from ever exiting in
the case of system call restart.

So this was the select API definition.

---

Being pragmatists, programmers programmed to the behaviour of
the API in actual implementations, rather than to the strict
"letter of the law" laid down by the man page.  This meant
that select was called in loop control constructs, and that
the bitmaps were reinitialized each time through the loop.

It also meant that the timeval struct was not reinitialized,
since that was more work, and no known implementations would
modify it.  Pre-POSIX signals, signal handlers were handled on
a signal stack, as a result of a kernel trampoline outcall,
and that meant that a restarting system call would not impact
the countdown.

---

Linux came along, and implemented the letter of the law; the
machines were no sufficiently fast, and the math sufficiently
cheap, that it was now possible to usefully accurate timekeeping
using the inverted math required of keeping a running tally
using the timeval deficit.  So they implemented it: it was
more useful than the historical behaviour on most platforms.

And every program which used non-zero valued timeval struct
contents, and assumed that they would not be modified, broke.

---

And here we see the problem with defining interfaces instead of
defining protocols.  A protocol is unambiguous with regard to
implementation details.  But an API, unless a lot of work takes
place to make it sufficiently abstract, and a lot more work
takes place to define exactly what will happen in all allowed
conditions, and to preclude the possibility of undefined
behaviour, simply can not hide implementation details.



If what people are trying to do here is define a cross-platform
system interface (and if they succeed, it will be the first one
forced on mainstream UNIX by the Open Source community), then
it means that careful design which eliminates ambiguity is the
single most important consideration.  There can be no undefined
behaviour, like that of select's timeval struct updating, or the
equally ambiguous, but less problematic, bitmap content partial
update -- which could bite people on a new platform, but so far
has not.

---

I have seen the BSD kqueue interface called "overengineered";
but people apparently don't realize that it is not so much
that it has been thought out to that level of detail beforehand,
as it is that it is on its third revision.  It wasn't really
overengineered to where it is today: it has matured to where it
is today.

Just as poll (however much I disdain it for select, in favor of
select's more universal platform portability) is a more mature
interface than select, and resolves problems in the select
design.  Poll is not an overengineered interface, it is a more
mature version of the select interface.

---

FWIW: except for platform-specific applications, which I've tried
very hard to avoid writing since the early 1980's or so, I will
probably be very conservative in my adoption of a kqueue interface,
whatever it ends up looking like, just as I've been conservative in
my adoption of poll (and, untill 1989, my adoption of select, since
there are other ways to solve the multiple input stream problem,
without needing a select, poll, or kqueue, and which work all
the way back to V7 UNIX).  Unless there's a problem that can not
be solved in any other way, such as performance or footprint, I'll
stick to tools that are cross-platform.

On general principles, it'd be a good idea if BSD and Linux
ended up with the same unambiguous interface.  The wider an
interface is adopted, the quicker you will see people who can't
afford to be nailed to the cross of a single platform willing
to adopt it in their code.  Ambiguity of any kind will hinder
that adoption, and would certainly prevent adoption by mainstream
UNIX: if you have to code it differently on different platforms,
then you might as well code it differently on their platform, too.


					Terry Lambert
					terry@lambert.org
---
Any opinions in this posting are my own and not those of my present
or previous employers.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
