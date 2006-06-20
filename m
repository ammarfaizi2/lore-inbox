Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWFTWbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWFTWbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWFTW3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:29:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53732 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751339AbWFTW2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:28:53 -0400
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
Subject: [PATCH 4/25] msi: Simplify msi enable and disable.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:17 -0600
Message-Id: <11508425191063-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425192220-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem.  Because the disable routines leave the msi interrupts in all
sorts of half enabled states the enable routines become impossible
to implement correctly, and almost impossible to understand.

Simplifing this allows me to simply kill the buggy reroute_msix_table,
and generally makes the code more maintainable.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi.c |  122 +++++++----------------------------------------------
 1 files changed, 16 insertions(+), 106 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 76d023d..c1c93f0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -915,7 +915,6 @@ int pci_enable_msi(struct pci_dev* dev)
 {
 	struct pci_bus *bus;
 	int pos, temp, status = -EINVAL;
-	u16 control;
 
 	if (!pci_msi_enable || !dev)
  		return status;
@@ -937,27 +936,8 @@ int pci_enable_msi(struct pci_dev* dev)
 	if (!pos)
 		return -EINVAL;
 
-	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
-		/* Lookup Sucess */
-		unsigned long flags;
+	BUG_ON(!msi_lookup_vector(dev, PCI_CAP_ID_MSI));
 
-		pci_read_config_word(dev, msi_control_reg(pos), &control);
-		if (control & PCI_MSI_FLAGS_ENABLE)
-			return 0;	/* Already in MSI mode */
-		spin_lock_irqsave(&msi_lock, flags);
-		if (!vector_irq[dev->irq]) {
-			msi_desc[dev->irq]->msi_attrib.state = 0;
-			vector_irq[dev->irq] = -1;
-			nr_released_vectors--;
-			spin_unlock_irqrestore(&msi_lock, flags);
-			status = msi_register_init(dev, msi_desc[dev->irq]);
-			if (status == 0)
-				enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
-			return status;
-		}
-		spin_unlock_irqrestore(&msi_lock, flags);
-		dev->irq = temp;
-	}
 	/* Check whether driver already requested for MSI-X vectors */
 	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	if (pos > 0 && !msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
@@ -999,6 +979,8 @@ void pci_disable_msi(struct pci_dev* dev
 	if (!(control & PCI_MSI_FLAGS_ENABLE))
 		return;
 
+	disable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+
 	spin_lock_irqsave(&msi_lock, flags);
 	entry = msi_desc[dev->irq];
 	if (!entry || !entry->dev || entry->msi_attrib.type != PCI_CAP_ID_MSI) {
@@ -1012,14 +994,12 @@ void pci_disable_msi(struct pci_dev* dev
 		       pci_name(dev), dev->irq);
 		BUG_ON(entry->msi_attrib.state > 0);
 	} else {
-		vector_irq[dev->irq] = 0; /* free it */
-		nr_released_vectors++;
 		default_vector = entry->msi_attrib.default_vector;
 		spin_unlock_irqrestore(&msi_lock, flags);
+		msi_free_vector(dev, dev->irq, 0);
+
 		/* Restore dev->irq to its default pin-assertion vector */
 		dev->irq = default_vector;
-		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
-					PCI_CAP_ID_MSI);
 	}
 }
 
@@ -1067,57 +1047,6 @@ static int msi_free_vector(struct pci_de
 	return 0;
 }
 
