Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269795AbRHYRFv>; Sat, 25 Aug 2001 13:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269796AbRHYRFn>; Sat, 25 Aug 2001 13:05:43 -0400
Received: from fungus.teststation.com ([212.32.186.211]:49672 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S269795AbRHYRFX>; Sat, 25 Aug 2001 13:05:23 -0400
Date: Sat, 25 Aug 2001 19:05:26 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: David Schmitt <david@heureka.co.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
In-Reply-To: <20010824162425.D27794@www.heureka.co.at>
Message-ID: <Pine.LNX.4.10.10108251801480.13314-100000@ada.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, David Schmitt wrote:

> Aug 24 11:15:07 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Aug 24 11:15:07 cheesy kernel: eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
> Aug 24 11:15:07 cheesy kernel: eth0: reset did not complete in 10 ms.
> Aug 24 11:15:07 cheesy kernel: eth0: reset finished after 10005 microseconds.
> Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #1 queued in slot 0.
[snip]
> Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #10 queued in slot 9.
> Aug 24 11:15:09 cheesy kernel: eth0: VIA Rhine monitor tick, status 0000.
> Aug 24 11:15:11 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Aug 24 11:15:11 cheesy kernel: eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
> Aug 24 11:15:11 cheesy kernel: eth0: reset did not complete in 10 ms.
> Aug 24 11:15:11 cheesy kernel: eth0: reset finished after 10005 microseconds.
> 
> 	Reloading the module doesn't help either. Only a reboot
> 	reenables network connectivity.

There is a patch in the 2.4.8-acX kernels that fixes a problem with
reseting the card when it is first used. I can't say that I know that it
fixes anything you are seeing, but it could be worth trying.

Did this start with recent versions, or have you never run older kernels
on this hw?

Reloading the module is to the hardware about the same as the watchdog
reset.

Rebooting obviously triggers something else too ... perhaps the BIOS talks
some sense to the card.

> [6.] A small shell script or example program which triggers the
> 	problem (if possible)
> 
> 	Downloading amounts of data (>50MB) will eventually trigger
> 	the problem. Transmitting data at less than full speed will
> 	not trigger it (or at least I haven't waited long enough?)

What do you use to download? from a server on the LAN or something remote?
and how do you slow down the speed of your transmission? How fast is it
when it is fast, and how much do you slow it down?

My other machine does not have anything useful installed, but it did have
chargen and discard open.

nc other.machine chargen > /dev/null
	iptraf says about 64Mbps
nc other.machine discard < /dev/zero
	iptraf says about 44Mbps

Sending about 1.5G in both directions, without problems. I used to have a
netperf setup and that would (more or less) fill the 100Mbps.


> [X.] Other notes, patches, fixes, workarounds
> 
> Further information from lspci, via-diag and ifconfig output as well
> as well as complete kernel syslog from boot to network-lock can be
> found on http://www.heureka.co.at/~david/dfe530tx/

The syslog gives a few hints that something is wrong ...

eth0: Transmit error, Tx status 00008100.
	8 - transmit error
	1 - transmit aborted after excessive collisions

but at the same time the 00 part means that the "collision retry count" is
0 and that it hasn't set a flag that it "experienced collisions in this
transmit event".

I think there were 3 of these, and from all but the last it recovers by
itself. Perhaps the collisions (or whatever it is that the card sees as
collisions) continued for a longer period.

It ends up in "eth0: transmit timed out" and the driver tries to reset the
card. That does not appear to work at all.


It's a nice report, I wish I had something more useful to reply with.

The driver source has links to some datasheets. They might be useful in
improving the reset code.
(Hmm, the tx_timeout code does: reset -> initialise ring -> wait for hw
 but initialise ring talks to the hw, perhaps it should wait for hw first
 ...)

/Urban

