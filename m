Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVBABeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVBABeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 20:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVBABep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 20:34:45 -0500
Received: from a213-22-240-12.netcabo.pt ([213.22.240.12]:28313 "EHLO
	sergiomb.no-ip.org") by vger.kernel.org with ESMTP id S261498AbVBABdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 20:33:38 -0500
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov
X-Antivirus-bastov: 1.24-st-qms (Clear:RC:1(192.168.1.2):. Processed in 0.10293 secs Process 30110)
Subject: Re: [ACPI] [BKPATCH] ACPI for 2.4
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Len Brown <len.brown@intel.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1107160339.18002.44.camel@d845pe>
References: <1107160339.18002.44.camel@d845pe>
Content-Type: multipart/mixed; boundary="=-3CcFwf9JCbPS/CWBiZ3I"
Date: Tue, 01 Feb 2005 01:33:27 +0000
Message-Id: <1107221607.29901.18.camel@bastov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3CcFwf9JCbPS/CWBiZ3I
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi, cool 

May I suggest a little more debug with this 2nd version of the patch in
attach ?.

I get dmesg | grep -i via 
1. Disabling VIA memory write queue (PCI ID 0305, rev 80): [55] 3c & 1f -> 1c
2. PCI: Via IRQ fixup
3. Applying quirk_via_acpi.
4. Applying VIA southbridge workaround. (VIA Apollo KT133 needs PCI latency patch, applying quirk_vialatency).
5. PCI: Disabling Via external APIC routing

agpgart: Detected Via Apollo Pro KT133 chipset
VP_IDE: VIA vt82c686b (rev 42) IDE UDMA100 controller on pci00:07.1
parport_pc: Via 686A parallel port: io=0x378

1- the north bridge patch on arch/i386/kernel/pci-pc.c
2- the new patch
3- If ISA doesn't support PCI_INTERRUPT_LINE  ?
* FIXME: it is questionable that quirk_via_acpi
* is needed.  It shows up as an ISA bridge, and does not
* support the PCI_INTERRUPT_LINE register at all.  Therefore
* it seems like setting the pci_dev's 'irq' to the
* value of the ACPI SCI interrupt is only done for convenience.
*  -jgarzik

4- The general quirk, quirks all devices. Don't try to disable it, it
can damage the computer.
5- has a
/* TODO: When we have device-specific interrupt routers,
* this code will go away from quirks.
*/
but only with CONFIG_X86_IO_APIC, looks to me with no sense because, I
suppose I don't have any IO_APIC just one local apic.


thanks,


On Mon, 2005-01-31 at 03:32 -0500, Len Brown wrote:
> Hi Marcelo, please do a 
> 
> 	bk pull bk://linux-acpi.bkbits.net/to-marcelo
> 
> thanks,
> -Len
> 
> ps. a plain patch is also available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.29/acpi-20040326-2.4.29.diff.gz
> 
> This will update the following files:
> 
>  arch/i386/kernel/pci-irq.c   |    4 ++--
>  arch/x86_64/kernel/pci-irq.c |    4 ++--
>  drivers/acpi/pci_irq.c       |    4 ++++
>  drivers/pci/quirks.c         |   30 +++++-------------------------
>  4 files changed, 13 insertions(+), 29 deletions(-)
> 
> through these ChangeSets:
> 
> <len.brown@intel.com> (05/01/26 1.1499.5.2)
>    [ACPI] via interrupt quirk fix from 2.6
>    http://bugzilla.kernel.org/show_bug.cgi?id=3319
>    
>    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
>    Signed-off-by: Len Brown <len.brown@intel.com.
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Sérgio M.B.

--=-3CcFwf9JCbPS/CWBiZ3I
Content-Disposition: attachment; filename=acpi-2.4.29v2.diff
Content-Type: text/x-patch; name=acpi-2.4.29v2.diff; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

--- a/arch/i386/kernel/pci-irq.c	2005-01-31 03:29:46 -05:00
+++ b/arch/i386/kernel/pci-irq.c	2005-01-31 03:29:46 -05:00
@@ -1120,7 +1120,7 @@
 void pcibios_enable_irq(struct pci_dev *dev)
 {
 	u8 pin;
-	extern int interrupt_line_quirk;
+	extern int via_interrupt_line_quirk;
  	struct pci_dev *temp_dev;
 	
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
@@ -1173,7 +1173,7 @@
 	}
 	/* VIA bridges use interrupt line for apic/pci steering across
 	   the V-Link */
-	else if (interrupt_line_quirk)
+	else if (via_interrupt_line_quirk)
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
 		
 }
