Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbULTUqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbULTUqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 15:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbULTUqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 15:46:32 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:17865 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261623AbULTUph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 15:45:37 -0500
Date: Mon, 20 Dec 2004 21:45:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
In-Reply-To: <1103554150.11069.104.camel@localhost>
Message-ID: <Pine.LNX.4.61.0412201959290.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com> 
 <Pine.LNX.4.61.0412170133560.793@scrub.home>  <1103244171.13614.2525.camel@localhost>
  <Pine.LNX.4.61.0412170150080.793@scrub.home>  <1103246050.13614.2571.camel@localhost>
  <Pine.LNX.4.61.0412170256500.793@scrub.home>  <1103257482.13614.2817.camel@localhost>
  <Pine.LNX.4.61.0412171132560.793@scrub.home>  <1103299179.13614.3551.camel@localhost>
  <Pine.LNX.4.61.0412171818090.793@scrub.home>  <1103320106.7864.6.camel@localhost>
  <Pine.LNX.4.61.0412180020220.793@scrub.home> <1103554150.11069.104.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Dec 2004, Dave Hansen wrote:

> But, what do you think we should do about the current #defines in
> asm/mmzone.h, like pfn_to_page()?  Would it be feasible to put them in
> another header that can use proper functions?

It should be possible to move it to asm/pgtable.h, although asm/memory.h 
(as arm already has) would be a good alternative.
struct page can be moved to linux/mmzone.h and and asm/mmzone.h should die 
rather soon. It was mistake to have definitions of inline functions/macros 
in two different files (asm/page.h and asm/mmzone.h).
Below is a patch which moves thing around so pfn_to_page/page_to_pfn can 
become inline functions.

bye, Roman

 asm/mmzone.h   |   27 -----
 asm/page.h     |    8 -
 asm/pgtable.h  |   44 +++++++++
 linux/mm.h     |  192 ----------------------------------------
 linux/mmzone.h |  272 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 5 files changed, 274 insertions(+), 269 deletions(-)

