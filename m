Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314484AbSEGPtw>; Tue, 7 May 2002 11:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315900AbSEGPtq>; Tue, 7 May 2002 11:49:46 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1028 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315878AbSEGPti>; Tue, 7 May 2002 11:49:38 -0400
Date: Tue, 7 May 2002 19:49:32 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.14: New PCI allocation code (alpha, arm, parisc) [1/2]
Message-ID: <20020507194932.A660@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes PCI resource allocation algorithm to 3 passes vs.
current 2 passes. Extra pass is used for calculation of required
size and alignment of PCI buses behind PCI-PCI bridges. After
that, in the pass #3, these buses get allocated like regular
PCI devices. This gives tighter PCI IO and memory packing -
for instance, this fixes allocation problems on certain alphas
with very small (112Mb) PCI memory range. Also, the new code
- will allow mixed approach to resource allocation:
  architecture can keep BIOS settings for some devices,
  and re-allocate resources for others, including improperly
  initialized bridges;
- makes prefetchable ranges support much simpler;
- allows sizing of IO and memory ranges for the host
  bridges, which might be very useful in some situations.

It was tested on various alphas; I haven't heard any complaints
from rmk and rth, so probably all of this is ok. :-)

Part 1:
- for all archs, 4th argument (align) added to
  pcibios_align_resource (and its callers).
  It's necessary because this function will be called for
  bus resources as well, and in this case size != alignment.
- for several archs, dead/bogus code removed from
  pcibios_fixup_pbus_ranges().

Ivan.

--- 2.5.14/arch/i386/kernel/pci-i386.c	Fri May  3 04:22:45 2002
+++ linux/arch/i386/kernel/pci-i386.c	Sun May  5 18:40:21 2002
@@ -136,7 +136,8 @@ pcibios_update_resource(struct pci_dev *
  * which might have be mirrored at 0x0100-0x03ff..
  */
 void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long start = res->start;
--- 2.5.14/arch/sparc64/kernel/pci.c	Fri May  3 04:22:37 2002
+++ linux/arch/sparc64/kernel/pci.c	Sun May  5 18:40:21 2002
@@ -311,7 +311,8 @@ void pcibios_fixup_pbus_ranges(struct pc
 {
 }
 
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+void pcibios_align_resource(void *data, struct resource *res,
+			    unsigned long size, unsigned long align)
 {
 }
 
--- 2.5.14/arch/ppc/kernel/pci.c	Fri May  3 04:22:52 2002
+++ linux/arch/ppc/kernel/pci.c	Sun May  5 18:40:21 2002
@@ -1083,10 +1083,6 @@ common_swizzle(struct pci_dev *dev, unsi
 void __init
 pcibios_fixup_pbus_ranges(struct pci_bus * bus, struct pbus_set_ranges_data * ranges)
 {
-	ranges->io_start -= bus->resource[0]->start;
-	ranges->io_end -= bus->resource[0]->start;
-	ranges->mem_start -= bus->resource[1]->start;
-	ranges->mem_end -= bus->resource[1]->start;
 }
 
 unsigned long resource_fixup(struct pci_dev * dev, struct resource * res,
--- 2.5.14/arch/mips/kernel/pci.c	Fri May  3 04:22:43 2002
+++ linux/arch/mips/kernel/pci.c	Sun May  5 18:40:21 2002
@@ -161,7 +161,8 @@ char *pcibios_setup(char *str)
 }
 
 void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 	/* this should not be called */
 }
--- 2.5.14/arch/mips/ite-boards/generic/it8172_pci.c	Fri May  3 04:22:55 2002
+++ linux/arch/mips/ite-boards/generic/it8172_pci.c	Sun May  5 18:40:21 2002
@@ -241,7 +241,8 @@ pcibios_enable_device(struct pci_dev *de
 
 
 void __init
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
     printk("pcibios_align_resource\n");
 }
--- 2.5.14/arch/mips/mips-boards/generic/pci.c	Fri May  3 04:22:50 2002
+++ linux/arch/mips/mips-boards/generic/pci.c	Mon May  6 21:28:07 2002
@@ -286,7 +286,8 @@ pcibios_enable_device(struct pci_dev *de
 }
 
 void __init
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 }
 
--- 2.5.14/arch/mips/ddb5xxx/common/pci.c	Fri May  3 04:22:57 2002
+++ linux/arch/mips/ddb5xxx/common/pci.c	Sun May  5 18:40:21 2002
@@ -164,7 +164,8 @@ char *pcibios_setup(char *str)
 }
 
 void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 	/* this should not be called */
 	MIPS_ASSERT(1 == 0);
