Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282275AbRLDChN>; Mon, 3 Dec 2001 21:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279997AbRLCXx6>; Mon, 3 Dec 2001 18:53:58 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:44995 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285142AbRLCVBA>; Mon, 3 Dec 2001 16:01:00 -0500
Date: Mon, 3 Dec 2001 16:00:59 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@linuxia64.org, marcelo@conectiva.com.br, davem@redhat.com
Subject: patch to no longer use ia64's software mmu
Message-ID: <20011203160059.A2022@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below (against 2.4.16) makes the ia64 port no longer use the (VERY
slow) software IO mmu but makes it use the same mechanism the x86 PAE port
uses: it lets the higher layers take care of the proper bouncing of
PCI-unreachable memory. The implemenation is pretty simple; instead of
having a 4Gb GFP_DMA zone and a <rest of ram> GFP_KERNEL zone, the ia64 port
now has a 4Gb GFP_DMA zone and a <rest of ram> GFP_HIGH zone.
Since the ia64 cpu can address all of this memory directly, the kmap() and
related functions are basically nops. 

The result: 100 mbit ethernet performance on a ia64 machine with 32Gb of ram
increased more than 4x (from 20 mbit to 95 mbit)....

The only downside is that the current kernel will always bounce buffer disk
IO even if the scsi card is 64 bit PCI capable; Jens Axboe's block highmem
patch fixes that downside nicely though.

Greetings,
    Arjan van de Ven

diff -urN Linux/arch/ia64/config.in linux/arch/ia64/config.in
--- Linux/arch/ia64/config.in	Fri Nov  9 22:26:17 2001
+++ linux/arch/ia64/config.in	Mon Dec  3 20:34:17 2001
@@ -25,6 +25,7 @@
 define_bool CONFIG_SBUS n
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
+define_bool CONFIG_HIGHMEM y
 
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
   define_bool CONFIG_ACPI y
diff -urN Linux/arch/ia64/kernel/Makefile linux/arch/ia64/kernel/Makefile
--- Linux/arch/ia64/kernel/Makefile	Fri Nov  9 22:26:17 2001
+++ linux/arch/ia64/kernel/Makefile	Mon Dec  3 20:45:28 2001
@@ -11,11 +11,11 @@
 
 O_TARGET := kernel.o
 
-export-objs := ia64_ksyms.o
+export-objs := ia64_ksyms.o pci-dma.o
 
 obj-y := acpi.o entry.o gate.o efi.o efi_stub.o ia64_ksyms.o irq.o irq_ia64.o irq_lsapic.o ivt.o \
 	 machvec.o pal.o process.o perfmon.o ptrace.o sal.o semaphore.o setup.o	\
-	 signal.o sys_ia64.o traps.o time.o unaligned.o unwind.o
+	 signal.o sys_ia64.o traps.o time.o unaligned.o unwind.o pci-dma.o
 obj-$(CONFIG_IA64_GENERIC) += iosapic.o
 obj-$(CONFIG_IA64_DIG) += iosapic.o
 obj-$(CONFIG_IA64_PALINFO) += palinfo.o
diff -urN Linux/arch/ia64/kernel/ia64_ksyms.c linux/arch/ia64/kernel/ia64_ksyms.c
--- Linux/arch/ia64/kernel/ia64_ksyms.c	Fri Nov  9 22:26:17 2001
+++ linux/arch/ia64/kernel/ia64_ksyms.c	Mon Dec  3 20:45:46 2001
@@ -6,6 +6,8 @@
 #include <linux/module.h>
 
 #include <linux/string.h>
+#include <linux/pci.h>
+
 EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL(memchr);
 EXPORT_SYMBOL(memcmp);
@@ -147,3 +149,5 @@
 #include <linux/proc_fs.h>
 extern struct proc_dir_entry *efi_dir;
 EXPORT_SYMBOL(efi_dir);