-static int reroute_msix_table(int head, struct msix_entry *entries, int *nvec)
-{
-	int vector = head, tail = 0;
-	int i, j = 0, nr_entries = 0;
-	void __iomem *base;
-	unsigned long flags;
-
-	spin_lock_irqsave(&msi_lock, flags);
-	while (head != tail) {
-		nr_entries++;
-		tail = msi_desc[vector]->link.tail;
-		if (entries[0].entry == msi_desc[vector]->msi_attrib.entry_nr)
-			j = vector;
-		vector = tail;
-	}
-	if (*nvec > nr_entries) {
-		spin_unlock_irqrestore(&msi_lock, flags);
-		*nvec = nr_entries;
-		return -EINVAL;
-	}
-	vector = ((j > 0) ? j : head);
-	for (i = 0; i < *nvec; i++) {
-		j = msi_desc[vector]->msi_attrib.entry_nr;
-		msi_desc[vector]->msi_attrib.state = 0;	/* Mark it not active */
-		vector_irq[vector] = -1;		/* Mark it busy */
-		nr_released_vectors--;
-		entries[i].vector = vector;
-		if (j != (entries + i)->entry) {
-			base = msi_desc[vector]->mask_base;
-			msi_desc[vector]->msi_attrib.entry_nr =
-				(entries + i)->entry;
-			writel( readl(base + j * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET), base +
-				(entries + i)->entry * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-			writel(	readl(base + j * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET), base +
-				(entries + i)->entry * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-			writel( (readl(base + j * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_DATA_OFFSET) & 0xff00) | vector,
-				base + (entries+i)->entry*PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_DATA_OFFSET);
-		}
-		vector = msi_desc[vector]->link.tail;
-	}
-	spin_unlock_irqrestore(&msi_lock, flags);
-
-	return 0;
-}
-
 /**
  * pci_enable_msix - configure device's MSI-X capability structure
  * @dev: pointer to the pci_dev data structure of MSI-X device function
@@ -1160,9 +1089,6 @@ int pci_enable_msix(struct pci_dev* dev,
  		return -EINVAL;
 
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
-	if (control & PCI_MSIX_FLAGS_ENABLE)
-		return -EINVAL;			/* Already in MSI-X mode */
-
 	nr_entries = multi_msix_capable(control);
 	if (nvec > nr_entries)
 		return -EINVAL;
@@ -1177,19 +1103,8 @@ int pci_enable_msix(struct pci_dev* dev,
 		}
 	}
 	temp = dev->irq;
-	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
-		/* Lookup Sucess */
-		nr_entries = nvec;
-		/* Reroute MSI-X table */
-		if (reroute_msix_table(dev->irq, entries, &nr_entries)) {
-			/* #requested > #previous-assigned */
-			dev->irq = temp;
-			return nr_entries;
-		}
-		dev->irq = temp;
-		enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
-		return 0;
-	}
+	BUG_ON(!msi_lookup_vector(dev, PCI_CAP_ID_MSIX));
+
 	/* Check whether driver already requested for MSI vector */
    	if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0 &&
 		!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
@@ -1248,37 +1163,32 @@ void pci_disable_msix(struct pci_dev* de
 	if (!(control & PCI_MSIX_FLAGS_ENABLE))
 		return;
 
+	disable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+
 	temp = dev->irq;
 	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
 		int state, vector, head, tail = 0, warning = 0;
 		unsigned long flags;
 
 		vector = head = dev->irq;
-		spin_lock_irqsave(&msi_lock, flags);
+		dev->irq = temp;			/* Restore pin IRQ */
 		while (head != tail) {
+			spin_lock_irqsave(&msi_lock, flags);
 			state = msi_desc[vector]->msi_attrib.state;
+			tail = msi_desc[vector]->link.tail;
+			spin_unlock_irqrestore(&msi_lock, flags);
 			if (state)
 				warning = 1;
-			else {
-				vector_irq[vector] = 0; /* free it */
-				nr_released_vectors++;
-			}
-			tail = msi_desc[vector]->link.tail;
+			else if (vector != head)	/* Release MSI-X vector */
+				msi_free_vector(dev, vector, 0);
 			vector = tail;
 		}
-		spin_unlock_irqrestore(&msi_lock, flags);
+		msi_free_vector(dev, vector, 0);
 		if (warning) {
-			dev->irq = temp;
 			printk(KERN_WARNING "PCI: %s: pci_disable_msix() called without "
 			       "free_irq() on all MSI-X vectors\n",
 			       pci_name(dev));
 			BUG_ON(warning > 0);
-		} else {
-			dev->irq = temp;
-			disable_msi_mode(dev,
-				pci_find_capability(dev, PCI_CAP_ID_MSIX),
-				PCI_CAP_ID_MSIX);
-
 		}
 	}
 }
-- 
1.4.0.gc07e

