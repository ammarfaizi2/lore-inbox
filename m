Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131545AbRCXCbr>; Fri, 23 Mar 2001 21:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131546AbRCXCbh>; Fri, 23 Mar 2001 21:31:37 -0500
Received: from mout0.freenet.de ([194.97.50.131]:29369 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S131545AbRCXCbV>;
	Fri, 23 Mar 2001 21:31:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Date: Sat, 24 Mar 2001 03:30:29 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01032403302905.05124@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi together,

seems like a hot discussion going on, but I couldn't resist and would like to
throw in my $0.02.

Besides misunderstandings and general displeasure, some very interesting
facts have shown up in the discussion (oh, yeah), which I'd like to know more
about, and just extend them with a bit of my latest experience regarding
memory usage.

First one is about buffer/inode cache. What I expect as a medium-skilled
system hacker would be: Before giving up with an OOM-whatever,

a) all non-dirty buffers should be freed, possibly giving tons of memory
b) all dirty buffers should be flushed and freed, alas

I'm not sure if both is tried ATM, but I think enough experts are here to
answer my questions :)

What I saw lately was some general system sluggishness after copying very big
files (ripping a CD image to disk) - it seems the system has paged out most
of its processes (including the calling bash shell) in favor of the copying
task, just for buffers! Up to which degree is this reasonable? It seems to
slow down the system when using swap, so for this task I better had
deactivated it. Not what one "intuitively" expects.

So, what is the second important point? The current system cannot properly
distinguish between memory an application "really" needs and memory an
application "eventually" needs (as internal caches, ...).

A possible solution could be the implementation of something like SIGDANGER,
which would be sent to an application in case of memory overload, so
it should try to free a bit memory if it can. Surely applications would have
to be modified to use that information. How about the C library, does it
maintain any big buffers, for I/O or so? I don't know, changes there could
surely be passed on transparently. Ok, ok, it's the MacOS way of thinking, so
the other possibility. This problems are intimately related to memory
overcommitting, or not doing so, so what might be fatal in overcommitting?

One problem arises if an application gets a huge part of overcommitted memory
and then tries to use it, which spontaneously fails - just because the memory
was committed somewhere else, to the 999 other apps which are already
 running.

The flaw there is that at some time, you can guarantee that the overcommit
would fail, if the memory was really used. At this point, the application
could be halted (so that it does not get the chance to make use of the
overcommit promise), until some more memory is available again - either by
paging, or by waiting for other jobs to terminate. This could lead to
starvation, but it potentially could let the system survive.

A further idea would be to use overcommitted memory only for buffers and
caches, this was already mentioned before. In any situation "near" an OOM,
further memory pressure should be avoided - for example, by letting malloc()
fail. This might also hurt existing processes, so some heuristics could
decide - a malloc() from a freshly started process should fail regardlessly
of its size, while older processes might get some more tolerance, because the
system might trust their behaviour a bit more.

So far from me, this was just a collection of some more or less unrelated
thoughts, which I'd like to know a bit more about, or hear from experts why
all of this is b*llshit (or: already done(TM)!)

Greetings,
Andreas
