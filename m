Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbSI2PWc>; Sun, 29 Sep 2002 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbSI2PWc>; Sun, 29 Sep 2002 11:22:32 -0400
Received: from zero.aec.at ([193.170.194.10]:14344 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262621AbSI2PW1>;
	Sun, 29 Sep 2002 11:22:27 -0400
Date: Sun, 29 Sep 2002 17:27:31 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20020929152731.GA10631@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc 3.2 has an __attribute__((malloc)) function attribute. It tells gcc
that a function returns newly allocated memory and that the return pointer
cannot alias with any other pointer in the parent function. This often
allows gcc to generate better code because the optimizer doesn't need take
pointer aliasing in account.

This patch implements it for 2.5.39 and some common allocation functions.

Also added an noinline macro to wrap __attribute__((noinline)). That's 
not used yet. It tells the compiler that it should never inline, which
may be useful to prevent some awful code generation for those misguided
folks who use -O3 (gcc often screws up the register allocation of a 
function completely when bigger functions are inlined). 

Patch for 2.5.39.

Please consider applying.

-Andi

diff -X ../KDIFX -burp linux/include/asm-i386/pgalloc.h linux-2.5.39-work/include/asm-i386/pgalloc.h
--- linux/include/asm-i386/pgalloc.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.39-work/include/asm-i386/pgalloc.h	2002-09-29 17:07:07.000000000 +0200
@@ -20,10 +20,10 @@ static inline void pmd_populate(struct m
  * Allocate and free page tables.
  */
 
-extern pgd_t *pgd_alloc(struct mm_struct *);
+extern pgd_t *pgd_alloc(struct mm_struct *) malloc_function;
 extern void pgd_free(pgd_t *pgd);
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
+extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long) malloc_function;
 extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);
 
 static inline void pte_free_kernel(pte_t *pte)
diff -X ../KDIFX -burp linux/include/linux/bootmem.h linux-2.5.39-work/include/linux/bootmem.h
--- linux/include/linux/bootmem.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.39-work/include/linux/bootmem.h	2002-09-29 17:03:39.000000000 +0200
@@ -37,7 +37,7 @@ typedef struct bootmem_data {
 extern unsigned long __init bootmem_bootmap_pages (unsigned long);
 extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
 extern void __init free_bootmem (unsigned long addr, unsigned long size);
-extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
+extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal) malloc_function;
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
@@ -55,7 +55,7 @@ extern unsigned long __init init_bootmem
 extern void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
 extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
 extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
-extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
+extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal) malloc_function;
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
diff -X ../KDIFX -burp linux/include/linux/dcache.h linux-2.5.39-work/include/linux/dcache.h
--- linux/include/linux/dcache.h	2002-09-29 16:54:34.000000000 +0200
+++ linux-2.5.39-work/include/linux/dcache.h	2002-09-29 17:03:57.000000000 +0200
@@ -173,8 +173,8 @@ extern void d_instantiate(struct dentry 
 extern void d_delete(struct dentry *);
 
 /* allocate/de-allocate */
-extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
-extern struct dentry * d_alloc_anon(struct inode *);
+extern struct dentry * d_alloc(struct dentry *, const struct qstr *) malloc_function;
+extern struct dentry * d_alloc_anon(struct inode *) malloc_function;
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
diff -X ../KDIFX -burp linux/include/linux/gfp.h linux-2.5.39-work/include/linux/gfp.h
--- linux/include/linux/gfp.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.39-work/include/linux/gfp.h	2002-09-29 17:08:55.000000000 +0200
@@ -39,8 +39,8 @@
  * can allocate highmem pages, the *get*page*() variants return
  * virtual kernel addresses to the allocated page(s).
  */
-extern struct page * FASTCALL(__alloc_pages(unsigned int gfp_mask, unsigned int order, struct zonelist *zonelist));
-extern struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned int order);
+extern struct page * FASTCALL(__alloc_pages(unsigned int gfp_mask, unsigned int order, struct zonelist *zonelist)) malloc_function;
+extern struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned int order) malloc_function;
 
 /*
  * We get the zone list from the current node and the gfp_mask.
@@ -49,7 +49,8 @@ extern struct page * alloc_pages_node(in
  * For the normal case of non-DISCONTIGMEM systems the NODE_DATA() gets
  * optimized to &contig_page_data at compile-time.
  */
-static inline struct page * alloc_pages(unsigned int gfp_mask, unsigned int order)
+static inline malloc_function struct page * 
+alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
 	pg_data_t *pgdat = NODE_DATA(numa_node_id());
 	unsigned int idx = (gfp_mask & GFP_ZONEMASK);
@@ -62,8 +63,8 @@ static inline struct page * alloc_pages(
 
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 
-extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order));
-extern unsigned long FASTCALL(get_zeroed_page(unsigned int gfp_mask));
+extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order)) malloc_function; 
+extern unsigned long FASTCALL(get_zeroed_page(unsigned int gfp_mask)) malloc_function;
 
 #define __get_free_page(gfp_mask) \
 		__get_free_pages((gfp_mask),0)
diff -X ../KDIFX -burp linux/include/linux/jbd.h linux-2.5.39-work/include/linux/jbd.h
--- linux/include/linux/jbd.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.39-work/include/linux/jbd.h	2002-09-29 17:04:40.000000000 +0200
@@ -54,7 +54,7 @@ extern int journal_enable_debug;
 #define jbd_debug(f, a...)	/**/
 #endif
 
