Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270608AbUJUFOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270608AbUJUFOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270590AbUJUFEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:04:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:44674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270621AbUJUE7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:59:46 -0400
Date: Wed, 20 Oct 2004 21:57:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: dsaxena@plexity.net
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Remove inclusion of <linux/irq.h> from pci/quirks.c
Message-Id: <20041020215750.3f3764e6.akpm@osdl.org>
In-Reply-To: <20041020182222.GA20201@plexity.net>
References: <20041020182222.GA20201@plexity.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena <dsaxena@plexity.net> wrote:
>
> <linux/irq.h> states:
> 
>  /*
>   * Please do not include this file in generic code.  There is currently
>   * no requirement for any architecture to implement anything held
>   * within this file.
>   *
>   * Thanks. --rmk
>   */
> 
>  The latest update into pci/quirks.c did not follow this and breaks 
>  building on ARM.

But it does break building on x86, which might prove a tad unpopular.

That x86 code shouldn't be in the generic PCI code at all, I guess.  This
patch move it into io_apic.c and appears to build OK.  I'll play with it a
bit more.

Also, it worries me that quirk_intel_irqbalance() is marked __devinit and
calls irqbalance_disable(), which is marked __init.  I guess a fix for that
would be to mark quirk_intel_irqbalance() as __init, since it's unlikely to
be called after free_initmem().  Does Greg agree?


 25-akpm/arch/i386/kernel/io_apic.c |   45 +++++++++++++++++++++++++++++++++++++
 25-akpm/drivers/pci/quirks.c       |   44 ------------------------------------
 arch/i386/kernel/pci-dma.c         |    0 
 3 files changed, 45 insertions(+), 44 deletions(-)

diff -puN drivers/pci/quirks.c~move-quirk_intel_irqbalance drivers/pci/quirks.c
--- 25/drivers/pci/quirks.c~move-quirk_intel_irqbalance	2004-10-20 21:51:21.111892336 -0700
+++ 25-akpm/drivers/pci/quirks.c	2004-10-20 21:51:39.829046896 -0700
@@ -1210,50 +1210,6 @@ static void __init quirk_intel_ide_combi
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,	  quirk_intel_ide_combined );
 #endif /* CONFIG_SCSI_SATA */
 
-#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
-
-void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
-{
-	u8 config, rev;
-	u32 word;
-	extern struct pci_raw_ops *raw_pci_ops;
-
-	/* BIOS may enable hardware IRQ balancing for
-	 * E7520/E7320/E7525(revision ID 0x9 and below)
-	 * based platforms.
-	 * Disable SW irqbalance/affinity on those platforms.
-	 */
-	pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);
-	if (rev > 0x9)
-		return;
-
-	printk(KERN_INFO "Intel E7520/7320/7525 detected.");
-
-	/* enable access to config space*/
-	pci_read_config_byte(dev, 0xf4, &config);
-	config |= 0x2;
-	pci_write_config_byte(dev, 0xf4, config);
-
-	/* read xTPR register */
-	raw_pci_ops->read(0, 0, 0x40, 0x4c, 2, &word);
-
-	if (!(word & (1 << 13))) {
-		printk(KERN_INFO "Disabling irq balancing and affinity\n");
-#ifdef CONFIG_IRQBALANCE
-		irqbalance_disable("");
-#endif
-		noirqdebug_setup("");
-		no_irq_affinity = 1;
-	}
-
-	config &= ~0x2;
-	/* disable access to config space*/
-	pci_write_config_byte(dev, 0xf4, config);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_intel_irqbalance);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_intel_irqbalance);
-#endif
-
 int pciehp_msi_quirk;
 
 static void __devinit quirk_pciehp_msi(struct pci_dev *pdev)
diff -puN arch/i386/kernel/pci-dma.c~move-quirk_intel_irqbalance arch/i386/kernel/pci-dma.c
diff -puN arch/i386/kernel/io_apic.c~move-quirk_intel_irqbalance arch/i386/kernel/io_apic.c
--- 25/arch/i386/kernel/io_apic.c~move-quirk_intel_irqbalance	2004-10-20 21:52:14.060842872 -0700
+++ 25-akpm/arch/i386/kernel/io_apic.c	2004-10-20 21:52:48.960537312 -0700
@@ -31,6 +31,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/compiler.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 
 #include <linux/sysdev.h>
 #include <asm/io.h>
@@ -2565,3 +2566,47 @@ int io_apic_set_pci_routing (int ioapic,
 }
 
 #endif /*CONFIG_ACPI_BOOT*/
+
+#if defined(CONFIG_SMP) && defined(CONFIG_PCI)
+void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
+{
+	u8 config, rev;
+	u32 word;
+	extern struct pci_raw_ops *raw_pci_ops;
+
+	/* BIOS may enable hardware IRQ balancing for
+	 * E7520/E7320/E7525(revision ID 0x9 and below)
+	 * based platforms.
+	 * Disable SW irqbalance/affinity on those platforms.
+	 */
+	pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);
+	if (rev > 0x9)
+		return;
+
+	printk(KERN_INFO "Intel E7520/7320/7525 detected.");
+
+	/* enable access to config space*/
+	pci_read_config_byte(dev, 0xf4, &config);
+	config |= 0x2;
+	pci_write_config_byte(dev, 0xf4, config);
+
+	/* read xTPR register */
+	raw_pci_ops->read(0, 0, 0x40, 0x4c, 2, &word);
+
+	if (!(word & (1 << 13))) {
+		printk(KERN_INFO "Disabling irq balancing and affinity\n");
+#ifdef CONFIG_IRQBALANCE
+		irqbalance_disable("");
+#endif
+		noirqdebug_setup("");
+		no_irq_affinity = 1;
+	}
+
+	config &= ~0x2;
+	/* disable access to config space*/
+	pci_write_config_byte(dev, 0xf4, config);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_intel_irqbalance);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_intel_irqbalance);
+#endif
+
_

