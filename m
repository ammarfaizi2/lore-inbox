Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030779AbWI0UdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030779AbWI0UdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030778AbWI0Ucv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:32:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37100 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030777AbWI0Ucs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:32:48 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/5] msi: Simplify msi sanity checks by adding with generic irq code.
Date: Wed, 27 Sep 2006 14:31:22 -0600
Message-Id: <11593890863331-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <<m11wpxm4sy.fsf@ebiederm.dsl.xmission.com>
References: <<m11wpxm4sy.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently msi.c is doing sanity checks that make certain before
an irq is destroyed it has no more users.

By adding irq_has_action I can perform the test is a generic way, instead
of relying on a msi specific data structure.

By performing the core check in dynamic_irq_cleanup I ensure every user
of dynamic irqs has a test present and we don't free resources that are
in use.

In msi.c this allows me to kill the attrib.state member of msi_desc and
all of the assciated code to maintain it.

To keep from freeing data structures when irq cleanup code is called to
soon changing dyanamic_irq_cleanup is insufficient because there are
msi specific data structures that are also not safe to free.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi.c   |   43 ++++++++-----------------------------------
 drivers/pci/msi.h   |    2 +-
 include/linux/irq.h |    7 +++++++
 kernel/irq/chip.c   |    7 +++++++
 4 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index da2c6c2..e3ba396 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -188,18 +188,6 @@ static void unmask_MSI_irq(unsigned int 
 
 static unsigned int startup_msi_irq_wo_maskbit(unsigned int irq)
 {
-	struct msi_desc *entry;
-	unsigned long flags;
-
-	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[irq];
-	if (!entry || !entry->dev) {
-		spin_unlock_irqrestore(&msi_lock, flags);
-		return 0;
-	}
-	entry->msi_attrib.state = 1;	/* Mark it active */
-	spin_unlock_irqrestore(&msi_lock, flags);
-
 	return 0;	/* never anything pending */
 }
 
@@ -212,14 +200,6 @@ static unsigned int startup_msi_irq_w_ma
 
 static void shutdown_msi_irq(unsigned int irq)
 {
-	struct msi_desc *entry;
-	unsigned long flags;
-
-	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[irq];
-	if (entry && entry->dev)
-		entry->msi_attrib.state = 0;	/* Mark it not active */
-	spin_unlock_irqrestore(&msi_lock, flags);
 }
 
 static void end_msi_irq_wo_maskbit(unsigned int irq)
@@ -671,7 +651,6 @@ static int msi_capability_init(struct pc
 	entry->link.head = irq;
 	entry->link.tail = irq;
 	entry->msi_attrib.type = PCI_CAP_ID_MSI;
-	entry->msi_attrib.state = 0;			/* Mark it not active */
 	entry->msi_attrib.is_64 = is_64bit_address(control);
 	entry->msi_attrib.entry_nr = 0;
 	entry->msi_attrib.maskbit = is_mask_bit_support(control);
@@ -744,7 +723,6 @@ static int msix_capability_init(struct p
  		j = entries[i].entry;
  		entries[i].vector = irq;
 		entry->msi_attrib.type = PCI_CAP_ID_MSIX;
- 		entry->msi_attrib.state = 0;		/* Mark it not active */
 		entry->msi_attrib.is_64 = 1;
 		entry->msi_attrib.entry_nr = j;
 		entry->msi_attrib.maskbit = 1;
@@ -897,12 +875,12 @@ void pci_disable_msi(struct pci_dev* dev
 		spin_unlock_irqrestore(&msi_lock, flags);
 		return;
 	}
-	if (entry->msi_attrib.state) {
+	if (irq_has_action(dev->irq)) {
 		spin_unlock_irqrestore(&msi_lock, flags);
 		printk(KERN_WARNING "PCI: %s: pci_disable_msi() called without "
 		       "free_irq() on MSI irq %d\n",
 		       pci_name(dev), dev->irq);
-		BUG_ON(entry->msi_attrib.state > 0);
+		BUG_ON(irq_has_action(dev->irq));
 	} else {
 		default_irq = entry->msi_attrib.default_irq;
 		spin_unlock_irqrestore(&msi_lock, flags);
@@ -1035,17 +1013,16 @@ void pci_disable_msix(struct pci_dev* de
 
 	temp = dev->irq;
 	if (!msi_lookup_irq(dev, PCI_CAP_ID_MSIX)) {
-		int state, irq, head, tail = 0, warning = 0;
+		int irq, head, tail = 0, warning = 0;
 		unsigned long flags;
 
 		irq = head = dev->irq;
 		dev->irq = temp;			/* Restore pin IRQ */
 		while (head != tail) {
 			spin_lock_irqsave(&msi_lock, flags);
-			state = msi_desc[irq]->msi_attrib.state;
 			tail = msi_desc[irq]->link.tail;
 			spin_unlock_irqrestore(&msi_lock, flags);
-			if (state)
+			if (irq_has_action(irq))
 				warning = 1;
 			else if (irq != head)	/* Release MSI-X irq */
 				msi_free_irq(dev, irq);
@@ -1072,7 +1049,7 @@ void pci_disable_msix(struct pci_dev* de
  **/
 void msi_remove_pci_irq_vectors(struct pci_dev* dev)
 {
-	int state, pos, temp;
+	int pos, temp;
 	unsigned long flags;
 
 	if (!pci_msi_enable || !dev)
@@ -1081,14 +1058,11 @@ void msi_remove_pci_irq_vectors(struct p
 	temp = dev->irq;		/* Save IOAPIC IRQ */
 	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
 	if (pos > 0 && !msi_lookup_irq(dev, PCI_CAP_ID_MSI)) {
-		spin_lock_irqsave(&msi_lock, flags);
-		state = msi_desc[dev->irq]->msi_attrib.state;
-		spin_unlock_irqrestore(&msi_lock, flags);
-		if (state) {
+		if (irq_has_action(dev->irq)) {
 			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
 			       "called without free_irq() on MSI irq %d\n",
 			       pci_name(dev), dev->irq);
-			BUG_ON(state > 0);
+			BUG_ON(irq_has_action(dev->irq));
 		} else /* Release MSI irq assigned to this device */
 			msi_free_irq(dev, dev->irq);
 		dev->irq = temp;		/* Restore IOAPIC IRQ */
@@ -1101,11 +1075,10 @@ void msi_remove_pci_irq_vectors(struct p
 		irq = head = dev->irq;
 		while (head != tail) {
 			spin_lock_irqsave(&msi_lock, flags);
-			state = msi_desc[irq]->msi_attrib.state;
 			tail = msi_desc[irq]->link.tail;
 			base = msi_desc[irq]->mask_base;
 			spin_unlock_irqrestore(&msi_lock, flags);
-			if (state)
+			if (irq_has_action(irq))
 				warning = 1;
 			else if (irq != head) /* Release MSI-X irq */
 				msi_free_irq(dev, irq);
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 435d05a..77823bf 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -53,7 +53,7 @@ struct msi_desc {
 	struct {
 		__u8	type	: 5; 	/* {0: unused, 5h:MSI, 11h:MSI-X} */
 		__u8	maskbit	: 1; 	/* mask-pending bit supported ?   */
-		__u8	state	: 1; 	/* {0: free, 1: busy}		  */
+		__u8	unused	: 1;
 		__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit  */
 		__u8	pos;	 	/* Location of the msi capability */
 		__u16	entry_nr;    	/* specific enabled entry 	  */
diff --git a/include/linux/irq.h b/include/linux/irq.h
index ee8a5ea..86b65ed 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -373,6 +373,13 @@ set_irq_chained_handler(unsigned int irq
 extern int create_irq(void);
 extern void destroy_irq(unsigned int irq);
 
+/* Test to see if a driver has successfully requested an irq */
+static inline int irq_has_action(unsigned int irq)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	return desc->action != NULL;
+}
+
 /* Dynamic irq helper functions */
 extern void dynamic_irq_init(unsigned int irq);
 extern void dynamic_irq_cleanup(unsigned int irq);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index e128b7d..2253898 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -151,6 +151,13 @@ void dynamic_irq_cleanup(unsigned int ir
 
 	desc = irq_desc + irq;
 	spin_lock_irqsave(&desc->lock, flags);
+	if (desc->action) {
+		spin_unlock_irqrestore(&desc->lock, flags);
+		printk(KERN_ERR "Destroying IRQ%d without calling free_irq\n",
+			irq);
+		WARN_ON(1);
+		return;
+	}
 	desc->handle_irq = handle_bad_irq;
 	desc->chip = &no_irq_chip;
 	spin_unlock_irqrestore(&desc->lock, flags);
-- 
1.4.2.rc3.g7e18e-dirty

