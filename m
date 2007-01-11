Return-Path: <linux-kernel-owner+w=401wt.eu-S965029AbXAKDf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbXAKDf0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 22:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbXAKDf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 22:35:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:63497 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965029AbXAKDfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 22:35:20 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fCdkjoLtnBh4tirTTfs4gbKijPwssrKYZWoLNfJGH2HHbueuJ0qkis9eW7gkf9SAT9i9Ix3kGQ4YZsTz+RP/HkQh8IyiEqCDzytEQ8s3iERWgyBUYWmi5ewMkv1Ff7PTZXuBHrW8Gs/ziZFBXRb0kT9+QgQzRCtFPOLCDzKmEog=
Message-ID: <4df04b840701101935i2083da21t26785bc6c00057a7@mail.gmail.com>
Date: Thu, 11 Jan 2007 11:35:17 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16.29 1/1] MM: enhance Linux swap subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My patch is based on my new idea to Linux swap subsystem, you can find more in
Documentation/vm_pps.txt which isn't only patch illustration but also file
changelog. In brief, SwapDaemon should scan and reclaim pages on
UserSpace::vmalist other than current zone::active/inactive. The change will
conspicuously enhance swap subsystem performance by

1) SwapDaemon can collect the statistic of process acessing pages and by it
  unmaps ptes, SMP specially benefits from it for we can use flush_tlb_range
  to unmap ptes batchly rather than frequently TLB IPI interrupt per a page in
  current Linux legacy swap subsystem. In fact, in some cases, we can even
  flush TLB without sending IPI.
2) Page-fault can issue better readahead requests since history data shows all
  related pages have conglomerating affinity. In contrast, Linux page-fault
  readaheads the pages relative to the SwapSpace position of current
  page-fault page.
3) It's conformable to POSIX madvise API family.

	Signed-off-by: Yunfeng Zhang <zyf.zeroos@gmail.com>

Index: linux-2.6.16.29/Documentation/vm_pps.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16.29/Documentation/vm_pps.txt	2007-01-11 10:51:15.649869656 +0800
@@ -0,0 +1,214 @@
+                         Pure Private Page System (pps)
+                     Copyright by Yunfeng Zhang on GFDL 1.2
+                              zyf.zeroos@gmail.com
+                              December 24-26, 2006
+
+// Purpose <([{
+The file is used to document the idea which is published firstly at
+http://www.ussg.iu.edu/hypermail/linux/kernel/0607.2/0451.html, as a part of my
+OS -- main page http://blog.chinaunix.net/u/21764/index.php. In brief, the
+patch of the document is for enchancing the performance of Linux swap
+subsystem. You can find the overview of the idea in section <How to Reclaim
+Pages more Efficiently> and how I patch it into Linux 2.6.16.29 in section
+<Pure Private Page System -- pps>.
+// }])>
+
+// How to Reclaim Pages more Efficiently <([{
+Good idea originates from overall design and management ability, when you look
+down from a manager view, you will relief yourself from disordered code and
+find some problem immediately.
+
+OK! to modern OS, its memory subsystem can be divided into three layers
+1) Space layer (InodeSpace, UserSpace and CoreSpace).
+2) VMA layer (PrivateVMA and SharedVMA, memory architecture-independent layer).
+3) PTE, zone/memory inode layer (architecture-dependent).
+4) Maybe it makes you sense that Page should be placed on the 3rd layer, but
+   here, it's placed on the 2nd layer since it's the basic unit of VMA.
+
+Since the 2nd layer assembles the much statistic of page-acess information, so
+it's nature that swap subsystem should be deployed and implemented on the 2nd
+layer.
+
+Undoubtedly, there are some virtues about it
+1) SwapDaemon can collect the statistic of process acessing pages and by it
+   unmaps ptes, SMP specially benefits from it for we can use flush_tlb_range
+   to unmap ptes batchly rather than frequently TLB IPI interrupt per a page in
+   current Linux legacy swap subsystem.
+2) Page-fault can issue better readahead requests since history data shows all
+   related pages have conglomerating affinity. In contrast, Linux page-fault
+   readaheads the pages relative to the SwapSpace position of current
+   page-fault page.
+3) It's conformable to POSIX madvise API family.
+
+Unfortunately, Linux 2.6.16.29 swap subsystem is based on the 3rd layer -- a
+system on zone::active_list/inactive_list.
+
+I've finished a patch, see section <Pure Private Page System -- pps>. Note, it
+ISN'T perfect.
+// }])>
+
+// Pure Private Page System -- pps  <([{
+As I've referred in previous section, perfectly applying my idea need to unroot
+page-surrounging swap subsystem to migrate it on VMA, but a huge gap has
+defeated me -- active_list and inactive_list. In fact, you can find
+lru_add_active code anywhere ... It's IMPOSSIBLE to me to complete it only by
+myself. It's also the difference between my design and Linux, in my OS, page is
+the charge of its new owner totally, however, to Linux, page management system
+is still tracing it by PG_active flag.
+
+So I conceive another solution:) That is, set up an independent page-recycle
+system rooted on Linux legacy page system -- pps, intercept all private pages
+belonging to PrivateVMA to pps, then use my pps to cycle them.  By the way, the
+whole job should be consist of two parts, here is the first --
+PrivateVMA-oriented (PPS), other is SharedVMA-oriented (should be called SPS)
+scheduled in future. Of course, if all are done, it will empty Linux legacy
+page system.
+
+In fact, pps is centered on how to better collect and unmap process private
+pages in SwapDaemon mm/vmscan.c:shrink_private_vma, the whole process is
+divided into six stages -- <Stage Definition>. Other sections show the remain
+aspects of pps
+1) <Data Definition> is basic data definition.
+2) <Concurrent racers of Shrinking pps> is focused on synchronization.
+3) <Private Page Lifecycle of pps> -- how private pages enter in/go off pps.
+4) <VMA Lifecycle of pps> which VMA is belonging to pps.
+
+PPS uses init_mm.mm_list list to enumerate all swappable UserSpace
+(shrink_private_vma).
+
+A new kernel thread -- kppsd is introduced in mm/vmscan.c, its task is to
+execute the stages of pps periodically, note an appropriate timeout ticks is
+necessary so we can give application a chance to re-map back its PrivatePage
+from UnmappedPTE to PTE, that is, show their conglomeration affinity.
+scan_control::pps_cmd field is used to control the behavior of kppsd, = 1 for
+accelerating scanning process and reclaiming pages, it's used in balance_pgdat.
+
+PPS statistic data is appended to /proc/meminfo entry, its prototype is in
+include/linux/mm.h.
+
+I'm also glad to highlight my a new idea -- dftlb which is described in
+section <Delay to Flush TLB>.
+// }])>
+
+// Delay to Flush TLB (dftlb) <([{
+Delay to flush TLB is instroduced by me to enhance flushing TLB efficiency, in
+brief, when we want to unmap a page from the page table of a process, why we
+send TLB IPI to other CPUs immediately, since every CPU has timer interrupt, we
+can insert flushing tasks into timer interrupt route to implement a
+free-charged TLB flushing.
+
+The trick is implemented in
+1) TLB flushing task is added in fill_in_tlb_task of mm/vmscan.c.
+2) timer_flush_tlb_tasks of kernel/timer.c is used by other CPUs to execute
+   flushing tasks.
+3) all data are defined in include/linux/mm.h.
+
+The restriction of dftlb. Following conditions must be met
+1) atomic cmpxchg instruction.
+2) atomically set the access bit after they touch a pte firstly.
+3) To some architectures, vma parameter of flush_tlb_range is maybe important,
+   if it's true, since it's possible that the vma of a TLB flushing task has
+   gone when a CPU starts to execute the task in timer interrupt, so don't use
+   dftlb.
+combine stage 1 with stage 2, and send IPI immediately in fill_in_tlb_tasks.
+
+dftlb increases mm_struct::mm_users to prevent the mm from being freed when
+other CPU works on it.
+// }])>
+
+// Stage Definition <([{
+The whole process of private page page-out is divided into six stages, as
+showed in shrink_pvma_scan_ptes of mm/vmscan.c, the code groups the similar
+pages to a series.
+1) PTE to untouched PTE (access bit is cleared), append flushing
tasks to dftlb.
+2) Convert untouched PTE to UnmappedPTE.
+3) Link SwapEntry to every UnmappedPTE.
+4) Flush PrivatePage of UnmappedPTE to its disk SwapPage.
+5) Reclaimed the page and shift UnmappedPTE to SwappedPTE.
+6) SwappedPTE stage.
+// }])>
+
+// Data Definition <([{
+New VMA flag (VM_PURE_PRIVATE) is appended into VMA in include/linux/mm.h.
+
+New PTE type (UnmappedPTE) is appended into PTE system in
+include/asm-i386/pgtable.h. Its prototype is
+struct UnmappedPTE {
+    int present : 1; // must be 0.
+    ...
+    int pageNum : 20;
+};
+The new PTE has a feature, it keeps a link to its PrivatePage and prevent the
+page from being visited by CPU, so you can use it in <Stage Definition> as a
+middleware.
+// }])>
+
+// Concurrent Racers of Shrinking pps <([{
+shrink_private_vma of mm/vmscan.c uses init_mm.mmlist to scan all swappable
+mm_struct instances, during the process of scaning and reclaiming process, it
+readlockes every mm_struct object, which brings some potential concurrent
+racers
+1) mm/swapfile.c    pps_swapoff (swapoff API).
+2) mm/memory.c  do_wp_page, handle_pte_fault::unmapped_pte, do_anonymous_page
+   (page-fault).
+
+The VMAs of pps can coexist with madvise, mlock, mprotect, mmap and munmap,
+that is why new VMA created from mmap.c:split_vma can re-enter into pps.
+// }])>
+
+// Private Page Lifecycle of pps <([{
+All pages belonging to pps are called as pure private page, its PTE type is PTE
+or UnmappedPTE.
+
+IN (NOTE, when a pure private page enters into pps, it's also trimmed from
+Linux legacy page system by commeting lru_cache_add_active clause)
+1) fs/exec.c	install_arg_pages	(argument pages).
+2) mm/memory	do_anonymous_page, do_wp_page, do_swap_page	(page fault).
+3) mm/swap_state.c	read_swap_cache_async	(swap pages).
+
+OUT
+1) mm/vmscan.c  shrink_pvma_scan_ptes   (stage 6, reclaim a private page).
+2) mm/memory    zap_pte_range   (free a page).
+3) kernel/fork.c	dup_mmap	(if someone uses fork, migrate all pps pages
+   back to let Linux legacy page system manage them).
+
+When a pure private page is in pps, it can be visited simultaneously by
+page-fault and SwapDaemon.
+// }])>
+
+// VMA Lifecycle of pps <([{
+When a PrivateVMA enters into pps, it's or-ed a new flag -- VM_PURE_PRIVATE in
+memory.c:enter_pps, you can also find which VMA is fit with pps in it, the flag
+is used in the shrink_private_vma of mm/vmscan.c.  Other fields are left
+untouched.
+
+IN.
+1) fs/exec.c	setup_arg_pages	(StackVMA).
+2) mm/mmap.c	do_mmap_pgoff, do_brk	(DataVMA).
+3) mm/mmap.c	split_vma, copy_vma	(in some cases, we need copy a VMA from an
+   exist VMA).
+
+OUT.
+1) kernel/fork.c	dup_mmap	(if someone uses fork, return the vma back to
+   Linux legacy system).
+2) mm/mmap.c	remove_vma, vma_adjust	(destroy VMA).
+3) mm/mmap.c	do_mmap_pgoff	(delete VMA when some errors occur).
+// }])>
+
+// Postscript <([{
+Note, some circumstances aren't tested due to hardware restriction e.g. SMP
+dftlb.
+
+Here are some improvements about pps
+1) In fact, I recommend one-to-one private model -- PrivateVMA, (PTE,
+   UnmappedPTE) and PrivatePage (SwapPage) which is described in my OS and the
+   aboved hyperlink of Linux kernel mail list. So it's a compromise to use
+   Linux legacy SwapCache in my pps.
+2) SwapSpace should provide more flexible interfaces, shrink_pvma_scan_ptes
+   need allocate swap entries in batch, exactly, allocate a batch of fake
+   continual swap entries, see mm/pps_swapin_readahead.
+
+If Linux kernel group can't make a schedule to re-write their memory code,
+however, pps maybe is the best solution until now.
+// }])>
+// vim: foldmarker=<([{,}])> foldmethod=marker et
Index: linux-2.6.16.29/fs/exec.c
===================================================================
--- linux-2.6.16.29.orig/fs/exec.c	2007-01-11 10:43:44.293976232 +0800
+++ linux-2.6.16.29/fs/exec.c	2007-01-11 10:51:15.576880752 +0800
@@ -320,8 +320,9 @@
 		pte_unmap_unlock(pte, ptl);
 		goto out;
 	}
