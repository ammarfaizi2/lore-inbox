Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277576AbRJLIYd>; Fri, 12 Oct 2001 04:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277580AbRJLIYX>; Fri, 12 Oct 2001 04:24:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15910 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277576AbRJLIYJ>; Fri, 12 Oct 2001 04:24:09 -0400
Date: Fri, 12 Oct 2001 10:24:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Cohen <robert.cohen@anu.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCH] Problems with IO throughput and fairness with 2.4.10 and 2.4.9-ac15
Message-ID: <20011012102409.S714@athlon.random>
In-Reply-To: <3BB31F99.941813DD@anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB31F99.941813DD@anu.edu.au>; from robert.cohen@anu.edu.au on Thu, Sep 27, 2001 at 10:46:17PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 10:46:17PM +1000, Robert Cohen wrote:
> Overall, the total throughput is not that bad, but the fact that it
> achieves this by starving clients to let one client at a time proceed is
> completely unacceptable for a file server.

So the problem here is starvation if I understand well.

This one isn't related to the VM, so it's normal that you don't see much
difference among the different VM, it's more likely either related to
netatalk or tcp or I/O elevator.

Anyways you can pretty well rule out the elevator using elvtune -r 1 -w
1 /dev/hd[abcd] and see if the starvation goes away.

> poor throughput that is seen in this test I associate with poor elevator
> performance. If the elevator doesnt group requests enough you get disk
> behaviour like "small read, seek, small read, seek" instead of grouping
> things into large reads or multiple reads between seeks. 

If you hear the seeks that's very good for the fairness, making the
elevator even more aggressive could only increase starvation of some
client.

> The problem where one client gets all the bandwidth has to be some kind
> of livelock.

netatalk may be processing the I/O requests not in a fair manner and if
the unfariness is introduced by netatalk no matter what tcp and I/O
subsystem do, we can do nothing to fix it from the kernel side. OTOH you
said that in the "cached" test netatalk was providing a fair
fileserving, but I'd still prefer if you could reproduce without using
netatalk, you can just use a rsh pipe to do the read and writes of the
files over the network for example, it should stress tcp and I/O
subsystem the same way. If you can't reproduce with rsh please file a
report to the netatalk people.

I doubt it's the tcp congestion control, of course it's unfair too
across multiple streams but I wouldn't expect it to generate that bad
fariness results.

> that they are just doing 8k reads and writes. The files are not opened
> O_SYNC and the file server process arent doing any fsync calls. This is

ok.

> supported by the fact that the performance is fine with 256 Megs of
> memory.

yes.

Andrea
