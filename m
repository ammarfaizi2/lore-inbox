Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVKUBOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVKUBOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVKUBOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:14:48 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:8936 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932159AbVKUBOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:14:22 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz
Message-Id: <E1Ee0Fz-0004CJ-Vg@localhost.localdomain>
Date: Sun, 20 Nov 2005 20:14:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH 2/5] Introduce PCI_NO_IRQ and pci_valid_irq()

Explicitly initialise pci_dev->irq with PCI_NO_IRQ, allowing us to change
the value of PCI_NO_IRQ once all drivers have been audited.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 drivers/pci/probe.c |    7 +++++--
 include/linux/pci.h |    9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

applies-to: 48ad7d3f9b055a9d4c1a1ab1f6dd0a584cfed99c
53424f050aff8200f80f4d3edf9af7b7f085e6f6
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
index de690ca..69cdd00 100644
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