Index: linux-mm/include/linux/mmzone.h
===================================================================
--- linux-mm.orig/include/linux/mmzone.h	2004-12-17 12:01:55.000000000 +0100
+++ linux-mm/include/linux/mmzone.h	2004-12-20 21:39:26.513594537 +0100
@@ -11,7 +11,168 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <linux/numa.h>
-#include <asm/atomic.h>
+#include <linux/rbtree.h>
+#include <linux/prio_tree.h>
+
+#ifdef ARCH_HAS_ATOMIC_UNSIGNED
+typedef unsigned page_flags_t;
+#else
+typedef unsigned long page_flags_t;
+#endif
+
+/*
+ * Each physical page in the system has a struct page associated with
+ * it to keep track of whatever it is we are using the page for at the
+ * moment. Note that we have no way to track which tasks are using
+ * a page.
+ */
+struct page {
+	page_flags_t flags;		/* Atomic flags, some possibly
+					 * updated asynchronously */
+	atomic_t _count;		/* Usage count, see below. */
+	atomic_t _mapcount;		/* Count of ptes mapped in mms,
+					 * to show when page is mapped
+					 * & limit reverse map searches.
+					 */
+	unsigned long private;		/* Mapping-private opaque data:
+					 * usually used for buffer_heads
+					 * if PagePrivate set; used for
+					 * swp_entry_t if PageSwapCache
+					 */
+	struct address_space *mapping;	/* If low bit clear, points to
+					 * inode address_space, or NULL.
+					 * If page mapped as anonymous
+					 * memory, low bit is set, and
+					 * it points to anon_vma object:
+					 * see PAGE_MAPPING_ANON below.
+					 */
+	pgoff_t index;			/* Our offset within mapping. */
+	struct list_head lru;		/* Pageout list, eg. active_list
+					 * protected by zone->lru_lock !
+					 */
+	/*
+	 * On machines where all RAM is mapped into kernel address space,
+	 * we can simply calculate the virtual address. On machines with
+	 * highmem some memory is mapped into kernel virtual memory
+	 * dynamically, so we need a place to store that address.
+	 * Note that this field could be 16 bits on x86 ... ;)
+	 *
+	 * Architectures with slow multiplication can define
+	 * WANT_PAGE_VIRTUAL in asm/page.h
+	 */
+#if defined(WANT_PAGE_VIRTUAL)
+	void *virtual;			/* Kernel virtual address (NULL if
+					   not kmapped, ie. highmem) */
+#endif /* WANT_PAGE_VIRTUAL */
+};
+
+/*
+ * This struct defines a memory VMM memory area. There is one of these
+ * per VM-area/task.  A VM area is any part of the process virtual memory
+ * space that has a special rule for the page-fault handlers (ie a shared
+ * library, the executable area etc).
+ */
+struct vm_area_struct {
+	struct mm_struct * vm_mm;	/* The address space we belong to. */
+	unsigned long vm_start;		/* Our start address within vm_mm. */
+	unsigned long vm_end;		/* The first byte after our end address
+					   within vm_mm. */
+
+	/* linked list of VM areas per task, sorted by address */
+	struct vm_area_struct *vm_next;
+
+	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */
+	unsigned long vm_flags;		/* Flags, listed below. */
+
+	struct rb_node vm_rb;
+
+	/*
+	 * For areas with an address space and backing store,
+	 * linkage into the address_space->i_mmap prio tree, or
+	 * linkage to the list of like vmas hanging off its node, or
+	 * linkage of vma in the address_space->i_mmap_nonlinear list.
+	 */
+	union {
+		struct {
+			struct list_head list;
+			void *parent;	/* aligns with prio_tree_node parent */
+			struct vm_area_struct *head;
+		} vm_set;
+
+		struct prio_tree_node prio_tree_node;
+	} shared;
+
+	/*
+	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
+	 * list, after a COW of one of the file pages.  A MAP_SHARED vma
+	 * can only be in the i_mmap tree.  An anonymous MAP_PRIVATE, stack
+	 * or brk vma (with NULL file) can only be in an anon_vma list.
+	 */
+	struct list_head anon_vma_node;	/* Serialized by anon_vma->lock */
+	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
+
+	/* Function pointers to deal with this struct. */
+	struct vm_operations_struct * vm_ops;
+
+	/* Information about our backing store: */
+	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
+					   units, *not* PAGE_CACHE_SIZE */
+	struct file * vm_file;		/* File we map to (can be NULL). */
+	void * vm_private_data;		/* was vm_pte (shared mem) */
+
+#ifdef CONFIG_NUMA
+	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
+};
+
+/*
+ * vm_flags..
+ */
+#define VM_READ		0x00000001	/* currently active flags */
+#define VM_WRITE	0x00000002
+#define VM_EXEC		0x00000004
+#define VM_SHARED	0x00000008
+
+#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
+#define VM_MAYWRITE	0x00000020
+#define VM_MAYEXEC	0x00000040
+#define VM_MAYSHARE	0x00000080
+
+#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
+#define VM_GROWSUP	0x00000200
+#define VM_SHM		0x00000400	/* shared memory area, don't swap out */
+#define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
+
+#define VM_EXECUTABLE	0x00001000
+#define VM_LOCKED	0x00002000
+#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
+
+					/* Used by sys_madvise() */
+#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
+#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
+
+#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
+#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
+#define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
+#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
+#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
+#define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
+
+#ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
+#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
+#endif
+
+#ifdef CONFIG_STACK_GROWSUP
+#define VM_STACK_FLAGS	(VM_GROWSUP | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
+#else
+#define VM_STACK_FLAGS	(VM_GROWSDOWN | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
+#endif
+
+#define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
+#define VM_ClearReadHint(v)		(v)->vm_flags &= ~VM_READHINTMASK
+#define VM_NormalReadHint(v)		(!((v)->vm_flags & VM_READHINTMASK))
+#define VM_SequentialReadHint(v)	((v)->vm_flags & VM_SEQ_READ)
+#define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
@@ -25,8 +186,6 @@ struct free_area {
 	unsigned long		*map;
 };
 
