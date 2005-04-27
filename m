Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVD0Ess@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVD0Ess (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 00:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVD0Ess
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 00:48:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:40659 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261921AbVD0ErH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 00:47:07 -0400
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <1114555655.7183.81.camel@gaston>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org>  <1114555655.7183.81.camel@gaston>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 14:46:23 +1000
Message-Id: <1114577183.7112.149.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 08:47 +1000, Benjamin Herrenschmidt wrote:

> No. I don't agree. userspace has no business understanding the kernel
> resources content. All userspace need to care about is the resource
> number, and _eventually_ match it to a BAR value (either for using the
> old /proc interface -> existing code, or to use it with real inx/outx
> instructions on x86).

Ok, let me correct myself here... I think you _are_ right, but I also
think that pci_dev->resource[] is _not_ a CPU address that can be
exposed to userland, it's is a kernel internal "cookie" whose meaning is
arch specific.

What we need here is a way to go from pci_dev->resource to some CPU
address (typically in most archs that would result in something that can
be fed through /dev/mem, though that is just an example, doing so is
definitely not recommended :)

Additionally, there are a few others issues:

 - mmap'ing resourceX vs. alignment. I have this video card with a bunch
of IOs at 0x400, so mmap'ing it will return something that maps the
first page of IO space (from 0). The userland program must be able to
recalculate the necessary alignement to know that it has to add 0x400 to
the mapping obtained via mmap. There is nothing in the API preventing
it, that is, the user program can get that via array exposed in
"resource" (or rather "resources" as I intend to rename it) ... provided
those are really CPU _addresses_ and not some kind of weird tokens
(which they are on some archs). In the case of IO space, there is the
additional requirement of actually knowing the real IO address for use
with inX/outX instructions on architectures that have those.

 - What about architectures that have 32 bits core but > 32 bits
physical address space, like ppc32 with 440 or e500 processors where
IO/MMIO space is above 4gb ? The proper fix here is to have struct
resource to be 64 bits fields but we aren't there ...

 - What is supposed to be passed to /proc/bus/pci mmap ? Should it be a
BAR value or the output of /proc/bus/pci/devices ? In the later case,
well, we are exposing the same crap as sysfs, that is a raw kernel
struct resource, which doesn't make sense out of the kernel. So I'm
tempted to "fix" /proc/bus/pci/devices the same way (see below) that I'm
fixing /sys/bus/pci/*/resources to pass a CPU physical address. (this
will only affect ppc[64] or other archs using my new callback anyway).

So what do that mean in practice ? Well, a few things :

1 - As described above, we need a kind of pci_resource_to_user() arch
hook so that struct resource can be converted in something that makes
sense to userland, typically a CPU physical address. It would be easy to
have a default implementation just using the resource "as-is" as it does
today, so we only have to fixup archs for which the value in there is
meaningless outside of the kernel (typically, ppc & ppc64 for IO
resources)

2 - The above pci_resource_to_user() might probably need to be defined
as returning a 64 bits value, and for consistency, we should probably
always display 64 bits in "resources" to handle the case of 32 bits CPUs
with > 32 bits IO space.
 
3 - pci_mmap_page_range() beeing called by both sysfs mmap and proc
mmap, we must clarify what it's "offset" parameter really is. Is it PCI
BAR value or is it a CPU physical address ? It was defined for the /proc
interface, was it ever documented . I though it wanted a BAR value but
Jesse seems to think it wants something out of /proc/bus/pci/devices.
The former would mean that either pci-sysfs.c must "convert" the offset
to a BAR value before calling pci_mmap_page_range(), or we must define a
different interface since they are non-consistent, but the later means
they are consistant (which is cool). In both case, current ppc
implementation is broken.

4 - additionally, to avoid future compatibility issues, I added the
resource number to the output of /sys/bus/pci/*/resources

The patch below implements this, with 1 - defaulting to just using the
resource as-is, plus a pair of imlpementations for ppc and ppc64, with 2
- returning an u64, and with 3 - taking the approach that /proc/bus/pci
expects offsets from /proc/bus/pci/devices (and not BAR values), that
means the interface stays consistent between proc and sysfs (pfiew !)

Additional misc question: The new interface doesn't allow to pass in any
"write combine" parametre like /proc did. In fact, this paremeter was a
bit limitative, since archs tend to be more varied when it comes to
relaxed ordering. On ppc & ppc64, I only use this as a hint, and the
pci_mmap_page_range() implementation (and /dev/mem too, so X benefits
from it) will in fact use the "prefetchable" attribute of the device
resource to decide wetehr to mark the space "guarded" or not. "guarded"
is a PPC specific attribute that disable things like speculation, but in
practice, also seem to disable write combining on some CPUs. I was
wondering wether it would make sense to haev pci-sysfs.c pass 1 for
write_combine when the resource beeing mapped has the prefetchable bit ?

Ok, here's the patch for comments. It's really on for comments now, I
has some nasty printk's in there, some useless hunks, etc... :)

So don't comment on these please :)

Ben.

Index: linux-work/arch/ppc64/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci.c	2005-04-24 11:37:38.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pci.c	2005-04-27 14:44:46.000000000 +1000
@@ -351,9 +351,12 @@
 		*offset += hose->pci_mem_offset;
 		res_bit = IORESOURCE_MEM;
 	} else {
-		io_offset = (unsigned long)hose->io_base_virt;
+		io_offset = (unsigned long)hose->io_base_virt - pci_io_base;
+		printk("offset: %lx, io_base_virt: %p, pci_io_base: %lx, io_offset: %lx\n",
+		       *offset, hose->io_base_virt, pci_io_base, io_offset);
 		*offset += io_offset;
 		res_bit = IORESOURCE_IO;
+		printk(" -> offset: %lx\n", *offset);
 	}
 
 	/*
@@ -373,12 +376,15 @@
 			continue;
 
 		/* In the range of this resource? */
