Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130396AbQLNPrn>; Thu, 14 Dec 2000 10:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132099AbQLNPrd>; Thu, 14 Dec 2000 10:47:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59666 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130396AbQLNPrZ>;
	Thu, 14 Dec 2000 10:47:25 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012141516.eBEFG5B06658@flint.arm.linux.org.uk>
Subject: Physical memory addresses/PCI memory addresses/io_remap_page_range/etc
To: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Date: Thu, 14 Dec 2000 15:16:04 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking at a frame buffer driver, and I'm getting a little confused...

To remove any confusion (since I know that people get confused with the
terminology here), here is how I define these addresses:

  virtual space    - address space that the kernel runs in
  physical space   - address space that the CPU sits in
  PCI memory space - memory address space that the PCI peripherals sit in

Many, if not all ARM architectures have physical address 0 different from
PCI memory address 0.

According to include/linux/fb.h, fb drivers should place a physical address
into "fix.smem_start" and "fix.mmio_start", which can then be passed to
io_remap_page_range.

However, many drivers (eg, Matrox Millenium) place the PCI memory space
address here (obtained from pci_resource_start), and this tends to cause
things to fail on ARM machines.

If we were to change (where possible) the PCI memory space such that it did
tie up with the physical address, then we loose the ability to use vgacon
consoles, which in turn means that there would have to be fbcon drivers for
a lot more PCI VGA cards in the kernel (since vgacon needs to access the usual
PCI memory address 0xb8000).

The questions (that I would like someone authoritive on this to answer)
are:

1. Should pci_resource_start be returning the PCI memory space address or
   a physical memory space address?

2. Should io_remap_page_range take a PCI memory space address or a physical
   memory space address?

3. Do we need a macro to convert PCI memory space addresses to physical
   memory space addresses?

4. What does this mean for ioremap?  (currently, on ARM, ioremap takes
   PCI memory space addresses, not a physical memory address, which makes
   the physmap MTD driver technically broken).

Help!
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
