Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTETEUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 00:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTETEUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 00:20:48 -0400
Received: from dp.samba.org ([66.70.73.150]:32702 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263535AbTETEUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 00:20:33 -0400
Subject: [PATCH 4/3] Replace dynamic percpu implementation
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Date: Tue, 20 May 2003 14:32:37 +1000
Message-Id: <20030520043332.E80372C09D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This requires the first three patches.  IA64 untested.  See comment.

Name: Dynamic per-cpu allocation using static per-cpu mechanism
Author: Rusty Russell
Status: Tested on 2.5.69-bk13
Depends: Misc/kmalloc_percpu-interface.patch.gz

D: This patch replaces the dynamic per-cpu allocator, alloc_percpu,
D: to make it use the same mechanism as the static per-cpu variables, ie.
D: ptr + __per_cpu_offset[smp_processor_id()] gives the variable address.
D: This allows it to be used in modules (following patch), and hopefully
D: increases space and time efficiency of reference at the same time.
D: It gets moved to its own (SMP-only) file: mm/percpu.c.
D: 
D: The basic idea is that when we need more memory, we allocate
D: another NR_CPUS*sizeof(.data.percpu section), and hand allocations
D: out from that (minus the __per_cpu_offset, which is set at boot
D: from the difference between the .data.percpu section and the
D: initial NR_CPUS*sizeof(.data.percpu section) allocation.
D: 
D: The situation is made trickier by archs which want to allocate
D: per-cpu memory near the CPUs which use them: hooks are provided for
D: the initial alloc (initial_percpumem(), which can also change the
D: size of the allocation, eg. to page-align), new_percpumem(), and
D: free_percpumem().  Defining __NEED_PERCPU_ALLOC gets the default
D: implementations (basically: alloc_bootmem, vmalloc and free
D: respectively).
D: 
D: Finally, IA64 uses the trick of mapping the local per-cpu area to
D: the same location on each CPU, but it's a fixed mapping of 64k.
D: This trivially maps to an initial_percpumem which always allocates
D: 64k, and a new_percpumem which always returns NULL.  This will prove
D: to be insufficient if per-cpu allocations become widespread: (see
D: comment).  IA64 code is untested.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-alpha/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-alpha/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-alpha/percpu.h	2003-01-02 12:25:14.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/include/asm-alpha/percpu.h	2003-05-20 12:59:17.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ALPHA_PERCPU_H
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif /* __ALPHA_PERCPU_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-generic/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-generic/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-generic/percpu.h	2003-05-20 12:57:17.000000000 +1000
+++ .31630-linux-2.5.69-bk13.updated/include/asm-generic/percpu.h	2003-05-20 12:57:19.000000000 +1000
@@ -2,7 +2,6 @@
 #define _ASM_GENERIC_PERCPU_H_
 #include <linux/compiler.h>
 
-#define __GENERIC_PER_CPU
 #ifdef CONFIG_SMP
 
 /* Separate out the type, so (int[3], foo) works. */
@@ -12,7 +11,7 @@
 #endif
 
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
-
+#define __get_cpu_ptr(ptr) per_cpu_ptr(ptr, smp_processor_id())
 #endif	/* SMP */
 
 #endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-h8300/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-h8300/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-h8300/percpu.h	2003-04-20 18:05:12.000000000 +1000
+++ .31630-linux-2.5.69-bk13.updated/include/asm-h8300/percpu.h	2003-05-20 12:59:37.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ARCH_H8300_PERCPU__
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif /* __ARCH_H8300_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-i386/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-i386/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-i386/percpu.h	2003-01-02 12:00:21.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/include/asm-i386/percpu.h	2003-05-20 12:57:19.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ARCH_I386_PERCPU__
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif /* __ARCH_I386_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-m68k/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-m68k/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-m68k/percpu.h	2003-01-02 12:33:55.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/include/asm-m68k/percpu.h	2003-05-20 13:00:01.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ASM_M68K_PERCPU_H
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif	/* __ASM_M68K_PERCPU_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-parisc/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-parisc/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-parisc/percpu.h	2003-01-02 12:32:48.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/include/asm-parisc/percpu.h	2003-05-20 13:01:07.000000000 +1000
@@ -2,6 +2,7 @@
 #define _PARISC_PERCPU_H
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-ppc/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-ppc/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-ppc/percpu.h	2003-01-02 12:00:21.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/include/asm-ppc/percpu.h	2003-05-20 13:01:19.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ARCH_PPC_PERCPU__
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif /* __ARCH_PPC_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-s390/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-s390/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-s390/percpu.h	2003-01-02 12:06:24.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/include/asm-s390/percpu.h	2003-05-20 13:02:50.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ARCH_S390_PERCPU__
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif /* __ARCH_S390_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-sparc/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-sparc/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-sparc/percpu.h	2003-01-02 12:02:23.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/include/asm-sparc/percpu.h	2003-05-20 13:03:12.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ARCH_SPARC_PERCPU__
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif /* __ARCH_SPARC_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-sparc64/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-sparc64/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-sparc64/percpu.h	2003-01-02 12:02:23.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/include/asm-sparc64/percpu.h	2003-05-20 13:03:20.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ARCH_SPARC64_PERCPU__
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif /* __ARCH_SPARC64_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/asm-x86_64/percpu.h .31630-linux-2.5.69-bk13.updated/include/asm-x86_64/percpu.h
--- .31630-linux-2.5.69-bk13/include/asm-x86_64/percpu.h	2003-01-02 12:32:48.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/include/asm-x86_64/percpu.h	2003-05-20 13:03:29.000000000 +1000
@@ -2,5 +2,6 @@
 #define __ARCH_I386_PERCPU__
 
 #include <asm-generic/percpu.h>
+#define __NEED_PERCPU_ALLOC
 
 #endif /* __ARCH_I386_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/include/linux/percpu.h .31630-linux-2.5.69-bk13.updated/include/linux/percpu.h
--- .31630-linux-2.5.69-bk13/include/linux/percpu.h	2003-05-20 12:57:17.000000000 +1000
+++ .31630-linux-2.5.69-bk13.updated/include/linux/percpu.h	2003-05-20 12:57:19.000000000 +1000
@@ -5,6 +5,9 @@
 #include <linux/string.h> /* For memset() */
 #include <asm/percpu.h>
 
+/* Maximum size allowed for alloc_percpu */
+#define PERCPU_MAX PAGE_SIZE
+
 /* Must be an lvalue. */
 #define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
@@ -15,29 +18,19 @@
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
-struct percpu_data {
-	void *ptrs[NR_CPUS];
-	void *blkp;
-};
-
 /* 
  * Use this to get to a cpu's version of the per-cpu object allocated using
  * alloc_percpu.  If you want to get "this cpu's version", maybe you want
  * to use get_cpu_ptr... 
  */ 
-#define per_cpu_ptr(ptr, cpu)                   \
-({                                              \
-        struct percpu_data *__p = (struct percpu_data *)~(unsigned long)(ptr); \
-        (__typeof__(ptr))__p->ptrs[(cpu)];	\
-})
+#define per_cpu_ptr(ptr, cpu) (RELOC_HIDE(ptr, __per_cpu_offset[cpu]))
 
 extern void *__alloc_percpu(size_t size, size_t align);
 extern void free_percpu(const void *);
 extern void kmalloc_percpu_init(void);
 
-#else /* CONFIG_SMP */
-
-#define per_cpu_ptr(ptr, cpu) (ptr)
+extern void setup_per_cpu_areas(void);
+#else /* ... !CONFIG_SMP */
 
 static inline void *__alloc_percpu(size_t size, size_t align)
 {
@@ -50,7 +43,6 @@ static inline void free_percpu(const voi
 {	
 	kfree(ptr);
 }
-static inline void kmalloc_percpu_init(void) { }
 
 /* Can't define per-cpu variables in modules.  Sorry --RR */
 #ifndef MODULE
@@ -60,7 +52,10 @@ static inline void kmalloc_percpu_init(v
 
 #define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
 #define __get_cpu_var(var)			var##__per_cpu
+#define per_cpu_ptr(ptr, cpu)			((void)cpu, (ptr))
+#define __get_cpu_ptr(ptr)			(ptr)
 
+static inline void setup_per_cpu_areas(void) { }
 #endif /* CONFIG_SMP */
 
 /* Simple wrapper for the common case: zeros memory. */
@@ -86,8 +81,8 @@ static inline void kmalloc_percpu_init(v
  * then considered to be safe. And ofcourse, "Thou shalt not sleep between 
  * get_cpu_ptr and put_cpu_ptr"
  */
-#define get_cpu_ptr(ptr) per_cpu_ptr(ptr, get_cpu())
-#define put_cpu_ptr(ptr) put_cpu()
+#define get_cpu_ptr(var) (*({ preempt_disable(); &__get_cpu_ptr(ptr); }))
+#define put_cpu_ptr(var) preempt_enable()
 
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/init/main.c .31630-linux-2.5.69-bk13.updated/init/main.c
--- .31630-linux-2.5.69-bk13/init/main.c	2003-05-19 10:53:51.000000000 +1000
+++ .31630-linux-2.5.69-bk13.updated/init/main.c	2003-05-20 12:57:19.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/mm/Makefile .31630-linux-2.5.69-bk13.updated/mm/Makefile
--- .31630-linux-2.5.69-bk13/mm/Makefile	2003-02-11 14:26:20.000000000 +1100
+++ .31630-linux-2.5.69-bk13.updated/mm/Makefile	2003-05-20 12:57:20.000000000 +1000
@@ -12,3 +12,4 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SMP)	+= percpu.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/mm/percpu.c .31630-linux-2.5.69-bk13.updated/mm/percpu.c
--- .31630-linux-2.5.69-bk13/mm/percpu.c	1970-01-01 10:00:00.000000000 +1000
+++ .31630-linux-2.5.69-bk13.updated/mm/percpu.c	2003-05-20 12:57:20.000000000 +1000
@@ -0,0 +1,286 @@
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
+static void *percpu_base;
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
+
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
+void *__alloc_percpu(size_t size, size_t align)
+{
+	struct pcpu_block *b;
+	unsigned long extra;
+	void *ret;
+
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31630-linux-2.5.69-bk13/mm/slab.c .31630-linux-2.5.69-bk13.updated/mm/slab.c
--- .31630-linux-2.5.69-bk13/mm/slab.c	2003-05-20 12:57:17.000000000 +1000
+++ .31630-linux-2.5.69-bk13.updated/mm/slab.c	2003-05-20 12:57:20.000000000 +1000
@@ -1937,47 +1937,6 @@ void * kmalloc (size_t size, int flags)
 	return NULL;
 }
 
-#ifdef CONFIG_SMP
-/**
- * __alloc_percpu - allocate one copy of the object for every present
- * cpu in the system, zeroing them.
- * Objects should be dereferenced using per_cpu_ptr/get_cpu_ptr
- * macros only.
- *
- * @size: how many bytes of memory are required.
- * @align: the alignment, which can't be greater than SMP_CACHE_BYTES.
- */
-void *__alloc_percpu(size_t size, size_t align)
-{
-	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
-
-	if (!pdata)
-		return NULL;
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-		pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
-		if (!pdata->ptrs[i])
-			goto unwind_oom;
-		memset(pdata->ptrs[i], 0, size);
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
@@ -2016,28 +1975,6 @@ void kfree (const void *objp)
 	local_irq_restore(flags);
 }
 
-#ifdef CONFIG_SMP
-/**
- * free_percpu - free previously allocated percpu memory
- * @objp: pointer returned by alloc_percpu.
- *
- * Don't free memory not originally allocated by alloc_percpu()
- * The complemented objp is to check for that.
- */
-void
-free_percpu(const void *objp)
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28912-2.5.69-bk13-kmalloc_percpu-full.pre/include/asm-ia64/percpu.h .28912-2.5.69-bk13-kmalloc_percpu-full/include/asm-ia64/percpu.h
--- .28912-2.5.69-bk13-kmalloc_percpu-full.pre/include/asm-ia64/percpu.h	2003-05-20 12:49:53.000000000 +1000
+++ .28912-2.5.69-bk13-kmalloc_percpu-full/include/asm-ia64/percpu.h	2003-05-20 12:49:54.000000000 +1000
@@ -24,9 +24,12 @@
 #endif
 
 #define __get_cpu_var(var)	(var##__per_cpu)
-#endif /* CONFIG_SMP */
+#define __get_cpu_ptr(ptr)	(ptr)
 
-extern void setup_per_cpu_areas (void);
+void *initial_percpumem(unsigned long *size);
+void *new_percpumem(size_t size);
+void free_percpumem(void *ptr, size_t size);
+#endif /* CONFIG_SMP */
 
 #endif /* !__ASSEMBLY__ */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28912-2.5.69-bk13-kmalloc_percpu-full.pre/arch/ia64/kernel/setup.c .28912-2.5.69-bk13-kmalloc_percpu-full/arch/ia64/kernel/setup.c
--- .28912-2.5.69-bk13-kmalloc_percpu-full.pre/arch/ia64/kernel/setup.c	2003-05-19 10:53:40.000000000 +1000
+++ .28912-2.5.69-bk13-kmalloc_percpu-full/arch/ia64/kernel/setup.c	2003-05-20 12:49:54.000000000 +1000
@@ -49,10 +49,6 @@
 
 extern char _end;
 
-#ifdef CONFIG_SMP
-unsigned long __per_cpu_offset[NR_CPUS];
-#endif
-
 DEFINE_PER_CPU(struct cpuinfo_ia64, cpu_info);
 DEFINE_PER_CPU(unsigned long, ia64_phys_stacked_size_p8);
 unsigned long ia64_cycles_per_usec;
@@ -627,12 +623,6 @@ identify_cpu (struct cpuinfo_ia64 *c)
 	c->unimpl_pa_mask = ~((1L<<63) | ((1L << phys_addr_size) - 1));
 }
 
-void
-setup_per_cpu_areas (void)
-{
-	/* start_kernel() requires this... */
-}
-
 static void
 get_max_cacheline_size (void)
 {
@@ -667,6 +657,44 @@ get_max_cacheline_size (void)
 		ia64_max_cacheline_size = max;
 }
 
+#ifdef CONFIG_SMP
+/* FIXME: Implement.  This would need to allocate size * NR_CPUS, and
+   set up a different mapping on each CPU at that address minus
+   __per_cpu_offset[0].  Probably need to reserve address space to
+   ensure we can do that.  --RR */
+static inline void *new_percpumem(size_t size)
+{
+	static int warned = 0;
+
+	if (!warned++)
+		printk(KERN_WARN "Out of per-cpu address space\n");
+	return NULL;
+}
+static inline void free_percpumem(void *ptr, size_t size)
+{
+	BUG();
+}
+
+static inline void *initial_percpumem(unsigned long *size)
+{
+	void *ptr;
+	unsigned int i;
+
+	BUG_ON(*size > PERCPU_PAGE_SIZE);
+	*size = PERCPU_PAGE_SIZE;
+
+	ptr = __alloc_bootmem(PERCPU_PAGE_SIZE * NR_CPUS, PERCPU_PAGE_SIZE,
+			      __pa(MAX_DMA_ADDRESS));
+	for (i = 0; i < NR_CPUS; i++) {
+		__per_cpu_offset[i] = ptr + *size*i - (void *)__per_cpu_start;
+		memcpy(ptr + *size*i, __per_cpu_start,
+		       __per_cpu_end - __per_cpu_start);
+	}
+
+	return ptr;
+}
+#endif /* CONFIG_SMP */
+
 /*
  * cpu_init() initializes state that is per-CPU.  This function acts
  * as a 'CPU state barrier', nothing should get across.
@@ -690,15 +718,8 @@ cpu_init (void)
 	 * get_free_pages() cannot be used before cpu_init() done.  BSP allocates
 	 * "NR_CPUS" pages for all CPUs to avoid that AP calls get_zeroed_page().
 	 */
-	if (smp_processor_id() == 0) {
-		cpu_data = __alloc_bootmem(PERCPU_PAGE_SIZE * NR_CPUS, PERCPU_PAGE_SIZE,
-					   __pa(MAX_DMA_ADDRESS));
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			memcpy(cpu_data, __phys_per_cpu_start, __per_cpu_end - __per_cpu_start);
-			__per_cpu_offset[cpu] = (char *) cpu_data - __per_cpu_start;
-			cpu_data += PERCPU_PAGE_SIZE;
-		}
-	}
+	if (smp_processor_id() == 0)
+		setup_per_cpu_areas();
 	cpu_data = __per_cpu_start + __per_cpu_offset[smp_processor_id()];
 #else /* !CONFIG_SMP */
 	cpu_data = __phys_per_cpu_start;
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
