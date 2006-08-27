Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWH0KNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWH0KNQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 06:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWH0KNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 06:13:16 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:64994 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750696AbWH0KNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 06:13:15 -0400
Date: Sun, 27 Aug 2006 06:07:04 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Message-ID: <200608270610_MC3-1-C975-E8B8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get these messages with 2.6.18-rc4 on i386:

        PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
        PCI: Cannot allocate resource region 8 of bridge 0000:00:04.0
        PCI: Cannot allocate resource region 9 of bridge 0000:00:04.0
        PCI: Cannot allocate resource region 7 of bridge 0000:00:05.0
        PCI: Cannot allocate resource region 8 of bridge 0000:00:05.0


For these PCI bridges:

00:04.0 PCI bridge: ATI Technologies Inc Unknown device 5a36 (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot-) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
        Capabilities: [b0] #0d [0000]
        Capabilities: [b8] HyperTransport: MSI Mapping
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel

00:05.0 PCI bridge: ATI Technologies Inc Unknown device 5a37 (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot-) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
        Capabilities: [b0] #0d [0000]
        Capabilities: [b8] HyperTransport: MSI Mapping
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel


Adding some debug:

--- 2.6.18-rc4-32.orig/arch/i386/pci/i386.c
+++ 2.6.18-rc4-32/arch/i386/pci/i386.c
@@ -100,6 +100,7 @@
        struct pci_dev *dev;
        int idx;
        struct resource *r, *pr;
+       int ret;

        /* Depth-First Search on bus tree */
        list_for_each_entry(bus, bus_list, node) {
@@ -109,8 +110,10 @@
                                if (!r->flags)
                                        continue;
                                pr = pci_find_parent_resource(dev, r);
-                               if (!r->start || !pr || request_resource(pr, r) < 0) {
+                               ret = 0;
+                               if (!r->start || !pr || (ret = request_resource(pr, r)) < 0) {
                                        printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));
+                                       printk(KERN_ERR "PCI: start = %p, parent = %p, ret = %d\n", r->start, pr, ret);
                                        /* Something is wrong with the region.
                                           Invalidate the resource to prevent child
                                           resource allocations in this range. */


r->start is zero in every case.


Some PCI debug messages for one bridge:

 PCI: Using MMCONFIG
 ...
 PCI: Scanning behind PCI bridge 0000:00:04.0, config 030200, pass 0
 PCI: Scanning bus 0000:02
 PCI: Fixups for bus 0000:02
 PCI: Bus scan for 0000:02 returning with max=02
 ...
 PCI: Scanning behind PCI bridge 0000:00:04.0, config 030200, pass 1
 ...
 PCI: Bridge: 0000:00:04.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
 ...
 PCI: Enabling bus mastering for device 0000:00:04.0
 PCI: Setting latency timer of device 0000:00:04.0 to 64
 ...
 PCI: Setting latency timer of device 0000:00:04.0 to 64
 pcie_portdrv_probe->Dev[5a36:1002] has invalid IRQ. Check vendor BIOS
 assign_interrupt_mode Found MSI capability
 Allocate Port Service[0000:00:04.0:pcie00]
 PM: Adding info for pci_express:0000:00:04.0:pcie00
 Allocate Port Service[0000:00:04.0:pcie01]
 PM: Adding info for pci_express:0000:00:04.0:pcie01
 Allocate Port Service[0000:00:04.0:pcie03]
 PM: Adding info for pci_express:0000:00:04.0:pcie03

It says (twice) it is setting latency timer to 64 yet lspci says it's zero.

I tried pci=nobios.  What else should I try?

-- 
Chuck
