Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWFMAfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWFMAfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbWFMAfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:35:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:63467 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932689AbWFMAei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:34:38 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/16] 64bit resource: change pci core and arch code to use resource_size_t
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 12 Jun 2006 17:31:15 -0700
Message-Id: <11501587223213-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11501587193060-git-send-email-greg@kroah.com>
References: <20060613003033.GA10717@kroah.com> <11501586781628-git-send-email-greg@kroah.com> <1150158683636-git-send-email-greg@kroah.com> <11501586871870-git-send-email-greg@kroah.com> <11501586902008-git-send-email-greg@kroah.com> <11501586942938-git-send-email-greg@kroah.com> <11501586982289-git-send-email-greg@kroah.com> <11501587011194-git-send-email-greg@kroah.com> <11501587043722-git-send-email-greg@kroah.com> <11501587082203-git-send-email-greg@kroah.com> <11501587122736-git-send-email-greg@kroah.com> <11501587153872-git-send-email-greg@kroah.com> <11501587193060-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/alpha/kernel/pci.c               |    4 ++--
 arch/arm/kernel/bios32.c              |    6 +++---
 arch/cris/arch-v32/drivers/pci/bios.c |    4 ++--
 arch/frv/mb93090-mb00/pci-frv.c       |    4 ++--
 arch/i386/pci/i386.c                  |    4 ++--
 arch/ia64/pci/pci.c                   |    2 +-
 arch/m68knommu/kernel/comempci.c      |    3 ++-
 arch/mips/pci/pci.c                   |    4 ++--
 arch/mips/pmc-sierra/yosemite/ht.c    |    4 ++--
 arch/parisc/kernel/pci.c              |    2 +-
 arch/powerpc/kernel/pci_32.c          |   22 +++++++++++++++-------
 arch/powerpc/kernel/pci_64.c          |    4 ++--
 arch/ppc/kernel/pci.c                 |   12 ++++++------
 arch/sh/boards/mpc1211/pci.c          |    4 ++--
 arch/sh/boards/overdrive/galileo.c    |    2 +-
 arch/sh/drivers/pci/pci.c             |    6 +++---
 arch/sh64/kernel/pcibios.c            |    4 ++--
 arch/sparc/kernel/pcic.c              |    2 +-
 arch/sparc64/kernel/pci.c             |    2 +-
 arch/v850/kernel/rte_mb_a_pci.c       |    2 +-
 arch/xtensa/kernel/pci.c              |    6 +++---
 drivers/pci/bus.c                     |   10 +++++-----
 drivers/pci/pci-sysfs.c               |    4 ++--
 drivers/pci/pci.h                     |    6 +++---
 drivers/pci/proc.c                    |    4 ++--
 drivers/pci/rom.c                     |   10 +++++-----
 drivers/pci/setup-res.c               |    6 +++---
 include/asm-arm/mach/pci.h            |    2 +-
 include/asm-powerpc/pci.h             |    2 +-
 include/asm-ppc/pci.h                 |    2 +-
 include/linux/pci.h                   |   13 +++++++------
 31 files changed, 86 insertions(+), 76 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 2a8b364..4ea6711 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -124,12 +124,12 @@ #define GB			(1024*MB)
 
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	struct pci_controller *hose = dev->sysdata;
 	unsigned long alignto;
