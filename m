Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270219AbUJTF4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270219AbUJTF4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 01:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270197AbUJSXbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:31:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:12426 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270142AbUJSWqf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:35 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257364148@kroah.com>
Date: Tue, 19 Oct 2004 15:42:16 -0700
Message-Id: <10982257361528@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.31, 2004/10/06 12:51:33-07:00, greg@kroah.com

[PATCH] PCI: fix __iomem * warnings for PCI msi core code.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/msi.c |   20 ++++++++++----------
 drivers/pci/msi.h |    2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)


diff -Nru a/drivers/pci/msi.c b/drivers/pci/msi.c
--- a/drivers/pci/msi.c	2004-10-19 15:24:58 -07:00
+++ b/drivers/pci/msi.c	2004-10-19 15:24:58 -07:00
@@ -66,7 +66,7 @@
 		int		pos;
 		u32		mask_bits;
 
-		pos = entry->mask_base;
+		pos = (int)entry->mask_base;
 		pci_read_config_dword(entry->dev, pos, &mask_bits);
 		mask_bits &= ~(1);
 		mask_bits |= flag;
@@ -548,7 +548,7 @@
 	dev->irq = vector;
 	entry->dev = dev;
 	if (is_mask_bit_support(control)) {
-		entry->mask_base = msi_mask_bits_reg(pos,
+		entry->mask_base = (void __iomem *)msi_mask_bits_reg(pos,
 				is_64bit_address(control));
 	}
 	/* Replace with MSI handler */
@@ -606,7 +606,7 @@
 	u32 phys_addr, table_offset;
  	u16 control;
 	u8 bir;
-	void *base;
+	void __iomem *base;
 
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	/* Request & Map MSI-X table region */
@@ -642,7 +642,7 @@
 		entry->msi_attrib.maskbit = 1;
 		entry->msi_attrib.default_vector = dev->irq;
 		entry->dev = dev;
-		entry->mask_base = (unsigned long)base;
+		entry->mask_base = base;
 		if (!head) {
 			entry->link.head = vector;
 			entry->link.tail = vector;
@@ -806,7 +806,7 @@
 {
 	struct msi_desc *entry;
 	int head, entry_nr, type;
-	unsigned long base = 0L;
+	void __iomem *base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
@@ -857,7 +857,7 @@
 			phys_addr = pci_resource_start (dev, bir);
 			phys_addr += (u32)(table_offset &
 				~PCI_MSIX_FLAGS_BIRMASK);
-			iounmap((void*)base);
+			iounmap(base);
 			release_mem_region(phys_addr,
 				nr_entries * PCI_MSIX_ENTRY_SIZE);
 		}
@@ -869,8 +869,8 @@
 static int reroute_msix_table(int head, struct msix_entry *entries, int *nvec)
 {
 	int vector = head, tail = 0;
-	int i = 0, j = 0, nr_entries = 0;
-	unsigned long base = 0L;
+	int i, j = 0, nr_entries = 0;
+	void __iomem *base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
@@ -1099,7 +1099,7 @@
    	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) > 0 &&
 		!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
 		int vector, head, tail = 0, warning = 0;
-		unsigned long base = 0L;
+		void __iomem *base = NULL;
 
 		vector = head = dev->irq;
 		while (head != tail) {
@@ -1129,7 +1129,7 @@
 			phys_addr = pci_resource_start (dev, bir);
 			phys_addr += (u32)(table_offset &
 				~PCI_MSIX_FLAGS_BIRMASK);
-			iounmap((void*)base);
+			iounmap(base);
 			release_mem_region(phys_addr, PCI_MSIX_ENTRY_SIZE *
 				multi_msix_capable(control));
 			printk(KERN_DEBUG "Driver[%d:%d:%d] unloaded wo doing free_irq on all vectors\n",
diff -Nru a/drivers/pci/msi.h b/drivers/pci/msi.h
--- a/drivers/pci/msi.h	2004-10-19 15:24:58 -07:00
+++ b/drivers/pci/msi.h	2004-10-19 15:24:58 -07:00
@@ -152,7 +152,7 @@
 		__u16	tail;
 	}link;
 
-	unsigned long mask_base;
+	void __iomem *mask_base;
 	struct pci_dev *dev;
 };
 

