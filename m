Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbULGHVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbULGHVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 02:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbULGHVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 02:21:18 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:1951 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261735AbULGHUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 02:20:44 -0500
Message-ID: <41B559E1.8050401@jp.fujitsu.com>
Date: Tue, 07 Dec 2004 16:21:05 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: [PATCH] IRQ resource deallocation [1/2]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is ACPI portion of IRQ resource deallocation.


----
Kernel Version:	2.6.10-rc3
Depends:	none
Description:

This patch is ACPI portion of IRQ deallocation. This patch defines the
following new interface. The implementation of this interface depends
on each platform.

    o void acpi_unregister_gsi(u32 gsi)

        This is a opposite portion of acpi_register_gsi(). This has a
        responsibility for deallocating IRQ resources associated with
        the specified GSI number.

        We need to consider the case of shared interrupt. In the case
        of shared interrupt, acpi_register_gsi() is called multiple
        times for one gsi. That is, registrations and unregistrations
        can be nested.

        This function undoes the effect of one call to
        acpi_register_gsi(). If this matches the last registration,
        IRQ resources associated with the specified GSI number are
        freed.

This patch also adds the following new function.

    o void acpi_pci_irq_disable (struct pci_dev *dev)

        This function is a opposite portion of
        acpi_pci_enable_irq(). It clears the device's linux IRQ number
        and calls acpi_unregister_gsi() to deallocate IRQ resources.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.10-rc3-kanesige/drivers/acpi/pci_irq.c |   52 +++++++++++++++++++++++
 linux-2.6.10-rc3-kanesige/include/linux/acpi.h   |   13 +++++
 2 files changed, 65 insertions(+)

diff -puN drivers/acpi/pci_irq.c~IRQ_deallocation_acpi drivers/acpi/pci_irq.c
--- linux-2.6.10-rc3/drivers/acpi/pci_irq.c~IRQ_deallocation_acpi	2004-12-06 19:51:50.274759676 +0900
+++ linux-2.6.10-rc3-kanesige/drivers/acpi/pci_irq.c	2004-12-06 19:54:43.254430880 +0900
@@ -407,3 +407,55 @@ acpi_pci_irq_enable (
 }
 EXPORT_SYMBOL(acpi_pci_irq_enable);
 
+
+#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
+void
+acpi_pci_irq_disable (
+	struct pci_dev		*dev)
+{
+	u32			gsi = 0;
+	u8			pin = 0;
+	int			edge_level = ACPI_LEVEL_SENSITIVE;
+	int			active_high_low = ACPI_ACTIVE_LOW;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_disable");
+
+	if (!dev)
+		return_VOID;
+	
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	if (!pin)
+		return_VOID;
+	pin--;
+
+	if (!dev->bus)
+		return_VOID;
+
+	/* 
+	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
+	 */
+ 	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+				  &edge_level, &active_high_low);
+	/*
+	 * If no PRT entry was found, we'll try to derive an IRQ from the
+	 * device's parent bridge.
+	 */
+	if (!gsi)
+ 		gsi = acpi_pci_irq_derive(dev, pin,
+					  &edge_level, &active_high_low);
+	if (!gsi)
+		return_VOID;
+
+	/*
+	 * TBD: It might be worth clearing dev->irq by magic constant
+	 * (e.g. PCI_UNDEFINED_IRQ).
+	 */
+
+	printk(KERN_INFO PREFIX "PCI interrupt for device %s disabled\n",
+	       pci_name(dev));
+
+	acpi_unregister_gsi(gsi);
+
+	return_VOID;
+}
+#endif /* CONFIG_ACPI_DEALLOCATE_IRQ */
diff -puN include/linux/acpi.h~IRQ_deallocation_acpi include/linux/acpi.h
--- linux-2.6.10-rc3/include/linux/acpi.h~IRQ_deallocation_acpi	2004-12-06 19:51:50.276712814 +0900
+++ linux-2.6.10-rc3-kanesige/include/linux/acpi.h	2004-12-06 19:51:50.279642521 +0900
@@ -416,6 +416,15 @@ static inline int acpi_boot_init(void)
 unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
+/*
+ * This function undoes the effect of one call to acpi_register_gsi().
+ * If this matches the last registration, any IRQ resources for gsi
+ * are freed.
+ */
+#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
+void acpi_unregister_gsi (u32 gsi);
+#endif
+
 #ifdef CONFIG_ACPI_PCI
 
 struct acpi_prt_entry {
@@ -441,6 +450,10 @@ struct pci_dev;
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq);
 
+#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
+void acpi_pci_irq_disable (struct pci_dev *dev);
+#endif
+
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;
 	int (*add)(acpi_handle handle);

_

