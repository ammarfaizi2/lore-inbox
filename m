Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbTEPFYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 01:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTEPFYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 01:24:32 -0400
Received: from dp.samba.org ([66.70.73.150]:64223 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264150AbTEPFYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 01:24:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, davidm@hpl.hp.com,
       rth@twiddle.net
Subject: [PATCH] Unlimited per-cpu allocation
Date: Fri, 16 May 2003 15:30:36 +1000
Message-Id: <20030516053654.F09242C07C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This goes back to the linked-list of blocks approach I used
initially, with the trick that layout-sensitive (ie. NUMA-aware) archs
can replace new_percpumem, free_percpumem and initial_percpumem with
their own allocators (results must be virtually contiguous).

Limitations:

1) There's a limit on how big each allocation can be, currently 1
   page.  More than that is probably silly at this stage.

2) Allocator is slow, simple, and sleeps.  If you want to start
   allocating every open(), or in interrupts, it's going to need to be
   beefed up: for the moment, I expect 4 or 8 byte allocs to be the
   norm, so fragmentation shouldn't be too bad either.

3) IA64.  It could allocate its 64k in initial_percpumem(), and then
   fail any calls to new_percpumem().  This won't be a problem at the
   moment, but hard choices have to be made if more than 64k of
   per-cpu memory is desirable here.

Looking at the users, I made the allocator zero the mem, too, which
deserved a rename from "kmalloc_percpu" to "alloc_percpu".

Finally, it's tempting to remove the macros and just use "__percpu":
Linus' address-space markings might be sufficient to catch direct
references to per-cpu vars, and archs really don't have much
flexibility of implementation anymore (ie. __thread doesn't play well
with dynamic allocation).

Feedback welcome,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Unlimited per-cpu allocation
Author: Rusty Russell
Status: Tested on 2.5.69-bk8

D: This patch allows an unlimited number of per-cpu allocations.  It
D: is more complex than the "simply allocate a big chunk up front"
D: approach of Misc/kmalloc_percpu.patch.gz, but it has a hook for
D: NUMA-aware allocations (default is alloc_bootmem then vmalloc
D: based).
D: 
D: Given the interface change, kmalloc_percpu is renamed to
D: alloc_percpu, and zeros memory (most callers want that, and it's
D: not completely trivial), and kfree_percpu renamed to free_percpu.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/include/asm-generic/percpu.h .29343-linux-2.5.69-bk10.updated/include/asm-generic/percpu.h
--- .29343-linux-2.5.69-bk10/include/asm-generic/percpu.h	2003-01-02 12:32:47.000000000 +1100
+++ .29343-linux-2.5.69-bk10.updated/include/asm-generic/percpu.h	2003-05-16 08:38:30.000000000 +1000
@@ -2,7 +2,6 @@
 #define _ASM_GENERIC_PERCPU_H_
 #include <linux/compiler.h>
 
