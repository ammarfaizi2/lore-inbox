Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWJTDVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWJTDVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWJTDVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:21:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26793
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751623AbWJTDVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:21:16 -0400
Date: Thu, 19 Oct 2006 20:21:17 -0700 (PDT)
Message-Id: <20061019.202117.123674883.davem@davemloft.net>
To: eiichiro.oiwa.nm@hitachi.com
Cc: jesse.barnes@intel.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002709U45383afc@hitachi.com>
References: <200610191103.16689.jesse.barnes@intel.com>
	<20061019.155844.18310932.davem@davemloft.net>
	<XNM1$9$0$4$$3$3$7$A$9002709U45383afc@hitachi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <eiichiro.oiwa.nm@hitachi.com>
Date: Fri, 20 Oct 2006 11:57:06 +0900

> I am sorry. I assumed ROM base address will be 0xc0000 if VGA Enable
> bit in Bridge Control Register set. This assuming is incorrect.

Please also notice another point we are trying to explain in this
thread, in fact several times.

This "bridge control register" is only valid for "PCI to PCI" bridges.

I repeat:

	This "bridge control register" is only valid for "PCI to PCI"
	bridges.

It is not valid for "host to PCI" bridges, yet the pci_fixup_video()
code is testing the bridge control register, blindly, in every bus
device it sees as it walks up the device tree to the root.

The bridge control register is valid for PCI header type BRIDGE, or
CARDBUS.  Host to PCI controllers use PCI header type NORMAL.  For
example, here is the lspci dump for my host bridge:

0000:00:00.0 Host bridge: Sun Microsystems Computer Corp. Tomatillo PCI Bus Module
00: 8e 10 01 a8 46 01 a0 22 00 00 00 06 00 40 00 00

and here is a dump for a PCI->PCI bridge in the same machine:

0000:00:02.0 PCI bridge: Texas Instruments PCI2250 PCI-to-PCI Bridge (rev 02)
00: 4c 10 23 ac 07 00 10 02 02 00 04 06 10 40 01 00

Clearly, the host bridge has PCI header type 0x00 (NORMAL) at offset
0x0e, and the PCI-PCI bridge has header type 0x01 (BRIDGE).

Back to the code, look at the loop:

	bus = pdev->bus;
	while (bus) {
		bridge = bus->self;
		if (bridge) {
			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
						&config);
			if (!(config & PCI_BRIDGE_CTL_VGA))
				return;
		}
		bus = bus->parent;
	}

Where is it making sure that this is a PCI to PCI bus and not a
host to PCI bus?  It's not, and that's a serious bug.  There should
be a PCI header type check here, or similar.  The PCI device probing
layer correctly checks the PCI header type before trying to access
the bridge control register of any PCI device.

And also, it is also true that the ioremap() calls done by
pci_map_rom() for the "0xc0000" case are totally invalid.  For several
reasons:

1) That is going to be RAM, not I/O memory space, therefore accessing
   it with ioremap() and asm/io.h accessors such as readl() and
   memcpy_fromio() will result in bus errors and other faults.

2) It is illegal to pass raw physical addresses to ioremap() as the
   first argument.  The first argument to ioremap() is an architecture
   defined opaque "address cookie" which by definition must be setup
   by platform specific code.

Just copying the x86 code over to IA64 to 'fix the problem' doesn't
fix any of these bugs (illegal access to bridge control register on
devices with PCI header type NORMAL) or portability problems (invalid
first argument to ioremap()).