+	atomic_inc(&pps_info.total);
+	atomic_inc(&pps_info.pte_count);
 	inc_mm_counter(mm, anon_rss);
-	lru_cache_add_active(page);
 	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
 	page_add_new_anon_rmap(page, vma, address);
@@ -436,6 +437,7 @@
 			kmem_cache_free(vm_area_cachep, mpnt);
 			return ret;
 		}
+		enter_pps(mm, mpnt);
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	}

Index: linux-2.6.16.29/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.16.29.orig/fs/proc/proc_misc.c	2007-01-11 10:43:44.104005112 +0800
+++ linux-2.6.16.29/fs/proc/proc_misc.c	2007-01-11 10:51:15.568881968 +0800
@@ -174,7 +174,11 @@
 		"PageTables:   %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
 		"VmallocUsed:  %8lu kB\n"
-		"VmallocChunk: %8lu kB\n",
+		"VmallocChunk: %8lu kB\n"
+		"PPS Total:    %8d kB\n"
+		"PPS PTE:      %8d kB\n"
+		"PPS Unmapped: %8d kB\n"
+		"PPS Swapped:  %8d kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.bufferram),
@@ -197,7 +201,11 @@
 		K(ps.nr_page_table_pages),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
-		vmi.largest_chunk >> 10
+		vmi.largest_chunk >> 10,
+		K(pps_info.total.counter),
+		K(pps_info.pte_count.counter),
+		K(pps_info.unmapped_count.counter),
+		K(pps_info.swapped_count.counter)
 		);

 		len += hugetlb_report_meminfo(page + len);
Index: linux-2.6.16.29/include/asm-i386/mmu_context.h
===================================================================
--- linux-2.6.16.29.orig/include/asm-i386/mmu_context.h	2007-01-11
10:43:47.095550328 +0800
+++ linux-2.6.16.29/include/asm-i386/mmu_context.h	2007-01-11
10:51:15.669866616 +0800
@@ -33,6 +33,9 @@
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
 #ifdef CONFIG_SMP
+		// vmscan.c::end_tlb_tasks maybe had copied cpu_vm_mask before we leave
+		// prev, so let's flush the trace of prev of delay_tlb_tasks.
+		timer_flush_tlb_tasks(NULL);
 		per_cpu(cpu_tlbstate, cpu).state = TLBSTATE_OK;
 		per_cpu(cpu_tlbstate, cpu).active_mm = next;
 #endif
Index: linux-2.6.16.29/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.16.29.orig/include/asm-i386/pgtable-2level.h	2007-01-11
10:43:47.285521448 +0800
+++ linux-2.6.16.29/include/asm-i386/pgtable-2level.h	2007-01-11
10:51:15.675865704 +0800
@@ -46,21 +46,21 @@
 }

 /*
- * Bits 0, 6 and 7 are taken, split up the 29 bits of offset
+ * Bits 0, 5, 6 and 7 are taken, split up the 28 bits of offset
  * into this range:
  */
-#define PTE_FILE_MAX_BITS	29
+#define PTE_FILE_MAX_BITS	28

 #define pte_to_pgoff(pte) \
-	((((pte).pte_low >> 1) & 0x1f ) + (((pte).pte_low >> 8) << 5 ))
+	((((pte).pte_low >> 1) & 0xf ) + (((pte).pte_low >> 8) << 4 ))

 #define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x1f) << 1) + (((off) >> 5) << 8) + _PAGE_FILE })
