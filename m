Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRAQBkW>; Tue, 16 Jan 2001 20:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130311AbRAQBkE>; Tue, 16 Jan 2001 20:40:04 -0500
Received: from 64-32-134-244.phx1.phoenixdsl.net ([64.32.134.244]:774 "EHLO
	virtualwire.org") by vger.kernel.org with ESMTP id <S130013AbRAQBj5>;
	Tue, 16 Jan 2001 20:39:57 -0500
Message-ID: <3A64F7E2.30807@virtualwire.org>
Date: Tue, 16 Jan 2001 18:39:46 -0700
From: Duncan Laurie <duncan@virtualwire.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-pre5 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: randy.dunlap@intel.com, torvalds@transmeta.com, pem@informatics.muni.cz
Subject: RE: int. assignment on SMP + ServerWorks chipset
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, torvalds@transmeta.com wrote:
 >
 > On Mon, 15 Jan 2001, Randy.Dunlap wrote:
 > >
 > > A Linux-USB user (pem@ = Petr) reported that USB (OHCI) wasn't
 > > working on his Intel STL2 system.  This system uses a ServerWorks
 > > chipset, hence the OHCI part.
 >
 > Does it work with "noapic"?
 >
 > It is entirely possible that we should try to use the pirq tables even
 > with the apic, and just make sure that we use the untranslated PCI irq
 > number for testing etc.
 >

This may actually be an MP BIOS bug...

According to the boot log, the MP table I/O Interrupt entry for the
USB controller (PCI device 00:0f:02) is:

   Int: type 0, pol 3, trig 3, bus 0, IRQ 3c, APIC ID 5, APIC INT 00

Which specifies the destination APIC ID 5 (corresponding to the 2nd
IO-APIC, used solely to distribute PCI interrupts) and destination INT
pin 0.  So when the IO-APICs are programmed this IRQ is remapped to:

   PCI->APIC IRQ transform: (B0,I15,P0) -> 16

The problem is the USB Interrupt is internally routed and should use
the ISA IO-APIC for the destination APIC, and a valid ISA IRQ for the
destination INT.  The MP table entry and corresponding IRQ transform
should look something like this:

   [I used INT 09 simply because it wasn't already assigned...]

   Int: type 0, pol 3, trig 3, bus 0, IRQ 3c, APIC ID 4, APIC INT 09
   PCI->APIC IRQ transform: (B0,I15,P0) -> 9

Here's a patch to find & correct this entry on boot.  Its not pretty,
and should ONLY be used to verify this particular fix--any real solution
will have to be done in the BIOS.  (there doesn't seem to be an easy way
to alter specific MP table entries outside of the BIOS, especially if
they happen to exist in write-protected memory regions...)

There may be bogus data in the PIRQ table as well, which is why this
explicitly routes the interrupt & sets the ELCR.  If you enable DEBUG
in pci-i386.h and re-send the dmesg output I will look it over.

    -duncan


--- linux/arch/i386/kernel/mpparse.c	Tue Nov 14 22:25:34 2000
+++ linux~/arch/i386/kernel/mpparse.c	Tue Jan 16 17:11:07 2001
@@ -237,6 +237,37 @@
  	 
	m->mpc_irqtype, m->mpc_irqflag & 3,
  	 
	(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
  	 
	m->mpc_srcbusirq, m->mpc_dstapic, m->mpc_dstirq);
+
+ 
if ((m->mpc_irqtype == 0) && ((m->mpc_irqflag & 3) == 3) &&
+ 
     ((m->mpc_irqflag >> 2) == 3) && (m->mpc_srcbus == 0) &&
+ 
     (m->mpc_dstapic == 5) && (m->mpc_srcbusirq == 0x3c))
+ 
{
+ 
	struct mpc_config_intsrc usbint = { MP_INTSRC,
+ 
					    0x00, 0x000f, 0x00,
+ 
					    0x3c, 0x04, 0x09 };
+ 
	unsigned char mask = 1 << (usbint.mpc_dstirq & 7);
+ 
	unsigned int port = 0x4d0 + (usbint.mpc_dstirq >> 3);
+ 
	unsigned char val = inb(port);
+
+ 
	Dprintk("MP BIOS bug, USB INT should use ISA IO-APIC!\n");
+
+ 
	/* fix PIRQ routing entry: index 1 -> dstirq */
+ 
	outb_p(1, 0xc00);
+ 
	outb_p(usbint.mpc_dstirq, 0xc01);
+ 
	if (!(val & mask))
+ 
		outb(val|mask, port);
+
+ 
	/* use modified intsrc struct */
+ 
	mp_irqs[mp_irq_entries] = usbint;
+
+ 
	Dprintk("Int: type %d, pol %d, trig %d, bus %d,"
+ 
		" IRQ %02x, APIC ID %x, APIC INT %02x\n",
+ 
		usbint.mpc_irqtype, usbint.mpc_irqflag & 3,
+ 
		(usbint.mpc_irqflag >> 2) & 3,
+ 
		usbint.mpc_srcbus,  usbint.mpc_srcbusirq,
+ 
		usbint.mpc_dstapic, usbint.mpc_dstirq);
+ 
}
+
  	if (++mp_irq_entries == MAX_IRQ_SOURCES)
  		panic("Max # of irq sources exceeded!!\n");
  }



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
