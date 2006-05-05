Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWEERbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWEERbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWEERbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:31:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15274 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751186AbWEERbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:31:14 -0400
Date: Fri, 5 May 2006 13:31:02 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Morton Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH 3/6] kconfigurable resources driver others changes
Message-ID: <20060505173102.GE6450@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060505172847.GC6450@in.ibm.com> <20060505173002.GD6450@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505173002.GD6450@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes to files under driver/* except driver/pci/* which is covered in a
  separate patch.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/ieee1394/ohci1394.c                |    2 +-
 drivers/infiniband/hw/ipath/ipath_driver.c |    8 ++++----
 drivers/net/8139cp.c                       |    2 +-
 drivers/pcmcia/rsrc_nonstatic.c            |   13 ++++++++-----
 drivers/pnp/manager.c                      |   11 ++++++-----
 drivers/pnp/resource.c                     |    8 ++++----
 include/linux/pnp.h                        |    7 +++++--
 7 files changed, 29 insertions(+), 22 deletions(-)

diff -puN include/linux/pnp.h~kconfigurable-resources-drivers-others-changes include/linux/pnp.h
--- linux-2.6.17-rc3-mm1-1M/include/linux/pnp.h~kconfigurable-resources-drivers-others-changes	2006-05-05 11:56:25.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/include/linux/pnp.h	2006-05-05 11:56:25.000000000 -0400
@@ -389,7 +389,8 @@ int pnp_start_dev(struct pnp_dev *dev);
 int pnp_stop_dev(struct pnp_dev *dev);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
-void pnp_resource_change(struct resource *resource, u64 start, u64 size);
+void pnp_resource_change(struct resource *resource, resource_size_t start,
+				resource_size_t size);
 
 /* protocol helpers */
 int pnp_is_active(struct pnp_dev * dev);
