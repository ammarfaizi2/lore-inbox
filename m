Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWFTWge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWFTWge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWFTWgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:36:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57316 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751329AbWFTW3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:00 -0400
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
Subject: [PATCH 8/25] msi: Simplify the msi irq limit policy.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:21 -0600
Message-Id: <11508425213394-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <1150842520775-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we attempt to predict how many irqs we will be
able to allocate with msi using pci_vector_resources and some
complicated accounting, and then we only allow each device
as many irqs as we think are available on average.

Only the s2io driver even takes advantage of this feature
all other drivers have a fixed number of irqs they need and
bail if they can't get them.

pci_vector_resources is inaccurate if anyone ever frees an irq.
The whole implmentation is racy.  The current irq limit policy
does not appear to make sense with current drivers.  So I have
simplified things.  We can revisit this we we need a more sophisticated
policy.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/pci/irq.c |   30 -----------------------------
 arch/ia64/pci/pci.c |    9 ---------
 drivers/pci/msi.c   |   53 ++++++++-------------------------------------------
 drivers/pci/msi.h   |   11 -----------
 4 files changed, 8 insertions(+), 95 deletions(-)

diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
index 8ce6950..768584d 100644
--- a/arch/i386/pci/irq.c
+++ b/arch/i386/pci/irq.c
@@ -1170,33 +1170,3 @@ #endif
 	}
 	return 0;
 }
-
-int pci_vector_resources(int last, int nr_released)
-{
-	int count = nr_released;
-
-	int next = last;
-	int offset = (last % 8);
-
-	while (next < FIRST_SYSTEM_VECTOR) {
-		next += 8;
-#ifdef CONFIG_X86_64
-		if (next == IA32_SYSCALL_VECTOR)
-			continue;
-#else
-		if (next == SYSCALL_VECTOR)
-			continue;
-#endif
-		count++;
-		if (next >= FIRST_SYSTEM_VECTOR) {
-			if (offset%8) {
-				next = FIRST_DEVICE_VECTOR + offset;
-				offset++;
-				continue;
-			}
-			count--;
-		}
-	}
-
-	return count;
-}
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 5bef0e3..b0028fd 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -810,12 +810,3 @@ pcibios_prep_mwi (struct pci_dev *dev)
 	}
 	return rc;
 }
-
-int pci_vector_resources(int last, int nr_released)
-{
-	int count = nr_released;
-
-	count += (IA64_LAST_DEVICE_VECTOR - last);
-
-	return count;
-}
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 40499c0..772f5b6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -30,8 +30,6 @@ static kmem_cache_t* msi_cachep;
 static int pci_msi_enable = 1;
 static int last_alloc_vector;
 static int nr_released_vectors;
-static int nr_reserved_vectors = NR_HP_RESERVED_VECTORS;
-static int nr_msix_devices;
 
 #ifndef CONFIG_X86_IO_APIC
 int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
@@ -542,11 +540,6 @@ void pci_scan_msi_device(struct pci_dev 
 {
 	if (!dev)
 		return;
-
-   	if (pci_find_capability(dev, PCI_CAP_ID_MSIX) > 0)
-		nr_msix_devices++;
-	else if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0)
-		nr_reserved_vectors++;
 }
 
 #ifdef CONFIG_PM
@@ -877,13 +870,19 @@ static int msix_capability_init(struct p
 		attach_msi_entry(entry, vector);
 	}
 	if (i != nvec) {
+		int avail = i - 1;
 		i--;
 		for (; i >= 0; i--) {
 			vector = (entries + i)->vector;
 			msi_free_vector(dev, vector, 0);
 			(entries + i)->vector = 0;
 		}
-		return -EBUSY;
+		/* If we had some success report the number of irqs
+		 * we succeeded in setting up.
+		 */
+		if (avail <= 0)
+			avail = -EBUSY;
+		return avail;
 	}
 	/* Set MSI-X enabled bits */
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
@@ -943,14 +942,6 @@ int pci_enable_msi(struct pci_dev* dev)
 			return -EINVAL;
 	}
 	status = msi_capability_init(dev);
-	if (!status) {
-   		if (!pos)
-			nr_reserved_vectors--;	/* Only MSI capable */
-		else if (nr_msix_devices > 0)
-			nr_msix_devices--;	/* Both MSI and MSI-X capable,
-						   but choose enabling MSI */
-	}
-
 	return status;
 }
 
@@ -1060,10 +1051,9 @@ static int msi_free_vector(struct pci_de
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
 {
 	struct pci_bus *bus;
-	int status, pos, nr_entries, free_vectors;
+	int status, pos, nr_entries;
 	int i, j, temp;
 	u16 control;
-	unsigned long flags;
 
 	if (!pci_msi_enable || !dev || !entries)
  		return -EINVAL;
@@ -1109,34 +1099,7 @@ int pci_enable_msix(struct pci_dev* dev,
 		dev->irq = temp;
 		return -EINVAL;
 	}
-
-	spin_lock_irqsave(&msi_lock, flags);
-	/*
-	 * msi_lock is provided to ensure that enough vectors resources are
-	 * available before granting.
-	 */
-	free_vectors = pci_vector_resources(last_alloc_vector,
-				nr_released_vectors);
-	/* Ensure that each MSI/MSI-X device has one vector reserved by
-	   default to avoid any MSI-X driver to take all available
- 	   resources */
-	free_vectors -= nr_reserved_vectors;
-	/* Find the average of free vectors among MSI-X devices */
-	if (nr_msix_devices > 0)
-		free_vectors /= nr_msix_devices;
-	spin_unlock_irqrestore(&msi_lock, flags);
-
-	if (nvec > free_vectors) {
-		if (free_vectors > 0)
-			return free_vectors;
-		else
-			return -EBUSY;
-	}
-
 	status = msix_capability_init(dev, entries, nvec);
-	if (!status && nr_msix_devices > 0)
-		nr_msix_devices--;
-
 	return status;
 }
 
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 3519eca..6793241 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -8,19 +8,8 @@ #define MSI_H
 
 #include <asm/msi.h>
 
-/*
- * Assume the maximum number of hot plug slots supported by the system is about
- * ten. The worstcase is that each of these slots is hot-added with a device,
- * which has two MSI/MSI-X capable functions. To avoid any MSI-X driver, which
- * attempts to request all available vectors, NR_HP_RESERVED_VECTORS is defined
- * as below to ensure at least one message is assigned to each detected MSI/
- * MSI-X device function.
- */
-#define NR_HP_RESERVED_VECTORS 	20
-
 extern int vector_irq[NR_VECTORS];
 extern void (*interrupt[NR_IRQS])(void);
-extern int pci_vector_resources(int last, int nr_released);
 
 /*
  * MSI-X Address Register
-- 
1.4.0.gc07e