-#define __GENERIC_PER_CPU
 #ifdef CONFIG_SMP
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
@@ -17,18 +16,11 @@ extern unsigned long __per_cpu_offset[NR
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
-#else /* ! SMP */
-
-/* Can't define per-cpu variables in modules.  Sorry --RR */
-#ifndef MODULE
-#define DEFINE_PER_CPU(type, name) \
-    __typeof__(type) name##__per_cpu
-#endif
-
-#define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
-#define __get_cpu_var(var)			var##__per_cpu
+#define per_cpu_ptr(ptr, cpu) ((__typeof__(ptr))(RELOC_HIDE(ptr, __per_cpu_offset[cpu])))
+#define __get_cpu_ptr(var) per_cpu_ptr(ptr, smp_processor_id())
 
-#endif	/* SMP */
+void setup_per_cpu_areas(void);
+#endif /* SMP */
 
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/include/asm-i386/percpu.h .29343-linux-2.5.69-bk10.updated/include/asm-i386/percpu.h
--- .29343-linux-2.5.69-bk10/include/asm-i386/percpu.h	2003-01-02 12:00:21.000000000 +1100
+++ .29343-linux-2.5.69-bk10.updated/include/asm-i386/percpu.h	2003-05-16 08:38:30.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ARCH_I386_PERCPU__
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif /* __ARCH_I386_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/include/linux/genhd.h .29343-linux-2.5.69-bk10.updated/include/linux/genhd.h
--- .29343-linux-2.5.69-bk10/include/linux/genhd.h	2003-05-05 12:37:12.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/include/linux/genhd.h	2003-05-16 09:14:37.000000000 +1000
@@ -160,10 +160,9 @@ static inline void disk_stat_set_all(str
 #ifdef  CONFIG_SMP
 static inline int init_disk_stats(struct gendisk *disk)
 {
-	disk->dkstats = kmalloc_percpu(sizeof (struct disk_stats), GFP_KERNEL);
+	disk->dkstats = alloc_percpu(struct disk_stats);
 	if (!disk->dkstats)
 		return 0;
-	disk_stat_set_all(disk, 0);
 	return 1;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/include/linux/percpu.h .29343-linux-2.5.69-bk10.updated/include/linux/percpu.h
--- .29343-linux-2.5.69-bk10/include/linux/percpu.h	2003-02-07 19:20:01.000000000 +1100
+++ .29343-linux-2.5.69-bk10.updated/include/linux/percpu.h	2003-05-16 09:15:12.000000000 +1000
@@ -1,71 +1,66 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
 #include <linux/spinlock.h> /* For preempt_disable() */
-#include <linux/slab.h> /* For kmalloc_percpu() */
+#include <linux/slab.h> /* For kmalloc() */
+#include <linux/cache.h>
+#include <asm/bug.h>
 #include <asm/percpu.h>
+#include <asm/page.h>
 
-/* Must be an lvalue. */
+/* Maximum size allowed for alloc_percpu */
+#define PERCPU_MAX PAGE_SIZE
+
+/* For variables declared with DECLARE_PER_CPU()/DEFINE_PER_CPU(). */
 #define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
+/* Also, per_cpu(var, cpu) to get another cpu's value. */
+
+/* For ptrs allocated with alloc_percpu */
+#define get_cpu_ptr(ptr) ({ preempt_disable(); __get_cpu_ptr(ptr); })
+#define put_cpu_ptr(ptr) preempt_enable()
+/* Also, per_cpu_ptr(ptr, cpu) to get another cpu's value. */
 
 #ifdef CONFIG_SMP
 
-struct percpu_data {
-	void *ptrs[NR_CPUS];
-	void *blkp;
-};
+extern void *__alloc_percpu(size_t size, size_t align);
+extern void free_percpu(const void *);
 
-/* 
- * Use this to get to a cpu's version of the per-cpu object allocated using
- * kmalloc_percpu.  If you want to get "this cpu's version", maybe you want
- * to use get_cpu_ptr... 
- */ 
-#define per_cpu_ptr(ptr, cpu)                   \
-({                                              \
-        struct percpu_data *__p = (struct percpu_data *)~(unsigned long)(ptr); \
-        (__typeof__(ptr))__p->ptrs[(cpu)];	\
-})
+extern unsigned long percpu_block_size;
 
-extern void *kmalloc_percpu(size_t size, int flags);
-extern void kfree_percpu(const void *);
-extern void kmalloc_percpu_init(void);
+#else /* !CONFIG_SMP */
 
-#else /* CONFIG_SMP */
+/* Can't define per-cpu variables in modules.  Sorry --RR */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __typeof__(type) name##__per_cpu
+#endif
 
-#define per_cpu_ptr(ptr, cpu) (ptr)
+#define per_cpu(var, cpu)			((void)(cpu), var##__per_cpu)
+#define __get_cpu_var(var)			var##__per_cpu
+#define per_cpu_ptr(ptr, cpu)			((void)(cpu), (ptr))
+#define __get_cpu_ptr(ptr)			(ptr)
 
-static inline void *kmalloc_percpu(size_t size, int flags)
+static inline void *__alloc_percpu(size_t size, size_t align)
 {
-	return(kmalloc(size, flags));
+	void *ret;
+
+	/* kmalloc always cacheline aligns. */
+	BUG_ON(align > SMP_CACHE_BYTES);
+	BUG_ON(size > PERCPU_MAX);
+	ret = kmalloc(size, GFP_KERNEL);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
 }
-static inline void kfree_percpu(const void *ptr)
+static inline void free_percpu(const void *ptr)
 {	
 	kfree(ptr);
 }
-static inline void kmalloc_percpu_init(void) { }
 
 #endif /* CONFIG_SMP */
 
-/* 
- * Use these with kmalloc_percpu. If
- * 1. You want to operate on memory allocated by kmalloc_percpu (dereference
- *    and read/modify/write)  AND 
- * 2. You want "this cpu's version" of the object AND 
- * 3. You want to do this safely since:
- *    a. On multiprocessors, you don't want to switch between cpus after 
- *    you've read the current processor id due to preemption -- this would 
- *    take away the implicit  advantage to not have any kind of traditional 
- *    serialization for per-cpu data
- *    b. On uniprocessors, you don't want another kernel thread messing
- *    up with the same per-cpu data due to preemption
- *    
- * So, Use get_cpu_ptr to disable preemption and get pointer to the 
- * local cpu version of the per-cpu object. Use put_cpu_ptr to enable
- * preemption.  Operations on per-cpu data between get_ and put_ is
- * then considered to be safe. And ofcourse, "Thou shalt not sleep between 
- * get_cpu_ptr and put_cpu_ptr"
- */
-#define get_cpu_ptr(ptr) per_cpu_ptr(ptr, get_cpu())
-#define put_cpu_ptr(ptr) put_cpu()
+/* Simple wrapper for the common case. */
+#define alloc_percpu(type) \
+	((type *)(__alloc_percpu(sizeof(type), __alignof__(type))))
 
 #endif /* __LINUX_PERCPU_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/include/net/ipv6.h .29343-linux-2.5.69-bk10.updated/include/net/ipv6.h
--- .29343-linux-2.5.69-bk10/include/net/ipv6.h	2003-05-16 08:08:43.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/include/net/ipv6.h	2003-05-16 08:38:30.000000000 +1000
@@ -145,7 +145,7 @@ extern atomic_t			inet6_sock_nr;
 
 int snmp6_register_dev(struct inet6_dev *idev);
 int snmp6_unregister_dev(struct inet6_dev *idev);
-int snmp6_mib_init(void *ptr[2], size_t mibsize);
+int snmp6_mib_init(void *ptr[2], size_t mibsize, size_t mibalign);
 void snmp6_mib_free(void *ptr[2]);
 
 struct ip6_ra_chain
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/init/main.c .29343-linux-2.5.69-bk10.updated/init/main.c
--- .29343-linux-2.5.69-bk10/init/main.c	2003-05-16 08:08:44.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/init/main.c	2003-05-16 08:38:30.000000000 +1000
@@ -306,30 +306,6 @@ static inline void smp_prepare_cpus(unsi
 
 #else
 
-#ifdef __GENERIC_PER_CPU
-unsigned long __per_cpu_offset[NR_CPUS];
-
-static void __init setup_per_cpu_areas(void)
-{
-	unsigned long size, i;
-	char *ptr;
-	/* Created by linker magic */
-	extern char __per_cpu_start[], __per_cpu_end[];
-
-	/* Copy section for each CPU (we discard the original) */
-	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
-	if (!size)
-		return;
-
-	ptr = alloc_bootmem(size * NR_CPUS);
-
-	for (i = 0; i < NR_CPUS; i++, ptr += size) {
-		__per_cpu_offset[i] = ptr - __per_cpu_start;
-		memcpy(ptr, __per_cpu_start, size);
-	}
-}
-#endif /* !__GENERIC_PER_CPU */
-
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/kernel/ksyms.c .29343-linux-2.5.69-bk10.updated/kernel/ksyms.c
--- .29343-linux-2.5.69-bk10/kernel/ksyms.c	2003-05-16 08:08:44.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/kernel/ksyms.c	2003-05-16 09:14:41.000000000 +1000
@@ -98,8 +98,8 @@ EXPORT_SYMBOL(remove_shrinker);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(kmalloc_percpu);
-EXPORT_SYMBOL(kfree_percpu);
+EXPORT_SYMBOL(__alloc_percpu);
+EXPORT_SYMBOL(free_percpu);
 EXPORT_SYMBOL(percpu_counter_mod);
 #endif
 EXPORT_SYMBOL(vfree);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/mm/Makefile .29343-linux-2.5.69-bk10.updated/mm/Makefile
--- .29343-linux-2.5.69-bk10/mm/Makefile	2003-02-11 14:26:20.000000000 +1100
+++ .29343-linux-2.5.69-bk10.updated/mm/Makefile	2003-05-16 08:38:30.000000000 +1000
@@ -12,3 +12,4 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SMP)	+= percpu.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/mm/percpu.c .29343-linux-2.5.69-bk10.updated/mm/percpu.c
--- .29343-linux-2.5.69-bk10/mm/percpu.c	1970-01-01 10:00:00.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/mm/percpu.c	2003-05-16 09:20:17.000000000 +1000
@@ -0,0 +1,442 @@
+/*
+ * Dynamic per-cpu allocation.
+ * Originally by Dipankar Sarma <dipankar@in.ibm.com>
+ * This version (C) 2003 Rusty Russell, IBM Corporation.
+ */
+
+/* Simple linked list allocator: we don't stress it hard, but do want
+   it space-efficient.  We keep the bookkeeping separately. */
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include <linux/string.h>
+#include <linux/percpu.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <linux/bootmem.h>
+#include <asm/semaphore.h>
+
+/* Created by linker magic */
+extern char __per_cpu_start[], __per_cpu_end[];
+
+static DECLARE_MUTEX(pcpu_lock);
+static LIST_HEAD(pcpu_blocks);
+static void *percpu_base; /* Initial per-cpu allocation. */
+unsigned long percpu_block_size;
+
+#ifdef __NEED_PERCPU_ALLOC
+static inline void *new_percpumem(size_t size)
+{
+	return vmalloc(size * NR_CPUS);
+}
+
+static inline void free_percpumem(void *ptr, size_t size)
+{
+	vfree(ptr);
+}
+
+static inline void *initial_percpumem(unsigned long *size)
+{
+	void *ptr;
+	unsigned int i;
+
+	ptr = alloc_bootmem(*size * NR_CPUS);
+	for (i = 0; i < NR_CPUS; i++) {
+		__per_cpu_offset[i] = ptr + *size*i - (void *)__per_cpu_start;
+		memcpy(ptr + *size*i, __per_cpu_start,
+		       __per_cpu_end - __per_cpu_start);
+	}
+	return ptr;
+}
+#endif
+
+struct pcpu_block
+{
+	struct list_head list;
+
+	/* Pointer to actual allocated memory. */
+	void *base_ptr;
+
+	/* Number of blocks used and allocated. */
+	unsigned short num_used, num_allocated;
+
+	/* Size of each block.  -ve means used. */
+	int size[0];
+};
+
+static struct pcpu_block *split_block(struct pcpu_block *b,
+				      unsigned int i,
+				      unsigned short size)
+{
+	/* Reallocation required? */
+	if (b->num_used + 1 > b->num_allocated) {
+		struct pcpu_block *new;
+
+		new = kmalloc(sizeof(*b)
+			      + sizeof(b->size[0]) * b->num_allocated*2,
+			      GFP_KERNEL);
+		if (!new)
+			return NULL;
+		new->base_ptr = b->base_ptr;
+		new->num_used = b->num_used;
+		new->num_allocated = b->num_allocated * 2;
+		memcpy(new->size, b->size, sizeof(b->size[0])*b->num_used);
+		list_del(&b->list);
+		list_add(&new->list, &pcpu_blocks);
+		kfree(b);
+		b = new;
+	}
+
+	/* Insert a new subblock */
+	memmove(&b->size[i+1], &b->size[i],
+		sizeof(b->size[0]) * (b->num_used - i));
+	b->num_used++;
+
+	b->size[i+1] -= size;
+	b->size[i] = size;
+	return b;
+}
+
+#define PERCPU_INIT_BLOCKS 4
+
+static int new_block(void)
+{
+	struct pcpu_block *b;
+
+	b = kmalloc(sizeof(*b) + PERCPU_INIT_BLOCKS*sizeof(int), GFP_KERNEL);
+	if (!b)
+		return 0;
+
+	b->base_ptr = new_percpumem(percpu_block_size);
+	if (!b->base_ptr) {
+		kfree(b);
+		return 0;
+	}
+
+	b->num_allocated = PERCPU_INIT_BLOCKS;
+	b->num_used = 1;
+	b->size[0] = percpu_block_size;
+
+	list_add(&b->list, &pcpu_blocks);
+	return 1;
+}
+
+static inline unsigned int abs(int val)
+{
+	if (val < 0)
+		return -val;
+	return val;
+}
+
+static int allocs, frees;
+
+void *__alloc_percpu(size_t size, size_t align)
+{
+	struct pcpu_block *b;
+	unsigned long extra;
+	void *ret;
+
+	allocs++;
+	BUG_ON(align > SMP_CACHE_BYTES);
+	BUG_ON(size > PERCPU_MAX);
+	BUG_ON(!percpu_block_size);
+
+	down(&pcpu_lock);
+ again:
+	list_for_each_entry(b, &pcpu_blocks, list) {
+		unsigned int i;
+		void *ptr = b->base_ptr;
+
+		for (i = 0; i < b->num_used; ptr += abs(b->size[i]), i++) {
+			/* Extra for alignment requirement. */
+			extra = ALIGN((unsigned long)ptr, align)
+				- (unsigned long)ptr;
+			BUG_ON(i == 0 && extra != 0);
+
+			if (b->size[i] < 0 || b->size[i] < extra + size)
+				continue;
+
+			/* Transfer extra to previous block. */
+			if (b->size[i-1] < 0)
+				b->size[i-1] -= extra;
+			else
+				b->size[i-1] += extra;
+			b->size[i] -= extra;
+			ptr += extra;
+
+			/* Split block if warranted */
+			if (b->size[i] - size > sizeof(unsigned long)) {
+				struct pcpu_block *realloc;
+				realloc = split_block(b, i, size);
+				if (!realloc)
+					continue;
+				b = realloc;
+			}
+
+			/* Mark allocated */
+			b->size[i] = -b->size[i];
+			/* Pointer will be offset by this: compensate. */ 
+			ret = RELOC_HIDE(ptr, -(percpu_base 
+						- (void *)__per_cpu_start));
+			for (i = 0; i < NR_CPUS; i++)
+				if (cpu_possible(i))
+					memset(per_cpu_ptr(ret, i), 0, size);
+			goto done;
+		}
+	}
+
+	if (new_block())
+		goto again;
+
+	ret =  NULL;
+ done:
+	up(&pcpu_lock);
+	return ret;
+}
+
+static void free_block(struct pcpu_block *b, unsigned int i)
+{
+	/* Block should be used. */
+	BUG_ON(b->size[i] >= 0);
+	b->size[i] = -b->size[i];
+
+	/* Merge with previous? */
+	if (i > 0 && b->size[i-1] >= 0) {
+		b->size[i-1] += b->size[i];
+		b->num_used--;
+		memmove(&b->size[i], &b->size[i+1],
+			(b->num_used - i) * sizeof(b->size[0]));
+		i--;
+	}
+	/* Merge with next? */
+	if (i+1 < b->num_used && b->size[i+1] >= 0) {
+		b->size[i] += b->size[i+1];
+		b->num_used--;
+		memmove(&b->size[i+1], &b->size[i+2],
+			(b->num_used - (i+1)) * sizeof(b->size[0]));
+	}
+	/* Empty? */
+	if (b->num_used == 1) {
+		BUG_ON(b->base_ptr == percpu_base);
+		list_del(&b->list);
+		free_percpumem(b->base_ptr, percpu_block_size);
+		kfree(b);
+	}
+}
+
+void free_percpu(const void *freeme)
+{
+	struct pcpu_block *b;
+
+	frees++;
+	/* Pointer will be offset by this amount: compensate. */ 
+	freeme = RELOC_HIDE(freeme, percpu_base - (void *)__per_cpu_start);
+	down(&pcpu_lock);
+	list_for_each_entry(b, &pcpu_blocks, list) {
+		unsigned int i;
+		void *ptr = b->base_ptr;
+
+		for (i = 0; i < b->num_used; ptr += abs(b->size[i]), i++) {
+			if (ptr == freeme) {
+				free_block(b, i);
+				up(&pcpu_lock);
+				return;
+			}
+		}
+	}
+	up(&pcpu_lock);
+	BUG();
+}
+
+#if 1
+#include <linux/random.h>
+
+static void check_values(unsigned int *ptrs[],
+			 unsigned int sizes[],
+			 unsigned int num)
+{
+	unsigned int cpu, i;
+	unsigned char *ptr;
+
+	if (!ptrs[num])
+		return;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		ptr = (unsigned char *)per_cpu_ptr(ptrs[num], cpu);
+		for (i = 0; i < sizes[num]; i++) {
+			if (ptr[i] != (unsigned char)(num + cpu))
+				BUG();
+		}
+	}
+}
+
+static void check_blocklen(void)
+{
+	struct pcpu_block *i;
+	unsigned int count = 0;
+
+	list_for_each_entry(i, &pcpu_blocks, list)
+		count++;
+
+	printk("Total blocks = %u\n", count);
+}
+
+static void dump_blocks(int start)
+{
+	struct pcpu_block *i;
+
+	list_for_each_entry(i, &pcpu_blocks, list) {
+		int expected_blocks = 1;
+
+		if (i->base_ptr == percpu_base)
+			expected_blocks = 2;
+		if (i->num_used != expected_blocks) {
+			printk("Block %p has %u subs at %s\n",
+			       i->base_ptr, i->num_used, start ? start : end);
+		}
+	}
+}	
+
+static void mymemset(void *ptr, int c, unsigned long len)
+{
+	unsigned char *p = ptr;
+	while (len > 0) {
+		*p = c;
+		p++;
+		len--;
+	}
+}		
+
+static int random(void)
+{
+	unsigned short s;
+
+	get_random_bytes(&s, sizeof(s));
+	return s;
+}
+
+static int test_percpu(void)
+{
+	unsigned int i;
+	unsigned int *ptr;
+	static unsigned int *ptrs[PERCPU_MAX], sizes[PERCPU_MAX];
+
+	dump_blocks();
+	allocs = frees = 0;
+	ptr = __alloc_percpu(4, 4);
+	printk("This cpu = %p (%u)\n",
+	       __get_cpu_ptr(ptr), *__get_cpu_ptr(ptr));
+	for (i = 0; i < NR_CPUS; i++) {
+		printk("&ptr[i] == %p (%u)\n",
+		       per_cpu_ptr(ptr, i), *per_cpu_ptr(ptr, i));
+		*per_cpu_ptr(ptr, i) = i;
+	}
+	free_percpu(ptr);
+
+	BUG_ON(allocs != frees);
+
+	for (i = 4; i < PERCPU_MAX; i+=27) {
+		unsigned int j;
+		ptrs[i] = __alloc_percpu(i, 4);
+		for (j = 0; j < NR_CPUS; j++) {
+			mymemset(per_cpu_ptr(ptrs[i], j), 0, i);
+			*per_cpu_ptr(ptrs[i], j) = i;
+		}
+	}
+
+	for (i = 4; i < PERCPU_MAX; i+=27) {
+		unsigned int j;
+		for (j = 0; j < NR_CPUS; j++)
+			if (*per_cpu_ptr(ptrs[i], j) != i)
+				BUG();
+	}
+	for (i = 4; i < PERCPU_MAX; i+=27) {
+		free_percpu(ptrs[i]);
+		ptrs[i] = NULL;
+	}
+
+	BUG_ON(allocs != frees);
+
+	/* Randomized test. */
+	for (i = 0; i < 10000; i++) {
+		unsigned int j = random() % PERCPU_MAX;
+		if (!ptrs[j]) {
+			unsigned int cpu;
+
+			sizes[j] = random() % PERCPU_MAX;
+			if (sizes[j] < 4)
+				sizes[j] = 4;
+			ptrs[j] = __alloc_percpu(sizes[j], 1<<(random()%L1_CACHE_SHIFT));
+
+			for (cpu = 0; cpu < NR_CPUS; cpu++)
+				memset(per_cpu_ptr(ptrs[j], cpu), j+cpu,
+				       sizes[j]);
+		} else {
+			if (random() % 1000 == 0) {
+				printk("c\n");
+				for (j = 0; j < PERCPU_MAX; j++)
+					check_values(ptrs, sizes, j);
+			} else {
+				check_values(ptrs, sizes, j);
+				free_percpu(ptrs[j]);
+				ptrs[j] = NULL;
+			}
+		}
+		if (i % (10000/10) == 0)
+			printk(".\n");
+	}
+	check_blocklen();
+
+	for (i = 0; i < PERCPU_MAX; i++) {
+		if (ptrs[i]) {
+			free_percpu(ptrs[i]);
+			ptrs[i] = NULL;
+		}
+	}
+	BUG_ON(allocs != frees);
+	dump_blocks();
+	return 0;
+}
+late_initcall(test_percpu);
+#endif
+
+unsigned long __per_cpu_offset[NR_CPUS];
+EXPORT_SYMBOL(__per_cpu_offset);
+
+void __init setup_per_cpu_areas(void)
+{
+	/* Idempotent (some archs call this earlier). */
+	if (percpu_block_size)
+		return;
+
+	/* Copy section for each CPU (we discard the original) */
+	percpu_block_size = ALIGN(__per_cpu_end - __per_cpu_start,
+				  SMP_CACHE_BYTES);
+	/* We guarantee at least this much. */
+	if (percpu_block_size < PERCPU_MAX)
+		percpu_block_size = PERCPU_MAX;
+
+	percpu_base = initial_percpumem(&percpu_block_size);
+}
+
+static int init_alloc_percpu(void)
+{
+	struct pcpu_block *pcpu;
+
+	printk("Per-cpu data: %Zu of %lu bytes at %p\n",
+	       __per_cpu_end - __per_cpu_start, percpu_block_size,
+	       percpu_base);
+
+	pcpu = kmalloc(sizeof(*pcpu)+sizeof(pcpu->size[0])*PERCPU_INIT_BLOCKS,
+		       GFP_KERNEL);
+	pcpu->num_allocated = PERCPU_INIT_BLOCKS;
+	pcpu->num_used = 2; /* Static block, and free block */
+	pcpu->size[0] = -(__per_cpu_end - __per_cpu_start);
+	pcpu->size[1] = percpu_block_size-(__per_cpu_end - __per_cpu_start);
+	pcpu->base_ptr = percpu_base;
+	list_add(&pcpu->list, &pcpu_blocks);
+
+	return 0;
+}
+core_initcall(init_alloc_percpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/mm/slab.c .29343-linux-2.5.69-bk10.updated/mm/slab.c
--- .29343-linux-2.5.69-bk10/mm/slab.c	2003-05-16 08:08:44.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/mm/slab.c	2003-05-16 08:38:30.000000000 +1000
@@ -1937,54 +1937,6 @@ void * kmalloc (size_t size, int flags)
 	return NULL;
 }
 