--- a/arch/x86_64/kernel/pci-irq.c	2005-01-31 03:29:46 -05:00
+++ b/arch/x86_64/kernel/pci-irq.c	2005-01-31 03:29:46 -05:00
@@ -742,7 +742,7 @@
 void pcibios_enable_irq(struct pci_dev *dev)
 {
 		u8 pin;
-	extern int interrupt_line_quirk;
+	extern int via_interrupt_line_quirk;
 
 		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
@@ -762,6 +762,6 @@
 	}
 	/* VIA bridges use interrupt line for apic/pci steering across
 	   the V-Link */
-	else if (interrupt_line_quirk)
+	else if (via_interrupt_line_quirk)
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 }
--- a/drivers/acpi/pci_irq.c	2005-01-31 03:29:46 -05:00
+++ b/drivers/acpi/pci_irq.c	2005-01-31 03:29:46 -05:00
@@ -335,6 +335,7 @@
 {
 	int			irq = 0;
 	u8			pin = 0;
+	extern int via_interrupt_line_quirk;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
 
@@ -382,6 +383,9 @@
 			return_VALUE(0);
 		}
  	}
+
+	if (via_interrupt_line_quirk)
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
 
 	dev->irq = irq;
 
--- linux-2.4.29f/drivers/pci/quirks.c.orig	2005-02-01 00:42:25.000000000 +0000
+++ linux-2.4.29f/drivers/pci/quirks.c	2005-02-01 00:59:26.000000000 +0000
@@ -143,7 +143,7 @@
 	busarb &= ~(1<<5);
 	busarb |= (1<<4);
 	pci_write_config_byte(dev, 0x76, busarb);
-	printk(KERN_INFO "Applying VIA southbridge workaround.\n");
+	printk(KERN_INFO "Applying VIA southbridge workaround. (VIA Apollo KT133 needs PCI latency patch, applying quirk_vialatency).\n");
 }
 
 /*
@@ -207,6 +207,7 @@
 	struct resource *r = &dev->resource[0];
 
 	if ((r->start & 0x3ffffff) || r->end != r->start + 0x3ffffff) {
+		printk(KERN_INFO "quirk_s3_64M:re-allocate the region.\n");
 		r->start = 0;
 		r->end = 0x3ffffff;
 	}
@@ -304,6 +305,7 @@
 		pci_read_config_dword(dev, 0x48, &region);
 		region &= PCI_BASE_ADDRESS_IO_MASK;
 		quirk_io_region(dev, region, 256, PCI_BRIDGE_RESOURCES);
+		printk(KERN_INFO "Applying quirk_vt82c586_acpi.\n");
 	}
 }
 
@@ -327,6 +329,7 @@
 	pci_read_config_dword(dev, 0x90, &smb);
 	smb &= PCI_BASE_ADDRESS_IO_MASK;
 	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 2);
+	printk(KERN_INFO "Applying quirk_vt82c686_acpi.\n");
 }
 
 
@@ -368,9 +371,6 @@
  * non-x86 architectures (yes Via exists on PPC among other places),
  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
  * interrupts delivered properly.
- *
- * TODO: When we have device-specific interrupt routers,
- * quirk_via_irqpic will go away from quirks.
  */
 
 /*
@@ -391,24 +391,9 @@
 	irq &= 0xf;
 	if (irq && (irq != 2))
 		d->irq = irq;
+	printk(KERN_INFO "Applying quirk_via_acpi.\n");
 }
 
-static void __init quirk_via_irqpic(struct pci_dev *dev)
-{
-	u8 irq, new_irq = dev->irq & 0xf;
-
-	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-
-	if (new_irq != irq) {
-		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
-		       dev->slot_name, irq, new_irq);
-
-		udelay(15);
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
-	}
-}
-
-
 /*
  * PIIX3 USB: We have to disable USB interrupts that are
  * hardwired to PIRQD# and may be shared with an
@@ -639,12 +624,14 @@
  *	VIA northbridges care about PCI_INTERRUPT_LINE
  */
  
-int interrupt_line_quirk;
+int via_interrupt_line_quirk;
 
 static void __init quirk_via_bridge(struct pci_dev *pdev)
 {
-	if(pdev->devfn == 0)
-		interrupt_line_quirk = 1;
+	if(pdev->devfn == 0) {
+		printk(KERN_INFO "PCI: Via IRQ fixup\n");
+		via_interrupt_line_quirk = 1;
+	}
 }
 	
 /* 
@@ -773,9 +760,6 @@
 #endif
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_via_irqpic },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_via_irqpic },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_via_irqpic },
 
 	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering },

--=-3CcFwf9JCbPS/CWBiZ3I--

