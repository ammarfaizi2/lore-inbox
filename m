Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271672AbRH0I2O>; Mon, 27 Aug 2001 04:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271673AbRH0I2E>; Mon, 27 Aug 2001 04:28:04 -0400
Received: from www.heureka.co.at ([195.64.11.111]:48649 "EHLO
	www.heureka.co.at") by vger.kernel.org with ESMTP
	id <S271672AbRH0I1t>; Mon, 27 Aug 2001 04:27:49 -0400
Date: Mon, 27 Aug 2001 10:27:40 +0200
From: David Schmitt <david@heureka.co.at>
To: linux-kernel@vger.kernel.org
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
Message-ID: <20010827102740.A9557@www.heureka.co.at>
In-Reply-To: <20010824162425.D27794@www.heureka.co.at> <Pine.LNX.4.10.10108251801480.13314-100000@ada.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10108251801480.13314-100000@ada.teststation.com>
User-Agent: Mutt/1.3.20i
Organization: Heureka - Der EDV-Dienstleister
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 07:05:26PM +0200, Urban Widmark wrote:
> On Fri, 24 Aug 2001, David Schmitt wrote:
> 
> > Aug 24 11:15:07 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > Aug 24 11:15:07 cheesy kernel: eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
> > Aug 24 11:15:07 cheesy kernel: eth0: reset did not complete in 10 ms.
> > Aug 24 11:15:07 cheesy kernel: eth0: reset finished after 10005 microseconds.
> > Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #1 queued in slot 0.
> [snip]
> > Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #10 queued in slot 9.
> > Aug 24 11:15:09 cheesy kernel: eth0: VIA Rhine monitor tick, status 0000.
> > Aug 24 11:15:11 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > Aug 24 11:15:11 cheesy kernel: eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
> > Aug 24 11:15:11 cheesy kernel: eth0: reset did not complete in 10 ms.
> > Aug 24 11:15:11 cheesy kernel: eth0: reset finished after 10005 microseconds.
> > 
> > 	Reloading the module doesn't help either. Only a reboot
> > 	reenables network connectivity.
> 
> There is a patch in the 2.4.8-acX kernels that fixes a problem with
> reseting the card when it is first used. I can't say that I know that it
> fixes anything you are seeing, but it could be worth trying.

Ok, I will try that too and report back.

> Did this start with recent versions, or have you never run older kernels
> on this hw?

I tried it now with 2.2.19 and killed it too. See below for details.

> Reloading the module is to the hardware about the same as the watchdog
> reset.

Good news: Under 2.2.19, reloading the module indeed reset the card,
so that it worked again. 

I will upload debugoutput from 2.2.19 too
(http://www.heureka.co.at/~david/dfe530tx/)

> Rebooting obviously triggers something else too ... perhaps the BIOS talks
> some sense to the card.

As mentioned above, it seems like the 2.2.19 version does the Right
Thing (but doesn't recover autmatically).

> > [6.] A small shell script or example program which triggers the
> > 	problem (if possible)
> > 
> > 	Downloading amounts of data (>50MB) will eventually trigger
> > 	the problem. Transmitting data at less than full speed will
> > 	not trigger it (or at least I haven't waited long enough?)
> 
> What do you use to download? from a server on the LAN or something remote?
> and how do you slow down the speed of your transmission? How fast is it
> when it is fast, and how much do you slow it down?

Ok, I could reproduce it kinda more systematically:

# ssh other.machine cat /dev/zero

Generates about 2Mbit incoming traffic. This doesn't trigger the
problem.

but doing one or two parallel ping -f other.machine locks the NIC for
good.


> > [X.] Other notes, patches, fixes, workarounds
> > 
> > Further information from lspci, via-diag and ifconfig output as well
> > as well as complete kernel syslog from boot to network-lock can be
> > found on http://www.heureka.co.at/~david/dfe530tx/
> 
> The syslog gives a few hints that something is wrong ...
> 
> eth0: Transmit error, Tx status 00008100.
> 	8 - transmit error
> 	1 - transmit aborted after excessive collisions
> 
> but at the same time the 00 part means that the "collision retry count" is
> 0 and that it hasn't set a flag that it "experienced collisions in this
> transmit event".

The network where the DFE530TX (and the other.machine) are attached
contains some 20-30 Windows PCs and some Novell Servers which all seem
quite braodcast-happy. The network itself is (mostly) unswitched and
10Mbit halfduplex, so I guess this really is connected to the
collisions.


> I think there were 3 of these, and from all but the last it recovers by
> itself. Perhaps the collisions (or whatever it is that the card sees as
> collisions) continued for a longer period.




> It ends up in "eth0: transmit timed out" and the driver tries to reset the
> card. That does not appear to work at all.

Under 2.2.19 the card doesn't recover automatically (lacking the
watchdog) but manually reloading the module works.

> It's a nice report, I wish I had something more useful to reply with.

Well, you pointed me in the right direction :-)

> The driver source has links to some datasheets. They might be useful in
> improving the reset code.
> (Hmm, the tx_timeout code does: reset -> initialise ring -> wait for hw
>  but initialise ring talks to the hw, perhaps it should wait for hw first
>  ...)

I'm not really into hacking C but, I will try to provide as much info
as possible.


Regards, David
-- 
Sponsored by heureKA, Austria (http://www.heureka.co.at)
