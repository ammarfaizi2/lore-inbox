Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUIXWVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUIXWVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269023AbUIXWVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:21:36 -0400
Received: from fmr04.intel.com ([143.183.121.6]:23006 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269022AbUIXWUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:20:46 -0400
Date: Fri, 24 Sep 2004 15:20:27 -0700
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Zwane Mwaikambo <zwane@fsmlabs.com>,
       Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org,
       asit.k.mallick@intel.com
Subject: Re: [Patch 0/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
Message-ID: <20040924152026.A25742@unix-os.sc.intel.com>
References: <20040923233410.A19555@unix-os.sc.intel.com> <Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com> <4154828F.6090205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4154828F.6090205@pobox.com>; from jgarzik@pobox.com on Fri, Sep 24, 2004 at 04:24:47PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 04:24:47PM -0400, Jeff Garzik wrote:
> Zwane Mwaikambo wrote:
> > On Thu, 23 Sep 2004, Suresh Siddha wrote:
> > 
> > 
> >>As part of the workaround for the "Interrupt message re-ordering across
> >>hub interface" errata (page #16 in
> >>http://developer.intel.com/design/chipsets/specupdt/30288402.pdf),
> >>BIOS may enable hardware IRQ balancing for Lindenhurst/Tumwater based chipset
> >>platforms. Software based irq_balance/irq_affinity should be disabled if
> >>hardware IRQ balancing is enabled.
> > 
> > 
> > Can we avoid those tests? Like not starting the irq balancer code at all 
> > with those chipsets?
> 
> 
> That's my preference.
> 

Ok. How about this patch?

Add pci quirks to disable irqbalance/affinity for E7520/E7320/E7525
with revision ID 0x09 and below.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -Nru linux-2.6.9-rc2/arch/i386/kernel/io_apic.c linux-irq/arch/i386/kernel/io_apic.c
--- linux-2.6.9-rc2/arch/i386/kernel/io_apic.c	2004-09-12 22:32:00.000000000 -0700
+++ linux-irq/arch/i386/kernel/io_apic.c	2004-09-04 12:12:42.499670496 -0700
@@ -31,6 +31,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/compiler.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 
 #include <linux/sysdev.h>
 #include <asm/io.h>
@@ -260,7 +261,7 @@
 cpumask_t __cacheline_aligned pending_irq_balance_cpumask[NR_IRQS];
 
 #define IRQBALANCE_CHECK_ARCH -999
-static int irqbalance_disabled = IRQBALANCE_CHECK_ARCH;
+int irqbalance_disabled = IRQBALANCE_CHECK_ARCH;
 static int physical_balance = 0;
 
 struct irq_cpu_info {
@@ -582,6 +583,30 @@
 	return 0;
 }
 
+/* HW irqbalance may be enabled for E7520/E7320/E7525 with revision ID 
+ * 0x09 and below. Disable sw irqbalance in that case
+ */
+static void check_hw_irqbalance(void)
+{
+	struct pci_dev *dev = NULL;
+	extern void quirk_intel_irqbalance(struct pci_dev *dev);
+
+	dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SMCH, 
+			      dev);
+	if (!dev)
+		dev = pci_find_device(PCI_VENDOR_ID_INTEL, 
+				      PCI_DEVICE_ID_INTEL_E7320_MCH, dev);
+	if (!dev)
+		dev = pci_find_device(PCI_VENDOR_ID_INTEL, 
+				      PCI_DEVICE_ID_INTEL_E7525_MCH, dev);
+	if (!dev)
+		return;
+
+	quirk_intel_irqbalance(dev);
+
+	return;	
+}
+
 static int __init balanced_irq_init(void)
 {
 	int i;
@@ -590,6 +615,8 @@
 
 	cpus_shift_right(tmp, cpu_online_map, 2);
         c = &boot_cpu_data;
+
+	check_hw_irqbalance();
 	/* When not overwritten by the command line ask subarchitecture. */
 	if (irqbalance_disabled == IRQBALANCE_CHECK_ARCH)
 		irqbalance_disabled = NO_BALANCE_IRQ;
@@ -636,7 +663,7 @@
 	return 0;
 }
 
-static int __init irqbalance_disable(char *str)
+int __init irqbalance_disable(char *str)
 {
 	irqbalance_disabled = 1;
 	return 0;
diff -Nru linux-2.6.9-rc2/arch/i386/kernel/irq.c linux-irq/arch/i386/kernel/irq.c
--- linux-2.6.9-rc2/arch/i386/kernel/irq.c	2004-09-12 22:31:30.000000000 -0700
+++ linux-irq/arch/i386/kernel/irq.c	2004-09-04 11:48:21.000000000 -0700
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
+++ linux-irq/arch/x86_64/kernel/irq.c	2004-09-04 11:48:23.000000000 -0700
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
+++ linux-irq/drivers/pci/quirks.c	2004-09-04 12:33:54.373316312 -0700
@@ -814,6 +814,64 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
 
+#ifdef CONFIG_X86_IO_APIC
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
+#ifdef CONFIG_IRQBALANCE
+	extern int irqbalance_disabled;
+
+	/* we might have come through check_hw_irqbalance()
+	 * and enabled the workaround
+	 */
+	if (irqbalance_disabled == 1 && no_irq_affinity)
+		return;
+#endif
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
+++ linux-irq/include/linux/pci_ids.h	2004-09-04 11:48:26.000000000 -0700
@@ -2204,6 +2204,8 @@
 #define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
 #define PCI_DEVICE_ID_INTEL_82855GM_IG	0x3582
 #define PCI_DEVICE_ID_INTEL_SMCH	0x3590
+#define PCI_DEVICE_ID_INTEL_E7320_MCH	0x3592
+#define PCI_DEVICE_ID_INTEL_E7525_MCH	0x359e
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
