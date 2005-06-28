Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVF1Ff3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVF1Ff3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVF1FfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:35:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:7148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261600AbVF1Fdd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:33 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: clean up the MSI code a bit.
In-Reply-To: <1119936775691@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:55 -0700
Message-Id: <11199367752569@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: clean up the MSI code a bit.

Mostly just cleans up the irq handling logic to be smaller and a bit more
descriptive as to what it really does.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 70549ad9cf074e12f12cdc931b29b2616dfb873a
tree dde5cdc320df87f1eee4b6ef94146dd741a31d14
parent bb4a61b6eaee01707f24deeefc5d7136f25f75c5
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Jun 2005 23:07:46 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:46 -0700

 drivers/pci/msi.c |   88 ++++++++++++++++++++---------------------------------
 drivers/pci/msi.h |    9 ++---
 2 files changed, 37 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -28,10 +28,10 @@ static struct msi_desc* msi_desc[NR_IRQS
 static kmem_cache_t* msi_cachep;
 
 static int pci_msi_enable = 1;
-static int last_alloc_vector = 0;
-static int nr_released_vectors = 0;
+static int last_alloc_vector;
+static int nr_released_vectors;
 static int nr_reserved_vectors = NR_HP_RESERVED_VECTORS;
-static int nr_msix_devices = 0;
+static int nr_msix_devices;
 
 #ifndef CONFIG_X86_IO_APIC
 int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
@@ -170,44 +170,30 @@ static unsigned int startup_msi_irq_wo_m
 	return 0;	/* never anything pending */
 }
 
-static void release_msi(unsigned int vector);
-static void shutdown_msi_irq(unsigned int vector)
-{
-	release_msi(vector);
-}
-
-#define shutdown_msi_irq_wo_maskbit	shutdown_msi_irq
-static void enable_msi_irq_wo_maskbit(unsigned int vector) {}
-static void disable_msi_irq_wo_maskbit(unsigned int vector) {}
-static void ack_msi_irq_wo_maskbit(unsigned int vector) {}
-static void end_msi_irq_wo_maskbit(unsigned int vector)
+static unsigned int startup_msi_irq_w_maskbit(unsigned int vector)
 {
-	move_msi(vector);
-	ack_APIC_irq();
+	startup_msi_irq_wo_maskbit(vector);
+	unmask_MSI_irq(vector);
+	return 0;	/* never anything pending */
 }
 
-static unsigned int startup_msi_irq_w_maskbit(unsigned int vector)
+static void shutdown_msi_irq(unsigned int vector)
 {
 	struct msi_desc *entry;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
 	entry = msi_desc[vector];
-	if (!entry || !entry->dev) {
-		spin_unlock_irqrestore(&msi_lock, flags);
-		return 0;
-	}
-	entry->msi_attrib.state = 1;	/* Mark it active */
+	if (entry && entry->dev)
+		entry->msi_attrib.state = 0;	/* Mark it not active */
 	spin_unlock_irqrestore(&msi_lock, flags);
-
-	unmask_MSI_irq(vector);
-	return 0;	/* never anything pending */
 }
 
