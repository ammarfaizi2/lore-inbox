Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWFTWgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWFTWgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWFTWgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:36:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56804 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751330AbWFTW27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:28:59 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 13/25] msi: Make the msi code irq based and not vector based.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:26 -0600
Message-Id: <11508425223015-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425221394-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The msi currently allocates irqs backwards.  First it
allocates a platform dependent routing value for an
interrupt the ``vector'' and then it figures out from the
vector which irq you are on.

For ia64 this is fine.  For x86 and x86_64 this is complete
nonsense and makes an enourmous mess of the irq handling
code and prevents some pretty significant cleanups in
the code for handling large numbers of irqs.

This patch refactors msi.c to work in terms of irqs and
create_irq/destroy_irq for dynamically managing irqs.

Hopefully this is finally a version of msi.c that
is useful on more than just x86 derivatives.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi.c |  425 +++++++++++++++++++++--------------------------------
 drivers/pci/msi.h |    7 -
 2 files changed, 168 insertions(+), 264 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 772f5b6..a5d3685 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -6,6 +6,7 @@
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  */
 
+#include <linux/err.h>
 #include <linux/mm.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -28,12 +29,6 @@ static struct msi_desc* msi_desc[NR_IRQS
 static kmem_cache_t* msi_cachep;
 
 static int pci_msi_enable = 1;
-static int last_alloc_vector;
-static int nr_released_vectors;
-
-#ifndef CONFIG_X86_IO_APIC
-int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
-#endif
 
 static struct msi_ops *msi_ops;
 
@@ -60,11 +55,11 @@ static int msi_cache_init(void)
 	return 0;
 }
 
