Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWCGPQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWCGPQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWCGPQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:16:44 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:21512 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751032AbWCGPQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:16:43 -0500
Date: Tue, 7 Mar 2006 15:16:27 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060307151627.GB9834@deprecation.cyrius.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com> <20060306191706.GA6947@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306191706.GA6947@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Michlmayr <tbm@cyrius.com> [2006-03-06 19:17]:
> There's another interrupt related bug in the driver, though.  I

There's yet another bug (or two).

I just got another kernel panic:
http://www.cyrius.com/tmp/de2104x_panic2.jpg (which I haven't been
able to reproduce so far; this was without your latest patch applied,
btw).  This happened when I was doing DHCP while my server was not
responding to DHCP.  I wonder if it's related to another issue I've
observed.

This card is a D-Link DE 530 with both a BNC and RJ-45 connector.
When I boot my machine without having the Ethernet cable plugged in,
Linux thinks there's a BNC connection.  When I plug in the cable, the
link light on the card goes on but Linux doesn't seem to notice - in
fact, when I then start DHCP again, the link light goes off again and
Linux talks about BNC being up... [FWIW, Linux 2.4 doesn't handle this
situation either.  Under 2.4 the link light doesn't even come up.]


dmesg: booting without the RJ-45 cable plugged in, doing DHCP, then
plugging the RJ-45 cable in and doing DHCP again:

hda: 4999680 sectors (2559 MB) w/256KiB Cache, CHS=4960/16/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 >
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
de0: SROM leaf offset 30, default media 10baseT auto
de0:   media block #0: 10baseT-FD
de0:   media block #1: BNC
de0:   media block #2: 10baseT-HD
eth0: 21041 at 0xb8802000, 00:80:c8:33:4f:96, IRQ 10
Probing IDE interface ide1...
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.12ac
input: PC Speaker as /class/input/input1
FDC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Adding 136512k swap on /dev/hda5.  Priority:-1 extents:1 across:136512k
EXT3 FS on hda1, internal journal
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
eth0: enabling interface
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
eth0: set link BNC
eth0:    mode 0x7ffc0000, sia 0x10c4,0xffffef09,0xfffff7fd,0xffff0006
eth0:    set mode 0x7ffc0000, set sia 0xef09,0xf7fd,0x6
eth0: link up, media BNC
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
eth0: disabling interface
eth0: timeout expired stopping DMA
ACPI: PCI interrupt for device 0000:00:0b.0 disabled
eth0: enabling interface
eth0: set link BNC
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef09,0xfffff7fd,0xffff0006
eth0:    set mode 0x7ffc0040, set sia 0xef09,0xf7fd,0x6
ADDRCONF(NETDEV_UP): eth0: link is not ready
eth0: link up, media BNC
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present


As a comparison, this happens when I boot with the RJ-45 cable plugged
in:

ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
de0: SROM leaf offset 30, default media 10baseT auto
de0:   media block #0: 10baseT-FD
de0:   media block #1: BNC
de0:   media block #2: 10baseT-HD
eth0: 21041 at 0xb8802000, 00:80:c8:33:4f:96, IRQ 10
Probing IDE interface ide1...
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.12ac
input: PC Speaker as /class/input/input1
FDC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Adding 136512k swap on /dev/hda5.  Priority:-1 extents:1 across:136512k
EXT3 FS on hda1, internal journal
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
eth0: enabling interface
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
eth0: link up, media 10baseT auto
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

-- 
Martin Michlmayr
http://www.cyrius.com/
