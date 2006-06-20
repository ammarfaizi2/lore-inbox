Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWFTWbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWFTWbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWFTW3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:29:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55268 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751336AbWFTW2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:28:54 -0400
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
Subject: [PATCH 6/25] msi: Implement helper functions read_msi_msg and write_msi_msg.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:19 -0600
Message-Id: <11508425201406-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <1150842520235-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In support of this I also add a struct msi_msg that captures
the the two address and one data field ina typical msi message,
and I remember the pos and if the address is 64bit in
struct msi_desc.

This makes the code a little more readable and easier to maintain,
and paves the way to further simplfications.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi.c   |  195 +++++++++++++++++++++++++--------------------------
 drivers/pci/msi.h   |    9 +-
 include/linux/pci.h |    6 ++
 3 files changed, 104 insertions(+), 106 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c1c93f0..e9db6c5 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -94,63 +94,100 @@ static void msi_set_mask_bit(unsigned in
 	}
 }
 
-#ifdef CONFIG_SMP
-static void set_msi_affinity(unsigned int vector, cpumask_t cpu_mask)
+static void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
-	struct msi_desc *entry;
-	u32 address_hi, address_lo;
-	unsigned int irq = vector;
-	unsigned int dest_cpu = first_cpu(cpu_mask);
-
-	entry = (struct msi_desc *)msi_desc[vector];
-	if (!entry || !entry->dev)
-		return;
+	switch(entry->msi_attrib.type) {
+	case PCI_CAP_ID_MSI:
+	{
+		struct pci_dev *dev = entry->dev;
+		int pos = entry->msi_attrib.pos;
+		u16 data;
+
+		pci_read_config_dword(dev, msi_lower_address_reg(pos),
+					&msg->address_lo);
+		if (entry->msi_attrib.is_64) {
+			pci_read_config_dword(dev, msi_upper_address_reg(pos),
+						&msg->address_hi);
+			pci_read_config_word(dev, msi_data_reg(pos, 1), &data);
+		} else {
+			msg->address_hi = 0;
+			pci_read_config_word(dev, msi_data_reg(pos, 1), &data);
+		}
+		msg->data = data;
+		break;
+	}
+	case PCI_CAP_ID_MSIX:
+	{
+		void __iomem *base;
+		base = entry->mask_base + 
+			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+ 
+		msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
+		msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
+		msg->data = readl(base + PCI_MSIX_ENTRY_DATA_OFFSET);
+ 		break;
+ 	}
+ 	default:
+		BUG();
+	}
+}
 
