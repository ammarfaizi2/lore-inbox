Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbTBFPnp>; Thu, 6 Feb 2003 10:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbTBFPnp>; Thu, 6 Feb 2003 10:43:45 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:57343 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267338AbTBFPmr>; Thu, 6 Feb 2003 10:42:47 -0500
Date: Thu, 6 Feb 2003 21:26:15 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkcd-devel@lists.sourceforge.net
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH][WIP] Using kexec for crash dumps in LKCD
Message-ID: <20030206212615.A2733@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <m1smwql3av.fsf@frodo.biederman.org> <20021231200519.A2110@in.ibm.com> <m11y2w557p.fsf@frodo.biederman.org> <20030204142426.A1950@in.ibm.com> <m1d6m81ttu.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1d6m81ttu.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Feb 03, 2003 at 10:46:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is an extension to LKCD to make use of Eric
Biederman's kexec implementation to delay the actual
writeout of a crashdump to disk to happen after a 
memory preserving reboot of a new kernel.

The real thanks for this goes to Dave Winchell and the 
rest of the Mission Critical Linux folks for first
implementing such an approach in mcore using Werner
Alamesberger's bootimg, and letting us learn and borrow 
ideas from it.

There is a subtle but crucial difference in the design 
of the scheme we use to get spare pages to save the dump 
which potentially enables us to save a complete memory 
snapshot (not just kernel pages) if we can get a good 
compression efficiency (i.e. theoretically limited 
only by the degree of compressability of the memory 
state and working memory space that must be left for the 
dump and kernel bootup code).

This code is still somewhat raw and there's a list of 
todo's and improvements in my mind, and loopholes to fix, 
but I decided it was high time to put this out for a start, 
so anyone who is interested could start taking a look and 
playing with it, and maybe help out if they like.

I plan to fold it into lkcd cvs tomorrow if possible unless 
anyone notices a major regression of existing lkcd 
functionality (i.e.  without CONFIG_CRASHDUMP_MEMDEV and 
CRASH_DUMP_SOFT_BOOT). I have  tried out Alt+Sysrq+d and a 
simple panic from a module as a sanity check.

(I haven't tried it out for a true panic yet - going there
bit by bit :))

In any case, I'll tag the cvs tree before checking in.

Merging and testing has been rather time consuming, so 
would appreciate if anyone planning to check in any changes 
before I do would let me know ahead of time.

I'm considering also checkin in a TODO file at the
top of the 2.5 directory in CVS to keep track of what
needs to be done. Would that be a good idea ?
I'll probably also post the TODOs on the mailing list.

OK, going ahead:

Steps to use:
--------------

A. Patching the kernel:
1) Patch vanilla 2.5.59 kernel with the kexec patches for
   2.5.59.
   I picked the ones from the OSDL site which Andy Pfiffer had
   mentioned in an earlier post
 	kexec for 2.5.59 (based upon the version for 2.5.54)
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1442

	hwfixes that makes it work for me (same as for 2.5.58):
	http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1444

2) Apply the latest dump patches from lkcd cvs
	i.e. apply the kernel patches under 2.5/patches
    (expect to see one reject in the 2nd hunk for reboot.c
     when applying notify_die.patch - you could ignore it for
     now) 
	and  copy the dump driver files at the appropriate
	places

3) Apply the attached patch (kexecdump.patch)

B. Kernel Build Configuration settings 
   You'll need CRASH_DUMP to be built into the kernel (not
   as a module) to be able to dump across a kexec boot
   CRASH_DUMP_BLOCKDEV, CRASH_DUMP_COMPRESS_GZIP are needed
   as we use them today
   New options you'll need CRASH_DUMP_MEMDEV (memory dump 
   driver) and CRASH_DUMP_SOFTBOOT (kexec based dumping) 

C. Run-time setup
   A new dump flag for memory-save-and-dump-after-boot 
   DUMP_FLAGS_SOFTBOOT has been introduced (0x2), which
   would need to be turned on in the dump flags.

   After running lkcd config as usual, there is one
   extra step needed to load the kernel to be kexec'ed
   This involves executing "kexec -l" with the regular
   command line options (derived from you /proc/cmdline)
   and one extra boot parameter, obtained as follows:
   crashdump=`cat /proc/sys/kernel/dump/addr`
   (This tells the new kernel where to find a saved
   in-memory crash dump from previous boot)

   e.g.
   kexec -l --command-line="root=806 console=tty0 console=
   ttyS0,38400 crashdump=`cat /proc/sys/kernel/dump/addr`"	
   <kernel bzImage>

D. On panic, the dump is saved in memory and then kexec is
   used to boot up a new kernel (instead of a regular reboot)
   If Alt+Sysrq+d is pressed then the dump is just saved
   in memory without rebooting

   [Note: The first few times you try it, it might be a 
   good idea to drop into "init 1" and unmount most filesystems 
   or remount them as read-only , before you force the panic
   - thanks to Andy Pfiffer for the tip ]

E. After running "lkcd config" triggers a writeout
   to the dump disk of the previously saved dump in memory.

F. From here on, one can run "lkcd save" as usual to generate
   the /var/log/dump/* files for analysis.


Regards
Suparna



-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kexecdump.patch"

diff -urN -X ../dontdiff linux-2.5.59/arch/i386/Kconfig linux-2.5.59-kexecdump/arch/i386/Kconfig
--- linux-2.5.59/arch/i386/Kconfig	Thu Feb  6 16:42:29 2003
+++ linux-2.5.59-kexecdump/arch/i386/Kconfig	Thu Feb  6 10:30:48 2003
@@ -1577,6 +1577,23 @@
 	help
 	  Say Y to allow saving crash dumps over a network device.
 
+config CRASH_DUMP_MEMDEV
+	bool "Crash dump staged memory driver"
+	depends on CRASH_DUMP
+	help
+	  Say Y to allow intermediate saving crash dumps in spare 
+	  memory pages which would then be written out to disk
+	  later.
+
+config CRASH_DUMP_SOFTBOOT
+	bool "Save crash dump across a soft reboot"
+	depends on CRASH_DUMP_MEMDEV
+	help
+	  Say Y to allow a crash dump to be preserved in memory
+	  pages across a soft reboot and written out to disk
+	  thereafter. For this to work, CRASH_DUMP must be 
+	  configured as part of the kernel (not as a module).
+
 config CRASH_DUMP_COMPRESS_RLE
 	tristate "Crash dump RLE compression"
 	depends on CRASH_DUMP
diff -urN -X ../dontdiff linux-2.5.59/arch/i386/kernel/setup.c linux-2.5.59-kexecdump/arch/i386/kernel/setup.c
--- linux-2.5.59/arch/i386/kernel/setup.c	Fri Jan 17 07:52:08 2003
+++ linux-2.5.59-kexecdump/arch/i386/kernel/setup.c	Thu Feb  6 13:04:11 2003
@@ -503,6 +503,7 @@
 	print_memory_map(who);
 } /* setup_memory_region */
 
+unsigned long crashdump_addr = 0xdeadbeef;
 
 static void __init parse_cmdline_early (char ** cmdline_p)
 {
@@ -565,6 +566,9 @@
 		if (c == ' ' && !memcmp(from, "highmem=", 8))
 			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
 	
+		if (c == ' ' && !memcmp(from, "crashdump=", 10))
+			crashdump_addr = memparse(from+10, &from); 
+			
 		c = *(from++);
 		if (!c)
 			break;
@@ -839,6 +843,8 @@
 		pci_mem_start = low_mem_size;
 }
 
+extern void crashdump_reserve(void);
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long max_low_pfn;
@@ -895,6 +901,10 @@
 	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
 	paging_init();
+
+#ifdef CONFIG_CRASH_DUMP_SOFTBOOT
+	crashdump_reserve(); /* Preserve crash dump state from prev boot */
+#endif
 #ifdef CONFIG_ACPI_BOOT
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
diff -urN -X ../dontdiff linux-2.5.59/drivers/dump/Makefile linux-2.5.59-kexecdump/drivers/dump/Makefile
--- linux-2.5.59/drivers/dump/Makefile	Wed Dec 18 13:47:50 2002
+++ linux-2.5.59-kexecdump/drivers/dump/Makefile	Thu Feb  6 07:49:15 2003
@@ -5,6 +5,7 @@
 
 dump-y					:= dump_setup.o dump_fmt.o dump_filters.o dump_scheme.o dump_execute.o
 dump-$(CONFIG_X86)			+= dump_i386.o
+dump-$(CONFIG_CRASH_DUMP_MEMDEV)	+= dump_memdev.o dump_overlay.o
 dump-objs				+= $(dump-y)
 
 obj-$(CONFIG_CRASH_DUMP)		+= dump.o
diff -urN -X ../dontdiff linux-2.5.59/drivers/dump/dump_blockdev.c linux-2.5.59-kexecdump/drivers/dump/dump_blockdev.c
--- linux-2.5.59/drivers/dump/dump_blockdev.c	Mon Feb  3 23:56:59 2003
+++ linux-2.5.59-kexecdump/drivers/dump/dump_blockdev.c	Thu Feb  6 07:49:15 2003
@@ -61,14 +61,19 @@
 	int len) 
 {
 	struct bio *bio = dev->bio;
+	unsigned long bsize = 0;
 
 	if (!bio->bi_vcnt)
 		return 0; /* first time, not mapped */
 
 
-	if ((bio_page(bio) != page) || (len != bio->bi_vcnt << PAGE_SHIFT)) 
+	if ((bio_page(bio) != page) || (len > bio->bi_vcnt << PAGE_SHIFT))
 		return 0; /* buffer not mapped */
 
+	bsize = bdev_hardsect_size(bio->bi_bdev);
+	if ((len & (PAGE_SIZE - 1)) || (len & bsize))
+		return 0; /* alignment checks needed */
+
 	/* quick check to decide if we need to redo bio_add_page */
 	if (bdev_get_queue(bio->bi_bdev)->merge_bvec_fn)
 		return 0; /* device may have other restrictions */
diff -urN -X ../dontdiff linux-2.5.59/drivers/dump/dump_execute.c linux-2.5.59-kexecdump/drivers/dump/dump_execute.c
--- linux-2.5.59/drivers/dump/dump_execute.c	Mon Feb  3 23:58:01 2003
+++ linux-2.5.59-kexecdump/drivers/dump/dump_execute.c	Thu Feb  6 07:49:15 2003
@@ -22,8 +22,6 @@
 #include <linux/dump.h>
 #include "dump_methods.h"
 
-extern int dump_device;
-
 struct notifier_block *dump_notifier_list; /* dump started/ended callback */
 
 /* Dump progress indicator */
@@ -84,7 +82,7 @@
 /* Saves all dump data */
 int dump_execute_savedump(void)
 {
-	int ret = 0;
+	int ret = 0, err = 0;
 
 	if ((ret = dump_begin()))  {
 		return ret;
@@ -93,7 +91,9 @@
 	if (dump_config.level != DUMP_LEVEL_HEADER) { 
 		ret = dump_sequencer();
 	}
-	dump_complete();
+	if ((err = dump_complete())) {
+		printk("Dump complete failed. Error %d\n", err);
+	}
 
 	return ret;
 }
@@ -109,7 +109,8 @@
 	}
 
 	/* tell interested parties that a dump is about to start */
-	notifier_call_chain(&dump_notifier_list, DUMP_BEGIN, &dump_device);
+	notifier_call_chain(&dump_notifier_list, DUMP_BEGIN, 
+		&dump_config.dump_device);
 
 	if (dump_config.level != DUMP_LEVEL_NONE)
 		ret = dump_execute_savedump();
@@ -118,7 +119,8 @@
 		dump_config.dumper->count, DUMP_BUFFER_SIZE);
 	
 	/* tell interested parties that a dump has completed */
