Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTCCMFS>; Mon, 3 Mar 2003 07:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbTCCMFS>; Mon, 3 Mar 2003 07:05:18 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:36105 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264711AbTCCMFR>; Mon, 3 Mar 2003 07:05:17 -0500
Date: Mon, 3 Mar 2003 15:14:12 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: jamal <hadi@cyberus.ca>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, kuznet@ms2.inr.ac.ru,
       david.knierim@tekelec.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       Donald Becker <becker@scyld.com>, linux-kernel@vger.kernel.org,
       alexander@netintact.se
Subject: Re: PCI init issues
Message-ID: <20030303151412.A15195@jurassic.park.msu.ru>
References: <20030302121050.F61365@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030302121050.F61365@shell.cyberus.ca>; from hadi@cyberus.ca on Sun, Mar 02, 2003 at 12:44:06PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 12:44:06PM -0500, jamal wrote:
> Interupt routing as can be seen above is really messed for that device.

Indeed. Quad tulip cards usually have irq pin A of each chip routed
to pins A-D on the connector, so they cannot have the same irq unless
all four irq pins are shared in the parent slot, which is unlikely in
this case.

> Q1: How do we resolve this other than moving around boards?

Here's [completely untested] patch that attempts to validate BIOS irq
assignments. This may break "good" irqs for other devices, but it's
interesting to see if it changes something.

> Q2: Should we really be dependent on bios this bad?

We certainly shouldn't wrt PCI IO and MMIO allocations, but irq routing
appears to be so horribly overcomplexed on x86 that dependence on
BIOS seems almost unavoidable here...
Other architectures don't have such kind of problems, BTW.

Ivan.

--- 2.4/arch/i386/kernel/pci-irq.c	Fri Feb 28 16:46:28 2003
+++ linux/arch/i386/kernel/pci-irq.c	Mon Mar  3 13:42:04 2003
@@ -730,7 +730,7 @@ void __init pcibios_fixup_irqs(void)
 		 */
 		if (io_apic_assign_pci_irqs)
 		{
-			int irq;
+			int irq, irq1 = -1;
 
 			if (pin) {
 				pin--;		/* interrupt pins are numbered starting from 1 */
@@ -741,15 +741,19 @@ void __init pcibios_fixup_irqs(void)
 	 * parent slot, and pin number. The SMP code detects such bridged
 	 * busses itself so we should get into this branch reliably.
 	 */
-				if (irq < 0 && dev->bus->parent) { /* go back to the bridge */
+				if (dev->bus->parent) { /* go back to the bridge */
 					struct pci_dev * bridge = dev->bus->self;
 
 					pin = (pin + PCI_SLOT(dev->devfn)) % 4;
-					irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
+					irq1 = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
 							PCI_SLOT(bridge->devfn), pin);
-					if (irq >= 0)
-						printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
-							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
+				}
+				if (irq1 >= 0 && irq1 != irq) {
+					/* IRQ listed in MP-table doesn't match one for parent slot.
+					   Use that we've found instead. */
+					irq = irq1;
+					printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
+						bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
 				}
 				if (irq >= 0) {
 					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
