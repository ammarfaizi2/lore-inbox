Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUIUIxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUIUIxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 04:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUIUIwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 04:52:09 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41936 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267535AbUIUIuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 04:50:54 -0400
Date: Tue, 21 Sep 2004 17:52:43 +0900
From: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
Subject: [PATCH] PCI IRQ resource deallocation support [2/3]
To: akpm@osdl.org, greg@kroah.com, len.brown@intel.com, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Message-id: <414FEBDB.2050201@soft.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is ACPI portion of IRQ deallocation. This patch defines the
following new interface. The implementation of this interface depends
on each platform.

    o void acpi_unregister_gsi(int irq)

        This is a opposite portion of acpi_register_gsi(). This has a
        responsibility for deallocating IRQ resources associated with
        the specified linux IRQ number.

        We need to consider the case of shared interrupt. In the case
        of shared interrupt, acpi_register_gsi() is called multiple
        times for one gsi. That is, registrations and unregistrations
        can be nested.

        This function undoes the effect of one call to
        acpi_register_gsi(). If this matches the last registration,
        IRQ resources associated with the specified linux IRQ number
        are freed.

This patch also adds the following new function.

    o void acpi_pci_irq_disable (struct pci_dev *dev)

        This function is a opposite portion of
        acpi_pci_enable_irq(). It clears the device's linux IRQ number
        and calls acpi_unregister_gsi() to deallocate IRQ resources.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.9-rc2-mm1-kanesige/arch/i386/kernel/acpi/boot.c |   11 +++++
 linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/acpi.c      |   11 +++++
 linux-2.6.9-rc2-mm1-kanesige/drivers/acpi/pci_irq.c       |   26 ++++++++++++++
 linux-2.6.9-rc2-mm1-kanesige/include/linux/acpi.h         |    2 +
 4 files changed, 50 insertions(+)

diff -puN arch/i386/kernel/acpi/boot.c~IRQ_deallocation_acpi arch/i386/kernel/acpi/boot.c
--- linux-2.6.9-rc2-mm1/arch/i386/kernel/acpi/boot.c~IRQ_deallocation_acpi	2004-09-21 14:06:20.000000000 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/i386/kernel/acpi/boot.c	2004-09-21 15:23:48.012354914 +0900
@@ -480,6 +480,17 @@ unsigned int acpi_register_gsi(u32 gsi, 
 }
 EXPORT_SYMBOL(acpi_register_gsi);
 
+/*
+ * This function undoes the effect of one call to acpi_register_gsi().
+ * If this matches the last regstration, any IRQ resources for gsi
+ * associated with the irq are freed.
+ */
+void
+acpi_unregister_gsi (unsigned int irq)
+{
+}
+EXPORT_SYMBOL(acpi_unregister_gsi);
+
 static unsigned long __init
 acpi_scan_rsdp (
 	unsigned long		start,
diff -puN arch/ia64/kernel/acpi.c~IRQ_deallocation_acpi arch/ia64/kernel/acpi.c
--- linux-2.6.9-rc2-mm1/arch/ia64/kernel/acpi.c~IRQ_deallocation_acpi	2004-09-21 14:06:20.000000000 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/acpi.c	2004-09-21 15:23:11.218165006 +0900
@@ -516,6 +516,17 @@ acpi_register_gsi (u32 gsi, int edge_lev
 }
 EXPORT_SYMBOL(acpi_register_gsi);
 
+/*
+ * This function undoes the effect of one call to acpi_register_gsi().
+ * If this matches the last regstration, any IRQ resources for gsi
+ * associated with the irq are freed.
+ */
+void
+acpi_unregister_gsi (unsigned int irq)
+{
+}
+EXPORT_SYMBOL(acpi_unregister_gsi);
+
 static int __init
 acpi_parse_fadt (unsigned long phys_addr, unsigned long size)
 {
diff -puN drivers/acpi/pci_irq.c~IRQ_deallocation_acpi drivers/acpi/pci_irq.c
--- linux-2.6.9-rc2-mm1/drivers/acpi/pci_irq.c~IRQ_deallocation_acpi	2004-09-21 14:06:20.000000000 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/drivers/acpi/pci_irq.c	2004-09-21 14:06:20.000000000 +0900
@@ -390,3 +390,29 @@ acpi_pci_irq_enable (
 
 	return_VALUE(dev->irq);
 }
+
+void
+acpi_pci_irq_disable (
+	struct pci_dev		*dev)
+{
+	unsigned char irq_disabled, irq;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_disable");
+
+	irq_disabled = dev->irq;
+
+	/*
+	 * dev->irq is cleared by BIOS-assigned IRQ set during boot.
+	 */
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
+	if (irq)
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+	dev->irq = irq;
+
+	printk(KERN_INFO PREFIX "PCI interrupt for device %s disabled\n",
+	       pci_name(dev));
+
+	acpi_unregister_gsi(irq_disabled);
+
+	return_VOID;
+}
diff -puN include/linux/acpi.h~IRQ_deallocation_acpi include/linux/acpi.h
--- linux-2.6.9-rc2-mm1/include/linux/acpi.h~IRQ_deallocation_acpi	2004-09-21 14:06:20.000000000 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/include/linux/acpi.h	2004-09-21 14:06:20.000000000 +0900
@@ -414,6 +414,7 @@ static inline int acpi_boot_init(void)
 #endif 	/*!CONFIG_ACPI_BOOT*/
 
 unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
+void acpi_unregister_gsi (unsigned int);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
 #ifdef CONFIG_ACPI_PCI
@@ -439,6 +440,7 @@ extern struct acpi_prt_list	acpi_prt;
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
+void acpi_pci_irq_disable (struct pci_dev *dev);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;

_