-#ifdef CONFIG_SMP
-/**
- * kmalloc_percpu - allocate one copy of the object for every present
- * cpu in the system.
- * Objects should be dereferenced using per_cpu_ptr/get_cpu_ptr
- * macros only.
- *
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
- * The @flags argument may be one of:
- *
- * %GFP_USER - Allocate memory on behalf of user.  May sleep.
- *
- * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
- *
- * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
- */
-void *
-kmalloc_percpu(size_t size, int flags)
-{
-	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), flags);
-
-	if (!pdata)
-		return NULL;
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-		pdata->ptrs[i] = kmalloc(size, flags);
-		if (!pdata->ptrs[i])
-			goto unwind_oom;
-	}
-
-	/* Catch derefs w/o wrappers */
-	return (void *) (~(unsigned long) pdata);
-
-unwind_oom:
-	while (--i >= 0) {
-		if (!cpu_possible(i))
-			continue;
-		kfree(pdata->ptrs[i]);
-	}
-	kfree(pdata);
-	return NULL;
-}
-#endif
-
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
@@ -2023,28 +1975,6 @@ void kfree (const void *objp)
 	local_irq_restore(flags);
 }
 
-#ifdef CONFIG_SMP
-/**
- * kfree_percpu - free previously allocated percpu memory
- * @objp: pointer returned by kmalloc_percpu.
- *
- * Don't free memory not originally allocated by kmalloc_percpu()
- * The complemented objp is to check for that.
- */
-void
-kfree_percpu(const void *objp)
-{
-	int i;
-	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-		kfree(p->ptrs[i]);
-	}
-}
-#endif
-
 unsigned int kmem_cache_size(kmem_cache_t *cachep)
 {
 	unsigned int objlen = cachep->objsize;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/net/ipv4/af_inet.c .29343-linux-2.5.69-bk10.updated/net/ipv4/af_inet.c
--- .29343-linux-2.5.69-bk10/net/ipv4/af_inet.c	2003-05-16 08:08:45.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/net/ipv4/af_inet.c	2003-05-16 09:15:30.000000000 +1000
@@ -1070,52 +1070,22 @@ static int __init init_ipv4_mibs(void)
 {
 	int i;
 
-	net_statistics[0] =
-	    kmalloc_percpu(sizeof (struct linux_mib), GFP_KERNEL);
-	net_statistics[1] =
-	    kmalloc_percpu(sizeof (struct linux_mib), GFP_KERNEL);
-	ip_statistics[0] = kmalloc_percpu(sizeof (struct ip_mib), GFP_KERNEL);
-	ip_statistics[1] = kmalloc_percpu(sizeof (struct ip_mib), GFP_KERNEL);
-	icmp_statistics[0] =
-	    kmalloc_percpu(sizeof (struct icmp_mib), GFP_KERNEL);
-	icmp_statistics[1] =
-	    kmalloc_percpu(sizeof (struct icmp_mib), GFP_KERNEL);
-	tcp_statistics[0] = kmalloc_percpu(sizeof (struct tcp_mib), GFP_KERNEL);
-	tcp_statistics[1] = kmalloc_percpu(sizeof (struct tcp_mib), GFP_KERNEL);
-	udp_statistics[0] = kmalloc_percpu(sizeof (struct udp_mib), GFP_KERNEL);
-	udp_statistics[1] = kmalloc_percpu(sizeof (struct udp_mib), GFP_KERNEL);
+	net_statistics[0] = alloc_percpu(struct linux_mib);
+	net_statistics[1] = alloc_percpu(struct linux_mib);
+	ip_statistics[0] = alloc_percpu(struct ip_mib);
+	ip_statistics[1] = alloc_percpu(struct ip_mib);
+	icmp_statistics[0] = alloc_percpu(struct icmp_mib);
+	icmp_statistics[1] = alloc_percpu(struct icmp_mib);
+	tcp_statistics[0] = alloc_percpu(struct tcp_mib);
+	tcp_statistics[1] = alloc_percpu(struct tcp_mib);
+	udp_statistics[0] = alloc_percpu(struct udp_mib);
+	udp_statistics[1] = alloc_percpu(struct udp_mib);
 	if (!
 	    (net_statistics[0] && net_statistics[1] && ip_statistics[0]
 	     && ip_statistics[1] && tcp_statistics[0] && tcp_statistics[1]
 	     && udp_statistics[0] && udp_statistics[1]))
 		return -ENOMEM;
 
-	/* Set all the per cpu copies of the mibs to zero */
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(net_statistics[0], i), 0,
-			       sizeof (struct linux_mib));
-			memset(per_cpu_ptr(net_statistics[1], i), 0,
-			       sizeof (struct linux_mib));
-			memset(per_cpu_ptr(ip_statistics[0], i), 0,
-			       sizeof (struct ip_mib));
-			memset(per_cpu_ptr(ip_statistics[1], i), 0,
-			       sizeof (struct ip_mib));
-			memset(per_cpu_ptr(icmp_statistics[0], i), 0,
-			       sizeof (struct icmp_mib));
-			memset(per_cpu_ptr(icmp_statistics[1], i), 0,
-			       sizeof (struct icmp_mib));
-			memset(per_cpu_ptr(tcp_statistics[0], i), 0,
-			       sizeof (struct tcp_mib));
-			memset(per_cpu_ptr(tcp_statistics[1], i), 0,
-			       sizeof (struct tcp_mib));
-			memset(per_cpu_ptr(udp_statistics[0], i), 0,
-			       sizeof (struct udp_mib));
-			memset(per_cpu_ptr(udp_statistics[1], i), 0,
-			       sizeof (struct udp_mib));
-		}
-	}
-
 	(void) tcp_mib_init();
 
 	return 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/net/ipv4/route.c .29343-linux-2.5.69-bk10.updated/net/ipv4/route.c