+EXPORT_SYMBOL(pci_alloc_consistent);
+EXPORT_SYMBOL(pci_free_consistent);
diff -urN Linux/arch/ia64/kernel/pci-dma.c linux/arch/ia64/kernel/pci-dma.c
--- Linux/arch/ia64/kernel/pci-dma.c	Thu Jan  1 01:00:00 1970
+++ linux/arch/ia64/kernel/pci-dma.c	Mon Dec  3 20:34:17 2001
@@ -0,0 +1,38 @@
+/*
+ * Dynamic DMA mapping support.
+ *
+ * On IA64 there is no hardware dynamic DMA address translation,
+ * so consistent alloc/free are merely page allocation/freeing.
+ * The rest of the dynamic DMA mapping interface is implemented
+ * in asm/pci.h.
+ */
+
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <asm/io.h>
+
+void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
+			   dma_addr_t *dma_handle)
+{
+	void *ret;
+	int gfp = GFP_ATOMIC;
+
+	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
+		gfp |= GFP_DMA;
+	ret = (void *)__get_free_pages(gfp, get_order(size));
+
+	if (ret != NULL) {
+		memset(ret, 0, size);
+		*dma_handle = virt_to_bus(ret);
+	}
+	return ret;
+}
+
+void pci_free_consistent(struct pci_dev *hwdev, size_t size,
+			 void *vaddr, dma_addr_t dma_handle)
+{
+	free_pages((unsigned long)vaddr, get_order(size));
+}
diff -urN Linux/arch/ia64/lib/Makefile linux/arch/ia64/lib/Makefile
--- Linux/arch/ia64/lib/Makefile	Tue Jul 31 18:30:08 2001
+++ linux/arch/ia64/lib/Makefile	Mon Dec  3 20:34:17 2001
@@ -7,14 +7,14 @@
 
 L_TARGET = lib.a
 
-export-objs := io.o swiotlb.o
+export-objs := io.o 
 
 obj-y := __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o					\
 	__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o					\
 	checksum.o clear_page.o csum_partial_copy.o copy_page.o				\
 	copy_user.o clear_user.o strncpy_from_user.o strlen_user.o strnlen_user.o	\
 	flush.o io.o do_csum.o								\
-	memcpy.o memset.o strlen.o swiotlb.o
+	memcpy.o memset.o strlen.o
 
 IGNORE_FLAGS_OBJS =	__divsi3.o __udivsi3.o __modsi3.o __umodsi3.o \
 			__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o
diff -urN Linux/arch/ia64/mm/init.c linux/arch/ia64/mm/init.c
--- Linux/arch/ia64/mm/init.c	Fri Nov  9 22:26:17 2001
+++ linux/arch/ia64/mm/init.c	Mon Dec  3 20:34:17 2001
@@ -13,6 +13,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
+#include <linux/highmem.h>
 
 #include <asm/bitops.h>
 #include <asm/dma.h>
@@ -36,6 +37,7 @@
 unsigned long MAX_DMA_ADDRESS = PAGE_OFFSET + 0x100000000UL;
 
 static unsigned long totalram_pages;
+static unsigned long totalhigh_pages;
 
 int
 do_check_pgt_cache (int low, int high)
@@ -160,8 +162,8 @@
 	val->sharedram = 0;
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
-	val->totalhigh = 0;
-	val->freehigh = 0;
+	val->totalhigh = totalhigh_pages;
+	val->freehigh = nr_free_highpages();
 	val->mem_unit = PAGE_SIZE;
 	return;
 }
@@ -349,12 +352,13 @@
 
 	memset(zones_size, 0, sizeof(zones_size));
 
-	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+	max_dma = virt_to_phys((void *) (MAX_DMA_ADDRESS)) >> PAGE_SHIFT;
+	
 	if (max_low_pfn < max_dma)
 		zones_size[ZONE_DMA] = max_low_pfn;
 	else {
 		zones_size[ZONE_DMA] = max_dma;
-		zones_size[ZONE_NORMAL] = max_low_pfn - max_dma;
+		zones_size[ZONE_HIGHMEM] = max_low_pfn - max_dma;
 	}
 	free_area_init(zones_size);
 }
@@ -382,6 +386,23 @@
 	return 0;
 }
 
