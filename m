Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVBBKQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVBBKQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 05:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVBBKQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 05:16:57 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40414 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261462AbVBBKPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 05:15:38 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pci: Arch hook to determine config space size
Date: Wed, 2 Feb 2005 11:05:36 +0100
User-Agent: KMail/1.6.2
Cc: Brian King <brking@us.ibm.com>,
       Linux Arch list <linux-arch@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <41FF0B0D.8020003@us.ibm.com> <1107233864.5963.65.camel@gaston>
In-Reply-To: <1107233864.5963.65.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_1XKAC8uyjyiXm6C";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200502021105.42249.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_1XKAC8uyjyiXm6C
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dinsdag 01 Februar 2005 05:57, Benjamin Herrenschmidt wrote:
> BTW. I'm thinking about moving all those PCI/VIO related fields out of
> struct device_node to their own structure and keep only a pointer to
> that structure in device_node. That way, we avoid the bloat for every
> single non-pci node in the system, and we can have different structures
> for different bus types (along with proper iommu function pointers and
> that sort-of-thing).

How about something along the lines of this patch? Instead of adding a
pointer to the pci data from the device node, it embeds the node inside
a new struct pci_device_node. The patch is not complete and therefore
not expected to work as is, but maybe you want to reuse it.

The interesting part that is missing is creating and destroying=20
pci_device_nodes in prom.c, maybe you have an idea how to do that.

I'm also not sure about eeh. Are the eeh functions known to be called
only for device_nodes of PCI devices? If not, eeh_mode and=20
eeh_config_addr might have to stay inside of device_node.

	Arnd <><

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6-64/arch/ppc64/kernel/pci.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/pci.h	2005-01-24 23:46:37.0000000=
00 +0100
+++ linux-2.6-64/arch/ppc64/kernel/pci.h	2005-02-02 00:11:01.485740824 +0100
@@ -29,8 +29,8 @@
=20
 /* PCI device_node operations */
 struct device_node;
