Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267972AbTBXFaM>; Mon, 24 Feb 2003 00:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267973AbTBXFaM>; Mon, 24 Feb 2003 00:30:12 -0500
Received: from mail.somanetworks.com ([216.126.67.42]:27050 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S267972AbTBXFaL>; Mon, 24 Feb 2003 00:30:11 -0500
Date: Mon, 24 Feb 2003 00:40:19 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
In-Reply-To: <Pine.LNX.4.44.0302231654370.1690-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302232046490.2559-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, Linus Torvalds wrote:

> 
> On Sun, 23 Feb 2003, Russell King wrote:
> > 
> > However, whether x86 PCs will survive bus renumbering or not remains to
> > be seen.  We currently try to leave as much of the configuration intact
> > from the BIOS.
> 
> Note that I made cardbus bus numbering _ignore_ the BIOS-setup numbering 
> even on PC's, exactly because of issues like this - trying to keep the 
> original BIOS numbering just won't work if the BIOS sets the wrong numbers 
> (I saw a BIOS that had happily assigned the _same_ PCI bus number to both 
> cardbus functions, whee).
> 
> I think we can (and should) make all hotpluggable PCI bridges use that 
> same cardbus logic.

If you mean the "max +=3" CardBus stuff in pci_scan_bridge, I can't see 
anything that simple working on a lot of the CompactPCI hardware I've 
seen, which tends to have multiple on-board bridges (Serverworks chipset 
boards especially).  Reserving bus numbers would therefore mean doing a 
subsequent renumbering of the other bus(es).  I think even your CardBus 
workaround would suffer in the case of a laptop which for some reason had 
another bridge (e.g. we might soon see laptops with both CardBus and 
Newcard bridges).

One approach that might work well for the CardBus situation, and might 
suffice for now for cPCI, might be to assign the hotplug bridge's 
subordinate bus and its children bus numbers starting at the maximum busnr 
+ 1 after the initial pci_scan_bus has been done.  If there is more than
one hotplug bridge, each gets an equal share of the remaining bus numbers.
On a cPCI system that has several cards with their own bridges, such a
scheme is potentially wasteful of bus numbers, but at least the 
renumbering would be contained to buses that should be able to handle it.  
For cPCI, some form of DMI-based system would also be required to identify 
the hotplug bridges, but I've been considering such a beast for resource 
reservation anyways.

> The real problematic case I see is if there are transparent hotplug
> bridges, with some devices just magically appear and disappear from a part 
> of a bus because of some invisible bridge. I don't know if such things 
> exist or even _can_ exist, but the perverse nature of PC hardware makes me 
> suspect they do.

All of the cPCI bus extenders that I've googled so far seem to use  
relatively normal bridges, so I'm thinking (also hoping) that the scenario 
you describe is not possible.  It does seem feasible, however, that one 
could build a pretty deep bus hierarchy in a 21-slot cPCI chassis, which 
could pose a sizing problem for automatic reservation schemes.  Here's 
hoping no one crawls out of the woodwork after 2.6.0 with either beast...

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


