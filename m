Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbRA0NV4>; Sat, 27 Jan 2001 08:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132623AbRA0NVr>; Sat, 27 Jan 2001 08:21:47 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:56242 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130355AbRA0NVe>; Sat, 27 Jan 2001 08:21:34 -0500
Message-ID: <3A72CD1E.32BB523F@uow.edu.au>
Date: Sun, 28 Jan 2001 00:29:02 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A726087.764CC02E@uow.edu.au> <Pine.GSO.4.30.0101270729270.24088-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> ..
> It is also useful to have both client and server stats.
> BTW, since the laptop (with the 3C card) is the client, the SG
> shouldnt kick in at all.

The `client' here is doing the sendfiling, so yes, the
gathering occurs on the client.

> ...
> > The test tool is, of course, documented [ :-)/2 ].  It's at
> >
> >       http://www.uow.edu.au/~andrewm/linux/#zc
> >
> 
> I'll give this a shot later. Can you try with the sendfiled-ttcp?
> http://www.cyberus.ca/~hadi/ttcp-sf.tar.gz

hmm..  I didn't bother with TCP_CORK because the files being
sent are "much" larger than a frame.  Guess I should.

The problem with things like ttcp is the measurement of CPU load.
If your network is so fast that your machine can't keep up then
fine, raw throughput is a good measure. But if the link is saturated
then normal process accounting doesn't cut it.

For example, at 100 mbps, `top' says ttcp is chewing 4% CPU. But guess
what?  A low-priority process running on the same machine is in fact
slowed down by 30%.  top lies.  Most of the cost of the networking layer
is being accounted to swapper, and lost.  And who accounts for cache
eviction, bus utilisation, etc.  We're better off measuring what's
left behind, rather than measuring what is consumed.

You can in fact do this with ttcp: run it with a super-high priority
and run a little task in the background (dummyload.c in the above
tarball does this).  See how much the dummy task is slowed down
wrt an unloaded system.  It gets tricky on SMP though.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