--- .29343-linux-2.5.69-bk10/net/ipv4/route.c	2003-05-16 08:08:46.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/net/ipv4/route.c	2003-05-16 09:20:19.000000000 +1000
@@ -2692,16 +2692,9 @@ int __init ip_rt_init(void)
 	ipv4_dst_ops.gc_thresh = (rt_hash_mask + 1);
 	ip_rt_max_size = (rt_hash_mask + 1) * 16;
 
-	rt_cache_stat = kmalloc_percpu(sizeof (struct rt_cache_stat),
-					GFP_KERNEL);
+	rt_cache_stat = alloc_percpu(struct rt_cache_stat);
 	if (!rt_cache_stat) 
 		goto out_enomem1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(rt_cache_stat, i), 0,
-			       sizeof (struct rt_cache_stat));
-		}
-	}
 
 	devinet_init();
 	ip_fib_init();
@@ -2737,7 +2730,7 @@ int __init ip_rt_init(void)
 out:
 	return rc;
 out_enomem:
-	kfree_percpu(rt_cache_stat);
+	free_percpu(rt_cache_stat);
 out_enomem1:
 	rc = -ENOMEM;
 	goto out;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/net/ipv6/af_inet6.c .29343-linux-2.5.69-bk10.updated/net/ipv6/af_inet6.c
