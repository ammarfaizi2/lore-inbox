Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbWJBSCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbWJBSCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbWJBSCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:02:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:34126 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965203AbWJBSCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:02:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=tpyTY31IXiNXeX8zjIREASO+W3RfZSq9zwDEpwhKm6qUyX3f723iesc+mIoumQqS6KUcE8TzySzxf2ygnJIhgzc4HxlcDHC4OaUFDtW8O3MAFKFiVuDh8gtTNx8bnrU4CYdNyNZENPZiQZxOJl2k2Dv1qa8sVLrkxHbTEq8b/pQ=
Date: Mon, 2 Oct 2006 20:00:48 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: [RFC PATCH] pci_request_irq (was [-mm patch] aic7xxx: check irq validity)
Message-ID: <20061002200048.GC3003@slug>
References: <20060929143949.GL5017@parisc-linux.org> <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159755141.2891.434.camel@laptopd505.fenrus.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've tried to summarize the different proposals made by Jeff Garzik,
Matthew Wilcox and Arjan van de Ven in the "[-mm patch] aic7xxx: check
irq validity" thread. I've also added:
- some kerneldoc
- renamed valid_irq to is_irq_valid() 
- added pci_release_irq(). 

I'll send a follow-up patch showing the implied modifications for the
following - semi-randomly chosen :) - drivers: aic7xxx, aic79xx, tg3
and drm.

Regards,
Frederik

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a544997..ae20a3a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -15,6 +15,7 @@ #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 #include <linux/string.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
@@ -810,6 +811,49 @@ err_out:
 }
 
 /**
+ * pci_request_irq - Reserve an IRQ for a PCI device
+ * @pdev: The PCI device whose irq is to be reserved
+ * handler: The interrupt handler function,
+ * pci_get_drvdata(pdev) shall be passed as an argument to that function
+ * @flags: The flags to be passed to request_irq()
+ * @name: The name of the device to be associated with the irq
+ *
+ * Returns 0 on success, or a negative value on error.  A warning
+ * message is also printed on failure.
+ */
+int pci_request_irq(struct pci_dev *pdev,
+		    irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		    unsigned long flags, const char *name)
+{
+	int rc;
+	const char *actual_name = name;
+
+	rc = is_irq_valid(pdev->irq);
+	if (!rc) {
+		dev_printk(KERN_ERR, &pdev->dev, "invalid irq #%d\n", pdev->irq);
+		return -EINVAL;
+	}
+
+	if (!actual_name)
+		actual_name = pci_name(pdev);
+
+	return request_irq(pdev->irq, handler, flags | IRQF_SHARED,
+			   actual_name, pci_get_drvdata(pdev));
+}
+EXPORT_SYMBOL(pci_request_irq);
+
+/**
+ * pci_free_irq - releases the interrupt line reserved to the PCI
+ * device pointed by @pdev 
+ * @pdev: the PCI device whose interrupt is to be freed
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
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1f97e3d..c320b50 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -75,6 +75,13 @@ struct irqaction {
 	struct proc_dir_entry *dir;
 };
 
+#ifndef ARCH_VALIDATE_PCI_IRQ
+static inline int is_irq_valid(unsigned int irq)
+{
+	return irq ? 1 : 0;
+}
+#endif /* ARCH_VALIDATE_PCI_IRQ */
+
 extern irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs);
 extern int request_irq(unsigned int,
 		       irqreturn_t (*handler)(int, void *, struct pt_regs *),
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5bc4659..5e0f07a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,6 +52,7 @@ #include <linux/list.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
@@ -531,6 +532,11 @@ void pci_release_regions(struct pci_dev 
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