+	((pte_t) { (((off) & 0xf) << 1) + (((off) >> 4) << 8) + _PAGE_FILE })

 /* Encode and de-code a swap entry */
-#define __swp_type(x)			(((x).val >> 1) & 0x1f)
+#define __swp_type(x)			(((x).val >> 1) & 0xf)
 #define __swp_offset(x)			((x).val >> 8)
-#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) |
((offset) << 8) })
+#define __swp_entry(type, offset)	((swp_entry_t) { ((type & 0xf) <<
1) | ((offset) << 8) | _PAGE_SWAPPED })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })

Index: linux-2.6.16.29/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.16.29.orig/include/asm-i386/pgtable.h	2007-01-11
10:43:47.478492112 +0800
+++ linux-2.6.16.29/include/asm-i386/pgtable.h	2007-01-11
10:51:15.682864640 +0800
@@ -121,7 +121,11 @@
 #define _PAGE_UNUSED3	0x800

 /* If _PAGE_PRESENT is clear, we use these: */
-#define _PAGE_FILE	0x040	/* nonlinear file mapping, saved PTE; unset:swap */
+#define _PAGE_UNMAPPED	0x020	/* a special PTE type, hold its page reference
+								   even it's unmapped, see more from
+								   Documentation/vm_pps.txt. */
+#define _PAGE_SWAPPED 0x040 /* swapped PTE. */
+#define _PAGE_FILE	0x060	/* nonlinear file mapping, saved PTE; */
 #define _PAGE_PROTNONE	0x080	/* if the user mapped it with PROT_NONE;
 				   pte_present gives true */
 #ifdef CONFIG_X86_PAE
@@ -228,7 +232,9 @@
 /*
  * The following only works if pte_present() is not true.
  */
-static inline int pte_file(pte_t pte)		{ return (pte).pte_low & _PAGE_FILE; }
+static inline int pte_unmapped(pte_t pte)	{ return ((pte).pte_low &
0x60) == _PAGE_UNMAPPED; }
+static inline int pte_swapped(pte_t pte)	{ return ((pte).pte_low &
0x60) == _PAGE_SWAPPED; }
+static inline int pte_file(pte_t pte)		{ return ((pte).pte_low &
0x60) == _PAGE_FILE; }

 static inline pte_t pte_rdprotect(pte_t pte)	{ (pte).pte_low &=
~_PAGE_USER; return pte; }
 static inline pte_t pte_exprotect(pte_t pte)	{ (pte).pte_low &=
~_PAGE_USER; return pte; }
Index: linux-2.6.16.29/include/linux/mm.h
===================================================================
--- linux-2.6.16.29.orig/include/linux/mm.h	2007-01-11 10:43:46.652617664 +0800
+++ linux-2.6.16.29/include/linux/mm.h	2007-01-11 10:51:15.656868592 +0800
@@ -166,6 +166,8 @@
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had
"vm_insert_page()" done on it */
+#define VM_PURE_PRIVATE	0x04000000	/* Is the vma is only belonging to a mm,
+									   see more from Documentation/vm_pps.txt */

 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
@@ -1056,5 +1058,33 @@
 extern int randomize_va_space;
 #endif

+struct pps_info {
+	atomic_t total;
+	atomic_t pte_count; // stage 1 and 2.
+	atomic_t unmapped_count; // stage 3 and 4.
+	atomic_t swapped_count; // stage 6.
+};
+extern struct pps_info pps_info;
+
+/* vmscan.c::delay flush TLB */
+struct delay_tlb_task
+{
+	struct mm_struct* mm;
+	cpumask_t cpu_mask;
+	struct vm_area_struct* vma[32];
+	unsigned long start[32];
+	unsigned long end[32];
+};
+extern struct delay_tlb_task delay_tlb_tasks[32];
+
+// The prototype of the function is fit with the "func" of "int
+// smp_call_function (void (*func) (void *info), void *info, int retry, int
+// wait);" of include/linux/smp.h of 2.6.16.29. Call it with NULL.
+void timer_flush_tlb_tasks(void* data /* = NULL */);
+
+void enter_pps(struct mm_struct* mm, struct vm_area_struct* vma);
+void leave_pps(struct vm_area_struct* vma, int migrate_flag);
+
+#define MAX_SERIES_LENGTH 8
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
Index: linux-2.6.16.29/include/linux/swapops.h
===================================================================
--- linux-2.6.16.29.orig/include/linux/swapops.h	2007-01-11
10:43:46.866585136 +0800
+++ linux-2.6.16.29/include/linux/swapops.h	2007-01-11 10:51:15.663867528 +0800
@@ -50,7 +50,7 @@
 {
 	swp_entry_t arch_entry;

-	BUG_ON(pte_file(pte));
+	BUG_ON(!pte_swapped(pte));
 	arch_entry = __pte_to_swp_entry(pte);
 	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
@@ -64,6 +64,6 @@
 	swp_entry_t arch_entry;

 	arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
-	BUG_ON(pte_file(__swp_entry_to_pte(arch_entry)));
+	BUG_ON(!pte_swapped(__swp_entry_to_pte(arch_entry)));
 	return __swp_entry_to_pte(arch_entry);
 }
Index: linux-2.6.16.29/kernel/fork.c
===================================================================
--- linux-2.6.16.29.orig/kernel/fork.c	2007-01-11 10:43:46.294672080 +0800
+++ linux-2.6.16.29/kernel/fork.c	2007-01-11 10:51:15.643870568 +0800
@@ -229,6 +229,7 @@
 		tmp = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
 			goto fail_nomem;
+		leave_pps(mpnt, 1);
 		*tmp = *mpnt;
 		pol = mpol_copy(vma_policy(mpnt));
 		retval = PTR_ERR(pol);
Index: linux-2.6.16.29/kernel/timer.c
===================================================================
--- linux-2.6.16.29.orig/kernel/timer.c	2007-01-11 10:43:46.091702936 +0800
+++ linux-2.6.16.29/kernel/timer.c	2007-01-11 10:51:15.635871784 +0800
@@ -842,6 +842,10 @@
 		rcu_check_callbacks(cpu, user_tick);
 	scheduler_tick();
  	run_posix_cpu_timers(p);