@@ -434,7 +435,9 @@ static inline int pnp_start_dev(struct p
 static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline void pnp_resource_change(struct resource *resource, u64 start, u64 size) { }
+static inline void pnp_resource_change(struct resource *resource,
+					resource_size_t start,
+					resource_size_t size) { }
 
 /* protocol helpers */
 static inline int pnp_is_active(struct pnp_dev * dev) { return 0; }
diff -puN drivers/pnp/resource.c~kconfigurable-resources-drivers-others-changes drivers/pnp/resource.c
--- linux-2.6.17-rc3-mm1-1M/drivers/pnp/resource.c~kconfigurable-resources-drivers-others-changes	2006-05-05 11:56:25.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/pnp/resource.c	2006-05-05 11:56:25.000000000 -0400
@@ -241,7 +241,7 @@ int pnp_check_port(struct pnp_dev * dev,
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	u64 *port, *end, *tport, *tend;
+	resource_size_t *port, *end, *tport, *tend;
 	port = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 
@@ -297,7 +297,7 @@ int pnp_check_mem(struct pnp_dev * dev, 
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	u64 *addr, *end, *taddr, *tend;
+	resource_size_t *addr, *end, *taddr, *tend;
 	addr = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 
@@ -358,7 +358,7 @@ int pnp_check_irq(struct pnp_dev * dev, 
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	u64 * irq = &dev->res.irq_resource[idx].start;
+	resource_size_t * irq = &dev->res.irq_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.irq_resource[idx].flags))
@@ -423,7 +423,7 @@ int pnp_check_dma(struct pnp_dev * dev, 
 #ifndef CONFIG_IA64
 	int tmp;
 	struct pnp_dev *tdev;
-	u64 * dma = &dev->res.dma_resource[idx].start;
+	resource_size_t * dma = &dev->res.dma_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.dma_resource[idx].flags))
diff -puN drivers/pnp/manager.c~kconfigurable-resources-drivers-others-changes drivers/pnp/manager.c
--- linux-2.6.17-rc3-mm1-1M/drivers/pnp/manager.c~kconfigurable-resources-drivers-others-changes	2006-05-05 11:56:25.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/pnp/manager.c	2006-05-05 11:56:25.000000000 -0400
@@ -20,7 +20,7 @@ DECLARE_MUTEX(pnp_res_mutex);
 
 static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 {
-	u64 *start, *end;
+	resource_size_t *start, *end;
 	unsigned long *flags;
 
 	if (!dev || !rule)
@@ -64,7 +64,7 @@ static int pnp_assign_port(struct pnp_de
 
 static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 {
-	u64 *start, *end;
+	resource_size_t *start, *end;
 	unsigned long *flags;
 
 	if (!dev || !rule)
@@ -118,7 +118,7 @@ static int pnp_assign_mem(struct pnp_dev
 
 static int pnp_assign_irq(struct pnp_dev * dev, struct pnp_irq *rule, int idx)
 {
-	u64 *start, *end;
+	resource_size_t *start, *end;
 	unsigned long *flags;
 	int i;
 
@@ -171,7 +171,7 @@ static int pnp_assign_irq(struct pnp_dev
 
 static int pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 {
-	u64 *start, *end;
+	resource_size_t *start, *end;
 	unsigned long *flags;
 	int i;
 
@@ -586,7 +586,8 @@ int pnp_disable_dev(struct pnp_dev *dev)
  * @size: size of region
  *
  */
-void pnp_resource_change(struct resource *resource, u64 start, u64 size)
+void pnp_resource_change(struct resource *resource, resource_size_t start,
+				resource_size_t size)
 {
 	if (resource == NULL)
 		return;
diff -puN drivers/pcmcia/rsrc_nonstatic.c~kconfigurable-resources-drivers-others-changes drivers/pcmcia/rsrc_nonstatic.c
--- linux-2.6.17-rc3-mm1-1M/drivers/pcmcia/rsrc_nonstatic.c~kconfigurable-resources-drivers-others-changes	2006-05-05 11:56:25.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/pcmcia/rsrc_nonstatic.c	2006-05-05 11:56:25.000000000 -0400
@@ -72,7 +72,7 @@ static DEFINE_MUTEX(rsrc_mutex);
 ======================================================================*/
 
 static struct resource *
-make_resource(u64 b, u64 n, int flags, char *name)
+make_resource(resource_size_t b, resource_size_t n, int flags, char *name)
 {
 	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
 
@@ -86,7 +86,8 @@ make_resource(u64 b, u64 n, int flags, c
 }
 
 static struct resource *
-claim_region(struct pcmcia_socket *s, u64 base, u64 size, int type, char *name)
+claim_region(struct pcmcia_socket *s, resource_size_t base,
+		resource_size_t size, int type, char *name)
 {
 	struct resource *res, *parent;
 
@@ -517,10 +518,11 @@ struct pcmcia_align_data {
 };
 
 static void
-pcmcia_common_align(void *align_data, struct resource *res, u64 size, u64 align)
+pcmcia_common_align(void *align_data, struct resource *res,
+			resource_size_t size, resource_size_t align)
 {
 	struct pcmcia_align_data *data = align_data;
-	u64 start;
+	resource_size_t start;
 	/*
 	 * Ensure that we have the correct start address
 	 */
@@ -531,7 +533,8 @@ pcmcia_common_align(void *align_data, st
 }
 
 static void
-pcmcia_align(void *align_data, struct resource *res, u64 size, u64 align)
+pcmcia_align(void *align_data, struct resource *res, resource_size_t size,
+		resource_size_t align)
 {
 	struct pcmcia_align_data *data = align_data;
 	struct resource_map *m;
diff -puN drivers/ieee1394/ohci1394.c~kconfigurable-resources-drivers-others-changes drivers/ieee1394/ohci1394.c
--- linux-2.6.17-rc3-mm1-1M/drivers/ieee1394/ohci1394.c~kconfigurable-resources-drivers-others-changes	2006-05-05 11:56:25.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/ieee1394/ohci1394.c	2006-05-05 11:56:25.000000000 -0400
@@ -3210,7 +3210,7 @@ static int __devinit ohci1394_pci_probe(
 {
 	struct hpsb_host *host;
 	struct ti_ohci *ohci;	/* shortcut to currently handled device */
-	u64 ohci_base;
+	resource_size_t ohci_base;
 
         if (pci_enable_device(dev))
 		FAIL(-ENXIO, "Failed to enable OHCI hardware");
diff -puN drivers/infiniband/hw/ipath/ipath_driver.c~kconfigurable-resources-drivers-others-changes drivers/infiniband/hw/ipath/ipath_driver.c
--- linux-2.6.17-rc3-mm1-1M/drivers/infiniband/hw/ipath/ipath_driver.c~kconfigurable-resources-drivers-others-changes	2006-05-05 11:56:25.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/infiniband/hw/ipath/ipath_driver.c	2006-05-05 11:56:25.000000000 -0400
@@ -451,10 +451,10 @@ static int __devinit ipath_init_one(stru
 	for (j = 0; j < 6; j++) {
 		if (!pdev->resource[j].start)
 			continue;
-		ipath_cdbg(VERBOSE, "BAR %d start %lx, end %lx, len %lx\n",
-			   j, pdev->resource[j].start,
-			   pdev->resource[j].end,
-			   pci_resource_len(pdev, j));
+		ipath_cdbg(VERBOSE, "BAR %d start %llx, end %llx, len %llx\n",
+			   j, (unsigned long long)pdev->resource[j].start,
+			   (unsigned long long)pdev->resource[j].end,
+			   (unsigned long long)pci_resource_len(pdev, j));
 	}
 
 	if (!addr) {
diff -puN drivers/net/8139cp.c~kconfigurable-resources-drivers-others-changes drivers/net/8139cp.c
--- linux-2.6.17-rc3-mm1-1M/drivers/net/8139cp.c~kconfigurable-resources-drivers-others-changes	2006-05-05 11:56:25.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/drivers/net/8139cp.c	2006-05-05 11:56:25.000000000 -0400
@@ -1668,7 +1668,7 @@ static int cp_init_one (struct pci_dev *
 	struct cp_private *cp;
 	int rc;
 	void __iomem *regs;
-	u64 pciaddr;
+	resource_size_t pciaddr;
 	unsigned int addr_len, i, pci_using_dac;
 	u8 pci_rev;
 
_