-	notifier_call_chain(&dump_notifier_list, DUMP_END, &dump_device);
+	notifier_call_chain(&dump_notifier_list, DUMP_END, 
+		&dump_config.dump_device);
 
 	return ret;
 }
diff -urN -X ../dontdiff linux-2.5.59/drivers/dump/dump_fmt.c linux-2.5.59-kexecdump/drivers/dump/dump_fmt.c
--- linux-2.5.59/drivers/dump/dump_fmt.c	Mon Feb  3 23:56:59 2003
+++ linux-2.5.59-kexecdump/drivers/dump/dump_fmt.c	Thu Feb  6 07:49:15 2003
@@ -88,6 +88,7 @@
 /*
  *  Set up common header fields (mainly the arch indep section) 
  *  Per-cpu state is handled by lcrash_save_context
+ *  Returns the size of the header in bytes.
  */
 static int lcrash_init_dump_header(const char *panic_str)
 {
@@ -154,7 +155,7 @@
 
 	dump_header_asm.dha_dumping_cpu = smp_processor_id();
 	
-	return 0;
+	return sizeof(dump_header) + sizeof(dump_header_asm);
 }
 
 
@@ -163,8 +164,7 @@
 {
 	int retval = 0;
 
-	if ((retval = lcrash_init_dump_header(panic_str))) 
-		return retval;
+	dump_config.dumper->header_len = lcrash_init_dump_header(panic_str);
 
 	/* capture register states for all processors */
 	dump_save_this_cpu(regs);
@@ -212,10 +212,10 @@
 	size = sizeof(dump_header);
 	memcpy(buf + size, (void *)&dump_header_asm, sizeof(dump_header_asm));
 	size += sizeof(dump_header_asm);
-	/* assuming header is dump buffer size always ? */
-	retval = dump_ll_write(buf , DUMP_BUFFER_SIZE);
+	size = PAGE_ALIGN(size);
+	retval = dump_ll_write(buf , size);
 
-	if (retval < DUMP_BUFFER_SIZE) 
+	if (retval < size) 
 		return (retval >= 0) ? ENOSPC : retval;
 
 	return 0;
diff -urN -X ../dontdiff linux-2.5.59/drivers/dump/dump_memdev.c linux-2.5.59-kexecdump/drivers/dump/dump_memdev.c
--- linux-2.5.59/drivers/dump/dump_memdev.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.59-kexecdump/drivers/dump/dump_memdev.c	Thu Feb  6 13:38:30 2003
@@ -0,0 +1,640 @@
+/*
+ * Implements the dump driver interface for saving a dump in available
+ * memory areas. The saved pages may be written out to persistent storage  
+ * after a soft reboot.
+ *
+ * Started: Oct 2002 -  Suparna Bhattacharya <suparna@in.ibm.com>
+ *
+ * Copyright (C) 2002 International Business Machines Corp. 
+ *
+ * This code is released under version 2 of the GNU GPL.
+ *
+ * The approach of tracking pages containing saved dump using map pages 
+ * allocated as needed has been derived from the Mission Critical Linux 
+ * mcore dump implementation. 
+ *
+ * Credits and a big thanks for letting the lkcd project make use of 
+ * the excellent piece of work and also helping with clarifications 
+ * and tips along the way are due to:
+ * 	Dave Winchell <winchell@mclx.com> (primary author of mcore)
+ * 	Jeff Moyer <moyer@mclx.com>
+ * 	Josh Huber <huber@mclx.com>
+ *
+ * For those familiar with the mcore code, the main differences worth
+ * noting here (besides the dump device abstraction) result from enabling 
+ * "high" memory pages (pages not permanently mapped in the kernel 
+ * address space) to be used for saving dump data (because of which a 
+ * simple virtual address based linked list cannot be used anymore for 
+ * managing free pages), an added level of indirection for faster 
+ * lookups during the post-boot stage, and the idea of pages being 
+ * made available as they get freed up while dump to memory progresses 
+ * rather than one time before starting the dump. The last point enables 
+ * a full memory snapshot to be saved starting with an initial set of 
+ * bootstrap pages given a good compression ratio. (See dump_overlay.c)
+ *
+ */
+
+/*
+ * -----------------MEMORY LAYOUT ------------------
+ * The memory space consists of a set of discontiguous pages, and
+ * discontiguous map pages as well, rooted in a chain of indirect
+ * map pages (also discontiguous). Except for the indirect maps 
+ * (which must be preallocated in advance), the rest of the pages 
+ * could be in high memory.
+ *
+ * root
+ *  |    ---------    --------        --------
+ *  -->  | .  . +|--->|  .  +|------->| . .  |       indirect 
+ *       --|--|---    ---|----        --|-|---	     maps
+ *         |  |          |     	        | |	
+ *    ------  ------   -------     ------ -------
+ *    | .  |  | .  |   | .  . |    | .  | |  . . |   maps 
+ *    --|---  --|---   --|--|--    --|--- ---|-|--
+ *     page    page    page page   page   page page  data
+ *                                                   pages
+ *
+ * Writes to the dump device happen sequentially in append mode.
+ * The main reason for the existence of the indirect map is
+ * to enable a quick way to lookup a specific logical offset in
+ * the saved data post-soft-boot, e.g. to writeout pages
+ * with more critical data first, even though such pages
+ * would have been compressed and copied last, being the lowest
+ * ranked candidates for reuse due to their criticality.
+ * (See dump_overlay.c)
+ */
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/bootmem.h>
+#include <linux/dump.h>
+#include "dump_methods.h"
+
+#define DUMP_MAP_SZ (PAGE_SIZE / sizeof(unsigned long)) /* direct map size */
+#define DUMP_IND_MAP_SZ	DUMP_MAP_SZ - 1  /* indirect map size */
+#define DUMP_NR_BOOTSTRAP	64  /* no of bootstrap pages */
+
+
+/* check if the next entry crosses a page boundary */
+static inline int is_last_map_entry(unsigned long *map)
+{
+	unsigned long addr = (unsigned long)(map + 1);
+
+	return (!(addr & (PAGE_SIZE - 1)));
+}
+
+/* Todo: should have some validation checks */
+/* The last entry in the indirect map points to the next indirect map */
+/* Indirect maps are referred to directly by virtual address */
+static inline unsigned long *next_indirect_map(unsigned long *map)
+{
+	return (unsigned long *)map[DUMP_IND_MAP_SZ];
+}
+
+#ifdef CONFIG_CRASH_DUMP_SOFTBOOT
+/* Called during early bootup - fixme: make this __init */
+void dump_early_reserve_map(struct dump_memdev *dev)
+{
+	unsigned long *map1, *map2;
+	loff_t off = 0, last = dev->last_used_offset >> PAGE_SHIFT;
+	int i, j;
+	
+	printk("Reserve bootmap space holding previous dump of %lld pages\n",
+			last);
+	map1= (unsigned long *)dev->indirect_map_root;
+
+	while (map1 && (off < last)) {
+		reserve_bootmem(virt_to_phys((void *)map1), PAGE_SIZE);
+		for (i=0;  (i < DUMP_MAP_SZ - 1) && map1[i] && (off < last); 
+			i++, off += DUMP_MAP_SZ) {
+			pr_debug("indirect map[%d] = 0x%lx\n", i, map1[i]);
+			if (map1[i] >= max_low_pfn)
+				continue;
+			reserve_bootmem(map1[i] << PAGE_SHIFT, PAGE_SIZE);
+			map2 = pfn_to_kaddr(map1[i]);
+			for (j = 0 ; (j < DUMP_MAP_SZ) && map2[j] && 
+				(off + j < last); j++) {
+				pr_debug("\t map[%d][%d] = 0x%lx\n", i, j, 
+					map2[j]);
+				if (map2[j] < max_low_pfn) {
+					reserve_bootmem(map2[j] << PAGE_SHIFT,
+						PAGE_SIZE);
+				}
+			}
+		}
+		map1 = next_indirect_map(map1);
+	}
+	dev->nr_free = 0; /* these pages don't belong to this boot */
+}
+#endif
+
+/* mark dump pages so that they aren't used by this kernel */
+void dump_mark_map(struct dump_memdev *dev)
+{
+	unsigned long *map1, *map2;
+	loff_t off = 0, last = dev->last_used_offset >> PAGE_SHIFT;
+	struct page *page;
+	int i, j;
+	
+	printk("Dump: marking pages in use by previous dump\n");
+	map1= (unsigned long *)dev->indirect_map_root;
+
+	while (map1 && (off < last)) {
+		page = virt_to_page(map1);	
+		SetPageInuse(page);
+		for (i=0;  (i < DUMP_MAP_SZ - 1) && map1[i] && (off < last); 
+			i++, off += DUMP_MAP_SZ) {
+			pr_debug("indirect map[%d] = 0x%lx\n", i, map1[i]);
+			page = pfn_to_page(map1[i]);
+			SetPageInuse(page);
+			map2 = kmap_atomic(page, KM_DUMP);
+			for (j = 0 ; (j < DUMP_MAP_SZ) && map2[j] && 
+				(off + j < last); j++) {
+				pr_debug("\t map[%d][%d] = 0x%lx\n", i, j, 
+					map2[j]);
+				page = pfn_to_page(map2[j]);
+				SetPageInuse(page);
+			}
+		}
+		map1 = next_indirect_map(map1);
+	}
+}
+	
+
+/* 
+ * Given a logical offset into the mem device lookup the 
+ * corresponding page 
+ * 	loc is specified in units of pages 
+ * Note: affects curr_map (even in the case where lookup fails)
+ */
+struct page *dump_mem_lookup(struct dump_memdev *dump_mdev, unsigned long loc)
+{
+	unsigned long *map;
+	unsigned long i, index = loc / DUMP_MAP_SZ;
+	struct page *page = NULL;
+	unsigned long curr_pfn, curr_map, *curr_map_ptr = NULL;
+
+	map = (unsigned long *)dump_mdev->indirect_map_root;
+	if (!map)
+		return NULL;
+
+	if (loc > dump_mdev->last_offset >> PAGE_SHIFT)
+		return NULL;
+
+	/* 
+	 * first locate the right indirect map 
+	 * in the chain of indirect maps 
+	 */
+	for (i = 0; i + DUMP_IND_MAP_SZ < index ; i += DUMP_IND_MAP_SZ) {
+		if (!(map = next_indirect_map(map)))
+			return NULL;
+	}
+	/* then the right direct map */
+	/* map entries are referred to by page index */
+	if ((curr_map = map[index - i])) {
+		page = pfn_to_page(curr_map);
+		/* update the current traversal index */
+		/* dump_mdev->curr_map = &map[index - i];*/
+		curr_map_ptr = &map[index - i];
+	}
+
+	if (page)
+		map = kmap_atomic(page, KM_DUMP);
+	else 
+		return NULL;
+
+	/* and finally the right entry therein */
+	/* data pages are referred to by page index */
+	i = index * DUMP_MAP_SZ;
+	if ((curr_pfn = map[loc - i])) {
+		page = pfn_to_page(curr_pfn);
+		dump_mdev->curr_map = curr_map_ptr;
+		dump_mdev->curr_map_offset = loc - i;
+		dump_mdev->ddev.curr_offset = loc << PAGE_SHIFT;
+	} else {
+		page = NULL;
+	}
+	kunmap_atomic(map, KM_DUMP);
+
+	return page;
+}
+			
+/* 
+ * Retrieves a pointer to the next page in the dump device 
+ * Used during the lookup pass post-soft-reboot 
+ */
+struct page *dump_mem_next_page(struct dump_memdev *dev)
+{
+	unsigned long i; 
+	unsigned long *map;	
+	struct page *page = NULL;
+
+	if (dev->ddev.curr_offset + PAGE_SIZE >= dev->last_offset) {
+		return NULL;
+	}
+
+	if ((i = (unsigned long)(++dev->curr_map_offset)) >= DUMP_MAP_SZ) {
+		/* move to next map */	
+		if (is_last_map_entry(++dev->curr_map)) {
+			/* move to the next indirect map page */
+			printk("dump_mem_next_page: go to next indirect map\n");
+			dev->curr_map = (unsigned long *)*dev->curr_map;
+			if (!dev->curr_map)
+				return NULL;
+		}
+		i = dev->curr_map_offset = 0;
+		pr_debug("dump_mem_next_page: next map 0x%lx, entry 0x%lx\n",
+				dev->curr_map, *dev->curr_map);
+
+	};
+	
+	if (*dev->curr_map) {
+		map = kmap_atomic(pfn_to_page(*dev->curr_map), KM_DUMP);
+		if (map[i])
+			page = pfn_to_page(map[i]);
+		kunmap_atomic(map, KM_DUMP);
+		dev->ddev.curr_offset += PAGE_SIZE;
+	};
+
+	return page;
+}
+
+
+/* Set up the initial maps and bootstrap space  */
+/* Must be called only after any previous dump is written out */
+int dump_mem_open(struct dump_dev *dev, unsigned long devid)
+{
+	struct dump_memdev *dump_mdev = DUMP_MDEV(dev);
+	unsigned long nr_maps, *map, *prev_map = &dump_mdev->indirect_map_root;
+	void *addr;
+	struct page *page;
+	unsigned long i = 0;
+
+	/* Todo: sanity check for unwritten previous dump */
+
+	/* allocate pages for indirect map (non highmem area) */
+	nr_maps = num_physpages / DUMP_MAP_SZ; /* maps to cover entire mem */
+	for (i = 0; i < nr_maps; i += DUMP_IND_MAP_SZ) {
+		if (!(map = (unsigned long *)dump_alloc_mem(PAGE_SIZE))) {
+			printk("Unable to alloc indirect map %ld\n", 
+				i / DUMP_IND_MAP_SZ);
+			return -ENOMEM;
+		}
+		clear_page(map);
+		*prev_map = (unsigned long)map;
+		prev_map = &map[DUMP_IND_MAP_SZ];
+	};
+		
+	dump_mdev->curr_map = (unsigned long *)dump_mdev->indirect_map_root;
+	dump_mdev->curr_map_offset = 0;	
+
+	/* 
+	 * allocate a few bootstrap pages: at least 1 map and 1 data page
+	 * plus enough to save the dump header
+	 */
+	i = 0;
+	do {
+		if (!(addr = dump_alloc_mem(PAGE_SIZE))) {
+			printk("Unable to alloc bootstrap page %ld\n", i);
+			return -ENOMEM;
+		}
+		page = virt_to_page(addr);
+		ClearPageInuse(page); /* bypass kernel page check */
+		if (dump_check_and_free_page(dump_mdev, page))
+			i++;
+		SetPageInuse(page); 
+	} while (i < DUMP_NR_BOOTSTRAP);
+
+
+	printk("dump memdev init: %ld maps, %ld bootstrap pgs, %ld free pgs\n",
+		nr_maps, i, dump_mdev->last_offset >> PAGE_SHIFT);
+	
+	dump_mdev->last_bs_offset = dump_mdev->last_offset;
+
+	return 0;
+}
+
+/* Releases all pre-alloc'd pages */
+int dump_mem_release(struct dump_dev *dev)
+{
+	struct dump_memdev *dump_mdev = DUMP_MDEV(dev);
+	struct page *page, *map_page;
+	unsigned long *map, *prev_map;
+	void *addr;
+	int i;
+
+	if (!dump_mdev->nr_free)
+		return 0;
+
+	pr_debug("dump_mem_release\n");
+	page = dump_mem_lookup(dump_mdev, 0);
+	for (i = 0; page && (i < DUMP_NR_BOOTSTRAP - 1); i++) {
+		if (PageHighMem(page))
+			break;
+		addr = page_address(page);
+		if (!addr) {
+			printk("page_address(%p) = NULL\n", page);
+			break;
+		}
+		pr_debug("Freeing page at 0x%lx\n", addr); 
+		dump_free_mem(addr);
+		if (dump_mdev->curr_map_offset >= DUMP_MAP_SZ - 1) {
+			map_page = pfn_to_page(*dump_mdev->curr_map);
+			if (PageHighMem(map_page))
+				break;
+			page = dump_mem_next_page(dump_mdev);
+			addr = page_address(map_page);
+			if (!addr) {
+				printk("page_address(%p) = NULL\n", 
+					map_page);
+				break;
+			}
+			pr_debug("Freeing map page at 0x%lx\n", addr);
+			dump_free_mem(addr);
+			i++;
+		} else {
+			page = dump_mem_next_page(dump_mdev);
+		}
+	}
+
+	/* now for the last used bootstrap page used as a map page */
+	if ((i < DUMP_NR_BOOTSTRAP) && (*dump_mdev->curr_map)) {
+		map_page = pfn_to_page(*dump_mdev->curr_map);
+		if ((map_page) && !PageHighMem(map_page)) {
+			addr = page_address(map_page);
+			if (!addr) {
+				printk("page_address(%p) = NULL\n", map_page);
+			} else {
+				pr_debug("Freeing map page at 0x%lx\n", addr);
+				dump_free_mem(addr);
+				i++;
+			}
+		}
+	}
+
+	printk("Freed %d bootstrap pages\n", i);
+
+	/* free the indirect maps */
+	map = (unsigned long *)dump_mdev->indirect_map_root;
+
+	i = 0;
+	while (map) {
+		prev_map = map;
+		map = next_indirect_map(map);
+		dump_free_mem(prev_map);
+		i++;
+	}
+
+	printk("Freed %d indirect map(s)\n", i);
+
+	/* Reset the indirect map */
+	dump_mdev->indirect_map_root = 0;
+	dump_mdev->curr_map = 0;
+
+	/* Reset the free list */
+	dump_mdev->nr_free = 0;
+
+	dump_mdev->last_offset = dump_mdev->ddev.curr_offset = 0;
+	dump_mdev->last_used_offset = 0;
+	dump_mdev->curr_map = NULL;
+	dump_mdev->curr_map_offset = 0;
+	return 0;
+}
+
+/*
+ * Long term:
+ * It is critical for this to be very strict. Cannot afford
+ * to have anything running and accessing memory while we overwrite 
+ * memory (potential risk of data corruption).
+ * If in doubt (e.g if a cpu is hung and not responding) just give
+ * up and refuse to proceed with this scheme.
+ *
+ * Note: I/O will only happen after soft-boot/switchover, so we can 
+ * safely disable interrupts and force stop other CPUs if this is
+ * going to be a disruptive dump, no matter what they
+ * are in the middle of.
+ */
+/* 
+ * ATM Most of this is already taken care of in the nmi handler 
+ * We may halt the cpus rightaway if we know this is going to be disruptive 
+ * For now, since we've limited ourselves to overwriting free pages we
+ * aren't doing much here. Eventually, we'd have to wait to make sure other
+ * cpus aren't using memory we could be overwriting
+ */
+int dump_mem_silence(struct dump_dev *dev)
+{
+	struct dump_memdev *dump_mdev = DUMP_MDEV(dev);
+
+	if (dump_mdev->last_offset > dump_mdev->last_bs_offset) {
+		/* prefer to run lkcd config & start with a clean slate */
+		return -EEXIST;
+	}
+	return 0;
+}
+
+extern int dump_overlay_resume(void);
+
+/* Trigger the next stage of dumping */
+int dump_mem_resume(struct dump_dev *dev)
+{
+	dump_overlay_resume(); 
+	return 0;
+}
+
+/* 
+ * Allocate mem dev pages as required and copy buffer contents into it.
+ * Fails if the no free pages are available
+ * Keeping it simple and limited for starters (can modify this over time)
+ *  Does not handle holes or a sparse layout
+ *  Data must be in multiples of PAGE_SIZE
+ */
+int dump_mem_write(struct dump_dev *dev, void *buf, unsigned long len)
+{
+	struct dump_memdev *dump_mdev = DUMP_MDEV(dev);
+	struct page *page;
+	unsigned long n = 0;
+	void *addr;
+	unsigned long *saved_curr_map, saved_map_offset;
+	int ret = 0;
+
+	pr_debug("dump_mem_write: offset 0x%llx, size %ld\n", 
+		dev->curr_offset, len);
+
+	if (dev->curr_offset + len > dump_mdev->last_offset)  {
+		printk("Out of space to write\n");
+		return -ENOSPC;
+	}
+	
+	if ((len & (PAGE_SIZE - 1)) || (dev->curr_offset & (PAGE_SIZE - 1)))
+		return -EINVAL; /* not aligned in units of page size */
+
+	saved_curr_map = dump_mdev->curr_map;
+	saved_map_offset = dump_mdev->curr_map_offset;
+	page = dump_mem_lookup(dump_mdev, dev->curr_offset >> PAGE_SHIFT);
+
+	for (n = len; (n > 0) && page; n -= PAGE_SIZE, buf += PAGE_SIZE ) {
+		addr = kmap_atomic(page, KM_DUMP);
+		/* memset(addr, 'x', PAGE_SIZE); */
+		memcpy(addr, buf, PAGE_SIZE);
+		kunmap_atomic(addr, KM_DUMP);
+		/* dev->curr_offset += PAGE_SIZE; */
+		page = dump_mem_next_page(dump_mdev);
+	}
+
+	dump_mdev->curr_map = saved_curr_map;
+	dump_mdev->curr_map_offset = saved_map_offset;
+
+	if (dump_mdev->last_used_offset < dev->curr_offset)
+		dump_mdev->last_used_offset = dev->curr_offset;
+
+	return (len - n) ? (len - n) : ret ;
+}
+
+/* dummy - always ready */
+int dump_mem_ready(struct dump_dev *dev, void *buf)
+{
+	return 0;
+}
+
+/* 
+ * Should check for availability of space to write upto the offset 
+ * affects only the curr_offset; last_offset untouched 
+ * Keep it simple: Only allow multiples of PAGE_SIZE for now 
+ */
+int dump_mem_seek(struct dump_dev *dev, loff_t offset)
+{
+	struct dump_memdev *dump_mdev = DUMP_MDEV(dev);
+
+	if (offset & (PAGE_SIZE - 1))
+		return -EINVAL; /* allow page size units only for now */
+	
+	/* Are we exceeding available space ? */
+	if (offset > dump_mdev->last_offset) {
+		printk("dump_mem_seek failed for offset 0x%llx\n",
+			offset);
+		return -ENOSPC;	
+	}
+
+	dump_mdev->ddev.curr_offset = offset;
+	return 0;
+}
+
+/* Copied from dump_filters.c */
+static inline int kernel_page(struct page *p)
+{
+	if (PageReserved(p) || (!PageLRU(p) && PageInuse(p)))
+		return 1;
+	else
+		return 0;
+}
+
+static inline int user_page(struct page *p)
+{
+	if (PageInuse(p)) {
+		if (!PageReserved(p) && PageLRU(p))
+			return 1;
+	}
+	return 0;
+}
+
+
+extern int dump_low_page(struct page *);
+
+int dump_reused_by_boot(struct page *page)
+{
+	/* Todo
+	 * Checks:
+	 * if PageReserved 
+	 * if < __end + bootmem_bootmap_pages for this boot + allowance 
+	 * if overwritten by initrd (how to check ?)
+	 * Also, add more checks in early boot code
+	 * e.g. bootmem bootmap alloc verify not overwriting dump, and if
+	 * so then realloc or move the dump pages out accordingly.
+	 */
+
+	/* Temporary proof of concept hack, avoid overwriting kern pages */
+
+	return (kernel_page(page) || dump_low_page(page) || user_page(page));
+}
+
+
+/* Uses the free page passed in to expand available space */
+int dump_mem_add_space(struct dump_memdev *dev, struct page *page)
+{
+	struct page *map_page;
+	unsigned long *map;	
+	unsigned long i; 
+
+	if (!dev->curr_map)
+		return -ENOMEM; /* must've exhausted indirect map */
+
+	if (!*dev->curr_map || dev->curr_map_offset >= DUMP_MAP_SZ) {
+		/* add map space */
+		*dev->curr_map = page_to_pfn(page);
+		dev->curr_map_offset = 0;
+		return 0;
+	}
+
+	/* add data space */
+	i = dev->curr_map_offset;
+	map_page = pfn_to_page(*dev->curr_map);
+	map = (unsigned long *)kmap_atomic(map_page, KM_DUMP);
+	map[i] = page_to_pfn(page);
+	kunmap_atomic(map, KM_DUMP);
+	dev->curr_map_offset = ++i;
+	dev->last_offset += PAGE_SIZE;
+	if (i >= DUMP_MAP_SZ) {
+		/* move to next map */
+		if (is_last_map_entry(++dev->curr_map)) {
+			/* move to the next indirect map page */
+			pr_debug("dump_mem_add_space: using next"
+			"indirect map\n");
+			dev->curr_map = (unsigned long *)*dev->curr_map;
+		}
+	}		
+	return 0;
+}
+
+
+/* Caution: making a dest page invalidates existing contents of the page */
+int dump_check_and_free_page(struct dump_memdev *dev, struct page *page)
+{
+	int err = 0;
+
+	/* 
+	 * the page can be used as a destination only if we are sure
+	 * it won't get overwritten by the soft-boot, and is not
+	 * critical for us right now.
+	 */
+	if (dump_reused_by_boot(page))
+		return 0;
+
+	if ((err = dump_mem_add_space(dev, page))) {
+		printk("Warning: Unable to extend memdev space. Err %d\n",
+		err);
+		return 0;
+	}
+
+	dev->nr_free++;
+	return 1;
+}
+
+
+struct dump_dev_ops dump_memdev_ops = {
+	.open 		= dump_mem_open,
+	.release	= dump_mem_release,
+	.silence	= dump_mem_silence,
+	.resume 	= dump_mem_resume,
+	.seek		= dump_mem_seek,
+	.write		= dump_mem_write,
+	.read		= NULL, /* not implemented at the moment */
+	.ready		= dump_mem_ready
+};
+
+static struct dump_memdev default_dump_memdev = {
+	.ddev = {.type_name = "memdev", .ops = &dump_memdev_ops,
+        	 .device_id = 0x14}
+	/* assume the rest of the fields are zeroed by default */
+};	
+	
+/* may be overwritten if a previous dump exists */
+struct dump_memdev *dump_memdev = &default_dump_memdev;
+
diff -urN -X ../dontdiff linux-2.5.59/drivers/dump/dump_methods.h linux-2.5.59-kexecdump/drivers/dump/dump_methods.h
--- linux-2.5.59/drivers/dump/dump_methods.h	Mon Feb  3 23:56:59 2003
+++ linux-2.5.59-kexecdump/drivers/dump/dump_methods.h	Thu Feb  6 14:05:52 2003
@@ -139,6 +139,7 @@
 	void *curr_buf; /* current position in the dump buffer */
 	void *dump_buf; /* starting addr of dump buffer */
 	int header_dirty; /* whether the header needs to be written out */
+	int header_len; 
 	struct list_head dumper_list; /* links to other dumpers */
 };	
 
