Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbTJVO0K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 10:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTJVO0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 10:26:10 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:35334 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263430AbTJVO0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 10:26:04 -0400
Date: Wed, 22 Oct 2003 18:25:37 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.6] fix bug in pci_setup_bridge()
Message-ID: <20031022182537.A5277@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug prevents Alphas with older firmware from booting if there
is a card with PCI-PCI bridge that supports 32-bit IO.
This has happened on AS2100 with a quad-tulip card, for example:
 - initially, the I/O window of 21152 bridge was 0x10000-0x10fff,
   as set up by firmware;
 - pci_setup_bridge() is going to change this, say, to 0xa000-0xafff:
   first, it updates PCI_IO_BASE_UPPER16 and PCI_IO_LIMIT_UPPER16
   registers, so that IO window temporarily is at 0x0000-0x0fff,
   which effectively blocks up all legacy IO ports in the lower
   4K range, such as serial, floppy, RTC an so on;
   does debugging printk - machine dies here with recursive
   machine checks as the serial console has gone.

Moving (or disabling) the debugging printk is not a solution -
there is possibility that timer interrupt (which might access RTC
ports) occurs between writes to lower and upper parts of the
base/limit registers.

The patch temporarily disables the IO window of the bridge by
setting PCI_IO_BASE_UPPER16 > PCI_IO_LIMIT_UPPER16 before doing
an update. It's safe, as we don't have any active IO behind
the bridge at this point. Also, it's a NOP for bridges with
16-bit-only IO.
Similar (but simpler, as we always clear upper 32 bits) fix
for 64-bit prefetchable MMIO range.

Ivan.

--- 2.6/drivers/pci/setup-bus.c	Sat Oct 18 01:43:35 2003
+++ linux/drivers/pci/setup-bus.c	Tue Oct 21 14:43:30 2003
@@ -132,13 +132,19 @@ pci_setup_cardbus(struct pci_bus *bus)
    PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
    requires that if there is no I/O ports or memory behind the
    bridge, corresponding range must be turned off by writing base
-   value greater than limit to the bridge's base/limit registers.  */
+   value greater than limit to the bridge's base/limit registers.
+
+   Note: care must be taken when updating I/O base/limit registers
+   of bridges which support 32-bit I/O. This update requires two
+   config space writes, so it's quite possible that an I/O window of
+   the bridge will have some undesirable address (e.g. 0) after the
+   first write. Ditto 64-bit prefetchable MMIO.  */
 static void __devinit
 pci_setup_bridge(struct pci_bus *bus)
 {
 	struct pci_dev *bridge = bus->self;
 	struct pci_bus_region region;
-	u32 l;
+	u32 l, io_upper16;
 
 	DBGC((KERN_INFO "PCI: Bus %d, bridge: %s\n",
 			bus->number, pci_name(bridge)));
@@ -151,20 +157,22 @@ pci_setup_bridge(struct pci_bus *bus)
 		l |= (region.start >> 8) & 0x00f0;
 		l |= region.end & 0xf000;
 		/* Set up upper 16 bits of I/O base/limit. */
-		pci_write_config_word(bridge, PCI_IO_BASE_UPPER16,
-				      region.start >> 16);
-		pci_write_config_word(bridge, PCI_IO_LIMIT_UPPER16,
-				      region.end >> 16);
+		io_upper16 = (region.end & 0xffff0000) | (region.start >> 16);
 		DBGC((KERN_INFO "  IO window: %04lx-%04lx\n",
 				region.start, region.end));
 	}
 	else {
 		/* Clear upper 16 bits of I/O base/limit. */
-		pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0);
+		io_upper16 = 0;
 		l = 0x00f0;
 		DBGC((KERN_INFO "  IO window: disabled.\n"));
 	}
+	/* Temporarily disable the I/O range before updating PCI_IO_BASE. */
+	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0x0000ffff);
+	/* Update lower 16 bits of I/O base/limit. */
 	pci_write_config_dword(bridge, PCI_IO_BASE, l);
+	/* Update upper 16 bits of I/O base/limit. */
+	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, io_upper16);
 
 	/* Set up the top and bottom of the PCI Memory segment
 	   for this bus. */
@@ -181,8 +189,9 @@ pci_setup_bridge(struct pci_bus *bus)
 	}
 	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 
-	/* Clear out the upper 32 bits of PREF base/limit. */
-	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0);
+	/* Clear out the upper 32 bits of PREF limit.
+	   If PCI_PREF_BASE_UPPER32 was non-zero, this temporarily
+	   disables PREF range, which is ok. */
 	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
 
 	/* Set up PREF base/limit. */
@@ -198,6 +207,9 @@ pci_setup_bridge(struct pci_bus *bus)
 		DBGC((KERN_INFO "  PREFETCH window: disabled.\n"));
 	}
 	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
+
+	/* Clear out the upper 32 bits of PREF base. */
+	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0);
 
 	/* Check if we have VGA behind the bridge.
 	   Enable ISA in either case (FIXME!). */
