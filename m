Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145338AbRA2GIi>; Mon, 29 Jan 2001 01:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145323AbRA2GI3>; Mon, 29 Jan 2001 01:08:29 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:47879 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S145322AbRA2GIX>; Mon, 29 Jan 2001 01:08:23 -0500
To: torvalds@transmeta.com
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <Pine.LNX.4.10.10101282050180.5079-100000@penguin.transmeta.com>
In-Reply-To: <20010129052950H.siemer@panorama.hadiko.de>
	<Pine.LNX.4.10.10101282050180.5079-100000@penguin.transmeta.com>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010129070810S.siemer@panorama.hadiko.de>
Date: Mon, 29 Jan 2001 07:08:10 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@transmeta.com>
> On Mon, 29 Jan 2001, Robert Siemer wrote:

> (...) that's really interesting..
> 
> > Device 00:01.0 (slot 0): ISA bridge
> >   INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
> >   INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
> >   INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
> >   INTD: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
> 
> Your "link" values are in the range 1-4. Which makes perfect sense, but
> that's absolutely _not_ what the Linux SiS routing code expects (the code 
> seems to expect them to be ASCII 'A' - 'D').
> 
> It looks very much like "pirq_sis_get()" and "pirq_sis_set()" in
> arch/i386/kernel/pci-irq.c are broken for your setup.
> 
> Can you replace them with the following:
> 
> 	static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
> 	{
> 		if (pirq <= 4) {
> 			u8 x;
> 			pci_read_config_byte(router, 0x40+pirq, &x);
> 			return (x & 0x80) ? 0 : (x & 0xf);
> 		}
> 		printk("Unknown SiS pirq value %d\n", pirq);
> 		return 0;
> 	}
> 
> and
> 
> 	static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
> 	{
> 		if (pirq <= 4) {
> 			pci_write_config_byte(router, 0x40 + pirq, irq);
> 			return 1;
> 		}
> 		printk("Unknown SiS pirq value %d\n", pirq);
> 		return 0;
> 	}
> 
> and see if that changes the behaviour. 

It doesn't.   A diff from the kernel output is following. Maybe it
helps...

Thanks,
	Robert


--- dmesg.2.4.0.debug	Sun Jan 28 21:09:46 2001
+++ dmesg.2.4.0	Mon Jan 29 06:25:53 2001
@@ -1,4 +1,4 @@
-Linux version 2.4.0 (root@panorama.hadiko.de) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #4 Sun Jan 28 19:03:05 CET 2001
+Linux version 2.4.0 (root@panorama.hadiko.de) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #5 Mon Jan 29 06:19:16 CET 2001
 BIOS-provided physical RAM map:
  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
@@ -231,8 +231,9 @@
 bttv: using 2 buffers with 2080k (4160k total) for capture
 BT848 and your chipset may not work together.
 bttv: Bt8xx card found (0).
-IRQ for 00:09.0:0 -> PIRQ 04, mask 1eb8, excl 0000 -> newirq=11 -> got IRQ 7
-IRQ routing conflict in pirq table! Try 'pci=autoirq'
+IRQ for 00:09.0:0 -> PIRQ 04, mask 1eb8, excl 0000 -> newirq=11 -> got IRQ 11
+PCI: Found IRQ 11 for device 00:09.0
+PCI: The same IRQ used for device 00:09.1
 bttv0: Bt878 (rev 2) at 00:09.0, irq: 11, latency: 32, memory: 0xe7800000
 bttv0: subsystem: 0070:13eb  =>  Hauppauge WinTV  =>  card=10
 bttv0: model: BT878(Hauppauge new (bt878)) [autodetected]
@@ -278,8 +279,8 @@
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 SIS5513: IDE controller on PCI bus 00 dev 09
 PCI: Enabling device 00:01.1 (0000 -> 0001)
-IRQ for 00:01.1:0 -> PIRQ 01, mask 1eb8, excl 0000 -> newirq=12 -> assigning IRQ 12 ... OK
-PCI: Assigned IRQ 12 for device 00:01.1
+IRQ for 00:01.1:0 -> PIRQ 01, mask 1eb8, excl 0000 -> newirq=12 -> got IRQ 12
+PCI: Found IRQ 12 for device 00:01.1
 PCI: The same IRQ used for device 00:01.2
 PCI: The same IRQ used for device 00:0c.0
 SIS5513: chipset revision 208
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
