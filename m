Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVANUDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVANUDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVANUDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:03:45 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:41964 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261947AbVANUBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:01:24 -0500
Date: Fri, 14 Jan 2005 12:01:03 -0800
From: Dave Jiang <dave.jiang@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, greg@kroah.com, smaurer@teja.com,
       dsaxena@plexity.net, drew.moseley@intel.com,
       mporter@kernel.crashing.org
Subject: [PATCH 1/5] resource: core changes to update u64 to unsigned long
Message-ID: <20050114200103.GA19386@plexity.net>
Reply-To: dave.jiang@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Corp.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the rework per Andrew and others' comments. Attempt to change
resource.start and resource.end to u64 from unsigned long.

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>


diff -Naur linux-2.6.11-rc1/drivers/pci/bus.c linux-2.6.11-rc1-u64/drivers/pci/bus.c
--- linux-2.6.11-rc1/drivers/pci/bus.c	2004-12-24 14:35:39.000000000 -0700
+++ linux-2.6.11-rc1-u64/drivers/pci/bus.c	2005-01-13 11:45:41.834462168 -0700
@@ -34,10 +34,10 @@
  */
 int
 pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-	unsigned long size, unsigned long align, unsigned long min,
+	u64 size, u64 align, u64 min,
 	unsigned int type_mask,
 	void (*alignf)(void *, struct resource *,
-			unsigned long, unsigned long),
+			u64, u64),
 	void *alignf_data)
 {
 	int i, ret = -ENOMEM;
diff -Naur linux-2.6.11-rc1/drivers/pci/pci.c linux-2.6.11-rc1-u64/drivers/pci/pci.c
--- linux-2.6.11-rc1/drivers/pci/pci.c	2005-01-13 14:40:02.726164904 -0700
+++ linux-2.6.11-rc1-u64/drivers/pci/pci.c	2005-01-13 17:45:45.663180992 -0700
@@ -564,7 +564,7 @@
 	return 0;
 
 err_out:
-	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%lx@%lx for device %s\n",
+	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%llx@%llx for device %s\n",
 		pci_resource_flags(pdev, bar) & IORESOURCE_IO ? "I/O" : "mem",
 		bar + 1, /* PCI BAR # */
 		pci_resource_len(pdev, bar), pci_resource_start(pdev, bar),
diff -Naur linux-2.6.11-rc1/drivers/pci/pci.h linux-2.6.11-rc1-u64/drivers/pci/pci.h
--- linux-2.6.11-rc1/drivers/pci/pci.h	2004-12-24 14:34:31.000000000 -0700
+++ linux-2.6.11-rc1-u64/drivers/pci/pci.h	2005-01-13 11:45:41.836461864 -0700
@@ -6,10 +6,10 @@
 extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_cleanup_rom(struct pci_dev *dev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-				  unsigned long size, unsigned long align,
-				  unsigned long min, unsigned int type_mask,
+				  u64 size, u64 align,
+				  u64 min, unsigned int type_mask,
 				  void (*alignf)(void *, struct resource *,
-					  	 unsigned long, unsigned long),
+					  	 u64, u64),
 				  void *alignf_data);
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
diff -Naur linux-2.6.11-rc1/drivers/pci/pci-sysfs.c linux-2.6.11-rc1-u64/drivers/pci/pci-sysfs.c
--- linux-2.6.11-rc1/drivers/pci/pci-sysfs.c	2005-01-13 14:40:02.725165056 -0700
+++ linux-2.6.11-rc1-u64/drivers/pci/pci-sysfs.c	2005-01-13 17:46:52.166071016 -0700
@@ -65,7 +65,7 @@
 		max = DEVICE_COUNT_RESOURCE;
 
 	for (i = 0; i < max; i++) {
-		str += sprintf(str,"0x%016lx 0x%016lx 0x%016lx\n",
+		str += sprintf(str,"0x%016llx 0x%016llx 0x%016lx\n",
 			       pci_resource_start(pci_dev,i),
 			       pci_resource_end(pci_dev,i),
 			       pci_resource_flags(pci_dev,i));
diff -Naur linux-2.6.11-rc1/drivers/pci/proc.c linux-2.6.11-rc1-u64/drivers/pci/proc.c
--- linux-2.6.11-rc1/drivers/pci/proc.c	2004-12-24 14:34:58.000000000 -0700
+++ linux-2.6.11-rc1-u64/drivers/pci/proc.c	2005-01-13 17:48:54.142527776 -0700
@@ -301,12 +301,6 @@
 #endif /* HAVE_PCI_MMAP */
 };
 
-#if BITS_PER_LONG == 32
-#define LONG_FORMAT "\t%08lx"
-#else
-#define LONG_FORMAT "\t%16lx"
-#endif
-
 /* iterator */
 static void *pci_seq_start(struct seq_file *m, loff_t *pos)
 {
@@ -358,11 +352,11 @@
 			dev->irq);
 	/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve compatibility */
 	for(i=0; i<7; i++)
-		seq_printf(m, LONG_FORMAT,
+		seq_printf(m, "\t%16llx",
 			dev->resource[i].start |
 			(dev->resource[i].flags & PCI_REGION_FLAG_MASK));
 	for(i=0; i<7; i++)
-		seq_printf(m, LONG_FORMAT,
+		seq_printf(m, "\t%16llx",
 			dev->resource[i].start < dev->resource[i].end ?
 			dev->resource[i].end - dev->resource[i].start + 1 : 0);
 	seq_putc(m, '\t');
diff -Naur linux-2.6.11-rc1/drivers/pci/setup-bus.c linux-2.6.11-rc1-u64/drivers/pci/setup-bus.c
--- linux-2.6.11-rc1/drivers/pci/setup-bus.c	2005-01-13 14:40:02.729164448 -0700
+++ linux-2.6.11-rc1-u64/drivers/pci/setup-bus.c	2005-01-13 17:56:03.320282840 -0700
@@ -357,7 +357,7 @@
 			order = __ffs(align) - 20;
 			if (order > 11) {
 				printk(KERN_WARNING "PCI: region %s/%d "
-				       "too large: %lx-%lx\n",
+				       "too large: %llx-%llx\n",
 				       pci_name(dev), i, r->start, r->end);
 				r->flags = 0;
 				continue;
diff -Naur linux-2.6.11-rc1/drivers/pci/setup-res.c linux-2.6.11-rc1-u64/drivers/pci/setup-res.c
--- linux-2.6.11-rc1/drivers/pci/setup-res.c	2004-12-24 14:35:25.000000000 -0700
+++ linux-2.6.11-rc1-u64/drivers/pci/setup-res.c	2005-01-13 17:57:29.963111128 -0700
@@ -42,7 +42,7 @@
 
 	pcibios_resource_to_bus(dev, &region, res);
 
-	DBGC((KERN_ERR "  got res [%lx:%lx] bus [%lx:%lx] flags %lx for "
+	DBGC((KERN_ERR "  got res [%llx:%llx] bus [%lx:%lx] flags %lx for "
 	      "BAR %d of %s\n", res->start, res->end,
 	      region.start, region.end, res->flags,
 	      resno, pci_name(dev)));
@@ -108,7 +108,7 @@
 		err = insert_resource(root, res);
 
 	if (err) {
-		printk(KERN_ERR "PCI: %s region %d of %s %s [%lx:%lx]\n",
+		printk(KERN_ERR "PCI: %s region %d of %s %s [%llx:%llx]\n",
 		       root ? "Address space collision on" :
 			      "No parent found for",
 		       resource, dtype, pci_name(dev), res->start, res->end);
@@ -121,7 +121,7 @@
 {
 	struct pci_bus *bus = dev->bus;
 	struct resource *res = dev->resource + resno;
-	unsigned long size, min, align;
+	u64 size, min, align;
 	int ret;
 
 	size = res->end - res->start + 1;
@@ -148,7 +148,7 @@
 	}
 
 	if (ret) {
-		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%lx@%lx for %s\n",
+		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%llx@%llx for %s\n",
 		       res->flags & IORESOURCE_IO ? "I/O" : "mem",
 		       resno, size, res->start, pci_name(dev));
 	} else if (resno < PCI_BRIDGE_RESOURCES) {
@@ -176,7 +176,7 @@
 			continue;
 		if (!r_align) {
 			printk(KERN_WARNING "PCI: Ignore bogus resource %d "
-					    "[%lx:%lx] of %s\n",
+					    "[%llx:%llx] of %s\n",
 					    i, r->start, r->end, pci_name(dev));
 			continue;
 		}
diff -Naur linux-2.6.11-rc1/drivers/pnp/manager.c linux-2.6.11-rc1-u64/drivers/pnp/manager.c
--- linux-2.6.11-rc1/drivers/pnp/manager.c	2004-12-24 14:35:39.000000000 -0700
+++ linux-2.6.11-rc1-u64/drivers/pnp/manager.c	2005-01-13 11:45:41.839461408 -0700
@@ -25,7 +25,8 @@
 
 static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 
 	if (!dev || !rule)
 		return -EINVAL;
@@ -68,7 +69,8 @@
 
 static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 
 	if (!dev || !rule)
 		return -EINVAL;
@@ -121,7 +123,8 @@
 
 static int pnp_assign_irq(struct pnp_dev * dev, struct pnp_irq *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 	int i;
 
 	/* IRQ priority: this table is good for i386 */
@@ -173,7 +176,8 @@
 
 static int pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 	int i;
 
 	/* DMA priority: this table is good for i386 */
@@ -548,7 +552,7 @@
  * @size: size of region
  *
  */
-void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size)
+void pnp_resource_change(struct resource *resource, u64 start, u64 size)
 {
 	if (resource == NULL)
 		return;
diff -Naur linux-2.6.11-rc1/drivers/pnp/resource.c linux-2.6.11-rc1-u64/drivers/pnp/resource.c
--- linux-2.6.11-rc1/drivers/pnp/resource.c	2004-12-24 14:34:58.000000000 -0700
+++ linux-2.6.11-rc1-u64/drivers/pnp/resource.c	2005-01-13 11:45:41.840461256 -0700
@@ -242,7 +242,7 @@
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long *port, *end, *tport, *tend;
+	u64 *port, *end, *tport, *tend;
 	port = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 
@@ -298,7 +298,7 @@
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long *addr, *end, *taddr, *tend;
+	u64 *addr, *end, *taddr, *tend;
 	addr = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 
@@ -359,7 +359,7 @@
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long * irq = &dev->res.irq_resource[idx].start;
+	u64 * irq = &dev->res.irq_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.irq_resource[idx].flags))
@@ -424,7 +424,7 @@
 #ifndef CONFIG_IA64
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long * dma = &dev->res.dma_resource[idx].start;
+	u64 * dma = &dev->res.dma_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.dma_resource[idx].flags))
diff -Naur linux-2.6.11-rc1/include/linux/ioport.h linux-2.6.11-rc1-u64/include/linux/ioport.h
--- linux-2.6.11-rc1/include/linux/ioport.h	2004-12-24 14:34:26.000000000 -0700
+++ linux-2.6.11-rc1-u64/include/linux/ioport.h	2005-01-13 11:45:41.843460800 -0700
@@ -9,13 +9,14 @@
 #define _LINUX_IOPORT_H
 
 #include <linux/compiler.h>
+#include <linux/types.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
  */
 struct resource {
+	u64 start, end;
 	const char *name;
-	unsigned long start, end;
 	unsigned long flags;
 	struct resource *parent, *sibling, *child;
 };
@@ -98,31 +99,31 @@
 extern int release_resource(struct resource *new);
 extern int insert_resource(struct resource *parent, struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
-			     unsigned long size,
-			     unsigned long min, unsigned long max,
-			     unsigned long align,
+			     u64 size,
+			     u64 min, u64 max,
+			     u64 align,
 			     void (*alignf)(void *, struct resource *,
-					    unsigned long, unsigned long),
+					    u64, u64),
 			     void *alignf_data);
-int adjust_resource(struct resource *res, unsigned long start,
-		    unsigned long size);
+int adjust_resource(struct resource *res, u64 start,
+		    u64 size);
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name))
 #define rename_region(region, newname) do { (region)->name = (newname); } while (0)
 
-extern struct resource * __request_region(struct resource *, unsigned long start, unsigned long n, const char *name);
+extern struct resource * __request_region(struct resource *, u64 start, u64 n, const char *name);
 
 /* Compatibility cruft */
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int __check_region(struct resource *, unsigned long, unsigned long);
-extern void __release_region(struct resource *, unsigned long, unsigned long);
+extern int __check_region(struct resource *, u64, u64);
+extern void __release_region(struct resource *, u64, u64);
 
-static inline int __deprecated check_region(unsigned long s, unsigned long n)
+static inline int __deprecated check_region(u64 s, u64 n)
 {
 	return __check_region(&ioport_resource, s, n);
 }
diff -Naur linux-2.6.11-rc1/include/linux/pci.h linux-2.6.11-rc1-u64/include/linux/pci.h
--- linux-2.6.11-rc1/include/linux/pci.h	2005-01-13 14:40:18.001842648 -0700
+++ linux-2.6.11-rc1-u64/include/linux/pci.h	2005-01-13 11:45:41.844460648 -0700
@@ -726,7 +726,7 @@
 
 /* Used only when drivers/pci/setup.c is used */
 void pcibios_align_resource(void *, struct resource *,
-			    unsigned long, unsigned long);
+			    u64, u64);
 void pcibios_update_irq(struct pci_dev *, int irq);
 
 /* Generic PCI functions used internally */
@@ -843,10 +843,10 @@
 
 /* drivers/pci/bus.c */
 int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-			   unsigned long size, unsigned long align,
-			   unsigned long min, unsigned int type_mask,
+			   u64 size, u64 align,
+			   u64 min, unsigned int type_mask,
 			   void (*alignf)(void *, struct resource *,
-					  unsigned long, unsigned long),
+					  u64, u64),
 			   void *alignf_data);
 void pci_enable_bridges(struct pci_bus *bus);
 
