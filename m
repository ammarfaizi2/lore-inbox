Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131031AbRAVA3P>; Sun, 21 Jan 2001 19:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbRAVA3E>; Sun, 21 Jan 2001 19:29:04 -0500
Received: from zeus.kernel.org ([209.10.41.242]:61636 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131387AbRAVA24>;
	Sun, 21 Jan 2001 19:28:56 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF36@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Duncan Laurie'" <duncan@virtualwire.org>, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, pem@informatics.muni.cz
Subject: RE: int. assignment on SMP + ServerWorks chipset
Date: Sun, 21 Jan 2001 16:26:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duncan,

Your temporary patch enables my USB host controller and USB devices
(mouse, hub, and keyboard) to work on an STL2 system.


> From: Duncan Laurie [mailto:duncan@virtualwire.org]
> Sent: Tuesday, January 16, 2001 5:40 PM
> To: linux-kernel@vger.kernel.org
> Cc: randy.dunlap@intel.com; torvalds@transmeta.com;
> pem@informatics.muni.cz
> Subject: RE: int. assignment on SMP + ServerWorks chipset
> 
...
> This may actually be an MP BIOS bug...

Yes, I was also thinking this.  I'll check with some other
people on it tomorrow.

Thanks,
~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

> According to the boot log, the MP table I/O Interrupt entry for the
> USB controller (PCI device 00:0f:02) is:
> 
>    Int: type 0, pol 3, trig 3, bus 0, IRQ 3c, APIC ID 5, APIC INT 00
> 
> Which specifies the destination APIC ID 5 (corresponding to the 2nd
> IO-APIC, used solely to distribute PCI interrupts) and destination INT
> pin 0.  So when the IO-APICs are programmed this IRQ is remapped to:
> 
>    PCI->APIC IRQ transform: (B0,I15,P0) -> 16
> 
> The problem is the USB Interrupt is internally routed and should use
> the ISA IO-APIC for the destination APIC, and a valid ISA IRQ for the
> destination INT.  The MP table entry and corresponding IRQ transform
> should look something like this:
> 
>    [I used INT 09 simply because it wasn't already assigned...]
> 
>    Int: type 0, pol 3, trig 3, bus 0, IRQ 3c, APIC ID 4, APIC INT 09
>    PCI->APIC IRQ transform: (B0,I15,P0) -> 9
> 
> Here's a patch to find & correct this entry on boot.  Its not pretty,
> and should ONLY be used to verify this particular fix--any 
> real solution
> will have to be done in the BIOS.  (there doesn't seem to be 
> an easy way
> to alter specific MP table entries outside of the BIOS, especially if
> they happen to exist in write-protected memory regions...)
> 
> There may be bogus data in the PIRQ table as well, which is why this
> explicitly routes the interrupt & sets the ELCR.  If you enable DEBUG
> in pci-i386.h and re-send the dmesg output I will look it over.
> 
>     -duncan
> 
> 
> --- linux/arch/i386/kernel/mpparse.c	Tue Nov 14 22:25:34 2000
> +++ linux~/arch/i386/kernel/mpparse.c	Tue Jan 16 17:11:07 2001
> @@ -237,6 +237,37 @@
>   	 
> 	m->mpc_irqtype, m->mpc_irqflag & 3,
>   	 
> 	(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
>   	 
> 	m->mpc_srcbusirq, m->mpc_dstapic, m->mpc_dstirq);
> +
> + 
> if ((m->mpc_irqtype == 0) && ((m->mpc_irqflag & 3) == 3) &&
> + 
>      ((m->mpc_irqflag >> 2) == 3) && (m->mpc_srcbus == 0) &&
> + 
>      (m->mpc_dstapic == 5) && (m->mpc_srcbusirq == 0x3c))
> + 
> {
> + 
> 	struct mpc_config_intsrc usbint = { MP_INTSRC,
> + 
> 					    0x00, 0x000f, 0x00,
> + 
> 					    0x3c, 0x04, 0x09 };
> + 
> 	unsigned char mask = 1 << (usbint.mpc_dstirq & 7);
> + 
> 	unsigned int port = 0x4d0 + (usbint.mpc_dstirq >> 3);
> + 
> 	unsigned char val = inb(port);
> +
> + 
> 	Dprintk("MP BIOS bug, USB INT should use ISA IO-APIC!\n");
> +
> + 
> 	/* fix PIRQ routing entry: index 1 -> dstirq */
> + 
> 	outb_p(1, 0xc00);
> + 
> 	outb_p(usbint.mpc_dstirq, 0xc01);
> + 
> 	if (!(val & mask))
> + 
> 		outb(val|mask, port);
> +
> + 
> 	/* use modified intsrc struct */
> + 
> 	mp_irqs[mp_irq_entries] = usbint;
> +
> + 
> 	Dprintk("Int: type %d, pol %d, trig %d, bus %d,"
> + 
> 		" IRQ %02x, APIC ID %x, APIC INT %02x\n",
> + 
> 		usbint.mpc_irqtype, usbint.mpc_irqflag & 3,
> + 
> 		(usbint.mpc_irqflag >> 2) & 3,
> + 
> 		usbint.mpc_srcbus,  usbint.mpc_srcbusirq,
> + 
> 		usbint.mpc_dstapic, usbint.mpc_dstirq);
> + 
> }
> +
>   	if (++mp_irq_entries == MAX_IRQ_SOURCES)
>   		panic("Max # of irq sources exceeded!!\n");
>   }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
