Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbTGHBZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 21:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbTGHBZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 21:25:56 -0400
Received: from mithril.c-zone.net ([63.172.74.235]:18189 "EHLO mail.c-zone.net")
	by vger.kernel.org with ESMTP id S265948AbTGHBZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 21:25:54 -0400
Message-ID: <3F0A2129.5070705@c-zone.net>
Date: Mon, 07 Jul 2003 18:40:57 -0700
From: jiho@c-zone.net
Organization: Kidding of Course
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE driver:  CBLID revisited
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw a thread about CBLID detection from earlier this year, and have 
encountered an issue with this.

The complexity of this situation can only be exceeded by the likely 
narrowness of its application, so bear with me.

I have an old Maxtor 91360U4.  This is a 13.6 BB, UDMA-66 drive that was 
made August 27, 1999.  For a few years I ran this as a UDMA-33 drive 
connected with a 40-wire cable to a VIA 82C586B South Bridge.  It was 
very happy there, except for a few "lost interrupt" incidents due to 
cable overheating caused by an even older Micropolis SCSI drive. 
(Anyway, I *believe* that's what it was.)

Now comes a new motherboard with a VIA 8235 South Bridge, which is 
UDMA-133 capable.  I install the Maxtor 91360U4 with an 80-wire cable. 
There are two OSes on it, Linux 2.4.17 and NetBSD 1.5.1.  When I boot 
NetBSD 1.5.1, it quickly encounters CRC errors during read operations, 
and ratchets down the mode; so I shut it down, at which point it 
vaporizes itself by trashing the file system metadata during write 
operations.

Linux 2.4.17 fares better.  Failing to recognize the 8235 chip, it 
leaves things alone, apparently, and seems to run OK.  I've forgotten 
what mode it winds up using.

2.4.20 recognizes the chip, but ratchets down the mode during kernel 
autoconfiguration.  I think it winds up using DMA mode 0.  It operates 
safely but slowly.

It emerges that the drive implements IDENTIFY DEVICE word 93 oddly. 
Bits 15-14 are correct (01b), but bit 13 is exactly upside down (0 with 
an 80-wire cable, 1 with a 40-wire cable).

The 8235, meanwhile, does have bits in a register that indicate BIOS 
detection of cable types (from each CBLID wire connected to a GPIO pin, 
apparently).

Since I'm running the IDE driver with VIA chipset support built-in, the 
driver enforces UDMA-66 with a 40-wire cable and UDMA-33 with an 80-wire 
cable.  This is because the VIA chipset test for UDMA-66 -- in function 
pci_init_via82cxxx() -- ignores the cable type bit, but looks at the 
timing bits.  But the timing bits are the same for UDMA-33 and UDMA-66. 
  Meanwhile, the drive test finds the upside down cable type bit from 
IDENTIFY DEVICE word 93.

I succeeded in hacking 2.4.20 so it gets this right, by #ifdef'ing out a 
couple of checks on IDENTIFY DEVICE word 93, and forcing the test in 
pci_init_via82cxxx() to depend on the chipset cable type bit.  The drive 
now runs at UDMA-66, and seems to coexist fine as slave to a Maxtor 
6Y080P0, an 80 BB UDMA-133 drive running in UDMA-133 mode (the drive I'm 
on as we speak).

Before rushing forward with a patch, however....

With this motherboard, I'm not sure I really need the VIA chipset 
support in the IDE driver anyway.  Without it (or maybe even with it), I 
could use the 'ideX=ata66' and 'ideX=dma' parameters.  Or could I?!?

But even so, that wouldn't necessarily address the situation for someone 
else with this drive, who has a VIA chipset somewhere between the 586B 
and 8235 and maybe a BIOS that doesn't initialize the best mode properly.

I was told by VIA that the cable type reporting bits are there "since" 
the first 8233 chip (device ID 0x3074).

Aside from that, I gotta say, the IDE driver really has gotten kind of 
large and complicated, probably from trying to deal with a zillion 
different oddball situations, much like this one.

Comments?  Questions?  Discussion?


-- Jim Howard  <jiho@c-zone.net>

