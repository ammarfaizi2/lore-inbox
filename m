Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVBTCJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVBTCJt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 21:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVBTCJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 21:09:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:12462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261238AbVBTCJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 21:09:46 -0500
Date: Sat, 19 Feb 2005 18:10:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
 interrupts. Fish. Please report.]
In-Reply-To: <1108863372.8413.158.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0502191757170.14706@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
 <1108863372.8413.158.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Feb 2005, Steven Rostedt wrote:
> 
> Here's the scoop:
> 
> cat /proc/iomem:

Ok. This one does not show device 00:1e.0 _at_all_. It had:

	I/O behind bridge: 00003000-00006fff
	Memory behind bridge: c2000000-cfffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff

and it just doesn't show. It shows some of the devices that are behind 
that bridge, though, and it should PCI Bus #01. Why not #02? Looks like we 
must have decided that that PCI bus is transparent.

But we have the PCI device hierarchy right:

> /sys/devices/pci0000:00/0000:00:1e.0/0000:02:00.0:
> /sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.0:
> /sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.1:
> /sys/devices/pci0000:00/0000:00:1e.0/0000:02:02.0:

Oh, and your dmesg does show:

	PCI: Transparent bridge - 0000:00:1e.0

so that explains it. We believe that 0:1e.0 is transparent. 

Maybe we're even right. We do have a few quirky bridges that are marked 
transparent. I didn't think yours was one of them, though.

I _think_ it's the code in arch/i386/pci/fixup.c that does this. See the

	static void __devinit pci_fixup_transparent_bridge(struct pci_dev *dev)

thing, and try to disable it. Maybe that rule is wrong, and triggers much 
too often?

Or maybe it really _is_ a transparent bridge after all, and the problem is 
somewhere else. Disabling the pci_fixup_transparent_bridge logic is a good 
thing to try first, though.

		Linus