diff -Naur linux-2.6.11-rc1/include/linux/pnp.h linux-2.6.11-rc1-u64/include/linux/pnp.h
--- linux-2.6.11-rc1/include/linux/pnp.h	2004-12-24 14:35:40.000000000 -0700
+++ linux-2.6.11-rc1-u64/include/linux/pnp.h	2005-01-13 11:45:41.845460496 -0700
@@ -384,7 +384,7 @@
 int pnp_validate_config(struct pnp_dev *dev);
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
-void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
+void pnp_resource_change(struct resource *resource, u64 start, u64 size);
 
 /* protocol helpers */
 int pnp_is_active(struct pnp_dev * dev);
@@ -429,7 +429,7 @@
 static inline int pnp_validate_config(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { }
+static inline void pnp_resource_change(struct resource *resource, u64 start, u64 size) { }
 
 /* protocol helpers */
 static inline int pnp_is_active(struct pnp_dev * dev) { return 0; }
diff -Naur linux-2.6.11-rc1/kernel/resource.c linux-2.6.11-rc1-u64/kernel/resource.c
--- linux-2.6.11-rc1/kernel/resource.c	2005-01-13 14:40:18.537761176 -0700
+++ linux-2.6.11-rc1-u64/kernel/resource.c	2005-01-13 18:01:09.029807928 -0700
@@ -23,7 +23,7 @@
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
-	.start	= 0x0000,
+	.start	= 0x0000ULL,
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
@@ -32,8 +32,8 @@
 
 struct resource iomem_resource = {
 	.name	= "PCI mem",
-	.start	= 0UL,
-	.end	= ~0UL,
+	.start	= 0ULL,
+	.end	= ~0ULL,
 	.flags	= IORESOURCE_MEM,
 };
 
@@ -83,7 +83,7 @@
 	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
 		if (p->parent == root)
 			break;
-	seq_printf(m, "%*s%0*lx-%0*lx : %s\n",
+	seq_printf(m, "%*s%0*llx-%0*llx : %s\n",
 			depth * 2, "",
 			width, r->start,
 			width, r->end,
@@ -151,8 +151,8 @@
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
-	unsigned long start = new->start;
-	unsigned long end = new->end;
+	u64 start = new->start;
+	u64 end = new->end;
 	struct resource *tmp, **p;
 
 	if (end < start)
@@ -236,11 +236,11 @@
  * Find empty slot in the resource tree given range and alignment.
  */
 static int find_resource(struct resource *root, struct resource *new,
-			 unsigned long size,
-			 unsigned long min, unsigned long max,
-			 unsigned long align,
+			 u64 size,
+			 u64 min, u64 max,
+			 u64 align,
 			 void (*alignf)(void *, struct resource *,
-					unsigned long, unsigned long),
+					u64, u64),
 			 void *alignf_data)
 {
 	struct resource *this = root->child;
@@ -282,11 +282,11 @@
  * Allocate empty slot in the resource tree given range and alignment.
  */
 int allocate_resource(struct resource *root, struct resource *new,
-		      unsigned long size,
-		      unsigned long min, unsigned long max,
-		      unsigned long align,
+		      u64 size,
+		      u64 min, u64 max,
+		      u64 align,
 		      void (*alignf)(void *, struct resource *,
-				     unsigned long, unsigned long),
+				     u64, u64),
 		      void *alignf_data)
 {
 	int err;
@@ -378,10 +378,10 @@
  * arguments.  Returns -EBUSY if it can't fit.  Existing children of
  * the resource are assumed to be immutable.
  */
-int adjust_resource(struct resource *res, unsigned long start, unsigned long size)
+int adjust_resource(struct resource *res, u64 start, u64 size)
 {
 	struct resource *tmp, *parent = res->parent;
-	unsigned long end = start + size - 1;
+	u64 end = start + size - 1;
 	int result = -EBUSY;
 
 	write_lock(&resource_lock);
@@ -428,7 +428,7 @@
  *
  * Release-region releases a matching busy region.
  */
-struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
+struct resource * __request_region(struct resource *parent, u64 start, u64 n, const char *name)
 {
 	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
 
@@ -465,7 +465,7 @@
 
 EXPORT_SYMBOL(__request_region);
 
-int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int __deprecated __check_region(struct resource *parent, u64 start, u64 n)
 {
 	struct resource * res;
 
@@ -480,10 +480,10 @@
 
 EXPORT_SYMBOL(__check_region);
 
-void __release_region(struct resource *parent, unsigned long start, unsigned long n)
+void __release_region(struct resource *parent, u64 start, u64 n)
 {
 	struct resource **p;
-	unsigned long end;
+	u64 end;
 
 	p = &parent->child;
 	end = start + n - 1;
@@ -512,7 +512,7 @@
 
 	write_unlock(&resource_lock);
 
-	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
+	printk(KERN_WARNING "Trying to free nonexistent resource <%16llx-%16llx>\n", start, end);
 }
 
 EXPORT_SYMBOL(__release_region);
