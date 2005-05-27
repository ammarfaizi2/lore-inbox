Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVE0PsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVE0PsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVE0PsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:48:11 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:28994 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262480AbVE0Prk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:47:40 -0400
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.219):SA:0(1.1/5.0):. Processed in 6.629509 secs Process 2761)
Message-ID: <4297410B.7050905@sergiomb.no-ip.org>
Date: Fri, 27 May 2005 16:47:23 +0100
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pt-PT; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en, pt
MIME-Version: 1.0
To: Len Brown <lenb@toshiba.hsd1.ma.comcast.net>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, bjorn.helgaas@hp.com
Subject: Re: [ACPI] [PATCH] VIA IRQ quirk for 2.6.12-rc5
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
In-Reply-To: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2005 15:47:35.0855 (UTC) FILETIME=[672CFBF0:01C562D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

Bjorn Helgaas has updated this issue on email [ACPI] [PATCH] PCI: do VIA IRQ fixup always, not just in PIC mode (resend)

My suggestion is reopen the bug 3319 
http://bugme.osdl.org/show_bug.cgi?id=3319
for track down better this issue .

thanks, 


Len Brown wrote:

>Linus,
>Please apply this patch to 2.6.12-rc5.
>It fixes a 2.6.11 regression in the VIA IRQ quirk
>on machines with mixed vendor chip-sets.
>
>thanks,
>Len
>
>
>Delete quirk_via_bridge(), restore quirk_via_irqpic() --
>but now improved to be invoked upon device ENABLE, and
>now only for VIA devices -- not all devices behind VIA bridges.
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Signed-off-by: Len Brown <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>
>
>diff -uprN -X dontdiff linux-2.6.12-rc5.orig/arch/i386/pci/irq.c linux-2.6.12-rc5/arch/i386/pci/irq.c
>--- linux-2.6.12-rc5.orig/arch/i386/pci/irq.c	2005-05-27 01:42:45.000000000 -0400
>+++ linux-2.6.12-rc5/arch/i386/pci/irq.c	2005-05-27 02:31:41.000000000 -0400
>@@ -1029,7 +1029,6 @@ void pcibios_penalize_isa_irq(int irq)
> static int pirq_enable_irq(struct pci_dev *dev)
> {
> 	u8 pin;
>-	extern int via_interrupt_line_quirk;
> 	struct pci_dev *temp_dev;
> 
> 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>@@ -1084,10 +1083,6 @@ static int pirq_enable_irq(struct pci_de
> 		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
> 		       'A' + pin, pci_name(dev), msg);
> 	}
>-	/* VIA bridges use interrupt line for apic/pci steering across
>-	   the V-Link */
>-	else if (via_interrupt_line_quirk)
>-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
> 	return 0;
> }
> 
>diff -uprN -X dontdiff linux-2.6.12-rc5.orig/drivers/acpi/pci_irq.c linux-2.6.12-rc5/drivers/acpi/pci_irq.c
>--- linux-2.6.12-rc5.orig/drivers/acpi/pci_irq.c	2005-05-27 01:43:08.000000000 -0400
>+++ linux-2.6.12-rc5/drivers/acpi/pci_irq.c	2005-05-27 02:31:41.000000000 -0400
>@@ -391,7 +391,6 @@ acpi_pci_irq_enable (
> 	u8			pin = 0;
> 	int			edge_level = ACPI_LEVEL_SENSITIVE;
> 	int			active_high_low = ACPI_ACTIVE_LOW;
>-	extern int		via_interrupt_line_quirk;
> 	char			*link = NULL;
> 
> 	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
>@@ -444,9 +443,6 @@ acpi_pci_irq_enable (
> 		}
>  	}
> 
>-	if (via_interrupt_line_quirk)
>-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
>-
> 	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
> 
> 	printk(KERN_INFO PREFIX "PCI Interrupt %s[%c] -> ",
>diff -uprN -X dontdiff linux-2.6.12-rc5.orig/drivers/pci/quirks.c linux-2.6.12-rc5/drivers/pci/quirks.c
>--- linux-2.6.12-rc5.orig/drivers/pci/quirks.c	2005-05-27 01:43:34.000000000 -0400
>+++ linux-2.6.12-rc5/drivers/pci/quirks.c	2005-05-27 02:35:27.000000000 -0400
>@@ -18,6 +18,7 @@
> #include <linux/pci.h>
> #include <linux/init.h>
> #include <linux/delay.h>
>+#include <linux/acpi.h>
> #include "pci.h"
> 
> /* Deal with broken BIOS'es that neglect to enable passive release,
>@@ -467,9 +468,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AM
>  * non-x86 architectures (yes Via exists on PPC among other places),
>  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
>  * interrupts delivered properly.
>- *
>- * TODO: When we have device-specific interrupt routers,
>- * quirk_via_irqpic will go away from quirks.
>  */
> 
> /*
>@@ -494,6 +492,29 @@ static void __devinit quirk_via_acpi(str
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
> 
>+static void __devinit quirk_via_irqpic(struct pci_dev *dev)
>+{
>+	u8 irq, new_irq;
>+
>+#ifdef CONFIG_X86_IO_APIC
>+	if (nr_ioapics && !skip_ioapic_setup)
>+		return;
>+#endif
>+#ifdef CONFIG_ACPI
>+	if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
>+		return;
>+#endif
>+	new_irq = dev->irq & 0xf;
>+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>+	if (new_irq != irq) {
>+		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
>+			pci_name(dev), irq, new_irq);
>+		udelay(15);	/* unknown if delay really needed */
>+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>+	}
>+}
>+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irqpic);
>+
> /*
>  * PIIX3 USB: We have to disable USB interrupts that are
>  * hardwired to PIRQD# and may be shared with an
>@@ -683,19 +704,6 @@ static void __init quirk_disable_pxb(str
> }
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb );
> 
>-/*
>- *	VIA northbridges care about PCI_INTERRUPT_LINE
>- */
>-int via_interrupt_line_quirk;
>-
>-static void __devinit quirk_via_bridge(struct pci_dev *pdev)
>-{
>-	if(pdev->devfn == 0) {
>-		printk(KERN_INFO "PCI: Via IRQ fixup\n");
>-		via_interrupt_line_quirk = 1;
>-	}
>-}
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge );
> 
> /*
>  *	Serverworks CSB5 IDE does not fully support native mode
>diff -uprN -X dontdiff linux-2.6.12-rc5.orig/include/linux/acpi.h linux-2.6.12-rc5/include/linux/acpi.h
>--- linux-2.6.12-rc5.orig/include/linux/acpi.h	2005-05-27 01:44:10.000000000 -0400
>+++ linux-2.6.12-rc5/include/linux/acpi.h	2005-05-27 02:47:04.000000000 -0400
>@@ -25,6 +25,8 @@
> #ifndef _LINUX_ACPI_H
> #define _LINUX_ACPI_H
> 
>+#ifdef	CONFIG_ACPI
>+
> #ifndef _LINUX
> #define _LINUX
> #endif
>@@ -533,4 +535,5 @@ static inline int acpi_get_pxm(acpi_hand
> 
> extern int pnpacpi_disabled;
> 
>-#endif /*_LINUX_ACPI_H*/
>+#endif	/* CONFIG_ACPI */
>+#endif	/*_LINUX_ACPI_H*/
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by Yahoo.
>Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
>Search APIs Find out how you can build Yahoo! directly into your own
>Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>

