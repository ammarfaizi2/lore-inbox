Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbRESMEe>; Sat, 19 May 2001 08:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbRESMEY>; Sat, 19 May 2001 08:04:24 -0400
Received: from pD951F4AB.dip.t-dialin.net ([217.81.244.171]:36101 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S261782AbRESMEQ>; Sat, 19 May 2001 08:04:16 -0400
Date: Sat, 19 May 2001 14:04:13 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: linux-net@vger.rutgers.edu, becker@scyld.com, jgarzik@mandrakesoft.com
Subject: RTL8139 difficulties in 2.2, not in 2.4
Message-ID: <20010519140413.B1795@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.rutgers.edu, becker@scyld.com,
	jgarzik@mandrakesoft.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having difficulties with a RTL8139 with Linux 2.2.19 (both drivers),
but not with Linux 2.4.4's 8139too driver. The card is an Allied Telesyn
AT-2500TX, the chip is reported as 8139C/rev. 0x10. The card shares its
IRQ 9 with an nVidia Riva TNT 128 [NV04], rev. 4.

(eth0 is a 3C900 Combo with 10base2 network)

The card is connected to a Siemens DSL modem which Deutsche Telekom AG
provides me with, mii-diag claims that modem refuses auto-negotiation,
the modem officially talks 10BaseT, not sure if half or full duplex.

This is the 8139/8129 driver of 2.2.19 speaking (note updating that to
the scyld.com v1.13 driver doesn't help):

eth1: RealTek RTL8139 Fast Ethernet at 0xbc00, IRQ 9, [MAC NOT SHOWN]
...
eth1: Transmit timeout, status 0d 0004 media 18.
eth1: Tx queue start entry 44  dirty entry 40.
eth1:  Tx descriptor 0 is 9008a06e. (queue head)
eth1:  Tx descriptor 1 is 9008a06e.
eth1:  Tx descriptor 2 is 9008a06e.
eth1:  Tx descriptor 3 is 9008a06e.
eth1: MII #32 registers are: 1000 782d 0000 0000 01e1 0000 0000 0000.
...
eth1: Tx queue start entry 4  dirty entry 0.
eth1: Transmit timeout, status 0c 0005 media 18.
eth1: Tx queue start entry 4  dirty entry 0.
eth1: Transmit timeout, status 0c 0005 media 18.
eth1: Tx queue start entry 4  dirty entry 0.
eth1: RTL8139 Interrupt line blocked, status 5.
eth1: RTL8139 Interrupt line blocked, status 5.
eth1: RTL8139 Interrupt line blocked, status 4.
eth1: RTL8139 Interrupt line blocked, status 4.
(continues every minute with status 4 if no traffic on interface)

The 8139too driver with 2.2.19 reports this:

eth1: Setting half-duplex based on auto-negotiated partner ability 0000.
eth1: Tx queue start entry 44  dirty entry 40.
eth1:  Tx descriptor 0 is 00002000. (queue head)
eth1:  Tx descriptor 1 is 00002000.
eth1:  Tx descriptor 2 is 00002000.
eth1:  Tx descriptor 3 is 00002000.
eth1: Setting half-duplex based on auto-negotiated partner ability 0000.

no mentionings about 8139 IRQ difficulties with 8139too.

There has been a similar report in the German-language
t-online.zugang.adsl newsgroup.

2.4.4 only has the "Setting half-duplex" log entry, no more eth1 log
entries, and is working properly.


Here's a diff from the rtl8139-diag v1.01 output, from 2.2 to 2.4:

--- 8139-2.2	Sat May 19 11:01:20 2001
+++ 8139-2.4	Sat May 19 12:28:24 2001
@@ -1,12 +1,12 @@
 rtl8139-diag.c:v1.01 4/30/99 Donald Becker (becker@cesdis.gsfc.nasa.gov)
 Index #1: Found a RealTek RTL8139 adapter at 0xbc00.
 RealTek chip registers at 0xbc00
- 0x000: 3d843000 0000c29c 80000000 00000000 9008a0f8 9008a0c6 9008a0c6 9008a0fe
- 0x020: 0732a000 0732a600 0732ac00 0732b200 07300000 0d0a0000 00cc00bc 0000c07f
- 0x040: 74000400 00009c0e d5a60770 00000000 002c10c6 00000000 008cc118 00100000
+ 0x000: 3d843000 0000c29c 00000000 00000000 9008a03c 9008a03e 9008a03c 9008a062
+ 0x020: 038f2000 038f2600 038f2c00 038f3200 06a30000 0d0a0000 41b441a4 0000c07f
+ 0x040: 74000600 0200f78a c5903fe1 00000000 000d10c6 00000000 0088d118 00100000
  0x060: 1000f00f 01e1782d 00000000 00000000 00000005 000f77c0 b0f243b9 7a36d743.
   No interrupt sources are pending.
- The chip configuration is 0x10 0x2c, MII half-duplex mode.
+ The chip configuration is 0x10 0x0d, MII half-duplex mode.
 Parsing the EEPROM of a RealTek chip:
   PCI IDs -- Vendor 0x10ec, Device 0x8139, Subsystem 0x1259.
   PCI timer settings -- minimum grant 32, maximum latency 64.

Can someone help?

-- 
Matthias Andree