+static int
+count_highmem_pages (u64 start, u64 end, void *arg)
+{
+	unsigned long num_high = 0;
+	unsigned long *count = arg;
+	struct page *pg;
+
+	for (pg = virt_to_page(start); pg < virt_to_page(end); ++pg)
+		if (page_to_phys(pg)>(0xffffffff)) {
+			++num_high;
+			set_bit(PG_highmem, &pg->flags);
+ 			pg->virtual = __va(page_to_phys(pg));
+		}
+	*count += num_high;
+	return 0;
+}
+
 void
 mem_init (void)
 {
@@ -395,7 +415,7 @@
 	 * any drivers that may need the PCI DMA interface are initialized or bootmem has
 	 * been freed.
 	 */
-	platform_pci_dma_init();
+	/*platform_pci_dma_init();*/
 #endif
 
 	if (!mem_map)
@@ -405,6 +425,8 @@
 	efi_memmap_walk(count_pages, &num_physpages);
 
 	max_mapnr = max_low_pfn;
+	highmem_start_page = mem_map + (0x100000000 >> PAGE_SHIFT);
+
 	high_memory = __va(max_low_pfn * PAGE_SIZE);
 
 	totalram_pages += free_all_bootmem();
@@ -412,6 +434,9 @@
 	reserved_pages = 0;
 	efi_memmap_walk(count_reserved_pages, &reserved_pages);
 
+	totalhigh_pages = 0;
+	efi_memmap_walk(count_highmem_pages, &totalhigh_pages);
+
 	codesize =  (unsigned long) &_etext - (unsigned long) &_stext;
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
diff -urN Linux/include/asm-ia64/highmem.h linux/include/asm-ia64/highmem.h
--- Linux/include/asm-ia64/highmem.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-ia64/highmem.h	Mon Dec  3 20:34:17 2001
@@ -0,0 +1,61 @@
+/*
+ * highmem.h: virtual kernel memory mappings for high memory
+ *
+ * Used in CONFIG_HIGHMEM systems for memory pages which
+ * are not addressable by direct kernel virtual addresses.
+ *
+ * Copyright (C) 1999 Gerhard Wichert, Siemens AG
+ *		      Gerhard.Wichert@pdb.siemens.de
+ *
+ *
+ * Redesigned the x86 32-bit VM architecture to deal with 
+ * up to 16 Terabyte physical memory. With current x86 CPUs
+ * we now support up to 64 Gigabytes physical RAM.
+ * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
+ * Modified for use on IA64 by Arjan van de Ven <arjanv@redhat.com>
+ */
+
+#ifndef _ASM_HIGHMEM_H
+#define _ASM_HIGHMEM_H
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/kmap_types.h>
+#include <asm/pgtable.h>
+
+/* undef for production */
+#define HIGHMEM_DEBUG 0
+
+/* declarations for highmem.c */
+extern unsigned long highstart_pfn, highend_pfn;
+
+extern pte_t *kmap_pte;
+extern pgprot_t kmap_prot;
+extern pte_t *pkmap_page_table;
+
+#define kmap_init(void) do {} while (0)
+
+/*
+ * Right now we initialize only a single pte table. It can be extended
+ * easily, subsequent pte tables have to be allocated in one physical
+ * chunk of RAM.
+ */
+#define kmap(page) page_address(page)
+#define kunmap(page) do {} while (0)
+
+/*
+ * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
+ * gives a more generic (and caching) interface. But kmap_atomic can
+ * be used in IRQ contexts, so in some (very limited) cases we need
+ * it.
+ */
+#define kmap_atomic(page, type) page_address(page)
+#define kunmap_atomic(kvaddr, type) do {} while (0)
+
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_HIGHMEM_H */
diff -urN Linux/include/asm-ia64/kmap_types.h linux/include/asm-ia64/kmap_types.h
--- Linux/include/asm-ia64/kmap_types.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-ia64/kmap_types.h	Mon Dec  3 20:34:17 2001
@@ -0,0 +1,15 @@
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_BOUNCE_WRITE,
+	KM_SKB_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BH_IRQ,
+	KM_TYPE_NR
+};
+
+#endif
diff -urN Linux/include/asm-ia64/machvec.h linux/include/asm-ia64/machvec.h
--- Linux/include/asm-ia64/machvec.h	Fri Nov  9 22:26:17 2001
+++ linux/include/asm-ia64/machvec.h	Mon Dec  3 20:34:17 2001
@@ -225,36 +225,6 @@
 #ifndef platform_global_tlb_purge
 # define platform_global_tlb_purge	ia64_global_tlb_purge /* default to architected version */
 #endif
-#ifndef platform_pci_dma_init
-# define platform_pci_dma_init		swiotlb_init
-#endif
-#ifndef platform_pci_alloc_consistent
-# define platform_pci_alloc_consistent	swiotlb_alloc_consistent
-#endif
-#ifndef platform_pci_free_consistent
-# define platform_pci_free_consistent	swiotlb_free_consistent
-#endif
-#ifndef platform_pci_map_single
-# define platform_pci_map_single	swiotlb_map_single
-#endif
-#ifndef platform_pci_unmap_single
-# define platform_pci_unmap_single	swiotlb_unmap_single
-#endif
-#ifndef platform_pci_map_sg
-# define platform_pci_map_sg		swiotlb_map_sg
-#endif
-#ifndef platform_pci_unmap_sg
-# define platform_pci_unmap_sg		swiotlb_unmap_sg
-#endif
-#ifndef platform_pci_dma_sync_single
-# define platform_pci_dma_sync_single	swiotlb_sync_single
-#endif
-#ifndef platform_pci_dma_sync_sg
-# define platform_pci_dma_sync_sg	swiotlb_sync_sg
-#endif
-#ifndef platform_pci_dma_address
-# define  platform_pci_dma_address	swiotlb_dma_address
-#endif
 #ifndef platform_irq_desc
 # define platform_irq_desc		__ia64_irq_desc
 #endif
