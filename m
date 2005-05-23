Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVEWX0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVEWX0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVEWXXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:23:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:22404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261220AbVEWXVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:21:32 -0400
Date: Mon, 23 May 2005 16:21:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, olof@austin.ibm.com,
       dsd@gentoo.org
Subject: [patch 05/16] PPC64: Fix LPAR IOMMU setup code for p630
Message-ID: <20050523232103.GQ27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a fix to deal with p630 systems in LPAR mode.  They're to date the
only system that in some cases might lack a dma-window property for the
bus, but contain an overriding property in the device node for the specific
adapter/slot.  This makes the device setup code a bit more complex since it
needs to do some of the things that the bus setup code has already done.

Signed-off-by: Olof Johansson <olof@austin.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/ppc64/kernel/pSeries_iommu.c |   55 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 1 deletion(-)

--- linux-2.6.11.10.orig/arch/ppc64/kernel/pSeries_iommu.c	2005-05-16 10:50:31.000000000 -0700
+++ linux-2.6.11.10/arch/ppc64/kernel/pSeries_iommu.c	2005-05-20 09:36:25.091359360 -0700
@@ -401,6 +401,8 @@
 	struct device_node *dn, *pdn;
 	unsigned int *dma_window = NULL;
 
+	DBG("iommu_bus_setup_pSeriesLP, bus %p, bus->self %p\n", bus, bus->self);
+
 	dn = pci_bus_to_OF_node(bus);
 
 	/* Find nearest ibm,dma-window, walking up the device tree */
@@ -455,6 +457,56 @@
 	}
 }
 
+static void iommu_dev_setup_pSeriesLP(struct pci_dev *dev)
+{
+	struct device_node *pdn, *dn;
+	struct iommu_table *tbl;
+	int *dma_window = NULL;
+
+	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s)\n", dev, dev->pretty_name);
+
+	/* dev setup for LPAR is a little tricky, since the device tree might
+	 * contain the dma-window properties per-device and not neccesarily
+	 * for the bus. So we need to search upwards in the tree until we
+	 * either hit a dma-window property, OR find a parent with a table
+	 * already allocated.
+	 */
+	dn = pci_device_to_OF_node(dev);
+
+	for (pdn = dn; pdn && !pdn->iommu_table; pdn = pdn->parent) {
+		dma_window = (unsigned int *)get_property(pdn, "ibm,dma-window", NULL);
+		if (dma_window)
+			break;
+	}
+
+	/* Check for parent == NULL so we don't try to setup the empty EADS
+	 * slots on POWER4 machines.
+	 */
+	if (dma_window == NULL || pdn->parent == NULL) {
+		/* Fall back to regular (non-LPAR) dev setup */
+		DBG("No dma window for device, falling back to regular setup\n");
+		iommu_dev_setup_pSeries(dev);
+		return;
+	} else {
+		DBG("Found DMA window, allocating table\n");
+	}
+
+	if (!pdn->iommu_table) {
+		/* iommu_table_setparms_lpar needs bussubno. */
+		pdn->bussubno = pdn->phb->bus->number;
+
+		tbl = (struct iommu_table *)kmalloc(sizeof(struct iommu_table),
+						    GFP_KERNEL);
+
+		iommu_table_setparms_lpar(pdn->phb, pdn, tbl, dma_window);
+
+		pdn->iommu_table = iommu_init_table(tbl);
+	}
+
+	if (pdn != dn)
+		dn->iommu_table = pdn->iommu_table;
+}
+
 static void iommu_bus_setup_null(struct pci_bus *b) { }
 static void iommu_dev_setup_null(struct pci_dev *d) { }
 
@@ -479,13 +531,14 @@
 			ppc_md.tce_free	 = tce_free_pSeriesLP;
 		}
 		ppc_md.iommu_bus_setup = iommu_bus_setup_pSeriesLP;
+		ppc_md.iommu_dev_setup = iommu_dev_setup_pSeriesLP;
 	} else {
 		ppc_md.tce_build = tce_build_pSeries;
 		ppc_md.tce_free  = tce_free_pSeries;
 		ppc_md.iommu_bus_setup = iommu_bus_setup_pSeries;
+		ppc_md.iommu_dev_setup = iommu_dev_setup_pSeries;
 	}
 
-	ppc_md.iommu_dev_setup = iommu_dev_setup_pSeries;
 
 	pci_iommu_init();
 }
