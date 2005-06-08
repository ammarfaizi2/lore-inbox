Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVFHGgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVFHGgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 02:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVFHGgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 02:36:41 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:51402 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262116AbVFHGgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 02:36:15 -0400
Date: Tue, 7 Jun 2005 23:35:59 -0700
From: Greg KH <gregkh@suse.de>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Cc: Roland Dreier <roland@topspin.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       ak@suse.de
Subject: [Penance PATCH] PCI: clean up the MSI code a bit
Message-ID: <20050608063559.GA22869@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'm very sorry for wasting people's time on this.  In the end, I
agree that the MSI code should stay as is.  It's just to complex and
confusing to enable it always for all devices at this time.  I'll put
the pci_enable/pci_disable idea on my TODO list to try to help out with
some of the logic that every-other pci driver seems to have to duplicate
all the time.  That seems like the best way forward.

So, here's a patch to try to make up for starting this discussion in the
first place.  It's a small cleanup to the MSI code to help make the irq
handling logic a bit easier to follow and understand (it also reduces
the size of the compiled code as a nice side benefit:
   text    data     bss     dec     hex filename
   7543     136     972    8651    21cb drivers/pci/msi.o - before patch
   7482     136     972    8590    218e drivers/pci/msi.o - after patch

Hey, every byte counts :)

I'm adding this to my pci tree and it will show up in the -mm tree
eventually.

thanks,

greg k-h

------------------

PCI: clean up the MSI code a bit.

Mostly just cleans up the irq handling logic to be smaller and a bit more
descriptive as to what it really does.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/msi.c |   88 ++++++++++++++++++++----------------------------------
 drivers/pci/msi.h |    9 ++---
 2 files changed, 37 insertions(+), 60 deletions(-)

--- gregkh-2.6.orig/drivers/pci/msi.c	2005-06-07 22:38:01.000000000 -0700
+++ gregkh-2.6/drivers/pci/msi.c	2005-06-07 23:12:29.000000000 -0700
@@ -28,10 +28,10 @@
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
@@ -170,44 +170,30 @@
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
@@ -216,6 +202,10 @@
 	ack_APIC_irq();
 }
 
+static void do_nothing(unsigned int vector)
+{
+}
+
 /*
  * Interrupt Type for MSI-X PCI/PCI-X/PCI-Express Devices,
  * which implement the MSI-X Capability Structure.
@@ -223,10 +213,10 @@
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
@@ -239,10 +229,10 @@
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
@@ -255,10 +245,10 @@
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
@@ -407,7 +397,7 @@
 {
 	struct msi_desc *entry;
 
-	entry = (struct msi_desc*) kmem_cache_alloc(msi_cachep, SLAB_KERNEL);
+	entry = kmem_cache_alloc(msi_cachep, SLAB_KERNEL);
 	if (!entry)
 		return NULL;
 
@@ -796,18 +786,6 @@
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
@@ -924,7 +902,7 @@
 /**
  * pci_enable_msix - configure device's MSI-X capability structure
  * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @data: pointer to an array of MSI-X entries
+ * @entries: pointer to an array of MSI-X entries
  * @nvec: number of MSI-X vectors requested for allocation by device driver
  *
  * Setup the MSI-X capability structure of device function with the number
--- gregkh-2.6.orig/drivers/pci/msi.h	2005-03-01 23:38:13.000000000 -0800
+++ gregkh-2.6/drivers/pci/msi.h	2005-06-07 23:10:43.000000000 -0700
@@ -41,11 +41,11 @@
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
@@ -64,7 +64,6 @@
 #define msi_enable(control, num) multi_msi_enable(control, num); \
 	control |= PCI_MSI_FLAGS_ENABLE
 
-#define msix_control_reg		msi_control_reg
 #define msix_table_offset_reg(base)	(base + 0x04)
 #define msix_pba_offset_reg(base)	(base + 0x08)
 #define msix_enable(control)	 	control |= PCI_MSIX_FLAGS_ENABLE