-extern void * __jbd_kmalloc (char *where, size_t size, int flags, int retry);
+extern void * __jbd_kmalloc (char *where, size_t size, int flags, int retry) malloc_function;
 #define jbd_kmalloc(size, flags) \
 	__jbd_kmalloc(__FUNCTION__, (size), (flags), journal_oom_retry)
 #define jbd_rep_kmalloc(size, flags) \
diff -X ../KDIFX -burp linux/include/linux/kernel.h linux-2.5.39-work/include/linux/kernel.h
--- linux/include/linux/kernel.h	2002-09-29 16:54:34.000000000 +0200
+++ linux-2.5.39-work/include/linux/kernel.h	2002-09-29 17:20:52.000000000 +0200
@@ -47,6 +47,16 @@ void __might_sleep(char *file, int line)
 #define might_sleep() do {} while(0)
 #endif
 
+#if __GNUC__ >= 3 && __GNUC_MINOR__ >= 1
+/* Function allocates new memory and return cannot alias with anything */
+#define malloc_function __attribute__((malloc))
+/* Never inline */
+#define noinline __attribute__((noinline))
+#else
+#define malloc_function
+#define noinline
+#endif
+
 extern struct notifier_block *panic_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
diff -X ../KDIFX -burp linux/include/linux/mempool.h linux-2.5.39-work/include/linux/mempool.h
--- linux/include/linux/mempool.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.39-work/include/linux/mempool.h	2002-09-29 17:05:04.000000000 +0200
@@ -21,10 +21,10 @@ typedef struct mempool_s {
 	wait_queue_head_t wait;
 } mempool_t;
 extern mempool_t * mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
-				 mempool_free_t *free_fn, void *pool_data);
+				 mempool_free_t *free_fn, void *pool_data) malloc_function;
 extern int mempool_resize(mempool_t *pool, int new_min_nr, int gfp_mask);
 extern void mempool_destroy(mempool_t *pool);
-extern void * mempool_alloc(mempool_t *pool, int gfp_mask);
+extern void * mempool_alloc(mempool_t *pool, int gfp_mask) malloc_function;
 extern void mempool_free(void *element, mempool_t *pool);
 
 #endif /* _LINUX_MEMPOOL_H */
diff -X ../KDIFX -burp linux/include/linux/mm.h linux-2.5.39-work/include/linux/mm.h
--- linux/include/linux/mm.h	2002-09-29 16:54:35.000000000 +0200
+++ linux-2.5.39-work/include/linux/mm.h	2002-09-29 17:09:14.000000000 +0200
@@ -417,7 +417,8 @@ static inline int set_page_dirty(struct 
  * inlining and the symmetry break with pte_alloc_map() that does all
  * of this out-of-line.
  */
-static inline pmd_t *pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
+static inline malloc_function pmd_t *
+pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address) 
 {
 	if (pgd_none(*pgd))
 		return __pmd_alloc(mm, pgd, address);
diff -X ../KDIFX -burp linux/include/linux/skbuff.h linux-2.5.39-work/include/linux/skbuff.h
--- linux/include/linux/skbuff.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.39-work/include/linux/skbuff.h	2002-09-29 17:02:37.000000000 +0200
@@ -259,11 +259,11 @@ struct sk_buff {
 #include <asm/system.h>
 
 extern void	       __kfree_skb(struct sk_buff *skb);
-extern struct sk_buff *alloc_skb(unsigned int size, int priority);
+extern struct sk_buff *alloc_skb(unsigned int size, int priority) malloc_function;
 extern void	       kfree_skbmem(struct sk_buff *skb);
-extern struct sk_buff *skb_clone(struct sk_buff *skb, int priority);
-extern struct sk_buff *skb_copy(const struct sk_buff *skb, int priority);
-extern struct sk_buff *pskb_copy(struct sk_buff *skb, int gfp_mask);
+extern struct sk_buff *skb_clone(struct sk_buff *skb, int priority) malloc_function;
+extern struct sk_buff *skb_copy(const struct sk_buff *skb, int priority) malloc_function;
+extern struct sk_buff *pskb_copy(struct sk_buff *skb, int gfp_mask) malloc_function;
 extern int	       pskb_expand_head(struct sk_buff *skb,
 					int nhead, int ntail, int gfp_mask);
 extern struct sk_buff *skb_realloc_headroom(struct sk_buff *skb,
diff -X ../KDIFX -burp linux/include/linux/slab.h linux-2.5.39-work/include/linux/slab.h
--- linux/include/linux/slab.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.39-work/include/linux/slab.h	2002-09-29 16:56:49.000000000 +0200
@@ -55,11 +55,11 @@ extern kmem_cache_t *kmem_cache_create(c
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
-extern void *kmem_cache_alloc(kmem_cache_t *, int);
+extern void *kmem_cache_alloc(kmem_cache_t *, int) malloc_function;
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 
-extern void *kmalloc(size_t, int);
+extern void *kmalloc(size_t, int) malloc_function;
 extern void kfree(const void *);
 
 extern int FASTCALL(kmem_cache_reap(int));
diff -X ../KDIFX -burp linux/include/linux/vmalloc.h linux-2.5.39-work/include/linux/vmalloc.h
--- linux/include/linux/vmalloc.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.39-work/include/linux/vmalloc.h	2002-09-29 17:06:33.000000000 +0200
@@ -21,9 +21,9 @@ struct vm_struct {
 /*
  *	Highlevel APIs for driver use
  */
-extern void *vmalloc(unsigned long size);
-extern void *vmalloc_32(unsigned long size);
-extern void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot);
+extern void *vmalloc(unsigned long size) malloc_function;
+extern void *vmalloc_32(unsigned long size) malloc_function;
+extern void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot) malloc_function;
 extern void vfree(void *addr);
 
 extern void *vmap(struct page **pages, unsigned int count);
