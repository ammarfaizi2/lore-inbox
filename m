Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129698AbQKQRFw>; Fri, 17 Nov 2000 12:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130256AbQKQRFh>; Fri, 17 Nov 2000 12:05:37 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:9726 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S130194AbQKQRFZ>;
	Fri, 17 Nov 2000 12:05:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10011170814440.2272-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.10.10011170814440.2272-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Hinds <dhinds@valinux.com>, tytso@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Nov 2000 16:34:41 +0000
Message-ID: <5178.974478881@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  If somebody still has a problem with the in-kernel stuff, speak up. 

I have an i82092AA evaluation board:

00:06.0 PCMCIA bridge: Intel Corporation 82092AA_0 (rev 02)
	Flags: slow devsel, IRQ 27
	I/O ports at 8400 [size=4]

I have three problems:

1. I have to specify the i365_base parameter when loading i82365,o 

2. Even when I specify cs_irq=27, it resorts to polling:

	Intel PCIC probe: 
	  Intel i82365sl DF ISA-to-PCMCIA at port 0x8400 ofs 0x00, 2 sockets
	    host opts [0]: none
	    host opts [1]: none
	    ISA irqs (default) = none! polling interval = 1000 ms
	  Intel i82365sl DF ISA-to-PCMCIA at port 0x8400 ofs 0x80, 2 sockets
	    host opts [2]: none
	    host opts [3]: none
	    ISA irqs (default) = none! polling interval = 1000 ms

3. Note that it finds no IRQs available for the cards' IREQ to use. This is
	on an Alpha SX164. 

I'll fix it over the weekend - basically it just looks like a little too 
much was stripped out of i82365.c when we started handling CardBus bridges 
elsewhere. We ought to still handle PCI->PCMCIA bridges which aren't 
CardBus-capable.


As a separate issue, the IDE on the same chip appears to be confusing the
kernel. I seem to end up with the generic IDE driver driving the on-board
CY82C693, which means I can't do DMA. That may be SRM's fault, though.


00:06.1 IDE interface: Intel Corporation 82092AA_1 (rev 02) (prog-if 00 [])
	Flags: slow devsel, IRQ 31
	I/O ports at 1090 [size=8]
	I/O ports at 1098
	I/O ports at 10a0 [size=8]
	I/O ports at 10a8 [size=8]

00:08.1 IDE interface: Contaq Microsystems 82c693 (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 0
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4
	I/O ports at 1080 [size=16]

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device 31, VID=8086, DID=1222
PCI_IDE: chipset revision 2
PCI_IDE: not 100% native mode: will probe irqs later
CY82C693: IDE controller on PCI bus 00 dev 41
CY82C693: chipset revision 0
CY82C693: not 100% native mode: will probe irqs later
CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)
CY82C693: port 0x01f0 already claimed by ide0
CY82C693: port 0x0170 already claimed by ide1
CY82C693: neither IDE port enabled (BIOS)



--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
