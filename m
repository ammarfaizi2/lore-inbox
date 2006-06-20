Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWFTWi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWFTWi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWFTWi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:38:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56036 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751341AbWFTW24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:28:56 -0400
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
Subject: [PATCH 7/25] msi: Refactor the msi_ops.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:20 -0600
Message-Id: <1150842520775-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425201406-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current msi_ops are short sighted in a number of ways, this
patch attempts to fix the glaring deficiences.

- Report in msi_ops if a 64bit address is needed in the msi message,
  so we can fail 32bit only msi structures.

- Send and receive a full struct msi_msg in both setup and target.
  This is a little cleaner and allows for architectures that need
  to modify the data to retarget the msi interrupt to a different cpu.

- In target pass in the full cpu mask instead of just the first
  cpu in case we can make use of the full cpu mask.

- Operate in terms of irqs and not vectors, currently there
  is still a 1-1 relationship but on architectures other than
  ia64 I expect this will change.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi-altix.c |   49 +++++++++++++++++++------------------
 drivers/pci/msi-apic.c  |   36 ++++++++++++++-------------
 drivers/pci/msi.c       |   22 ++++++++---------
 drivers/pci/msi.h       |   62 -----------------------------------------------
 include/linux/pci.h     |   62 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 115 deletions(-)

diff --git a/drivers/pci/msi-altix.c b/drivers/pci/msi-altix.c
index bed4183..7aedc2a 100644
--- a/drivers/pci/msi-altix.c
+++ b/drivers/pci/msi-altix.c
@@ -26,7 +26,7 @@ struct sn_msi_info {
 static struct sn_msi_info *sn_msi_info;
 
 static void
-sn_msi_teardown(unsigned int vector)
+sn_msi_teardown(unsigned int irq)
 {
 	nasid_t nasid;
 	int widget;
@@ -36,7 +36,7 @@ sn_msi_teardown(unsigned int vector)
 	struct pcibus_bussoft *bussoft;
 	struct sn_pcibus_provider *provider;
 
-	sn_irq_info = sn_msi_info[vector].sn_irq_info;
+	sn_irq_info = sn_msi_info[irq].sn_irq_info;
 	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
 		return;
 
@@ -45,9 +45,9 @@ sn_msi_teardown(unsigned int vector)
 	provider = SN_PCIDEV_BUSPROVIDER(pdev);
 
 	(*provider->dma_unmap)(pdev,
-			       sn_msi_info[vector].pci_addr,
+			       sn_msi_info[irq].pci_addr,
 			       PCI_DMA_FROMDEVICE);
-	sn_msi_info[vector].pci_addr = 0;
+	sn_msi_info[irq].pci_addr = 0;
 
 	bussoft = SN_PCIDEV_BUSSOFT(pdev);
 	nasid = NASID_GET(bussoft->bs_base);
@@ -56,14 +56,13 @@ sn_msi_teardown(unsigned int vector)
 			SWIN_WIDGETNUM(bussoft->bs_base);
 
 	sn_intr_free(nasid, widget, sn_irq_info);
-	sn_msi_info[vector].sn_irq_info = NULL;
+	sn_msi_info[irq].sn_irq_info = NULL;
 
 	return;
 }
 
 int
-sn_msi_setup(struct pci_dev *pdev, unsigned int vector,
-	     u32 *addr_hi, u32 *addr_lo, u32 *data)
+sn_msi_setup(struct pci_dev *pdev, unsigned int irq, struct msi_msg *msg)
 {
 	int widget;
 	int status;
@@ -93,7 +92,7 @@ sn_msi_setup(struct pci_dev *pdev, unsig
 	if (! sn_irq_info)
 		return -ENOMEM;
 
-	status = sn_intr_alloc(nasid, widget, sn_irq_info, vector, -1, -1);
+	status = sn_intr_alloc(nasid, widget, sn_irq_info, irq, -1, -1);
 	if (status) {
 		kfree(sn_irq_info);
 		return -ENOMEM;
@@ -119,28 +118,27 @@ sn_msi_setup(struct pci_dev *pdev, unsig
 		return -ENOMEM;
 	}
 
-	sn_msi_info[vector].sn_irq_info = sn_irq_info;
-	sn_msi_info[vector].pci_addr = bus_addr;
+	sn_msi_info[irq].sn_irq_info = sn_irq_info;
+	sn_msi_info[irq].pci_addr = bus_addr;
 
-	*addr_hi = (u32)(bus_addr >> 32);
-	*addr_lo = (u32)(bus_addr & 0x00000000ffffffff);
+	msg->address_hi = (u32)(bus_addr >> 32);
+	msg->address_lo = (u32)(bus_addr & 0x00000000ffffffff);
 
 	/*
 	 * In the SN platform, bit 16 is a "send vector" bit which
 	 * must be present in order to move the vector through the system.
 	 */
-	*data = 0x100 + (unsigned int)vector;
+	msg->data = 0x100 + irq;
 
 #ifdef CONFIG_SMP
-	set_irq_affinity_info((vector & 0xff), sn_irq_info->irq_cpuid, 0);
+	set_irq_affinity_info(irq, sn_irq_info->irq_cpuid, 0);
 #endif
 
 	return 0;
 }
 
 static void
-sn_msi_target(unsigned int vector, unsigned int cpu,
-	      u32 *addr_hi, u32 *addr_lo)
+sn_msi_target(unsigned int irq, cpumask_t cpu_mask, struct msi_msg *msg)
 {
 	int slice;
 	nasid_t nasid;
@@ -150,8 +148,10 @@ sn_msi_target(unsigned int vector, unsig
 	struct sn_irq_info *sn_irq_info;
 	struct sn_irq_info *new_irq_info;
 	struct sn_pcibus_provider *provider;
+	unsigned int cpu;
 
-	sn_irq_info = sn_msi_info[vector].sn_irq_info;
+	cpu = first_cpu(cpu_mask);
+	sn_irq_info = sn_msi_info[irq].sn_irq_info;
 	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
 		return;
 
@@ -163,15 +163,15 @@ sn_msi_target(unsigned int vector, unsig
 	pdev = sn_pdev->pdi_linux_pcidev;
 	provider = SN_PCIDEV_BUSPROVIDER(pdev);
 
-	bus_addr = (u64)(*addr_hi) << 32 | (u64)(*addr_lo);
+	bus_addr = (u64)(msg->address_hi) << 32 | (u64)(msg->address_lo);
 	(*provider->dma_unmap)(pdev, bus_addr, PCI_DMA_FROMDEVICE);
-	sn_msi_info[vector].pci_addr = 0;
+	sn_msi_info[irq].pci_addr = 0;
 
 	nasid = cpuid_to_nasid(cpu);
 	slice = cpuid_to_slice(cpu);
 
 	new_irq_info = sn_retarget_vector(sn_irq_info, nasid, slice);
-	sn_msi_info[vector].sn_irq_info = new_irq_info;
+	sn_msi_info[irq].sn_irq_info = new_irq_info;
 	if (new_irq_info == NULL)
 		return;
 
@@ -184,12 +184,13 @@ sn_msi_target(unsigned int vector, unsig
 					sizeof(new_irq_info->irq_xtalkaddr),
 					SN_DMA_MSI|SN_DMA_ADDR_XIO);
 
-	sn_msi_info[vector].pci_addr = bus_addr;
-	*addr_hi = (u32)(bus_addr >> 32);
-	*addr_lo = (u32)(bus_addr & 0x00000000ffffffff);
+	sn_msi_info[irq].pci_addr = bus_addr;
+	msg->address_hi = (u32)(bus_addr >> 32);
+	msg->address_lo = (u32)(bus_addr & 0x00000000ffffffff);
 }
 
 struct msi_ops sn_msi_ops = {
+	.needs_64bit_address = 1,
 	.setup = sn_msi_setup,
 	.teardown = sn_msi_teardown,
 #ifdef CONFIG_SMP
@@ -201,7 +202,7 @@ int
 sn_msi_init(void)
 {
 	sn_msi_info =
-		kzalloc(sizeof(struct sn_msi_info) * NR_VECTORS, GFP_KERNEL);
+		kzalloc(sizeof(struct sn_msi_info) * NR_IRQS, GFP_KERNEL);
 	if (! sn_msi_info)
 		return -ENOMEM;
 
diff --git a/drivers/pci/msi-apic.c b/drivers/pci/msi-apic.c
index 5ed798b..1ce2589 100644
--- a/drivers/pci/msi-apic.c
+++ b/drivers/pci/msi-apic.c
@@ -46,37 +46,36 @@ #define     MSI_ADDR_REDIRECTION_LOWPRI	
 
 
 static void
-msi_target_apic(unsigned int vector,
-		unsigned int dest_cpu,
-		u32 *address_hi,	/* in/out */
-		u32 *address_lo)	/* in/out */
+msi_target_apic(unsigned int irq, cpumask_t cpu_mask, struct msi_msg *msg)
 {
-	u32 addr = *address_lo;
+	u32 addr = msg->address_lo;
 
 	addr &= MSI_ADDR_DESTID_MASK;
-	addr |= MSI_ADDR_DESTID_CPU(cpu_physical_id(dest_cpu));
+	addr |= MSI_ADDR_DESTID_CPU(cpu_physical_id(first_cpu(cpu_mask)));
 
-	*address_lo = addr;
+	msg->address_lo = addr;
 }
 
 static int
 msi_setup_apic(struct pci_dev *pdev,	/* unused in generic */
-		unsigned int vector,
-		u32 *address_hi,
-		u32 *address_lo,
-		u32 *data)
+		unsigned int irq,
+		struct msi_msg *msg)
 {
 	unsigned long	dest_phys_id;
+	unsigned int	vector;
 
 	dest_phys_id = cpu_physical_id(first_cpu(cpu_online_map));
+	vector = irq;
 
-	*address_hi = 0;
-	*address_lo =	MSI_ADDR_HEADER |
-			MSI_ADDR_DESTMODE_PHYS |
-			MSI_ADDR_REDIRECTION_CPU |
-			MSI_ADDR_DESTID_CPU(dest_phys_id);
+	msg->address_hi = 0;
+	msg->address_lo =
+		MSI_ADDR_HEADER |
+		MSI_ADDR_DESTMODE_PHYS |
+		MSI_ADDR_REDIRECTION_CPU |
+		MSI_ADDR_DESTID_CPU(dest_phys_id);
 
-	*data = MSI_DATA_TRIGGER_EDGE |
+	msg->data = 
+		MSI_DATA_TRIGGER_EDGE |
 		MSI_DATA_LEVEL_ASSERT |
 		MSI_DATA_DELIVERY_FIXED |
 		MSI_DATA_VECTOR(vector);
@@ -85,7 +84,7 @@ msi_setup_apic(struct pci_dev *pdev,	/* 
 }
 
 static void
-msi_teardown_apic(unsigned int vector)
+msi_teardown_apic(unsigned int irq)
 {
 	return;		/* no-op */
 }
@@ -95,6 +94,7 @@ msi_teardown_apic(unsigned int vector)
  */
 
 struct msi_ops msi_apic_ops = {
+	.needs_64bit_address = 0,
 	.setup = msi_setup_apic,
 	.teardown = msi_teardown_apic,
 	.target = msi_target_apic,
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e9db6c5..40499c0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -172,19 +172,17 @@ static void write_msi_msg(struct msi_des
 }
 
 #ifdef CONFIG_SMP
-static void set_msi_affinity(unsigned int vector, cpumask_t cpu_mask)
+static void set_msi_affinity(unsigned int irq, cpumask_t cpu_mask)
 {
 	struct msi_desc *entry;
 	struct msi_msg msg;
-	unsigned int irq = vector;
-	unsigned int dest_cpu = first_cpu(cpu_mask);
 
-	entry = (struct msi_desc *)msi_desc[vector];
+	entry = msi_desc[irq];
 	if (!entry || !entry->dev)
 		return;
 
 	read_msi_msg(entry, &msg);
-	msi_ops->target(vector, dest_cpu, &msg.address_hi, &msg.address_lo);
+	msi_ops->target(irq, cpu_mask, &msg);
 	write_msi_msg(entry, &msg);
 	set_native_irq_info(irq, cpu_mask);
 }
@@ -709,14 +707,14 @@ static int msi_register_init(struct pci_
 {
 	int status;
 	struct msi_msg msg;
-	int pos, vector = dev->irq;
+	int pos;
 	u16 control;
 
 	pos = entry->msi_attrib.pos;
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 
 	/* Configure MSI capability structure */
-	status = msi_ops->setup(dev, vector, &msg.address_hi, &msg.address_lo, &msg.data);
+	status = msi_ops->setup(dev, dev->irq, &msg);
 	if (status < 0)
 		return status;
 
@@ -871,10 +869,7 @@ static int msix_capability_init(struct p
 		/* Replace with MSI-X handler */
 		irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
 		/* Configure MSI-X capability structure */
-		status = msi_ops->setup(dev, vector,
-					&msg.address_hi,
-					&msg.address_lo,
-					&msg.data);
+		status = msi_ops->setup(dev, vector, &msg);
 		if (status < 0)
 			break;
 
@@ -910,6 +905,7 @@ int pci_enable_msi(struct pci_dev* dev)
 {
 	struct pci_bus *bus;
 	int pos, temp, status = -EINVAL;
+	u16 control;
 
 	if (!pci_msi_enable || !dev)
  		return status;
@@ -931,6 +927,10 @@ int pci_enable_msi(struct pci_dev* dev)
 	if (!pos)
 		return -EINVAL;
 
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	if (!is_64bit_address(control) && msi_ops->needs_64bit_address)
+		return -EINVAL;
+
 	BUG_ON(!msi_lookup_vector(dev, PCI_CAP_ID_MSI));
 
 	/* Check whether driver already requested for MSI-X vectors */
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 62f61b6..3519eca 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -6,68 +6,6 @@
 #ifndef MSI_H
 #define MSI_H
 
-/*
- * MSI operation vector.  Used by the msi core code (drivers/pci/msi.c)
- * to abstract platform-specific tasks relating to MSI address generation
- * and resource management.
- */
-struct msi_ops {
-	/**
-	 * setup - generate an MSI bus address and data for a given vector
-	 * @pdev: PCI device context (in)
-	 * @vector: vector allocated by the msi core (in)
-	 * @addr_hi: upper 32 bits of PCI bus MSI address (out)
-	 * @addr_lo: lower 32 bits of PCI bus MSI address (out)
-	 * @data: MSI data payload (out)
-	 *
-	 * Description: The setup op is used to generate a PCI bus addres and
-	 * data which the msi core will program into the card MSI capability
-	 * registers.  The setup routine is responsible for picking an initial
-	 * cpu to target the MSI at.  The setup routine is responsible for
-	 * examining pdev to determine the MSI capabilities of the card and
-	 * generating a suitable address/data.  The setup routine is
-	 * responsible for allocating and tracking any system resources it
-	 * needs to route the MSI to the cpu it picks, and for associating
-	 * those resources with the passed in vector.
-	 *
-	 * Returns 0 if the MSI address/data was successfully setup.
-	 **/
-
-	int	(*setup)    (struct pci_dev *pdev, unsigned int vector,
-			     u32 *addr_hi, u32 *addr_lo, u32 *data);
-
-	/**
-	 * teardown - release resources allocated by setup
-	 * @vector: vector context for resources (in)
-	 *
-	 * Description:  The teardown op is used to release any resources
-	 * that were allocated in the setup routine associated with the passed
-	 * in vector.
-	 **/
-
-	void	(*teardown) (unsigned int vector);
-
-	/**
-	 * target - retarget an MSI at a different cpu
-	 * @vector: vector context for resources (in)
-	 * @cpu:  new cpu to direct vector at (in)
-	 * @addr_hi: new value of PCI bus upper 32 bits (in/out)
-	 * @addr_lo: new value of PCI bus lower 32 bits (in/out)
-	 *
-	 * Description:  The target op is used to redirect an MSI vector
-	 * at a different cpu.  addr_hi/addr_lo coming in are the existing
-	 * values that the MSI core has programmed into the card.  The
-	 * target code is responsible for freeing any resources (if any)
-	 * associated with the old address, and generating a new PCI bus
-	 * addr_hi/addr_lo that will redirect the vector at the indicated cpu.
-	 **/
-
-	void	(*target)   (unsigned int vector, unsigned int cpu,
-			     u32 *addr_hi, u32 *addr_lo);
-};
-
-extern int msi_register(struct msi_ops *ops);
-
 #include <asm/msi.h>
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c7be27b..1aa01aa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -613,6 +613,68 @@ extern int pci_enable_msix(struct pci_de
 	struct msix_entry *entries, int nvec);
 extern void pci_disable_msix(struct pci_dev *dev);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+
+/*
+ * MSI operation vector.  Used by the msi core code (drivers/pci/msi.c)
+ * to abstract platform-specific tasks relating to MSI address generation
+ * and resource management.
+ */
+struct msi_ops {
+	int needs_64bit_address;
+	/**
+	 * setup - generate an MSI bus address and data for a given vector
+	 * @pdev: PCI device context (in)
+	 * @irq: irq allocated by the msi core (in)
+	 * @msg: PCI bus address and data for msi message (out)
+	 *
+	 * Description: The setup op is used to generate a PCI bus addres and
+	 * data which the msi core will program into the card MSI capability
+	 * registers.  The setup routine is responsible for picking an initial
+	 * cpu to target the MSI at.  The setup routine is responsible for
+	 * examining pdev to determine the MSI capabilities of the card and
+	 * generating a suitable address/data.  The setup routine is
+	 * responsible for allocating and tracking any system resources it
+	 * needs to route the MSI to the cpu it picks, and for associating
+	 * those resources with the passed in vector.
+	 *
+	 * Returns 0 if the MSI address/data was successfully setup.
+	 **/
+
+	int	(*setup)    (struct pci_dev *pdev, unsigned int irq,
+			     struct msi_msg *msg);
+
+	/**
+	 * teardown - release resources allocated by setup
+	 * @vector: vector context for resources (in)
+	 *
+	 * Description:  The teardown op is used to release any resources
+	 * that were allocated in the setup routine associated with the passed
+	 * in vector.
+	 **/
+
+	void	(*teardown) (unsigned int irq);
+
+	/**
+	 * target - retarget an MSI at a different cpu
+	 * @vector: vector context for resources (in)
+	 * @cpu:  new cpu to direct vector at (in)
+	 * @addr_hi: new value of PCI bus upper 32 bits (in/out)
+	 * @addr_lo: new value of PCI bus lower 32 bits (in/out)
+	 *
+	 * Description:  The target op is used to redirect an MSI vector
+	 * at a different cpu.  addr_hi/addr_lo coming in are the existing
+	 * values that the MSI core has programmed into the card.  The
+	 * target code is responsible for freeing any resources (if any)
+	 * associated with the old address, and generating a new PCI bus
+	 * addr_hi/addr_lo that will redirect the vector at the indicated cpu.
+	 **/
+
+	void	(*target)   (unsigned int irq, cpumask_t cpumask,
+			     struct msi_msg *msg);
+};
+
+extern int msi_register(struct msi_ops *ops);
+
 #endif
 
 extern void pci_block_user_cfg_access(struct pci_dev *dev);
-- 
1.4.0.gc07e

