Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030732AbWI0T7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030732AbWI0T7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030734AbWI0T7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:59:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26004 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030732AbWI0T7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:59:33 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/5] msi: Only use a single irq_chip for msi interrupts
Date: Wed, 27 Sep 2006 13:58:14 -0600
Message-Id: <11593870973413-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m164f9m6dy.fsf@ebiederm.dsl.xmission.com>
References: <m164f9m6dy.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The logic works like this.

Since we no longer track the state logic by hand in msi.c startup
and shutdown are no longer needed.

By updating msi_set_mask_bit to work on msi devices that do not
implement a mask bit we can always call the mask/unmask functions.

What we really have are mask and unmask so we use them to
implement the .mask and .unmask functions instead of .enable
and .disable.

By switching to the handle_edge_irq handler we only need an ack
function that moves the irq if necessary.  Which removes the
old end and ack functions and their peculiar logic of sometimes
disabling an irq.

This removes the reliance on pre genirq irq handling methods.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi.c |  115 +++++++++++------------------------------------------
 1 files changed, 24 insertions(+), 91 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e3ba396..fc7dd2a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -53,21 +53,20 @@ static void msi_set_mask_bit(unsigned in
 	struct msi_desc *entry;
 
 	entry = msi_desc[irq];
-	if (!entry || !entry->dev || !entry->mask_base)
-		return;
+	BUG_ON(!entry || !entry->dev);
 	switch (entry->msi_attrib.type) {
 	case PCI_CAP_ID_MSI:
-	{
-		int		pos;
-		u32		mask_bits;
-
-		pos = (long)entry->mask_base;
-		pci_read_config_dword(entry->dev, pos, &mask_bits);
-		mask_bits &= ~(1);
-		mask_bits |= flag;
-		pci_write_config_dword(entry->dev, pos, mask_bits);
+		if (entry->msi_attrib.maskbit) {
+			int		pos;
+			u32		mask_bits;
+
+			pos = (long)entry->mask_base;
+			pci_read_config_dword(entry->dev, pos, &mask_bits);
+			mask_bits &= ~(1);
+			mask_bits |= flag;
+			pci_write_config_dword(entry->dev, pos, mask_bits);
+		}
 		break;
-	}
 	case PCI_CAP_ID_MSIX:
 	{
 		int offset = entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
@@ -76,6 +75,7 @@ static void msi_set_mask_bit(unsigned in
 		break;
 	}
 	default:
+		BUG();
 		break;
 	}
 }
@@ -186,83 +186,21 @@ static void unmask_MSI_irq(unsigned int 
 	msi_set_mask_bit(irq, 0);
 }
 
-static unsigned int startup_msi_irq_wo_maskbit(unsigned int irq)
-{
-	return 0;	/* never anything pending */
-}
-
-static unsigned int startup_msi_irq_w_maskbit(unsigned int irq)
-{
-	startup_msi_irq_wo_maskbit(irq);
-	unmask_MSI_irq(irq);
-	return 0;	/* never anything pending */
-}
-
-static void shutdown_msi_irq(unsigned int irq)
-{
-}
-
-static void end_msi_irq_wo_maskbit(unsigned int irq)
+static void ack_msi_irq(unsigned int irq)
 {
 	move_native_irq(irq);
 	ack_APIC_irq();
 }
 
-static void end_msi_irq_w_maskbit(unsigned int irq)
-{
-	move_native_irq(irq);
-	unmask_MSI_irq(irq);
-	ack_APIC_irq();
-}
-
-static void do_nothing(unsigned int irq)
-{
-}
-
-/*
- * Interrupt Type for MSI-X PCI/PCI-X/PCI-Express Devices,
- * which implement the MSI-X Capability Structure.
- */
-static struct hw_interrupt_type msix_irq_type = {
-	.typename	= "PCI-MSI-X",
-	.startup	= startup_msi_irq_w_maskbit,
-	.shutdown	= shutdown_msi_irq,
-	.enable		= unmask_MSI_irq,
-	.disable	= mask_MSI_irq,
-	.ack		= mask_MSI_irq,
-	.end		= end_msi_irq_w_maskbit,
-	.set_affinity	= set_msi_affinity
-};
-
-/*
- * Interrupt Type for MSI PCI/PCI-X/PCI-Express Devices,
- * which implement the MSI Capability Structure with
- * Mask-and-Pending Bits.
- */
-static struct hw_interrupt_type msi_irq_w_maskbit_type = {
-	.typename	= "PCI-MSI",
-	.startup	= startup_msi_irq_w_maskbit,
-	.shutdown	= shutdown_msi_irq,
-	.enable		= unmask_MSI_irq,
-	.disable	= mask_MSI_irq,
-	.ack		= mask_MSI_irq,
-	.end		= end_msi_irq_w_maskbit,
-	.set_affinity	= set_msi_affinity
-};
-
 /*
- * Interrupt Type for MSI PCI/PCI-X/PCI-Express Devices,
- * which implement the MSI Capability Structure without
- * Mask-and-Pending Bits.
+ * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
+ * which implement the MSI or MSI-X Capability Structure.
  */
-static struct hw_interrupt_type msi_irq_wo_maskbit_type = {
-	.typename	= "PCI-MSI",
-	.startup	= startup_msi_irq_wo_maskbit,
-	.shutdown	= shutdown_msi_irq,
-	.enable		= do_nothing,
-	.disable	= do_nothing,
-	.ack		= do_nothing,
-	.end		= end_msi_irq_wo_maskbit,
+static struct irq_chip msi_chip = {
+	.name		= "PCI-MSI",
+	.unmask		= unmask_MSI_irq,
+	.mask		= mask_MSI_irq,
+	.ack		= ack_msi_irq,
 	.set_affinity	= set_msi_affinity
 };
 
@@ -330,7 +268,7 @@ static void attach_msi_entry(struct msi_
 	spin_unlock_irqrestore(&msi_lock, flags);
 }
 
-static int create_msi_irq(struct hw_interrupt_type *handler)
+static int create_msi_irq(struct irq_chip *chip)
 {
 	struct msi_desc *entry;
 	int irq;
@@ -345,7 +283,7 @@ static int create_msi_irq(struct hw_inte
 		return -EBUSY;
 	}
 
-	set_irq_chip(irq, handler);
+	set_irq_chip_and_handler(irq, chip, handle_edge_irq);
 	set_irq_data(irq, entry);
 
 	return irq;
@@ -634,16 +572,11 @@ static int msi_capability_init(struct pc
 	struct msi_desc *entry;
 	int pos, irq;
 	u16 control;
-	struct hw_interrupt_type *handler;
 
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	/* MSI Entry Initialization */
-	handler = &msi_irq_wo_maskbit_type;
-	if (is_mask_bit_support(control))
-		handler = &msi_irq_w_maskbit_type;
-
-	irq = create_msi_irq(handler);
+	irq = create_msi_irq(&msi_chip);
 	if (irq < 0)
 		return irq;
 
@@ -715,7 +648,7 @@ static int msix_capability_init(struct p
 
 	/* MSI-X Table Initialization */
 	for (i = 0; i < nvec; i++) {
-		irq = create_msi_irq(&msix_irq_type);
+		irq = create_msi_irq(&msi_chip);
 		if (irq < 0)
 			break;
 
-- 
1.4.2.rc3.g7e18e-dirty

