Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbQJZQrt>; Thu, 26 Oct 2000 12:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129676AbQJZQrj>; Thu, 26 Oct 2000 12:47:39 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:29702 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129509AbQJZQrZ>; Thu, 26 Oct 2000 12:47:25 -0400
Date: Thu, 26 Oct 2000 09:44:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dan Kegel <dank@alumni.caltech.edu>
cc: "Eric W. Biederman" <ebiederm@biederman.org>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Linux's implementation of poll() not scalable?
In-Reply-To: <39F859C7.FC0A726F@alumni.caltech.edu>
Message-ID: <Pine.LNX.4.10.10010260936330.2460-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Oct 2000, Dan Kegel wrote:
> 
> With level-triggered interfaces like poll(), your chances
> of writing a correctly functioning program are higher because you
> can throw events away (on purpose or accidentally) with no consequences; 
> the next time around the loop, poll() will happily tell you the current
> state of all the fd's.

Agreed.

However, we also need to remember what got us to this discussion in the
first place. One of the reasons why poll() is such a piggy interface is
exactly because it tries to be "nice" to the programmer.

I'd much rather have an event interface that is documented to be edge-
triggered and is really _lightweight_, than have another interface that
starts out with some piggy features.

I do understand that level to some degree is "nicer", but everybody pretty
much agrees that apart from requireing more care, edge-triggered certainly
does everything the level-triggered interfaces do. 

For example, if you want to only partially handle an event (one of the
more valid arguments I've seen, although I do not agree with it actually
being all that common or important thing to do), the edge-triggered
interface _does_ allow for that. It's fairly easy, in fact: you just
re-bind the thing.

(My suggested "bind()" interface would be to just always add a newly bound
fd to the event queue, but I would not object to a "one-time test for
active" kind of "bind()" interface either - which would basically allow
for a poll() interface - and the existing Linux internal "poll()"
implementation actually already allows for exactly this so it wouldn't
even add any complexity).

> With edge-triggered interfaces, the programmer must be much more careful
> to avoid ever dropping a single event; if he does, he's screwed.
> This gives rise to complicated code in apps to remember the current
> state of fd's in those cases where the programmer has to drop events.

No, the "re-bind()" approach works very simply, and means that the
overhead of testing whether the event is still active is not a generic
thing that _always_ has to be done, but something where the application
can basically give the kernel the information that "this time we're
leaving the event possibly half-done, please re-test now".

Advantage: performance again. The common case doesn't take the performance
hit.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
