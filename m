Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754286AbWKMIS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286AbWKMIS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 03:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbWKMIS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 03:18:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:50318 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1754279AbWKMIS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 03:18:58 -0500
Subject: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Anton Blanchard <anton@samba.org>, Dave Airlie <airlied@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, Ian Romanick <idr@us.ibm.com>,
       Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 19:16:30 +1100
Message-Id: <1163405790.4982.289.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The powerpc version of pci_resource_to_user() and associated hooks
used by /proc/bus/pci and /sys/bus/pci mmap have been broken for some
time on machines that don't have a 1:1 mapping of devices (basically
on non-PowerMacs) and have PCI devices above 32 bits.

This attempts to fix it as well as possible. 

The rule is supposed to be that pci_resource_to_user() always converts
the resources back into a BAR values since that's what the /proc
interface was supposed to deal with. However, for X to work on platforms
where PCI MMIO is not mapped 1:1, it became a habit of platforms like
sparc or powerpc to pass "fixed up" values there sinve X expects to
be able to use values from /proc/bus/pci/devices as offsets to mmap
of /dev/mem...

So we keep that contraption here, causing also /sys/*/resource to
expose fully absolute MMIO addresses instead of BAR values, which is
ugly, but should still work as long as those are only used to calculate
alignment within a page.

X is still broken when built 32 bits on machines where PCI MMIO can be
above 32 bits space unfortunately. It looks like somebody (DaveM ?)
hacked a fix in X to handle long long resources and had the good idea
to wrap it in #ifdef __sparc__ :-(

I suppose distro can do a quick fix here to get current X working, at
least until we have the new code from Ian Romanick that is supposed to
do proper use of sysfs for mapping resources.

This version of the patch is not well tested, mostly for comments at
this point.

As for fixing X to deal with 64 bits values when built as a 32 bits
binary, edit hw/xfree86/os-support/linux/lnx_pci.c and make it use
the definitions inside #ifdef __sparc__ at the top of the file. I
can't see any good reason why this was made sparc only in the first
place though...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Dave (Airlie), maybe you want to fix X git ? As a temporary measure
at least until we get Ian code ?

Index: linux-cell/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_32.c	2006-11-13 13:37:51.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/pci_32.c	2006-11-13 19:01:28.000000000 +1100
@@ -1546,7 +1546,7 @@ pci_resource_to_bus(struct pci_dev *pdev
 
 
 static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
-					       unsigned long *offset,
+					       resource_size_t *offset,
 					       enum pci_mmap_state mmap_state)
 {
 	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
@@ -1558,7 +1558,9 @@ static struct resource *__pci_mmap_make_
 
 	/* If memory, add on the PCI bridge address offset */
 	if (mmap_state == pci_mmap_mem) {
+#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
 		*offset += hose->pci_mem_offset;
+#endif
 		res_bit = IORESOURCE_MEM;
 	} else {
 		io_offset = hose->io_base_virt - (void __iomem *)_IO_BASE;
@@ -1626,9 +1628,6 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	else
 		prot |= _PAGE_GUARDED;
 
-	printk("PCI map for %s:%llx, prot: %lx\n", pci_name(dev),
-		(unsigned long long)rp->start, prot);
-
 	return __pgprot(prot);
 }
 
