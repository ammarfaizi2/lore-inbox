Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129220AbQJ0Arm>; Thu, 26 Oct 2000 20:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129677AbQJ0Ard>; Thu, 26 Oct 2000 20:47:33 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:43762 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129220AbQJ0ArY>; Thu, 26 Oct 2000 20:47:24 -0400
Date: Thu, 26 Oct 2000 17:47:23 -0700
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: Linux's implementation of poll() not scalable?
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@biederman.org>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <39F8D09B.F55AD0FD@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <Pine.LNX.4.10.10010260936330.2460-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> However, we also need to remember what got us to this discussion in the
> first place. One of the reasons why poll() is such a piggy interface is
> exactly because it tries to be "nice" to the programmer.

poll() is a piggy interface because it is O(n) in polled file 
descriptors, not because of its level-triggered nature.

> I'd much rather have an event interface that is documented to be edge-
> triggered and is really _lightweight_, than have another interface that
> starts out with some piggy features.

Agreed (except for that 'edge-triggered' part), but I don't think
'level-triggered' implies piggy.   I haven't benchmarked whether
kqueue() slows down the networking layer of FreeBSD yet; do you
suspect maintaining the level-triggered structures actually is
a bottleneck for them?
 
> I do understand that level to some degree is "nicer", but everybody pretty
> much agrees that apart from requireing more care, edge-triggered certainly
> does everything the level-triggered interfaces do.

Agreed.
 
> For example, if you want to only partially handle an event (one of the
> more valid arguments I've seen, although I do not agree with it actually
> being all that common or important thing to do), the edge-triggered
> interface _does_ allow for that. It's fairly easy, in fact: you just
> re-bind the thing.
> 
> (My suggested "bind()" interface would be to just always add a newly bound
> fd to the event queue, but I would not object to a "one-time test for
> active" kind of "bind()" interface either - which would basically allow
> for a poll() interface - and the existing Linux internal "poll()"
> implementation actually already allows for exactly this so it wouldn't
> even add any complexity).
> ... the "re-bind()" approach works very simply, and means that the
> overhead of testing whether the event is still active is not a generic
> thing that _always_ has to be done, but something where the application
> can basically give the kernel the information that "this time we're
> leaving the event possibly half-done, please re-test now".

Hmm.  I don't like the extra system call, though.  Any chance you'd be
willing to make get_events() take a vector of bind requests, so we can
avoid the system call overhead of re-binding?  (Or is that too close
to kqueue for you?)

And are you sure apps will always know whether they need to rebind?
Sometimes you're faced with a protocol stack which may or may not
read the requests fully, and which you aren't allowed to change.
It'd be nice to still have a high-performance interface that can deal with 
that situation.
- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