@@ -147,11 +148,32 @@
 	ulong level;
 	ulong flags;
 	struct dumper *dumper;
+	unsigned long dump_device;
+	unsigned long dump_addr; /* relevant only for in-memory dumps */
 	struct list_head dump_dev_list;
 };	
 
 extern struct dump_config dump_config;
 
+/* Used to save the dump config across a reboot for 2-stage dumps: 
+ * 
+ * Note: The scheme, format, compression and device type should be 
+ * registered at bootup, for this config to be sharable across soft-boot. 
+ * The function addresses could have changed and become invalid, and
+ * need to be set up again.
+ */
+struct dump_config_block {
+	u64 magic; /* for a quick sanity check after reboot */
+	struct dump_memdev memdev; /* handle to dump stored in memory */
+	struct dump_config config;
+	struct dumper dumper;
+	struct dump_scheme scheme;
+	struct dump_fmt fmt;
+	struct __dump_compress compress;
+	struct dump_data_filter filter_table[MAX_PASSES];
+	struct dump_anydev dev[MAX_DEVS]; /* target dump device */
+};
+
 
 /* Wrappers that invoke the methods for the current (active) dumper */
 
@@ -275,6 +297,8 @@
 
 /* Some pre-defined dumpers */
 extern struct dumper dumper_singlestage;
