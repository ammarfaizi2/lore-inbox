Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUJDKTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUJDKTp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 06:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUJDKTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 06:19:32 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35787 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267963AbUJDKQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 06:16:08 -0400
Date: Mon, 04 Oct 2004 19:17:50 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: take2: [Patch 2/3] Updated patches for PCI IRQ deallocation support
To: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>
Cc: Greg KH <greg@kroah.com>, "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
Message-id: <4161234E.2070805@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew and Len,

This is a patch for ACPI code that has no dependencies. [patch 3/3]
is waiting for this patch to be applied because [patch 3/3] depends
on this patch.

Please apply.

Thanks,
Kenji Kaneshige

----
Name:		IRQ_deallocation_acpi.patch
Kernel Version:	2.6.9-rc3
Depends:	none
Change Log:

    - Ported to 2.6.9-rc3

    - Moved the definition of acpi_unregister_gsi() from .c file into
      arch specific header files.

    - Changed acpi_pci_irq_disable() not to call acpi_unregister_gsi()
      if the device dev doesn't use I/O xAPIC interrupt. With this
      change, the argument of acpi_unregister_gsi() interface was
      changed from Linux IRQ number to GSI number.

Change Log:

    - Changed acpi_pci_irq_disable() to leave 'dev->irq' as it
      is. Clearing 'dev->irq' by some magic constant
      (e.g. PCI_UNDEFINED_IRQ) is TBD.

Change Log:

    - Fixed some typos in comments.

    - Changed 'unsigned char irq_disabled' to 'unsigned int
      irq_disabled' because pci_dev.irq is unsigned int.

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

 linux-2.6.9-rc3-kanesige/drivers/acpi/pci_irq.c    |   50 +++++++++++++++++++++
 linux-2.6.9-rc3-kanesige/include/asm-i386/acpi.h   |    7 ++
 linux-2.6.9-rc3-kanesige/include/asm-ia64/acpi.h   |    7 ++
 linux-2.6.9-rc3-kanesige/include/asm-x86_64/acpi.h |    7 ++
 linux-2.6.9-rc3-kanesige/include/linux/acpi.h      |    1 
 5 files changed, 72 insertions(+)

diff -puN drivers/acpi/pci_irq.c~IRQ_deallocation_acpi drivers/acpi/pci_irq.c
--- linux-2.6.9-rc3/drivers/acpi/pci_irq.c~IRQ_deallocation_acpi	2004-10-04 17:03:36.308279299 +0900
+++ linux-2.6.9-rc3-kanesige/drivers/acpi/pci_irq.c	2004-10-04 17:03:36.317068410 +0900
@@ -390,3 +390,53 @@ acpi_pci_irq_enable (
 
 	return_VALUE(dev->irq);
 }
+
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
diff -puN include/asm-i386/acpi.h~IRQ_deallocation_acpi include/asm-i386/acpi.h
--- linux-2.6.9-rc3/include/asm-i386/acpi.h~IRQ_deallocation_acpi	2004-10-04 17:03:36.310232434 +0900
+++ linux-2.6.9-rc3-kanesige/include/asm-i386/acpi.h	2004-10-04 17:03:36.318044978 +0900
@@ -191,6 +191,13 @@ extern void acpi_reserve_bootmem(void);
 
 extern u8 x86_acpiid_to_apicid[];
 
+/*
+ * This function undoes the effect of one call to acpi_register_gsi().
+ * If this matches the last registration, any IRQ resources for gsi
+ * are freed.
+ */
+static inline void acpi_unregister_gsi (u32 gsi) { }
+
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/
diff -puN include/asm-ia64/acpi.h~IRQ_deallocation_acpi include/asm-ia64/acpi.h
--- linux-2.6.9-rc3/include/asm-ia64/acpi.h~IRQ_deallocation_acpi	2004-10-04 17:03:36.312185570 +0900
+++ linux-2.6.9-rc3-kanesige/include/asm-ia64/acpi.h	2004-10-04 17:03:36.318044978 +0900
@@ -107,6 +107,13 @@ extern int __initdata nid_to_pxm_map[MAX
 
 extern u16 ia64_acpiid_to_sapicid[];
 
+/*
+ * This function undoes the effect of one call to acpi_register_gsi().
+ * If this matches the last registration, any IRQ resources for gsi
+ * are freed.
+ */
+static inline void acpi_unregister_gsi (u32 gsi) { }
+
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/
diff -puN include/asm-x86_64/acpi.h~IRQ_deallocation_acpi include/asm-x86_64/acpi.h
--- linux-2.6.9-rc3/include/asm-x86_64/acpi.h~IRQ_deallocation_acpi	2004-10-04 17:03:36.313162138 +0900
+++ linux-2.6.9-rc3-kanesige/include/asm-x86_64/acpi.h	2004-10-04 17:03:36.318044978 +0900
@@ -166,6 +166,13 @@ extern int acpi_pci_disabled;
 
 extern u8 x86_acpiid_to_apicid[];
 
+/*
+ * This function undoes the effect of one call to acpi_register_gsi().
+ * If this matches the last registration, any IRQ resources for gsi
+ * are freed.
+ */
+static inline void acpi_unregister_gsi (u32 gsi) { }
+
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/
diff -puN include/linux/acpi.h~IRQ_deallocation_acpi include/linux/acpi.h
--- linux-2.6.9-rc3/include/linux/acpi.h~IRQ_deallocation_acpi	2004-10-04 17:03:36.315115274 +0900
+++ linux-2.6.9-rc3-kanesige/include/linux/acpi.h	2004-10-04 17:03:36.319021546 +0900
@@ -439,6 +439,7 @@ extern struct acpi_prt_list	acpi_prt;
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
+void acpi_pci_irq_disable (struct pci_dev *dev);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;

_