+static void write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
+{
 	switch (entry->msi_attrib.type) {
 	case PCI_CAP_ID_MSI:
 	{
-		int pos = pci_find_capability(entry->dev, PCI_CAP_ID_MSI);
-
-		if (!pos)
-			return;
-
-		pci_read_config_dword(entry->dev, msi_upper_address_reg(pos),
-			&address_hi);
-		pci_read_config_dword(entry->dev, msi_lower_address_reg(pos),
-			&address_lo);
-
-		msi_ops->target(vector, dest_cpu, &address_hi, &address_lo);
-
-		pci_write_config_dword(entry->dev, msi_upper_address_reg(pos),
-			address_hi);
-		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
-			address_lo);
-		set_native_irq_info(irq, cpu_mask);
+		struct pci_dev *dev = entry->dev;
+		int pos = entry->msi_attrib.pos;
+
+		pci_write_config_dword(dev, msi_lower_address_reg(pos), 
+					msg->address_lo);
+		if (entry->msi_attrib.is_64) {
+			pci_write_config_dword(dev, msi_upper_address_reg(pos), 
+						msg->address_hi);
+			pci_write_config_word(dev, msi_data_reg(pos, 1), 
+						msg->data);
+		} else {
+			pci_write_config_word(dev, msi_data_reg(pos, 0), 
+						msg->data);
+		}
 		break;
 	}
 	case PCI_CAP_ID_MSIX:
 	{
-		int offset_hi =
-			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET;
-		int offset_lo =
-			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET;
-
-		address_hi = readl(entry->mask_base + offset_hi);
-		address_lo = readl(entry->mask_base + offset_lo);
-
-		msi_ops->target(vector, dest_cpu, &address_hi, &address_lo);
-
-		writel(address_hi, entry->mask_base + offset_hi);
-		writel(address_lo, entry->mask_base + offset_lo);
-		set_native_irq_info(irq, cpu_mask);
+		void __iomem *base;
+		base = entry->mask_base + 
+			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+
+		writel(msg->address_lo,
+			base + PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
+		writel(msg->address_hi,
+			base + PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
+		writel(msg->data, base + PCI_MSIX_ENTRY_DATA_OFFSET);
 		break;
 	}
 	default:
-		break;
+		BUG();
 	}
 }
+
+#ifdef CONFIG_SMP
+static void set_msi_affinity(unsigned int vector, cpumask_t cpu_mask)
+{
+	struct msi_desc *entry;
+	struct msi_msg msg;
+	unsigned int irq = vector;
+	unsigned int dest_cpu = first_cpu(cpu_mask);
+
+	entry = (struct msi_desc *)msi_desc[vector];
+	if (!entry || !entry->dev)
+		return;
+
+	read_msi_msg(entry, &msg);
+	msi_ops->target(vector, dest_cpu, &msg.address_hi, &msg.address_lo);
+	write_msi_msg(entry, &msg);
+	set_native_irq_info(irq, cpu_mask);
+}
 #else
 #define set_msi_affinity NULL
 #endif /* CONFIG_SMP */
@@ -614,23 +651,10 @@ int pci_save_msix_state(struct pci_dev *
 
 	vector = head = dev->irq;
 	while (head != tail) {
-		int j;
-		void __iomem *base;
 		struct msi_desc *entry;
 
 		entry = msi_desc[vector];
-		base = entry->mask_base;
-		j = entry->msi_attrib.entry_nr;
-
-		entry->address_lo_save =
-			readl(base + j * PCI_MSIX_ENTRY_SIZE +
-			      PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-		entry->address_hi_save =
-			readl(base + j * PCI_MSIX_ENTRY_SIZE +
-			      PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-		entry->data_save =
-			readl(base + j * PCI_MSIX_ENTRY_SIZE +
-			      PCI_MSIX_ENTRY_DATA_OFFSET);
+		read_msi_msg(entry, &entry->msg_save);
 
 		tail = msi_desc[vector]->link.tail;
 		vector = tail;
@@ -647,8 +671,6 @@ void pci_restore_msix_state(struct pci_d
 	u16 save;
 	int pos;
 	int vector, head, tail = 0;
-	void __iomem *base;
-	int j;
 	struct msi_desc *entry;
 	int temp;
 	struct pci_cap_saved_state *save_state;
@@ -671,18 +693,7 @@ void pci_restore_msix_state(struct pci_d
 	vector = head = dev->irq;
 	while (head != tail) {
 		entry = msi_desc[vector];
-		base = entry->mask_base;
-		j = entry->msi_attrib.entry_nr;
-
-		writel(entry->address_lo_save,
-			base + j * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-		writel(entry->address_hi_save,
-			base + j * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-		writel(entry->data_save,
-			base + j * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_DATA_OFFSET);
+		write_msi_msg(entry, &entry->msg_save);
 
 		tail = msi_desc[vector]->link.tail;
 		vector = tail;
@@ -697,29 +708,19 @@ #endif
 static int msi_register_init(struct pci_dev *dev, struct msi_desc *entry)
 {
 	int status;
-	u32 address_hi;
-	u32 address_lo;
-	u32 data;
+	struct msi_msg msg;
 	int pos, vector = dev->irq;
 	u16 control;
 
-   	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	pos = entry->msi_attrib.pos;
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 
 	/* Configure MSI capability structure */
-	status = msi_ops->setup(dev, vector, &address_hi, &address_lo, &data);
+	status = msi_ops->setup(dev, vector, &msg.address_hi, &msg.address_lo, &msg.data);
 	if (status < 0)
 		return status;
 
-	pci_write_config_dword(dev, msi_lower_address_reg(pos), address_lo);
-	if (is_64bit_address(control)) {
-		pci_write_config_dword(dev,
-			msi_upper_address_reg(pos), address_hi);
-		pci_write_config_word(dev,
-			msi_data_reg(pos, 1), data);
-	} else
-		pci_write_config_word(dev,
-			msi_data_reg(pos, 0), data);
+	write_msi_msg(entry, &msg);
 	if (entry->msi_attrib.maskbit) {
 		unsigned int maskbits, temp;
 		/* All MSIs are unmasked by default, Mask them all */
@@ -769,9 +770,11 @@ static int msi_capability_init(struct pc
 	entry->link.tail = vector;
 	entry->msi_attrib.type = PCI_CAP_ID_MSI;
 	entry->msi_attrib.state = 0;			/* Mark it not active */
+	entry->msi_attrib.is_64 = is_64bit_address(control);
 	entry->msi_attrib.entry_nr = 0;
 	entry->msi_attrib.maskbit = is_mask_bit_support(control);
 	entry->msi_attrib.default_vector = dev->irq;	/* Save IOAPIC IRQ */
+	entry->msi_attrib.pos = pos;
 	dev->irq = vector;
 	entry->dev = dev;
 	if (is_mask_bit_support(control)) {
@@ -809,9 +812,7 @@ static int msix_capability_init(struct p
 				struct msix_entry *entries, int nvec)
 {
 	struct msi_desc *head = NULL, *tail = NULL, *entry = NULL;
-	u32 address_hi;
-	u32 address_lo;
-	u32 data;
+	struct msi_msg msg;
 	int status;
 	int vector, pos, i, j, nr_entries, temp = 0;
 	unsigned long phys_addr;
@@ -848,9 +849,11 @@ static int msix_capability_init(struct p
  		entries[i].vector = vector;
 		entry->msi_attrib.type = PCI_CAP_ID_MSIX;
  		entry->msi_attrib.state = 0;		/* Mark it not active */
+		entry->msi_attrib.is_64 = 1;
 		entry->msi_attrib.entry_nr = j;
 		entry->msi_attrib.maskbit = 1;
 		entry->msi_attrib.default_vector = dev->irq;
+		entry->msi_attrib.pos = pos;
 		entry->dev = dev;
 		entry->mask_base = base;
 		if (!head) {
@@ -869,21 +872,13 @@ static int msix_capability_init(struct p
 		irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
 		/* Configure MSI-X capability structure */
 		status = msi_ops->setup(dev, vector,
-					&address_hi,
-					&address_lo,
-					&data);
+					&msg.address_hi,
+					&msg.address_lo,
+					&msg.data);
 		if (status < 0)
 			break;
 
-		writel(address_lo,
-			base + j * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-		writel(address_hi,
-			base + j * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-		writel(data,
-			base + j * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_DATA_OFFSET);
+		write_msi_msg(entry, &msg);
 		attach_msi_entry(entry, vector);
 	}
 	if (i != nvec) {
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 9b31d4c..62f61b6 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -130,10 +130,10 @@ struct msi_desc {
 		__u8	type	: 5; 	/* {0: unused, 5h:MSI, 11h:MSI-X} */
 		__u8	maskbit	: 1; 	/* mask-pending bit supported ?   */
 		__u8	state	: 1; 	/* {0: free, 1: busy}		  */
-		__u8	reserved: 1; 	/* reserved			  */
+		__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit  */
 		__u8	entry_nr;    	/* specific enabled entry 	  */
 		__u8	default_vector; /* default pre-assigned vector    */
-		__u8	unused; 	/* formerly unused destination cpu*/
+		__u8	pos;	 	/* Location of the msi capability */
 	}msi_attrib;
 
 	struct {
@@ -146,10 +146,7 @@ struct msi_desc {
 
 #ifdef CONFIG_PM
 	/* PM save area for MSIX address/data */
-
-	u32	address_hi_save;
-	u32	address_lo_save;
-	u32	data_save;
+	struct msi_msg msg_save;
 #endif
 };
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e36e3d5..c7be27b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -591,6 +591,12 @@ struct msix_entry {
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
+struct msi_msg {
+	u32	address_lo;	/* low 32 bits of msi message address */
+	u32	address_hi;	/* high 32 bits of msi message address */
+	u32	data;		/* 16 bits of msi message data */
+};
+
 #ifndef CONFIG_PCI_MSI
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
-- 
1.4.0.gc07e

