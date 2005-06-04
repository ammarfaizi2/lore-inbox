Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVFDP5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFDP5q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFDP5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:57:46 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:53376
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S261352AbVFDP5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:57:43 -0400
Date: Sat, 4 Jun 2005 17:57:42 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 09:50:13PM -0700, Linus Torvalds wrote:
> Usually the easiest way to match up things is to just do
> 
> 	x/10i pci_setup_bridge+0x1a2
> 
> and match it up with "make drivers/pci/setup-bus.s". 

OK, here's some more info (now visible on an 80x60 FB console):

1) I can see a couple of messages

	PCI: Failed to allocate mem resource #10:2000000@80000000 for 0000:06:09.1
	...

followed by

	PCI: Bus 7, cardbus bridge: 0000:06:09.0
  	IO window: 00005000-00005fff
  	IO window: 00006000-00006fff
  	PREFETCH window: 80000000-81ffffff
  	MEM window: 80000000-81ffffff

, repeated for busses 11 and 15 of the cardbus bridge. This is the
notebook-internal cardbus bridge (see lspci in previous mail).

2) The last messages right before the oops are

  PCI: Bridge 0000:00:1e.0
    IO window 1000-6fff
    MEM window: 01000000-0dffffff

  This is the Southbridge to the notebook-internal PCI bus 0000:06

3) The oops itself occurs when attempting to setup the PREFETCH window of
that bridge and begins
  
  Unable to handle kernel NULL pointer dereference at virtual address 00000004

Specifically, it is located at the call of

    pcibios_resource_to_bus(bridge, &region, bus->resource[2]);

in drivers/pci/setup-bus.c, line 202.  I confirmed that
bus->resource[2] is indeed NULL at that time.

Interestingly, the PCI Express-to-PCI bus in the docking station
appears _not_ to be involved in this crash.

As usual, please let me know what additional info would be useful.

Andreas
