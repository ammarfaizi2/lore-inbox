Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVJ0PJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVJ0PJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVJ0PJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:09:03 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:595 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750960AbVJ0PJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:09:03 -0400
To: Matthew Wilcox <matthew@wil.cx>
Cc: gregkh@suse.de, mst@mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
X-Message-Flag: Warning: May contain useful information
References: <524q799p2t.fsf@cisco.com>
	<20051022233220.GA1463@parisc-linux.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 27 Oct 2005 08:08:45 -0700
In-Reply-To: <20051022233220.GA1463@parisc-linux.org> (Matthew Wilcox's
 message of "Sat, 22 Oct 2005 17:32:20 -0600")
Message-ID: <52hdb3yp36.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 27 Oct 2005 15:08:46.0455 (UTC) FILETIME=[53F28070:01C5DB08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Matthew> Perhaps the right thing to do is to change pad2 (in
    Matthew> struct pci_bus) to bus_flags and make bit 0
    Matthew> PCI_BRIDGE_FLAGS_NO_MSI ?

Seems reasonable, but I'm still not sure how to implement this.  Where
does this bit get set and propagated to secondary buses?

To give a somewhat pathological real-world example, Mellanox PCI-X
adapters have a PCI bridge in them; in other words, a single adapter
looks like:

	0000:03:01.0 PCI bridge: Mellanox Technologies MT23108 PCI Bridge (rev a1) (prog-if 00 [Normal decode])
		Flags: bus master, 66MHz, medium devsel, latency 64
		Bus: primary=03, secondary=04, subordinate=04, sec-latency=68
		Memory behind bridge: e8200000-e82fffff
		Prefetchable memory behind bridge: 00000000ea800000-00000000f7f00000
		Capabilities: [70] PCI-X bridge device.
	
	0000:04:00.0 InfiniBand: Mellanox Technologies MT23108 InfiniHost (rev a1)
		Subsystem: Mellanox Technologies MT23108 InfiniHost
		Flags: bus master, fast Back2Back, 66MHz, medium devsel, latency 64, IRQ 185
		Memory at e8200000 (64-bit, non-prefetchable) [size=1M]
		Memory at ea800000 (64-bit, prefetchable) [size=8M]
		Memory at f0000000 (64-bit, prefetchable) [size=128M]
		Capabilities: [40] #11 [001f]
		Capabilities: [50] Vital Product Data
		Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/5 Enable-
		Capabilities: [70] PCI-X non-bridge device.

That means the NO_MSI flag still needs to get propagated from the 8131
bridge to the Mellanox bridge, and that needs to cause no_msi to get
set on the actual device.

Also, if someone hot-plugged such an adapter into a bus below an AMD
8131 host bridge (I believe eg Sun V40Zs have hot-pluggable slots like
that), then the NO_MSI flag still needs to get propagated from the
8131 bridge to the Mellanox bridge and set no_msi on the final device.

Where in the PCI driver code is the right place to handle all this (I
hope by writing the code only once)?

 - R.
