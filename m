Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317650AbSFRWbP>; Tue, 18 Jun 2002 18:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317651AbSFRWbN>; Tue, 18 Jun 2002 18:31:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47580 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317650AbSFRWbH>;
	Tue, 18 Jun 2002 18:31:07 -0400
Date: Wed, 19 Jun 2002 00:28:27 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: David Schwartz <davids@webmaster.com>
Cc: mgix@mgix.com, Robert Love <rml@tech9.net>, <root@chaos.analogic.com>,
       Chris Friesen <Chris.Friesen@mail.elte.hu>,
       <cfriesen@nortelnetworks.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
In-Reply-To: <20020618204237.AAA5802@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.4.44.0206190018310.23460-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jun 2002, David Schwartz wrote:

> 	Exactly. This is the UNIX tradition of static and dynamic
> priorities. The more polite you are about yielding the CPU when you
> don't need it, the more claim you have to getting it when you do need
> it.

firstly, the thing that defines the scheduler's implementation details is
not tradition but actual, hard, verifiable use. If you've ever seen
sched_yield() code under Linux then you'll quickly realize that it's
mainly used as a "oh damn, i cannot continue now, i have no proper kernel
object to sleep on, lets busy-wait" kind of mechanizm. (Which, by the way,
is as far from polite as it gets.)

secondly, i'd like to ask everyone arguing one way or other, and this
means you and Robert and everyone else as well, to actually read and think
about the fix i did.

The new implementation of sched_yield() is *not* throwing away your
timeslices immediately. In fact it first tries it the 'polite' way to get
some progress by gradually decreasing its priority - *IF* that fails (and
it has to fail and keep looping for at least ~10 times if there are
default priorities) then it will start dropping away timeslices - one by
one. That gives another 20 opportunities for the task to actually get some
work done. Even after this we still let the task run one more jiffy.
*THEN* only is the task pushed back into the expired array.

so the tests quoted here were the extreme example: a task did nothing but
sched_yield(). And the modified scheduler did a good job of supressing
this process, if there was other, non-sched_yield() work around. A
database process with a casual sched_yield() call should not see much
effect.

	Ingo

