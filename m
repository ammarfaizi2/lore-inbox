Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132608AbRA0KFs>; Sat, 27 Jan 2001 05:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRA0KFj>; Sat, 27 Jan 2001 05:05:39 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:22026 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S132606AbRA0KF2>; Sat, 27 Jan 2001 05:05:28 -0500
Date: Sat, 27 Jan 2001 02:05:13 -0800
Message-Id: <200101271005.f0RA5DX04357@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A726087.764CC02E@uow.edu.au>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001 16:45:43 +1100, Andrew Morton <andrewm@uow.edu.au> wrote:

> The client is a 650 MHz PIII.  The NIC is a 3CCFE575CT Cardbus 3com.
> It supports Scatter/Gather and hardware checksums.  The NIC's interrupt
> is shared with the Cardbus controller, so this will impact throughput
> slightly.
> 
> The kernels which were tested were 2.4.1-pre10 with and without the
> zerocopy patch.  We only look at client load (the TCP sender).
> 
> The link throughput was 11.5 mbytes/sec at all times (saturated 100baseT)
> 
> 2.4.1-pre10-vanilla, using sendfile():          29.6% CPU
> 2.4.1-pre10-vanilla, using read()/write():      34.5% CPU
> 
> 2.4.1-pre10+zercopy, using sendfile():          18.2% CPU
> 2.4.1-pre10+zercopy, using read()/write():      38.1% CPU
> 
> 2.4.1-pre10+zercopy, using sendfile():          22.9% CPU    * hardware tx checksums disabled
> 2.4.1-pre10+zercopy, using read()/write():      39.2% CPU    * hardware tx checksums disabled

750MHz PIII, Adaptec Starfire NIC, driver modified to use hardware sg+csum
(both Tx/Rx), and Intel i82559 (eepro100), no hardware csum support,
vanilla driver.

The box has 512MB of RAM, and I'm using a 100MB file, so it's entirely cached.

starfire:
2.4.1-pre10+zerocopy, using sendfile():		 9.6% CPU
2.4.1-pre10+zerocopy, using read()/write():	18.3%-29.6% CPU		* why so much variance?

2.4.1-pre10+zerocopy, using sendfile():		17.4% CPU		* hardware csum disabled
2.4.1-pre10+zerocopy, using read()/write():	16.5%-26.8% CPU		* idem, again why so much variance?

2.4.1-pre10-vanilla, using sendfile():		16.5% CPU
2.4.1-pre10-vanilla, using read()/write():	14.5%-24.5% CPU		* high variance again

eepro100:
2.4.1-pre10+zerocopy, using sendfile():		16.0% CPU
2.4.1-pre10+zerocopy, using read()/write():	15.0%-24.5% CPU		* why so much variance?

2.4.1-pre10-vanilla, using sendfile():		16.7% CPU
2.4.1-pre10-vanilla, using read()/write():	14.5%-24.6% CPU		* high variance again

The read+write case is really weird. I'm getting results like this:

CPU load: 27.9491
CPU load: 25.4763
CPU load: 15.8544
CPU load: 25.455
CPU load: 25.2072
CPU load: 15.8677
CPU load: 25.4896
CPU load: 25.2791
CPU load: 15.8837

i.e. 2 slow, 1 fast, 2 slow, 1 fast, and so on so forth.

> What can we conclude?
> 
> - sendfile is 10% cheaper than read()-then-write() on 2.4.1-pre10.

Hard to tell, with such inconclusive results...

> - sendfile() with the zerocopy patch is 40% cheaper than
>   sendfile() without the zerocopy patch.

Indeed. Close to 50% in fact.

> - hardware Tx checksums don't make much difference.  hmm...

Actually it makes all the difference in the world for the starfire.
Interesting...

> Bear in mind that the 3c59x driver uses a one-interrupt-per-packet
> algorithm.  Mitigation reduces this to 0.3 ints/packet.
> So we're absorbing 4,500 interrupts/sec while processing
> 12,000 packets/sec.  gigE NICs do much better mitigation than
> this and the relative benefits of zerocopy will be much higher
> for these.  Hopefully Jamal can do some testing.

Hmm.. the starfire also has quite advanced interrupt mitigation,
but I have not played with it. Maybe tomorrow. So these results
are with one-interrupt-per-packet.

P.S. The starfire still doesn't like tinygrams (skb's with 1-byte
fragments). Fortunately your test program doesn't seem to generate
them. :-)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