-#define shutdown_msi_irq_w_maskbit	shutdown_msi_irq
-#define enable_msi_irq_w_maskbit	unmask_MSI_irq
-#define disable_msi_irq_w_maskbit	mask_MSI_irq
-#define ack_msi_irq_w_maskbit		mask_MSI_irq
+static void end_msi_irq_wo_maskbit(unsigned int vector)
+{
+	move_msi(vector);
+	ack_APIC_irq();
+}
 
 static void end_msi_irq_w_maskbit(unsigned int vector)
 {
@@ -216,6 +202,10 @@ static void end_msi_irq_w_maskbit(unsign
 	ack_APIC_irq();
 }
 
+static void do_nothing(unsigned int vector)
+{
+}
+
 /*
  * Interrupt Type for MSI-X PCI/PCI-X/PCI-Express Devices,
  * which implement the MSI-X Capability Structure.
@@ -223,10 +213,10 @@ static void end_msi_irq_w_maskbit(unsign
 static struct hw_interrupt_type msix_irq_type = {
 	.typename	= "PCI-MSI-X",
 	.startup	= startup_msi_irq_w_maskbit,
-	.shutdown	= shutdown_msi_irq_w_maskbit,
-	.enable		= enable_msi_irq_w_maskbit,
-	.disable	= disable_msi_irq_w_maskbit,
-	.ack		= ack_msi_irq_w_maskbit,
+	.shutdown	= shutdown_msi_irq,
+	.enable		= unmask_MSI_irq,
+	.disable	= mask_MSI_irq,
+	.ack		= mask_MSI_irq,
 	.end		= end_msi_irq_w_maskbit,
 	.set_affinity	= set_msi_irq_affinity
 };
@@ -239,10 +229,10 @@ static struct hw_interrupt_type msix_irq
 static struct hw_interrupt_type msi_irq_w_maskbit_type = {
 	.typename	= "PCI-MSI",
 	.startup	= startup_msi_irq_w_maskbit,
-	.shutdown	= shutdown_msi_irq_w_maskbit,
-	.enable		= enable_msi_irq_w_maskbit,
-	.disable	= disable_msi_irq_w_maskbit,
-	.ack		= ack_msi_irq_w_maskbit,
+	.shutdown	= shutdown_msi_irq,
+	.enable		= unmask_MSI_irq,
+	.disable	= mask_MSI_irq,
+	.ack		= mask_MSI_irq,
 	.end		= end_msi_irq_w_maskbit,
 	.set_affinity	= set_msi_irq_affinity
 };
@@ -255,10 +245,10 @@ static struct hw_interrupt_type msi_irq_
 static struct hw_interrupt_type msi_irq_wo_maskbit_type = {
 	.typename	= "PCI-MSI",
 	.startup	= startup_msi_irq_wo_maskbit,
-	.shutdown	= shutdown_msi_irq_wo_maskbit,
-	.enable		= enable_msi_irq_wo_maskbit,
-	.disable	= disable_msi_irq_wo_maskbit,
-	.ack		= ack_msi_irq_wo_maskbit,
+	.shutdown	= shutdown_msi_irq,
+	.enable		= do_nothing,
+	.disable	= do_nothing,
+	.ack		= do_nothing,
 	.end		= end_msi_irq_wo_maskbit,
 	.set_affinity	= set_msi_irq_affinity
 };
@@ -407,7 +397,7 @@ static struct msi_desc* alloc_msi_entry(
 {
 	struct msi_desc *entry;
 
-	entry = (struct msi_desc*) kmem_cache_alloc(msi_cachep, SLAB_KERNEL);
+	entry = kmem_cache_alloc(msi_cachep, SLAB_KERNEL);
 	if (!entry)
 		return NULL;
 
@@ -796,18 +786,6 @@ void pci_disable_msi(struct pci_dev* dev
 	}
 }
 
-static void release_msi(unsigned int vector)
-{
-	struct msi_desc *entry;
-	unsigned long flags;
-
-	spin_lock_irqsave(&msi_lock, flags);
-	entry = msi_desc[vector];
-	if (entry && entry->dev)
-		entry->msi_attrib.state = 0;	/* Mark it not active */
-	spin_unlock_irqrestore(&msi_lock, flags);
-}
-
 static int msi_free_vector(struct pci_dev* dev, int vector, int reassign)
 {
 	struct msi_desc *entry;
@@ -924,7 +902,7 @@ static int reroute_msix_table(int head, 
 /**
  * pci_enable_msix - configure device's MSI-X capability structure
  * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @data: pointer to an array of MSI-X entries
+ * @entries: pointer to an array of MSI-X entries
  * @nvec: number of MSI-X vectors requested for allocation by device driver
  *
  * Setup the MSI-X capability structure of device function with the number
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -41,11 +41,11 @@ static inline void move_msi(int vector) 
 #define PCI_MSIX_FLAGS_BIRMASK		(7 << 0)
 #define PCI_MSIX_FLAGS_BITMASK		(1 << 0)
 
-#define PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET	0
-#define PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET	4
-#define PCI_MSIX_ENTRY_DATA_OFFSET		8
-#define PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET	12
 #define PCI_MSIX_ENTRY_SIZE			16
+#define  PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET	0
+#define  PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET	4
+#define  PCI_MSIX_ENTRY_DATA_OFFSET		8
+#define  PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET	12
 
 #define msi_control_reg(base)		(base + PCI_MSI_FLAGS)
 #define msi_lower_address_reg(base)	(base + PCI_MSI_ADDRESS_LO)
@@ -64,7 +64,6 @@ static inline void move_msi(int vector) 
 #define msi_enable(control, num) multi_msi_enable(control, num); \
 	control |= PCI_MSI_FLAGS_ENABLE
 
-#define msix_control_reg		msi_control_reg
 #define msix_table_offset_reg(base)	(base + 0x04)
 #define msix_pba_offset_reg(base)	(base + 0x08)
 #define msix_enable(control)	 	control |= PCI_MSIX_FLAGS_ENABLE