+extern struct dumper dumper_stage1;
+extern struct dumper dumper_stage2;
 
 /* These are temporary */
 #define DUMP_MASK_HEADER	DUMP_LEVEL_HEADER
@@ -287,6 +311,7 @@
 
 int dump_generic_execute(const char *panic_str, const struct pt_regs *regs);
 extern int dump_ll_write(void *buf, unsigned long len); 
+int dump_check_and_free_page(struct dump_memdev *dev, struct page *page);
 
 static inline void dumper_reset(void)
 {
@@ -308,7 +333,16 @@
 
 static inline void dump_free_mem(void *buf)
 {
+	struct page *page;
+
+	/* ignore reserved pages (e.g. post soft boot stage) */
+	if (buf && (page = virt_to_page(buf))) {
+		if (PageReserved(page))
+			return;
+	}
+
 	kfree(buf);
 }
 
+
 #endif /*  _LINUX_DUMP_METHODS_H */
diff -urN -X ../dontdiff linux-2.5.59/drivers/dump/dump_overlay.c linux-2.5.59-kexecdump/drivers/dump/dump_overlay.c
--- linux-2.5.59/drivers/dump/dump_overlay.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.59-kexecdump/drivers/dump/dump_overlay.c	Thu Feb  6 14:06:43 2003
@@ -0,0 +1,848 @@
+/*
+ * Two-stage soft-boot based dump scheme methods (memory overlay
+ * with post soft-boot writeout)
+ *
+ * Started: Oct 2002 -  Suparna Bhattacharya <suparna@in.ibm.com>
+ *
+ * This approach of saving the dump in memory and writing it 
+ * out after a softboot without clearing memory is derived from the 
+ * Mission Critical Linux dump implementation. Credits and a big
+ * thanks for letting the lkcd project make use of the excellent 
+ * piece of work and also for helping with clarifications and 
+ * tips along the way are due to:
+ * 	Dave Winchell <winchell@mclx.com> (primary author of mcore)
+ * 	and also to
+ * 	Jeff Moyer <moyer@mclx.com>
+ * 	Josh Huber <huber@mclx.com>
+ * 
+ * For those familiar with the mcore implementation, the key 
+ * differences/extensions here are in allowing entire memory to be 
+ * saved (in compressed form) through a careful ordering scheme 
+ * on both the way down as well on the way up after boot, the latter
+ * for supporting the LKCD notion of passes in which most critical 
+ * data is the first to be saved to the dump device. Also the post 
+ * boot writeout happens from within the kernel rather than driven 
+ * from userspace.
+ *
+ * The sequence is orchestrated through the abstraction of "dumpers",
+ * one for the first stage which then sets up the dumper for the next 
+ * stage, providing for a smooth and flexible reuse of the singlestage 
+ * dump scheme methods and a handle to pass dump device configuration 
+ * information across the soft boot. 
+ *
+ * Copyright (C) 2002 International Business Machines Corp. 
+ *
+ * This code is released under version 2 of the GNU GPL.
+ */
+
+/*
+ * Disruptive dumping using the second kernel soft-boot option
+ * for issuing dump i/o operates in 2 stages:
+ * 
+ * (1) - Saves the (compressed & formatted) dump in memory using a 
+ *       carefully ordered overlay scheme designed to capture the 
+ *       entire physical memory or selective portions depending on 
+ *       dump config settings, 
+ *     - Registers the stage 2 dumper and 
+ *     - Issues a soft reboot w/o clearing memory. 
+ *
+ *     The overlay scheme starts with a small bootstrap free area
+ *     and follows a reverse ordering of passes wherein it 
+ *     compresses and saves data starting with the least critical 
+ *     areas first, thus freeing up the corresponding pages to 
+ *     serve as destination for subsequent data to be saved, and
+ *     so on. With a good compression ratio, this makes it feasible
+ *     to capture an entire physical memory dump without significantly
+ *     reducing memory available during regular operation.
+ *
+ * (2) Post soft-reboot, runs through the saved memory dump and
+ *     writes it out to disk, this time around, taking care to
+ *     save the more critical data first (i.e. pages which figure 
+ *     in early passes for a regular dump). Finally issues a 
+ *     clean reboot.
+ *     
+ *     Since the data was saved in memory after selection/filtering
+ *     and formatted as per the chosen output dump format, at this 
+ *     stage the filter and format actions are just dummy (or
+ *     passthrough) actions, except for influence on ordering of
+ *     passes.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/highmem.h>
+#include <linux/bootmem.h>
+#include <linux/dump.h>
+#include "dump_methods.h"
+
+extern struct list_head dumper_list_head;
+extern struct dump_memdev *dump_memdev;
+extern struct dumper dumper_stage2;
+struct dump_config_block *dump_saved_config = NULL;
+extern struct dump_blockdev *dump_blockdev;
+static struct dump_memdev *saved_dump_memdev = NULL;
+static struct dumper *saved_dumper = NULL;
+
+/* For testing 
+extern void dump_display_map(struct dump_memdev *);
+*/
+
+struct dumper *dumper_by_name(char *name)
+{
+#ifdef LATER
+	struct dumper *dumper;
+	list_for_each_entry(dumper, &dumper_list_head, dumper_list)
+		if (!strncmp(dumper->name, name, 32))
+			return dumper;
+
+	/* not found */
+	return NULL; 
+#endif
+	/* Temporary proof of concept */
+	if (!strncmp(dumper_stage2.name, name, 32))
+		return &dumper_stage2;
+	else
+		return NULL;
+}
+
+#ifdef CONFIG_CRASH_DUMP_SOFTBOOT
+extern void dump_early_reserve_map(struct dump_memdev *);
+
+void crashdump_reserve(void)
+{
+	extern unsigned long crashdump_addr;
+
+	if (crashdump_addr == 0xdeadbeef) 
+		return;
+
+	/* reserve dump config and saved dump pages */
+	dump_saved_config = (struct dump_config_block *)crashdump_addr;
+	/* magic verification */
+	if (dump_saved_config->magic != DUMP_MAGIC_LIVE) {
+		printk("Invalid dump magic. Ignoring dump\n");
+		dump_saved_config = NULL;
+		return;
+	}
+			
+	printk("Dump may be available from previous boot\n");
+
+	reserve_bootmem(virt_to_phys((void *)crashdump_addr), 
+		PAGE_ALIGN(sizeof(struct dump_config_block)));
+	dump_early_reserve_map(&dump_saved_config->memdev);
+
+}
+#endif
+
+/* 
+ * Loads the dump configuration from a memory block saved across soft-boot
+ * The ops vectors need fixing up as the corresp. routines may have 
+ * relocated in the new soft-booted kernel.
+ */
+int dump_load_config(struct dump_config_block *config)
+{
+	struct dumper *dumper;
+	struct dump_data_filter *filter_table, *filter;
+	struct dump_dev *dev;
+	int i;
+
+	if (config->magic != DUMP_MAGIC_LIVE)
+		return -ENOENT; /* not a valid config */
+
+	/* initialize generic config data */
+	memcpy(&dump_config, &config->config, sizeof(dump_config));
+
+	/* initialize dumper state */
+	if (!(dumper = dumper_by_name(config->dumper.name)))  {
+		printk("dumper name mismatch\n");
+		return -ENOENT; /* dumper mismatch */
+	}
+	
+	/* verify and fixup schema */
+	if (strncmp(dumper->scheme->name, config->scheme.name, 32)) {
+		printk("dumper scheme mismatch\n");
+		return -ENOENT; /* mismatch */
+	}
+	config->scheme.ops = dumper->scheme->ops;
+	config->dumper.scheme = &config->scheme;
+	
+	/* verify and fixup filter operations */
+	filter_table = dumper->filter;
+	for (i = 0, filter = config->filter_table; 
+		((i < MAX_PASSES) && filter_table[i].selector); 
+		i++, filter++) {
+		if (strncmp(filter_table[i].name, filter->name, 32)) {
+			printk("dump filter mismatch\n");
+			return -ENOENT; /* filter name mismatch */
+		}
+		filter->selector = filter_table[i].selector;
+	}
+	config->dumper.filter = config->filter_table;
+
+	/* fixup format */
+	if (strncmp(dumper->fmt->name, config->fmt.name, 32)) {
+		printk("dump format mismatch\n");
+		return -ENOENT; /* mismatch */
+	}
+	config->fmt.ops = dumper->fmt->ops;
+	config->dumper.fmt = &config->fmt;
+
+	/* fixup target device */
+	dev = (struct dump_dev *)(&config->dev[0]);
+	if (dumper->dev == NULL) {
+		pr_debug("Vanilla dumper - assume default\n");
+		if (dump_dev == NULL)
+			return -ENODEV;
+		dumper->dev = dump_dev;
+	}
+
+	if (strncmp(dumper->dev->type_name, dev->type_name, 32)) { 
+		printk("dump dev type mismatch %s instead of %s\n",
+				dev->type_name, dumper->dev->type_name);
+		return -ENOENT; /* mismatch */
+	}
+	dev->ops = dumper->dev->ops; 
+	config->dumper.dev = dev;
+	
+	/* fixup memory device containing saved dump pages */
+	/* assume statically init'ed dump_memdev */
+	config->memdev.ddev.ops = dump_memdev->ddev.ops; 
+	/* switch to memdev from prev boot */
+	saved_dump_memdev = dump_memdev; /* remember current */
+	dump_memdev = &config->memdev;
+
+	/* Make this the current primary dumper */
+	dump_config.dumper = &config->dumper;
+
+	return 0;
+}
+
+/* Saves the dump configuration in a memory block for use across a soft-boot */
+int dump_save_config(struct dump_config_block *config)
+{
+	printk("saving dump config settings\n");
+
+	/* dump config settings */
+	memcpy(&config->config, &dump_config, sizeof(dump_config));
+
+	/* dumper state */
+	memcpy(&config->dumper, dump_config.dumper, sizeof(struct dumper));
+	memcpy(&config->scheme, dump_config.dumper->scheme, 
+		sizeof(struct dump_scheme));
+	memcpy(&config->fmt, dump_config.dumper->fmt, sizeof(struct dump_fmt));
+	memcpy(&config->dev[0], dump_config.dumper->dev, 
+		sizeof(struct dump_anydev));
+	memcpy(&config->filter_table, dump_config.dumper->filter, 
+		sizeof(struct dump_data_filter)*MAX_PASSES);
+
+	/* handle to saved mem pages */
+	memcpy(&config->memdev, dump_memdev, sizeof(struct dump_memdev));
+
+	config->magic = DUMP_MAGIC_LIVE;
+	
+	return 0;
+}
+
+int dump_init_stage2(struct dump_config_block *saved_config)
+{
+	int err = 0;
+
+	pr_debug("dump_init_stage2\n");
+	/* Check if dump from previous boot exists */
+	if (saved_config) {
+		printk("loading dumper from previous boot \n");
+		/* load and configure dumper from previous boot */
+		if ((err = dump_load_config(saved_config)))
+			return err;
+
+		if (!dump_oncpu) {
+			if ((err = dump_configure(dump_config.dump_device))) {
+				printk("Stage 2 dump configure failed\n");
+				return err;
+			}
+		}
+
+		dumper_reset();
+		dump_dev = dump_config.dumper->dev;
+		/* write out the dump */
+		err = dump_generic_execute(NULL, NULL);
+		
+		dump_saved_config = NULL;
+
+		if (!dump_oncpu) {
+			dump_unconfigure(); 
+		}
+		
+		return err;
+
+	} else {
+		/* no dump to write out */
+		printk("no dumper from previous boot \n");
+		return 0;
+	}
+}
+
+extern void dump_mem_markpages(struct dump_memdev *);
+
+int dump_switchover_stage(void)
+{
+	int ret = 0;
+
+	/* trigger stage 2 rightaway - in real life would be after soft-boot */
+	/* dump_saved_config would be a boot param */
+	saved_dump_memdev = dump_memdev;
+	saved_dumper = dump_config.dumper;
+	ret = dump_init_stage2(dump_saved_config);
+	dump_memdev = saved_dump_memdev;
+	dump_config.dumper = saved_dumper;
+	return ret;
+}
+
+int dump_activate_softboot(void) 
+{
+	int err = 0;
+
+	/* temporary - switchover to writeout previously saved dump */
+	err = dump_switchover_stage(); /* non-disruptive case */
+	if (dump_oncpu) 
+		dump_config.dumper = &dumper_stage1; /* set things back */
+
+	return err;
+
+	dump_silence_level = DUMP_HALT_CPUS;
+	/* wait till we become the only cpu */
+	/* maybe by checking for online cpus ? */
+
+	/* now call into kexec */
+
+	/* TBD/Fixme: 
+	 * should we call reboot notifiers ? inappropriate for panic ?  
+	 * what about device_shutdown() ? 
+	 * is explicit bus master disabling needed or can we do that
+	 * through driverfs ? 
+	 */
+	return 0;
+}
+
+/* --- DUMP SCHEME ROUTINES  --- */
+
+static inline int dump_buf_pending(struct dumper *dumper)
+{
+	return (dumper->curr_buf - dumper->dump_buf);
+}
+
+/* Invoked during stage 1 of soft-reboot based dumping */
+int dump_overlay_sequencer(void)
+{
+	struct dump_data_filter *filter = dump_config.dumper->filter;
+	struct dump_data_filter *filter2 = dumper_stage2.filter;
+	int pass = 0, err = 0, save = 0;
+	int (*action)(unsigned long, unsigned long);
+
+	/* Make sure gzip compression is being used */
+	if (dump_config.dumper->compress->compress_type != DUMP_COMPRESS_GZIP) {
+		printk(" Please set GZIP compression \n");
+		return -EINVAL;
+	}
+
+	/* start filling in dump data right after the header */
+	dump_config.dumper->curr_offset = 
+		PAGE_ALIGN(dump_config.dumper->header_len);
+
+	/* Locate the last pass */
+	for (;filter->selector; filter++, pass++);
+	
+	/* 
+	 * Start from the end backwards: overlay involves a reverse 
+	 * ordering of passes, since less critical pages are more
+	 * likely to be reusable as scratch space once we are through
+	 * with them. 
+	 */
+	for (--pass, --filter; pass >= 0; pass--, filter--)
+	{
+		/* Assumes passes are exclusive (even across dumpers) */
+		/* Requires care when coding the selection functions */
+		if ((save = filter->level_mask & dump_config.level))
+			action = dump_save_data;
+		else
+			action = dump_skip_data;
+
+		/* Remember the offset where this pass started */
+		/* The second stage dumper would use this */
+		if (dump_buf_pending(dump_config.dumper) & (PAGE_SIZE - 1)) {
+			pr_debug("Starting pass %d with pending data\n", pass);
+			pr_debug("filling dummy data to page-align it\n");
+			dump_config.dumper->curr_buf = (void *)PAGE_ALIGN(
+				(unsigned long)dump_config.dumper->curr_buf);
+		}
+		
+		filter2[pass].start = dump_config.dumper->curr_offset
+			+ dump_buf_pending(dump_config.dumper);
+
+		err = dump_iterator(pass, action, filter);
+
+		filter2[pass].end = dump_config.dumper->curr_offset
+			+ dump_buf_pending(dump_config.dumper);
+
+		if (err < 0) {
+			printk("dump_overlay_seq: failure %d in pass %d\n", 
+				err, pass);
+			break;
+		}	
+		printk("\n %d overlay pages %s of %d each in pass %d\n", 
+		err, save ? "saved" : "skipped", DUMP_PAGE_SIZE, pass);
+	}
+
+	return err;
+}
+
+/* from dump_memdev.c */
+extern struct page *dump_mem_lookup(struct dump_memdev *dev, unsigned long loc);
+extern struct page *dump_mem_next_page(struct dump_memdev *dev);
+
+static inline struct page *dump_get_saved_page(loff_t loc)
+{
+	return (dump_mem_lookup(dump_memdev, loc >> PAGE_SHIFT));
+}
+
+static inline struct page *dump_next_saved_page(void)
+{
+	return (dump_mem_next_page(dump_memdev));
+}
+
+/* 
+ * Iterates over list of saved dump pages. Invoked during second stage of 
+ * soft boot dumping
+ *
+ * Observation: If additional selection is desired at this stage then
+ * a different iterator could be written which would advance 
+ * to the next page header everytime instead of blindly picking up
+ * the data. In such a case loc would be interpreted differently. 
+ * At this moment however a blind pass seems sufficient, cleaner and
+ * faster.
+ */
+int dump_saved_data_iterator(int pass, int (*action)(unsigned long, 
+	unsigned long), struct dump_data_filter *filter)
+{
+	loff_t loc = filter->start;
+	struct page *page;
+	unsigned long count = 0;
+	int err = 0;
+	unsigned long sz;
+
+	printk("pass %d, start off 0x%llx end offset 0x%llx\n", pass,
+			filter->start, filter->end);
+
+	/* loc will get treated as logical offset into stage 1 */
+	page = dump_get_saved_page(loc);
+			
+	for (; loc < filter->end; loc += PAGE_SIZE) {
+		dump_config.dumper->curr_loc = loc;
+		if (!page) {
+			printk("no more saved data for pass %d\n", pass);
+			break;
+		}
+		sz = (loc + PAGE_SIZE > filter->end) ? filter->end - loc :
+			PAGE_SIZE;
+
+		if (page && filter->selector(pass, (unsigned long)page, 
+			PAGE_SIZE))  {
+			pr_debug("mem offset 0x%llx\n", loc);
+			if ((err = action((unsigned long)page, sz))) 
+				break;
+			else
+				count++;
+			/* clear the contents of page */
+			/* fixme: consider using KM_DUMP instead */
+			clear_highpage(page);
+			
+		}
+		page = dump_next_saved_page();
+	}
+
+	return err ? err : count;
+}
+
+static inline int dump_overlay_pages_done(struct page *page, int nr)
+{
+	int ret=0;
+
+	for (; nr ; page++, nr--) {
+		if (dump_check_and_free_page(dump_memdev, page))
+			ret++;
+	}
+	return ret;
+}
+
+int dump_overlay_save_data(unsigned long loc, unsigned long len)
+{
+	int err = 0;
+	struct page *page = (struct page *)loc;
+	static unsigned long cnt = 0;
+
+	if ((err = dump_generic_save_data(loc, len)))
+		return err;
+
+	if (dump_overlay_pages_done(page, len >> PAGE_SHIFT)) {
+		cnt++;
+		if (!(cnt & 0x7f))
+			pr_debug("released page 0x%lx\n", page_to_pfn(page));
+	}
+	
+	return err;
+}
+
+
+int dump_overlay_skip_data(unsigned long loc, unsigned long len)
+{
+	struct page *page = (struct page *)loc;
+
+	dump_overlay_pages_done(page, len >> PAGE_SHIFT);
+	return 0;
+}
+
+int dump_overlay_resume(void)
+{
+	int err = 0;
+
+	/* 
+	 * switch to stage 2 dumper, save dump_config_block
+	 * and then trigger a soft-boot
+	 */
+	dumper_stage2.header_len = dump_config.dumper->header_len;
+	dump_config.dumper = &dumper_stage2;
+	if ((err = dump_save_config(dump_saved_config)))
+		return err;
+
+	dump_dev = dump_config.dumper->dev;
+
+	return err;
+	err = dump_switchover_stage();  /* plugs into soft boot mechanism */
+	dump_config.dumper = &dumper_stage1; /* set things back */
+	return err;
+}
+
+int dump_overlay_configure(unsigned long devid)
+{
+	struct dump_dev *dev;
+	struct dump_config_block *saved_config = dump_saved_config;
+	int err = 0;
+
+	/* If there is a previously saved dump, write it out first */
+	if (saved_config) {
+		printk("Processing old dump pending writeout\n");
+		err = dump_switchover_stage();
+		if (err) {
+			printk("failed to writeout saved dump\n");
+			return err;
+		}
+		dump_free_mem(saved_config); /* testing only: not after boot */
+	}
+
+	dev = dumper_stage2.dev = dump_config.dumper->dev;
+	/* From here on the intermediate dump target is memory-only */
+	dump_dev = dump_config.dumper->dev = &dump_memdev->ddev;
+	if ((err = dump_generic_configure(0))) {
+		printk("dump generic configure failed: err %d\n", err);
+		return err;
+	}
+	/* temporary */
+	dumper_stage2.dump_buf = dump_config.dumper->dump_buf;
+
+	/* Sanity check on the actual target dump device */
+	if (!dev || (err = dev->ops->open(dev, devid))) {
+		return err;
+	}
+	/* TBD: should we release the target if this is soft-boot only ? */
+
+	/* alloc a dump config block area to save across reboot */
+	if (!(dump_saved_config = dump_alloc_mem(sizeof(struct 
+		dump_config_block)))) {
+		printk("dump config block alloc failed\n");
+		/* undo configure */
+		dump_generic_unconfigure();
+		return -ENOMEM;
+	}
+	dump_config.dump_addr = (unsigned long)dump_saved_config;
+	printk("Dump config block of size %d set up at 0x%lx\n", 
+		sizeof(*dump_saved_config), (unsigned long)dump_saved_config);
+	return 0;
+}
+
+int dump_overlay_unconfigure(void)
+{
+	struct dump_dev *dev = dumper_stage2.dev;
+	int err = 0;
+
+	pr_debug("dump_overlay_unconfigure\n");
+	/* Close the secondary device */
+	dev->ops->release(dev); 
+	pr_debug("released secondary device\n");
+
+	err = dump_generic_unconfigure();
+	pr_debug("Unconfigured generic portions\n");
+	dump_free_mem(dump_saved_config);
+	dump_saved_config = NULL;
+	pr_debug("Freed saved config block\n");
+	dump_dev = dump_config.dumper->dev = dumper_stage2.dev;
+
+	printk("Unconfigured overlay dumper\n");
+	return err;
+}
+
+int dump_staged_unconfigure(void)
+{
+	int err = 0;
+	struct dump_config_block *saved_config = dump_saved_config;
+	struct dump_dev *dev;
+
+	pr_debug("dump_staged_unconfigure\n");
+	err = dump_generic_unconfigure();
+
+	/* now check if there is a saved dump waiting to be written out */
+	if (saved_config) {
+		printk("Processing saved dump pending writeout\n");
+		if ((err = dump_switchover_stage())) {
+			printk("Error in commiting saved dump at 0x%lx\n", 
+				(unsigned long)saved_config);
+			printk("Old dump may hog memory\n");
+		} else {
+			dump_free_mem(saved_config);
+			pr_debug("Freed saved config block\n");
+		}
+		dump_saved_config = NULL;
+	} else {
+		dev = &dump_memdev->ddev;
+		dev->ops->release(dev);
+	}
+	printk("Unconfigured second stage dumper\n");
+
+	return 0;
+}
+
+/* ----- PASSTHRU FILTER ROUTINE --------- */
+
+/* transparent - passes everything through */
+int dump_passthru_filter(int pass, unsigned long loc, unsigned long sz)
+{
+	return 1;
+}
+
+/* ----- PASSTRU FORMAT ROUTINES ---- */
+
+
+int dump_passthru_configure_header(const char *panic_str, const struct pt_regs *regs)
+{
+	dump_config.dumper->header_dirty++;
+	return 0;
+}
+
+/* Copies bytes of data from page(s) to the specified buffer */
+int dump_copy_pages(void *buf, struct page *page, unsigned long sz)
+{
+	unsigned long len = 0, bytes;
+	void *addr;
+
+	while (len < sz) {
+		addr = kmap_atomic(page, KM_DUMP);
+		bytes = (sz > len + PAGE_SIZE) ? PAGE_SIZE : sz - len;	
+		memcpy(buf, addr, bytes); 
+		kunmap_atomic(addr, KM_DUMP);
+		buf += bytes;
+		len += bytes;
+		page++;
+	}
+	/* memset(dump_config.dumper->curr_buf, 0x57, len); temporary */
+
+	return sz - len;
+}
+
+int dump_passthru_update_header(void)
+{
+	long len = dump_config.dumper->header_len;
+	struct page *page;
+	void *buf = dump_config.dumper->dump_buf;
+	int err = 0;
+
+	if (!dump_config.dumper->header_dirty)
+		return 0;
+
+	pr_debug("Copying header of size %ld bytes from memory\n", len);
+	if (len > DUMP_BUFFER_SIZE) 
+		return -E2BIG;
+
+	page = dump_mem_lookup(dump_memdev, 0);
+	for (; (len > 0) && page; buf += PAGE_SIZE, len -= PAGE_SIZE) {
+		if ((err = dump_copy_pages(buf, page, PAGE_SIZE)))
+			return err;
+		page = dump_mem_next_page(dump_memdev);
+	}
+	if (len > 0) {
+		printk("Incomplete header saved in mem\n");
+		return -ENOENT;
+	}
+
+	if ((err = dump_dev_seek(0))) {
+		printk("Unable to seek to dump header offset\n");
+		return err;
+	}
+	err = dump_ll_write(dump_config.dumper->dump_buf, 
+		buf - dump_config.dumper->dump_buf);
+	if (err < dump_config.dumper->header_len)
+		return (err < 0) ? err : -ENOSPC;
+
+	dump_config.dumper->header_dirty = 0;
+	return 0;
+}
+
+static loff_t next_dph_offset = 0;
+
+static int dph_valid(struct __dump_page *dph)
+{
+	if ((dph->dp_address & (PAGE_SIZE - 1)) || (dph->dp_flags 
+	      > DUMP_DH_COMPRESSED) || (!dph->dp_flags) ||
+		(dph->dp_size > PAGE_SIZE)) {
+	printk("dp->address = 0x%llx, dp->size = 0x%x, dp->flag = 0x%x\n",
+		dph->dp_address, dph->dp_size, dph->dp_flags);
+		return 0;
+	}
+	return 1;
+}
+
+int dump_verify_lcrash_data(void *buf, unsigned long sz)
+{
+	struct __dump_page *dph;
+
+	/* sanity check for page headers */
+	while (next_dph_offset + sizeof(*dph) < sz) {
+		dph = (struct __dump_page *)(buf + next_dph_offset);
+		if (!dph_valid(dph)) {
+			printk("Invalid page hdr at offset 0x%llx\n",
+				next_dph_offset);
+			return -EINVAL;
+		}
+		next_dph_offset += dph->dp_size + sizeof(*dph);
+	}
+
+	next_dph_offset -= sz;	
+	return 0;
+}
+
+/* 
+ * TBD/Later: Consider avoiding the copy by using a scatter/gather 
+ * vector representation for the dump buffer
+ */
+int dump_passthru_add_data(unsigned long loc, unsigned long sz)
+{
+	struct page *page = (struct page *)loc;
+	void *buf = dump_config.dumper->curr_buf;
+	int err = 0;
+
+	if ((err = dump_copy_pages(buf, page, sz))) {
+		printk("dump_copy_pages failed");
+		return err;
+	}
+
+	if ((err = dump_verify_lcrash_data(buf, sz))) {
+		printk("dump_verify_lcrash_data failed\n");
+		printk("Invalid data for pfn 0x%lx\n", page_to_pfn(page));
+		printk("Page flags 0x%lx\n", page->flags);
+		printk("Page count 0x%x\n", atomic_read(&page->count));
+		return err;
+	}
+
+	dump_config.dumper->curr_buf = buf + sz;
+
+	return 0;
+}
+
+
+/* Stage 1 dumper: Saves compressed dump in memory and soft-boots system */
+
+/* Scheme to overlay saved data in memory for writeout after a soft-boot */
+struct dump_scheme_ops dump_scheme_overlay_ops = {
+	.configure	= dump_overlay_configure,
+	.unconfigure	= dump_overlay_unconfigure,
+	.sequencer	= dump_overlay_sequencer,
+	.iterator	= dump_page_iterator,
+	.save_data	= dump_overlay_save_data,
+	.skip_data	= dump_overlay_skip_data,
+	.write_buffer	= dump_generic_write_buffer
+};
+
+struct dump_scheme dump_scheme_overlay = {
+	.name		= "overlay",
+	.ops		= &dump_scheme_overlay_ops
+};
+
+
+/* Stage 1 must use a good compression scheme - default to gzip */
+extern struct __dump_compress dump_gzip_compression;
+
+struct dumper dumper_stage1 = {
+	.name		= "stage1",
+	.scheme		= &dump_scheme_overlay,
+	.fmt		= &dump_fmt_lcrash,
+	.compress 	= &dump_none_compression, /* needs to be gzip */
+	.filter		= dump_filter_table,
+	.dev		= NULL,
+};		
+
+/* Stage 2 dumper: Activated after softboot to write out saved dump to device */
+
+/* Formatter that transfers data as is (transparent) w/o further conversion */
+struct dump_fmt_ops dump_fmt_passthru_ops = {
+	.configure_header	= dump_passthru_configure_header,
+	.update_header		= dump_passthru_update_header,
+	.save_context		= NULL, /* unused */
+	.add_data		= dump_passthru_add_data,
+	.update_end_marker	= dump_lcrash_update_end_marker
+};
+
+struct dump_fmt dump_fmt_passthru = {
+	.name	= "passthru",
+	.ops	= &dump_fmt_passthru_ops
+};
+
+/* Filter that simply passes along any data within the range (transparent)*/
+/* Note: The start and end ranges in the table are filled in at run-time */
+
+extern int dump_filter_none(int pass, unsigned long loc, unsigned long sz);
+
+struct dump_data_filter dump_passthru_filtertable[MAX_PASSES] = {
+{.name = "passkern", .selector = dump_passthru_filter, 
+	.level_mask = DUMP_MASK_KERN },
+{.name = "passuser", .selector = dump_passthru_filter, 
+	.level_mask = DUMP_MASK_USED },
+{.name = "passunused", .selector = dump_passthru_filter, 
+	.level_mask = DUMP_MASK_UNUSED },
+{.name = "none", .selector = dump_filter_none, 
+	.level_mask = DUMP_MASK_REST }
+};
+
+
+/* Scheme to handle data staged / preserved across a soft-boot */
+struct dump_scheme_ops dump_scheme_staged_ops = {
+	.configure	= dump_generic_configure,
+	.unconfigure	= dump_staged_unconfigure,
+	.sequencer	= dump_generic_sequencer,
+	.iterator	= dump_saved_data_iterator,
+	.save_data	= dump_generic_save_data,
+	.skip_data	= dump_generic_skip_data,
+	.write_buffer	= dump_generic_write_buffer
+};
+
+struct dump_scheme dump_scheme_staged = {
+	.name		= "staged",
+	.ops		= &dump_scheme_staged_ops
+};
+
+/* The stage 2 dumper comprising all these */
+struct dumper dumper_stage2 = {
+	.name		= "stage2",
+	.scheme		= &dump_scheme_staged,
+	.fmt		= &dump_fmt_passthru,
+	.compress 	= &dump_none_compression,
+	.filter		= dump_passthru_filtertable,
+	.dev		= NULL,
+};		
+
diff -urN -X ../dontdiff linux-2.5.59/drivers/dump/dump_scheme.c linux-2.5.59-kexecdump/drivers/dump/dump_scheme.c
--- linux-2.5.59/drivers/dump/dump_scheme.c	Mon Feb  3 23:56:59 2003
+++ linux-2.5.59-kexecdump/drivers/dump/dump_scheme.c	Thu Feb  6 07:49:15 2003
@@ -151,7 +151,7 @@
 
 		if (!(dump_config.dumper->count & 0x3f)) {
 			/* Update the header every one in a while */
-			/* memset((void *)dump_buf, 'b', DUMP_BUFFER_SIZE);*/
+			memset((void *)dump_buf, 'b', DUMP_BUFFER_SIZE);
 			if ((ret = dump_update_header()) < 0) {
 				/* issue warning */
 				return ret;
@@ -167,6 +167,12 @@
 
 		/* --- Done with periodic chores -- */
 
+		/* 
+		 * extra bit of copying to simplify verification  
+		 * in the second kernel boot based scheme
+		 */
+		memcpy(dump_buf - DUMP_PAGE_SIZE, dump_buf + 
+			DUMP_BUFFER_SIZE - DUMP_PAGE_SIZE, DUMP_PAGE_SIZE);
 
 		/* now adjust the leftover bits back to the top of the page */
 		/* this case would not arise during stage 2 (passthru) */
@@ -267,7 +273,7 @@
 
 	/* Allocate the dump buffer and initialize dumper state */
 	/* Assume that we get aligned addresses */
-	if (!(buf = dump_alloc_mem(DUMP_BUFFER_SIZE + 2 * DUMP_PAGE_SIZE)))
+	if (!(buf = dump_alloc_mem(DUMP_BUFFER_SIZE + 3 * DUMP_PAGE_SIZE)))
 		return -ENOMEM;
 
 	if ((unsigned long)buf & (PAGE_SIZE - 1)) {
@@ -277,7 +283,7 @@
 	}
 
 	/* Initialize the rest of the fields */
-	dump_config.dumper->dump_buf = buf;
+	dump_config.dumper->dump_buf = buf + DUMP_PAGE_SIZE;
 	dumper_reset();
 
 	/* Open the dump device */
@@ -305,14 +311,19 @@
 	void *buf = dump_config.dumper->dump_buf;
 	int ret = 0;
 
+	pr_debug("Generic unconfigure\n");
 	/* Close the dump device */
 	if (dev && (ret = dev->ops->release(dev)))
 		return ret;
+
+	printk("Closed dump device\n");
 	
 	if (buf)
-		dump_free_mem(buf);
+		dump_free_mem((buf - DUMP_PAGE_SIZE));
 
 	dump_config.dumper->curr_buf = dump_config.dumper->dump_buf = NULL;
+	pr_debug("Released dump buffer\n");
+
 	return 0;
 }
 
diff -urN -X ../dontdiff linux-2.5.59/drivers/dump/dump_setup.c linux-2.5.59-kexecdump/drivers/dump/dump_setup.c
--- linux-2.5.59/drivers/dump/dump_setup.c	Mon Feb  3 23:57:00 2003
+++ linux-2.5.59-kexecdump/drivers/dump/dump_setup.c	Thu Feb  6 16:52:08 2003
@@ -129,6 +129,8 @@
 struct dump_config dump_config = {
 	.level 		= 0,
 	.flags 		= 0,
+	.dump_device	= 0,
+	.dump_addr	= 0,
 	.dumper 	= NULL
 };
 
@@ -140,7 +142,6 @@
 /* Other global fields */
 extern struct __dump_header dump_header; 
 struct dump_dev *dump_dev = NULL;  /* Active dump device                   */
-int dump_device = 0;
 static int dump_compress = 0;
 
 static u16 dump_compress_none(const u8 *old, u16 oldsize, u8 *new, u16 newsize);
@@ -191,6 +192,8 @@
 static int proc_dump_device(ctl_table *ctl, int write, struct file *f,
 			    void *buffer, size_t *lenp);
 
+static int proc_doulonghex(ctl_table *ctl, int write, struct file *f,
+			    void *buffer, size_t *lenp);
 /*
  * sysctl-tuning infrastructure.
  */
@@ -200,14 +203,14 @@
 	  .data = &dump_config.level, 	 
 	  .maxlen = sizeof(int),
 	  .mode = 0644,
-	  .proc_handler = proc_dointvec, },
+	  .proc_handler = proc_doulonghex, },
 
 	{ .ctl_name = CTL_DUMP_FLAGS,
 	  .procname = DUMP_FLAGS_NAME,
 	  .data = &dump_config.flags,	
 	  .maxlen = sizeof(int),
 	  .mode = 0644,
-	  .proc_handler = proc_dointvec, },
+	  .proc_handler = proc_doulonghex, },
 
 	{ .ctl_name = CTL_DUMP_COMPRESS,
 	  .procname = DUMP_COMPRESS_NAME,
@@ -219,10 +222,19 @@
 	{ .ctl_name = CTL_DUMP_DEVICE,
 	  .procname = DUMP_DEVICE_NAME,
 	  .mode = 0644,
-	  .data = &dump_device, /* FIXME */
+	  .data = &dump_config.dump_device, /* FIXME */
 	  .maxlen = sizeof(int),
 	  .proc_handler = proc_dump_device },
 
+#ifdef CONFIG_CRASH_DUMP_MEMDEV
+	{ .ctl_name = CTL_DUMP_ADDR,
+	  .procname = DUMP_ADDR_NAME,
+	  .mode = 0444,
+	  .data = &dump_config.dump_addr,
+	  .maxlen = sizeof(unsigned long),
+	  .proc_handler = proc_doulonghex },
+#endif
+
 	{ 0, }
 };
 