+
+#ifdef SMP
+	timer_flush_tlb_tasks(NULL);
+#endif
 }

 /*
Index: linux-2.6.16.29/mm/fremap.c
===================================================================
--- linux-2.6.16.29.orig/mm/fremap.c	2007-01-11 10:43:44.883886552 +0800
+++ linux-2.6.16.29/mm/fremap.c	2007-01-11 10:51:15.596877712 +0800
@@ -37,7 +37,7 @@
 			page_cache_release(page);
 		}
 	} else {
-		if (!pte_file(pte))
+		if (pte_swapped(pte))
 			free_swap_and_cache(pte_to_swp_entry(pte));
 		pte_clear(mm, addr, ptep);
 	}
Index: linux-2.6.16.29/mm/memory.c
===================================================================
--- linux-2.6.16.29.orig/mm/memory.c	2007-01-11 10:43:45.689764040 +0800
+++ linux-2.6.16.29/mm/memory.c	2007-01-11 10:51:15.627873000 +0800
@@ -436,7 +436,7 @@

 	/* pte contains position in swap or file, so copy. */
 	if (unlikely(!pte_present(pte))) {
-		if (!pte_file(pte)) {
+		if (pte_swapped(pte)) {
 			swap_duplicate(pte_to_swp_entry(pte));
 			/* make sure dst_mm is on swapoff's mmlist. */
 			if (unlikely(list_empty(&dst_mm->mmlist))) {
@@ -615,6 +615,9 @@
 	spinlock_t *ptl;
 	int file_rss = 0;
 	int anon_rss = 0;
+	int pps_pte = 0;
+	int pps_unmapped = 0;
+	int pps_swapped = 0;

 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
@@ -658,6 +661,13 @@
 						addr) != page->index)
 				set_pte_at(mm, addr, pte,
 					   pgoff_to_pte(page->index));
+			if (vma->vm_flags & VM_PURE_PRIVATE) {
+				if (page != ZERO_PAGE(addr)) {
+					if (PageWriteback(page))
+						lru_cache_add_active(page);
+					pps_pte++;
+				}
+			}
 			if (PageAnon(page))
 				anon_rss--;
 			else {
@@ -677,12 +687,31 @@
 		 */
 		if (unlikely(details))
 			continue;
-		if (!pte_file(ptent))
+		if (pte_unmapped(ptent)) {
+			struct page *page;
+			page = pfn_to_page(pte_pfn(ptent));
+			BUG_ON(page == ZERO_PAGE(addr));
+			if (PageWriteback(page))
+				lru_cache_add_active(page);
+			pps_unmapped++;
+			pte_clear_full(mm, addr, pte, tlb->fullmm);
+			tlb_remove_page(tlb, page);
+			anon_rss--;
+			continue;
+		}
+		if (pte_swapped(ptent)) {
+			if (vma->vm_flags & VM_PURE_PRIVATE)
+				pps_swapped++;
 			free_swap_and_cache(pte_to_swp_entry(ptent));
+		}
 		pte_clear_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));

 	add_mm_rss(mm, file_rss, anon_rss);
+	atomic_sub(pps_pte + pps_unmapped, &pps_info.total);
+	atomic_sub(pps_pte, &pps_info.pte_count);
+	atomic_sub(pps_unmapped, &pps_info.unmapped_count);
+	atomic_sub(pps_swapped, &pps_info.swapped_count);
 	pte_unmap_unlock(pte - 1, ptl);

 	return addr;
@@ -1508,7 +1537,12 @@
 		ptep_establish(vma, address, page_table, entry);
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
-		lru_cache_add_active(new_page);
+		if (!(vma->vm_flags & VM_PURE_PRIVATE))
+			lru_cache_add_active(new_page);
+		else {
+			atomic_inc(&pps_info.total);
+			atomic_inc(&pps_info.pte_count);
+		}
 		page_add_new_anon_rmap(new_page, vma, address);

 		/* Free the old page.. */
@@ -1864,6 +1898,84 @@
 }

 /*
+ * New read ahead code, mainly for VM_PURE_PRIVATE only.
+ */
+static void pps_swapin_readahead(swp_entry_t entry, unsigned long
addr,struct vm_area_struct *vma, pte_t* pte, pmd_t* pmd)
+{
+	struct page* page;
+	pte_t *prev, *next;
+	swp_entry_t temp;
+	spinlock_t* ptl = pte_lockptr(vma->vm_mm, pmd);
+	int swapType = swp_type(entry);
+	int swapOffset = swp_offset(entry);
+	int readahead = 1, abs;
+
+	if (!(vma->vm_flags & VM_PURE_PRIVATE)) {
+		swapin_readahead(entry, addr, vma);
+		return;
+	}
+
+	page = read_swap_cache_async(entry, vma, addr);
+	if (!page)
+		return;
+	page_cache_release(page);
+
+	// read ahead the whole series, first forward then backward.
+	while (readahead < MAX_SERIES_LENGTH) {
+		next = pte++;
+		if (next - (pte_t*) pmd >= PTRS_PER_PTE)
+			break;
+		spin_lock(ptl);
+        if (!(!pte_present(*next) && pte_swapped(*next))) {
+			spin_unlock(ptl);
+			break;
+		}
+		temp = pte_to_swp_entry(*next);
+		spin_unlock(ptl);
+		if (swp_type(temp) != swapType)
+			break;
+		abs = swp_offset(temp) - swapOffset;
+		abs = abs < 0 ? -abs : abs;
+		swapOffset = swp_offset(temp);
+		if (abs > 8)
+			// the two swap entries are too far, give up!
+			break;
+		page = read_swap_cache_async(temp, vma, addr);
+		if (!page)
+			return;
+		page_cache_release(page);
+		readahead++;
+	}
+
+	swapOffset = swp_offset(entry);
+	while (readahead < MAX_SERIES_LENGTH) {
+		prev = pte--;
+		if (prev - (pte_t*) pmd < 0)
+			break;
+		spin_lock(ptl);
+        if (!(!pte_present(*prev) && pte_swapped(*prev))) {
+			spin_unlock(ptl);
+			break;
+		}
+		temp = pte_to_swp_entry(*prev);
+		spin_unlock(ptl);
+		if (swp_type(temp) != swapType)
+			break;
+		abs = swp_offset(temp) - swapOffset;
+		abs = abs < 0 ? -abs : abs;
+		swapOffset = swp_offset(temp);
+		if (abs > 8)
+			// the two swap entries are too far, give up!
+			break;
+		page = read_swap_cache_async(temp, vma, addr);
+		if (!page)
+			return;
+		page_cache_release(page);
+		readahead++;
+	}
+}
+
+/*
  * We enter with non-exclusive mmap_sem (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
  * We return with mmap_sem still held, but pte unmapped and unlocked.
@@ -1885,7 +1997,7 @@
 again:
 	page = lookup_swap_cache(entry);
 	if (!page) {
- 		swapin_readahead(entry, address, vma);
+ 		pps_swapin_readahead(entry, address, vma, page_table, pmd);
  		page = read_swap_cache_async(entry, vma, address);
 		if (!page) {
 			/*
@@ -1904,10 +2016,15 @@
 		grab_swap_token();
 	}

-	mark_page_accessed(page);
+	if (!(vma->vm_flags & VM_PURE_PRIVATE))
+		mark_page_accessed(page);
 	lock_page(page);
 	if (!PageSwapCache(page)) {
 		/* Page migration has occured */
+		if (vma->vm_flags & VM_PURE_PRIVATE) {
+			lru_cache_add_active(page);
+			mark_page_accessed(page);
+		}
 		unlock_page(page);
 		page_cache_release(page);
 		goto again;
@@ -1922,6 +2039,10 @@

 	if (unlikely(!PageUptodate(page))) {
 		ret = VM_FAULT_SIGBUS;
+		if (vma->vm_flags & VM_PURE_PRIVATE) {
+			lru_cache_add_active(page);
+			mark_page_accessed(page);
+		}
 		goto out_nomap;
 	}

@@ -1942,6 +2063,11 @@
 	if (vm_swap_full())
 		remove_exclusive_swap_page(page);
 	unlock_page(page);
