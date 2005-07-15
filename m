Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVGOUyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVGOUyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVGOUyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:54:51 -0400
Received: from fmr20.intel.com ([134.134.136.19]:11143 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261151AbVGOUyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:54:45 -0400
Date: Fri, 15 Jul 2005 14:10:10 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200507152110.j6FLAAen014904@snoqualmie.dp.intel.com>
To: akpm@osdl.org
Subject: [patch] fix EFI memory map parsing for x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The memory descriptors that comprise the EFI memory map are
not fixed in stone such that the size could change in the 
future.  This uses the memory descriptor size obtained from
EFI to iterate over the memory map entries during boot. 
This enables the removal of an x86 specific pad (and ifdef) in
the EFI header.  I also couldn't stomach the broken up nature
of the function to put EFI runtime calls into virtual mode any 
longer so I fixed that up a bit as well.

For reference, this patch only impacts x86.

 arch/i386/kernel/efi.c   |  101 +++++++++++++++++++++++------------------------
 arch/i386/kernel/setup.c |   14 ++++--
 arch/i386/mm/init.c      |    5 +-
 include/asm-i386/setup.h |    2 
 include/linux/efi.h      |   14 +-----
 5 files changed, 67 insertions(+), 69 deletions(-)

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
---

diff -urNp linux-2.6.13-rc3/arch/i386/kernel/efi.c linux-2.6.13-rc3-efi/arch/i386/kernel/efi.c
--- linux-2.6.13-rc3/arch/i386/kernel/efi.c	2005-07-15 11:30:30.000000000 -0400
+++ linux-2.6.13-rc3-efi/arch/i386/kernel/efi.c	2005-07-15 12:08:55.000000000 -0400
@@ -233,22 +233,23 @@ void __init efi_map_memmap(void)
 {
 	memmap.map = NULL;
 
-	memmap.map = (efi_memory_desc_t *)
-		bt_ioremap((unsigned long) memmap.phys_map,
-			(memmap.nr_map * sizeof(efi_memory_desc_t)));
-
+	memmap.map = bt_ioremap((unsigned long) memmap.phys_map,
+			(memmap.nr_map * memmap.desc_size));
 	if (memmap.map == NULL)
 		printk(KERN_ERR PFX "Could not remap the EFI memmap!\n");
+
+	memmap.map_end = memmap.map + (memmap.nr_map * memmap.desc_size);
 }
 
 #if EFI_DEBUG
 static void __init print_efi_memmap(void)
 {
 	efi_memory_desc_t *md;
+	void *p;
 	int i;
 
-	for (i = 0; i < memmap.nr_map; i++) {
-		md = &memmap.map[i];
+	for (p = memmap.map, i = 0; p < memmap.map_end; p += memmap.desc_size, i++) {
+		md = p;
 		printk(KERN_INFO "mem%02u: type=%u, attr=0x%llx, "
 			"range=[0x%016llx-0x%016llx) (%lluMB)\n",
 			i, md->type, md->attribute, md->phys_addr,
@@ -271,10 +272,10 @@ void efi_memmap_walk(efi_freemem_callbac
 	} prev, curr;
 	efi_memory_desc_t *md;
 	unsigned long start, end;
-	int i;
+	void *p;
 
-	for (i = 0; i < memmap.nr_map; i++) {
-		md = &memmap.map[i];
+	for (p = memmap.map; p < memmap.map_end; p += memmap.desc_size) {
+		md = p;
 
 		if ((md->num_pages == 0) || (!is_available_memory(md)))
 			continue;
@@ -325,6 +326,7 @@ void __init efi_init(void)
 	memmap.phys_map = EFI_MEMMAP;
 	memmap.nr_map = EFI_MEMMAP_SIZE/EFI_MEMDESC_SIZE;
 	memmap.desc_version = EFI_MEMDESC_VERSION;
+	memmap.desc_size = EFI_MEMDESC_SIZE;
 
 	efi.systab = (efi_system_table_t *)
 		boot_ioremap((unsigned long) efi_phys.systab,
@@ -431,22 +433,30 @@ void __init efi_init(void)
 		printk(KERN_ERR PFX "Could not map the runtime service table!\n");
 
 	/* Map the EFI memory map for use until paging_init() */
-
-	memmap.map = (efi_memory_desc_t *)
-		boot_ioremap((unsigned long) EFI_MEMMAP, EFI_MEMMAP_SIZE);
-
+	memmap.map = boot_ioremap((unsigned long) EFI_MEMMAP, EFI_MEMMAP_SIZE);
 	if (memmap.map == NULL)
 		printk(KERN_ERR PFX "Could not map the EFI memory map!\n");
 
-	if (EFI_MEMDESC_SIZE != sizeof(efi_memory_desc_t)) {
-		printk(KERN_WARNING PFX "Warning! Kernel-defined memdesc doesn't "
-			   "match the one from EFI!\n");
-	}
+	memmap.map_end = memmap.map + (memmap.nr_map * memmap.desc_size);
+
 #if EFI_DEBUG
 	print_efi_memmap();
 #endif
 }
 
+static inline void __init check_range_for_systab(efi_memory_desc_t *md)
+{
+	if (((unsigned long)md->phys_addr <= (unsigned long)efi_phys.systab) &&
+		((unsigned long)efi_phys.systab < md->phys_addr +
+		((unsigned long)md->num_pages << EFI_PAGE_SHIFT))) {
+		unsigned long addr;
+
+		addr = md->virt_addr - md->phys_addr + 
+			(unsigned long)efi_phys.systab;
+		efi.systab = (efi_system_table_t *)addr;
+	}
+}
+
 /*
  * This function will switch the EFI runtime services to virtual mode.
  * Essentially, look through the EFI memmap and map every region that
@@ -460,43 +470,32 @@ void __init efi_enter_virtual_mode(void)
 {
 	efi_memory_desc_t *md;
 	efi_status_t status;
-	int i;
+	void *p;
 
 	efi.systab = NULL;
 
-	for (i = 0; i < memmap.nr_map; i++) {
-		md = &memmap.map[i];
+	for (p = memmap.map; p < memmap.map_end; p += memmap.desc_size) {
+		md = p;
 
-		if (md->attribute & EFI_MEMORY_RUNTIME) {
-			md->virt_addr =
-				(unsigned long)ioremap(md->phys_addr,
-					md->num_pages << EFI_PAGE_SHIFT);
-			if (!(unsigned long)md->virt_addr) {
-				printk(KERN_ERR PFX "ioremap of 0x%lX failed\n",
-					(unsigned long)md->phys_addr);
-			}
+		if (!(md->attribute & EFI_MEMORY_RUNTIME)) 
+			continue;
 
-			if (((unsigned long)md->phys_addr <=
-					(unsigned long)efi_phys.systab) &&
-				((unsigned long)efi_phys.systab <
-					md->phys_addr +
-					((unsigned long)md->num_pages <<
-						EFI_PAGE_SHIFT))) {
-				unsigned long addr;
-
-				addr = md->virt_addr - md->phys_addr +
-						(unsigned long)efi_phys.systab;
-				efi.systab = (efi_system_table_t *)addr;
-			}
+		md->virt_addr = (unsigned long)ioremap(md->phys_addr,
+			md->num_pages << EFI_PAGE_SHIFT);
+		if (!(unsigned long)md->virt_addr) {
+			printk(KERN_ERR PFX "ioremap of 0x%lX failed\n",
+				(unsigned long)md->phys_addr);
 		}
+		/* update the virtual address of the EFI system table */
+		check_range_for_systab(md);
 	}
 
 	if (!efi.systab)
 		BUG();
 
 	status = phys_efi_set_virtual_address_map(
-			sizeof(efi_memory_desc_t) * memmap.nr_map,
-			sizeof(efi_memory_desc_t),
+			memmap.desc_size * memmap.nr_map,
+			memmap.desc_size,
 			memmap.desc_version,
 		       	memmap.phys_map);
 
@@ -536,10 +535,10 @@ efi_initialize_iomem_resources(struct re
 {
 	struct resource *res;
 	efi_memory_desc_t *md;
-	int i;
+	void *p;
 
-	for (i = 0; i < memmap.nr_map; i++) {
-		md = &memmap.map[i];
+	for (p = memmap.map; p < memmap.map_end; p += memmap.desc_size) {
+		md = p;
 
 		if ((md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT)) >
 		    0x100000000ULL)
@@ -616,10 +615,10 @@ efi_initialize_iomem_resources(struct re
 u32 efi_mem_type(unsigned long phys_addr)
 {
 	efi_memory_desc_t *md;
-	int i;
+	void *p;
 
-	for (i = 0; i < memmap.nr_map; i++) {
-		md = &memmap.map[i];
+	for (p = memmap.map; p < memmap.map_end; p += memmap.desc_size) {
+		md = p;
 		if ((md->phys_addr <= phys_addr) && (phys_addr <
 			(md->phys_addr + (md-> num_pages << EFI_PAGE_SHIFT)) ))
 			return md->type;
@@ -630,10 +629,10 @@ u32 efi_mem_type(unsigned long phys_addr
 u64 efi_mem_attributes(unsigned long phys_addr)
 {
 	efi_memory_desc_t *md;
-	int i;
+	void *p;
 
-	for (i = 0; i < memmap.nr_map; i++) {
-		md = &memmap.map[i];
+	for (p = memmap.map; p < memmap.map_end; p += memmap.desc_size) {
+		md = p;
 		if ((md->phys_addr <= phys_addr) && (phys_addr <
 			(md->phys_addr + (md-> num_pages << EFI_PAGE_SHIFT)) ))
 			return md->attribute;
diff -urNp linux-2.6.13-rc3/arch/i386/kernel/setup.c linux-2.6.13-rc3-efi/arch/i386/kernel/setup.c
--- linux-2.6.13-rc3/arch/i386/kernel/setup.c	2005-07-15 11:30:30.000000000 -0400
+++ linux-2.6.13-rc3-efi/arch/i386/kernel/setup.c	2005-07-15 12:10:05.000000000 -0400
@@ -370,12 +370,16 @@ static void __init limit_regions(unsigne
 	int i;
 
 	if (efi_enabled) {
-		for (i = 0; i < memmap.nr_map; i++) {
-			current_addr = memmap.map[i].phys_addr +
-				       (memmap.map[i].num_pages << 12);
-			if (memmap.map[i].type == EFI_CONVENTIONAL_MEMORY) {
+		efi_memory_desc_t *md;
+		void *p;
+
+		for (p = memmap.map, i = 0; p < memmap.map_end; 
+			p += memmap.desc_size, i++) { 
+			md = p;
+			current_addr = md->phys_addr + (md->num_pages << 12);
+			if (md->type == EFI_CONVENTIONAL_MEMORY) {
 				if (current_addr >= size) {
-					memmap.map[i].num_pages -=
+					md->num_pages -=
 						(((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);
 					memmap.nr_map = i + 1;
 					return;
diff -urNp linux-2.6.13-rc3/arch/i386/mm/init.c linux-2.6.13-rc3-efi/arch/i386/mm/init.c
--- linux-2.6.13-rc3/arch/i386/mm/init.c	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/arch/i386/mm/init.c	2005-07-15 11:47:55.000000000 -0400
@@ -198,9 +198,10 @@ int page_is_ram(unsigned long pagenr)
 
 	if (efi_enabled) {
 		efi_memory_desc_t *md;
+		void *p;
 
-		for (i = 0; i < memmap.nr_map; i++) {
-			md = &memmap.map[i];
+		for (p = memmap.map; p < memmap.map_end; p += memmap.desc_size) {
+			md = p;
 			if (!is_available_memory(md))
 				continue;
 			addr = (md->phys_addr+PAGE_SIZE-1) >> PAGE_SHIFT;
diff -urNp linux-2.6.13-rc3/include/asm-i386/setup.h linux-2.6.13-rc3-efi/include/asm-i386/setup.h
--- linux-2.6.13-rc3/include/asm-i386/setup.h	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/include/asm-i386/setup.h	2005-07-15 11:48:19.000000000 -0400
@@ -44,7 +44,7 @@ extern unsigned char boot_params[PARAM_S
 #define EFI_SYSTAB ((efi_system_table_t *) *((unsigned long *)(PARAM+0x1c4)))
 #define EFI_MEMDESC_SIZE (*((unsigned long *) (PARAM+0x1c8)))
 #define EFI_MEMDESC_VERSION (*((unsigned long *) (PARAM+0x1cc)))
-#define EFI_MEMMAP ((efi_memory_desc_t *) *((unsigned long *)(PARAM+0x1d0)))
+#define EFI_MEMMAP ((void *) *((unsigned long *)(PARAM+0x1d0)))
 #define EFI_MEMMAP_SIZE (*((unsigned long *) (PARAM+0x1d4)))
 #define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAM+0x1F2))
 #define RAMDISK_FLAGS (*(unsigned short *) (PARAM+0x1F8))
diff -urNp linux-2.6.13-rc3/include/linux/efi.h linux-2.6.13-rc3-efi/include/linux/efi.h
--- linux-2.6.13-rc3/include/linux/efi.h	2005-07-15 11:30:30.000000000 -0400
+++ linux-2.6.13-rc3-efi/include/linux/efi.h	2005-07-15 11:49:21.000000000 -0400
@@ -91,11 +91,6 @@ typedef	struct {
 
 #define EFI_PAGE_SHIFT		12
 
-/*
- * For current x86 implementations of EFI, there is
- * additional padding in the mem descriptors.  This is not
- * the case in ia64.  Need to have this fixed in the f/w.
- */
 typedef struct {
 	u32 type;
 	u32 pad;
@@ -103,9 +98,6 @@ typedef struct {
 	u64 virt_addr;
 	u64 num_pages;
 	u64 attribute;
-#if defined (__i386__)
-	u64 pad1;
-#endif
 } efi_memory_desc_t;
 
 typedef int (*efi_freemem_callback_t) (unsigned long start, unsigned long end, void *arg);
@@ -240,10 +232,12 @@ typedef struct {
 } efi_system_table_t;
 
 struct efi_memory_map {
-	efi_memory_desc_t *phys_map;
-	efi_memory_desc_t *map;
+	void *phys_map;
+	void *map;
+	void *map_end;
 	int nr_map;
 	unsigned long desc_version;
+	unsigned long desc_size;
 };
 
 #define EFI_INVALID_ACPI_TABLE_ADDR	(~0UL)
