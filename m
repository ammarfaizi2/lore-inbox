Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268151AbTCFQmx>; Thu, 6 Mar 2003 11:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268153AbTCFQmx>; Thu, 6 Mar 2003 11:42:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52498 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268151AbTCFQmw>; Thu, 6 Mar 2003 11:42:52 -0500
Date: Thu, 6 Mar 2003 08:51:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@digeo.com>, <rml@tech9.net>, <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <3E6770F3.8030207@pobox.com>
Message-ID: <Pine.LNX.4.44.0303060842270.7206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Jeff Garzik wrote:
>
> Pardon the suggestion of a dumb hueristic, feel free to ignore me: 
> would it work to run-first processes that have modified their iopl() 
> level?  i.e. "if you access hardware directly, we'll treat you specially 
> in the scheduler"?

See, the thing is, I don't actually believe that X is _special_ in this 
regard.

If we have an interactive process that has been waiting nicely for
somebody else (ie it is "interactive" in that it tends to run quickly and 
then wait again, without blowing away the cache), then I think that 
"somebody else" should be automatically getting some of the extra 
attention - just for latency reasons.

It's not an X special-case issue. It's a completely _generic_ "low-latency
service to interactive tasks" issue. 

Put another way:

Imagine other servers running on the same machine. Imagine, if you will, a
logging service (or IM server, or whatever) that gets overwhelmed when it
has thousands of interactive clients on an overloaded machine. We know the
clients care about latency (clearly true since they sleep a lot - they
can't be about bandwidth: the logic only triggers if the clients have lots
of interactivity bonus points), so if we notice that this server is waking
up a lot of these latency-critical clients, doesn't it make sense to make
the _server_ as latency-critical too?

See? My small patch hits _exactly_ that case. It misses a lot of 
opportunities (it really only works with synchronous wakeups, so in 
practice it probably ends up working mainly for things like UNIX domain 
sockets and regular pipes), but that's an implementation issue, not a 
"special case" thing.

		Linus