-struct pglist_data;
-
 /*
  * zone->lock and zone->lru_lock are two of the hottest locks in the kernel.
  * So add a wild amount of padding here to ensure that they fall into separate
@@ -238,6 +397,74 @@ struct zonelist {
 	struct zone *zones[MAX_NUMNODES * MAX_NR_ZONES + 1]; // NULL delimited
 };
 
+#ifndef CONFIG_DISCONTIGMEM
+
+extern struct pglist_data contig_page_data;
+#define NODE_DATA(nid)		(&contig_page_data)
+#define NODE_MEM_MAP(nid)	mem_map
+#define MAX_NODES_SHIFT		1
+#define pfn_to_nid(pfn)		(0)
+
+#else /* CONFIG_DISCONTIGMEM */
+
+#include <asm/mmzone.h>
+
+#if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
+/*
+ * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
+ * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
+ */
+#define MAX_NODES_SHIFT		6
+#elif BITS_PER_LONG == 64
+/*
+ * with 64 bit flags field, there's plenty of room.
+ */
+#define MAX_NODES_SHIFT		10
+#endif
+
+#endif /* !CONFIG_DISCONTIGMEM */
+
+#if NODES_SHIFT > MAX_NODES_SHIFT
+#error NODES_SHIFT > MAX_NODES_SHIFT
+#endif
+
+/* There are currently 3 zones: DMA, Normal & Highmem, thus we need 2 bits */
+#define MAX_ZONES_SHIFT		2
+
+#if ZONES_SHIFT > MAX_ZONES_SHIFT
+#error ZONES_SHIFT > MAX_ZONES_SHIFT
+#endif
+
+/*
+ * The zone field is never updated after free_area_init_core()
+ * sets it, so none of the operations on it need to be atomic.
+ * We'll have up to (MAX_NUMNODES * MAX_NR_ZONES) zones total,
+ * so we use (MAX_NODES_SHIFT + MAX_ZONES_SHIFT) here to get enough bits.
+ */
+#define NODEZONE_SHIFT (sizeof(page_flags_t)*8 - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
+#define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
+
+static inline unsigned long page_zonenum(struct page *page)
+{
+	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
+}
+static inline unsigned long page_to_nid(struct page *page)
+{
+	return (page->flags >> (NODEZONE_SHIFT + ZONES_SHIFT));
+}
+
+static inline void set_page_zone(struct page *page, unsigned long nodezone_num)
+{
+	page->flags &= ~(~0UL << NODEZONE_SHIFT);
+	page->flags |= nodezone_num << NODEZONE_SHIFT;
+}
+
+extern struct zone *zone_table[];
+
+static inline struct zone *page_zone(struct page *page)
+{
+	return zone_table[page->flags >> NODEZONE_SHIFT];
+}
 
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM
@@ -369,48 +596,9 @@ int min_free_kbytes_sysctl_handler(struc
 int lower_zone_protection_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
 
-#include <linux/topology.h>
 /* Returns the number of the current Node. */
 #define numa_node_id()		(cpu_to_node(smp_processor_id()))
 
-#ifndef CONFIG_DISCONTIGMEM
-
-extern struct pglist_data contig_page_data;
-#define NODE_DATA(nid)		(&contig_page_data)
-#define NODE_MEM_MAP(nid)	mem_map
-#define MAX_NODES_SHIFT		1
-#define pfn_to_nid(pfn)		(0)
-
-#else /* CONFIG_DISCONTIGMEM */
-
-#include <asm/mmzone.h>
-
-#if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
-/*
- * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
- * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
- */
-#define MAX_NODES_SHIFT		6
-#elif BITS_PER_LONG == 64
-/*
- * with 64 bit flags field, there's plenty of room.
- */
-#define MAX_NODES_SHIFT		10
-#endif
-
-#endif /* !CONFIG_DISCONTIGMEM */
-
-#if NODES_SHIFT > MAX_NODES_SHIFT
-#error NODES_SHIFT > MAX_NODES_SHIFT
-#endif
-
-/* There are currently 3 zones: DMA, Normal & Highmem, thus we need 2 bits */
-#define MAX_ZONES_SHIFT		2
-
-#if ZONES_SHIFT > MAX_ZONES_SHIFT
-#error ZONES_SHIFT > MAX_ZONES_SHIFT
-#endif
-
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
Index: linux-mm/include/asm/mmzone.h
===================================================================
--- linux-mm.orig/include/asm/mmzone.h	2004-07-03 19:02:16.000000000 +0200
+++ linux-mm/include/asm/mmzone.h	2004-12-20 21:36:42.708848071 +0100
@@ -102,35 +102,8 @@ static inline struct pglist_data *pfn_to
 /* XXX: FIXME -- wli */
 #define kern_addr_valid(kaddr)	(0)
 
-#define pfn_to_page(pfn)						\
-({									\
-	unsigned long __pfn = pfn;					\
-	int __node  = pfn_to_nid(__pfn);				\
-	&node_mem_map(__node)[node_localnr(__pfn,__node)];		\
-})
-
-#define page_to_pfn(pg)							\
-({									\
-	struct page *__page = pg;					\
-	struct zone *__zone = page_zone(__page);			\
-	(unsigned long)(__page - __zone->zone_mem_map)			\
-		+ __zone->zone_start_pfn;				\
-})
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
-#ifdef CONFIG_X86_NUMAQ            /* we have contiguous memory on NUMA-Q */
-#define pfn_valid(pfn)          ((pfn) < num_physpages)
-#else
-static inline int pfn_valid(int pfn)
-{
-	int nid = pfn_to_nid(pfn);
-
-	if (nid >= 0)
-		return (pfn < node_end_pfn(nid));
-	return 0;
-}
-#endif
-
 extern int get_memcfg_numa_flat(void );
 /*
  * This allows any one NUMA architecture to be compiled
Index: linux-mm/include/asm/pgtable.h
===================================================================
--- linux-mm.orig/include/asm/pgtable.h	2004-10-20 17:28:49.000000000 +0200
+++ linux-mm/include/asm/pgtable.h	2004-12-20 21:36:42.717846519 +0100
@@ -25,6 +25,50 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 
+#ifndef CONFIG_DISCONTIGMEM
+
+static inline struct page *pfn_to_page(unsigned long pfn)
+{
+	return mem_map + pfn;
+}
+static inline unsigned long page_to_pfn(struct page *page)
+{
+	return page - mem_map;
+}
+
+#define pfn_valid(pfn)		((pfn) < max_mapnr)
+
+#else
+
+static inline struct page *pfn_to_page(unsigned long pfn)
+{
+	int node = pfn_to_nid(pfn);
+	return &node_mem_map(node)[node_localnr(pfn, node)];
+}
+static inline unsigned long page_to_pfn(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	return zone->zone_start_pfn + (page - zone->zone_mem_map);
+}
+
+#ifdef CONFIG_X86_NUMAQ            /* we have contiguous memory on NUMA-Q */
+#define pfn_valid(pfn)          ((pfn) < num_physpages)
+#else
+static inline int pfn_valid(int pfn)
+{
+	int nid = pfn_to_nid(pfn);
+
+	if (nid >= 0)
+		return (pfn < node_end_pfn(nid));
+	return 0;
+}
+#endif
+
+#endif /* !CONFIG_DISCONTIGMEM */
+#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+
+#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
Index: linux-mm/include/linux/mm.h
===================================================================
--- linux-mm.orig/include/linux/mm.h	2004-12-17 12:01:55.000000000 +0100
+++ linux-mm/include/linux/mm.h	2004-12-20 21:36:42.718846346 +0100
@@ -53,114 +53,6 @@ extern int sysctl_legacy_va_layout;
  */
 
 /*
- * This struct defines a memory VMM memory area. There is one of these
- * per VM-area/task.  A VM area is any part of the process virtual memory
- * space that has a special rule for the page-fault handlers (ie a shared
- * library, the executable area etc).
- */
-struct vm_area_struct {
-	struct mm_struct * vm_mm;	/* The address space we belong to. */
-	unsigned long vm_start;		/* Our start address within vm_mm. */
-	unsigned long vm_end;		/* The first byte after our end address
-					   within vm_mm. */
-
-	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next;
-
-	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */
-	unsigned long vm_flags;		/* Flags, listed below. */
-
-	struct rb_node vm_rb;
-
-	/*
-	 * For areas with an address space and backing store,
-	 * linkage into the address_space->i_mmap prio tree, or
-	 * linkage to the list of like vmas hanging off its node, or
-	 * linkage of vma in the address_space->i_mmap_nonlinear list.
-	 */
-	union {
-		struct {
-			struct list_head list;
-			void *parent;	/* aligns with prio_tree_node parent */
-			struct vm_area_struct *head;
-		} vm_set;
-
-		struct prio_tree_node prio_tree_node;
-	} shared;
-
-	/*
-	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
-	 * list, after a COW of one of the file pages.  A MAP_SHARED vma
-	 * can only be in the i_mmap tree.  An anonymous MAP_PRIVATE, stack
-	 * or brk vma (with NULL file) can only be in an anon_vma list.
-	 */
-	struct list_head anon_vma_node;	/* Serialized by anon_vma->lock */
-	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
-
-	/* Function pointers to deal with this struct. */
-	struct vm_operations_struct * vm_ops;
-
-	/* Information about our backing store: */
-	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
-					   units, *not* PAGE_CACHE_SIZE */
-	struct file * vm_file;		/* File we map to (can be NULL). */
-	void * vm_private_data;		/* was vm_pte (shared mem) */
-
-#ifdef CONFIG_NUMA
-	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
-#endif
-};
-
-/*
- * vm_flags..
- */
-#define VM_READ		0x00000001	/* currently active flags */
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
-
-#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_MAYSHARE	0x00000080
-
-#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
-#define VM_GROWSUP	0x00000200
-#define VM_SHM		0x00000400	/* shared memory area, don't swap out */
-#define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
-
-#define VM_EXECUTABLE	0x00001000
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
-
-					/* Used by sys_madvise() */
-#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
-
-#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
-#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
-#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
-#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
-
-#ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
-#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
-#endif
-
-#ifdef CONFIG_STACK_GROWSUP
-#define VM_STACK_FLAGS	(VM_GROWSUP | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
-#else
-#define VM_STACK_FLAGS	(VM_GROWSDOWN | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
-#endif
-
-#define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
-#define VM_ClearReadHint(v)		(v)->vm_flags &= ~VM_READHINTMASK
-#define VM_NormalReadHint(v)		(!((v)->vm_flags & VM_READHINTMASK))
-#define VM_SequentialReadHint(v)	((v)->vm_flags & VM_SEQ_READ)
-#define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)
-
-/*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
  */
@@ -187,58 +79,6 @@ struct vm_operations_struct {
 struct mmu_gather;
 struct inode;
 
-#ifdef ARCH_HAS_ATOMIC_UNSIGNED
-typedef unsigned page_flags_t;
-#else
-typedef unsigned long page_flags_t;
-#endif
-
-/*
- * Each physical page in the system has a struct page associated with
- * it to keep track of whatever it is we are using the page for at the
- * moment. Note that we have no way to track which tasks are using
- * a page.
- */
-struct page {
-	page_flags_t flags;		/* Atomic flags, some possibly
-					 * updated asynchronously */
-	atomic_t _count;		/* Usage count, see below. */
-	atomic_t _mapcount;		/* Count of ptes mapped in mms,
-					 * to show when page is mapped
-					 * & limit reverse map searches.
-					 */
-	unsigned long private;		/* Mapping-private opaque data:
-					 * usually used for buffer_heads
-					 * if PagePrivate set; used for
-					 * swp_entry_t if PageSwapCache
-					 */
-	struct address_space *mapping;	/* If low bit clear, points to
-					 * inode address_space, or NULL.
-					 * If page mapped as anonymous
-					 * memory, low bit is set, and
-					 * it points to anon_vma object:
-					 * see PAGE_MAPPING_ANON below.
-					 */
-	pgoff_t index;			/* Our offset within mapping. */
-	struct list_head lru;		/* Pageout list, eg. active_list
-					 * protected by zone->lru_lock !
-					 */
-	/*
-	 * On machines where all RAM is mapped into kernel address space,
-	 * we can simply calculate the virtual address. On machines with
-	 * highmem some memory is mapped into kernel virtual memory
-	 * dynamically, so we need a place to store that address.
-	 * Note that this field could be 16 bits on x86 ... ;)
-	 *
-	 * Architectures with slow multiplication can define
-	 * WANT_PAGE_VIRTUAL in asm/page.h
-	 */
-#if defined(WANT_PAGE_VIRTUAL)
-	void *virtual;			/* Kernel virtual address (NULL if
-					   not kmapped, ie. highmem) */
-#endif /* WANT_PAGE_VIRTUAL */
-};
-
 /*
  * FIXME: take this include out, include page-flags.h in
  * files which need it (119 of them)
@@ -372,38 +212,6 @@ static inline void put_page(struct page 
  *   to swap space and (later) to be read back into memory.
  */
 
-/*
- * The zone field is never updated after free_area_init_core()
- * sets it, so none of the operations on it need to be atomic.
- * We'll have up to (MAX_NUMNODES * MAX_NR_ZONES) zones total,
- * so we use (MAX_NODES_SHIFT + MAX_ZONES_SHIFT) here to get enough bits.
- */
-#define NODEZONE_SHIFT (sizeof(page_flags_t)*8 - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
-#define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
-
-static inline unsigned long page_zonenum(struct page *page)
-{
-	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
-}
-static inline unsigned long page_to_nid(struct page *page)
-{
-	return (page->flags >> (NODEZONE_SHIFT + ZONES_SHIFT));
-}
-
-struct zone;
-extern struct zone *zone_table[];
-
-static inline struct zone *page_zone(struct page *page)
-{
-	return zone_table[page->flags >> NODEZONE_SHIFT];
-}
-
-static inline void set_page_zone(struct page *page, unsigned long nodezone_num)
-{
-	page->flags &= ~(~0UL << NODEZONE_SHIFT);
-	page->flags |= nodezone_num << NODEZONE_SHIFT;
-}
-
 #ifndef CONFIG_DISCONTIGMEM
 /* The array of struct pages - for discontigmem use pgdat->lmem_map */
 extern struct page *mem_map;
Index: linux-mm/include/asm/page.h
===================================================================
--- linux-mm.orig/include/asm/page.h	2004-12-17 12:01:48.000000000 +0100
+++ linux-mm/include/asm/page.h	2004-12-20 21:36:42.718846346 +0100
@@ -133,14 +133,6 @@ extern int sysctl_legacy_va_layout;
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
-#ifndef CONFIG_DISCONTIGMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
-#endif /* !CONFIG_DISCONTIGMEM */
-#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-
-#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
 #define VM_DATA_DEFAULT_FLAGS \
 	(VM_READ | VM_WRITE | \
