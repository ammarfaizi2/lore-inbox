Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131950AbRA1F1t>; Sun, 28 Jan 2001 00:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132316AbRA1F1k>; Sun, 28 Jan 2001 00:27:40 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:25338 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131950AbRA1F1Y>; Sun, 28 Jan 2001 00:27:24 -0500
Message-ID: <3A73AF7B.6610B559@uow.edu.au>
Date: Sun, 28 Jan 2001 16:34:51 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: netdev@oss.sgi.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A726087.764CC02E@uow.edu.au> from "Andrew Morton" at Jan 27, 1 08:45:00 am <200101271854.VAA02845@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > 2.4.1-pre10+zercopy, using read()/write():      38.1% CPU
> 
> write() on zc card is worse than normal write() by definition.
> It generates split buffers.

yes.  The figures below show this.  Disabling SG+checksums speeds
up write() and send().

> Split buffers are more expensive and we have to pay for this.
> You have paid too much for slow card though. 8)
>
> Do you measure load correctly?

Yes.  Quite confident about this.  Here's the algorithm:

1: Run a cycle-soaker on each CPU on an otherwise unloaded
   system.  See how much "work" they all do per second.

2: Run the cycle-soakers again, but with network traffic happening.
   See how much their "work" is reduced. Deduce networking CPU load
   from this difference.

   The networking code all runs SCHED_FIFO or in interrupt context,
   so the cycle-soakers have no effect upon the network code's access
   to the CPU.

   The "cycle-soakers" just sit there spinning and dirtying 10,000
   cachelines per second.

> > 2.4.1-pre10+zercopy, using read()/write():      39.2% CPU    * hardware tx checksums disabled
> 
> This is illegal combination of parameters. You force two memory accesses,
> doing this. The fact that it does not add to load is dubious. 8)8)

mm.. Perhaps with read()/write() the data is already in cache?

Anyway, I've tweaked up the tool again so it can do send() or
write() (then I looked at the implementation and wondered why
I'd bothered).  It also does TCP_CORK now.

I ran another set of tests.  The zerocopy patch improves sendfile()
hugely but slows down send()/write() significantly, with a 3c905C:

http://www.uow.edu.au/~andrewm/linux/#zc



The kernels which were tested were 2.4.1-pre10 with and without the
zerocopy patch.  We only look at client load (the TCP sender).

In all tests the link throughput was 11.5 mbytes/sec at all times
(saturated 100baseT) unless otherwise noted.

The client (the thing which sends data) is a dual 500MHz PII with a
3c905C.

For the write() and send() tests, the chunk size was 64 kbytes.

The workload was 63 files with an average length of 350 kbytes.

                                                     CPU

    2.4.1-pre10+zerocopy, using sendfile():          9.6%
    2.4.1-pre10+zerocopy, using send():             24.1%
    2.4.1-pre10+zerocopy, using write():            24.2%

    2.4.1-pre10+zerocopy, using sendfile():         16.2%       * checksums and SG disabled
    2.4.1-pre10+zerocopy, using send():             21.5%       * checksums and SG disabled
    2.4.1-pre10+zerocopy, using write():            21.5%       * checksums and SG disabled



    2.4.1-pre10-vanilla, using sendfile():          17.1%
    2.4.1-pre10-vanilla, using send():              21.1%
    2.4.1-pre10-vanilla, using write():             21.1%


Bearing in mind that a large amount of the load is in the device
driver, the zerocopy patch makes a large improvement in sendfile
efficiency.  But read() and send() performance is decreased by 10% -
more than this if you factor out the constant device driver overhead.

TCP_CORK makes no difference.  The files being sent are much larger
than a single frame.

Conclusions:

  For a NIC which cannot do scatter/gather/checksums, the zerocopy
  patch makes no change in throughput in all case.

  For a NIC which can do scatter/gather/checksums, sendfile()
  efficiency is improved by 40% and send() efficiency is decreased by
  10%.  The increase and decrease caused by the zerocopy patch will in
  fact be significantly larger than these two figures, because the
  measurements here include a constant base load caused by the device
  driver.
 


-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