diff -urN Linux/include/asm-ia64/pci.h linux/include/asm-ia64/pci.h
--- Linux/include/asm-ia64/pci.h	Fri Nov  9 22:26:17 2001
+++ linux/include/asm-ia64/pci.h	Mon Dec  3 20:34:17 2001
@@ -36,15 +36,147 @@
 /*
  * Dynamic DMA mapping API.  See Documentation/DMA-mapping.txt for details.
  */
-#define pci_alloc_consistent		platform_pci_alloc_consistent
-#define pci_free_consistent		platform_pci_free_consistent
-#define pci_map_single			platform_pci_map_single
-#define pci_unmap_single		platform_pci_unmap_single
-#define pci_map_sg			platform_pci_map_sg
-#define pci_unmap_sg			platform_pci_unmap_sg
-#define pci_dma_sync_single		platform_pci_dma_sync_single
-#define pci_dma_sync_sg			platform_pci_dma_sync_sg
-#define sg_dma_address			platform_pci_dma_address
+
+#define flush_write_buffers() do {} while (0)
+
+
+/* Map a single buffer of the indicated size for DMA in streaming mode.
+ * The 32-bit bus address to use is returned.
+ *
+ * Once the device is given the dma address, the device owns this memory
+ * until either pci_unmap_single or pci_dma_sync_single is performed.
+ */
+static inline dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr,
+					size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	flush_write_buffers();
+	return virt_to_bus(ptr);
+}
+
+/* Unmap a single streaming mode DMA translation.  The dma_addr and size
+ * must match what was provided for in a previous pci_map_single call.  All
+ * other usages are undefined.
+ *
+ * After this call, reads by the cpu to the buffer are guarenteed to see
+ * whatever the device wrote there.
+ */
+static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
+				    size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	/* Nothing to do */
+}
+
+/*
+ * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
+ * to pci_map_single, but takes a struct page instead of a virtual address
+ */
+static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page *page,
+				      unsigned long offset, size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+
+	return (page - mem_map) * PAGE_SIZE + offset;
+}
+
+static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
+				  size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	/* Nothing to do */
+}
+
+/* Map a set of buffers described by scatterlist in streaming
+ * mode for DMA.  This is the scather-gather version of the
+ * above pci_map_single interface.  Here the scatter gather list
+ * elements are each tagged with the appropriate dma address
+ * and length.  They are obtained via sg_dma_{address,length}(SG).
+ *
+ * NOTE: An implementation may be able to use a smaller number of
+ *       DMA address/length pairs than there are SG table elements.
+ *       (for example via virtual mapping capabilities)
+ *       The routine returns the number of addr/length pairs actually
+ *       used, at most nents.
+ *
+ * Device ownership issues as mentioned above for pci_map_single are
+ * the same here.
+ */
+static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+			     int nents, int direction)
+{
+	int i;
+
+	if (direction == PCI_DMA_NONE)
+		BUG();
+ 
+ 	/*
+ 	 * temporary 2.4 hack
+ 	 */
+ 	for (i = 0; i < nents; i++ ) {
+ 		if (sg[i].address && sg[i].page)
+ 			BUG();
+ 		else if (!sg[i].address && !sg[i].page)
+ 			BUG();
+ 
+ 		if (sg[i].address)
+ 			sg[i].dma_address = virt_to_bus(sg[i].address);
+ 		else
+ 			sg[i].dma_address = page_to_bus(sg[i].page) + sg[i].offset;
+ 	}
+ 
+	flush_write_buffers();
+	return nents;
+}
+
+/* Unmap a set of streaming mode DMA translations.
+ * Again, cpu read rules concerning calls here are the same as for
+ * pci_unmap_single() above.
+ */
+static inline void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+				int nents, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	/* Nothing to do */
+}
+
+/* Make physical memory consistent for a single
+ * streaming mode DMA translation after a transfer.
+ *
+ * If you perform a pci_map_single() but wish to interrogate the
+ * buffer using the cpu, yet do not wish to teardown the PCI dma
+ * mapping, you must call this function before doing so.  At the
+ * next point you give the PCI dma address back to the card, the
+ * device again owns the buffer.
+ */
+static inline void pci_dma_sync_single(struct pci_dev *hwdev,
+				       dma_addr_t dma_handle,
+				       size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	flush_write_buffers();
+}
+
+/* Make physical memory consistent for a set of streaming
+ * mode DMA translations after a transfer.
+ *
+ * The same as pci_dma_sync_single but for a scatter-gather list,
+ * same rules and usage.
+ */
+static inline void pci_dma_sync_sg(struct pci_dev *hwdev,
+				   struct scatterlist *sg,
+				   int nelems, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	flush_write_buffers();
+}
 
 /*
  * Return whether the given PCI device DMA address mask can be supported properly.  For
@@ -79,4 +211,27 @@
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
 
+#define PCI_DMA_BUS_IS_PHYS (1)
+#define pci_dac_dma_supported(pci_dev, mask)      (0)
+
+/* Allocate and map kernel buffer using consistent mode DMA for a device.
+ * hwdev should be valid struct pci_dev pointer for PCI devices,
+ * NULL for PCI-like buses (ISA, EISA).
+ * Returns non-NULL cpu-view pointer to the buffer if successful and
+ * sets *dma_addrp to the pci side dma address as well, else *dma_addrp
+ * is undefined.
+ */
+extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
+                                  dma_addr_t *dma_handle);
+
+/* Free and unmap a consistent DMA buffer.
+ * cpu_addr is what was returned from pci_alloc_consistent,
+ * size must be the same as what as passed into pci_alloc_consistent,
+ * and likewise dma_addr must be the same as what *dma_addrp was set to.
+ *
+ * References to the memory and mappings associated with cpu_addr/dma_addr
+ * past this call are illegal.
+ */
+extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
+                                void *vaddr, dma_addr_t dma_handle);
 #endif /* _ASM_IA64_PCI_H */