@@ -392,7 +404,16 @@
 		dump_unconfigure();
 	}
 	/* set up new dumper */
-	dump_config.dumper = &dumper_singlestage;
+	if (dump_config.flags & DUMP_FLAGS_SOFTBOOT) {
+		printk("Configuring softboot based dump \n");
+#ifdef CONFIG_CRASH_DUMP_MEMDEV
+		dump_config.dumper = &dumper_stage1; 
+#else
+		printk("Requires CONFIG_CRASHDUMP_MEMDEV. Can't proceed.\n");
+#endif
+	} else {
+		dump_config.dumper = &dumper_singlestage;
+	}	
 	dump_config.dumper->dev = dump_dev;
 
 	ret = dump_configure(devid);
@@ -400,10 +421,11 @@
 		dump_okay = 1;
 		pr_debug("%s dumper set up for dev 0x%lx\n", 
 			dump_config.dumper->name, devid);
-		dump_device = devid;
+ 		dump_config.dump_device = devid;
 	} else {
 		printk("%s dumper set up failed for dev 0x%lx\n", 
 		       dump_config.dumper->name, devid);
+ 		dump_config.dumper = NULL;
 	}
 	return ret;
 }
@@ -473,7 +495,7 @@
 
 		
 	case DIOGDUMPDEV:	/* get dump_device */
