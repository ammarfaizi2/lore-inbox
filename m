Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTKZByX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 20:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTKZByX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 20:54:23 -0500
Received: from palrel11.hp.com ([156.153.255.246]:31947 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263871AbTKZByS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 20:54:18 -0500
Date: Tue, 25 Nov 2003 17:54:16 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, David Hinds <dahinds@users.sourceforge.net>,
       linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031126015416.GA14745@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031125004942.GA3002@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241804560.1599@home.osdl.org> <20031125023319.GA3819@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241845200.1599@home.osdl.org> <Pine.LNX.4.58.0311241851480.1599@home.osdl.org> <20031125031156.GA4243@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241919220.1599@home.osdl.org> <20031125034815.GC4483@bougret.hpl.hp.com> <Pine.LNX.4.58.0311242028220.1599@home.osdl.org> <Pine.LNX.4.58.0311242100540.1599@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311242100540.1599@home.osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 09:17:21PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 24 Nov 2003, Linus Torvalds wrote:
> >
> > That "Bus 0 IRQ 44" should actually be it: that decodes to bus 0, slot 17,
> > pin 0. Exactly what we want.
> 
> Never mind. We didn't want 17, we wanted 19. 17 was the USB thing.
> 
> Slot 18 was Ethernet, and slot 19 was your cardbus bridge.
> 
> However, you said that it still didn't work when you switched the ethernet
> and cardbus cards around, which actually makes me suspect that slot 19 got
> dynamically turned into _this_ entry by the BIOS:
> 
> > Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 12

	Wrong, this is my AGP Matrox card.
	The correct answer is that it's nowhere to be found in the
APIC table.

> ie it has noticed that slot 19 contains a PCI->CardBus bridge, and thus
> instead of calling it "bus 0, irq 4c" (which would be slot 19 on bus 0),
> it has the IRQ translation as "bus 1, irq 0" (which is "slot 0 on bus 1").
> 
> And indeed, we won't find that for the PCI->Cardbus bridge chip. But it
> kind of makes sense, because the device _behind_ the bridge (which will
> have the same irq) will indeed be "slot 0 on bus 1").

	Nope, Bus 1 is the AGP. Bus 2 is a PCI multifunction
card. Carbus cards appear on Bus 3, but I don't think any of the info
from Bus 3 is very useful.

> Just for fun, could you switch the ethernet/cardbus cards around again,
> and see if that "bus 1" line moves up one (current slot 18 aka "irq 48"),
> and the one that is now "bus 1"  ends up being "bus 0, IRQ 4C" (ie slot 19
> which now would have the ethernet card instead of a PCI bridge).

	I did that, "bus 1" remained the same and the Ethernet was
moved from irq 48 to irq 4C.

> Ingo, any ideas on how to handle this sanely?
> 
> Jean - you could just _force_ the match, by special-casing it, and seeing
> it it works. We actaully already try the _other_ way in
> 
> 	arch/i386/pci/irq.c: pcibios_fixup_irqs()
> 
> if we don't find a translation, we try to find a translation through the
> _parent_ infromation, but we never think to ask "oh, if we are a bridge,
> maybe we should ask the child".

	I tried that. But, the list of childs is empty. Well, I guess
that when next point to the list head, it's empty ;-)
	Note that I tried that without any CardBus device in the
slot. Maybe if there was a CardBus card in it, we may get one
child. But, I don't want to depend on that.

> 			Linus

	The fix is simple. We just need a "manual override". It's
basically impossible for the kernel to find the right answer without
some outside help. This was the conclusion that David Hinds reached
with the Pcmcia package (see Pcmcia Howto 5.2).
	The patch below just does that. I tried this patch with a 16
bits Pcmcia card (ISA irq) and a 32 bits Carbus card (PCI irq), and
both work fine (I just need the magic sequence "manual_pci_irq=0,19,17").
	You may no like this kind of ugly patch, but it brings feature
parity with respect to the old Pcmcia package.

	Anyway, thanks greatly for the help, you lead me in the right
direction and I now have a workable solution.

	Have fun...

	Jean

-------------------------------------------------------------

diff -u -p linux/arch/i386/pci/irq.j1.c linux/arch/i386/pci/irq.c
--- linux/arch/i386/pci/irq.j1.c	Tue Nov 25 10:36:45 2003
+++ linux/arch/i386/pci/irq.c	Tue Nov 25 17:35:44 2003
@@ -693,6 +693,43 @@ static int pcibios_lookup_irq(struct pci
 	return 1;
 }
 
+#define MAX_MIRQS 4
+int manual_irq_entries[MAX_MIRQS][3];		/* bus/slot/irq */
+int manual_irqs_enabled;	/* = 0 */
+
+static int __init manual_irq_setup(char *str)
+{
+	int i, max;
+	int ints[(MAX_MIRQS*3)+1];
+
+	get_options(str, ARRAY_SIZE(ints), ints);
+
+	for (i = 0; i < MAX_MIRQS; i++)
+		manual_irq_entries[i][0] = -1;
+
+	manual_irqs_enabled = 1;
+
+	max = MAX_MIRQS * 3;
+	if (ints[0] < max)
+		max = ints[0];
+	max = max / 3;
+
+	for (i = 0; i < max; i++) {
+		/* Fill our mapping table */
+		manual_irq_entries[i][0] = ints[(3*i) + 1];
+		manual_irq_entries[i][1] = ints[(3*i) + 2];
+		manual_irq_entries[i][2] = ints[(3*i) + 3];
+
+		printk(KERN_DEBUG "Manual PCI %d:%d -> IRQ %d\n",
+		       manual_irq_entries[i][0],
+		       manual_irq_entries[i][1],
+		       manual_irq_entries[i][2]);
+	}
+	return 1;
+}
+
+__setup("manual_pci_irq=", manual_irq_setup);
+
 static void __init pcibios_fixup_irqs(void)
 {
 	struct pci_dev *dev = NULL;
@@ -757,6 +794,30 @@ static void __init pcibios_fixup_irqs(vo
 		 */
 		if (pin && !dev->irq)
 			pcibios_lookup_irq(dev, 0);
+
+		/*
+		 * Manual fixups. Use at your own risks. Jean II
+		 * This assume that the PCI IRQ routing is done right,
+		 * and it's just the BIOS that ignore the card. If you
+		 * need to also fixup the PCI IRQ routing, you will
+		 * probably need to use the "pirq=" option.
+		 * I use this hack to get a PCI-CardBus add-on adapter
+		 * to be recognised on my destktop.
+		 * Jean II
+		 */
+		if (manual_irqs_enabled) {
+			int i;
+			for(i = 0; i < MAX_MIRQS; i++)
+				if ((dev->bus->number ==
+				     manual_irq_entries[i][0])
+				    && (PCI_SLOT(dev->devfn) ==
+					manual_irq_entries[i][1])) {
+					printk(KERN_INFO "PCI->APIC IRQ manual fixup: (B%d,I%d) -> %d\n",
+						dev->bus->number, PCI_SLOT(dev->devfn), manual_irq_entries[i][2]);
+					dev->irq = manual_irq_entries[i][2];
+					pci_write_config_byte(dev, PCI_INTERRUPT_LINE, manual_irq_entries[i][2]);
+				}
+		}
 	}
 }
 

