Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbQLGTyM>; Thu, 7 Dec 2000 14:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130877AbQLGTyC>; Thu, 7 Dec 2000 14:54:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26374 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130870AbQLGTxy>;
	Thu, 7 Dec 2000 14:53:54 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012071922.TAA09634@raistlin.arm.linux.org.uk>
Subject: Oops while assigning PCI resources
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Dec 2000 19:22:24 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel is 2.4.0-test12-pre7

I'm seeing an oops while assigning PCI resources on an ARM board.  This
board as a PCI to PCI bridge on board without any devices on the second
bus.

Trace is:

Trace; c0013ac0 <pbus_assign_resources+0/e4>
Trace; c0013ba4 <pci_assign_unassigned_resources+0/98>
Trace; c0009f34 <pcibios_init+0/68>
Trace; c0012db4 <pci_init+0/44>
Trace; c00089ec <do_basic_setup+0/54>

The place which is causing the oops is in drivers/pci/setup-bus.c:

        for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
                struct pci_bus *b = pci_bus_b(ln);

                vvvvvvvvvvvvvvvvvvvvv
                b->resource[0]->start = ranges->io_start = ranges->io_end;
                ^^^^^^^^^^^^^^^^^^^^^
                b->resource[1]->start = ranges->mem_start = ranges->mem_end;

                pbus_assign_resources(b, ranges);

The reason is because b->resource is NULL.  Looking at drivers/pci/pci.c,
when we hit a non-cardbus bridge, we never set b->resource[*] to point to
anything.  We call "pci_add_new_bus" from pci_scan_bridge, but neither
pci_add_new_bus nor pci_scan_bridge sets up the resources.

Unfortunately, the PCI bus code (in drivers/pci/setup-bus.c) seems to
assume that someone somewhere has allocated these resources.
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
