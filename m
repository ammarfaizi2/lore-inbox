Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268072AbRGVVx6>; Sun, 22 Jul 2001 17:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268073AbRGVVxs>; Sun, 22 Jul 2001 17:53:48 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:32924 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S268072AbRGVVxg>;
	Sun, 22 Jul 2001 17:53:36 -0400
Message-ID: <3B5B4B64.712A7955@candelatech.com>
Date: Sun, 22 Jul 2001 14:53:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG REPORT]  Sony VAIO, 2.4.7:  CardBus failures with Tulip & 3c575 
 cards.
In-Reply-To: <200107222059.f6MKx2212465@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

dump_pirq ouput is found below.

Linus Torvalds wrote:
> 
> In article <3B5B1F77.D8B45FFA@candelatech.com> you write:
> >
> >This report contains information about my failure to get my
> >CardBus NICs working correctly.  Hardware involved is:
> >
> >Sony VAIO PCG-FX210 laptop (800Mhz Duron...)
> >DFE-650 16-bit PCMCIA NIC x2
> >3Com Megahertz 32-bit 3CCFE575BT NIC x2
> >AmbiCom 32-bit 8100 NIC  (tulip) x2
> 
> This looks suspiciously like your slot #1 gets the PCI interrupt routing
> wrong.
> 
> Note especially the kernel reports:
> 
>         Linux Kernel Card Services 3.1.22
>           options:  [pci] [cardbus] [pm]
>         PCI: Assigned IRQ 9 for device 00:0a.0
>         PCI: Assigned IRQ 10 for device 00:0a.1
>         IRQ routing conflict for 00:07.5, have irq 5, want irq 10
>         IRQ routing conflict for 00:07.6, have irq 5, want irq 10
>         PCI: Sharing IRQ 10 with 00:10.0
> 
> it really looks like your slot 1 controller (00:0a.1) really wants irq5,
> based on the fact that other devices are reported to have irq5.
> 
> However, if they _really_ have irq5 already routed, I'm surprised that
> the PCI irq router "r->get()" function didn't pick up on that fact, and
> that the "set" function apparently didn't work correctly.
> 
> So I'd guess that when you insert a card in slot #1, you get a constant
> stream of interrupts on irq5, which is not where the kernel is expecting
> them, so your machine locks up.
> 
> Can you do the following:
>  - run dump_pirq on your machine (attached)

Ok, I found a dump_pirq script on the web, maybe it does what
you want:


Interrupt routing table found at address 0xfdf60:
  Version 1.0, size 0x0080
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x1106 device 0x0596

Device 00:07.0 (slot 0): ISA bridge
  INTA: link 0x55, irq mask 0x9eb8 [3,4,5,7,9,10,11,12,15]
  INTB: link 0x56, irq mask 0x9eb8 [3,4,5,7,9,10,11,12,15]
  INTC: link 0x56, irq mask 0x9cb8 [3,4,5,7,10,11,12,15]
  INTD: link 0x57, irq mask 0x06a0 [5,7,9,10]

Device 00:00.0 (slot 0): Host bridge
  INTA: link 0x55, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTB: link 0x56, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTC: link 0x56, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTD: link 0x57, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x56, irq mask 0x0020 [5]

Device 00:0a.0 (slot 0): CardBus bridge
  INTA: link 0x55, irq mask 0x0020 [5]
  INTB: link 0x56, irq mask 0x0020 [5]

Device 00:10.0 (slot 0): Ethernet controller
  INTA: link 0x56, irq mask 0x0400 [10]

Device 00:0e.0 (slot 0): FireWire (IEEE 1394)
  INTA: link 0x57, irq mask 0x0200 [9]

Interrupt router at 00:07.0: VIA 82C686 PCI-to-ISA bridge
  PIRQA (link 0x01): irq 9
  PIRQB (link 0x02): irq 10
  PIRQC (link 0x03): irq 5
  PIRQD (link 0x05): irq 9


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
