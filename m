Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbTC1VPx>; Fri, 28 Mar 2003 16:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263148AbTC1VPx>; Fri, 28 Mar 2003 16:15:53 -0500
Received: from compaq.com ([161.114.1.205]:1034 "EHLO ztxmail01.ztx.compaq.com")
	by vger.kernel.org with ESMTP id <S263147AbTC1VPu>;
	Fri, 28 Mar 2003 16:15:50 -0500
Date: Fri, 28 Mar 2003 15:28:45 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: PCI question
Message-ID: <20030328092845.GA1029@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it possible for a driver to know the size of each 
the BARs which struct pci_dev->resource[x].start corresponds with?

(e.g. whether it is a 64 bit BAR, or a 32 bit BAR?)

Why do I need to do this?

Because I have a controller (cciss driver) where some 
BARS may be sometimes 32 bit, sometimes 64 bit (depending 
on the board).

There's a sequence that you have to go through while init'ing
the board where you get an offset from PCI BAR 0 to know what
BAR to use for a certain other bit of memory.
Rather than reading that BAR directly, I want to use what's
in struct pci_dev->resource[x].start, but I do not know what
'x' is.  (I need to find x.)

Currently the code assumes all the BARs are 32 bits, so it does
something like this.

	x = (my_bar_offset  - PCI_BASE_ADDRESS_0)/4;

Instead, I need to do something along the lines of:

	offset = 0;
	for (i=0;i<DEVICE_COUNT_RESOURCES;i++) {
		if offset == (my_bar_offset - PCI_BASE_ADDRESS_0) {
			x = offset;
			break;
		}
		if ( BAR i is 32 bit )
			offset += 4;
		else if ( BAR i is 64 bit )
			ofset += 8;
	}
	if (i==DEVICE_COUNT_RESOURCES)
		offset = -1; /* didn't find it */

But I need to be able to figure out how big each BAR is.
Can I do that without going thru all the rigamarole of 
writing all 0xfffff's to the BAR, then reading it back, 
etc?

I didn't see anywhere in struct pci_dev->resource[x] 
where the size of the bar was saved.  It didn't seem 
to be encoded in the flags that I could see...	

drivers/pci/pci.c:read_pci_bases() looks like it tests
to see if BARs are 32 or 64 bit, but does not save this
information in pci_dev->resource[x], except in the fact that
if fills in the topmost 32 bits of addr.

Any ideas?

Another idea is to just catalog the boards and
just "know" which boards have 64 bit BARs and where,
but I'd rather have more general code.

Thanks,

-- steve

