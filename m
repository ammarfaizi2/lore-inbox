Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbRFBNRs>; Sat, 2 Jun 2001 09:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262564AbRFBNRj>; Sat, 2 Jun 2001 09:17:39 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21415 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262563AbRFBNRc>;
	Sat, 2 Jun 2001 09:17:32 -0400
Message-ID: <3B18E768.3B0864C7@mandrakesoft.com>
Date: Sat, 02 Jun 2001 09:17:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
        cort@fsmlabs.com, thunder7@xs4all.nl,
        Adrian Cox <adrian@humboldt.co.uk>, mj@ucw.cz
Subject: PATCH 2.4.5.ac6: more Via irq fixes
Content-Type: multipart/mixed;
 boundary="------------C5E420D527090A8D2A40982B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C5E420D527090A8D2A40982B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a patch against 2.4.5-ac6 which should fix issues with
on-board Via devices and interrupts, particularly on Via SMP machines,
or Via machines that requires 'noapic' or "PNP-OS:No" to be functional.

This has been tested by a user with a Via SMP board under both MPS 1.1
and MPS 1.4, and has been shown to solve the problems he was having with
interrupt delivery.  It has also been tested on my dinky, ancient K6-2
laptop to make sure there were no generic Via regressions.

Special thanks again to Adrian Cox, who pointed out the
somewhat-documented fact that PCI_INTERRUPT_LINE is not merely a
scratchpad register for the on-board Via devices.  Since we blindly
write the values from IO-APIC into PCI_INTERRUPT_LINE, whose irq values
can exceed the register limit of 14, this caused some chaos for Via
users.

This patch also moves the Via ACPI to drivers/pci/quirks.c, because Via
ACPI is not x86 only, and it updates some comments and adds a helpful
printk.

2.5/LATE 2.4 NOTE:  As Linus has pointed out, we really need
infrastructure to have different interrupt routers on a per-device
basis.  If you look through the PCI quirks in the arch and generic code,
you see code working around this lack of infrastructure, sometimes in
really ugly ways.

-- 
Jeff Garzik      | Echelon words of the day, from The Register:
Building 1024    | FRU Lebed HALO Spetznaz Al Amn al-Askari Glock 26 
MandrakeSoft     | Steak Knife Kill the President anarchy echelon
                 | nuclear assassinate Roswell Waco World Trade Center
--------------C5E420D527090A8D2A40982B
Content-Type: text/plain; charset=us-ascii;
 name="via-irqpic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-irqpic.patch"

diff -urN linux.ac6/arch/i386/kernel/pci-pc.c linux.viairq/arch/i386/kernel/pci-pc.c
--- linux.ac6/arch/i386/kernel/pci-pc.c	Sat May 26 18:44:02 2001
+++ linux.viairq/arch/i386/kernel/pci-pc.c	Sat Jun  2 09:05:03 2001
@@ -940,18 +940,6 @@
 	pcibios_max_latency = 32;
 }
 
-static void __init pci_fixup_via_acpi(struct pci_dev *d)
-{
-	/*
-	 * VIA ACPI device: IRQ line in PCI config byte 0x42
-	 */
-	u8 irq;
-	pci_read_config_byte(d, 0x42, &irq);
-	irq &= 0x0f;
-	if (irq && (irq != 2))
-		d->irq = irq;
-}
-
 static void __init pci_fixup_piix4_acpi(struct pci_dev *d)
 {
 	/*
@@ -1002,8 +990,6 @@
 	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			pci_fixup_ide_bases },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		pci_fixup_latency },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		pci_fixup_latency },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	pci_fixup_via_acpi },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	pci_fixup_via_acpi },
 #if 0
 /* This seems completely bogus so I am removing it -- Alan */	
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C691,	pci_fixup_via691 },
diff -urN linux.ac6/drivers/pci/quirks.c linux.viairq/drivers/pci/quirks.c
--- linux.ac6/drivers/pci/quirks.c	Thu May 17 13:11:23 2001
+++ linux.viairq/drivers/pci/quirks.c	Sat Jun  2 09:04:33 2001
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #undef DEBUG
 
