Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131414AbQLGXVo>; Thu, 7 Dec 2000 18:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131462AbQLGXVY>; Thu, 7 Dec 2000 18:21:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2062 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131414AbQLGXVU>;
	Thu, 7 Dec 2000 18:21:20 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012072246.eB7Mk9e13384@flint.arm.linux.org.uk>
Subject: PCI bridge setup weirdness
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Dec 2000 22:46:08 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel 2.4.0-test12-pre7

There appears to be a possibility whereby the root resources (ioport_resource
and iomem_resource) can get modified by the PCI code:

Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Fast back to back transfers enabled
ioport: 00000000 - 0000ffff
ioport0: 00001000 - 0000ffff
ioport1: 00001000 - 0000ffff
PCI: Bus 1, bridge: Digital Equipment Corporation DECchip 21152
  IO window: 0000-0fff
  MEM window: 00000000-000fffff
ioport2: 00001000 - 00001fff
ioport: 00001000 - 00001fff

So now the PCI IO resource contains 0x1000 to 0x1fff.  Unfortunately,
the PCI devices on the root bus are allocated to IO ports 0x4000 and
up.

This means that drivers are unable to request their resources:

Linux Tulip driver version 0.9.11 (November 3, 2000)
conflict: 1000-1fff: PCI IO (100)
tulip: eth0: I/O region (0x80@0x4400) unavailable, aborting
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
conflict: 1000-1fff: PCI IO (100)
eepro100: cannot reserve I/O ports

It appears to be caused by the pci_read_bridge_bases code copying the
pointer to the resources instead of making a copy of the resources
themselves.

I'm not sure what the correct fix is here (there have been some recent
changes in this area, but I'll hack around it for now).
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
