Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWJDTcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWJDTcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWJDTcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:32:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:41733 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750897AbWJDTcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:32:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=cwOVxxHvYwhcTcOWZuSqehSh2r2Sts0iAkuvN4iYyxyXhNFVV27bxxI00QETIZR3GQWHNzFeC8im+CKhkz7eVBDFADIUyrAUe9Xpr1R2ZfNdmpqAmfMlTDdRzRuv1JToV8HospEf0JzqbYKazrlzeOi8QqCynwah/bg2RKi7RxU=
Date: Wed, 4 Oct 2006 19:32:29 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, matthew@wil.cx, alan@lxorguk.ukuu.org.uk,
       jeff@garzik.org, akpm@osdl.org, rdunlap@xenotime.net, gregkh@suse.de
Subject: [RFC PATCH] add pci_{request,free}_irq take #3
Message-ID: <20061004193229.GA352@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is take #3 of the "add pci_{request,free}_irq" patch.
The following changes have been made since last proposal:
- add IRQF_SHARED systematically to the flags parameter. This is safe
  even for MSI as seen here: http://lkml.org/lkml/2006/10/4/21
- remove IRQF_SHARED from tg3 and e1000
- s/ARCH_VALIDATE_PCI_IRQ/ARCH_VALIDATE_IRQ/ in
  include/linux/interrupts.h, as the irq line may be tweaked outside
  the pci subsystem in an arch specific way.

I'll send a follow-up patch showing the implied modifications for the
following drivers: aic7xxx, aic79xx, tg3 and e1000.

Please note that I'm not submitting the driver changes, they're there
only for illustration purposes. I'll CC the appropriate maintainers
when/if an API is agreed upon.

Regards,
Frederik

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a544997..50b49ef 100644
 drivers/pci/pci.c         |   42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/interrupt.h |    7 +++++++
 include/linux/pci.h       |    6 ++++++
 3 files changed, 55 insertions(+)

Index: 2.6.18-mm3/drivers/pci/pci.c
===================================================================
--- 2.6.18-mm3.orig/drivers/pci/pci.c
+++ 2.6.18-mm3/drivers/pci/pci.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 #include <linux/string.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
@@ -810,6 +811,47 @@ err_out:
 }
 
 /**
+ * pci_request_irq - Reserve an IRQ for a PCI device
+ * @pdev: The PCI device whose irq is to be reserved
+ * @handler: The interrupt handler function,
+ * @flags: The flags to be passed to request_irq()
+ * @name: The name of the device to be associated with the irq
+ *
+ * Returns 0 on success, or a negative value on error.  A warning
+ * message is also printed on failure.
+ * pci_get_drvdata(pdev) shall be passed as an argument to the @handler
+ * function
+ */
+int pci_request_irq(struct pci_dev *pdev,
+		    irqreturn_t(*handler) (int, void *, struct pt_regs *),
+		    unsigned long flags, const char *name)
+{
+	if (!is_irq_valid(pdev->irq)) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "No usable irq line was found (got #%d)\n",
+			   pdev->irq);
+		return -EINVAL;
+	}
+
+	return request_irq(pdev->irq, handler, flags | IRQF_SHARED,
+			   name ? name : pdev->driver->name,
+			   pci_get_drvdata(pdev));
+}
+EXPORT_SYMBOL(pci_request_irq);
+
+/**
+ * pci_free_irq - Free an IRQ for a PCI device
+ *
+ * @pdev: the PCI device whose interrupt is to be freed
+ * pci_get_drvdata(pdev) is used as the device identifier
+ */
+void pci_free_irq(struct pci_dev *pdev)
+{
+	free_irq(pdev->irq, pci_get_drvdata(pdev));
+}
+EXPORT_SYMBOL(pci_free_irq);
+
+/**
  * pci_set_master - enables bus-mastering for device dev
  * @dev: the PCI device to enable
  *
Index: 2.6.18-mm3/include/linux/interrupt.h
===================================================================
--- 2.6.18-mm3.orig/include/linux/interrupt.h
+++ 2.6.18-mm3/include/linux/interrupt.h
@@ -75,6 +75,13 @@ struct irqaction {
 	struct proc_dir_entry *dir;
 };
 
+#ifndef ARCH_VALIDATE_IRQ
+static inline int is_irq_valid(unsigned int irq)
+{
+	return irq ? 1 : 0;
+}
+#endif /* ARCH_VALIDATE_IRQ */
+
 extern irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs);
 extern int request_irq(unsigned int,
 		       irqreturn_t (*handler)(int, void *, struct pt_regs *),
Index: 2.6.18-mm3/include/linux/pci.h
===================================================================
--- 2.6.18-mm3.orig/include/linux/pci.h
+++ 2.6.18-mm3/include/linux/pci.h
@@ -52,6 +52,7 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
@@ -532,6 +533,11 @@ void pci_release_regions(struct pci_dev 
 int __must_check pci_request_region(struct pci_dev *, int, const char *);
 void pci_release_region(struct pci_dev *, int);
 
+int __must_check pci_request_irq(struct pci_dev *pdev,
+		    irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		    unsigned long flags, const char *name);
+void pci_free_irq(struct pci_dev *pdev);
+
 /* drivers/pci/bus.c */
 int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			struct resource *res, resource_size_t size,