diff -urN Linux/include/asm-ia64/scatterlist.h linux/include/asm-ia64/scatterlist.h
--- Linux/include/asm-ia64/scatterlist.h	Tue Nov 13 17:01:16 2001
+++ linux/include/asm-ia64/scatterlist.h	Mon Dec  3 20:44:15 2001
@@ -14,10 +14,12 @@
 	/* These two are only valid if ADDRESS member of this struct is NULL.  */
 	struct page *page;
 	unsigned int offset;
+	dma_addr_t dma_address;
 
 	unsigned int length;	/* buffer length */
 };
 
 #define ISA_DMA_THRESHOLD	(~0UL)
+#define sg_dma_address(sg)	((sg)->dma_address)
 
 #endif /* _ASM_IA64_SCATTERLIST_H */
diff -urN Linux/include/asm-ia64/types.h linux/include/asm-ia64/types.h
--- Linux/include/asm-ia64/types.h	Fri Apr 21 23:21:24 2000
+++ linux/include/asm-ia64/types.h	Mon Dec  3 20:34:17 2001
@@ -63,6 +63,7 @@
 /* DMA addresses are 64-bits wide, in general.  */
 
 typedef u64 dma_addr_t;
+typedef u64 dma64_addr_t;
 
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
diff -urN Linux/kernel/ksyms.c linux/kernel/ksyms.c
--- Linux/kernel/ksyms.c	Wed Nov 21 22:07:25 2001
+++ linux/kernel/ksyms.c	Mon Dec  3 20:41:11 2001
@@ -117,8 +117,11 @@
 EXPORT_SYMBOL(get_unmapped_area);
 EXPORT_SYMBOL(init_mm);
 #ifdef CONFIG_HIGHMEM
+#ifndef __ia64__
+/* these are inlined on ia64 */
 EXPORT_SYMBOL(kmap_high);
 EXPORT_SYMBOL(kunmap_high);
+#endif
 EXPORT_SYMBOL(highmem_start_page);
 EXPORT_SYMBOL(create_bounce);
 #endif
diff -urN Linux/mm/highmem.c linux/mm/highmem.c
--- Linux/mm/highmem.c	Mon Oct 22 23:01:57 2001
+++ linux/mm/highmem.c	Mon Dec  3 20:42:44 2001
@@ -22,6 +22,8 @@
 #include <linux/swap.h>
 #include <linux/slab.h>
 
+
+#ifndef __ia64__
 /*
  * Virtual_count is not a pure "count".
  *  0 means that it is not mapped, and has not been mapped
@@ -186,6 +188,8 @@
 		wake_up(&pkmap_map_wait);
 }
 
+#endif
+
 #define POOL_SIZE 32
 
 /*