-		return put_user((long)dump_device, (long *)arg);
+		return put_user((long)dump_config.dump_device, (long *)arg);
 
 	case DIOSDUMPLEVEL:	/* set dump_level */
 		if (!(f->f_flags & O_RDWR))
@@ -563,10 +585,10 @@
 
 	/* same permission checks as ioctl */
 	if (capable(CAP_SYS_ADMIN)) {
-		ret = proc_dointvec(ctl, write, f, buffer, lenp);
+		ret = proc_doulonghex(ctl, write, f, buffer, lenp);
 		if (ret == 0 && write && *valp != oval) {
 			/* need to restore old value to close properly */
-			dump_device = (dev_t) oval;
+			dump_config.dump_device = (dev_t) oval;
 			__dump_open();
 			ret = dumper_setup(dump_config.flags, (dev_t) *valp);
 		}
@@ -575,6 +597,37 @@
 	return ret;
 }
 
+/* All for the want of a proc_do_xxx routine which prints values in hex */
+static int 
+proc_doulonghex(ctl_table *ctl, int write, struct file *f,
+		 void *buffer, size_t *lenp)
+{
+#define TMPBUFLEN 20
+	unsigned long *i;
+	size_t len, left;
+	char buf[TMPBUFLEN];
+
+	if (!ctl->data || !ctl->maxlen || !*lenp || (f->f_pos)) {
+		*lenp = 0;
+		return 0;
+	}
+	
+	i = (unsigned long *) ctl->data;
+	left = *lenp;
+	
+	sprintf(buf, "0x%lx\n", (*i));
+	len = strlen(buf);
+	if (len > left)
+		len = left;
+	if(copy_to_user(buffer, buf, len))
+		return -EFAULT;
+	
+	left -= len;
+	*lenp -= left;
+	f->f_pos += *lenp;
+	return 0;
+}
+
 /*
  * -----------------------------------------------------------------------
  *                     I N I T   F U N C T I O N S
diff -urN -X ../dontdiff linux-2.5.59/include/linux/dump.h linux-2.5.59-kexecdump/include/linux/dump.h
--- linux-2.5.59/include/linux/dump.h	Mon Feb  3 23:57:01 2003
+++ linux-2.5.59-kexecdump/include/linux/dump.h	Thu Feb  6 13:56:35 2003
@@ -87,6 +87,7 @@
 
 /* dump flags - any dump-type specific flags -- add as necessary */
 #define DUMP_FLAGS_NONE		0x0	/* no flags are set for this dump   */
