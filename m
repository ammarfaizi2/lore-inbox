Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262087AbRFBHlo>; Sat, 2 Jun 2001 03:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262088AbRFBHlf>; Sat, 2 Jun 2001 03:41:35 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37285 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262087AbRFBHlS>;
	Sat, 2 Jun 2001 03:41:18 -0400
Message-ID: <3B189894.8B2FA041@mandrakesoft.com>
Date: Sat, 02 Jun 2001 03:41:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: thunder7@xs4all.nl
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        John Cavan <johnc@damncats.org>
Subject: [PATCH] interrupt problem with MPS 1.4 / not with MPS 1.1 ?
In-Reply-To: <3B16A7E3.1BD600F3@colorfullife.com> <20010531222708.A8295@middle.of.nowhere> <3B16AD5D.DEDB8523@colorfullife.com> <20010601071414.A871@middle.of.nowhere> <3B17D0C1.5FC21CFB@colorfullife.com> <20010601210346.A1069@middle.of.nowhere> <3B17FE40.BDCB31BD@mandrakesoft.com> <20010602082710.A1071@middle.of.nowhere>
Content-Type: multipart/mixed;
 boundary="------------6AC85F0A1F53EF0DC34966F6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6AC85F0A1F53EF0DC34966F6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> On Fri, Jun 01, 2001 at 04:42:40PM -0400, Jeff Garzik wrote:
> > Does this patch fix things for you, such that MPS 1.1 and MPS 1.4 both
> > work?
> 
> No, I'm afraid it doesn't :-(
> 
> Here are the dmesg (with some info cut out for brevity), the
> /proc/interrupts and the lspci -vvvxxx from a 2.4.5-ac6 kernel with this
> patch. I see in the dmesg the patch is active, but still I get:


Thanks for testing.

Ok, how about this one?  This is a more simple version of the logic
presented, which should give you the value that Manfred asked you plug
in manually.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
--------------6AC85F0A1F53EF0DC34966F6
Content-Type: text/plain; charset=us-ascii;
 name="via-irqpic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-irqpic.patch"

diff -urN linux-2.4.5/drivers/pci/quirks.c linux.viairq/drivers/pci/quirks.c
--- linux-2.4.5/drivers/pci/quirks.c	Sat May 19 20:43:06 2001
+++ linux.viairq/drivers/pci/quirks.c	Sat Jun  2 03:38:48 2001
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #undef DEBUG
 
@@ -267,6 +268,8 @@
 /*
  * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip
  * devices to the external APIC.
+ *
+ * TODO: this should be done at IRQ assign time (pci_enable_device call)
  */
 static void __init quirk_via_ioapic(struct pci_dev *dev)
 {
@@ -277,6 +280,9 @@
 	else
 		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
 		
+	printk(KERN_INFO "PCI: %sbling Via external APIC routing\n",
+	       tmp ? "Disa" : "Ena");
+
 	/* Offset 0x58: External APIC IRQ output control */
 	pci_write_config_byte (dev, 0x58, tmp);
 }
@@ -285,6 +291,34 @@
 
 
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
+ * TODO: this should be done at IRQ assign time (pci_enable_device call)
+ */
+static void __init quirk_via_irqpic(struct pci_dev *dev)
+{
+	u8 irq, new_irq;
+
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+	new_irq = irq & 0xf;
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
@@ -372,6 +406,11 @@
 #ifdef CONFIG_X86_IO_APIC 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic },
 #endif
+
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_via_irqpic },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_irqpic },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_via_irqpic },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_via_irqpic },
 
 	{ 0 }
 };
diff -urN linux-2.4.5/drivers/sound/via82cxxx_audio.c linux.viairq/drivers/sound/via82cxxx_audio.c
--- linux-2.4.5/drivers/sound/via82cxxx_audio.c	Tue May  1 19:05:00 2001
+++ linux.viairq/drivers/sound/via82cxxx_audio.c	Fri Jun  1 16:32:25 2001
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

--------------6AC85F0A1F53EF0DC34966F6--