--- 2.5.14/arch/mips/gt64120/common/pci.c	Fri May  3 04:22:53 2002
+++ linux/arch/mips/gt64120/common/pci.c	Mon May  6 21:27:03 2002
@@ -886,7 +886,7 @@ void pcibios_update_resource(struct pci_
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size)
+			    unsigned long size, unsigned long align)
 {
 	struct pci_dev *dev = data;
 
--- 2.5.14/arch/mips/ddb5074/pci.c	Fri May  3 04:22:53 2002
+++ linux/arch/mips/ddb5074/pci.c	Sun May  5 18:40:21 2002
@@ -319,10 +319,6 @@ void __init pcibios_update_irq(struct pc
 void __init pcibios_fixup_pbus_ranges(struct pci_bus *bus,
 				      struct pbus_set_ranges_data *ranges)
 {
-	ranges->io_start -= bus->resource[0]->start;
-	ranges->io_end -= bus->resource[0]->start;
-	ranges->mem_start -= bus->resource[1]->start;
-	ranges->mem_end -= bus->resource[1]->start;
 }
 
 int pcibios_enable_resources(struct pci_dev *dev)
@@ -396,7 +392,7 @@ void pcibios_update_resource(struct pci_
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size)
+			    unsigned long size, unsigned long align)
 {
 	struct pci_dev *dev = data;
 
--- 2.5.14/arch/mips/ddb5476/pci.c	Fri May  3 04:22:49 2002
+++ linux/arch/mips/ddb5476/pci.c	Sun May  5 18:40:21 2002
@@ -470,7 +470,7 @@ void pcibios_update_resource(struct pci_
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size)
+			    unsigned long size, unsigned long align)
 {
 	struct pci_dev *dev = data;
 
--- 2.5.14/arch/mips/sni/pci.c	Fri May  3 04:22:54 2002
+++ linux/arch/mips/sni/pci.c	Sun May  5 18:40:21 2002
@@ -199,7 +199,8 @@ int __init pcibios_enable_device(struct 
 }
 
 void __init
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 }
 
--- 2.5.14/arch/alpha/kernel/pci.c	Fri May  3 04:22:40 2002
+++ linux/arch/alpha/kernel/pci.c	Mon May  6 21:34:29 2002
@@ -128,7 +128,8 @@ struct pci_fixup pcibios_fixups[] __init
 #define GB			(1024*MB)
 
 void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 	struct pci_dev *dev = data;
 	struct pci_controller *hose = dev->sysdata;
@@ -168,7 +169,7 @@ pcibios_align_resource(void *data, struc
 		 */
 
 		/* Align to multiple of size of minimum base.  */
-		alignto = MAX(0x1000, size);
+		alignto = MAX(0x1000, align);
 		start = ALIGN(start, alignto);
 		if (hose->sparse_mem_base && size <= 7 * 16*MB) {
 			if (((start / (16*MB)) & 0x7) == 0) {
--- 2.5.14/arch/sparc/kernel/pcic.c	Fri May  3 04:22:37 2002
+++ linux/arch/sparc/kernel/pcic.c	Mon May  6 21:26:04 2002
@@ -865,7 +865,8 @@ void pcibios_update_resource(struct pci_
 {
 }
 
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+void pcibios_align_resource(void *data, struct resource *res,
+			    unsigned long size, unsigned long align)
 {
 }
 
--- 2.5.14/arch/x86_64/kernel/pci-x86_64.c	Fri May  3 04:22:57 2002
+++ linux/arch/x86_64/kernel/pci-x86_64.c	Sun May  5 18:40:21 2002
@@ -136,7 +136,8 @@ pcibios_update_resource(struct pci_dev *
  * which might have be mirrored at 0x0100-0x03ff..
  */
 void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long start = res->start;
--- 2.5.14/arch/ia64/kernel/pci.c	Fri May  3 04:22:52 2002
+++ linux/arch/ia64/kernel/pci.c	Sun May  5 18:40:21 2002
@@ -259,10 +259,6 @@ pcibios_update_irq (struct pci_dev *dev,
 void __init
 pcibios_fixup_pbus_ranges (struct pci_bus * bus, struct pbus_set_ranges_data * ranges)
 {
-	ranges->io_start -= bus->resource[0]->start;
-	ranges->io_end -= bus->resource[0]->start;
-	ranges->mem_start -= bus->resource[1]->start;
-	ranges->mem_end -= bus->resource[1]->start;
 }
 
 int
@@ -278,7 +274,8 @@ pcibios_enable_device (struct pci_dev *d
 }
 
 void
-pcibios_align_resource (void *data, struct resource *res, unsigned long size)
+pcibios_align_resource (void *data, struct resource *res,
+		        unsigned long size, unsigned long align)
 {
 }
 
--- 2.5.14/arch/arm/kernel/bios32.c	Fri May  3 04:22:50 2002
+++ linux/arch/arm/kernel/bios32.c	Mon May  6 21:34:29 2002
@@ -662,7 +662,8 @@ char * __init pcibios_setup(char *str)
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might be mirrored at 0x0100-0x03ff..
  */
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+void pcibios_align_resource(void *data, struct resource *res,
+			    unsigned long size, unsigned long align)
 {
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long start = res->start;
--- 2.5.14/arch/mips64/sgi-ip27/ip27-pci.c	Fri May  3 04:22:55 2002
+++ linux/arch/mips64/sgi-ip27/ip27-pci.c	Sun May  5 18:40:21 2002
@@ -238,10 +238,6 @@ void __init
 pcibios_fixup_pbus_ranges(struct pci_bus * bus,
                           struct pbus_set_ranges_data * ranges)
 {
-	ranges->io_start  -= bus->resource[0]->start;
-	ranges->io_end    -= bus->resource[0]->start;
-	ranges->mem_start -= bus->resource[1]->start;
-	ranges->mem_end   -= bus->resource[1]->start;
 }
 
 int __init
@@ -252,7 +248,8 @@ pcibios_enable_device(struct pci_dev *de
 }
 
 void __init
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 }
 
--- 2.5.14/arch/mips64/mips-boards/generic/pci.c	Fri May  3 04:22:41 2002
+++ linux/arch/mips64/mips-boards/generic/pci.c	Sun May  5 18:40:21 2002
@@ -290,7 +290,8 @@ pcibios_enable_device(struct pci_dev *de
 }
 
 void __init
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 }
 
--- 2.5.14/arch/mips64/sgi-ip32/ip32-pci.c	Fri May  3 04:22:58 2002
+++ linux/arch/mips64/sgi-ip32/ip32-pci.c	Sun May  5 18:40:21 2002
@@ -329,7 +329,7 @@ char * __init pcibios_setup (char *str)
 }
 
 void __init pcibios_align_resource (void *data, struct resource *res,
-				    unsigned long size)
+				    unsigned long size, unsigned long align)
 {
 }
 
@@ -352,10 +352,6 @@ void __init pcibios_fixup_bus (struct pc
 void __init pcibios_fixup_pbus_ranges(struct pci_bus * bus,
 				      struct pbus_set_ranges_data * ranges)
 {
-	ranges->io_start -= bus->resource[0]->start;
-	ranges->io_end -= bus->resource[0]->start;
-	ranges->mem_start -= bus->resource[1]->start;
-	ranges->mem_end -= bus->resource[1]->start;
 }
 
 /*
--- 2.5.14/arch/ppc64/kernel/pci.c	Fri May  3 04:22:47 2002
+++ linux/arch/ppc64/kernel/pci.c	Mon May  6 21:24:50 2002
@@ -180,7 +180,8 @@ pcibios_fixup_resources(struct pci_dev* 
  * which might have be mirrored at 0x0100-0x03ff..
  */
 void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
 {
 	struct pci_dev *dev = data;
 
--- 2.5.14/arch/sh/kernel/pci_st40.c	Fri May  3 04:22:56 2002
+++ linux/arch/sh/kernel/pci_st40.c	Sun May  5 18:40:21 2002
@@ -414,10 +414,6 @@ void __init
 pcibios_fixup_pbus_ranges(struct pci_bus *bus,
 			  struct pbus_set_ranges_data *ranges)
 {
-	ranges->io_start -= bus->resource[0]->start;
-	ranges->io_end -= bus->resource[0]->start;
-	ranges->mem_start -= bus->resource[1]->start;
-	ranges->mem_end -= bus->resource[1]->start;
 }
 
 void __init pcibios_init(void)
--- 2.5.14/arch/sh/kernel/pcibios.c	Fri May  3 04:22:47 2002
+++ linux/arch/sh/kernel/pcibios.c	Mon May  6 21:23:52 2002
@@ -60,7 +60,8 @@ pcibios_update_resource(struct pci_dev *
  * addresses to be allocated in the 0x000-0x0ff region
  * modulo 0x400.
  */
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+void pcibios_align_resource(void *data, struct resource *res,
+			    unsigned long size, unsigned long align)
 {
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long start = res->start;
--- 2.5.14/arch/parisc/kernel/pci.c	Fri May  3 04:22:38 2002
+++ linux/arch/parisc/kernel/pci.c	Sun May  5 18:40:21 2002
@@ -337,13 +337,15 @@ void pcibios_fixup_pbus_ranges(
 ** than res->start.
 */
 void __devinit
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long alignment)
 {
 	unsigned long mask, align;
 
-	DBG_RES("pcibios_align_resource(%s, (%p) [%lx,%lx]/%x, 0x%lx)\n",
+	DBG_RES("pcibios_align_resource(%s, (%p) [%lx,%lx]/%x, 0x%lx, 0x%lx)\n",
 		((struct pci_dev *) data)->slot_name,
-		res->parent, res->start, res->end, (int) res->flags, size);
+		res->parent, res->start, res->end,
+		(int) res->flags, size, alignment);
 
 	/* has resource already been aligned/assigned? */
 	if (res->parent)
@@ -400,11 +402,11 @@ pcibios_size_bridge(struct pci_bus *bus,
 
 			if (res.flags & IORESOURCE_IO) {
 				res.start = inner.io_end;
-				pcibios_align_resource(dev, &res, size);
+				pcibios_align_resource(dev, &res, size, 0);
 				inner.io_end += res.start + size;
 			} else if (res.flags & IORESOURCE_MEM) {
 				res.start = inner.mem_end;
-				pcibios_align_resource(dev, &res, size);
+				pcibios_align_resource(dev, &res, size, 0);
 				inner.mem_end = res.start + size;
 			}
 
--- 2.5.14/include/linux/ioport.h	Fri May  3 04:22:44 2002
+++ linux/include/linux/ioport.h	Sun May  5 18:40:21 2002
@@ -92,7 +92,8 @@ extern int allocate_resource(struct reso
 			     unsigned long size,
 			     unsigned long min, unsigned long max,
 			     unsigned long align,
-			     void (*alignf)(void *, struct resource *, unsigned long),
+			     void (*alignf)(void *, struct resource *,
+					    unsigned long, unsigned long),
 			     void *alignf_data);
 
 /* Convenience shorthand with allocation */
--- 2.5.14/include/linux/pci.h	Fri May  3 04:22:52 2002
+++ linux/include/linux/pci.h	Mon May  6 21:34:29 2002
@@ -501,7 +501,8 @@ int pcibios_enable_device(struct pci_dev
 char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */
-void pcibios_align_resource(void *, struct resource *, unsigned long);
+void pcibios_align_resource(void *, struct resource *,
+			    unsigned long, unsigned long);
 void pcibios_update_resource(struct pci_dev *, struct resource *,
 			     struct resource *, int);
 void pcibios_update_irq(struct pci_dev *, int irq);
--- 2.5.14/drivers/pci/setup-res.c	Fri May  3 04:22:47 2002
+++ linux/drivers/pci/setup-res.c	Mon May  6 21:34:29 2002
@@ -69,6 +69,7 @@ static int pci_assign_bus_resource(const
 	unsigned int type_mask,
 	int resno)
 {
+	unsigned long align;
 	int i;
 
 	type_mask |= IORESOURCE_IO | IORESOURCE_MEM;
@@ -81,12 +82,20 @@ static int pci_assign_bus_resource(const
 		if ((res->flags ^ r->flags) & type_mask)
 			continue;
 
-		/* We cannot allocate a non-prefetching resource from a pre-fetching area */
-		if ((r->flags & IORESOURCE_PREFETCH) && !(res->flags & IORESOURCE_PREFETCH))
+		/* We cannot allocate a non-prefetching resource
+		   from a pre-fetching area */
+		if ((r->flags & IORESOURCE_PREFETCH) &&
+		    !(res->flags & IORESOURCE_PREFETCH))
 			continue;
 
+		/* The bridge resources are special, as their
+		   size != alignment. Sizing routines return
+		   required alignment in the "start" field. */
+		align = (resno < PCI_BRIDGE_RESOURCES) ? size : res->start;
+
 		/* Ok, try it out.. */
-		if (allocate_resource(r, res, size, min, -1, size, pcibios_align_resource, dev) < 0)
+		if (allocate_resource(r, res, size, min, -1, align,
+				      pcibios_align_resource, dev) < 0)
 			continue;
 
 		/* Update PCI config space.  */
--- 2.5.14/kernel/resource.c	Fri May  3 04:22:41 2002
+++ linux/kernel/resource.c	Sun May  5 18:40:21 2002
@@ -152,7 +152,8 @@ static int find_resource(struct resource
 			 unsigned long size,
 			 unsigned long min, unsigned long max,
 			 unsigned long align,
-			 void (*alignf)(void *, struct resource *, unsigned long),
+			 void (*alignf)(void *, struct resource *,
+					unsigned long, unsigned long),
 			 void *alignf_data)
 {
 	struct resource *this = root->child;
@@ -169,7 +170,7 @@ static int find_resource(struct resource
 			new->end = max;
 		new->start = (new->start + align - 1) & ~(align - 1);
 		if (alignf)
-			alignf(alignf_data, new, size);
+			alignf(alignf_data, new, size, align);
 		if (new->start < new->end && new->end - new->start + 1 >= size) {
 			new->end = new->start + size - 1;
 			return 0;
@@ -189,7 +190,8 @@ int allocate_resource(struct resource *r
 		      unsigned long size,
 		      unsigned long min, unsigned long max,
 		      unsigned long align,
-		      void (*alignf)(void *, struct resource *, unsigned long),
+		      void (*alignf)(void *, struct resource *,
+				     unsigned long, unsigned long),
 		      void *alignf_data)
 {
 	int err;