-static void msi_set_mask_bit(unsigned int vector, int flag)
+static void msi_set_mask_bit(unsigned int irq, int flag)
 {
 	struct msi_desc *entry;
 
-	entry = (struct msi_desc *)msi_desc[vector];
+	entry = msi_desc[irq];
 	if (!entry || !entry->dev || !entry->mask_base)
 		return;
 	switch (entry->msi_attrib.type) {
@@ -188,23 +183,23 @@ #else
 #define set_msi_affinity NULL
 #endif /* CONFIG_SMP */
 
-static void mask_MSI_irq(unsigned int vector)
+static void mask_MSI_irq(unsigned int irq)
 {
-	msi_set_mask_bit(vector, 1);
+	msi_set_mask_bit(irq, 1);
 }
 
-static void unmask_MSI_irq(unsigned int vector)
+static void unmask_MSI_irq(unsigned int irq)
 {
-	msi_set_mask_bit(vector, 0);
+	msi_set_mask_bit(irq, 0);
 }
 
-static unsigned int startup_msi_irq_wo_maskbit(unsigned int vector)
+static unsigned int startup_msi_irq_wo_maskbit(unsigned int irq)
 {
 	struct msi_desc *entry;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[vector];
+	entry = msi_desc[irq];
 	if (!entry || !entry->dev) {
 		spin_unlock_irqrestore(&msi_lock, flags);
 		return 0;
@@ -215,39 +210,39 @@ static unsigned int startup_msi_irq_wo_m
 	return 0;	/* never anything pending */
 }
 
-static unsigned int startup_msi_irq_w_maskbit(unsigned int vector)
+static unsigned int startup_msi_irq_w_maskbit(unsigned int irq)
 {
-	startup_msi_irq_wo_maskbit(vector);
-	unmask_MSI_irq(vector);
+	startup_msi_irq_wo_maskbit(irq);
+	unmask_MSI_irq(irq);
 	return 0;	/* never anything pending */
 }
 
-static void shutdown_msi_irq(unsigned int vector)
+static void shutdown_msi_irq(unsigned int irq)
 {
 	struct msi_desc *entry;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[vector];
+	entry = msi_desc[irq];
 	if (entry && entry->dev)
 		entry->msi_attrib.state = 0;	/* Mark it not active */
 	spin_unlock_irqrestore(&msi_lock, flags);
 }
 
-static void end_msi_irq_wo_maskbit(unsigned int vector)
+static void end_msi_irq_wo_maskbit(unsigned int irq)
 {
-	move_native_irq(vector);
+	move_native_irq(irq);
 	ack_APIC_irq();
 }
 
-static void end_msi_irq_w_maskbit(unsigned int vector)
+static void end_msi_irq_w_maskbit(unsigned int irq)
 {
-	move_native_irq(vector);
-	unmask_MSI_irq(vector);
+	move_native_irq(irq);
+	unmask_MSI_irq(irq);
 	ack_APIC_irq();
 }
 
-static void do_nothing(unsigned int vector)
+static void do_nothing(unsigned int irq)
 {
 }
 
@@ -298,86 +293,7 @@ static struct hw_interrupt_type msi_irq_
 	.set_affinity	= set_msi_affinity
 };
 
-static int msi_free_vector(struct pci_dev* dev, int vector, int reassign);
-static int assign_msi_vector(void)
-{
-	static int new_vector_avail = 1;
-	int vector;
-	unsigned long flags;
-
-	/*
-	 * msi_lock is provided to ensure that successful allocation of MSI
-	 * vector is assigned unique among drivers.
-	 */
-	spin_lock_irqsave(&msi_lock, flags);
-
-	if (!new_vector_avail) {
-		int free_vector = 0;
-
-		/*
-	 	 * vector_irq[] = -1 indicates that this specific vector is:
-	 	 * - assigned for MSI (since MSI have no associated IRQ) or
-	 	 * - assigned for legacy if less than 16, or
-	 	 * - having no corresponding 1:1 vector-to-IOxAPIC IRQ mapping
-	 	 * vector_irq[] = 0 indicates that this vector, previously
-		 * assigned for MSI, is freed by hotplug removed operations.
-		 * This vector will be reused for any subsequent hotplug added
-		 * operations.
-	 	 * vector_irq[] > 0 indicates that this vector is assigned for
-		 * IOxAPIC IRQs. This vector and its value provides a 1-to-1
-		 * vector-to-IOxAPIC IRQ mapping.
-	 	 */
-		for (vector = FIRST_DEVICE_VECTOR; vector < NR_IRQS; vector++) {
-			if (vector_irq[vector] != 0)
-				continue;
-			free_vector = vector;
-			if (!msi_desc[vector])
-			      	break;
-			else
-				continue;
-		}
-		if (!free_vector) {
-			spin_unlock_irqrestore(&msi_lock, flags);
-			return -EBUSY;
-		}
-		vector_irq[free_vector] = -1;
-		nr_released_vectors--;
-		spin_unlock_irqrestore(&msi_lock, flags);
-		if (msi_desc[free_vector] != NULL) {
-			struct pci_dev *dev;
-			int tail;
-
-			/* free all linked vectors before re-assign */
-			do {
-				spin_lock_irqsave(&msi_lock, flags);
-				dev = msi_desc[free_vector]->dev;
-				tail = msi_desc[free_vector]->link.tail;
-				spin_unlock_irqrestore(&msi_lock, flags);
-				msi_free_vector(dev, tail, 1);
-			} while (free_vector != tail);
-		}
-
-		return free_vector;
-	}
-	vector = assign_irq_vector(AUTO_ASSIGN);
-	last_alloc_vector = vector;
-	if (vector  == LAST_DEVICE_VECTOR)
-		new_vector_avail = 0;
-
-	spin_unlock_irqrestore(&msi_lock, flags);
-	return vector;
-}
-
-static int get_new_vector(void)
-{
-	int vector = assign_msi_vector();
-
-	if (vector > 0)
-		set_intr_gate(vector, interrupt[vector]);
-
-	return vector;
-}
-
+static int msi_free_irq(struct pci_dev* dev, int irq);
 static int msi_init(void)
 {
 	static int status = -ENOMEM;
@@ -401,13 +317,13 @@ static int msi_init(void)
 	}
 
 	if (! msi_ops) {
+		pci_msi_enable = 0;
 		printk(KERN_WARNING
 		       "PCI: MSI ops not registered. MSI disabled.\n");
 		status = -EINVAL;
 		return status;
 	}
 
-	last_alloc_vector = assign_irq_vector(AUTO_ASSIGN);
 	status = msi_cache_init();
 	if (status < 0) {
 		pci_msi_enable = 0;
@@ -415,23 +331,9 @@ static int msi_init(void)
 		return status;
 	}
 
-	if (last_alloc_vector < 0) {
-		pci_msi_enable = 0;
-		printk(KERN_WARNING "PCI: No interrupt vectors available for MSI\n");
-		status = -EBUSY;
-		return status;
-	}
-	vector_irq[last_alloc_vector] = 0;
-	nr_released_vectors++;
-
 	return status;
 }
 
-static int get_msi_vector(struct pci_dev *dev)
-{
-	return get_new_vector();
-}
-
 static struct msi_desc* alloc_msi_entry(void)
 {
 	struct msi_desc *entry;
@@ -447,29 +349,45 @@ static struct msi_desc* alloc_msi_entry(
 	return entry;
 }
 
-static void attach_msi_entry(struct msi_desc *entry, int vector)
+static void attach_msi_entry(struct msi_desc *entry, int irq)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
-	msi_desc[vector] = entry;
+	msi_desc[irq] = entry;
 	spin_unlock_irqrestore(&msi_lock, flags);
 }
 
-static void irq_handler_init(int cap_id, int pos, int mask)
+static int create_msi_irq(struct hw_interrupt_type *handler)
 {
-	unsigned long flags;
+	struct msi_desc *entry;
+	int irq;
 
-	spin_lock_irqsave(&irq_desc[pos].lock, flags);
-	if (cap_id == PCI_CAP_ID_MSIX)
-		irq_desc[pos].chip = &msix_irq_type;
-	else {
-		if (!mask)
-			irq_desc[pos].chip = &msi_irq_wo_maskbit_type;
-		else
-			irq_desc[pos].chip = &msi_irq_w_maskbit_type;
+	entry = alloc_msi_entry();
+	if (!entry)
+		return -ENOMEM;
+	
+	irq = create_irq();
+	if (irq < 0) {
+		kmem_cache_free(msi_cachep, entry);
+		return -EBUSY;
 	}
-	spin_unlock_irqrestore(&irq_desc[pos].lock, flags);
+	
+	set_irq_chip(irq, handler);
+	set_irq_data(irq, entry);
+
+	return irq;
+}
+
+static void destroy_msi_irq(unsigned int irq)
+{
+	struct msi_desc *entry;
+
+	entry = get_irq_data(irq);
+	set_irq_chip(irq, NULL);
+	set_irq_data(irq, NULL);
+	destroy_irq(irq);
+	kmem_cache_free(msi_cachep, entry);
 }
 
 static void enable_msi_mode(struct pci_dev *dev, int pos, int type)
@@ -514,21 +432,21 @@ void disable_msi_mode(struct pci_dev *de
 	}
 }
 
-static int msi_lookup_vector(struct pci_dev *dev, int type)
+static int msi_lookup_irq(struct pci_dev *dev, int type)
 {
-	int vector;
+	int irq;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
-	for (vector = FIRST_DEVICE_VECTOR; vector < NR_IRQS; vector++) {
-		if (!msi_desc[vector] || msi_desc[vector]->dev != dev ||
-			msi_desc[vector]->msi_attrib.type != type ||
-			msi_desc[vector]->msi_attrib.default_vector != dev->irq)
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		if (!msi_desc[irq] || msi_desc[irq]->dev != dev ||
+			msi_desc[irq]->msi_attrib.type != type ||
+			msi_desc[irq]->msi_attrib.default_irq != dev->irq)
 			continue;
 		spin_unlock_irqrestore(&msi_lock, flags);
-		/* This pre-assigned MSI vector for this device
-		   already exits. Override dev->irq with this vector */
-		dev->irq = vector;
+		/* This pre-assigned MSI irq for this device
+		   already exits. Override dev->irq with this irq */
+		dev->irq = irq;
 		return 0;
 	}
 	spin_unlock_irqrestore(&msi_lock, flags);
@@ -613,7 +531,7 @@ int pci_save_msix_state(struct pci_dev *
 {
 	int pos;
 	int temp;
-	int vector, head, tail = 0;
+	int irq, head, tail = 0;
 	u16 control;
 	struct pci_cap_saved_state *save_state;
 
@@ -635,20 +553,20 @@ int pci_save_msix_state(struct pci_dev *
 
 	/* save the table */
 	temp = dev->irq;
-	if (msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
+	if (msi_lookup_irq(dev, PCI_CAP_ID_MSIX)) {
 		kfree(save_state);
 		return -EINVAL;
 	}
 
-	vector = head = dev->irq;
+	irq = head = dev->irq;
 	while (head != tail) {
 		struct msi_desc *entry;
 
-		entry = msi_desc[vector];
+		entry = msi_desc[irq];
 		read_msi_msg(entry, &entry->msg_save);
 
-		tail = msi_desc[vector]->link.tail;
-		vector = tail;
+		tail = msi_desc[irq]->link.tail;
+		irq = tail;
 	}
 	dev->irq = temp;
 
@@ -661,7 +579,7 @@ void pci_restore_msix_state(struct pci_d
 {
 	u16 save;
 	int pos;
-	int vector, head, tail = 0;
+	int irq, head, tail = 0;
 	struct msi_desc *entry;
 	int temp;
 	struct pci_cap_saved_state *save_state;
@@ -679,15 +597,15 @@ void pci_restore_msix_state(struct pci_d
 
 	/* route the table */
 	temp = dev->irq;
-	if (msi_lookup_vector(dev, PCI_CAP_ID_MSIX))
+	if (msi_lookup_irq(dev, PCI_CAP_ID_MSIX))
 		return;
-	vector = head = dev->irq;
+	irq = head = dev->irq;
 	while (head != tail) {
-		entry = msi_desc[vector];
+		entry = msi_desc[irq];
 		write_msi_msg(entry, &entry->msg_save);
 
-		tail = msi_desc[vector]->link.tail;
-		vector = tail;
+		tail = msi_desc[irq]->link.tail;
+		irq = tail;
 	}
 	dev->irq = temp;
 
@@ -734,55 +652,54 @@ static int msi_register_init(struct pci_
  * @dev: pointer to the pci_dev data structure of MSI device function
  *
  * Setup the MSI capability structure of device function with a single
- * MSI vector, regardless of device function is capable of handling
+ * MSI irq, regardless of device function is capable of handling
  * multiple messages. A return of zero indicates the successful setup
- * of an entry zero with the new MSI vector or non-zero for otherwise.
+ * of an entry zero with the new MSI irq or non-zero for otherwise.
  **/
 static int msi_capability_init(struct pci_dev *dev)
 {
 	int status;
 	struct msi_desc *entry;
-	int pos, vector;
+	int pos, irq;
 	u16 control;
+	struct hw_interrupt_type *handler;
 
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	/* MSI Entry Initialization */
-	entry = alloc_msi_entry();
-	if (!entry)
-		return -ENOMEM;
+	handler = &msi_irq_wo_maskbit_type;
+	if (is_mask_bit_support(control))
+		handler = &msi_irq_w_maskbit_type;
 
-	vector = get_msi_vector(dev);
-	if (vector < 0) {
-		kmem_cache_free(msi_cachep, entry);
-		return -EBUSY;
-	}
-	entry->link.head = vector;
-	entry->link.tail = vector;
+	irq = create_msi_irq(handler);
+	if (irq < 0)
+		return irq;
+
+	entry = get_irq_data(irq);
+	entry->link.head = irq;
+	entry->link.tail = irq;
 	entry->msi_attrib.type = PCI_CAP_ID_MSI;
 	entry->msi_attrib.state = 0;			/* Mark it not active */
 	entry->msi_attrib.is_64 = is_64bit_address(control);
 	entry->msi_attrib.entry_nr = 0;
 	entry->msi_attrib.maskbit = is_mask_bit_support(control);
-	entry->msi_attrib.default_vector = dev->irq;	/* Save IOAPIC IRQ */
+	entry->msi_attrib.default_irq = dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.pos = pos;
-	dev->irq = vector;
+	dev->irq = irq;
 	entry->dev = dev;
 	if (is_mask_bit_support(control)) {
 		entry->mask_base = (void __iomem *)(long)msi_mask_bits_reg(pos,
 				is_64bit_address(control));
 	}
-	/* Replace with MSI handler */
-	irq_handler_init(PCI_CAP_ID_MSI, vector, entry->msi_attrib.maskbit);
 	/* Configure MSI capability structure */
 	status = msi_register_init(dev, entry);
 	if (status != 0) {
-		dev->irq = entry->msi_attrib.default_vector;
-		kmem_cache_free(msi_cachep, entry);
+		dev->irq = entry->msi_attrib.default_irq;
+		destroy_msi_irq(irq);
 		return status;
 	}
 
-	attach_msi_entry(entry, vector);
+	attach_msi_entry(entry, irq);
 	/* Set MSI enabled bits	 */
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 
@@ -796,8 +713,8 @@ static int msi_capability_init(struct pc
  * @nvec: number of @entries
  *
  * Setup the MSI-X capability structure of device function with a
- * single MSI-X vector. A return of zero indicates the successful setup of
- * requested MSI-X entries with allocated vectors or non-zero for otherwise.
+ * single MSI-X irq. A return of zero indicates the successful setup of
+ * requested MSI-X entries with allocated irqs or non-zero for otherwise.
  **/
 static int msix_capability_init(struct pci_dev *dev,
 				struct msix_entry *entries, int nvec)
@@ -805,7 +722,7 @@ static int msix_capability_init(struct p
 	struct msi_desc *head = NULL, *tail = NULL, *entry = NULL;
 	struct msi_msg msg;
 	int status;
-	int vector, pos, i, j, nr_entries, temp = 0;
+	int irq, pos, i, j, nr_entries, temp = 0;
 	unsigned long phys_addr;
 	u32 table_offset;
  	u16 control;
@@ -827,54 +744,50 @@ static int msix_capability_init(struct p
 
 	/* MSI-X Table Initialization */
 	for (i = 0; i < nvec; i++) {
-		entry = alloc_msi_entry();
-		if (!entry)
-			break;
-		vector = get_msi_vector(dev);
-		if (vector < 0) {
-			kmem_cache_free(msi_cachep, entry);
+		irq = create_msi_irq(&msix_irq_type);
+		if (irq < 0)
 			break;
-		}
 
+		entry = get_irq_data(irq);
  		j = entries[i].entry;
- 		entries[i].vector = vector;
+ 		entries[i].vector = irq;
 		entry->msi_attrib.type = PCI_CAP_ID_MSIX;
  		entry->msi_attrib.state = 0;		/* Mark it not active */
 		entry->msi_attrib.is_64 = 1;
 		entry->msi_attrib.entry_nr = j;
 		entry->msi_attrib.maskbit = 1;
-		entry->msi_attrib.default_vector = dev->irq;
+		entry->msi_attrib.default_irq = dev->irq;
 		entry->msi_attrib.pos = pos;
 		entry->dev = dev;
 		entry->mask_base = base;
 		if (!head) {
-			entry->link.head = vector;
-			entry->link.tail = vector;
+			entry->link.head = irq;
+			entry->link.tail = irq;
 			head = entry;
 		} else {
 			entry->link.head = temp;
 			entry->link.tail = tail->link.tail;
-			tail->link.tail = vector;
-			head->link.head = vector;
+			tail->link.tail = irq;
+			head->link.head = irq;
 		}
-		temp = vector;
+		temp = irq;
 		tail = entry;
-		/* Replace with MSI-X handler */
-		irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
 		/* Configure MSI-X capability structure */
-		status = msi_ops->setup(dev, vector, &msg);
-		if (status < 0)
+		status = msi_ops->setup(dev, irq, &msg);
+		if (status < 0) {
+			destroy_msi_irq(irq);
 			break;
+		}
 
 		write_msi_msg(entry, &msg);
-		attach_msi_entry(entry, vector);
+		attach_msi_entry(entry, irq);
 	}
 	if (i != nvec) {
 		int avail = i - 1;
 		i--;
 		for (; i >= 0; i--) {
-			vector = (entries + i)->vector;
-			msi_free_vector(dev, vector, 0);
+			irq = (entries + i)->vector;
+			msi_free_irq(dev, irq);
 			(entries + i)->vector = 0;
 		}
 		/* If we had some success report the number of irqs
@@ -895,10 +808,10 @@ static int msix_capability_init(struct p
  * @dev: pointer to the pci_dev data structure of MSI device function
  *
  * Setup the MSI capability structure of device function with
- * a single MSI vector upon its software driver call to request for
+ * a single MSI irq upon its software driver call to request for
  * MSI mode enabled on its hardware device function. A return of zero
  * indicates the successful setup of an entry zero with the new MSI
- * vector or non-zero for otherwise.
+ * irq or non-zero for otherwise.
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
@@ -930,13 +843,13 @@ int pci_enable_msi(struct pci_dev* dev)
 	if (!is_64bit_address(control) && msi_ops->needs_64bit_address)
 		return -EINVAL;
 
-	BUG_ON(!msi_lookup_vector(dev, PCI_CAP_ID_MSI));
+	BUG_ON(!msi_lookup_irq(dev, PCI_CAP_ID_MSI));
 
-	/* Check whether driver already requested for MSI-X vectors */
+	/* Check whether driver already requested for MSI-X irqs */
 	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (pos > 0 && !msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
+	if (pos > 0 && !msi_lookup_irq(dev, PCI_CAP_ID_MSIX)) {
 			printk(KERN_INFO "PCI: %s: Can't enable MSI.  "
-			       "Device already has MSI-X vectors assigned\n",
+			       "Device already has MSI-X irq assigned\n",
 			       pci_name(dev));
 			dev->irq = temp;
 			return -EINVAL;
@@ -948,7 +861,7 @@ int pci_enable_msi(struct pci_dev* dev)
 void pci_disable_msi(struct pci_dev* dev)
 {
 	struct msi_desc *entry;
-	int pos, default_vector;
+	int pos, default_irq;
 	u16 control;
 	unsigned long flags;
 
@@ -976,30 +889,30 @@ void pci_disable_msi(struct pci_dev* dev
 	if (entry->msi_attrib.state) {
 		spin_unlock_irqrestore(&msi_lock, flags);
 		printk(KERN_WARNING "PCI: %s: pci_disable_msi() called without "
-		       "free_irq() on MSI vector %d\n",
+		       "free_irq() on MSI irq %d\n",
 		       pci_name(dev), dev->irq);
 		BUG_ON(entry->msi_attrib.state > 0);
 	} else {
-		default_vector = entry->msi_attrib.default_vector;
+		default_irq = entry->msi_attrib.default_irq;
 		spin_unlock_irqrestore(&msi_lock, flags);
-		msi_free_vector(dev, dev->irq, 0);
+		msi_free_irq(dev, dev->irq);
 
-		/* Restore dev->irq to its default pin-assertion vector */
-		dev->irq = default_vector;
+		/* Restore dev->irq to its default pin-assertion irq */
+		dev->irq = default_irq;
 	}
 }
 
-static int msi_free_vector(struct pci_dev* dev, int vector, int reassign)
+static int msi_free_irq(struct pci_dev* dev, int irq)
 {
 	struct msi_desc *entry;
 	int head, entry_nr, type;
 	void __iomem *base;
 	unsigned long flags;
 
-	msi_ops->teardown(vector);
+	msi_ops->teardown(irq);
 
 	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[vector];
+	entry = msi_desc[irq];
 	if (!entry || entry->dev != dev) {
 		spin_unlock_irqrestore(&msi_lock, flags);
 		return -EINVAL;
@@ -1011,22 +924,16 @@ static int msi_free_vector(struct pci_de
 	msi_desc[entry->link.head]->link.tail = entry->link.tail;
 	msi_desc[entry->link.tail]->link.head = entry->link.head;
 	entry->dev = NULL;
-	if (!reassign) {
-		vector_irq[vector] = 0;
-		nr_released_vectors++;
-	}
-	msi_desc[vector] = NULL;
+	msi_desc[irq] = NULL;
 	spin_unlock_irqrestore(&msi_lock, flags);
 
-	kmem_cache_free(msi_cachep, entry);
+	destroy_msi_irq(irq);
 
 	if (type == PCI_CAP_ID_MSIX) {
-		if (!reassign)
-			writel(1, base +
-				entry_nr * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
+		writel(1, base + entry_nr * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
 
-		if (head == vector)
+		if (head == irq)
 			iounmap(base);
 	}
 
@@ -1037,15 +944,15 @@ static int msi_free_vector(struct pci_de
  * pci_enable_msix - configure device's MSI-X capability structure
  * @dev: pointer to the pci_dev data structure of MSI-X device function
  * @entries: pointer to an array of MSI-X entries
- * @nvec: number of MSI-X vectors requested for allocation by device driver
+ * @nvec: number of MSI-X irqs requested for allocation by device driver
  *
  * Setup the MSI-X capability structure of device function with the number
- * of requested vectors upon its software driver call to request for
+ * of requested irqs upon its software driver call to request for
  * MSI-X mode enabled on its hardware device function. A return of zero
  * indicates the successful configuration of MSI-X capability structure
- * with new allocated MSI-X vectors. A return of < 0 indicates a failure.
+ * with new allocated MSI-X irqs. A return of < 0 indicates a failure.
  * Or a return of > 0 indicates that driver request is exceeding the number
- * of vectors available. Driver should use the returned value to re-send
+ * of irqs available. Driver should use the returned value to re-send
  * its request.
  **/
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
@@ -1088,13 +995,13 @@ int pci_enable_msix(struct pci_dev* dev,
 		}
 	}
 	temp = dev->irq;
-	BUG_ON(!msi_lookup_vector(dev, PCI_CAP_ID_MSIX));
+	BUG_ON(!msi_lookup_irq(dev, PCI_CAP_ID_MSIX));
 
-	/* Check whether driver already requested for MSI vector */
+	/* Check whether driver already requested for MSI irq */
    	if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0 &&
-		!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
+		!msi_lookup_irq(dev, PCI_CAP_ID_MSI)) {
 		printk(KERN_INFO "PCI: %s: Can't enable MSI-X.  "
-		       "Device already has an MSI vector assigned\n",
+		       "Device already has an MSI irq assigned\n",
 		       pci_name(dev));
 		dev->irq = temp;
 		return -EINVAL;
@@ -1124,27 +1031,27 @@ void pci_disable_msix(struct pci_dev* de
 	disable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
 
 	temp = dev->irq;
-	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
-		int state, vector, head, tail = 0, warning = 0;
+	if (!msi_lookup_irq(dev, PCI_CAP_ID_MSIX)) {
+		int state, irq, head, tail = 0, warning = 0;
 		unsigned long flags;
 
-		vector = head = dev->irq;
+		irq = head = dev->irq;
 		dev->irq = temp;			/* Restore pin IRQ */
 		while (head != tail) {
 			spin_lock_irqsave(&msi_lock, flags);
-			state = msi_desc[vector]->msi_attrib.state;
-			tail = msi_desc[vector]->link.tail;
+			state = msi_desc[irq]->msi_attrib.state;
+			tail = msi_desc[irq]->link.tail;
 			spin_unlock_irqrestore(&msi_lock, flags);
 			if (state)
 				warning = 1;
-			else if (vector != head)	/* Release MSI-X vector */
-				msi_free_vector(dev, vector, 0);
-			vector = tail;
+			else if (irq != head)	/* Release MSI-X irq */
+				msi_free_irq(dev, irq);
+			irq = tail;
 		}
-		msi_free_vector(dev, vector, 0);
+		msi_free_irq(dev, irq);
 		if (warning) {
 			printk(KERN_WARNING "PCI: %s: pci_disable_msix() called without "
-			       "free_irq() on all MSI-X vectors\n",
+			       "free_irq() on all MSI-X irqs\n",
 			       pci_name(dev));
 			BUG_ON(warning > 0);
 		}
@@ -1152,11 +1059,11 @@ void pci_disable_msix(struct pci_dev* de
 }
 
 /**
- * msi_remove_pci_irq_vectors - reclaim MSI(X) vectors to unused state
+ * msi_remove_pci_irq_vectors - reclaim MSI(X) irqs to unused state
  * @dev: pointer to the pci_dev data structure of MSI(X) device function
  *
  * Being called during hotplug remove, from which the device function
- * is hot-removed. All previous assigned MSI/MSI-X vectors, if
+ * is hot-removed. All previous assigned MSI/MSI-X irqs, if
  * allocated for this device function, are reclaimed to unused state,
  * which may be used later on.
  **/
@@ -1170,42 +1077,42 @@ void msi_remove_pci_irq_vectors(struct p
 
 	temp = dev->irq;		/* Save IOAPIC IRQ */
 	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (pos > 0 && !msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
+	if (pos > 0 && !msi_lookup_irq(dev, PCI_CAP_ID_MSI)) {
 		spin_lock_irqsave(&msi_lock, flags);
 		state = msi_desc[dev->irq]->msi_attrib.state;
 		spin_unlock_irqrestore(&msi_lock, flags);
 		if (state) {
 			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
-			       "called without free_irq() on MSI vector %d\n",
+			       "called without free_irq() on MSI irq %d\n",
 			       pci_name(dev), dev->irq);
 			BUG_ON(state > 0);
-		} else /* Release MSI vector assigned to this device */
-			msi_free_vector(dev, dev->irq, 0);
+		} else /* Release MSI irq assigned to this device */
+			msi_free_irq(dev, dev->irq);
 		dev->irq = temp;		/* Restore IOAPIC IRQ */
 	}
 	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (pos > 0 && !msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
-		int vector, head, tail = 0, warning = 0;
+	if (pos > 0 && !msi_lookup_irq(dev, PCI_CAP_ID_MSIX)) {
+		int irq, head, tail = 0, warning = 0;
 		void __iomem *base = NULL;
 
-		vector = head = dev->irq;
+		irq = head = dev->irq;
 		while (head != tail) {
 			spin_lock_irqsave(&msi_lock, flags);
-			state = msi_desc[vector]->msi_attrib.state;
-			tail = msi_desc[vector]->link.tail;
-			base = msi_desc[vector]->mask_base;
+			state = msi_desc[irq]->msi_attrib.state;
+			tail = msi_desc[irq]->link.tail;
+			base = msi_desc[irq]->mask_base;
 			spin_unlock_irqrestore(&msi_lock, flags);
 			if (state)
 				warning = 1;
-			else if (vector != head) /* Release MSI-X vector */
-				msi_free_vector(dev, vector, 0);
-			vector = tail;
+			else if (irq != head) /* Release MSI-X irq */
+				msi_free_irq(dev, irq);
+			irq = tail;
 		}
-		msi_free_vector(dev, vector, 0);
+		msi_free_irq(dev, irq);
 		if (warning) {
 			iounmap(base);
 			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
-			       "called without free_irq() on all MSI-X vectors\n",
+			       "called without free_irq() on all MSI-X irqs\n",
 			       pci_name(dev));
 			BUG_ON(warning > 0);
 		}
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 6793241..435d05a 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -8,9 +8,6 @@ #define MSI_H
 
 #include <asm/msi.h>
 
-extern int vector_irq[NR_VECTORS];
-extern void (*interrupt[NR_IRQS])(void);
-
 /*
  * MSI-X Address Register
  */
@@ -58,9 +55,9 @@ struct msi_desc {
 		__u8	maskbit	: 1; 	/* mask-pending bit supported ?   */
 		__u8	state	: 1; 	/* {0: free, 1: busy}		  */
 		__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit  */
-		__u8	entry_nr;    	/* specific enabled entry 	  */
-		__u8	default_vector; /* default pre-assigned vector    */
 		__u8	pos;	 	/* Location of the msi capability */
+		__u16	entry_nr;    	/* specific enabled entry 	  */
+		unsigned default_irq;	/* default pre-assigned irq	  */
 	}msi_attrib;
 
 	struct {
-- 
1.4.0.gc07e

