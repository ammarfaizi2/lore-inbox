Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRBMNTT>; Tue, 13 Feb 2001 08:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131434AbRBMNTJ>; Tue, 13 Feb 2001 08:19:09 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:36840 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131317AbRBMNSx>; Tue, 13 Feb 2001 08:18:53 -0500
Message-ID: <3A89362E.A0DE6C14@uow.edu.au>
Date: Wed, 14 Feb 2001 00:27:10 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] zerocopy patch against 2.4.2-pre2
In-Reply-To: <3A868FF3.BC7F6679@uow.edu.au>,
		<14979.43130.731593.90703@pizda.ninka.net>
		<3A868FF3.BC7F6679@uow.edu.au> <14984.55981.974147.573306@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Andrew Morton writes:
>  > Changing the memory copy function did make some difference
>  > in my setup.  But the performance drop on send(8k) is only approx 10%,
>  > partly because I changed the way I'm testing it - `cyclesoak' is
>  > now penalised more heavily by cache misses, and amount of cache
>  > missing which networking causes cyclesoak is basically the same,
>  > whether or not the ZC patch is applied.
> 
> Ok ok ok, but are we at the point where there are no sizable "over the
> wire" performance anomalies anymore?  That is what is important, what
> are the localhost bandwidth measurements looking like for you now
> with/without the patch applied?

Using 2.4.2-pre3 + zerocopy-2.4.2p3-1.diff

All numbers in megs/sec

zcc/zcs is doing read(8k)/send(8k) to localhost.

On the dual 500MHz PII:

                   zcc/zcs                 bw_tcp

  Unpatched:       70                       66     
  Patched:         67                       66

Single 500MHz PII:

  Unpatched:       58                       54
  Patched:         49                       52 

Single 650MHz PIII Coppermine:

  Unpatched:       140                      180-250 
  Patched:         107                      159  


With or without ZC, there is Wierd Stuff happening with local
networking. Throughput is all over the place.

- With zcs reporting throughput once per second, the numbers were jumping
  around by +/-10%.  Had to bump the averaging period to 5 seconds to
  make much sense of it.   With a real network, they're rock solid.

- The difference between the PII and PIII is far beyond anything I see
  with any other workload.

- The difference between zcc/zcs and bw_tcp on the PIII is interesting.
  It's still apparent when zcc/zcs uses a 64k transfer buffer, like bw_tcp.
  zcc/zcs is doing file system reads, whereas bw_tcp isn't.  But the
  discrepancy isn't there on the PII.

- On the unpatched kernel, I saw one bw_tcp run after a reboot report
  410 Mbytes/sec.  Thereafter it's around 210.  err..  make that 180. No,
  make that 254. WTF?

Amongst all the noise it seems there's a problem on the PIII but
not the PII.

It's getting very lonely testing this stuff. It would be useful if
someone else could help out - at least running the bw_tcp tests. It's
pretty simple:

	bw_tcp -s ; bw_tcp 0


> I want to reach a known state where we can conclude "over the wire is
> about as good or better than before, but there is a cpu/cache usage
> penalty from the zerocopy stuff".
> 
> This is important.  It lets us get to the next stage which is to
> use your tools, numbers, and some profiling to see if we can get
> some of that cpu overhead back.

Seems, with the 100baseT NIC the performance drop on the Coppermine
is only half that of the Mendocino.  I _think_ the Mendocino is
only 4-way associative, but reports vary on this.  Coppermine is 8-way.

-
