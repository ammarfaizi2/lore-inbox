Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129956AbRAaLWa>; Wed, 31 Jan 2001 06:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130153AbRAaLWY>; Wed, 31 Jan 2001 06:22:24 -0500
Received: from oxmail4.ox.ac.uk ([163.1.2.33]:9167 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129956AbRAaLWE>;
	Wed, 31 Jan 2001 06:22:04 -0500
Date: Wed, 31 Jan 2001 11:21:45 +0000
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: jamal <hadi@cyberus.ca>, Ion Badulescu <ionut@cs.columbia.edu>,
        Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Message-ID: <20010131112145.A13345@sable.ox.ac.uk>
In-Reply-To: <Pine.GSO.4.30.0101302000471.3017-100000@shell.cyberus.ca> <Pine.LNX.4.30.0101310213400.13467-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0101310213400.13467-100000@elte.hu>; from mingo@elte.hu on Wed, Jan 31, 2001 at 02:14:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
> 
> On Tue, 30 Jan 2001, jamal wrote:
> 
> > > - is this UDP or TCP based? (UDP i guess)
> > >
> > TCP
> 
> well then i'd suggest to do:
> 
> 	echo 100000 100000 100000 > /proc/sys/net/ipv4/tcp_wmem
> 
> does this make any difference?

For the last week I've been benchmarking Linux network and I/O on a
couple of machines with 3c985 gigabit cards and some other stuff
(see below). One of the things I tried yesterday was a beta test
version of a secure ftpd written by Chris Evans which happens to use
sendfile() making it a convenient extra benchmark. I'd already put
net.core.{r,w}mem_max up to 262144 for the sake of gensink and other
benchmarks which raise SO_{SND,RCV}BUF. I hadn't however, tried
raising tcp_wmem as per your suggestion above.

Currently the systems are linked back to back with fibre with jumbo
frames (MTU 9000) on and running pure kernel 2.4.1. I transferred a 300
MByte file repeatedly from the server to the client with an ftp "get"
client-side. The file will have been completely in page cache on the
server (both machines have 512MB RAM) and was written to /dev/null on
the client side. (Yes, I checked the client was doing ordinary
read/write and not throwing it away).

Without the raised tcp_wmem setting I was getting 81 MByte/s.
With tcp_wmem set as above I got 86 MByte/s. Nice increase. Any other
setting I can tweak apart from {r,w}mem_max and tcp_{w,r}mem? The CPU
on the client (350 MHz PII) is the bottleneck: gensink4 maxes out at
69 Mbyte/s pulling TCP from the server and 94 Mbyte/s pushing. (The
other system, 733 MHz PIII pushes >100MByte/s UDP with ttcp but the
client drops most of it).

I'll be following up Dave Miller's "please benchmark zerocopy"
request when I've got some more numbers written down since I've only
just put the zerocopy patch in and haven't rebooted yet.

If anyone wants any other specific benchmarks done (I/O or network)
I may get some time to do them: the PIII system has an 8-port
Escalade card with 8 x 46GB disks (117 MByte/s block writes as
measured by Bonnie on a RAID1/0 mixed RAIDset) and there are also
four dual-port eepro fast ethernet cards, a Cisco 8-port 3508G gigabit
switch and a 24-port 3524 fast ethernet switch (gigastack linked to
the 3508G).  I'm benchmarking and looking into the possibility of a DIY
NAS or SAN-type thing.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