--- .29343-linux-2.5.69-bk10/net/ipv6/af_inet6.c	2003-05-16 08:08:47.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/net/ipv6/af_inet6.c	2003-05-16 09:20:27.000000000 +1000
@@ -637,32 +637,25 @@ inet6_unregister_protosw(struct inet_pro
 }
 
 int
-snmp6_mib_init(void *ptr[2], size_t mibsize)
+snmp6_mib_init(void *ptr[2], size_t mibsize, size_t mibalign)
 {
 	int i;
 
 	if (ptr == NULL)
 		return -EINVAL;
 
-	ptr[0] = kmalloc_percpu(mibsize, GFP_KERNEL);
+	ptr[0] = __alloc_percpu(mibsize, mibalign);
 	if (!ptr[0])
 		goto err0;
 
-	ptr[1] = kmalloc_percpu(mibsize, GFP_KERNEL);
+	ptr[1] = __alloc_percpu(mibsize, mibalign);
 	if (!ptr[1])
 		goto err1;
 
-	/* Zero percpu version of the mibs */
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(ptr[0], i), 0, mibsize);
-			memset(per_cpu_ptr(ptr[1], i), 0, mibsize);
-		}
-	}
 	return 0;
 
 err1:
-	kfree_percpu(ptr[0]);
+	free_percpu(ptr[0]);
 	ptr[0] = NULL;
 err0:
 	return -ENOMEM;