+#define DUMP_FLAGS_SOFTBOOT	0x2	/* 2 stage soft-boot based dump	    */
 
 #define DUMP_FLAGS_TARGETMASK	0xf0000000 /* handle special case targets   */
 #define DUMP_FLAGS_DISKDUMP	0x80000000 /* dump to local disk 	    */
@@ -107,6 +108,7 @@
 #define DUMP_COMPRESS_NAME	"compress"
 #define DUMP_LEVEL_NAME		"level"
 #define DUMP_FLAGS_NAME		"flags"
+#define DUMP_ADDR_NAME		"addr"
 
 #define DUMP_SYSRQ_KEY		'd'	/* key to use for MAGIC_SYSRQ key   */
 
@@ -117,7 +119,8 @@
 	CTL_DUMP_COMPRESS=3,
 	CTL_DUMP_LEVEL=3,
 	CTL_DUMP_FLAGS=4,
-	CTL_DUMP_TEST=5,
+	CTL_DUMP_ADDR=5,
+	CTL_DUMP_TEST=6,
 };
 
 
diff -urN -X ../dontdiff linux-2.5.59/include/linux/dumpdev.h linux-2.5.59-kexecdump/include/linux/dumpdev.h
--- linux-2.5.59/include/linux/dumpdev.h	Mon Feb  3 23:57:01 2003
+++ linux-2.5.59-kexecdump/include/linux/dumpdev.h	Thu Feb  6 07:49:15 2003
@@ -70,6 +70,44 @@
 	return container_of(dev, struct dump_blockdev, ddev);
 }
 