+		printk(" r%d: %lx -> %lx\n", i, rp->start, rp->end);
 		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
 			continue;
 
 		/* found it! construct the final physical address */
-		if (mmap_state == pci_mmap_io)
-			*offset += hose->io_base_phys - io_offset;
+		if (mmap_state == pci_mmap_io) {
+		       	*offset += hose->io_base_phys - io_offset;
+			printk(" result: %lx\n", *offset);
+		}
 		return rp;
 	}
 
@@ -941,4 +947,22 @@
 }
 EXPORT_SYMBOL(pci_read_irq_line);
 
+void pci_resource_to_user(const struct pci_dev *dev, int bar,
+			  const struct resource *rsrc,
+			  u64 *start, u64 *end)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	unsigned long offset = 0;
+
+	if (hose == NULL)
+		return;
+
+	if (rsrc->flags & IORESOURCE_IO)
+		offset = pci_io_base - (unsigned long)hose->io_base_virt +
+			hose->io_base_phys;
+
+	*start = rsrc->start + offset;
+	*end = rsrc->end + offset;
+}
+
 #endif /* CONFIG_PPC_MULTIPLATFORM */
Index: linux-work/drivers/pci/pci-sysfs.c
===================================================================
--- linux-work.orig/drivers/pci/pci-sysfs.c	2005-04-24 11:37:45.000000000 +1000
+++ linux-work/drivers/pci/pci-sysfs.c	2005-04-27 14:40:28.000000000 +1000
@@ -54,27 +54,30 @@
 
 /* show resources */
 static ssize_t
-resource_show(struct device * dev, char * buf)
+resources_show(struct device * dev, char * buf)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	char * str = buf;
 	int i;
 	int max = 7;
+	u64 start, end;
 
 	if (pci_dev->subordinate)
 		max = DEVICE_COUNT_RESOURCE;
 
 	for (i = 0; i < max; i++) {
-		str += sprintf(str,"0x%016lx 0x%016lx 0x%016lx\n",
-			       pci_resource_start(pci_dev,i),
-			       pci_resource_end(pci_dev,i),
-			       pci_resource_flags(pci_dev,i));
+		struct resource *res =  &pci_dev->resource[i];
+		pci_resource_to_user(pci_dev, i, res, &start, &end);
+		str += sprintf(str,"0x%02x 0x%016llx 0x%016llx 0x%016llx\n", i,
+			       (unsigned long long)start,
+			       (unsigned long long)end,
+			       (unsigned long long)res->flags);
 	}
 	return (str - buf);
 }
 
 struct device_attribute pci_dev_attrs[] = {
-	__ATTR_RO(resource),
+	__ATTR_RO(resources),
 	__ATTR_RO(vendor),
 	__ATTR_RO(device),
 	__ATTR_RO(subsystem_vendor),
@@ -267,8 +270,21 @@
 						       struct device, kobj));
 	struct resource *res = (struct resource *)attr->private;
 	enum pci_mmap_state mmap_type;
+	u64 start, end;
+	int i;
+
+	for (i = 0; i < PCI_ROM_RESOURCE; i++)
+		if (res == &pdev->resource[i])
+			break;
+	if (i >= PCI_ROM_RESOURCE)
+		return -ENODEV;
 
-	vma->vm_pgoff += res->start >> PAGE_SHIFT;
+	/* pci_mmap_page_range() expects the same kind of entry as coming
+	 * from /proc/bus/pci/ which is a "user visible" value. If this is
+	 * different from the resource itself, arch will do necessary fixup.
+	 */
+	pci_resource_to_user(pdev, i, res, &start, &end);
+	vma->vm_pgoff += start >> PAGE_SHIFT;
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
 
 	return pci_mmap_page_range(pdev, vma, mmap_type, 0);
Index: linux-work/include/asm-ppc64/pci.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pci.h	2005-04-24 11:38:56.000000000 +1000
+++ linux-work/include/asm-ppc64/pci.h	2005-04-27 14:34:18.000000000 +1000
@@ -135,6 +135,11 @@
 					 unsigned long offset,
 					 unsigned long size,
 					 pgprot_t prot);
