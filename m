Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129938AbQJ0Bhp>; Thu, 26 Oct 2000 21:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130434AbQJ0Bhf>; Thu, 26 Oct 2000 21:37:35 -0400
Received: from cb58709-a.mdsn1.wi.home.com ([24.17.241.9]:23563 "EHLO
	prism.flugsvamp.com") by vger.kernel.org with ESMTP
	id <S129938AbQJ0BhS>; Thu, 26 Oct 2000 21:37:18 -0400
Date: Thu, 26 Oct 2000 20:35:45 -0500 (CDT)
From: Jonathan Lemon <jlemon@flugsvamp.com>
Message-Id: <200010270135.e9R1ZjS39822@prism.flugsvamp.com>
To: Dan Kegel <dank@alumni.caltech.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux's implementation of poll() not scalable?
X-Newsgroups: local.mail.linux-kernel
In-Reply-To: <local.mail.linux-kernel/39F8D09B.F55AD0FD@alumni.caltech.edu>
In-Reply-To: <local.mail.linux-kernel/Pine.LNX.4.10.10010260936330.2460-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <local.mail.linux-kernel/39F8D09B.F55AD0FD@alumni.caltech.edu> you write:
>Linus Torvalds wrote:
>> I'd much rather have an event interface that is documented to be edge-
>> triggered and is really _lightweight_, than have another interface that
>> starts out with some piggy features.
>
>Agreed (except for that 'edge-triggered' part), but I don't think
>'level-triggered' implies piggy.   I haven't benchmarked whether
>kqueue() slows down the networking layer of FreeBSD yet; do you
>suspect maintaining the level-triggered structures actually is
>a bottleneck for them?

I really don't think it's a bottleneck.  At the moment, all events
are maintained on a linked list.  To dequeue an event, we simply:

	1. take the event on the front of the list.
	2. validate event.  (call filter function)
	3. copy event into return array.
	4. put event back on end of list.

If the `EV_ONESHOT' flag is set, we skip steps 2 & 4, and destroy
the event after it is returned to the user.
    (we want to wait only once for this particular event)

If the `EV_CLEAR' flag is set, we skip step 4.
    (pure edge-triggered delivery)

Step 4 is pretty simple, just re-insertion back onto the queue.

If you eliminate Step 2, then you have a `correctness' issue; where
the application must deal with stale events.  The validation function
is equally lightweight and doesn't (IMO) cause a performance problem.


>> ... the "re-bind()" approach works very simply, and means that the
>> overhead of testing whether the event is still active is not a generic
>> thing that _always_ has to be done, but something where the application
>> can basically give the kernel the information that "this time we're
>> leaving the event possibly half-done, please re-test now".
>
>Hmm.  I don't like the extra system call, though.  Any chance you'd be
>willing to make get_events() take a vector of bind requests, so we can
>avoid the system call overhead of re-binding?  (Or is that too close
>to kqueue for you?)

IMO, I'd think that the calls should be orthogonal.  If the "get_events()"
call returns an array, why shouldn't the "bind_request()" call as well?
Otherwise you're only amortizing the system calls in one direction.


>And are you sure apps will always know whether they need to rebind?
>Sometimes you're faced with a protocol stack which may or may not
>read the requests fully, and which you aren't allowed to change.
>It'd be nice to still have a high-performance interface that can deal with 
>that situation.

Agreed.
--
Jonathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
