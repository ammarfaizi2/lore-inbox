Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTFWPJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 11:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTFWPJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 11:09:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35789 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263945AbTFWPJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 11:09:04 -0400
Date: Mon, 23 Jun 2003 16:23:10 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Martin Mares <mj@ucw.cz>
Subject: [PCI] Various legacy probing options
Message-ID: <20030623152310.GG2620@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd like to take the logic that checks whether a bus has already
been scanned out of pcibios_scan_root() and push it down into
pci_scan_bus{,_parented}().

The trouble is that pci_scan_bus() already has a check for whether
a bus has been scanned or not and returns the opposite possibiity
(pcibios_scan_root() returns the bus if it exists; pci_scan_bus()
returns NULL if that bus already exists).

Most callers of pci_scan_bus() don't even bother to check the return
value, so they don't care if this changes.  The only caller I can find
that actually cares is arch/i386/pci/irq.c:pirq_peer_trick() [can someone
check me on this?  some of the architectures are a bit strange].

I wonder if this case ever occurs, though.  pirq_peer_trick() is called
from pcibios_irq_init() which is a subsys_initcall.  irq.o is linked
after legacy.o, which contains the subsys_initcall pci_legacy_init(),
which calls pcibios_fixup_peer_bridges() which already iterates over
0-pcibios_last_bus looking for busses.

Are there really broken PCs out there that will have additional bridges
found in the PIRQ tables after pcibios_last_bus?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
