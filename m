Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135404AbRD0KE7>; Fri, 27 Apr 2001 06:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135444AbRD0KEt>; Fri, 27 Apr 2001 06:04:49 -0400
Received: from www.wen-online.de ([212.223.88.39]:64519 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135404AbRD0KEc>;
	Fri, 27 Apr 2001 06:04:32 -0400
Date: Fri, 27 Apr 2001 12:04:00 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: #define HZ 1024 -- negative effects?
In-Reply-To: <OE54ug1uBnF36bxQ3T100003b0d@hotmail.com>
Message-ID: <Pine.LNX.4.33.0104270848530.425-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have not tried it, but I would think that setting HZ to 1024
> > should make a big improvement in responsiveness.
> >
> > Currently, the time slice allocated to a standard Linux
> > process is 5*HZ, or 50ms when HZ is 100.  That means that you
> > will notice keystrokes being echoed slowly in X when you have
> > just one or two running processes,
>
> Rubbish.  Whenever a higher-priority thread than the current
> thread becomes runnable the current thread will get preempted,
> regardless of whether its timeslices is over or not.

(hmm.. noone mentioned this, and it doesn't look like anyone is
going to volunteer to be my proxy [see ionut's .sig].  oh well)

What about SCHED_YIELD and allocating during vm stress times?

Say you have only two tasks.  One is the gui and is allocating,
the other is a pure compute task.  The compute task doesn't do
anything which will cause preemtion except use up it's slice.
The gui may yield the cpu but the compute job never will.

(The gui won't _become_ runnable if that matters.  It's marked
as running, has yielded it's remaining slice and went to sleep..
with it's eyes open;)

Since increasing HZ reduces timeslice, the maximum amount of time
that you can yield is also decreased.  In the above case, isn't
it true that changing HZ from 100 to 1000 decreases sleep time
for the yielder from 50ms to 5ms if the compute task is at the
start of it's slice when the gui yields?

It seems likely that even if you're running a normal mix of tasks,
that the gui, big fat oinker that the things tend to be, will yield
much more often than the slimmer tasks it's competing with for cpu
because it's likely allocating/yielding much more often.

It follows that increasing HZ must decrease latency for the gui if
there's any vm stress.. and that's the time that gui responsivness
complaints usually refer to.  Throughput for yielding tasks should
also increase with a larger HZ value because the number of yields
is constant (tied to the number of allocations) but the amount of
cpu time lost per yield is smaller.

Correct?

(if big fat tasks _don't_ generally allocate more than slim tasks,
my refering to ionuts .sig was most unfortunate.  i hope it's safe
to assume that you can't become that obese without eating a lot;)

 	-Mike

