Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbTDCRyY 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261542AbTDCRyY 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:54:24 -0500
Received: from postal.sdsc.edu ([132.249.20.114]:18308 "EHLO postal.sdsc.edu")
	by vger.kernel.org with ESMTP id S261539AbTDCRyC 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 12:54:02 -0500
Date: Thu, 3 Apr 2003 10:05:27 -0800 (PST)
From: "Peter L. Ashford" <ashford@sdsc.edu>
To: Jonathan Vardy <jonathan@explainerdc.com>
cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: RAID 5 performance problems
In-Reply-To: <73300040777B0F44B8CE29C87A0782E101FA97B2@exchange.explainerdc.com>
Message-ID: <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

> I'm having trouble with getting the right performance out of my software
> raid 5 system. I've installed Red Hat 9.0 with kernel 2.4.20 compiled
> myself to match my harware (had the same problem with the default
> kernel). When I test the raid device's speed using 'hdparm -Tt /dev/hdx'
> I get this:
>
> /dev/md0:
> Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28 MB/sec
> Timing buffered disk reads:  64 MB in  2.39 seconds = 26.78 MB/sec
>
> This is really low for a raid system and I can't figure out what is
> causing this. I use rounded cables but I also tried the original Promise
> cables and there was no difference in performance.

The ONLY reason that I can think of to use round cables would be for
looks.  From a performance or reliability standpoint, they are a waste of
money.  I routinely build systems with dual 8-channel IDE RAID cards
(3Ware 7500-8) and 16 disks, and ONLY use flat cables.

> But still the raid performs slow. Does anybody have an idea how I could
> improve the performance? I've seen raid systems like my own performing
> much better (speeds of around 80MB/sec). I've added as many specs as I
> could find below so you can see what my configuration is.
>
> The hardware in the machine is as following:
>
> Maiboard   	: Asus P2B-d dual PII slot 1 with latest bios update
> Processors 	: 2x Intel PII 350Mhz
> Memory     	: 512MB SDRam 100Mhz ECC
> Controller 	: Promise FastTrak100 TX4 with latest firmware update
> Boot HD	: Maxtor 20GB 5400rpm
> Raid HD's	: 5x WDC1200BB 120GB 7200rpm ATA100

Your bottlenecks are probably (in order):

1.  Disk controllers (get off the motherboard IDE, dump the FastTrak, use
	Master only)
2.  I/O bandwidth (multiple PCI buses)
3.  Memory bandwidth (switch to something like a P4)
4.  Disks (this is where your friend's dual Xeon system is)

Your network probably belongs in this list somewhere, but you didn't
provide enough information for me to determine where it belongs.  The
necessary information would be the network type, switch/hub, and the type
and quantity of processing being performed prior to putting the data on
the net.

> 4 of the raid HD's are connected to the Promise controller and the other
> raid HD is master on the second onboard IDE channel (udma2/ATA33)

I've NEVER heard that the FastTrak runs fast (I have been told that they
run VERY slowly).  I've benchmarked RAW disk speeds with an Ultra-100 and
WD1200JB drives, and gotten 50MB/S from each disk, as opposed to your
26MB/S (there should be almost no difference for the BB drives).  My
suggestion would be to remove the FastTrak, and get two Ultra-100s and an
Ultra-133 (or one Ultra-100 and two Ultra-133s).  Use one disk per channel
(Master only), and move the system disk onto one of the Promise cards.
This change should get you up to the performance of your friend's old
system.

If you switch to a dual bus system, make sure that the two controllers
with two RAID drives are on separate buses.  In a triple bus system, each
of the three controllers would be on a different bus (put the NIC with the
system drive).

An inexpensive P4 Celeron with FAST memory would probably run faster.
FYI, The primary reason that the large file servers use the dual Xeon
boards is to get the high memory and I/O bandwidth.  The high CPU
bandwidth is also useful, primarily with TCP/IP encapsulation.

<SNIP>

> As you see /dev/hdc is on the onboard IDE channel. Tos be certain that
> this was not the bottleneck, I removed it from the raid so that is runs
> in degraded mode. This did not change the performance much. Rebuild
> speed is laso very slow, it is round 6MB/sec.
>
> The drives originally came from a friend's file server where they were
> also employed in a raid configuration. I've compared my results in
> Bonny++ to his results:
>
> My raid:

<SNIP>

14MB/S block write, 30MB/S block read

> His raid:

<SNIP>

99MB/S block write, 178MB/S block read

This MUST have had a better disk controller system AND multiple PCI buses.
The limit of one PCI bus (32-bit/33MHz, as used by the Promise
controllers) is 133MB/S, and they are exceeding that.

> His machine has dual P Xeon 2000Mhz processors but that shouldn't be the
> reason that the results are so different. My processor isn't at 100%
> while testing. Even his older system which had 80gig drives and dual
> 500Mhz processors is much faster:

<SNIP>

35MB/S block write, 72MB/S block read

As mentioned above, the CPU isn't the primary limit in I/O.  You have to
consider I/O bandwidth (number, width and clock of PCI buses), and memory
bandwidth.

Good luck.
				Peter Ashford

