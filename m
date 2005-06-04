Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFDAV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFDAV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFDAV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:21:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:24809 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbVFDAVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:21:09 -0400
Date: Fri, 3 Jun 2005 17:22:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
In-Reply-To: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de>
Message-ID: <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Jun 2005, Andreas Koch wrote:
> 
> While all of the USB and FireWire devices are visible using config
> space reads, they cannot be accessed correctly (all normal reads
> appear to return 0xff).  After checking the dmesg logs, I find
> 
> 	PCI: Cannot allocate resource region 7 of bridge 0000:02:00.0
> 	PCI: Cannot allocate resource region 8 of bridge 0000:02:00.0

Well, that would be right, because the parent of that bridge doesn't seem 
to have any resources set up:

	0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 04) (prog-if 00 [Normal decode])
	  Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 0, cache line size 08
	  Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
	  I/O behind bridge: 00000000-00000fff
	  Memory behind bridge: 00000000-000fffff
	  Prefetchable memory behind bridge: 0000000000000000-0000000000000000

the "IO/memory behind bridge" things don't seem to be making a lot of 
sense.

Hmm. Normally on PC's we let the BIOS worry about PCI bridge resource
setup. The hotplug code knows about the setup-bus stuff too, but the
_normal_ PCI bus resouces are usually left alone. It looks like maybe we
shouldn't do that any more for PCI Express.

Hmm.. Just a wild guess (and this may not work at _all_, so who knows..): 
how about adding a

	pci_assign_unassigned_resources();

call to the end of "pcibios_init()" in arch/i386/pci/common.c ?

NOTE! In order for that to even link, you need to make sure that you have 
CONFIG_HOTPLUG enabled, otherwise x86 won't have even linked in the bus 
resource code from drivers/pci/setup-bus.c. And even so, I won't guarantee 
that it does anything sane...

(I'm really surprised that we've gone this long without havign x86 do the 
bus setup, though. So I'd not be in the least surprised if we need 
_something_ like this, I'm just not at all sure that just adding that 
single line won't do something disastrously bad..)

		Linus