+	if (vma->vm_flags & VM_PURE_PRIVATE) {
+		atomic_dec(&pps_info.swapped_count);
+		atomic_inc(&pps_info.total);
+		atomic_inc(&pps_info.pte_count);
+	}

 	if (write_access) {
 		if (do_wp_page(mm, vma, address,
@@ -1993,8 +2119,13 @@
 		page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 		if (!pte_none(*page_table))
 			goto release;
+		if (!(vma->vm_flags & VM_PURE_PRIVATE))
+			lru_cache_add_active(page);
+		else {
+			atomic_inc(&pps_info.total);
+			atomic_inc(&pps_info.pte_count);
+		}
 		inc_mm_counter(mm, anon_rss);
-		lru_cache_add_active(page);
 		page_add_new_anon_rmap(page, vma, address);
 	} else {
 		/* Map the ZERO_PAGE - vm_page_prot is readonly */
@@ -2209,6 +2340,22 @@

 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
+		if (pte_unmapped(entry)) {
+			BUG_ON(!(vma->vm_flags & VM_PURE_PRIVATE));
+			atomic_dec(&pps_info.unmapped_count);
+			atomic_inc(&pps_info.pte_count);
+			struct page* page = pte_page(entry);
+			pte_t temp_pte = mk_pte(page, vma->vm_page_prot);
+			pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+			if (unlikely(pte_same(*pte, entry))) {
+				page_add_new_anon_rmap(page, vma, address);
+				set_pte_at(mm, address, pte, temp_pte);
+				update_mmu_cache(vma, address, temp_pte);
+				lazy_mmu_prot_update(temp_pte);
+			}
+			pte_unmap_unlock(pte, ptl);
+			return VM_FAULT_MINOR;
+		}
 		if (pte_none(entry)) {
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
 				return do_anonymous_page(mm, vma, address,
@@ -2445,3 +2592,118 @@
 }

 #endif	/* __HAVE_ARCH_GATE_AREA */
+
+static void migrate_back_pte_range(struct mm_struct* mm, pmd_t *pmd, struct
+		vm_area_struct *vma, unsigned long addr, unsigned long end)
+{
+	struct page* page;
+	pte_t entry;
+	pte_t *pte;
+	spinlock_t* ptl;
+	int pps_pte = 0;
+	int pps_unmapped = 0;
+	int pps_swapped = 0;
+
+	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	do {
+		if (!pte_present(*pte) && pte_unmapped(*pte)) {
+			page = pte_page(*pte);
+			entry = mk_pte(page, vma->vm_page_prot);
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+			set_pte_at(mm, addr, pte, entry);
+			BUG_ON(page == ZERO_PAGE(addr));
+			page_add_new_anon_rmap(page, vma, addr);
+			lru_cache_add_active(page);
+			pps_unmapped++;
+		} else if (pte_present(*pte)) {
+			page = pte_page(*pte);
+			if (page == ZERO_PAGE(addr))
+				continue;
+			lru_cache_add_active(page);
+			pps_pte++;
+		} else if (!pte_present(*pte) && pte_swapped(*pte))
+			pps_swapped++;
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap_unlock(pte - 1, ptl);
+	lru_add_drain();
+	atomic_sub(pps_pte + pps_unmapped, &pps_info.total);
+	atomic_sub(pps_pte, &pps_info.pte_count);
+	atomic_sub(pps_unmapped, &pps_info.unmapped_count);
+	atomic_sub(pps_swapped, &pps_info.swapped_count);
+}
+
+static void migrate_back_pmd_range(struct mm_struct* mm, pud_t *pud, struct
+		vm_area_struct *vma, unsigned long addr, unsigned long end)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		migrate_back_pte_range(mm, pmd, vma, addr, next);
+	} while (pmd++, addr = next, addr != end);
+}
+
+static void migrate_back_pud_range(struct mm_struct* mm, pgd_t *pgd, struct
+		vm_area_struct *vma, unsigned long addr, unsigned long end)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		migrate_back_pmd_range(mm, pud, vma, addr, next);
+	} while (pud++, addr = next, addr != end);
+}
+
+// migrate all pages of pure private vma back to Linux legacy memory
management.
+static void migrate_back_legacy_linux(struct mm_struct* mm, struct
vm_area_struct* vma)
+{
+	pgd_t* pgd;
+	unsigned long next;
+	unsigned long addr = vma->vm_start;
+	unsigned long end = vma->vm_end;
+
+	pgd = pgd_offset(mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		migrate_back_pud_range(mm, pgd, vma, addr, next);
+	} while (pgd++, addr = next, addr != end);
+}
+
+void enter_pps(struct mm_struct* mm, struct vm_area_struct* vma)
+{
+	int condition = VM_READ | VM_WRITE | VM_EXEC | \
+		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC | \
+		 VM_GROWSDOWN | VM_GROWSUP | \
+		 VM_LOCKED | VM_SEQ_READ | VM_RAND_READ | VM_DONTCOPY | VM_ACCOUNT | \
+		 VM_PURE_PRIVATE;
+	if (!(vma->vm_flags & ~condition) && vma->vm_file == NULL) {
+		vma->vm_flags |= VM_PURE_PRIVATE;
+		if (list_empty(&mm->mmlist)) {
+			spin_lock(&mmlist_lock);
+			if (list_empty(&mm->mmlist))
+				list_add(&mm->mmlist, &init_mm.mmlist);
+			spin_unlock(&mmlist_lock);
+		}
+	}
+}
+
+void leave_pps(struct vm_area_struct* vma, int migrate_flag)
+{
+	struct mm_struct* mm = vma->vm_mm;
+
+	if (vma->vm_flags & VM_PURE_PRIVATE) {
+		vma->vm_flags &= ~VM_PURE_PRIVATE;
+		if (migrate_flag)
+			migrate_back_legacy_linux(mm, vma);
+	}
+}
Index: linux-2.6.16.29/mm/mmap.c
===================================================================
--- linux-2.6.16.29.orig/mm/mmap.c	2007-01-11 10:43:44.685916648 +0800
+++ linux-2.6.16.29/mm/mmap.c	2007-01-11 10:51:15.589878776 +0800
@@ -206,6 +206,7 @@
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_free(vma_policy(vma));
+	leave_pps(vma, 0);
 	kmem_cache_free(vm_area_cachep, vma);
 	return next;
 }
@@ -593,6 +594,7 @@
 			fput(file);
 		mm->map_count--;
 		mpol_free(vma_policy(next));
+		leave_pps(next, 0);
 		kmem_cache_free(vm_area_cachep, next);
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
@@ -1091,6 +1093,8 @@
 	if ((vm_flags & (VM_SHARED|VM_ACCOUNT)) == (VM_SHARED|VM_ACCOUNT))
 		vma->vm_flags &= ~VM_ACCOUNT;

+	enter_pps(mm, vma);
+
 	/* Can addr have changed??
 	 *
 	 * Answer: Yes, several device drivers can do it in their
@@ -1113,6 +1117,7 @@
 			fput(file);
 		}
 		mpol_free(vma_policy(vma));
+		leave_pps(vma, 0);
 		kmem_cache_free(vm_area_cachep, vma);
 	}
 out:	
@@ -1140,6 +1145,7 @@
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
 	charged = 0;
 free_vma:
+	leave_pps(vma, 0);
 	kmem_cache_free(vm_area_cachep, vma);
 unacct_error:
 	if (charged)
@@ -1717,6 +1723,10 @@

 	/* most fields are the same, copy all, and then fixup */
 	*new = *vma;
+	if (new->vm_flags & VM_PURE_PRIVATE) {
+		new->vm_flags &= ~VM_PURE_PRIVATE;
+		enter_pps(mm, new);
+	}

 	if (new_below)
 		new->vm_end = addr;
@@ -1917,6 +1927,7 @@
 	vma->vm_pgoff = pgoff;
 	vma->vm_flags = flags;
 	vma->vm_page_prot = protection_map[flags & 0x0f];
+	enter_pps(mm, vma);
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 out:
 	mm->total_vm += len >> PAGE_SHIFT;
@@ -2040,6 +2051,10 @@
 				get_file(new_vma->vm_file);
 			if (new_vma->vm_ops && new_vma->vm_ops->open)
 				new_vma->vm_ops->open(new_vma);
+			if (new_vma->vm_flags & VM_PURE_PRIVATE) {
+				new_vma->vm_flags &= ~VM_PURE_PRIVATE;
+				enter_pps(mm, new_vma);
+			}
 			vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		}
 	}
Index: linux-2.6.16.29/mm/rmap.c
===================================================================
--- linux-2.6.16.29.orig/mm/rmap.c	2007-01-11 10:43:45.083856152 +0800
+++ linux-2.6.16.29/mm/rmap.c	2007-01-11 10:51:15.604876496 +0800
@@ -633,7 +633,7 @@
 			spin_unlock(&mmlist_lock);
 		}
 		set_pte_at(mm, address, pte, swp_entry_to_pte(entry));
-		BUG_ON(pte_file(*pte));
+		BUG_ON(!pte_swapped(*pte));
 		dec_mm_counter(mm, anon_rss);
 	} else
 		dec_mm_counter(mm, file_rss);
Index: linux-2.6.16.29/mm/swap_state.c
===================================================================
--- linux-2.6.16.29.orig/mm/swap_state.c	2007-01-11 10:43:44.484947200 +0800
+++ linux-2.6.16.29/mm/swap_state.c	2007-01-11 10:51:15.582879840 +0800
@@ -354,7 +354,8 @@
 			/*
 			 * Initiate read into locked page and return.
 			 */
-			lru_cache_add_active(new_page);
+			if (vma == NULL || !(vma->vm_flags & VM_PURE_PRIVATE))
+				lru_cache_add_active(new_page);
 			swap_readpage(NULL, new_page);
 			return new_page;
 		}
