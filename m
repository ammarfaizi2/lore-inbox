Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279502AbRKASfC>; Thu, 1 Nov 2001 13:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279505AbRKASe5>; Thu, 1 Nov 2001 13:34:57 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:12050 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S279502AbRKASen>; Thu, 1 Nov 2001 13:34:43 -0500
Date: Thu, 1 Nov 2001 19:34:37 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: xircom_cb and promiscious mode
Message-ID: <20011101193437.B924@torres.ka0.zugschlus.de>
In-Reply-To: <20011101112628.A30743@torres.ka0.zugschlus.de> <200111011547.fA1Fl3B23182@buggy.badula.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111011547.fA1Fl3B23182@buggy.badula.org>; from ionut@cs.columbia.edu on Thu, Nov 01, 2001 at 10:47:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 10:47:03AM -0500, Ion Badulescu wrote:
> On Thu, 1 Nov 2001 11:26:28 +0100, Marc Haber <mh+linux-kernel@zugschlus.de> wrote:
> > I am quite interested in the problems that arise with the xircom
> > cardbus ethernet cards, since I have difficulties with them as well.
> > However, my problems are not solved by setting promisc mode.
> 
> Indeed, this sounds like a very different problem.

:-(

> > When I try to transmit larger amounts of data (such as scp'ing a 30 MB
> > file over from a different machine on the LAN), network transfer
> > stalls. I can abort the user space program, but the network link is
> > gone.
> 
> Ok, so let's take a closer look at this. I am mostly interested in the 
> behavior of the xircom_tulip_cb from 2.4.13+ and 2.4.12-ac4+ kernels.

OK. All tests have been done on 2.4.13-ac5.

> When you say the network link is gone, does it mean the network link light 
> on the card is gone?

No. The light (that is somewhere _inside_ the card for the R2BE-100)
stays on.

> What does mii-tool report?

This is what mii-tool reports while the link is still up:
|Basic registers of MII PHY #0:  1000 782d 0040 6331 00a1 45e1 0005 2001.
| The autonegotiated capability is 00a0.
|The autonegotiated media type is 100baseTx.
| Basic mode control register 0x1000: Auto-negotiation enabled.
| You have link beat, and everything is working OK.
| Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
|   End of basic transceiver informaion.

Invoking mii-diag after provoking the network freeze freezes the
entire machine. Not even magic sqsrq works in that situation.

> Do you get any kernel messages when the networking dies? Any netdev 
> transmit timeouts or anything else?

neither on syslog, nor on the console.

Sometimes, I get a "spurious 8259A interrupt: IRQ7" or " spurious
8259A interrupt: IRQ15" message on console and syslog, though.

> What are the messages you get from xircom_tulip_cb when it gets 
> initialized? [make sure you look at dmesg's output, some syslog 
> configurations don't log all kernel messages.]

I stopped pcmcia, unloaded all modules, and reloaded them again. This
is the relevant dmesg output:
|Linux Kernel Card Services 3.1.22
|  options:  [pci] [cardbus] [pm]
|PCI: Found IRQ 10 for device 00:09.0
|PCI: Sharing IRQ 10 with 00:09.1
|PCI: Found IRQ 10 for device 00:09.1
|PCI: Sharing IRQ 10 with 00:09.0
|Yenta IRQ list 0898, PCI irq10
|Socket status: 30000007
|Yenta IRQ list 0898, PCI irq10
|Socket status: 30000821
|cs: cb_alloc(bus 6): vendor 0x115d, device 0x0003
|PCI: Enabling device 06:00.0 (0000 -> 0003)
|cs: IO port probe 0x0c00-0x0cff: clean.
|cs: IO port probe 0x0800-0x08ff: clean.
|cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x37f 0x398-0x39f 0cs: IO port probe 0x0a00-0x0aff: clean.
|xircom_tulip_cb.c derived from tulip.c:v0.91 4/14/99 becker@scyld.com
| unofficial 2.4.x kernel port, version 0.91+LK1.1, October 11, 2001
| PCI: Setting latency timer of device 06:00.0 to 64
| eth0: Xircom Cardbus Adapter rev 3 at 0x4c00, 00:10:A4:98:CD:5C, IRQ 10.
|eth0:  MII transceiver #0 config 3000 status 7809 advertising 01e1.

> Can you run tcpdump on the other side of the scp connection to see what 
> exactly is going on?

Sure.
|19:10:31.258464 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:31.258610 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:31.258793 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:31.258978 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:31.258958 192.168.130.42.32781 > 172.20.206.6.22: tcp 0 (DF) [tos 0x8]
|19:10:31.259275 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:31.259464 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:31.259322 192.168.130.42.32781 > 172.20.206.6.22: tcp 0 (DF) [tos 0x8]
|19:10:31.259798 172.20.206.6.22 > 192.168.130.42.32781: tcp 476 (DF) [tos 0x8]
|19:10:31.276840 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:31.469788 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:31.889876 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:32.729853 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:34.409733 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:37.769731 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:44.489736 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:10:57.929585 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:11:24.809292 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:12:18.568665 172.20.206.6.22 > 192.168.130.42.32781: tcp 1448 (DF) [tos 0x8]
|19:12:23.568365 arp who-has 192.168.130.42 tell 192.168.130.1
|19:12:24.568352 arp who-has 192.168.130.42 tell 192.168.130.1
|19:12:25.568350 arp who-has 192.168.130.42 tell 192.168.130.1
|19:12:26.568327 arp who-has 192.168.130.42 tell 192.168.130.1
|19:12:27.568298 arp who-has 192.168.130.42 tell 192.168.130.1
|19:12:28.568296 arp who-has 192.168.130.42 tell 192.168.130.1

172.20.206.6 and 192.168.130.1 are the remote side (external and
internal IP of my border router), and 192.168.130.42 is the notebook
in question. tcpdump done on the border router. This looks like the
notebook simply stops answering, after which the remote side fills up
the window and then waits, arping for the notebook after running into
a time out.

> > 2.4.13-ac5 has the patched xircom_tulip_cb from 2.4.13-pre3?
> 
> It does.

Then there is still a bug. Or something's wrong here.

I cannot rule out that my notebook is broken, Chicony has a history of
making abysmally bad hardware, and the machine is about two years old.
I don't have a reference notebook that has Linux installed and can do
Cardbus to cross-check, sorry.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