@@ -673,18 +666,21 @@ snmp6_mib_free(void *ptr[2])
 {
 	if (ptr == NULL)
 		return;
-	kfree_percpu(ptr[0]);
-	kfree_percpu(ptr[1]);
+	free_percpu(ptr[0]);
+	free_percpu(ptr[1]);
 	ptr[0] = ptr[1] = NULL;
 }
 
 static int __init init_ipv6_mibs(void)
 {
-	if (snmp6_mib_init((void **)ipv6_statistics, sizeof (struct ipv6_mib)) < 0)
+	if (snmp6_mib_init((void **)ipv6_statistics, sizeof (struct ipv6_mib),
+			   __alignof__(struct ipv6_mib)) < 0)
 		goto err_ip_mib;
-	if (snmp6_mib_init((void **)icmpv6_statistics, sizeof (struct icmpv6_mib)) < 0)
+	if (snmp6_mib_init((void **)icmpv6_statistics, sizeof (struct icmpv6_mib),
+			   __alignof__(struct ipv6_mib)) < 0)
 		goto err_icmp_mib;
-	if (snmp6_mib_init((void **)udp_stats_in6, sizeof (struct udp_mib)) < 0)
+	if (snmp6_mib_init((void **)udp_stats_in6, sizeof (struct udp_mib),
+			   __alignof__(struct ipv6_mib)) < 0)
 		goto err_udp_mib;
 	return 0;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/net/ipv6/proc.c .29343-linux-2.5.69-bk10.updated/net/ipv6/proc.c
--- .29343-linux-2.5.69-bk10/net/ipv6/proc.c	2003-05-16 08:08:47.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/net/ipv6/proc.c	2003-05-16 08:38:30.000000000 +1000
@@ -228,7 +228,8 @@ int snmp6_register_dev(struct inet6_dev 
 	if (!idev || !idev->dev)
 		return -EINVAL;
 
-	if (snmp6_mib_init((void **)idev->stats.icmpv6, sizeof(struct icmpv6_mib)) < 0)
+	if (snmp6_mib_init((void **)idev->stats.icmpv6, sizeof(struct icmpv6_mib),
+			   __alignof__(struct ipv6_mib)) < 0)
 		goto err_icmp;
 
 #ifdef CONFIG_PROC_FS
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29343-linux-2.5.69-bk10/net/sctp/protocol.c .29343-linux-2.5.69-bk10.updated/net/sctp/protocol.c
--- .29343-linux-2.5.69-bk10/net/sctp/protocol.c	2003-05-16 08:08:49.000000000 +1000
+++ .29343-linux-2.5.69-bk10.updated/net/sctp/protocol.c	2003-05-16 09:20:31.000000000 +1000
@@ -880,34 +880,22 @@ static int __init init_sctp_mibs(void)
 {
 	int i;
 
-	sctp_statistics[0] = kmalloc_percpu(sizeof (struct sctp_mib),
-					    GFP_KERNEL);
+	sctp_statistics[0] = alloc_percpu(struct sctp_mib);
 	if (!sctp_statistics[0])
 		return -ENOMEM;
-	sctp_statistics[1] = kmalloc_percpu(sizeof (struct sctp_mib),
-					    GFP_KERNEL);
+	sctp_statistics[1] = alloc_percpu(struct sctp_mib);
 	if (!sctp_statistics[1]) {
-		kfree_percpu(sctp_statistics[0]);
+		free_percpu(sctp_statistics[0]);
 		return -ENOMEM;
 	}
-
-	/* Zero all percpu versions of the mibs */
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(sctp_statistics[0], i), 0,
-					sizeof (struct sctp_mib));
-			memset(per_cpu_ptr(sctp_statistics[1], i), 0,
-					sizeof (struct sctp_mib));
-		}
-	}
 	return 0;
 
 }
 
 static void cleanup_sctp_mibs(void)
 {
-	kfree_percpu(sctp_statistics[0]);
-	kfree_percpu(sctp_statistics[1]);
+	free_percpu(sctp_statistics[0]);
+	free_percpu(sctp_statistics[1]);
 }
 
 /* Initialize the universe into something sensible.  */