Index: linux-2.6.16.29/mm/swapfile.c
===================================================================
--- linux-2.6.16.29.orig/mm/swapfile.c	2007-01-11 10:43:45.490794288 +0800
+++ linux-2.6.16.29/mm/swapfile.c	2007-01-11 10:51:15.619874216 +0800
@@ -7,6 +7,7 @@

 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
@@ -417,6 +418,166 @@
 	}
 }

+static int pps_test_swap_type(struct mm_struct* mm, pmd_t* pmd, pte_t* pte, int
+		type, struct page** ret_page)
+{
+	spinlock_t* ptl = pte_lockptr(mm, pmd);
+	swp_entry_t entry;
+	struct page* page;
+
+	spin_lock(ptl);
+	if (!pte_present(*pte) && pte_swapped(*pte)) {
+		entry = pte_to_swp_entry(*pte);
+		if (swp_type(entry) == type) {
+			*ret_page = NULL;
+			spin_unlock(ptl);
+			return 1;
+		}
+	} else {
+		page = pfn_to_page(pte_pfn(*pte));
+		if (PageSwapCache(page)) {
+			entry.val = page_private(page);
+			if (swp_type(entry) == type) {
+				page_cache_get(page);
+				*ret_page = page;
+				spin_unlock(ptl);
+				return 1;
+			}
+		}
+	}
+	spin_unlock(ptl);
+	return 0;
+}
+
+static int pps_swapoff_scan_ptes(struct mm_struct* mm, struct vm_area_struct*
+		vma, pmd_t* pmd, unsigned long addr, unsigned long end, int type)
+{
+	pte_t *pte;
+	struct page* page;
+
+	pte = pte_offset_map(pmd, addr);
+	do {
+		while (pps_test_swap_type(mm, pmd, pte, type, &page)) {
+			if (page == NULL) {
+				switch (__handle_mm_fault(mm, vma, addr, 0)) {
+				case VM_FAULT_SIGBUS:
+				case VM_FAULT_OOM:
+					return -ENOMEM;
+				case VM_FAULT_MINOR:
+				case VM_FAULT_MAJOR:
+					break;
+				default:
+					BUG();
+				}
+			} else {
+				wait_on_page_locked(page);
+				wait_on_page_writeback(page);
+				lock_page(page);
+				if (!PageSwapCache(page)) {
+					unlock_page(page);
+					page_cache_release(page);
+					break;
+				}
+				wait_on_page_writeback(page);
+				delete_from_swap_cache(page);
+				unlock_page(page);
+				page_cache_release(page);
+				break;
+			}
+		}
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	return 0;
+}
+
+static int pps_swapoff_pmd_range(struct mm_struct* mm, struct vm_area_struct*
+		vma, pud_t* pud, unsigned long addr, unsigned long end, int type)
+{
+	unsigned long next;
+	int ret;
+	pmd_t* pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		ret = pps_swapoff_scan_ptes(mm, vma, pmd, addr, next, type);
+		if (ret == -ENOMEM)
+			return ret;
+	} while (pmd++, addr = next, addr != end);
+	return 0;
+}
+
+static int pps_swapoff_pud_range(struct mm_struct* mm, struct vm_area_struct*
+		vma, pgd_t* pgd, unsigned long addr, unsigned long end, int type)
+{
+	unsigned long next;
+	int ret;
+	pud_t* pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		ret = pps_swapoff_pmd_range(mm, vma, pud, addr, next, type);
+		if (ret == -ENOMEM)
+			return ret;
+	} while (pud++, addr = next, addr != end);
+	return 0;
+}
+
+static int pps_swapoff_pgd_range(struct mm_struct* mm, struct vm_area_struct*
+		vma, int type)
+{
+	unsigned long next;
+	unsigned long addr = vma->vm_start;
+	unsigned long end = vma->vm_end;
+	int ret;
+	pgd_t* pgd = pgd_offset(mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		ret = pps_swapoff_pud_range(mm, vma, pgd, addr, next, type);
+		if (ret == -ENOMEM)
+			return ret;
+	} while (pgd++, addr = next, addr != end);
+	return 0;
+}
+
+static int pps_swapoff(int type)
+{
+	struct vm_area_struct* vma;
+	struct list_head *pos;
+	struct mm_struct *prev, *mm;
+	int ret = 0;
+
+	prev = mm = &init_mm;
+	pos = &init_mm.mmlist;
+	atomic_inc(&prev->mm_users);
+	spin_lock(&mmlist_lock);
+	while ((pos = pos->next) != &init_mm.mmlist) {
+		mm = list_entry(pos, struct mm_struct, mmlist);
+		if (!atomic_add_unless(&mm->mm_users, 1, 0))
+			continue;
+		spin_unlock(&mmlist_lock);
+		mmput(prev);
+		prev = mm;
+		down_read(&mm->mmap_sem);
+		for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
+			if (!(vma->vm_flags & VM_PURE_PRIVATE))
+				continue;
+			if (vma->vm_flags & VM_LOCKED)
+				continue;
+			ret = pps_swapoff_pgd_range(mm, vma, type);
+			if (ret == -ENOMEM)
+				break;
+		}
+		up_read(&mm->mmap_sem);
+		spin_lock(&mmlist_lock);
+	}
+	spin_unlock(&mmlist_lock);
+	mmput(prev);
+	return ret;
+}
+
 /*
  * No need to decide whether this PTE shares the swap entry with others,
  * just let do_wp_page work it out if a write is requested later - to
@@ -619,6 +780,12 @@
 	int reset_overflow = 0;
 	int shmem;

+	// Let's first read all pps pages back! Note, it's one-to-one mapping.
+	retval = pps_swapoff(type);
+	if (retval == -ENOMEM) // something was wrong.
+		return -ENOMEM;
+	// Now, the remain pages are shared pages, go ahead!
+
 	/*
 	 * When searching mms for an entry, a good strategy is to
 	 * start at the first mm we freed the previous entry from
@@ -848,16 +1015,20 @@
  */
 static void drain_mmlist(void)
 {
-	struct list_head *p, *next;
+	// struct list_head *p, *next;
 	unsigned int i;

 	for (i = 0; i < nr_swapfiles; i++)
 		if (swap_info[i].inuse_pages)
 			return;
+	/*
+	 * Now, init_mm.mmlist list not only is used by SwapDevice but also is used
+	 * by PPS.
 	spin_lock(&mmlist_lock);
 	list_for_each_safe(p, next, &init_mm.mmlist)
 		list_del_init(p);
 	spin_unlock(&mmlist_lock);
+	*/
 }

 /*
Index: linux-2.6.16.29/mm/vmscan.c
===================================================================
--- linux-2.6.16.29.orig/mm/vmscan.c	2007-01-11 10:43:45.288824992 +0800
+++ linux-2.6.16.29/mm/vmscan.c	2007-01-11 10:51:15.611875432 +0800
@@ -79,6 +79,9 @@
 	 * In this context, it doesn't matter that we scan the
 	 * whole list at once. */
 	int swap_cluster_max;