@@ -267,6 +268,9 @@
 /*
  * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip
  * devices to the external APIC.
+ *
+ * TODO: When we have device-specific interrupt routers,
+ * this code will go away from quirks.
  */
 static void __init quirk_via_ioapic(struct pci_dev *dev)
 {
@@ -277,6 +281,9 @@
 	else
 		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
 		
+	printk(KERN_INFO "PCI: %sbling Via external APIC routing\n",
+	       tmp == 0 ? "Disa" : "Ena");
+
 	/* Offset 0x58: External APIC IRQ output control */
 	pci_write_config_byte (dev, 0x58, tmp);
 }
@@ -285,6 +292,56 @@
 
 
 /*
+ * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
+ * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
+ * when written, it makes an internal connection to the PIC.
+ * For these devices, this register is defined to be 4 bits wide.
+ * Normally this is fine.  However for IO-APIC motherboards, or
+ * non-x86 architectures (yes Via exists on PPC among other places),
+ * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
+ * interrupts delivered properly.
+ *
+ * TODO: When we have device-specific interrupt routers,
+ * quirk_via_irqpic will go away from quirks.
+ */
+
+/*
+ * FIXME: it is questionable that quirk_via_acpi
+ * is needed.  It shows up as an ISA bridge, and does not
+ * support the PCI_INTERRUPT_LINE register at all.  Therefore
+ * it seems like setting the pci_dev's 'irq' to the
+ * value of the ACPI SCI interrupt is only done for convenience.
+ *	-jgarzik
+ */
+static void __init quirk_via_acpi(struct pci_dev *d)
+{
+	/*
+	 * VIA ACPI device: SCI IRQ line in PCI config byte 0x42
+	 */
+	u8 irq;
+	pci_read_config_byte(d, 0x42, &irq);
+	irq &= 0xf;
+	if (irq && (irq != 2))
+		d->irq = irq;
+}
+
+static void __init quirk_via_irqpic(struct pci_dev *dev)
+{
+	u8 irq, new_irq = dev->irq & 0xf;
+
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+
+	if (new_irq != irq) {
+		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
+		       dev->slot_name, irq, new_irq);
+
+		udelay(15);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
+	}
+}
+
+
+/*
  * PIIX3 USB: We have to disable USB interrupts that are
  * hardwired to PIRQD# and may be shared with an
  * external device.
@@ -372,6 +429,11 @@
 #ifdef CONFIG_X86_IO_APIC 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic },
 #endif
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_via_irqpic },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_via_irqpic },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_via_irqpic },
 
 	{ 0 }
 };
diff -urN linux.ac6/drivers/sound/via82cxxx_audio.c linux.viairq/drivers/sound/via82cxxx_audio.c
--- linux.ac6/drivers/sound/via82cxxx_audio.c	Wed May  2 05:26:15 2001
+++ linux.viairq/drivers/sound/via82cxxx_audio.c	Sat Jun  2 09:04:33 2001
@@ -3012,7 +3012,6 @@
 {
 	int rc;
 	struct via_info *card;
-	u8 tmp;
 	static int printed_version = 0;
 
 	DPRINTK ("ENTER\n");
@@ -3107,19 +3106,6 @@
 	if (rc) {
 		printk (KERN_ERR PFX "interrupt init failed, aborting\n");
 		goto err_out_have_proc;
-	}
-
-	pci_read_config_byte (pdev, 0x3C, &tmp);
-	if ((tmp & 0x0F) != pdev->irq) {
-		printk (KERN_WARNING PFX "IRQ fixup, 0x3C==0x%02X\n", tmp);
-		udelay (15);
-		tmp &= 0xF0;
-		tmp |= pdev->irq;
-		pci_write_config_byte (pdev, 0x3C, tmp);
-		DPRINTK ("new 0x3c==0x%02x\n", tmp);
-	} else {
-		DPRINTK ("IRQ reg 0x3c==0x%02x, irq==%d\n",
-			tmp, tmp & 0x0F);
 	}
 
 	printk (KERN_INFO PFX "board #%d at 0x%04lX, IRQ %d\n",

--------------C5E420D527090A8D2A40982B--