+#define HAVE_ARCH_PCI_RESOURCE_TO_USER
+extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
+				 const struct resource *rsrc,
+				 u64 *start, u64 *end);
+
 
 
 #endif	/* __KERNEL__ */
Index: linux-work/drivers/pci/proc.c
===================================================================
--- linux-work.orig/drivers/pci/proc.c	2005-04-24 11:37:45.000000000 +1000
+++ linux-work/drivers/pci/proc.c	2005-04-27 14:34:18.000000000 +1000
@@ -354,14 +354,20 @@
 			dev->device,
 			dev->irq);
 	/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve compatibility */
-	for(i=0; i<7; i++)
+	for(i=0; i<7; i++) {
+		u64 start, end;
+		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, LONG_FORMAT,
-			dev->resource[i].start |
+			((unsigned long)start) |
 			(dev->resource[i].flags & PCI_REGION_FLAG_MASK));
-	for(i=0; i<7; i++)
+	}
+	for(i=0; i<7; i++) {
+		u64 start, end;
+		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, LONG_FORMAT,
 			dev->resource[i].start < dev->resource[i].end ?
-			dev->resource[i].end - dev->resource[i].start + 1 : 0);
+			(unsigned long)(end - start) + 1 : 0);
+	}
 	seq_putc(m, '\t');
 	if (drv)
 		seq_printf(m, "%s", drv->name);
Index: linux-work/drivers/pci/pci.c
===================================================================
--- linux-work.orig/drivers/pci/pci.c	2005-04-24 11:37:45.000000000 +1000
+++ linux-work/drivers/pci/pci.c	2005-04-27 14:34:18.000000000 +1000
@@ -770,7 +770,7 @@
 	return 0;
 }
 #endif
-     
+
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev = NULL;
Index: linux-work/include/linux/pci.h
===================================================================
--- linux-work.orig/include/linux/pci.h	2005-04-24 11:39:20.000000000 +1000
+++ linux-work/include/linux/pci.h	2005-04-27 14:34:18.000000000 +1000
@@ -1017,6 +1017,21 @@
 #define pci_pretty_name(dev) ""
 #endif
 
+
+/* Some archs don't want to expose struct resource to userland as-is
+ * in sysfs and /proc
+ */
+#ifndef HAVE_ARCH_PCI_RESOURCE_TO_USER
+static void pci_resource_to_user(const struct pci_dev *dev, int bar,
+				 const struct resource *rsrc,
+				 u64 *start, u64 *end)
+{
+	*start = rsrc->start;
+	*end = rsrc->end;
+}
+#endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
+
+
 /*
  *  The world is not perfect and supplies us with broken PCI devices.
  *  For at least a part of these bugs we need a work-around, so both
Index: linux-work/include/asm-ppc/pci.h
===================================================================
--- linux-work.orig/include/asm-ppc/pci.h	2005-04-24 11:38:54.000000000 +1000
+++ linux-work/include/asm-ppc/pci.h	2005-04-27 14:34:18.000000000 +1000
@@ -103,6 +103,12 @@
 					 unsigned long size,
 					 pgprot_t prot);
 
+#define HAVE_ARCH_PCI_RESOURCE_TO_USER
+extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
+				 const struct resource *rsrc,
+				 u64 *start, u64 *end);
+
+
 #endif	/* __KERNEL__ */
 
 #endif /* __PPC_PCI_H */
Index: linux-work/arch/ppc/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/pci.c	2005-04-24 11:37:38.000000000 +1000
+++ linux-work/arch/ppc/kernel/pci.c	2005-04-27 14:42:34.000000000 +1000
@@ -1495,7 +1495,7 @@
 		*offset += hose->pci_mem_offset;
 		res_bit = IORESOURCE_MEM;
 	} else {
-		io_offset = (unsigned long)hose->io_base_virt;
+		io_offset = hose->io_base_virt - ___IO_BASE;
 		*offset += io_offset;
 		res_bit = IORESOURCE_IO;
 	}
@@ -1522,7 +1522,7 @@
 
 		/* found it! construct the final physical address */
 		if (mmap_state == pci_mmap_io)
-			*offset += hose->io_base_phys - _IO_BASE;
+			*offset += hose->io_base_phys - io_offset;
 		return rp;
 	}
 
@@ -1739,6 +1739,23 @@
 	return result;
 }
 
+void pci_resource_to_user(const struct pci_dev *dev, int bar,
+			  const struct resource *rsrc,
+			  u64 *start, u64 *end)
+{
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+	unsigned long offset = 0;
+
+	if (hose == NULL)
+		return;
+
+	if (rsrc->flags & IORESOURCE_IO)
+		offset = ___IO_BASE - hose->io_base_virt + hose->io_base_phys;
+
+	*start = rsrc->start + offset;
+	*end = rsrc->end + offset;
+}
+
 void __init
 pci_init_resource(struct resource *res, unsigned long start, unsigned long end,
 		  int flags, char *name)


