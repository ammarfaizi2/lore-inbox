Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWIJAJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWIJAJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 20:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWIJAJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 20:09:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32707 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965039AbWIJAJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 20:09:20 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru, liste@jordet.net
In-Reply-To: <45033370.8040005@gentoo.org>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 01:31:12 +0100
Message-Id: <1157848272.6877.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-09 am 17:34 -0400, ysgrifennodd Daniel Drake:
> Devices on the PCI bus need to be quirked (in some circumstances), as 
> when they are on the PCI bus they use the IRQ line for routing, and the 
> IRQ line is what the quirk actually modifies.
> 
> V-bus devices do not need the quirk because IRQ routing there is handled 
> by IRQ number alone.
> 
> Is the above correct?

I've no idea. The data sheets imply not.

> I did some searching and couldn't find anything out about the V-bus, I 
> assume that is some VIA-specific thing.

Earlier VIA chipsets use PCI to link internal devices and the bridges as
is normal for older systems. Later systems use a private internal bus
for this (as intel does with GCH), but which looks like PCI

And then you have external PCI devices on plug in cards.

All the PCI cases should be the same, IRQ routing by IRQ line/pin
A/B/C/D. 

VIA have always told me that "ACPI handles this" and we don't need
quirks. Various chips have different IRQ routing logic and it's all a
bit weird if we don't use ACPI and/or BIOS routing.

Anyway its supposed to work like this if you want to try and unpick the
failing cases and work out how to fix them sanely:

MVP4 and 82C686*
	IDE IRQ is 0x4A bits 3/2 (sec ide) and (1/0) (pri ide)
	00 - 14 01 - 15 10 - 10 11 - 11

	0x51 bits 7-4 are parport irq
	0x51 bits 3-0 are floppy irq
	0x52 bits 7-4 are ser2 irq
	0x53 bits 3-0 are ser1 irq
	0x55 bits 7-4 route PIRQA
	0x56 bits 7-4 route PIRQC
	0x56 bits 0-3 route PIRQB
	0x57 bits 7-4 route PIRQD

	0-15 = irq num but 0 = off 2, 8 and 13 are not allowed

82C686 adds
	0x58 bit 0 - USB port 0 IRQ to APIC
	     bit 1 - USB port 1 IRQ to APIC
	     bit 2 - AC97 IRQ to APIC
	     bit 3 - MC97 IRQ to APIC (thats the modem)
	     bit 4 - ACPI IRQ to APIC


Each chip gets more complex so you can see why quirks and PCI IRQ
re-routing games will get quite horrible quite fast.

By the 8233  (just to cause pain btw some 8233's have a 3com built in
network...)

0x4D has become APIC control instead of 0x58 and adds
	bit 6  USB port 4/5
	bit 5 LAN
while 0x51-0x53 vanish but 55-57 are the same (ie it becomes a bit more
sane). Things like the USB IRQ pin are still hardwired (R/O).

The 8235 has some strange IRQ routing logic of its own. The APIC and
system now deals with 24 IRQs with an allegedly fixed routing of INTA ->
16 INTB -17 INTC -18 INTD -19 IDE -20 USB1 21, USB 2 21 or 23
[selectable], AC97/MC97 - 22

55-57 remain the same but the 0x4D register vanishes although it appears
to be a docs error and bit 7 is added for IDE. virtual PCI devices end
up at IRQ 16-23 using the low 3 bits of the IRQ line value if the line
is switched to APIC. The docs self conflict here on whether you can only
use IRQ 20 for IDE etc

One way you can often identify the onboard devices btw is that writes to
interrupt pin have no effect (ie PIN is fixed) and on older chips writes
to irq number are masked by 0x0F. Also IRQ 2 and 15 (or 0x?F if you dont
notice the masking) are not permitted generally but can be written.




