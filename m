Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTEBIeA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTEBId7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:33:59 -0400
Received: from dp.samba.org ([66.70.73.150]:31464 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261863AbTEBIdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:33:45 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Mosberger-Tang <davidm@hpl.hp.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] per-cpu change
Date: Fri, 02 May 2003 18:28:34 +1000
Message-Id: <20030502084610.0C8AC2C0BF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	To implement kmalloc_percpu to use the same primitives that
normal (static) per-cpu vars use, I have made some changes.  This is
required for sane per-cpu variable support in modules, but the
implementation also makes allocation v. efficient.  I've had to make
more assumptions about the per-cpu layout though.

	IA64 is the only arch which doesn't use the generic struct
(x86-64 seems to be partway 8), so I wanted to check with you.
Basically, we over-allocate up front, and pass out the rest through
the __alloc_percpu interface.  I've made the setup_per_cpu_areas()
idempotent, so you should simply be able to call that from your
cpu_init() (the later generic call will do nothing).

	Please tell me if this is too restrictive for IA64.  Ideally
it should be a simplification: you just need to override
__get_cpu_var(var) and __get_cpu_ptr(var) for SMP in asm/percpu.h.
You might want to set PERCPU_POOL_SIZE (16k would be plenty for my
machine, but you currently do 64k).

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: kmalloc_percpu to use same percpu operators
Author: Rusty Russell
Status: Tested on 2.5.68-bk11

D: By overallocating the per-cpu data at boot, we can make quite an
D: efficient allocator, and then use it to support per-cpu data in
D: modules (next patch).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/include/asm-generic/percpu.h .21483-linux-2.5.68-bk11.updated/include/asm-generic/percpu.h
--- .21483-linux-2.5.68-bk11/include/asm-generic/percpu.h	2003-01-02 12:32:47.000000000 +1100
+++ .21483-linux-2.5.68-bk11.updated/include/asm-generic/percpu.h	2003-05-02 18:20:00.000000000 +1000
@@ -2,37 +2,9 @@
 #define _ASM_GENERIC_PERCPU_H_
 #include <linux/compiler.h>
 
-#define __GENERIC_PER_CPU
+/* Some archs may want to keep __per_cpu_offset for this CPU in a register. */
 #ifdef CONFIG_SMP
-
-extern unsigned long __per_cpu_offset[NR_CPUS];
-
-/* Separate out the type, so (int[3], foo) works. */
-#ifndef MODULE
-#define DEFINE_PER_CPU(type, name) \
-    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#endif
-
-/* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
-
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
-
-#endif	/* SMP */
-
-#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
-
-#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
-#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
-
+#define __get_cpu_ptr(var) per_cpu_ptr(ptr, smp_processor_id())
+#endif /* SMP */
 #endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/include/linux/genhd.h .21483-linux-2.5.68-bk11.updated/include/linux/genhd.h