=2Dtypedef void *(*traverse_func)(struct device_node *me, void *data);
=2Dvoid *traverse_pci_devices(struct device_node *start, traverse_func pre,
+typedef void *(*traverse_func)(struct pci_device_node *me, void *data);
+void *traverse_pci_devices(struct pci_device_node *start, traverse_func pr=
e,
 		void *data);
=20
 void pci_devs_phb_init(void);
Index: linux-2.6-64/arch/ppc64/kernel/pSeries_iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/pSeries_iommu.c	2005-02-01 22:53:=
00.673332472 +0100
+++ linux-2.6-64/arch/ppc64/kernel/pSeries_iommu.c	2005-02-02 00:11:01.4867=
40672 +0100
@@ -48,7 +48,7 @@
=20
 #define DBG(fmt...)
=20
=2Dextern int is_python(struct device_node *);
+extern int is_python(struct pci_device_node *);
=20
 static void tce_build_pSeries(struct iommu_table *tbl, long index,=20
 			      long npages, unsigned long uaddr,=20
@@ -289,7 +289,7 @@
  * Currently we hard code these sizes (more or less).
  */
 static void iommu_table_setparms_lpar(struct pci_controller *phb,
=2D				      struct device_node *dn,
+				      struct pci_device_node *dn,
 				      struct iommu_table *tbl,
 				      unsigned int *dma_window)
 {
@@ -308,7 +308,7 @@
=20
 static void iommu_bus_setup_pSeries(struct pci_bus *bus)
 {
=2D	struct device_node *dn, *pdn;
+	struct pci_device_node *dn, *pdn;
=20
 	DBG("iommu_bus_setup_pSeries, bus %p, bus->self %p\n", bus, bus->self);
=20
@@ -331,7 +331,7 @@
=20
 			DBG("Python root bus %s\n", bus->name);
=20
=2D			iohole =3D (unsigned int *)get_property(dn, "io-hole", 0);
+			iohole =3D (unsigned int *)get_property(&dn->node, "io-hole", 0);
=20
 			if (iohole) {
 				/* On first bus we need to leave room for the
@@ -349,7 +349,7 @@
=20
 			tbl =3D kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
=20
=2D			iommu_table_setparms(dn->phb, dn, tbl);
+			iommu_table_setparms(dn->phb, &dn->node, tbl);
 			dn->iommu_table =3D iommu_init_table(tbl);
 		} else {
 			/* 256 MB window by default */
@@ -368,7 +368,7 @@
=20
 			tbl =3D kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
=20
=2D			iommu_table_setparms(dn->phb, dn, tbl);
+			iommu_table_setparms(dn->phb, &dn->node, tbl);
=20
 			dn->iommu_table =3D iommu_init_table(tbl);
 		} else {
@@ -382,17 +382,19 @@
 static void iommu_bus_setup_pSeriesLP(struct pci_bus *bus)
 {
 	struct iommu_table *tbl;
=2D	struct device_node *dn, *pdn;
+	struct pci_device_node *dn, *pdn;
+	struct device_node *n;
 	unsigned int *dma_window =3D NULL;
=20
 	dn =3D pci_bus_to_OF_node(bus);
=20
 	/* Find nearest ibm,dma-window, walking up the device tree */
=2D	for (pdn =3D dn; pdn !=3D NULL; pdn =3D pdn->parent) {
=2D		dma_window =3D (unsigned int *)get_property(pdn, "ibm,dma-window", NUL=
L);
+	for (n =3D &dn->node; n; n =3D n->parent) {
+		dma_window =3D (unsigned int *)get_property(n, "ibm,dma-window", NULL);
 		if (dma_window !=3D NULL)
 			break;
 	}
+	pdn =3D to_pci_node(n);
=20
 	if (dma_window =3D=3D NULL) {
 		DBG("iommu_bus_setup_pSeriesLP: bus %s seems to have no ibm,dma-window p=
roperty\n", dn->full_name);
@@ -420,7 +422,7 @@
=20
 static void iommu_dev_setup_pSeries(struct pci_dev *dev)
 {
=2D	struct device_node *dn, *mydn;
+	struct pci_device_node *dn, *mydn;
=20
 	DBG("iommu_dev_setup_pSeries, dev %p (%s)\n", dev, dev->pretty_name);
 	/* Now copy the iommu_table ptr from the bus device down to the
@@ -430,7 +432,7 @@
 	mydn =3D dn =3D pci_device_to_OF_node(dev);
=20
 	while (dn && dn->iommu_table =3D=3D NULL)
=2D		dn =3D dn->parent;
+		dn =3D to_pci_node(dn->node.parent);
=20
 	if (dn) {
 		mydn->iommu_table =3D dn->iommu_table;
Index: linux-2.6-64/include/asm-ppc64/pci-bridge.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/include/asm-ppc64/pci-bridge.h	2005-01-24 23:47:11.=
000000000 +0100
+++ linux-2.6-64/include/asm-ppc64/pci-bridge.h	2005-02-02 00:11:01.4867406=
72 +0100
@@ -53,22 +53,23 @@
 /* Get a device_node from a pci_dev.  This code must be fast except in the=
 case
  * where the sysdata is incorrect and needs to be fixed up (hopefully just=
 once)
  */
=2Dstatic inline struct device_node *pci_device_to_OF_node(struct pci_dev *=
dev)
+static inline struct pci_device_node *pci_device_to_OF_node(struct pci_dev=
 *dev)
 {
 	struct device_node *dn =3D dev->sysdata;
+	struct pci_device_node *pdn =3D to_pci_node(dn);
=20
=2D	if (dn->devfn =3D=3D dev->devfn && dn->busno =3D=3D dev->bus->number)
=2D		return dn;	/* fast path.  sysdata is good */
+	if (pdn->devfn =3D=3D dev->devfn && pdn->busno =3D=3D dev->bus->number)
+		return pdn;	/* fast path.  sysdata is good */
 	else
=2D		return fetch_dev_dn(dev);
+		return to_pci_node(fetch_dev_dn(dev));
 }
=20
=2Dstatic inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus)
+static inline struct pci_device_node *pci_bus_to_OF_node(struct pci_bus *b=
us)
 {
 	if (bus->self)
 		return pci_device_to_OF_node(bus->self);
 	else
=2D		return bus->sysdata; /* Must be root bus (PHB) */
+		return to_pci_node(bus->sysdata); /* Must be root bus (PHB) */
 }
=20
 extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
@@ -83,7 +84,7 @@
 	struct device_node *busdn =3D bus->sysdata;
=20
 	BUG_ON(busdn =3D=3D NULL);
=2D	return busdn->phb;
+	return to_pci_node(busdn)->phb;
 }
=20
 #endif
Index: linux-2.6-64/include/asm-ppc64/eeh.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/include/asm-ppc64/eeh.h	2005-02-01 22:32:12.3611047=
76 +0100
+++ linux-2.6-64/include/asm-ppc64/eeh.h	2005-02-02 00:11:01.487740520 +0100
@@ -27,7 +27,7 @@
=20
 struct pci_dev;
 struct device_node;
=2Dstruct device_node;
+struct pci_device_node;
 struct notifier_block;
=20
 #ifdef CONFIG_EEH
@@ -40,7 +40,7 @@
 void __init eeh_init(void);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
 				unsigned long val);
=2Dint eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev);
+int eeh_dn_check_failure(struct pci_device_node *dn, struct pci_dev *dev);
 void __init pci_addr_cache_build(void);
=20
 /**
@@ -52,7 +52,7 @@
  * device (including config space i/o).  Call eeh_add_device_late
  * to finish the eeh setup for this device.
  */
=2Dvoid eeh_add_device_early(struct device_node *);
+void eeh_add_device_early(struct pci_device_node *);
 void eeh_add_device_late(struct pci_dev *);
=20
 /**
Index: linux-2.6-64/arch/ppc64/kernel/sys_ppc32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/sys_ppc32.c	2005-02-01 22:53:00.6=
73332472 +0100
+++ linux-2.6-64/arch/ppc64/kernel/sys_ppc32.c	2005-02-02 00:11:01.48774052=
0 +0100
@@ -744,7 +744,7 @@
 	struct pci_controller* hose;
 	struct list_head *ln;
 	struct pci_bus *bus =3D NULL;
=2D	struct device_node *hose_node;
+	struct pci_device_node *hose_node;
=20
 	/* Argh ! Please forgive me for that hack, but that's the
 	 * simplest way to get existing XFree to not lockup on some
@@ -771,7 +771,7 @@
 	if (bus =3D=3D NULL || bus->sysdata =3D=3D NULL)
 		return -ENODEV;
=20
=2D	hose_node =3D (struct device_node *)bus->sysdata;
+	hose_node =3D to_pci_node(bus->sysdata);
 	hose =3D hose_node->phb;
=20
 	switch (which) {
Index: linux-2.6-64/arch/ppc64/kernel/iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/iommu.c	2005-01-24 23:46:37.00000=
0000 +0100
+++ linux-2.6-64/arch/ppc64/kernel/iommu.c	2005-02-02 00:11:01.488740368 +0=
100
@@ -432,7 +432,7 @@
 	return tbl;
 }
=20
=2Dvoid iommu_free_table(struct device_node *dn)
+void iommu_free_table(struct pci_device_node *dn)
 {
 	struct iommu_table *tbl =3D dn->iommu_table;
 	unsigned long bitmap_sz, i;
@@ -440,7 +440,7 @@
=20
 	if (!tbl || !tbl->it_map) {
 		printk(KERN_ERR "%s: expected TCE map for %s\n", __FUNCTION__,
=2D				dn->full_name);
+				dn->node.full_name);
 		return;
 	}
=20
@@ -449,7 +449,7 @@
 	for (i =3D 0; i < (tbl->it_size/64); i++) {
 		if (tbl->it_map[i] !=3D 0) {
 			printk(KERN_WARNING "%s: Unexpected TCEs for %s\n",
=2D				__FUNCTION__, dn->full_name);
+				__FUNCTION__, dn->node.full_name);
 			break;
 		}
 	}
Index: linux-2.6-64/include/asm-ppc64/iommu.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/include/asm-ppc64/iommu.h	2005-01-24 23:47:11.00000=
0000 +0100
+++ linux-2.6-64/include/asm-ppc64/iommu.h	2005-02-02 00:11:01.488740368 +0=
100
@@ -101,6 +101,7 @@
 #endif /* CONFIG_PPC_ISERIES */
=20
 struct scatterlist;
+struct pci_device_node;
=20
 #ifdef CONFIG_PPC_MULTIPLATFORM
=20
@@ -109,14 +110,14 @@
 extern void iommu_setup_u3(void);
=20
 /* Frees table for an individual device node */
=2Dextern void iommu_free_table(struct device_node *dn);
+extern void iommu_free_table(struct pci_device_node *dn);
=20
 #endif /* CONFIG_PPC_MULTIPLATFORM */
=20
 #ifdef CONFIG_PPC_PSERIES
=20
 /* Creates table for an individual device node */
=2Dextern void iommu_devnode_init_pSeries(struct device_node *dn);
+extern void iommu_devnode_init_pSeries(struct pci_device_node *dn);
=20
 #endif /* CONFIG_PPC_PSERIES */
=20
Index: linux-2.6-64/arch/ppc64/kernel/pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/pci.c	2005-01-24 23:46:36.0000000=
00 +0100
+++ linux-2.6-64/arch/ppc64/kernel/pci.c	2005-02-02 00:11:01.489740216 +0100
@@ -447,13 +447,13 @@
 static ssize_t pci_show_devspec(struct device *dev, char *buf)
 {
 	struct pci_dev *pdev;
=2D	struct device_node *np;
+	struct pci_device_node *np;
=20
 	pdev =3D to_pci_dev (dev);
 	np =3D pci_device_to_OF_node(pdev);
=2D	if (np =3D=3D NULL || np->full_name =3D=3D NULL)
+	if (np =3D=3D NULL || np->node.full_name =3D=3D NULL)
 		return 0;
=2D	return sprintf(buf, "%s", np->full_name);
+	return sprintf(buf, "%s", np->node.full_name);
 }
 static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
 #endif /* CONFIG_PPC_MULTIPLATFORM */
@@ -734,7 +734,8 @@
  */
 int pcibios_scan_all_fns(struct pci_bus *bus, int devfn)
 {
=2D       struct device_node *busdn, *dn;
+       struct pci_device_node *busdn;
+       struct device_node *dn;
=20
        if (bus->self)
                busdn =3D pci_device_to_OF_node(bus->self);
@@ -749,8 +750,8 @@
         * device tree.  If they are then we need to scan all the
         * functions of this slot.
         */
=2D       for (dn =3D busdn->child; dn; dn =3D dn->sibling)
=2D               if ((dn->devfn >> 3) =3D=3D (devfn >> 3))
+       for (dn =3D busdn->node.child; dn; dn =3D dn->sibling)
+               if ((to_pci_node(dn)->devfn >> 3) =3D=3D (devfn >> 3))
                        return 1;
=20
        return 0;
@@ -851,7 +852,7 @@
 int pci_read_irq_line(struct pci_dev *pci_dev)
 {
 	u8 intpin;
=2D	struct device_node *node;
+	struct pci_device_node *node;
=20
     	pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &intpin);
 	if (intpin =3D=3D 0)
@@ -861,10 +862,10 @@
 	if (node =3D=3D NULL)
 		return -1;
=20
=2D	if (node->n_intrs =3D=3D 0)
+	if (node->node.n_intrs =3D=3D 0)
 		return -1;
=20
=2D	pci_dev->irq =3D node->intrs[0].line;
+	pci_dev->irq =3D node->node.intrs[0].line;
=20
 	pci_write_config_byte(pci_dev, PCI_INTERRUPT_LINE, pci_dev->irq);
=20
Index: linux-2.6-64/include/asm-ppc64/prom.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/include/asm-ppc64/prom.h	2005-02-01 22:32:12.365104=
168 +0100
+++ linux-2.6-64/include/asm-ppc64/prom.h	2005-02-02 00:11:01.490740064 +01=
00
@@ -131,15 +131,6 @@
 	struct	interrupt_info *intrs;
 	char	*full_name;
=20
=2D	/* PCI stuff probably doesn't belong here */
=2D	int	busno;			/* for pci devices */
=2D	int	bussubno;		/* for pci devices */
=2D	int	devfn;			/* for pci devices */
=2D	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
=2D	int	eeh_config_addr;
=2D	struct  pci_controller *phb;	/* for pci devices */
=2D	struct	iommu_table *iommu_table;	/* for phb's or bridges */
=2D
 	struct	property *properties;
 	struct	device_node *parent;
 	struct	device_node *child;
@@ -153,6 +144,22 @@
 	unsigned long _flags;
 };
=20
+struct pci_device_node {
+	int	busno;
+	int	bussubno;
+	int	devfn;
+	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
+	int	eeh_config_addr;
+	struct  pci_controller *phb;
+	struct	iommu_table *iommu_table;	/* for phb's or bridges */
+	struct  device_node node;
+};
+
+static inline struct pci_device_node *to_pci_node(struct device_node *n)
+{
+	return n ? container_of(n, struct pci_device_node, node) : NULL;
+}
+
 extern struct device_node *of_chosen;
=20
 /* flag descriptions */
Index: linux-2.6-64/arch/ppc64/kernel/pci_iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/pci_iommu.c	2005-01-24 23:46:37.0=
00000000 +0100
+++ linux-2.6-64/arch/ppc64/kernel/pci_iommu.c	2005-02-02 00:11:01.49074006=
4 +0100
@@ -48,7 +48,7 @@
  * pci_device_to_OF_node since ->sysdata will have been initialised
  * in the iommu init code for all devices.
  */
=2D#define PCI_GET_DN(dev) ((struct device_node *)((dev)->sysdata))
+#define PCI_GET_DN(dev) (to_pci_node(((dev)->sysdata)))
=20
 static inline struct iommu_table *devnode_table(struct pci_dev *dev)
 {
Index: linux-2.6-64/arch/ppc64/kernel/pci_dn.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/pci_dn.c	2005-01-24 23:46:37.0000=
00000 +0100
+++ linux-2.6-64/arch/ppc64/kernel/pci_dn.c	2005-02-02 00:11:01.490740064 +=
0100
@@ -34,13 +34,13 @@
  * Traverse_func that inits the PCI fields of the device node.
  * NOTE: this *must* be done before read/write config to the device.
  */
=2Dstatic void * __devinit update_dn_pci_info(struct device_node *dn, void =
*data)
+static void * __devinit update_dn_pci_info(struct pci_device_node *dn, voi=
d *data)
 {
 	struct pci_controller *phb =3D data;
 	u32 *regs;
=20
 	dn->phb =3D phb;
=2D	regs =3D (u32 *)get_property(dn, "reg", NULL);
+	regs =3D (u32 *)get_property(&dn->node, "reg", NULL);
 	if (regs) {
 		/* First register entry is addr (00BBSS00)  */
 		dn->busno =3D (regs[0] >> 16) & 0xff;
@@ -67,21 +67,21 @@
  * one of these nodes we also assume its siblings are non-pci for
  * performance.
  */
=2Dvoid *traverse_pci_devices(struct device_node *start, traverse_func pre,
+void *traverse_pci_devices(struct pci_device_node *start, traverse_func pr=
e,
 		void *data)
 {
 	struct device_node *dn, *nextdn;
 	void *ret;
=20
 	/* We started with a phb, iterate all childs */
=2D	for (dn =3D start->child; dn; dn =3D nextdn) {
+	for (dn =3D start->node.child; dn; dn =3D nextdn) {
 		u32 *classp, class;
=20
 		nextdn =3D NULL;
 		classp =3D (u32 *)get_property(dn, "class-code", NULL);
 		class =3D classp ? *classp : 0;
=20
=2D		if (pre && ((ret =3D pre(dn, data)) !=3D NULL))
+		if (pre && ((ret =3D pre(to_pci_node(dn), data)) !=3D NULL))
 			return ret;
=20
 		/* If we are a PCI bridge, go down */
@@ -96,7 +96,7 @@
 			/* Walk up to next valid sibling. */
 			do {
 				dn =3D dn->parent;
=2D				if (dn =3D=3D start)
+				if (dn =3D=3D &start->node)
 					return NULL;
 			} while (dn->sibling =3D=3D NULL);
 			nextdn =3D dn->sibling;
@@ -107,7 +107,7 @@
=20
 void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
 {
=2D	struct device_node * dn =3D (struct device_node *) phb->arch_data;
+	struct pci_device_node *dn =3D to_pci_node(phb->arch_data);
=20
 	/* PHB nodes themselves must not match */
 	dn->devfn =3D dn->busno =3D -1;
@@ -121,7 +121,7 @@
  * Traversal func that looks for a <busno,devfcn> value.
  * If found, the device_node is returned (thus terminating the traversal).
  */
=2Dstatic void *is_devfn_node(struct device_node *dn, void *data)
+static void *is_devfn_node(struct pci_device_node *dn, void *data)
 {
 	int busno =3D ((unsigned long)data >> 8) & 0xff;
 	int devfn =3D ((unsigned long)data) & 0xff;
@@ -144,13 +144,13 @@
  */
 struct device_node *fetch_dev_dn(struct pci_dev *dev)
 {
=2D	struct device_node *orig_dn =3D dev->sysdata;
+	struct pci_device_node *orig_dn =3D to_pci_node(dev->sysdata);
 	struct pci_controller *phb =3D orig_dn->phb; /* assume same phb as orig_d=
n */
=2D	struct device_node *phb_dn;
+	struct pci_device_node *phb_dn;
 	struct device_node *dn;
 	unsigned long searchval =3D (dev->bus->number << 8) | dev->devfn;
=20
=2D	phb_dn =3D phb->arch_data;
+	phb_dn =3D to_pci_node(phb->arch_data);
 	dn =3D traverse_pci_devices(phb_dn, is_devfn_node, (void *)searchval);
 	if (dn)
 		dev->sysdata =3D dn;
Index: linux-2.6-64/arch/ppc64/kernel/eeh.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/eeh.c	2005-02-02 00:10:53.1260116=
96 +0100
+++ linux-2.6-64/arch/ppc64/kernel/eeh.c	2005-02-02 00:11:06.039048616 +0100
@@ -254,7 +254,7 @@
=20
 static void __pci_addr_cache_insert_device(struct pci_dev *dev)
 {
=2D	struct device_node *dn;
+	struct pci_device_node *dn;
 	int i;
 	int inserted =3D 0;
=20
@@ -413,7 +413,7 @@
  * @dn: device node to read
  * @rets: array to return results in
  */
=2Dstatic int read_slot_reset_state(struct device_node *dn, int rets[])
+static int read_slot_reset_state(struct pci_device_node *dn, int rets[])
 {
 	int token, outputs;
=20
@@ -528,7 +528,7 @@
  *
  * It is safe to call this routine in an interrupt context.
  */
=2Dint eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
+int eeh_dn_check_failure(struct pci_device_node *dn, struct pci_dev *dev)
 {
 	int ret;
 	int rets[3];
@@ -603,7 +603,7 @@
 	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
=20
 	printk(KERN_INFO "EEH: MMIO failure (%d) on device: %s %s\n",
=2D	       rets[0], dn->name, dn->full_name);
+	       rets[0], dn->node.name, dn->node.full_name);
 	event =3D kmalloc(sizeof(*event), GFP_ATOMIC);
 	if (event =3D=3D NULL) {
 		eeh_panic(dev, reset_state);
@@ -611,7 +611,7 @@
  	}
=20
 	event->dev =3D dev;
=2D	event->dn =3D dn;
+	event->dn =3D &dn->node;
 	event->reset_state =3D reset_state;
=20
 	/* We may or may not be called in an interrupt context */
@@ -647,7 +647,7 @@
 {
 	unsigned long addr;
 	struct pci_dev *dev;
=2D	struct device_node *dn;
+	struct pci_device_node *dn;
=20
 	/* Finding the phys addr + pci device; this is pretty quick. */
 	addr =3D eeh_token_to_phys((unsigned long __force) token);
@@ -670,8 +670,9 @@
 };
=20
 /* Enable eeh for the given device node. */
=2Dstatic void *early_enable_eeh(struct device_node *dn, void *data)
+static void *early_enable_eeh(struct pci_device_node *pdn, void *data)
 {
+	struct device_node *dn =3D &pdn->node;
 	struct eeh_early_enable_info *info =3D data;
 	int ret;
 	char *status =3D get_property(dn, "status", NULL);
@@ -681,7 +682,7 @@
 	u32 *regs;
 	int enable;
=20
=2D	dn->eeh_mode =3D 0;
+	pdn->eeh_mode =3D 0;
=20
 	if (status && strcmp(status, "ok") !=3D 0)
 		return NULL;	/* ignore devices with bad status */
@@ -692,7 +693,7 @@
=20
 	/* There is nothing to check on PCI to ISA bridges */
 	if (dn->type && !strcmp(dn->type, "isa")) {
=2D		dn->eeh_mode |=3D EEH_MODE_NOCHECK;
+		pdn->eeh_mode |=3D EEH_MODE_NOCHECK;
 		return NULL;
 	}
=20
@@ -709,7 +710,7 @@
 		enable =3D 0;
=20
 	if (!enable)
=2D		dn->eeh_mode |=3D EEH_MODE_NOCHECK;
+		pdn->eeh_mode |=3D EEH_MODE_NOCHECK;
=20
 	/* Ok... see if this device supports EEH.  Some do, some don't,
 	 * and the only way to find out is to check each and every one. */
@@ -722,8 +723,8 @@
 				EEH_ENABLE);
 		if (ret =3D=3D 0) {
 			eeh_subsystem_enabled =3D 1;
=2D			dn->eeh_mode |=3D EEH_MODE_SUPPORTED;
=2D			dn->eeh_config_addr =3D regs[0];
+			pdn->eeh_mode |=3D EEH_MODE_SUPPORTED;
+			pdn->eeh_config_addr =3D regs[0];
 #ifdef DEBUG
 			printk(KERN_DEBUG "EEH: %s: eeh enabled\n", dn->full_name);
 #endif
@@ -731,10 +732,12 @@
=20
 			/* This device doesn't support EEH, but it may have an
 			 * EEH parent, in which case we mark it as supported. */
=2D			if (dn->parent && (dn->parent->eeh_mode & EEH_MODE_SUPPORTED)) {
+			if (dn->parent && (to_pci_node(dn->parent)->eeh_mode
+							& EEH_MODE_SUPPORTED)) {
 				/* Parent supports EEH. */
=2D				dn->eeh_mode |=3D EEH_MODE_SUPPORTED;
=2D				dn->eeh_config_addr =3D dn->parent->eeh_config_addr;
+				pdn->eeh_mode |=3D EEH_MODE_SUPPORTED;
+				pdn->eeh_config_addr =3D
+					to_pci_node(dn->parent)->eeh_config_addr;
 				return NULL;
 			}
 		}
@@ -798,7 +801,7 @@
=20
 		info.buid_lo =3D BUID_LO(buid);
 		info.buid_hi =3D BUID_HI(buid);
=2D		traverse_pci_devices(phb, early_enable_eeh, &info);
+		traverse_pci_devices(to_pci_node(phb), early_enable_eeh, &info);
 	}
=20
 	if (eeh_subsystem_enabled)
@@ -819,7 +822,7 @@
  * on the CEC architecture, type of the device, on earlier boot
  * command-line arguments & etc.
  */
=2Dvoid eeh_add_device_early(struct device_node *dn)
+void eeh_add_device_early(struct pci_device_node *dn)
 {
 	struct pci_controller *phb;
 	struct eeh_early_enable_info info;
Index: linux-2.6-64/arch/ppc64/kernel/prom.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/prom.c	2005-02-02 00:10:53.129011=
240 +0100
+++ linux-2.6-64/arch/ppc64/kernel/prom.c	2005-02-02 00:11:06.041048312 +01=
00
@@ -1802,8 +1802,11 @@
  */
 static void of_cleanup_node(struct device_node *np)
 {
=2D	if (np->iommu_table && get_property(np, "ibm,dma-window", NULL))
=2D		iommu_free_table(np);
+	if (get_property(np, "ibm,dma-window", NULL)) {
+		struct pci_device_node *p =3D to_pci_node(np);
+		if (p->iommu_table)
+			iommu_free_table(p);
+	}
 }
=20
 /*
Index: linux-2.6-64/arch/ppc64/kernel/pSeries_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-64.orig/arch/ppc64/kernel/pSeries_pci.c	2005-02-02 00:10:53=
=2E127011544 +0100
+++ linux-2.6-64/arch/ppc64/kernel/pSeries_pci.c	2005-02-02 00:11:06.040048=
464 +0100
@@ -52,14 +52,12 @@
=20
 extern struct mpic *pSeries_mpic;
=20
=2Dstatic int rtas_read_config(struct device_node *dn, int where, int size,=
 u32 *val)
+static int rtas_read_config(struct pci_device_node *dn, int where, int siz=
e, u32 *val)
 {
 	int returnval =3D -1;
 	unsigned long buid, addr;
 	int ret;
=20
=2D	if (!dn)
=2D		return PCIBIOS_DEVICE_NOT_FOUND;
 	if (where & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
=20
@@ -87,7 +85,8 @@
 				unsigned int devfn,
 				int where, int size, u32 *val)
 {
=2D	struct device_node *busdn, *dn;
+	struct pci_device_node *busdn;
+	struct device_node *dn;
=20
 	if (bus->self)
 		busdn =3D pci_device_to_OF_node(bus->self);
@@ -95,13 +94,15 @@
 		busdn =3D bus->sysdata;	/* must be a phb */
=20
 	/* Search only direct children of the bus */
=2D	for (dn =3D busdn->child; dn; dn =3D dn->sibling)
=2D		if (dn->devfn =3D=3D devfn)
=2D			return rtas_read_config(dn, where, size, val);
+	for (dn =3D busdn->node.child; dn; dn =3D dn->sibling) {
+		struct pci_device_node *pdn =3D to_pci_node(dn);
+		if (pdn->devfn =3D=3D devfn)
+			return rtas_read_config(pdn, where, size, val);
+	}
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
=20
=2Dstatic int rtas_write_config(struct device_node *dn, int where, int size=
, u32 val)
+static int rtas_write_config(struct pci_device_node *dn, int where, int si=
ze, u32 val)
 {
 	unsigned long buid, addr;
 	int ret;
@@ -129,7 +130,8 @@
 				 unsigned int devfn,
 				 int where, int size, u32 val)
 {
=2D	struct device_node *busdn, *dn;
+	struct pci_device_node *busdn;
+	struct device_node *dn;
=20
 	if (bus->self)
 		busdn =3D pci_device_to_OF_node(bus->self);
@@ -137,9 +139,11 @@
 		busdn =3D bus->sysdata;	/* must be a phb */
=20
 	/* Search only direct children of the bus */
=2D	for (dn =3D busdn->child; dn; dn =3D dn->sibling)
=2D		if (dn->devfn =3D=3D devfn)
=2D			return rtas_write_config(dn, where, size, val);
+	for (dn =3D busdn->node.child; dn; dn =3D dn->sibling) {
+		struct pci_device_node *pdn =3D to_pci_node(dn);
+		if (pdn->devfn =3D=3D devfn)
+			return rtas_write_config(pdn, where, size, val);
+	}
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
=20


--Boundary-02=_1XKAC8uyjyiXm6C
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCAKX15t5GS2LDRf4RAoY+AJ0TsA83ZA1hMzpuyOtF7wdA2EjIZgCfR8f5
F9O4ncf2Rlh6bClv8mBZwhg=
=XAIQ
-----END PGP SIGNATURE-----

--Boundary-02=_1XKAC8uyjyiXm6C--
