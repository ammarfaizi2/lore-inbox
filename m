Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143808AbRA2E7X>; Sun, 28 Jan 2001 23:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144144AbRA2E7O>; Sun, 28 Jan 2001 23:59:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17938 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S143808AbRA2E7E>; Sun, 28 Jan 2001 23:59:04 -0500
Date: Sun, 28 Jan 2001 20:58:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Siemer <siemer@panorama.hadiko.de>
cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0
In-Reply-To: <20010129052950H.siemer@panorama.hadiko.de>
Message-ID: <Pine.LNX.4.10.10101282050180.5079-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jan 2001, Robert Siemer wrote:
> From: Linus Torvalds <torvalds@transmeta.com>
> 
> > Another one..
> 
> > Robert, can you get the dump_pirq script from the pcmcia_cs package
> > and send the output to us?
> 
> ...it seems to reflect my settings in the bios:

No, but that's really interesting..

> Device 00:01.0 (slot 0): ISA bridge
>   INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
>   INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
>   INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
>   INTD: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Your "link" values are in the range 1-4. Which makes perfect sense, but
that's absolutely _not_ what the Linux SiS routing code expects (the code 
seems to expect them to be ASCII 'A' - 'D').

It looks very much like "pirq_sis_get()" and "pirq_sis_set()" in
arch/i386/kernel/pci-irq.c are broken for your setup.

Can you replace them with the following:

	static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
	{
		if (pirq <= 4) {
			u8 x;
			pci_read_config_byte(router, 0x40+pirq, &x);
			return (x & 0x80) ? 0 : (x & 0xf);
		}
		printk("Unknown SiS pirq value %d\n", pirq);
		return 0;
	}

and

	static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
	{
		if (pirq <= 4) {
			pci_write_config_byte(router, 0x40 + pirq, irq);
			return 1;
		}
		printk("Unknown SiS pirq value %d\n", pirq);
		return 0;
	}

and see if that changes the behaviour. 

Anybody else with SiS chipsets that want to try the above? Please..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
