Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270999AbRH1NqO>; Tue, 28 Aug 2001 09:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270992AbRH1NqF>; Tue, 28 Aug 2001 09:46:05 -0400
Received: from www.heureka.co.at ([195.64.11.111]:4872 "EHLO www.heureka.co.at")
	by vger.kernel.org with ESMTP id <S270990AbRH1Npv>;
	Tue, 28 Aug 2001 09:45:51 -0400
Date: Tue, 28 Aug 2001 15:45:41 +0200
From: David Schmitt <david@heureka.co.at>
To: linux-kernel@vger.kernel.org
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
Message-ID: <20010828154540.A23296@www.heureka.co.at>
In-Reply-To: <20010827102740.A9557@www.heureka.co.at> <Pine.LNX.4.10.10108272025400.25944-100000@ada.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10108272025400.25944-100000@ada.teststation.com>
User-Agent: Mutt/1.3.20i
Organization: Heureka - Der EDV-Dienstleister
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re!

After fooling around a bit more I can now distinguish three different
states (with 2.4.9):

1) Working (very easy):

Aug 28 13:45:01 cheesy kernel:  In via_rhine_rx(), entry XX status 00668f00.

2) Recoverable troubles (nasty but bearable):

Aug 28 13:45:04 cheesy kernel:  In via_rhine_rx(), entry XX status 005e9700.
Aug 28 13:45:05 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 28 13:45:05 cheesy kernel: eth0: reset finished after 5 microseconds.
Aug 28 13:45:05 cheesy kernel:  In via_rhine_rx(), entry XX status 00668f00.

Aug 28 13:45:32 cheesy kernel:  In via_rhine_rx(), entry XX status 015a9700.
Aug 28 13:45:33 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 28 13:45:33 cheesy kernel: eth0: reset finished after 105 microseconds.
Aug 28 13:45:33 cheesy kernel:  In via_rhine_rx(), entry XX status 00668f00.

Note 1: '005e9700' doesn't always cause a timeout.
Note 2: the delay in the second paragraph.

and

3) Unrecoverable (really bad):

Aug 28 13:45:51 cheesy kernel:  In via_rhine_rx(), entry XX status 00668f00.
Aug 28 13:45:52 cheesy kernel:  In via_rhine_rx(), entry XX status 00668f00.
Aug 28 13:45:52 cheesy kernel:  In via_rhine_rx(), entry XX status 00729700.
Aug 28 13:45:54 cheesy kernel:  In via_rhine_rx(), entry XX status 00669700.
Aug 28 13:45:54 cheesy kernel:  In via_rhine_rx(), entry XX status 00ee9700.
Aug 28 13:45:54 cheesy kernel:  In via_rhine_rx(), entry XX status 00f79700.
Aug 28 13:45:54 cheesy kernel:  In via_rhine_rx(), entry XX status 00669700.
Aug 28 13:45:55 cheesy kernel:  In via_rhine_rx(), entry XX status 005e9700.
Aug 28 13:45:55 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 28 13:45:55 cheesy kernel: eth0: reset finished after 10005 microseconds.
Aug 28 13:45:59 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 28 13:45:59 cheesy kernel: eth0: reset finished after 10005 microseconds.

Then I noticed the following: Upon unload the driver emits some kind
of exit status:

Correct shutdown:
Aug 28 14:53:34 cheesy kernel: eth0: Shutting down ethercard, status was 085a.

After first resets:
Aug 28 14:54:11 cheesy kernel: eth0: Shutting down ethercard, status was 081a.

After total NIC lockup:
Aug 28 14:56:24 cheesy kernel: eth0: Shutting down ethercard, status was 883a.


Wondering if via-diag shows some differences I got this:

root@cheesy # via-diag -mm -aa -ee
via-diag.c:v2.06 5/22/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 Index #1: Found a VIA VT3065 Rhine-II adapter at 0x9400.
 Station address 00:05:5d:09:90:1f.
 Tx disabled, Rx enabled, half-duplex (0x800c).
  Receive  mode is 0x6c: Normal unicast and hashed multicast.
  Transmit mode is 0x22: Transmitter set to INTERNAL LOOPBACK!.
[..]

This seems to be the problem. Reloading the module does not help
anymore. I'd guess forcing the transmit mode in the reset to something
sane would help??

Any ideas what can be done for further debugging this problem? 



On Mon, Aug 27, 2001 at 09:02:29PM +0200, Urban Widmark wrote:
[kernels]

I tried it with this kernels:

2.2.19

Resets correctly with rm-/insmod

2.2.19 with Dennis' patch

Resets often, but no lock up.

2.4.9 with via-rhine.c from 2.4.2

Resets correctly with rm-/insmod

2.4.9 with via-rhine.c from 2.4.3

First resets correctly. After third or fourth time locks up, with
transmit mode 0x21 (which via-diag says is the same as 0x20)

2.4.9

Resets a fwe times correctly, then see above.


> > but doing one or two parallel ping -f other.machine locks the NIC for
> > good.
> 
> Good (that you have a reliable way to trigger this). For about how long do
> you need to run this?

10-20 seconds.

> > The network where the DFE530TX (and the other.machine) are attached
> > contains some 20-30 Windows PCs and some Novell Servers which all seem
> > quite braodcast-happy. The network itself is (mostly) unswitched and
> > 10Mbit halfduplex, so I guess this really is connected to the
> > collisions.
> 
> Depending on the sort of access you have, you could test unplugging
> everyone else and repeat the 'ping -f' test.

I try and take the card home, there I have some more possibilities to
test.

Regards, David
-- 
Signaturen sind wie Frauen. Man findet selten eine Vernuenftige
	-- gesehen in at.linux
