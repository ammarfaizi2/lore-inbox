Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317630AbSGJVZ5>; Wed, 10 Jul 2002 17:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317632AbSGJVZt>; Wed, 10 Jul 2002 17:25:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61888 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317630AbSGJVZm>;
	Wed, 10 Jul 2002 17:25:42 -0400
Message-Id: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com>
To: Larry McVoy <lm@bitmover.com>
cc: Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>,
       Thunder from the hill <thunder@ngforever.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal 
In-reply-to: Your message of "Mon, 08 Jul 2002 22:21:27 PDT."
             <20020708222127.G11300@work.bitmover.com> 
Date: Wed, 10 Jul 2002 14:28:02 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
           v
    > With a narrowly defined and used lock, it is much less difficult to
           ^
    
Larry responded:
    If you were talking about replacing a big lock with one lock, you
    might have a point.  But you aren't.  You can't be, because by
    definition if you take out the big lock you have to put in lots
    of little locks.  And then you get discover all the problems that
    the BKL was hiding that you just exposed by removing it.

And this is bad ... how? A bad locking mechanism, or incorrect usage of
a good one, is exposed. Should it not be?
    
    If you think that managing those is easier than managing the BKL,
    you don't understand the first thing about threading.

So threading is difficult to manage or even impossible without a global
lock for everyone to use? True -- I suppose that would force people to
think about what they are locking and which lock is appropriate to avoid
unnecessary contention.  It would require that the new locks' scopes and
assumptions be documented instead of handed down verbally from 
teacher to student.  It would have the side effect of making it easier
for a newcomer to come up to speed on a particular section of code, thus
allowing a greater number of people to understand the code and offer fixes
or enhancements.
    
    I think the kernel crowd is starting to sense how complex things
    are getting and are pushing back a bit.  Don't fight them, this
    isn't IRIX/Dynix/PTX/AIX/Solaris.

In some ways, that's a shame.  All of those have valuable parts to them.

    It's Linux and part of the
    appeal, part of the reason you are here, is that it is (was) simple.

Feel free to return to version 7 anytime. Life was simpler with single
cpus and only physical memory.  It is true that more complex hardware
has demanded more complex software.

    All you are doing is suggesting that it should be more complex.
    I don't agree at all.

I respect your right to disagree, but I contest the assertion that
"all" we are doing is making it more complex.  In general, finer
grained locking is a good thing, as it isolates contention (both
present AND future) in areas that truly are contending for the same
resource.  As with all things, it is possible to overdo it.  While
certainly true on SMP machines, this is especially underscored with
NUMA machines.  Sometimes the cost of allowing other processors to have
access to a lock or set of data (and the attendant flushing and
reloading of caches) can actually make it more efficient to hold the
lock longer than is necessary for the simple operation you are
attempting.  This is the exception, however, not the rule, and is not a
reason to abandon finer-grained locking.

    > So can you define for me under what conditions the BKL is appropriate
    > to use?  
    
    Can you tell me for sure that there are no races introduced by your
    proposed change?

In many cases, no more than you can tell me, "for sure", what the
weather will be tomorrow.  I can tell you, after inspection, that I
*believe* there are no races and you would learn, after enough times,
that I'm right more often than not.  You'd learn that my word (and the
implied testing behind it) is sufficient. I don't expect anybody to
grant that right off. And even then, the world will find I'm still
wrong sometimes. This truly is the way Linux is supported now.

(And you can replace "I" with, I think, about any Linux luminary.)

The reason I asked the question is to point out that nobody CAN answer
it today.  That's bad.  Every subsystem should have either a maintainer
who can answer these sorts of questions, or clear documentation that
answers it for us. The BKL has (unfortunately) evolved beyond that.

This is exactly the supportability issue that reduction of the BKL will
address. Replacing an instance of it with a well-defined,
well-documented lock should make the new lock's use obvious to
newcomers, and the BKL's remaining uses marginally easier to
understand.

    Can you tell me the list of locks and what they cover in the last
    multi threaded OS you worked in?  I thought not.  Nobody could.

Off the top of my head? no. I'm not a walking encyclopedia.  From
comments and supporting documentation and supporting staff?  about
80%.  The 20% that could not be clearly identified tended to provide a
disproportionate number of bugs, and I think most people agreed they
were undesirable from a support standpoint.

Your argument seems to be, "things are very complicated right now but
they often work, so let's not change anything."  I would argue that
unless these things ARE understood, we are destined to spend a lot of
time uncovering bugs in the future -- so let's improve it now.

Rick
