Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161192AbWF0QiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbWF0QiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWF0QiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:38:01 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44010 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161180AbWF0Qhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:50 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 13/17] [PATCH] 64bit resource: change pci core and arch code to use resource_size_t
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:49 -0700
Message-Id: <11514260761750-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260722341-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com> <11514260543854-git-send-email-greg@kroah.com> <11514260583661-git-send-email-greg@kroah.com> <11514260612035-git-send-email-greg@kroah.com> <11514260651070-git-send-email-greg@kroah.com> <11514260692919-git-send-email-greg@kroah.com> <11514260722341-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
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
 arch/powerpc/kernel/pci_32.c          |   10 +++++-----
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
 31 files changed, 76 insertions(+), 74 deletions(-)

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
index 302fc14..45da06f 100644
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
index 1e9d062..a2b9c60 100644
--- a/arch/cris/arch-v32/drivers/pci/bios.c
+++ b/arch/cris/arch-v32/drivers/pci/bios.c
@@ -43,10 +43,10 @@ int pci_mmap_page_range(struct pci_dev *
 
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
index a151f7a..10154a2 100644
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
index 77375a5..5bef0e3 100644
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
index 4dfce15..ba66f8c 100644
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
index d9e2506..8474355 100644
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
@@ -1756,7 +1756,7 @@ #endif /* CONFIG_PPC_PMAC */
 
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
-			  u64 *start, u64 *end)
+			  resource_size_t *start, resource_size_t *end)
 {
 	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
 	unsigned long offset = 0;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 247937d..286aa52 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -138,11 +138,11 @@ #endif
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
index 8544e10..242bb05 100644
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
@@ -1130,7 +1130,7 @@ long sys_pciconfig_iobase(long which, un
 
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
index bcfdddd..5df3ebd 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -860,7 +860,7 @@ char * __init pcibios_setup(char *str)
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 }
 
diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 6c9e3e9..20ca9ec 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -357,7 +357,7 @@ void pcibios_update_irq(struct pci_dev *
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
index c6f471b..eda029f 100644
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
index 7230926..5f7db9d 100644
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
index bc405c0..606f9b6 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -87,7 +87,7 @@ resource_show(struct device * dev, struc
 	char * str = buf;
 	int i;
 	int max = 7;
-	u64 start, end;
+	resource_size_t start, end;
 
 	if (pci_dev->subordinate)
 		max = DEVICE_COUNT_RESOURCE;
@@ -365,7 +365,7 @@ pci_mmap_resource(struct kobject *kobj, 
 						       struct device, kobj));
 	struct resource *res = (struct resource *)attr->private;
 	enum pci_mmap_state mmap_type;
-	u64 start, end;
+	resource_size_t start, end;
 	int i;
 
 	for (i = 0; i < PCI_ROM_RESOURCE; i++)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 29bdeca..9cc842b 100644
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
index f5ff0d3..ab78e4b 100644
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
@@ -209,7 +209,7 @@ pdev_sort_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct resource_list *list, *tmp;
-		unsigned long r_align;
+		resource_size_t r_align;
 
 		r = &dev->resource[i];
 		r_align = r->end - r->start;
@@ -225,7 +225,7 @@ pdev_sort_resources(struct pci_dev *dev,
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
index 62a8c22..983fca2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -404,8 +404,8 @@ int pcibios_enable_device(struct pci_dev
 char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */
-void pcibios_align_resource(void *, struct resource *,
-			    unsigned long, unsigned long);
+void pcibios_align_resource(void *, struct resource *, resource_size_t,
+				resource_size_t);
 void pcibios_update_irq(struct pci_dev *, int irq);
 
 /* Generic PCI functions used internally */
@@ -532,10 +532,10 @@ void pci_release_region(struct pci_dev *
 
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
 
@@ -730,7 +730,8 @@ static inline char *pci_name(struct pci_
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

