Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130895AbRA0Fiq>; Sat, 27 Jan 2001 00:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbRA0Fig>; Sat, 27 Jan 2001 00:38:36 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:48629 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130895AbRA0FiU>; Sat, 27 Jan 2001 00:38:20 -0500
Message-ID: <3A726087.764CC02E@uow.edu.au>
Date: Sat, 27 Jan 2001 16:45:43 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please keep netdev copied, else Jamal will grump at you, and
 you don't want that).

I've whacked together some tools to measure TCP throughput
with both sendfile and read/write.  I've tested with and
without the zerocopy patch.

The CPU load figures are very accurate: the tool uses a `subtractive'
algorithm which measures how much CPU is left over by the networking
code, rather than trying to measure how much CPU load the networking
stuff actually takes, if you see what I mean.  This accounts accurately
for CPU load, interrupts, softirq processing, memory bandwidth utilisation
and cache pollution.

The client is a 650 MHz PIII.  The NIC is a 3CCFE575CT Cardbus 3com.
It supports Scatter/Gather and hardware checksums.  The NIC's interrupt
is shared with the Cardbus controller, so this will impact throughput
slightly.

The kernels which were tested were 2.4.1-pre10 with and without the
zerocopy patch.  We only look at client load (the TCP sender).

The link throughput was 11.5 mbytes/sec at all times (saturated 100baseT)

2.4.1-pre10-vanilla, using sendfile():          29.6% CPU
2.4.1-pre10-vanilla, using read()/write():      34.5% CPU

2.4.1-pre10+zercopy, using sendfile():          18.2% CPU
2.4.1-pre10+zercopy, using read()/write():      38.1% CPU

2.4.1-pre10+zercopy, using sendfile():          22.9% CPU    * hardware tx checksums disabled
2.4.1-pre10+zercopy, using read()/write():      39.2% CPU    * hardware tx checksums disabled


What can we conclude?

- sendfile is 10% cheaper than read()-then-write() on 2.4.1-pre10.

- sendfile() with the zerocopy patch is 40% cheaper than
  sendfile() without the zerocopy patch.

- hardware Tx checksums don't make much difference.  hmm...

Bear in mind that the 3c59x driver uses a one-interrupt-per-packet
algorithm.  Mitigation reduces this to 0.3 ints/packet.
So we're absorbing 4,500 interrupts/sec while processing
12,000 packets/sec.  gigE NICs do much better mitigation than
this and the relative benefits of zerocopy will be much higher
for these.  Hopefully Jamal can do some testing.

BTW: I could not reproduce Jamal's oops when sending large
files (2 gigs with sendfile()).

The test tool is, of course, documented [ :-)/2 ].  It's at

	http://www.uow.edu.au/~andrewm/linux/#zc

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