--- .21483-linux-2.5.68-bk11/include/linux/genhd.h	2003-05-02 11:06:18.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/include/linux/genhd.h	2003-05-02 18:20:00.000000000 +1000
@@ -160,10 +160,9 @@ static inline void disk_stat_set_all(str
 #ifdef  CONFIG_SMP
 static inline int init_disk_stats(struct gendisk *disk)
 {
-	disk->dkstats = kmalloc_percpu(sizeof (struct disk_stats), GFP_KERNEL);
+	disk->dkstats = kmalloc_percpu(struct disk_stats);
 	if (!disk->dkstats)
 		return 0;
-	disk_stat_set_all(disk, 0);
 	return 1;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/include/linux/percpu.h .21483-linux-2.5.68-bk11.updated/include/linux/percpu.h
--- .21483-linux-2.5.68-bk11/include/linux/percpu.h	2003-02-07 19:20:01.000000000 +1100
+++ .21483-linux-2.5.68-bk11.updated/include/linux/percpu.h	2003-05-02 18:20:00.000000000 +1000
@@ -1,71 +1,85 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
-#include <linux/spinlock.h> /* For preempt_disable() */
-#include <linux/slab.h> /* For kmalloc_percpu() */
+#include <linux/preempt.h> /* For preempt_disable() */
+#include <linux/slab.h> /* For kmalloc() */
+#include <linux/cache.h>
+#include <linux/string.h>
+#include <asm/bug.h>
 #include <asm/percpu.h>
 
-/* Must be an lvalue. */
+/* Total pool for percpu data (for each CPU). */
+#ifndef PERCPU_POOL_SIZE
+#define PERCPU_POOL_SIZE 32768
+#endif
+
+/* For variables declared with DECLARE_PER_CPU()/DEFINE_PER_CPU(). */
 #define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
+/* Also, per_cpu(var, cpu) to get another cpu's value. */
+
+/* For ptrs allocated with kmalloc_percpu */
+#define get_cpu_ptr(ptr) ({ preempt_disable(); __get_cpu_ptr(ptr); })
+#define put_cpu_ptr(ptr) preempt_enable()
+/* Also, per_cpu_ptr(ptr, cpu) to get another cpu's value. */
 
 #ifdef CONFIG_SMP
 
-struct percpu_data {
-	void *ptrs[NR_CPUS];
-	void *blkp;
-};
+/* __alloc_percpu zeros memory for every cpu, as a convenience. */
+extern void *__alloc_percpu(size_t size, size_t align);
+extern void kfree_percpu(const void *);
 
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
+extern unsigned long __per_cpu_offset[NR_CPUS];
 
-extern void *kmalloc_percpu(size_t size, int flags);
-extern void kfree_percpu(const void *);
-extern void kmalloc_percpu_init(void);
+/* Separate out the type, so (int[3], foo) works. */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
+#endif
 
-#else /* CONFIG_SMP */
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+#define per_cpu_ptr(ptr, cpu) ((__typeof__(ptr))(RELOC_HIDE(ptr, __per_cpu_offset[cpu])))
 
-#define per_cpu_ptr(ptr, cpu) (ptr)
+extern void setup_per_cpu_areas(void);
+#else /* !CONFIG_SMP */
 
-static inline void *kmalloc_percpu(size_t size, int flags)
+/* Can't define per-cpu variables in modules.  Sorry --RR */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __typeof__(type) name##__per_cpu
+#endif
+
+#define per_cpu(var, cpu)			((void)(cpu), var##__per_cpu)
+#define __get_cpu_var(var)			var##__per_cpu
+#define per_cpu_ptr(ptr, cpu)			((void)(cpu), (ptr))
+#define __get_cpu_ptr(ptr)			(ptr)
+
+static inline void *__alloc_percpu(size_t size, size_t align)
 {
-	return(kmalloc(size, flags));
+	void *ret;
+	/* kmalloc always cacheline aligns. */
+	BUG_ON(align > SMP_CACHE_BYTES);
+	BUG_ON(size > PERCPU_POOL_SIZE/2);
+	ret = kmalloc(size, GFP_KERNEL);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
 }
 static inline void kfree_percpu(const void *ptr)
 {	
 	kfree(ptr);
 }
-static inline void kmalloc_percpu_init(void) { }
 
+static inline void setup_per_cpu_areas(void) { }
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
+/* Simple wrapper for the common case.  Zeros memory. */
+#define kmalloc_percpu(type) \
+	((type *)(__alloc_percpu(sizeof(type), __alignof__(type))))
+
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
+
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
 
 #endif /* __LINUX_PERCPU_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/include/net/ipv6.h .21483-linux-2.5.68-bk11.updated/include/net/ipv6.h
--- .21483-linux-2.5.68-bk11/include/net/ipv6.h	2003-05-02 11:06:20.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/include/net/ipv6.h	2003-05-02 18:20:00.000000000 +1000
@@ -145,7 +145,7 @@ extern atomic_t			inet6_sock_nr;
 
 int snmp6_register_dev(struct inet6_dev *idev);
 int snmp6_unregister_dev(struct inet6_dev *idev);
-int snmp6_mib_init(void *ptr[2], size_t mibsize);
+int snmp6_mib_init(void *ptr[2], size_t mibsize, size_t mibalign);
 void snmp6_mib_free(void *ptr[2]);
 
 struct ip6_ra_chain
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/init/main.c .21483-linux-2.5.68-bk11.updated/init/main.c
--- .21483-linux-2.5.68-bk11/init/main.c	2003-05-02 11:06:21.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/init/main.c	2003-05-02 18:20:00.000000000 +1000
@@ -301,35 +301,10 @@ static void __init smp_init(void)
 #define smp_init()	do { } while (0)
 #endif
 
-static inline void setup_per_cpu_areas(void) { }
 static inline void smp_prepare_cpus(unsigned int maxcpus) { }
 
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/kernel/ksyms.c .21483-linux-2.5.68-bk11.updated/kernel/ksyms.c
--- .21483-linux-2.5.68-bk11/kernel/ksyms.c	2003-05-02 11:06:21.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/kernel/ksyms.c	2003-05-02 18:20:00.000000000 +1000
@@ -99,7 +99,7 @@ EXPORT_SYMBOL(remove_shrinker);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(kmalloc_percpu);
+EXPORT_SYMBOL(__alloc_percpu);
 EXPORT_SYMBOL(kfree_percpu);
 EXPORT_SYMBOL(percpu_counter_mod);
 #endif
@@ -607,7 +607,7 @@ EXPORT_SYMBOL(init_thread_union);
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(find_task_by_pid);
 EXPORT_SYMBOL(next_thread);
-#if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
+#if defined(CONFIG_SMP)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/mm/Makefile .21483-linux-2.5.68-bk11.updated/mm/Makefile
--- .21483-linux-2.5.68-bk11/mm/Makefile	2003-02-11 14:26:20.000000000 +1100
+++ .21483-linux-2.5.68-bk11.updated/mm/Makefile	2003-05-02 18:20:00.000000000 +1000
@@ -12,3 +12,4 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_SMP)	+= percpu.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/mm/percpu.c .21483-linux-2.5.68-bk11.updated/mm/percpu.c
--- .21483-linux-2.5.68-bk11/mm/percpu.c	1970-01-01 10:00:00.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/mm/percpu.c	2003-05-02 18:20:00.000000000 +1000
@@ -0,0 +1,218 @@
+/*
+ * Dynamic per-cpu allocation.
+ * Originally by Dipankar Sarma <dipankar@in.ibm.com>
+ * This version (C) 2003 Rusty Russell, IBM Corporation.
+ */
+
+/* Simple allocator: we don't stress it hard, but do want it
+   fairly space-efficient. */
+#include <linux/percpu.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <asm/semaphore.h>
+
+static DECLARE_MUTEX(pcpu_lock);
+
+/* We could allocate multiple of these in future.  For the moment, we
+   allocate one at boot time. */
+static void *base_ptr;
+
+struct pcpu_block
+{
+	/* Number of blocks used and allocated. */
+	unsigned short num_used, num_allocated;
+
+	/* Size of each block.  -ve means used. */
+	int size[0];
+};
+static struct pcpu_block *pcpu; /* = NULL */
+
+/* Created by linker magic */
+extern char __per_cpu_start[], __per_cpu_end[];
+
+/* Splits a block into two.  Reallocs pcpu if neccessary. */
+static int split_block(unsigned int i, unsigned short size)
+{
+	/* Reallocation required? */
+	if (pcpu->num_used + 1 > pcpu->num_allocated) {
+		struct pcpu_block *new;
+
+		new = kmalloc(sizeof(*pcpu)
+			      + sizeof(pcpu->size[0]) * pcpu->num_allocated*2,
+			      GFP_KERNEL);
+		if (!new)
+			return 0;
+		new->num_used = pcpu->num_used;
+		new->num_allocated = pcpu->num_allocated * 2;
+		memcpy(new->size, pcpu->size,
+		       sizeof(pcpu->size[0])*pcpu->num_used);
+		kfree(pcpu);
+		pcpu = new;
+	}
+
+	/* Insert a new subblock */
+	memmove(&pcpu->size[i+1], &pcpu->size[i],
+		sizeof(pcpu->size[0]) * (pcpu->num_used - i));
+	pcpu->num_used++;
+
+	pcpu->size[i+1] -= size;
+	pcpu->size[i] = size;
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
+static inline void zero_all(void *pcpuptr, unsigned int size)
+{
+	unsigned int i;;
+
+	for (i = 0; i < NR_CPUS; i++)
+		memset(per_cpu_ptr(pcpuptr, i), 0, size);
+}
+
+void *__alloc_percpu(size_t size, size_t align)
+{
+	unsigned long extra;
+	unsigned int i;
+	void *ptr;
+	void *ret = NULL;
+
+	BUG_ON(align > SMP_CACHE_BYTES);
+	BUG_ON(size > PERCPU_POOL_SIZE/2);
+
+	down(&pcpu_lock);
+	ptr = base_ptr;
+	for (i = 0; i < pcpu->num_used; ptr += abs(pcpu->size[i]), i++) {
+		/* Extra for alignment requirement. */
+		extra = ALIGN((unsigned long)ptr, align) - (unsigned long)ptr;
+
+		/* Allocated or not large enough? */
+		if (pcpu->size[i] < 0 || pcpu->size[i] < extra + size)
+			continue;
+
+		/* Transfer extra to previous block. */
+		if (pcpu->size[i-1] < 0)
+			pcpu->size[i-1] -= extra;
+		else
+			pcpu->size[i-1] += extra;
+		pcpu->size[i] -= extra;
+		ptr += extra;
+
+		/* Split block if warranted */
+		if (pcpu->size[i] - size > sizeof(unsigned long)) {
+			if (!split_block(i, size))
+				goto out;
+		}
+
+		/* Mark allocated */
+		pcpu->size[i] = -pcpu->size[i];
+		/* Pointer will be offset by this: compensate. */ 
+		ret = RELOC_HIDE(ptr, -__per_cpu_offset[0]);
+		zero_all(ret, size);
+		break;
+	}
+ out:
+	up(&pcpu_lock);
+	return ret;
+}
+
+static void free_block(const void *freeme)
+{
+	unsigned int i;
+	void *ptr = base_ptr;
+
+	for (i = 0; i < pcpu->num_used; ptr += abs(pcpu->size[i]), i++) {
+		if (ptr == freeme) {
+			/* Double free? */
+			BUG_ON(pcpu->size[i] > 0);
+			/* Block 0 is for non-dynamic per-cpu data. */
+			BUG_ON(i == 0);
+			pcpu->size[i] = -pcpu->size[i];
+			goto merge;
+		}
+	}
+	BUG();
+
+ merge:
+	/* Merge with previous? */
+	if (pcpu->size[i-1] >= 0) {
+		pcpu->size[i-1] += pcpu->size[i];
+		pcpu->num_used--;
+		memmove(&pcpu->size[i], &pcpu->size[i+1],
+			(pcpu->num_used - i) * sizeof(pcpu->size[0]));
+		i--;
+	}
+	/* Merge with next? */
+	if (i+1 < pcpu->num_used && pcpu->size[i+1] >= 0) {
+		pcpu->size[i] += pcpu->size[i+1];
+		pcpu->num_used--;
+		memmove(&pcpu->size[i+1], &pcpu->size[i+2],
+			(pcpu->num_used - (i+1)) * sizeof(pcpu->size[0]));
+	}
+
+	/* There's always one block: the core kernel one. */
+	BUG_ON(pcpu->num_used == 0);
+}
+
+void kfree_percpu(const void *ptr)
+{
+	down(&pcpu_lock);
+	/* Pointer will be offset by this amount: compensate. */ 
+	free_block(RELOC_HIDE(ptr, __per_cpu_offset[0]));
+	up(&pcpu_lock);
+}
+
+unsigned long __per_cpu_offset[NR_CPUS];
+EXPORT_SYMBOL(__per_cpu_offset);
+
+#define PERCPU_INIT_BLOCKS 4
+
+/* We can't kmalloc yet, so alloc_percpu init done later. */
+void __init setup_per_cpu_areas(void)
+{
+	unsigned long i;
+	void *ptr;
+
+	/* Called early on some archs, so make this idempotent. */
+	if (base_ptr)
+		return;
+
+	base_ptr = alloc_bootmem(PERCPU_POOL_SIZE * NR_CPUS);
+
+	/* Don't panic yet, they won't see it */
+	if (__per_cpu_end - __per_cpu_start > PERCPU_POOL_SIZE)
+		return;
+
+	/* Copy section for each CPU (we discard the original) */
+	ptr = base_ptr;
+	for (i = 0; i < NR_CPUS; i++, ptr += PERCPU_POOL_SIZE) {
+		__per_cpu_offset[i] = ptr - (void *)__per_cpu_start;
+		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
+	}
+}
+
+static int init_alloc_percpu(void)
+{
+	printk("Per-cpu data: %Zu of %u bytes\n",
+	       __per_cpu_end - __per_cpu_start, PERCPU_POOL_SIZE);
+
+	if (__per_cpu_end - __per_cpu_start > PERCPU_POOL_SIZE)
+		panic("Too much per-cpu data.\n");
+
+	pcpu = kmalloc(sizeof(*pcpu)+sizeof(pcpu->size[0])*PERCPU_INIT_BLOCKS,
+		       GFP_KERNEL);
+	pcpu->num_allocated = PERCPU_INIT_BLOCKS;
+	pcpu->num_used = 2;
+	pcpu->size[0] = -(__per_cpu_end - __per_cpu_start);
+	pcpu->size[1] = PERCPU_POOL_SIZE-(__per_cpu_end - __per_cpu_start);
+
+	return 0;
+}
+
+__initcall(init_alloc_percpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/mm/slab.c .21483-linux-2.5.68-bk11.updated/mm/slab.c
--- .21483-linux-2.5.68-bk11/mm/slab.c	2003-04-20 18:05:16.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/mm/slab.c	2003-05-02 18:20:00.000000000 +1000
@@ -1902,54 +1902,6 @@ void * kmalloc (size_t size, int flags)
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
@@ -1988,28 +1940,6 @@ void kfree (const void *objp)
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/net/ipv4/af_inet.c .21483-linux-2.5.68-bk11.updated/net/ipv4/af_inet.c
--- .21483-linux-2.5.68-bk11/net/ipv4/af_inet.c	2003-04-20 18:05:16.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/net/ipv4/af_inet.c	2003-05-02 18:20:00.000000000 +1000
@@ -1060,54 +1060,21 @@ static struct inet_protocol icmp_protoco
 
 static int __init init_ipv4_mibs(void)
 {
-	int i;
-
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
+	net_statistics[0] = kmalloc_percpu(struct linux_mib);
+	net_statistics[1] = kmalloc_percpu(struct linux_mib);
+	ip_statistics[0] = kmalloc_percpu(struct ip_mib);
+	ip_statistics[1] = kmalloc_percpu(struct ip_mib);
+	icmp_statistics[0] = kmalloc_percpu(struct icmp_mib);
+	icmp_statistics[1] = kmalloc_percpu(struct icmp_mib);
+	tcp_statistics[0] = kmalloc_percpu(struct tcp_mib);
+	tcp_statistics[1] = kmalloc_percpu(struct tcp_mib);
+	udp_statistics[0] = kmalloc_percpu(struct udp_mib);
+	udp_statistics[1] = kmalloc_percpu(struct udp_mib);
 	if (!
 	    (net_statistics[0] && net_statistics[1] && ip_statistics[0]
 	     && ip_statistics[1] && tcp_statistics[0] && tcp_statistics[1]
 	     && udp_statistics[0] && udp_statistics[1]))
 		return -ENOMEM;
-
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/net/ipv4/route.c .21483-linux-2.5.68-bk11.updated/net/ipv4/route.c
--- .21483-linux-2.5.68-bk11/net/ipv4/route.c	2003-05-02 11:06:25.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/net/ipv4/route.c	2003-05-02 18:20:00.000000000 +1000
@@ -2656,17 +2656,9 @@ int __init ip_rt_init(void)
 	ipv4_dst_ops.gc_thresh = (rt_hash_mask + 1);
 	ip_rt_max_size = (rt_hash_mask + 1) * 16;
 
-	rt_cache_stat = kmalloc_percpu(sizeof (struct rt_cache_stat),
-					GFP_KERNEL);
+	rt_cache_stat = kmalloc_percpu(struct rt_cache_stat);
 	if (!rt_cache_stat) 
 		goto out_enomem1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(rt_cache_stat, i), 0,
-			       sizeof (struct rt_cache_stat));
-		}
-	}
-
 	devinet_init();
 	ip_fib_init();
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/net/ipv6/af_inet6.c .21483-linux-2.5.68-bk11.updated/net/ipv6/af_inet6.c
--- .21483-linux-2.5.68-bk11/net/ipv6/af_inet6.c	2003-05-02 11:06:25.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/net/ipv6/af_inet6.c	2003-05-02 18:20:00.000000000 +1000
@@ -632,28 +632,20 @@ inet6_unregister_protosw(struct inet_pro
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
-
-	/* Zero percpu version of the mibs */
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_possible(i)) {
-			memset(per_cpu_ptr(ptr[0], i), 0, mibsize);
-			memset(per_cpu_ptr(ptr[1], i), 0, mibsize);
-		}
-	}
 	return 0;
 
 err1:
