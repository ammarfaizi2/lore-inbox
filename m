Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbRIDWIC>; Tue, 4 Sep 2001 18:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269651AbRIDWHx>; Tue, 4 Sep 2001 18:07:53 -0400
Received: from ash.lnxi.com ([207.88.130.242]:50682 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S269421AbRIDWHj>;
	Tue, 4 Sep 2001 18:07:39 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Don't overwrite ramdisks
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 04 Sep 2001 16:07:56 -0600
Message-ID: <m3y9nua9tv.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Problem:  With linux-2.4.x if you put in enough ram it is possible
to nearly fill with low 1GB ram with the struct page array, making
a safe place to put a ramdisk nearly impossible to predict.  The base of
the array has already changed between 2.2 and 2.4.

With this patch the initial bootmem_bitmap is moved into the kernel's
initdata so we can verify that it is indeed in the initial page table.

Additionally the code to reserve the ramdisk location is moved before
the struct page array is allocated.  Making overwriting a ramdisk
no longer a fear.

Eric


diff -uNr linux-2.4.10-pre4/arch/i386/kernel/setup.c linux-2.4.10-pre4.eb1/arch/i386/kernel/setup.c
--- linux-2.4.10-pre4/arch/i386/kernel/setup.c	Tue Sep  4 15:28:30 2001
+++ linux-2.4.10-pre4.eb1/arch/i386/kernel/setup.c	Tue Sep  4 15:29:23 2001
@@ -769,9 +769,32 @@
 	}
 }
 
+
+
+#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+
+/*
+ * 128MB for vmalloc and initrd
+ */
+#define VMALLOC_RESERVE	(unsigned long)(128 << 20)
+#define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
+#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+#define MAX_NONPAE_PFN	(1 << 20)
+
+/* On x86 for 1GB low mem the bootmem_bitmap is at worst 32k
+ * that is big but nothing to worry about.  This must be in the kernels
+ * initial page tables so don't even try to get fancy where we allocate it.
+ * This data must be aligned on a page boundary so since I don't
+ * have a handlig __aligned_page_size attribute I allocate an extra
+ * PAGE_SIZE -1 bytes.
+ */
+static unsigned char bootmem_bitmap[((MAXMEM_PFN +7)/8) + PAGE_SIZE -1] __initdata = { 0 };
+
 void __init setup_arch(char **cmdline_p)
 {
-	unsigned long bootmap_size, low_mem_size;
+	unsigned long bootmap_pfn, low_mem_size;
 	unsigned long start_pfn, max_pfn, max_low_pfn;
 	int i;
 
@@ -805,30 +828,18 @@
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
-	code_resource.start = virt_to_bus(&_text);
-	code_resource.end = virt_to_bus(&_etext)-1;
-	data_resource.start = virt_to_bus(&_etext);
-	data_resource.end = virt_to_bus(&_edata)-1;
+	code_resource.start = virt_to_phys(&_text);
+	code_resource.end = virt_to_phys(&_etext)-1;
+	data_resource.start = virt_to_phys(&_etext);
+	data_resource.end = virt_to_phys(&_edata)-1;
 
 	parse_mem_cmdline(cmdline_p);
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
-/*
- * 128MB for vmalloc and initrd
- */
-#define VMALLOC_RESERVE	(unsigned long)(128 << 20)
-#define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
-#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
-#define MAX_NONPAE_PFN	(1 << 20)
-
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
 	 */
-	start_pfn = PFN_UP(__pa(&_end));
+	start_pfn = PFN_UP(virt_to_phys(&_end));
 
 	/*
 	 * Find the highest page frame number we have available
@@ -883,7 +894,8 @@
 	/*
 	 * Initialize the boot-time allocator (with low memory only):
 	 */
-	bootmap_size = init_bootmem(start_pfn, max_low_pfn);
+	bootmap_pfn = PFN_UP(virt_to_phys(&bootmem_bitmap));
+	init_bootmem(bootmap_pfn, max_low_pfn);
 
 	/*
 	 * Register fully available low RAM pages with the bootmem allocator.
@@ -919,14 +931,32 @@
 		size = last_pfn - curr_pfn;
 		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
 	}
-	/*
-	 * Reserve the bootmem bitmap itself as well. We do this in two
-	 * steps (first step was init_bootmem()) because this catches
-	 * the (very unlikely) case of us accidentally initializing the
-	 * bootmem allocator with an invalid RAM area.
+	/* 
+	 * Reserve the kernel memory.
 	 */
-	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(start_pfn) +
-			 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
+	reserve_bootmem(HIGH_MEMORY, PFN_PHYS(start_pfn) + 
+		PAGE_SIZE-1 - (HIGH_MEMORY));
+
+	/* 
+	 * Reserve the initrd 
+	 */
+#ifdef CONFIG_BLK_DEV_INITRD
+	initrd_start = 0;
+	initrd_end = 0;
+	if (LOADER_TYPE && INITRD_START && INITRD_SIZE) {
+		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
+			reserve_bootmem(INITRD_START, INITRD_SIZE);
+			initrd_start = INITRD_START + PAGE_OFFSET;
+			initrd_end = initrd_start + INITRD_SIZE;
+		}
+		else {
+			printk(KERN_ERR "initrd extends beyond end of memory "
+			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+			    INITRD_START + INITRD_SIZE,
+			    max_low_pfn << PAGE_SHIFT);
+		}
+	}
+#endif
 
 	/*
 	 * reserve physical page 0 - it's a special BIOS page on many boxes,
@@ -962,23 +992,6 @@
 	init_apic_mappings();
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (LOADER_TYPE && INITRD_START) {
-		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
-			reserve_bootmem(INITRD_START, INITRD_SIZE);
-			initrd_start =
-				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
-			initrd_end = initrd_start+INITRD_SIZE;
-		}
-		else {
-			printk(KERN_ERR "initrd extends beyond end of memory "
-			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
-			    INITRD_START + INITRD_SIZE,
-			    max_low_pfn << PAGE_SHIFT);
-			initrd_start = 0;
-		}
-	}
-#endif
 
 	/*
 	 * Request address space for all standard RAM and ROM resources
