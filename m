Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263130AbTCWRsX>; Sun, 23 Mar 2003 12:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263134AbTCWRsX>; Sun, 23 Mar 2003 12:48:23 -0500
Received: from imspcml002.netvigator.com ([203.198.23.216]:7815 "EHLO
	imspcml002.netvigator.com") by vger.kernel.org with ESMTP
	id <S263130AbTCWRsV>; Sun, 23 Mar 2003 12:48:21 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Subject: Re: ISAPNP BUG: 2.4.65 ne2000 driver w. isapnp not working
Date: Mon, 24 Mar 2003 01:57:53 +0800
User-Agent: KMail/1.5
References: <3E7DE01B.2B6985DF@megsinet.net>
In-Reply-To: <3E7DE01B.2B6985DF@megsinet.net>
Cc: linux-kernel@vger.kernel.org
x-os: GNU/Linux 2.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303240157.53373.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

Thank you for your message and patch which I tested. Firstlye some more background info.

I just started testing 2.5 on all kinds of hw.  This is being done on RH beta 8.094 (phoebe)

This machine is an old 586 w/o ACPI and bootet with acpi=off. I sent messages  and dmesg to your email only.

1) 2.5.65 + acpi20030321, isapnp fails on the _first_ attempt and works on the second and further(rmmod ne and 8390) attempts. There is a kernel message during ifup which may give you a hint

1st attempt:
 kernel: pnp: res: The PnP device '01:01.00' is already active.
 kernel: ne.c: You must supply "io=0xNNN" value(s) for ISA cards.
 ifup: ne device eth0 does not seem to be present, delaying initialization.
 network: Bringing up interface eth0:  failed

2nd (and further after rmmod) attempt:
 kernel: ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
 kernel: Last modified Nov 1, 2000 by Paul Gortmaker
 kernel: NE*000 ethercard probe at 0x2a0: 00 00 ff ff 27 ef
 kernel: eth0: NE2000 found at 0x2a0, using IRQ 15.
 network: Bringing up interface eth0:  succeeded

2) 2.5.65 + acpi20030321 + your patch, pnp does not work at all, but the module can be inserted with modprobe ne io=0x2a0 irq=15. It seems it does not talk to the ne code as Beckers msg missing?

All attempts of ifup eth0 or service network start:

ifup: Cannot find device "eth0"
network: Bringing up loopback interface:  succeeded
kernel: ne.c: You must supply "io=0xNNN" value(s) for ISA cards.
ifup: ne device eth0 does not seem to be present, delaying initialization.
network: Bringing up interface eth0:  failed

modprobe ne io=0x2a0 irq=15:

kernel: ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
kernel: Last modified Nov 1, 2000 by Paul Gortmaker
kernel: NE*000 ethercard probe at 0x2a0: 00 00 ff ff 27 ef
kernel: eth0: NE2000 found at 0x2a0, using IRQ 15.
 

for me not yet ... :-)
Michael


On Monday 24 March 2003 00:26, you wrote:
> > Hello.
> >
> > Have some trouble with loading modules (see earlier
> > message). Tried to compile a driver in.
> >
> > dmesg:
> > -------
> > isapnp: Scanning for PnP cards...
> > isapnp: Card Plug & Play Ethernet card
> > isapnp: 1 Plug and Play card detected total
> > ------
> >
> > - no further references do isapnp in logs
> >
> > - Same card works (with pnp disabled (jumper) and driver
> > compiled as a module) by modprobing it with io=0x300
> >
> > - Same card works with 2.4.21-pre5 driver as module both
> > with pnp and modual probing
> >
> >         Regards
> >         Michael
> > -
>
> Michael,
>
> NE2k ISAPNP broke around 2.5.64, again.  There are 2 parts to
> the attached patch, one to move the NIC initialization earlier
> in the boot sequence and the second is a HACK to get ne2k to
> work when compiled into the kernel, I've never tried NE2k as a
> module...
>
> 1. The level of isapnp_init was moved to after apci.  Since it
> is now after net_dev_init, ISA PNP NICs fail to initialized at
> boot.
>
>    This fix allows ISA PNP NIC cards to work during
> net_dev_init, and still leaves isapnp_init after apci_init.
>
> 2. The second piece kills off a now ?unnecessary? probe.
>
> Works for me,
> Martin