@@ -675,11 +667,14 @@ snmp6_mib_free(void *ptr[2])
 
 static int __init init_ipv6_mibs(void)
 {
-	if (snmp6_mib_init((void **)ipv6_statistics, sizeof (struct ipv6_mib)) < 0)
+	if (snmp6_mib_init((void **)ipv6_statistics, sizeof (struct ipv6_mib),
+			   __alignof__(struct ipv6_mib)) < 0)
 		goto err_ip_mib;
-	if (snmp6_mib_init((void **)icmpv6_statistics, sizeof (struct icmpv6_mib)) < 0)
+	if (snmp6_mib_init((void **)icmpv6_statistics, sizeof (struct icmpv6_mib),
+			   __alignof__(struct icmpv6_mib)) < 0)
 		goto err_icmp_mib;
-	if (snmp6_mib_init((void **)udp_stats_in6, sizeof (struct udp_mib)) < 0)
+	if (snmp6_mib_init((void **)udp_stats_in6, sizeof (struct udp_mib),
+			   __alignof__(struct udp_mib)) < 0)
 		goto err_udp_mib;
 	return 0;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/net/ipv6/proc.c .21483-linux-2.5.68-bk11.updated/net/ipv6/proc.c
--- .21483-linux-2.5.68-bk11/net/ipv6/proc.c	2003-05-02 11:06:27.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/net/ipv6/proc.c	2003-05-02 18:20:00.000000000 +1000
@@ -226,7 +226,7 @@ int snmp6_register_dev(struct inet6_dev 
 	if (!idev || !idev->dev)
 		return -EINVAL;
 
-	if (snmp6_mib_init((void **)idev->stats.icmpv6, sizeof(struct icmpv6_mib)) < 0)
+	if (snmp6_mib_init((void **)idev->stats.icmpv6, sizeof(struct icmpv6_mib), __alignof__(struct icmpv6_mib)) < 0)
 		goto err_icmp;
 
 #ifdef CONFIG_PROC_FS
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21483-linux-2.5.68-bk11/net/sctp/protocol.c .21483-linux-2.5.68-bk11.updated/net/sctp/protocol.c
--- .21483-linux-2.5.68-bk11/net/sctp/protocol.c	2003-05-02 11:06:29.000000000 +1000
+++ .21483-linux-2.5.68-bk11.updated/net/sctp/protocol.c	2003-05-02 18:20:00.000000000 +1000
@@ -853,26 +853,14 @@ static int __init init_sctp_mibs(void)
 {
 	int i;
 
-	sctp_statistics[0] = kmalloc_percpu(sizeof (struct sctp_mib),
-					    GFP_KERNEL);
+	sctp_statistics[0] = kmalloc_percpu(struct sctp_mib);
 	if (!sctp_statistics[0])
 		return -ENOMEM;
-	sctp_statistics[1] = kmalloc_percpu(sizeof (struct sctp_mib),
-					    GFP_KERNEL);
+	sctp_statistics[1] = kmalloc_percpu(struct sctp_mib);
 	if (!sctp_statistics[1]) {
 		kfree_percpu(sctp_statistics[0]);
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
