Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130892AbQK1JVt>; Tue, 28 Nov 2000 04:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130803AbQK1JVi>; Tue, 28 Nov 2000 04:21:38 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:60121 "EHLO
        delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
        id <S130892AbQK1JV1>; Tue, 28 Nov 2000 04:21:27 -0500
Date: Tue, 28 Nov 2000 09:42:36 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <Pine.LNX.3.96.1001127203333.9821A-100000@sneaker.sch.bme.hu>
Message-ID: <Pine.GSO.3.96.1001128091924.23460A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Mr. Big wrote:

> We've disabled the apic, because there was a hint, that maybe there's some
> bug with the hardware or software on it. I belive that it's could be
> better to use the apic.
> 
> The output of lspci -v:
[...]
> 00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
>         Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
>         Flags: bus master, medium devsel, latency 64, IRQ 5

 Hmm, this is the device you reported you have a problem initially, isn't
it?  If it is, then...

> 00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
>         Flags: bus master, medium devsel, latency 64, IRQ 5

 ... it shares its IRQ with an USB host adapter as I suspected.  And you
don't have an USB driver installed.  Does the following patch help?  (Hmm,
since you tested 2.4.0-test* as well -- it might not as it's just a
backport...  Then again -- you might hit a different problem with
2.4.0-test*.) 

 It's not impossible for an I/O APIC to lose an EOI message if there are
severe errors during the transmission -- since you already tried
2.4.0-test*: have you seen any APIC errors in the syslog? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -up --recursive --new-file linux-2.2.17.macro/drivers/pci/quirks.c linux-2.2.17/drivers/pci/quirks.c
--- linux-2.2.17.macro/drivers/pci/quirks.c	Wed Oct 27 00:53:40 1999
+++ linux-2.2.17/drivers/pci/quirks.c	Fri Oct 20 10:33:01 2000
@@ -144,6 +144,26 @@ __initfunc(static void quirk_isa_dma_han
 	}
 }
 
+/*
+ * PIIX3 USB: We have to disable USB interrupts that are
+ * hardwired to PIRQD# and may be shared with an
+ * external device.
+ *
+ * Legacy Support Register (LEGSUP):
+ *     bit13:  USB PIRQ Enable (USBPIRQDEN),
+ *     bit4:   Trap/SMI On IRQ Enable (USBSMIEN).
+ *
+ * We mask out all r/wc bits, too.
+ */
+__initfunc(static void quirk_piix3_usb(struct pci_dev *dev, int arg))
+{
+	u16 legsup;
+
+	pci_read_config_word(dev, 0xc0, &legsup);
+	legsup &= 0x50ef;
+	pci_write_config_word(dev, 0xc0, legsup);
+}
+
 
 typedef void (*quirk_handler)(struct pci_dev *, int);
 
@@ -202,6 +222,8 @@ static struct quirk_info quirk_list[] __
 	 */
 	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs,	0x00 },
 	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596_0,	quirk_isa_dma_hangs,	0x00 },
+	{ PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb,	0x00 },
+	{ PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb,	0x00 },
 };
 
 __initfunc(void pci_quirks_init(void))

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