@@ -1697,7 +1696,7 @@ int pci_mmap_page_range(struct pci_dev *
 			enum pci_mmap_state mmap_state,
 			int write_combine)
 {
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	resource_size_t offset = vma->vm_pgoff << PAGE_SHIFT;
 	struct resource *rp;
 	int ret;
 
@@ -1810,21 +1809,43 @@ void pci_resource_to_user(const struct p
 			  resource_size_t *start, resource_size_t *end)
 {
 	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
-	unsigned long offset = 0;
+	resource_size_t offset = 0;
 
 	if (hose == NULL)
 		return;
 
 	if (rsrc->flags & IORESOURCE_IO)
-		offset = (void __iomem *)_IO_BASE - hose->io_base_virt
-			+ hose->io_base_phys;
+		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+
+	/* We pass a fully fixed up address to userland for MMIO instead of
+	 * a BAR value because X is lame and expects to be able to use that
+	 * to pass to /dev/mem !
+	 *
+	 * That means that we'll have potentially 64 bits values where some
+	 * userland apps only expect 32 (like X itself since it thinks only
+	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
+	 * 32 bits CHRPs :-(
+	 *
+	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
+	 * has been fixed (and the fix spread enough), we can re-enable the
+	 * 2 lines below and pass down a BAR value to userland. In that case
+	 * we'll also have to re-enable the matching code in
+	 * __pci_mmap_make_offset().
+	 *
+	 * BenH.
+	 */
+#if 0
+	else if (rsrc->flags & IORESOURCE_MEM)
+		offset = hose->pci_mem_offset;
+#endif
 
-	*start = rsrc->start + offset;
-	*end = rsrc->end + offset;
+	*start = rsrc->start - offset;
+	*end = rsrc->end - offset;
 }
 
 void __init
-pci_init_resource(struct resource *res, unsigned long start, unsigned long end,
+pci_init_resource(struct resource *res, resource_size_t start,
+		  resource_size_t end,
 		  int flags, char *name)
 {
 	res->start = start;
Index: linux-cell/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_64.c	2006-11-13 13:37:51.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/pci_64.c	2006-11-13 19:01:21.000000000 +1100
@@ -689,7 +689,7 @@ int pci_proc_domain(struct pci_bus *bus)
  * Returns negative error code on failure, zero on success.
  */
 static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
-					       unsigned long *offset,
+					       resource_size_t *offset,
 					       enum pci_mmap_state mmap_state)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
@@ -701,7 +701,9 @@ static struct resource *__pci_mmap_make_
 
 	/* If memory, add on the PCI bridge address offset */
 	if (mmap_state == pci_mmap_mem) {
+#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
 		*offset += hose->pci_mem_offset;
+#endif
 		res_bit = IORESOURCE_MEM;
 	} else {
 		io_offset = (unsigned long)hose->io_base_virt - pci_io_base;
@@ -769,9 +771,6 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	else
 		prot |= _PAGE_GUARDED;
 
-	printk(KERN_DEBUG "PCI map for %s:%lx, prot: %lx\n", pci_name(dev), rp->start,
-	       prot);
-
 	return __pgprot(prot);
 }
 
@@ -839,7 +838,7 @@ pgprot_t pci_phys_mem_access_prot(struct
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	resource_size_t offset = vma->vm_pgoff << PAGE_SHIFT;
 	struct resource *rp;
 	int ret;
 
@@ -1342,20 +1341,41 @@ EXPORT_SYMBOL(pci_read_irq_line);
 
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
-			  u64 *start, u64 *end)
+			  resource_size_t *start, resource_size_t *end)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long offset = 0;
+	resource_size_t offset = 0;
 
 	if (hose == NULL)
 		return;
 
 	if (rsrc->flags & IORESOURCE_IO)
-		offset = pci_io_base - (unsigned long)hose->io_base_virt +
-			hose->io_base_phys;
+		offset = (unsigned long)hose->io_base_virt - pci_io_base;
+
+	/* We pass a fully fixed up address to userland for MMIO instead of
+	 * a BAR value because X is lame and expects to be able to use that
+	 * to pass to /dev/mem !
+	 *
+	 * That means that we'll have potentially 64 bits values where some
+	 * userland apps only expect 32 (like X itself since it thinks only
+	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
+	 * 32 bits CHRPs :-(
+	 *
+	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
+	 * has been fixed (and the fix spread enough), we can re-enable the
+	 * 2 lines below and pass down a BAR value to userland. In that case
+	 * we'll also have to re-enable the matching code in
+	 * __pci_mmap_make_offset().
+	 *
+	 * BenH.
+	 */
+#if 0
+	else if (rsrc->flags & IORESOURCE_MEM)
+		offset = hose->pci_mem_offset;
+#endif
 
-	*start = rsrc->start + offset;
-	*end = rsrc->end + offset;
+	*start = rsrc->start - offset;
+	*end = rsrc->end - offset;
 }
 
 struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
Index: linux-cell/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pci-bridge.h	2006-11-13 13:37:50.000000000 +1100
+++ linux-cell/include/asm-powerpc/pci-bridge.h	2006-11-13 13:51:00.000000000 +1100
@@ -31,12 +31,12 @@ struct pci_controller {
 	int last_busno;
 
 	void __iomem *io_base_virt;
-	unsigned long io_base_phys;
+	resource_size_t io_base_phys;
 
 	/* Some machines have a non 1:1 mapping of
 	 * the PCI memory space in the CPU bus space
 	 */
-	unsigned long pci_mem_offset;
+	resource_size_t pci_mem_offset;
 	unsigned long pci_io_size;
 
 	struct pci_ops *ops;
Index: linux-cell/include/asm-ppc/pci-bridge.h
===================================================================
--- linux-cell.orig/include/asm-ppc/pci-bridge.h	2006-11-13 13:37:50.000000000 +1100
+++ linux-cell/include/asm-ppc/pci-bridge.h	2006-11-13 13:47:30.000000000 +1100
@@ -20,8 +20,8 @@ extern unsigned long pci_bus_mem_base_ph
 extern struct pci_controller* pcibios_alloc_controller(void);
 
 /* Helper function for setting up resources */
-extern void pci_init_resource(struct resource *res, unsigned long start,
-			      unsigned long end, int flags, char *name);
+extern void pci_init_resource(struct resource *res, resource_size_t start,
+			      resource_size_t end, int flags, char *name);
 
 /* Get the PCI host controller for a bus */
 extern struct pci_controller* pci_bus_to_hose(int bus);
@@ -50,12 +50,12 @@ struct pci_controller {
 	int bus_offset;
 
 	void __iomem *io_base_virt;
-	unsigned long io_base_phys;
+	resource_size_t io_base_phys;
 
 	/* Some machines (PReP) have a non 1:1 mapping of
 	 * the PCI memory space in the CPU bus space
 	 */
-	unsigned long pci_mem_offset;
+	resource_size_t pci_mem_offset;
 
 	struct pci_ops *ops;
 	volatile unsigned int __iomem *cfg_addr;