+
+/* mem  - for internal use by soft-boot based dumper */
+struct dump_memdev {
+	struct dump_dev ddev;
+	unsigned long indirect_map_root;
+	unsigned long nr_free;
+	struct page *curr_page;
+	unsigned long *curr_map;
+	unsigned long curr_map_offset;
+	unsigned long last_offset;
+	unsigned long last_used_offset;
+	unsigned long last_bs_offset;
+};	
+
+static inline struct dump_memdev *DUMP_MDEV(struct dump_dev *dev)
+{
+	return container_of(dev, struct dump_memdev, ddev);
+}
+
+/* Todo/future - meant for raw dedicated interfaces e.g. mini-ide driver */
+struct dump_rdev {
+	struct dump_dev ddev;
+	char name[32];
+	int (*reset)(struct dump_rdev *, unsigned int, 
+		unsigned long);
+	/* ... to do ... */
+};
+
+/* just to get the size right when saving config across a soft-reboot */
+struct dump_anydev {
+	union {
+		struct dump_blockdev bddev;
+		/* .. add other types here .. */
+	};
+};
+
+
+
 /* Dump device / target operation wrappers */
 /* These assume that dump_dev is initiatized to dump_config.dumper->dev */
 
diff -urN -X ../dontdiff linux-2.5.59/kernel/panic.c linux-2.5.59-kexecdump/kernel/panic.c
--- linux-2.5.59/kernel/panic.c	Thu Feb  6 16:42:29 2003
+++ linux-2.5.59-kexecdump/kernel/panic.c	Thu Feb  6 16:18:10 2003
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/kexec.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 
@@ -74,13 +75,22 @@
 	 	 * Delay timeout seconds before rebooting the machine. 
 		 * We can't use the "normal" timers since we just panicked..
 	 	 */
+		struct kimage *image;
 		printk(KERN_EMERG "Rebooting in %d seconds..",panic_timeout);
-		mdelay(panic_timeout*1000);
 		/*
 		 *	Should we run the reboot notifier. For the moment Im
 		 *	choosing not too. It might crash, be corrupt or do
 		 *	more harm than good for other reasons.
 		 */
+#ifdef CONFIG_KEXEC
+		image = xchg(&kexec_image, 0);
+		if (image) {
+			printk(KERN_EMERG "by starting a new kernel ..\n");
+			mdelay(panic_timeout*1000);
+			machine_kexec(image);
+		}
+#endif
+		mdelay(panic_timeout*1000);
 		machine_restart(NULL);
 	}
 #ifdef __sparc__

--9jxsPFA5p3P2qPhR--
