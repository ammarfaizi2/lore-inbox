Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUI1VOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUI1VOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUI1VOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:14:14 -0400
Received: from fmr04.intel.com ([143.183.121.6]:52360 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S267968AbUI1VMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:12:18 -0400
Date: Tue, 28 Sep 2004 14:11:57 -0700
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: akpm@osdl.org
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, asit.k.mallick@intel.com,
       Andi Kleen <ak@suse.de>
Subject: Re: [Patch 0/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
Message-ID: <20040928141157.D18131@unix-os.sc.intel.com>
References: <20040923233410.A19555@unix-os.sc.intel.com> <Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com> <4154828F.6090205@pobox.com> <20040924152026.A25742@unix-os.sc.intel.com> <Pine.LNX.4.53.0409251206120.2914@musoma.fsmlabs.com> <20040927110350.C18131@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040927110350.C18131@unix-os.sc.intel.com>; from suresh.b.siddha@intel.com on Mon, Sep 27, 2004 at 11:03:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 11:03:51AM -0700, Suresh Siddha wrote:
> As far as irq_affinity is concerned, workaround fits nicely in quirks.c
> infrastructure.
> 
> x86 irqbalance is the one which is causing the pain. Workaround will be more
> cleaner if we can move balanced_irq_init() to late_initcall.
> 
> If there is no objection, I can post a new patch with that change.

Here is a new patch. Andrew please apply.

thanks,
suresh

--

As part of the workaround for the "Interrupt message re-ordering across
hub interface" errata (page #16 in
http://developer.intel.com/design/chipsets/specupdt/30288402.pdf),
BIOS may enable hardware IRQ balancing for E7520/E7320/E7525(revision ID
0x9 and below) based platforms.

Add pci quirks to disable SW irqbalance/affinity on those platforms.
Move balanced_irq_init() to late_initcall so that kirqd will be started 
after pci quirks.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -Nru linux-2.6.9-rc2/arch/i386/kernel/io_apic.c linux-irq/arch/i386/kernel/io_apic.c
--- linux-2.6.9-rc2/arch/i386/kernel/io_apic.c	2004-09-12 22:32:00.000000000 -0700
+++ linux-irq/arch/i386/kernel/io_apic.c	2004-09-08 09:51:56.000000000 -0700
@@ -636,7 +636,7 @@
 	return 0;
 }
 
-static int __init irqbalance_disable(char *str)
+int __init irqbalance_disable(char *str)
 {
 	irqbalance_disabled = 1;
 	return 0;
@@ -653,7 +653,7 @@
 	}
 }
 
-__initcall(balanced_irq_init);
+late_initcall(balanced_irq_init);
 
 #else /* !CONFIG_IRQBALANCE */
 static inline void move_irq(int irq) { }
diff -Nru linux-2.6.9-rc2/arch/i386/kernel/irq.c linux-irq/arch/i386/kernel/irq.c
--- linux-2.6.9-rc2/arch/i386/kernel/irq.c	2004-09-12 22:31:30.000000000 -0700
+++ linux-irq/arch/i386/kernel/irq.c	2004-09-08 09:28:35.000000000 -0700
@@ -272,7 +272,7 @@
 
 static int noirqdebug;
 
-static int __init noirqdebug_setup(char *str)
+int __init noirqdebug_setup(char *str)
 {
 	noirqdebug = 1;
 	printk("IRQ lockup detection disabled\n");
@@ -997,13 +997,15 @@
 	return len;
 }
 
+int no_irq_affinity;
+
 static int irq_affinity_write_proc(struct file *file, const char __user *buffer,
 					unsigned long count, void *data)
 {
 	int irq = (long)data, full_count = count, err;
 	cpumask_t new_value, tmp;
 
-	if (!irq_desc[irq].handler->set_affinity)
+	if (!irq_desc[irq].handler->set_affinity || no_irq_affinity)
 		return -EIO;
 
 	err = cpumask_parse(buffer, count, new_value);
diff -Nru linux-2.6.9-rc2/arch/x86_64/kernel/irq.c linux-irq/arch/x86_64/kernel/irq.c
--- linux-2.6.9-rc2/arch/x86_64/kernel/irq.c	2004-09-12 22:32:26.000000000 -0700
+++ linux-irq/arch/x86_64/kernel/irq.c	2004-09-08 09:28:35.000000000 -0700
@@ -835,6 +835,8 @@
 	return len;
 }
 
+int no_irq_affinity;
+
 static int irq_affinity_write_proc (struct file *file,
 					const char __user *buffer,
 					unsigned long count, void *data)
@@ -842,7 +844,7 @@
 	int irq = (long) data, full_count = count, err;
 	cpumask_t tmp, new_value;
 
-	if (!irq_desc[irq].handler->set_affinity)
+	if (!irq_desc[irq].handler->set_affinity || no_irq_affinity)
 		return -EIO;
 
 	err = cpumask_parse(buffer, count, new_value);
diff -Nru linux-2.6.9-rc2/drivers/pci/quirks.c linux-irq/drivers/pci/quirks.c
--- linux-2.6.9-rc2/drivers/pci/quirks.c	2004-09-12 22:31:27.000000000 -0700
+++ linux-irq/drivers/pci/quirks.c	2004-09-08 18:20:59.794026624 -0700
@@ -814,6 +814,55 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
 
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
+#include <asm/hw_irq.h>
+#ifdef CONFIG_IRQBALANCE
+extern int irqbalance_disable(char *str);
+#endif
+extern int no_irq_affinity;
+extern int noirqdebug_setup(char *str);
+
+
+void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
+{
+	u8 config, rev;
+	u32 word;
+	extern struct pci_raw_ops *raw_pci_ops;
+
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
+#ifdef __i386__
+#ifdef CONFIG_IRQBALANCE
+		irqbalance_disable("");
+#endif
+		noirqdebug_setup("");
+#endif
+		no_irq_affinity = 1;
+	}
+
+	config &= ~0x2;
+	/* disable access to config space*/
+	pci_write_config_byte(dev, 0xf4, config);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_SMCH,	quirk_intel_irqbalance);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_intel_irqbalance);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_intel_irqbalance);
+#endif
+
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
  */
diff -Nru linux-2.6.9-rc2/include/linux/pci_ids.h linux-irq/include/linux/pci_ids.h
--- linux-2.6.9-rc2/include/linux/pci_ids.h	2004-09-12 22:33:54.000000000 -0700
+++ linux-irq/include/linux/pci_ids.h	2004-09-08 09:28:35.000000000 -0700
@@ -2204,6 +2204,8 @@
 #define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
 #define PCI_DEVICE_ID_INTEL_82855GM_IG	0x3582
 #define PCI_DEVICE_ID_INTEL_SMCH	0x3590
+#define PCI_DEVICE_ID_INTEL_E7320_MCH	0x3592
+#define PCI_DEVICE_ID_INTEL_E7525_MCH	0x359e
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