+
+	/* pps control command, 0: do stage 1-4, kppsd only; 1: full stages. */
+	int pps_cmd;
 };

 /*
@@ -1514,6 +1517,428 @@
 	return ret;
 }

+// pps fields.
+static wait_queue_head_t kppsd_wait;
+static struct scan_control wakeup_sc;
+struct pps_info pps_info = {
+	.total = ATOMIC_INIT(0),
+	.pte_count = ATOMIC_INIT(0), // stage 1 and 2.
+	.unmapped_count = ATOMIC_INIT(0), // stage 3 and 4.
+	.swapped_count = ATOMIC_INIT(0) // stage 6.
+};
+// pps end.
+
+struct series_t {
+	pte_t orig_ptes[MAX_SERIES_LENGTH];
+	pte_t* ptes[MAX_SERIES_LENGTH];
+	struct page* pages[MAX_SERIES_LENGTH];
+	int series_length;
+	int series_stage;
+} series;
+
+static int get_series_stage(pte_t* pte, int index)
+{
+	series.orig_ptes[index] = *pte;
+	series.ptes[index] = pte;
+	if (pte_present(series.orig_ptes[index])) {
+		struct page* page = pfn_to_page(pte_pfn(series.orig_ptes[index]));
+		series.pages[index] = page;
+		if (page == ZERO_PAGE(addr)) // reserved page is exclusive from us.
+			return 7;
+		if (pte_young(series.orig_ptes[index])) {
+			return 1;
+		} else
+			return 2;
+	} else if (pte_unmapped(series.orig_ptes[index])) {
+		struct page* page = pfn_to_page(pte_pfn(series.orig_ptes[index]));
+		series.pages[index] = page;
+		if (!PageSwapCache(page))
+			return 3;
+		else {
+			if (PageWriteback(page) || PageDirty(page))
+				return 4;
+			else
+				return 5;
+		}
+	} else // pte_swapped -- SwappedPTE
+		return 6;
+}
+
+static void find_series(pte_t** start, unsigned long* addr, unsigned long end)
+{
+	int i;
+	int series_stage = get_series_stage((*start)++, 0);
+	*addr += PAGE_SIZE;
+
+	for (i = 1; i < MAX_SERIES_LENGTH && *addr < end; i++, (*start)++,
*addr += PAGE_SIZE) {
+		if (series_stage != get_series_stage(*start, i))
+			break;
+	}
+	series.series_stage = series_stage;
+	series.series_length = i;
+}
+
+struct delay_tlb_task delay_tlb_tasks[32] = { [0 ... 31] = {0} };
+
+void timer_flush_tlb_tasks(void* data)
+{
+	int i;
+#ifdef CONFIG_X86
+	int flag = 0;
+#endif
+	for (i = 0; i < 32; i++) {
+		if (delay_tlb_tasks[i].mm != NULL &&
+				cpu_isset(smp_processor_id(), delay_tlb_tasks[i].mm->cpu_vm_mask) &&
+				cpu_isset(smp_processor_id(), delay_tlb_tasks[i].cpu_mask)) {
+#ifdef CONFIG_X86
+			flag = 1;
+#elif
+			// smp::local_flush_tlb_range(delay_tlb_tasks[i]);
+#endif
+			cpu_clear(smp_processor_id(), delay_tlb_tasks[i].cpu_mask);
+		}
+	}
+#ifdef CONFIG_X86
+	if (flag)
+		local_flush_tlb();
+#endif
+}
+
+static struct delay_tlb_task* delay_task = NULL;
+static int vma_index = 0;
+
+static struct delay_tlb_task* search_free_tlb_tasks_slot(void)
+{
+	struct delay_tlb_task* ret = NULL;
+	int i;
+again:
+	for (i = 0; i < 32; i++) {
+		if (delay_tlb_tasks[i].mm != NULL) {
+			if (cpus_empty(delay_tlb_tasks[i].cpu_mask)) {
+				mmput(delay_tlb_tasks[i].mm);
+				delay_tlb_tasks[i].mm = NULL;
+				ret = &delay_tlb_tasks[i];
+			}
+		} else
+			ret = &delay_tlb_tasks[i];
+	}
+	if (!ret) { // Force flush TLBs.
+		on_each_cpu(timer_flush_tlb_tasks, NULL, 0, 1);
+		goto again;
+	}
+	return ret;
+}
+
+static void init_delay_task(struct mm_struct* mm)
+{
+	cpus_clear(delay_task->cpu_mask);
+	vma_index = 0;
+	delay_task->mm = mm;
+}
+
+/*
+ * We will be working on the mm, so let's force to flush it if necessary.
+ */
+static void start_tlb_tasks(struct mm_struct* mm)
+{
+	int i, flag = 0;
+again:
+	for (i = 0; i < 32; i++) {
+		if (delay_tlb_tasks[i].mm == mm) {
+			if (cpus_empty(delay_tlb_tasks[i].cpu_mask)) {
+				mmput(delay_tlb_tasks[i].mm);
+				delay_tlb_tasks[i].mm = NULL;
+			} else
+				flag = 1;
+		}
+	}
+	if (flag) { // Force flush TLBs.
+		on_each_cpu(timer_flush_tlb_tasks, NULL, 0, 1);
+		goto again;
+	}
+	BUG_ON(delay_task != NULL);
+	delay_task = search_free_tlb_tasks_slot();
+	init_delay_task(mm);
+}
+
+static void end_tlb_tasks(void)
+{
+	atomic_inc(&delay_task->mm->mm_users);
+	delay_task->cpu_mask = delay_task->mm->cpu_vm_mask;
+	delay_task = NULL;
+#ifndef CONFIG_SMP
+	timer_flush_tlb_tasks(NULL);
+#endif
+}
+
+static void fill_in_tlb_tasks(struct vm_area_struct* vma, unsigned long addr,
+		unsigned long end)
+{
+	struct mm_struct* mm;
+	// First, try to combine the task with the previous.
+	if (vma_index != 0 && delay_task->vma[vma_index - 1] == vma &&
+			delay_task->end[vma_index - 1] == addr) {
+		delay_task->end[vma_index - 1] = end;
+		return;
+	}
+fill_it:
+	if (vma_index != 32) {
+		delay_task->vma[vma_index] = vma;
+		delay_task->start[vma_index] = addr;
+		delay_task->end[vma_index] = end;
+		vma_index++;
+		return;
+	}
+	mm = delay_task->mm;
+	end_tlb_tasks();
+
+	delay_task = search_free_tlb_tasks_slot();
+	init_delay_task(mm);
+	goto fill_it;
+}
+
+static void shrink_pvma_scan_ptes(struct scan_control* sc, struct mm_struct*
+		mm, struct vm_area_struct* vma, pmd_t* pmd, unsigned long addr,
+		unsigned long end)
+{
+	int i, statistic;
+	spinlock_t* ptl = pte_lockptr(mm, pmd);
+	pte_t* pte = pte_offset_map(pmd, addr);
+	int anon_rss = 0;
+	struct pagevec freed_pvec;
+	int may_enter_fs = (sc->gfp_mask & (__GFP_FS | __GFP_IO));
+	struct address_space* mapping = &swapper_space;
+
+	pagevec_init(&freed_pvec, 1);
+	do {
+		memset(&series, 0, sizeof(struct series_t));
+		find_series(&pte, &addr, end);
+		if (sc->pps_cmd == 0 && series.series_stage == 5)
+			continue;
+		switch (series.series_stage) {
+			case 1: // PTE -- untouched PTE.
+				for (i = 0; i < series.series_length; i++) {
+					struct page* page = series.pages[i];
+					lock_page(page);
+					spin_lock(ptl);
+					if (unlikely(pte_same(*series.ptes[i], series.orig_ptes[i]))) {
+						if (pte_dirty(*series.ptes[i]))
+							set_page_dirty(page);
+						set_pte_at(mm, addr + i * PAGE_SIZE, series.ptes[i],
+								pte_mkold(pte_mkclean(*series.ptes[i])));
+					}
+					spin_unlock(ptl);
+					unlock_page(page);
+				}
+				fill_in_tlb_tasks(vma, addr, addr + (PAGE_SIZE * series.series_length));
+				break;
+			case 2: // untouched PTE -- UnmappedPTE.
+				/*
+				 * Note in stage 1, we've flushed TLB in fill_in_tlb_tasks, so
+				 * if it's still clear here, we can shift it to Unmapped type.
+				 *
+				 * If some architecture doesn't support atomic cmpxchg
+				 * instruction or can't atomically set the access bit after
+				 * they touch a pte at first, combine stage 1 with stage 2, and
+				 * send IPI immediately in fill_in_tlb_tasks.
+				 */
+				spin_lock(ptl);
+				statistic = 0;
+				for (i = 0; i < series.series_length; i++) {
+					if (unlikely(pte_same(*series.ptes[i], series.orig_ptes[i]))) {
+						pte_t pte_unmapped = series.orig_ptes[i];
+						pte_unmapped.pte_low &= ~_PAGE_PRESENT;
+						pte_unmapped.pte_low |= _PAGE_UNMAPPED;
+						if (cmpxchg(&series.ptes[i]->pte_low,
+									series.orig_ptes[i].pte_low,
+									pte_unmapped.pte_low) !=
+								series.orig_ptes[i].pte_low)
+							continue;
+						page_remove_rmap(series.pages[i]);
+						anon_rss--;
+						statistic++;
+					}
+				}
+				atomic_add(statistic, &pps_info.unmapped_count);
+				atomic_sub(statistic, &pps_info.pte_count);
+				spin_unlock(ptl);
+				break;
+			case 3: // Attach SwapPage to PrivatePage.
+				/*
+				 * A better arithmetic should be applied to Linux SwapDevice to
+				 * allocate fake continual SwapPages which are close to each
+				 * other, the offset between two close SwapPages is less than 8.
+				 */
+				if (sc->may_swap) {
+					for (i = 0; i < series.series_length; i++) {
+						lock_page(series.pages[i]);
+						if (!PageSwapCache(series.pages[i])) {
+							if (!add_to_swap(series.pages[i], GFP_ATOMIC)) {
+								unlock_page(series.pages[i]);
+								break;
+							}
+						}
+						unlock_page(series.pages[i]);
+					}
+				}
+				break;
+			case 4: // SwapPage isn't consistent with PrivatePage.
+				/*
+				 * A mini version pageout().
+				 *
+				 * Current swap space can't commit multiple pages together:(
+				 */
+				if (sc->may_writepage && may_enter_fs) {
+					for (i = 0; i < series.series_length; i++) {
+						struct page* page = series.pages[i];
+						int res;
+
+						if (!may_write_to_queue(mapping->backing_dev_info))
+							break;
+						lock_page(page);
+						if (!PageDirty(page) || PageWriteback(page)) {
+							unlock_page(page);
+							continue;
+						}
+						clear_page_dirty_for_io(page);
+						struct writeback_control wbc = {
+							.sync_mode = WB_SYNC_NONE,
+							.nr_to_write = SWAP_CLUSTER_MAX,
+							.nonblocking = 1,
+							.for_reclaim = 1,
+						};
+						page_cache_get(page);
+						SetPageReclaim(page);
+						res = swap_writepage(page, &wbc);
+						if (res < 0) {
+							handle_write_error(mapping, page, res);
+							ClearPageReclaim(page);
+							page_cache_release(page);
+							break;
+						}
+						if (!PageWriteback(page))
+							ClearPageReclaim(page);
+						page_cache_release(page);
+					}
+				}
+				break;
+			case 5: // UnmappedPTE -- SwappedPTE, reclaim PrivatePage.
+				statistic = 0;
+				for (i = 0; i < series.series_length; i++) {
+					struct page* page = series.pages[i];
+					lock_page(page);
+					spin_lock(ptl);
+					if (unlikely(!pte_same(*series.ptes[i], series.orig_ptes[i]))) {
+						spin_unlock(ptl);
+						unlock_page(page);
+						continue;
+					}
+					statistic++;
+					swp_entry_t entry = { .val = page_private(page) };
+					swap_duplicate(entry);
+					pte_t pte_swp = swp_entry_to_pte(entry);
+					set_pte_at(mm, addr + i * PAGE_SIZE, series.ptes[i], pte_swp);
+					spin_unlock(ptl);
+					if (PageSwapCache(page) && !PageWriteback(page))
+						delete_from_swap_cache(page);
+					unlock_page(page);
+
+					if (!pagevec_add(&freed_pvec, page))
+						__pagevec_release_nonlru(&freed_pvec);
+					sc->nr_reclaimed++;
+				}
+				atomic_add(statistic, &pps_info.swapped_count);
+				atomic_sub(statistic, &pps_info.unmapped_count);
+				atomic_sub(statistic, &pps_info.total);
+				break;
+			case 6:
+				// NULL operation!
+				break;
+		}
+	} while (addr < end);
+	add_mm_counter(mm, anon_rss, anon_rss);
+	if (pagevec_count(&freed_pvec))
+		__pagevec_release_nonlru(&freed_pvec);
+}
+
+static void shrink_pvma_pmd_range(struct scan_control* sc, struct mm_struct*
+		mm, struct vm_area_struct* vma, pud_t* pud, unsigned long addr,
+		unsigned long end)
+{
+	unsigned long next;
+	pmd_t* pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		shrink_pvma_scan_ptes(sc, mm, vma, pmd, addr, next);
+	} while (pmd++, addr = next, addr != end);
+}
+
+static void shrink_pvma_pud_range(struct scan_control* sc, struct mm_struct*
+		mm, struct vm_area_struct* vma, pgd_t* pgd, unsigned long addr,
+		unsigned long end)
+{
+	unsigned long next;
+	pud_t* pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		shrink_pvma_pmd_range(sc, mm, vma, pud, addr, next);
+	} while (pud++, addr = next, addr != end);
+}
+
+static void shrink_pvma_pgd_range(struct scan_control* sc, struct mm_struct*
+		mm, struct vm_area_struct* vma)
+{
+	unsigned long next;
+	unsigned long addr = vma->vm_start;
+	unsigned long end = vma->vm_end;
+	pgd_t* pgd = pgd_offset(mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		shrink_pvma_pud_range(sc, mm, vma, pgd, addr, next);
+	} while (pgd++, addr = next, addr != end);
+}
+
+static void shrink_private_vma(struct scan_control* sc)
+{
+	struct vm_area_struct* vma;
+	struct list_head *pos;
+	struct mm_struct *prev, *mm;
+
+	prev = mm = &init_mm;
+	pos = &init_mm.mmlist;
+	atomic_inc(&prev->mm_users);
+	spin_lock(&mmlist_lock);
+	while ((pos = pos->next) != &init_mm.mmlist) {
+		mm = list_entry(pos, struct mm_struct, mmlist);
+		if (!atomic_add_unless(&mm->mm_users, 1, 0))
+			continue;
+		spin_unlock(&mmlist_lock);
+		mmput(prev);
+		prev = mm;
+		start_tlb_tasks(mm);
+		if (down_read_trylock(&mm->mmap_sem)) {
+			for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
+				if (!(vma->vm_flags & VM_PURE_PRIVATE))
+					continue;
+				if (vma->vm_flags & VM_LOCKED)
+					continue;
+				shrink_pvma_pgd_range(sc, mm, vma);
+			}
+			up_read(&mm->mmap_sem);
+		}
+		end_tlb_tasks();
+		spin_lock(&mmlist_lock);
+	}
+	spin_unlock(&mmlist_lock);
+	mmput(prev);
+}
+
 /*
  * For kswapd, balance_pgdat() will work across all this node's zones until
  * they are all at pages_high.
@@ -1557,6 +1982,10 @@
 	sc.may_swap = 1;
 	sc.nr_mapped = read_page_state(nr_mapped);

+	wakeup_sc = sc;
+	wakeup_sc.pps_cmd = 1;
+	wake_up_interruptible(&kppsd_wait);
+
 	inc_page_state(pageoutrun);

 	for (i = 0; i < pgdat->nr_zones; i++) {
@@ -1693,6 +2122,33 @@
 	return total_reclaimed;
 }

+static int kppsd(void* p)
+{
+	struct task_struct *tsk = current;
+	int timeout;
+	DEFINE_WAIT(wait);
+	daemonize("kppsd");
+	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE;
+	struct scan_control default_sc;
+	default_sc.gfp_mask = GFP_KERNEL;
+	default_sc.may_writepage = 1;
+	default_sc.may_swap = 1;
+	default_sc.pps_cmd = 0;
+
+	while (1) {
+		try_to_freeze();
+		prepare_to_wait(&kppsd_wait, &wait, TASK_INTERRUPTIBLE);
+		timeout = schedule_timeout(2000);
+		finish_wait(&kppsd_wait, &wait);
+
+		if (timeout)
+			shrink_private_vma(&wakeup_sc);
+		else
+			shrink_private_vma(&default_sc);
+	}
+	return 0;
+}
+
 /*
  * The background pageout daemon, started as a kernel thread
  * from the init process.
@@ -1837,6 +2293,15 @@
 }
 #endif /* CONFIG_HOTPLUG_CPU */

+static int __init kppsd_init(void)
+{
+	init_waitqueue_head(&kppsd_wait);
+	kernel_thread(kppsd, NULL, CLONE_KERNEL);
+	return 0;
+}
+
+module_init(kppsd_init)
+
 static int __init kswapd_init(void)
 {
 	pg_data_t *pgdat;