-	unsigned long start = res->start;
+	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
 		/* Make sure we start at our min on all hoses */
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index de606df..e97dc54 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -304,7 +304,7 @@ static inline int pdev_bad_for_parity(st
 static void __devinit
 pdev_fixup_device_resources(struct pci_sys_data *root, struct pci_dev *dev)
 {
-	unsigned long offset;
+	resource_size_t offset;
 	int i;
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -634,9 +634,9 @@ char * __init pcibios_setup(char *str)
  * which might be mirrored at 0x0100-0x03ff..
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
-	unsigned long start = res->start;
+	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
index 24bc149..1a076df 100644
--- a/arch/cris/arch-v32/drivers/pci/bios.c
+++ b/arch/cris/arch-v32/drivers/pci/bios.c
@@ -45,10 +45,10 @@ int pci_mmap_page_range(struct pci_dev *
 
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff --git a/arch/frv/mb93090-mb00/pci-frv.c b/arch/frv/mb93090-mb00/pci-frv.c
index 0a26bf6..4f165c9 100644
--- a/arch/frv/mb93090-mb00/pci-frv.c
+++ b/arch/frv/mb93090-mb00/pci-frv.c
@@ -64,10 +64,10 @@ #endif
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff --git a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
index ed2c8c8..d2add37 100644
--- a/arch/i386/pci/i386.c
+++ b/arch/i386/pci/i386.c
@@ -48,10 +48,10 @@ #include "pci.h"
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+			resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index ab829a2..c355638 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -568,7 +568,7 @@ pcibios_disable_device (struct pci_dev *
 
 void
 pcibios_align_resource (void *data, struct resource *res,
-		        unsigned long size, unsigned long align)
+		        resource_size_t size, resource_size_t align)
 {
 }
 
diff --git a/arch/m68knommu/kernel/comempci.c b/arch/m68knommu/kernel/comempci.c
index 8670938..db7a0c1 100644
--- a/arch/m68knommu/kernel/comempci.c
+++ b/arch/m68knommu/kernel/comempci.c
@@ -357,7 +357,8 @@ void pcibios_fixup_bus(struct pci_bus *b
 
 /*****************************************************************************/
 
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size, unsigned long align)
+void pcibios_align_resource(void *data, struct resource *res,
+				resource_size_t size, resource_size_t align)
 {
 }
 
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 21402ff..20278b9 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -51,11 +51,11 @@ unsigned long PCIBIOS_MIN_MEM	= 0;
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	struct pci_controller *hose = dev->sysdata;
-	unsigned long start = res->start;
+	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
 		/* Make sure we start at our min on all hoses */
diff --git a/arch/mips/pmc-sierra/yosemite/ht.c b/arch/mips/pmc-sierra/yosemite/ht.c
index 54b65a8..fb523eb 100644
--- a/arch/mips/pmc-sierra/yosemite/ht.c
+++ b/arch/mips/pmc-sierra/yosemite/ht.c
@@ -383,12 +383,12 @@ void pcibios_update_resource(struct pci_
 
 
 void pcibios_align_resource(void *data, struct resource *res,
-                            unsigned long size, unsigned long align)
+                            resource_size_t size, resource_size_t align)
 {
         struct pci_dev *dev = data;
 
         if (res->flags & IORESOURCE_IO) {
-                unsigned long start = res->start;
+                resource_size_t start = res->start;
 
                 /* We need to avoid collisions with `mirrored' VGA ports
                    and other strange ISA hardware, so we always want the
diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index 79c7db2..7d6967e 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -289,7 +289,7 @@ #endif
  * than res->start.
  */
 void pcibios_align_resource(void *data, struct resource *res,
-				unsigned long size, unsigned long alignment)
+				resource_size_t size, resource_size_t alignment)
 {
 	unsigned long mask, align;
 
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 18886e8..c78b545 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -173,18 +173,18 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
  */
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size,
-		       unsigned long align)
+void pcibios_align_resource(void *data, struct resource *res,
+				resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
 			       " (%lld bytes)\n", pci_name(dev),
-			       dev->resource - res, size);
+			       dev->resource - res, (unsigned long long)size);
 		}
 
 		if (start & 0x300) {
@@ -1114,8 +1114,16 @@ check_for_io_childs(struct pci_bus *bus,
 	int	i;
 	int	rc = 0;
 
-#define push_end(res, size) do { unsigned long __sz = (size) ; \
-	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
+	/*
+	 * Assuming mask is a power of two - 1, push_end
+	 * moves res->end to the end of the next
+	 * mask-aligned boundary.
+	 * e.g. res->end of 0x1fff moves to 0x2fff
+	 */
+#define push_end(res, mask) do {				\
+	BUG_ON(((mask+1) & mask) != 0);			\
+	res->end = -(-res->end & ~(unsigned long)mask);		\
+	res->end += mask;					\
     } while (0)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -1756,7 +1764,7 @@ #endif /* CONFIG_PPC_PMAC */
 
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
-			  u64 *start, u64 *end)
+			  resource_size_t *start, resource_size_t *end)
 {
 	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
 	unsigned long offset = 0;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 4c4449b..0ba0413 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -146,11 +146,11 @@ #endif
  * which might have be mirrored at 0x0100-0x03ff..
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long start = res->start;
+	resource_size_t start = res->start;
 	unsigned long alignto;
 
 	if (res->flags & IORESOURCE_IO) {
diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
index 3ddc1e0..4c836df 100644
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -171,13 +171,13 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
  */
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size,
-		       unsigned long align)
+void pcibios_align_resource(void *data, struct resource *res,
+				resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
@@ -960,8 +960,8 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	else
 		prot |= _PAGE_GUARDED;
 
-	printk("PCI map for %s:%llx, prot: %llx\n", pci_name(dev), rp->start,
-	       prot);
+	printk("PCI map for %s:%llx, prot: %lx\n", pci_name(dev),
+		(unsigned long long)rp->start, prot);
 
 	return __pgprot(prot);
 }
@@ -1131,7 +1131,7 @@ long sys_pciconfig_iobase(long which, un
 
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
-			  u64 *start, u64 *end)
+			  resource_size_t *start, resource_size_t *end)
 {
 	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
 	unsigned long offset = 0;
diff --git a/arch/sh/boards/mpc1211/pci.c b/arch/sh/boards/mpc1211/pci.c
index ba3a654..9f7ccd3 100644
--- a/arch/sh/boards/mpc1211/pci.c
+++ b/arch/sh/boards/mpc1211/pci.c
@@ -273,9 +273,9 @@ void __init pcibios_fixup_irqs(void)
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
-	unsigned long start = res->start;
+	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
 		if (start >= 0x10000UL) {
diff --git a/arch/sh/boards/overdrive/galileo.c b/arch/sh/boards/overdrive/galileo.c
index 276fa11..b055809 100644
--- a/arch/sh/boards/overdrive/galileo.c
+++ b/arch/sh/boards/overdrive/galileo.c
@@ -536,7 +536,7 @@ void __init pcibios_fixup_bus(struct pci
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size)
+			    resource_size_t size)
 {
 }
 
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index c166990..3d546ba 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -75,7 +75,7 @@ pcibios_update_resource(struct pci_dev *
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 			    __attribute__ ((weak));
 
 /*
@@ -85,10 +85,10 @@ void pcibios_align_resource(void *data, 
  * modulo 0x400.
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff --git a/arch/sh64/kernel/pcibios.c b/arch/sh64/kernel/pcibios.c
index 50c61dc..945920b 100644
--- a/arch/sh64/kernel/pcibios.c
+++ b/arch/sh64/kernel/pcibios.c
@@ -69,10 +69,10 @@ pcibios_update_resource(struct pci_dev *
  * modulo 0x400.
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 42002b7..f181835 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -859,7 +859,7 @@ char * __init pcibios_setup(char *str)
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 }
 
diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index f97ddeb..3bd582e 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -390,7 +390,7 @@ void pcibios_update_irq(struct pci_dev *
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 }
 
diff --git a/arch/v850/kernel/rte_mb_a_pci.c b/arch/v850/kernel/rte_mb_a_pci.c
index ffbb6d0..3a7c5c9 100644
--- a/arch/v850/kernel/rte_mb_a_pci.c
+++ b/arch/v850/kernel/rte_mb_a_pci.c
@@ -329,7 +329,7 @@ void pcibios_fixup_bus(struct pci_bus *b
 
 void
 pcibios_align_resource (void *data, struct resource *res,
-			unsigned long size, unsigned long align)
+			resource_size_t size, resource_size_t align)
 {
 }
 
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index de19501..19373ef 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -71,13 +71,13 @@ static int pci_bus_count;
  * which might have be mirrored at 0x0100-0x03ff..
  */
 void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size,
-    		       unsigned long align)
+pcibios_align_resource(void *data, struct resource *res, resource_size_t size,
+    		       resource_size_t align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index eed67d9..d3ca2f9 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -34,11 +34,11 @@ #include "pci.h"
  */
 int
 pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-	unsigned long size, unsigned long align, unsigned long min,
-	unsigned int type_mask,
-	void (*alignf)(void *, struct resource *,
-			unsigned long, unsigned long),
-	void *alignf_data)
+		resource_size_t size, resource_size_t align,
+		resource_size_t min, unsigned int type_mask,
+		void (*alignf)(void *, struct resource *, resource_size_t,
+				resource_size_t),
+		void *alignf_data)
 {
 	int i, ret = -ENOMEM;
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 56ac2bc..df14c54 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -64,7 +64,7 @@ resource_show(struct device * dev, struc
 	char * str = buf;
 	int i;
 	int max = 7;
-	u64 start, end;
+	resource_size_t start, end;
 
 	if (pci_dev->subordinate)
 		max = DEVICE_COUNT_RESOURCE;
@@ -320,7 +320,7 @@ pci_mmap_resource(struct kobject *kobj, 
 						       struct device, kobj));
 	struct resource *res = (struct resource *)attr->private;
 	enum pci_mmap_state mmap_type;
-	u64 start, end;
+	resource_size_t start, end;
 	int i;
 
 	for (i = 0; i < PCI_ROM_RESOURCE; i++)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 30630cb..1ea979a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -6,10 +6,10 @@ extern int pci_create_sysfs_dev_files(st
 extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_cleanup_rom(struct pci_dev *dev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-				  unsigned long size, unsigned long align,
-				  unsigned long min, unsigned int type_mask,
+				  resource_size_t size, resource_size_t align,
+				  resource_size_t min, unsigned int type_mask,
 				  void (*alignf)(void *, struct resource *,
-					  	 unsigned long, unsigned long),
+					      resource_size_t, resource_size_t),
 				  void *alignf_data);
 /* Firmware callbacks */
 extern int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 20dfd77..99cf333 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -350,14 +350,14 @@ static int show_device(struct seq_file *
 			dev->irq);
 	/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve compatibility */
 	for (i=0; i<7; i++) {
-		u64 start, end;
+		resource_size_t start, end;
 		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, "\t%16llx",
 			(unsigned long long)(start |
 			(dev->resource[i].flags & PCI_REGION_FLAG_MASK)));
 	}
 	for (i=0; i<7; i++) {
-		u64 start, end;
+		resource_size_t start, end;
 		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, "\t%16llx",
 			dev->resource[i].start < dev->resource[i].end ?
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 598a115..cbb69cf 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -80,8 +80,8 @@ void __iomem *pci_map_rom(struct pci_dev
 	} else {
 		if (res->flags & IORESOURCE_ROM_COPY) {
 			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-			return (void __iomem *)pci_resource_start(pdev,
-							     PCI_ROM_RESOURCE);
+			return (void __iomem *)(unsigned long)
+				pci_resource_start(pdev, PCI_ROM_RESOURCE);
 		} else {
 			/* assign the ROM an address if it doesn't have one */
 			if (res->parent == NULL &&
@@ -170,11 +170,11 @@ void __iomem *pci_map_rom_copy(struct pc
 		return rom;
 
 	res->end = res->start + *size;
-	memcpy_fromio((void*)res->start, rom, *size);
+	memcpy_fromio((void*)(unsigned long)res->start, rom, *size);
 	pci_unmap_rom(pdev, rom);
 	res->flags |= IORESOURCE_ROM_COPY;
 
-	return (void __iomem *)res->start;
+	return (void __iomem *)(unsigned long)res->start;
 }
 
 /**
@@ -227,7 +227,7 @@ void pci_cleanup_rom(struct pci_dev *pde
 {
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 	if (res->flags & IORESOURCE_ROM_COPY) {
-		kfree((void*)res->start);
+		kfree((void*)(unsigned long)res->start);
 		res->flags &= ~IORESOURCE_ROM_COPY;
 		res->start = 0;
 		res->end = 0;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d3e70ca..7b1e893 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -121,7 +121,7 @@ int pci_assign_resource(struct pci_dev *
 {
 	struct pci_bus *bus = dev->bus;
 	struct resource *res = dev->resource + resno;
-	unsigned long size, min, align;
+	resource_size_t size, min, align;
 	int ret;
 
 	size = res->end - res->start + 1;
@@ -169,7 +169,7 @@ pdev_sort_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct resource_list *list, *tmp;
-		unsigned long r_align;
+		resource_size_t r_align;
 
 		r = &dev->resource[i];
 		r_align = r->end - r->start;
@@ -185,7 +185,7 @@ pdev_sort_resources(struct pci_dev *dev,
 		}
 		r_align = (i < PCI_BRIDGE_RESOURCES) ? r_align + 1 : r->start;
 		for (list = head; ; list = list->next) {
-			unsigned long align = 0;
+			resource_size_t align = 0;
 			struct resource_list *ln = list->next;
 			int idx;
 
diff --git a/include/asm-arm/mach/pci.h b/include/asm-arm/mach/pci.h
index 25d540e..923e0ca 100644
--- a/include/asm-arm/mach/pci.h
+++ b/include/asm-arm/mach/pci.h
@@ -28,7 +28,7 @@ struct hw_pci {
 struct pci_sys_data {
 	struct list_head node;
 	int		busnr;		/* primary bus number			*/
-	unsigned long	mem_offset;	/* bus->cpu memory mapping offset	*/
+	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
 	unsigned long	io_offset;	/* bus->cpu IO mapping offset		*/
 	struct pci_bus	*bus;		/* PCI bus				*/
 	struct resource *resource[3];	/* Primary PCI bus resources		*/
diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
index 5d2c9e6..46afd29 100644
--- a/include/asm-powerpc/pci.h
+++ b/include/asm-powerpc/pci.h
@@ -242,7 +242,7 @@ #if defined(CONFIG_PPC_MULTIPLATFORM) ||
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
-				 u64 *start, u64 *end);
+				 resource_size_t *start, resource_size_t *end);
 #endif /* CONFIG_PPC_MULTIPLATFORM || CONFIG_PPC32 */
 
 #endif	/* __KERNEL__ */
diff --git a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
index 61434ed..11ffaaa 100644
--- a/include/asm-ppc/pci.h
+++ b/include/asm-ppc/pci.h
@@ -133,7 +133,7 @@ extern pgprot_t	pci_phys_mem_access_prot
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
-				 u64 *start, u64 *end);
+				 resource_size_t *start, resource_size_t *end);
 
 
 #endif	/* __KERNEL__ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a6a4e3..ad1943f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -402,8 +402,8 @@ int pcibios_enable_device(struct pci_dev
 char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */
-void pcibios_align_resource(void *, struct resource *,
-			    unsigned long, unsigned long);
+void pcibios_align_resource(void *, struct resource *, resource_size_t,
+				resource_size_t);
 void pcibios_update_irq(struct pci_dev *, int irq);
 
 /* Generic PCI functions used internally */
@@ -528,10 +528,10 @@ void pci_release_region(struct pci_dev *
 
 /* drivers/pci/bus.c */
 int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-			   unsigned long size, unsigned long align,
-			   unsigned long min, unsigned int type_mask,
+			   resource_size_t size, resource_size_t align,
+			   resource_size_t min, unsigned int type_mask,
 			   void (*alignf)(void *, struct resource *,
-					  unsigned long, unsigned long),
+					  resource_size_t, resource_size_t),
 			   void *alignf_data);
 void pci_enable_bridges(struct pci_bus *bus);
 
@@ -725,7 +725,8 @@ static inline char *pci_name(struct pci_
  */
 #ifndef HAVE_ARCH_PCI_RESOURCE_TO_USER
 static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
-                const struct resource *rsrc, u64 *start, u64 *end)
+                const struct resource *rsrc, resource_size_t *start,
+		resource_size_t *end)
 {
 	*start = rsrc->start;
 	*end = rsrc->end;
-- 
1.4.0

