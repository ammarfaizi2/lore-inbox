Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130378AbRA0OQq>; Sat, 27 Jan 2001 09:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130761AbRA0OQh>; Sat, 27 Jan 2001 09:16:37 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:38581 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S130378AbRA0OQU>;
	Sat, 27 Jan 2001 09:16:20 -0500
Date: Sat, 27 Jan 2001 09:15:28 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Andrew Morton <andrewm@uow.edu.au>
cc: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A72CD1E.32BB523F@uow.edu.au>
Message-ID: <Pine.GSO.4.30.0101270900230.24088-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, Andrew Morton wrote:

> jamal wrote:
> >
> > ..
> > It is also useful to have both client and server stats.
> > BTW, since the laptop (with the 3C card) is the client, the SG
> > shouldnt kick in at all.
>
> The `client' here is doing the sendfiling, so yes, the
> gathering occurs on the client.
>

OK, semantics. Maybe we should stick to sender and receiver.
(server normally will translate to "serve" files)

> > I'll give this a shot later. Can you try with the sendfiled-ttcp?
> > http://www.cyberus.ca/~hadi/ttcp-sf.tar.gz
>
> hmm..  I didn't bother with TCP_CORK because the files being
> sent are "much" larger than a frame.  Guess I should.

It doesnt make much sense to use sendfile without TCP_CORK.

> The problem with things like ttcp is the measurement of CPU load.
> If your network is so fast that your machine can't keep up then
> fine, raw throughput is a good measure. But if the link is saturated
> then normal process accounting doesn't cut it.

ttcp's CPU measure is not the best. Part of my plan was to change that.
It uses times(). So the measurement is not good. It is infact not
very reflective on SMP. The way to do it there is to break it down
by CPU.
Throughput: 100Mbps is really nothing. Linux never had a problem with
4-500Mbps file serving. So throughput is an important number. so is
end to end latency, but in file serving case, latency might not be a big
deal so ignore it.

> For example, at 100 mbps, `top' says ttcp is chewing 4% CPU. But guess
> what?  A low-priority process running on the same machine is in fact
> slowed down by 30%.  top lies.  Most of the cost of the networking layer
> is being accounted to swapper, and lost.  And who accounts for cache
> eviction, bus utilisation, etc.  We're better off measuring what's
> left behind, rather than measuring what is consumed.
>
> You can in fact do this with ttcp: run it with a super-high priority
> and run a little task in the background (dummyload.c in the above
> tarball does this).  See how much the dummy task is slowed down
> wrt an unloaded system.  It gets tricky on SMP though.
>

The best way to do CPU measurement is via /proc. The way top
does it. You measure it from within your nettest program. This does
measure what is "left behind" since your proggie is in user space.
Actually, it shouldnt matter whether you do it from your test program or
from dummyload.c. With dummyload you might have to sigkill the program
every  time a test terminates.
You also should break down utilization by CPU.

cheers,
jamal

PS:- can you try it out with the ttcp testcode i posted?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
