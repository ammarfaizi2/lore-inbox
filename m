Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286482AbRLTX6x>; Thu, 20 Dec 2001 18:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286483AbRLTX6o>; Thu, 20 Dec 2001 18:58:44 -0500
Received: from d-dialin-2966.addcom.de ([213.61.82.86]:40431 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286482AbRLTX6b>; Thu, 20 Dec 2001 18:58:31 -0500
Date: Fri, 21 Dec 2001 00:58:37 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Pavel Machek <pavel@suse.cz>
cc: Cory Bell <cory.bell@usa.net>, <linux-kernel@vger.kernel.org>,
        John Clemens <john@deater.net>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
In-Reply-To: <20011220234055.A133@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0112210042440.2101-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, Pavel Machek wrote:

> > Cruel hack to route every link to irq 11 (may of course lock up your box)
> > 
> > setpci -s 7.0 49.b=99
> 
> Huh, this did the trick! Interrupts now arrive correctly to the
> soundcard. Recording is still broken, but that's probably separate
> problem. (I did not even need those two other setpci's ;-)

setpci -s 7.0 49.b=09 should do the trick as well, right?

Well, let me extend your dump_pirq with info from your ACPI DSDT (lines 
starting with ==):

Device 00:0f.0 (slot 0):

Device 00:02.0 (slot 0):
  INTA: link 0x59, irq mask 0x0800
==      LNKU

Device 00:08.0 (slot 1):
  INTA: link 0x49, irq mask 0x0020
==	LNKC

Device 00:04.0 (slot 0):
  INTA: link 0x48, irq mask 0x0800
==      LNKA
  INTB: link 0x48, irq mask 0x0800
==      LNKB

Device 00:10.0 (slot 0):
  INTA: link 0x48, irq mask 0x0800
==      LNKB

Device 00:07.0 (slot 0):
  INTA: link 0x48, irq mask 0xdef8
  INTB: link 0x48, irq mask 0xdef8
  INTC: link 0x49, irq mask 0xdef8
  INTD: link 0x49, irq mask 0xdef8
== no ACPI info here

Device 00:01.0 (slot 0):
  INTA: link 0x48, irq mask 0x0800
== no ACPI info here

Device 01:00.0 (slot 0):
  INTA: link 0x48, irq mask 0x0800
==      LNKA

Interrupt router at 00:07.0: AcerLabs Aladdin M1533 PCI-to-ISA bridge
  INT1 (link 1): irq 11
  INT2 (link 2): irq 11
  INT3 (link 3): unrouted
  INT4 (link 4): unrouted
  INT5 (link 5): unrouted
  INT6 (link 6): unrouted
  INT7 (link 7): unrouted
  INT8 (link 8): unrouted
  Serial IRQ: [enabled] [continuous] [frame=21] [pulse=12]

==  LNKA IPRS (0x48) 0x0298 [3,4,7,9]
==  LNKB IPRS (0x48) 0x0298 [3,4,7,9]
==  LNKC IPRC (0x49) 0x0280 [7,9]
==  LNKD IPRS (0x49) 0x0298 [3,4,7,9]
==  LNKU IPRU (0x74) 0x0020 [5] 

Your PIRQ table is hopelessly broken. The kernel code expects the "link
0x.." field to contain numbers between 0 to 7, corresponding to INT1 to
INT8. Your link field seems to contain the config space offset instead,
but that's fundamentally broken, since one config space byte determines 
the routing for two links, thus it's not possible to figure out which one 
is meant. 

Also, USB uses a special link which won't work with the current kernel 
code at all. The possible IRQ masks are quite different between the PIRQ 
table and the ACPI table. (And your BIOS seems to have set the USB 
controller to IRQ 11, (USB->LNKU->IRQ11), which isn't even allowed 
according to the IRQ mask).

So, there's basically no chance to get the IRQ routing code working 
correctly with your PIRQ table. However, using the ACPI provided info 
should work fine as far as I can see. Did you try the latest ACPI snapshot 
+ my ACPI IRQ routing patch? It'd be interesting to see what that gives.
(it may even work ;-)

--Kai





