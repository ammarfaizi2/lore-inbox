Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVKCOvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVKCOvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVKCOvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:51:43 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:202 "EHLO palinux.hppa")
	by vger.kernel.org with ESMTP id S1030239AbVKCOvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:51:42 -0500
Date: Thu, 3 Nov 2005 07:51:41 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103145141.GX23749@parisc-linux.org>
References: <20051103144926.GV23749@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103144926.GV23749@parisc-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce PCI_NO_IRQ and pci_valid_irq()
Explicitly initialise pci_dev->irq with PCI_NO_IRQ, allowing us to change
the value of PCI_NO_IRQ when all drivers have been audited.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

---

 drivers/pci/probe.c |    7 +++++--
 include/linux/pci.h |    9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

applies-to: 734b9ec7d20002b1acdc9f4f7142efa2e5340e0d
bc63ebe08e89a7be876a0538e2c563e2cb1d9617
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fce2cb2..35ba70b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -571,9 +571,12 @@ static void pci_read_irq(struct pci_dev 
 	unsigned char irq;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
-	if (irq)
+	if (irq) {
 		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	dev->irq = irq;
+		dev->irq = irq;
+	} else {
+		dev->irq = PCI_NO_IRQ;
+	}
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3596ac9..4e009e2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -140,6 +140,15 @@ struct pci_dev {
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 };
 
+/*
+ * The PCI subsystem has traditionally filled in 0 when no interrupt has been
+ * assigned.  While we should move to using NO_IRQ instead, many drivers
+ * remain to be converted.  Once all drivers are using PCI_NO_IRQ, switching
+ * over should be a simple search-and-replace.
+ */
+#define PCI_NO_IRQ		0
+#define pci_valid_irq(irq)	(irq != PCI_NO_IRQ)
+
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
 #define pci_dev_b(n) list_entry(n, struct pci_dev, bus_list)
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
---
0.99.8.GIT
