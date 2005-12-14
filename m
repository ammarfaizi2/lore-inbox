Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVLNTt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVLNTt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVLNTt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:49:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:52131 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964875AbVLNTt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:49:56 -0500
Date: Wed, 14 Dec 2005 13:45:30 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: pci_scan_bridge and cardbus controllers?
Message-ID: <Pine.LNX.4.44.0512141311140.14530-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in pci_fixup_parent_subordinate_busnr() we will only reassign bus numbers 
if pcibios_assign_all_busses() returns 1.

If we got to pci_fixup_parent_subordinate_busnr() and
pcibios_assign_all_busses() returns 0, should we not print out some
warning since we most likely got here because the bios didn't init things
properly?

I came across this on an embedded system in which we had a cardbus 
controller behind a P2P bridge.  The bios did not reserve any bus numbers 
for the cardbus controller like linux does.  So I ended up with:

03:04.0 CardBus bridge: Texas Instruments PCI4510 PC card Cardbus Controller (rev 03)
        Flags: bus master, medium devsel, latency 0, IRQ 18
        Memory at 00000000bb100000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=03, secondary=04, subordinate=07, sec-latency=176
        Memory window 0: b9000000-bafff000
        Memory window 1: 9dc00000-9efff000 (prefetchable)
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

and the P2P bridge:
00:11.0 PCI bridge: Pericom Semiconductor PCI to PCI Bridge (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
        I/O behind bridge: 00efe000-00ffdfff
        Memory behind bridge: b6000000-bb7fffff
        Prefetchable memory behind bridge: 000000008fc00000-000000009db00000
        Capabilities: [dc] Power Management version 1
        Capabilities: [b0] Slot ID: 0 slots, First-, chassis 00

Seems like a case we should warn about or not update the cardbus 
controller's subordinate number if pcibios_assign_all_busses() returns 0.

- kumar

