Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVANC3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVANC3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVANC3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:29:23 -0500
Received: from ozlabs.org ([203.10.76.45]:20140 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261778AbVANCZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:25:30 -0500
Subject: Re: [patch] mm: Reimplementation of dynamic percpu memory allocator
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
In-Reply-To: <20050113083412.GA7567@impedimenta.in.ibm.com>
References: <20050113083412.GA7567@impedimenta.in.ibm.com>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 13:24:47 +1100
Message-Id: <1105669487.7311.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 14:04 +0530, Ravikiran G Thirumalai wrote:
> Hi Andrew,
> Could you consider this for inclusion in the mm tree?  The patch has been
> tested in user space and kernel space.  Manfred seems to like the fact that
> allocator doesn't depend on slab, so that it can be used for slab's internal
> head arrays.  He had questions about fragmentation which I have answered.
> 
> Patch follows
> 
> Thanks,
> Kiran
> 
> 
> The following patch re-implements the linux dynamic percpu memory allocator
> so that:
> 1. Percpu memory dereference is faster 
> 	- One less memory reference compared to existing simple alloc_percpu
> 	- As fast as with static percpu areas, one mem ref less actually.

Hmm, for me one point of a good dynamic per-cpu implementation is that
the same per_cpu_offset be used as for the static per-cpu variables.
This means that architectures can put it in a register.  It also has
different properties than slab, because tiny allocations will be more
common (ie. one counter).

I've had this implementation sitting around for a while: it's not
enormously fast, but it is space-efficient, and would need a cache on
the front if people started doing a high rate of allocs.  First patch is
merely a cleanup.

Rusty.
Name: Unification of per-cpu headers for SMP
Author: Rusty Russell
Status: Trivial
Depends: Percpu/percpu-up-unify.patch.gz

There's really only one sane way to implement accessing other CPU's
variables, there's no real reason for archs to use a method other
than __per_cpu_offset[], so move that from asm-*/percpu.h to
linux/percpu.h.

Index: linux-2.6.11-rc1-bk1-Percpu/include/asm-ia64/percpu.h
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/include/asm-ia64/percpu.h	2004-02-18 23:54:32.000000000 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/include/asm-ia64/percpu.h	2005-01-14 13:19:04.681626896 +1100
@@ -35,9 +35,6 @@
  * external routine, to avoid include-hell.
  */
 #ifdef CONFIG_SMP
-
-extern unsigned long __per_cpu_offset[NR_CPUS];
-
 /* Equal to __per_cpu_offset[smp_processor_id()], but faster to access: */
 DECLARE_PER_CPU(unsigned long, local_per_cpu_offset);
 
Index: linux-2.6.11-rc1-bk1-Percpu/init/main.c
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/init/main.c	2005-01-13 12:11:11.000000000 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/init/main.c	2005-01-14 13:19:04.768613672 +1100
@@ -305,11 +305,10 @@
 
 #else
 
-#ifdef __GENERIC_PER_CPU
 unsigned long __per_cpu_offset[NR_CPUS];
-
 EXPORT_SYMBOL(__per_cpu_offset);
 
+#ifdef __GENERIC_PER_CPU
 static void __init setup_per_cpu_areas(void)
 {
 	unsigned long size, i;
Index: linux-2.6.11-rc1-bk1-Percpu/arch/ia64/kernel/setup.c
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/arch/ia64/kernel/setup.c	2005-01-14 11:08:00.000000000 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/arch/ia64/kernel/setup.c	2005-01-14 13:19:04.893594672 +1100
@@ -56,11 +56,6 @@
 # error "struct cpuinfo_ia64 too big!"
 #endif
 
-#ifdef CONFIG_SMP
-unsigned long __per_cpu_offset[NR_CPUS];
-EXPORT_SYMBOL(__per_cpu_offset);
-#endif
-
 DEFINE_PER_CPU(struct cpuinfo_ia64, cpu_info);
 DEFINE_PER_CPU(unsigned long, local_per_cpu_offset);
 DEFINE_PER_CPU(unsigned long, ia64_phys_stacked_size_p8);
Index: linux-2.6.11-rc1-bk1-Percpu/include/linux/percpu.h
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/include/linux/percpu.h	2004-10-19 14:34:22.000000000 +1000
+++ linux-2.6.11-rc1-bk1-Percpu/include/linux/percpu.h	2005-01-14 13:19:04.985580688 +1100
@@ -16,6 +16,9 @@
 #define put_cpu_var(var) preempt_enable()
 
 #ifdef CONFIG_SMP
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
+extern unsigned long __per_cpu_offset[NR_CPUS];
 
 struct percpu_data {
 	void *ptrs[NR_CPUS];
Index: linux-2.6.11-rc1-bk1-Percpu/include/asm-generic/percpu.h
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/include/asm-generic/percpu.h	2004-02-04 15:39:09.000000000 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/include/asm-generic/percpu.h	2005-01-14 13:19:05.099563360 +1100
@@ -5,14 +5,10 @@
 #define __GENERIC_PER_CPU
 #ifdef CONFIG_SMP
 
-extern unsigned long __per_cpu_offset[NR_CPUS];
-
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
-/* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
 /* A macro to avoid #include hell... */


Name: Dynamic per-cpu allocation using static per-cpu mechanism
Author: Rusty Russell
Status: Tested on 2.6.10-rc2-bk13

This patch replaces the dynamic per-cpu allocator, alloc_percpu,
to make it use the same mechanism as the static per-cpu variables, ie.
ptr + __per_cpu_offset[smp_processor_id()] gives the variable address.
This increases space and time efficiency of reference at the same time.

This is a generalization of the allocator in kernel/module.c: it
gets moved to its own (SMP-only) file: mm/percpu.c.

The basic idea is that when we need more memory, we allocate
another NR_CPUS*sizeof(.data.percpu section), and hand allocations
out from that (minus the __per_cpu_offset, which is set at boot
from the difference between the .data.percpu section and the
initial NR_CPUS*sizeof(.data.percpu section) allocation.

The situation is made trickier by archs which want to allocate per-cpu
memory near the CPUs which use them: hooks are provided for the
initial alloc (arch_alloc_percpu_bootmem(), which can also change the
size of the allocation, eg. to page-align) and arch_alloc_percpu().
__GENERIC_PER_CPU gets sane default implementations.

Index: linux-2.6.11-rc1-bk1-Percpu/mm/percpu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-rc1-bk1-Percpu/mm/percpu.c	2005-01-14 13:19:24.844561664 +1100
@@ -0,0 +1,334 @@
+/* Routines to do per-cpu allocation.
+
+   These are more complicated than I would like, because different
+   architectures want different things.
+
+   The basic idea is simple: we allocate a (virtually) contiguous
+   block of memory at boot, and index it by cpu.  The offset between
+   the original percpu section and these duplicate sections is
+   recorded in __per_cpu_offset[cpu] (and in some archs, a register,
+   etc).  eg. the per-cpu section ends up at 0xc00a0000, and we
+   allocate 64k for each CPU stating at 0x100a0000, then
+   __per_cpu_offset[0] is 0x50000000, __per_cpu_offset[1] is
+   0x50010000, etc.
+
+   This original block is also handed out to modules which use
+   DEFINE_PER_CPU: on some archs it has to be this original block, as
+   they use magic tricks to dereference these static per-cpu variables
+   in some cases (eg. cpu_local_inc on ia64).
+
+   Other blocks can be allocated later to fulfill dynamic per-cpu
+   requests: they used the same __per_cpu_offset[] values as their
+   static cousins, so the layout has to be the same (this is why we
+   insist on contiguous memory in the first place: it's easy to get
+   more contiguous memory).
+
+   It makes sense to allocate the per-cpu memory so that the memory is
+   close to the corresponding CPU, and use the virt<->phys mapping to
+   turn it into a contiguous array.  However, the pagesize in the
+   kernel is often large, and we don't want to reserve that all for
+   static allocations, so we only reserve part of it.
+
+   Note about the allocator: it's designed to be space-efficient,
+   since it's used for ints and longs (counters) and the like.  For
+   speed, it needs a cache on top.
+ */
+#include <linux/percpu.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/bootmem.h>
+#include <linux/init.h>
+#include <asm/semaphore.h>
+
+/* Created by linker magic */
+extern char __per_cpu_start[], __per_cpu_end[];
+
+unsigned long __per_cpu_offset[NR_CPUS];
+EXPORT_SYMBOL(__per_cpu_offset);
+
+struct percpu_block {
+	struct list_head list;
+	/* Number of blocks used and allocated. */
+	unsigned int num_used, num_allocated;
+	/* Pointer to start of block. */
+	void *start;
+	/* Array containing sizes of each block.  -ve means used. */
+	int *size;
+};
+
+static DECLARE_MUTEX(percpu_lock);
+static struct percpu_block percpu_core;
+/* All blocks have to be the same size per cpu, otherwise span would differ. */
+static unsigned long reserved_size, percpu_size;
+
+#ifdef __GENERIC_PER_CPU
+/* Ideally, an arch will sew together pages local to CPUs to form a
+ * continuous allocation. */
+static inline void *arch_alloc_percpu(unsigned long size)
+{
+	void *ret;
+
+	ret = kmalloc(size * NR_CPUS, GFP_KERNEL);
+	if (!ret)
+		ret = vmalloc(size * NR_CPUS);
+	return ret;
+}
+
+static inline void *arch_alloc_percpu_bootmem(unsigned long *size)
+{
+	return alloc_bootmem(*size * NR_CPUS);
+}
+#endif /* __GENERIC_PER_CPU */
+
+static struct percpu_block *new_block(void)
+{
+	struct percpu_block *b;
+
+	b = kmalloc(sizeof(*b), GFP_KERNEL);
+	if (!b)
+		return NULL;
+
+	b->num_used = 1;
+	b->num_allocated = 4;
+	b->size = kmalloc(sizeof(b->size[0]) * b->num_allocated, GFP_KERNEL);
+	if (!b->size) {
+		kfree(b);
+		return NULL;
+	}
+
+	b->size[0] = percpu_size;
+	return b;
+}
+
+/* Done early, so areas can be used. */
+void __init setup_per_cpu_areas(void)
+{
+	unsigned long i;
+	char *ptr;
+
+	/* Copy section for each CPU (we discard the original) */
+	reserved_size = ALIGN(__per_cpu_end - __per_cpu_start,SMP_CACHE_BYTES);
+#ifdef CONFIG_MODULES
+	/* Enough to cover all DEFINE_PER_CPUs in modules, too. */
+	reserved_size = min(reserved_size, 8192UL * sizeof(unsigned long));
+#endif
+	/* Arch may choose to allocate much more for each CPU
+	 * (eg. large pages). */
+	percpu_size = reserved_size;
+	percpu_core.start = ptr = arch_alloc_percpu_bootmem(&percpu_size);
+	BUG_ON(percpu_size < reserved_size);
+	for (i = 0; i < NR_CPUS; i++, ptr += percpu_size) {
+		__per_cpu_offset[i] = ptr - __per_cpu_start;
+		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
+	}
+}
+
+static int __init percpu_alloc_init(void)
+{
+	percpu_core.num_used = 2;
+	percpu_core.num_allocated = 4;
+	percpu_core.size = kmalloc(sizeof(percpu_core.size[0])
+				   * percpu_core.num_allocated,
+				   GFP_KERNEL);
+	/* Static in-kernel percpu data (used, so negative). */
+	percpu_core.size[0] = -(__per_cpu_end - __per_cpu_start);
+	/* Free room. */
+	percpu_core.size[1] = percpu_size + percpu_core.size[0];
+	INIT_LIST_HEAD(&percpu_core.list);
+
+	if (percpu_size > reserved_size) {
+		struct percpu_block *b;
+
+		/* Mark out extra space as allocated. */
+		percpu_core.size[1] = reserved_size + percpu_core.size[0];
+		percpu_core.size[2] = -(percpu_size - reserved_size);
+		percpu_core.num_used++;
+
+		/* Duplicate of core block, but with core space allocated. */
+		b = new_block();
+		b->size[0] = -reserved_size;
+		b->size[1] = percpu_size - reserved_size;
+		b->num_used = 2;
+		b->start = percpu_core.start;
+		list_add(&b->list, &percpu_core.list);
+	}
+	return 0;
+}
+core_initcall(percpu_alloc_init);
+
+static int split_block(unsigned int i, unsigned short size,
+		       struct percpu_block *pb)
+{
+	/* Reallocation required? */
+	if (pb->num_used + 1 > pb->num_allocated) {
+		int *new = kmalloc(sizeof(new[0]) * pb->num_allocated*2,
+				   GFP_KERNEL);
+		if (!new)
+			return 0;
+
+		memcpy(new, pb->size, sizeof(new[0])*pb->num_allocated);
+		pb->num_allocated *= 2;
+		kfree(pb->size);
+		pb->size = new;
+	}
+
+	/* Insert a new subblock */
+	memmove(&pb->size[i+1], &pb->size[i],
+		sizeof(pb->size[0]) * (pb->num_used - i));
+	pb->num_used++;
+
+	pb->size[i+1] -= size;
+	pb->size[i] = size;
+	return 1;
+}
+
+static inline unsigned int block_size(int val)
+{
+	if (val < 0)
+		return -val;
+	return val;
+}
+
+static void *alloc_from_block(unsigned long size, unsigned long align,
+			      struct percpu_block *pb)
+{
+	unsigned long extra;
+	unsigned int i;
+	void *ptr;
+
+	BUG_ON(align > SMP_CACHE_BYTES);
+
+	ptr = pb->start;
+	for (i = 0; i < pb->num_used; ptr += block_size(pb->size[i]), i++) {
+		/* Extra for alignment requirement. */
+		extra = ALIGN((unsigned long)ptr, align) - (unsigned long)ptr;
+		BUG_ON(i == 0 && extra != 0);
+
+		if (pb->size[i] < 0 || pb->size[i] < extra + size)
+			continue;
+
+		/* Transfer extra to previous block. */
+		if (pb->size[i-1] < 0)
+			pb->size[i-1] -= extra;
+		else
+			pb->size[i-1] += extra;
+		pb->size[i] -= extra;
+		ptr += extra;
+
+		/* Split block if warranted */
+		if (pb->size[i] - size > sizeof(unsigned long))
+			if (!split_block(i, size, pb))
+				return NULL;
+
+		/* Mark allocated */
+		pb->size[i] = -pb->size[i];
+		return ptr;
+	}
+	return NULL;
+}
+
+static void free_from_block(const void *freeme, struct percpu_block *pb)
+{
+	unsigned int i;
+	void *ptr = pb->start;
+
+	for (i = 0; ptr != freeme; ptr += block_size(pb->size[i]), i++)
+		BUG_ON(i == pb->num_used);
+
+	pb->size[i] = -pb->size[i];
+	/* Merge with previous? */
+	if (i > 0 && pb->size[i-1] >= 0) {
+		pb->size[i-1] += pb->size[i];
+		pb->num_used--;
+		memmove(&pb->size[i], &pb->size[i+1],
+			(pb->num_used - i) * sizeof(pb->size[0]));
+		i--;
+	}
+	/* Merge with next? */
+	if (i+1 < pb->num_used && pb->size[i+1] >= 0) {
+		pb->size[i] += pb->size[i+1];
+		pb->num_used--;
+		memmove(&pb->size[i+1], &pb->size[i+2],
+			(pb->num_used - (i+1)) * sizeof(pb->size[0]));
+	}
+}
+
+#ifdef CONFIG_MODULES
+void *percpu_modalloc(unsigned long size, unsigned long align)
+{
+	void *ret;
+
+	down(&percpu_lock);
+	ret = alloc_from_block(size, align, &percpu_core);
+	printk(KERN_WARNING "Could not allocate %lu bytes percpu data\n",size);
+	up(&percpu_lock);
+	return ret;
+}
+
+void percpu_modfree(void *freeme)
+{
+	down(&percpu_lock);
+	free_from_block(freeme, &percpu_core);
+	up(&percpu_lock);
+}
+#endif
+
+void *__alloc_percpu(unsigned long size, unsigned long align)
+{
+	void *ret = NULL;
+	struct percpu_block *b;
+	unsigned int cpu;
+
+	down(&percpu_lock);
+	/* Cleverly skips over kernel reserved space. */
+	list_for_each_entry(b, &percpu_core.list, list) {
+		ret = alloc_from_block(size, align, b);
+		if (ret) 
+			goto success;
+	}
+
+	b = new_block();
+	if (!b)
+		goto unlock;
+
+	b->start = arch_alloc_percpu(percpu_size);
+	if (!b->start) {
+		kfree(b->size);
+		kfree(b);
+		goto unlock;
+	}
+
+	list_add(&b->list, &percpu_core.list);
+	ret = alloc_from_block(size, align, b);
+	BUG_ON(!ret);
+success:
+	/* Gives a pointer for use with per_cpu_ptr() etc. */
+	ret -= __per_cpu_offset[0];
+	for_each_cpu(cpu)
+		memset(per_cpu_ptr(ret, cpu), 0, size);
+unlock:
+	up(&percpu_lock);
+	return ret;
+}
+EXPORT_SYMBOL(__alloc_percpu);
+
+void free_percpu(const void *freeme)
+{
+	struct percpu_block *i;
+
+	freeme += __per_cpu_offset[0];
+
+	down(&percpu_lock);
+	/* Cleverly skips over kernel reserved space. */
+	list_for_each_entry(i, &percpu_core.list, list) {
+		if (freeme >= i->start && freeme < i->start + percpu_size) {
+			free_from_block(freeme, i);
+			goto unlock;
+		}
+	}
+	BUG();
+unlock:
+	up(&percpu_lock);
+}
+EXPORT_SYMBOL(free_percpu);
Index: linux-2.6.11-rc1-bk1-Percpu/init/main.c
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/init/main.c	2005-01-14 13:19:04.768613672 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/init/main.c	2005-01-14 13:19:24.843561816 +1100
@@ -300,38 +300,9 @@
 #define smp_init()	do { } while (0)
 #endif
 
-static inline void setup_per_cpu_areas(void) { }
 static inline void smp_prepare_cpus(unsigned int maxcpus) { }
 
 #else
-
-unsigned long __per_cpu_offset[NR_CPUS];
-EXPORT_SYMBOL(__per_cpu_offset);
-
-#ifdef __GENERIC_PER_CPU
-static void __init setup_per_cpu_areas(void)
-{
-	unsigned long size, i;
-	char *ptr;
-	/* Created by linker magic */
-	extern char __per_cpu_start[], __per_cpu_end[];
-
-	/* Copy section for each CPU (we discard the original) */
-	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
-#ifdef CONFIG_MODULES
-	if (size < PERCPU_ENOUGH_ROOM)
-		size = PERCPU_ENOUGH_ROOM;
-#endif
-
-	ptr = alloc_bootmem(size * NR_CPUS);
-
-	for (i = 0; i < NR_CPUS; i++, ptr += size) {
-		__per_cpu_offset[i] = ptr - __per_cpu_start;
-		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
-	}
-}
-#endif /* !__GENERIC_PER_CPU */
-
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
Index: linux-2.6.11-rc1-bk1-Percpu/kernel/module.c
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/kernel/module.c	2005-01-13 12:11:11.000000000 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/kernel/module.c	2005-01-14 13:19:24.845561512 +1100
@@ -209,152 +209,13 @@
 }
 
 #ifdef CONFIG_SMP
-/* Number of blocks used and allocated. */
-static unsigned int pcpu_num_used, pcpu_num_allocated;
-/* Size of each block.  -ve means used. */
-static int *pcpu_size;
-
-static int split_block(unsigned int i, unsigned short size)
-{
-	/* Reallocation required? */
-	if (pcpu_num_used + 1 > pcpu_num_allocated) {
-		int *new = kmalloc(sizeof(new[0]) * pcpu_num_allocated*2,
-				   GFP_KERNEL);
-		if (!new)
-			return 0;
-
-		memcpy(new, pcpu_size, sizeof(new[0])*pcpu_num_allocated);
-		pcpu_num_allocated *= 2;
-		kfree(pcpu_size);
-		pcpu_size = new;
-	}
-
-	/* Insert a new subblock */
-	memmove(&pcpu_size[i+1], &pcpu_size[i],
-		sizeof(pcpu_size[0]) * (pcpu_num_used - i));
-	pcpu_num_used++;
-
-	pcpu_size[i+1] -= size;
-	pcpu_size[i] = size;
-	return 1;
-}
-
-static inline unsigned int block_size(int val)
-{
-	if (val < 0)
-		return -val;
-	return val;
-}
-
-/* Created by linker magic */
-extern char __per_cpu_start[], __per_cpu_end[];
-
-static void *percpu_modalloc(unsigned long size, unsigned long align)
-{
-	unsigned long extra;
-	unsigned int i;
-	void *ptr;
-
-	BUG_ON(align > SMP_CACHE_BYTES);
-
-	ptr = __per_cpu_start;
-	for (i = 0; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
-		/* Extra for alignment requirement. */
-		extra = ALIGN((unsigned long)ptr, align) - (unsigned long)ptr;
-		BUG_ON(i == 0 && extra != 0);
-
-		if (pcpu_size[i] < 0 || pcpu_size[i] < extra + size)
-			continue;
-
-		/* Transfer extra to previous block. */
-		if (pcpu_size[i-1] < 0)
-			pcpu_size[i-1] -= extra;
-		else
-			pcpu_size[i-1] += extra;
-		pcpu_size[i] -= extra;
-		ptr += extra;
-
-		/* Split block if warranted */
-		if (pcpu_size[i] - size > sizeof(unsigned long))
-			if (!split_block(i, size))
-				return NULL;
-
-		/* Mark allocated */
-		pcpu_size[i] = -pcpu_size[i];
-		return ptr;
-	}
-
-	printk(KERN_WARNING "Could not allocate %lu bytes percpu data\n",
-	       size);
-	return NULL;
-}
-
-static void percpu_modfree(void *freeme)
-{
-	unsigned int i;
-	void *ptr = __per_cpu_start + block_size(pcpu_size[0]);
-
-	/* First entry is core kernel percpu data. */
-	for (i = 1; i < pcpu_num_used; ptr += block_size(pcpu_size[i]), i++) {
-		if (ptr == freeme) {
-			pcpu_size[i] = -pcpu_size[i];
-			goto free;
-		}
-	}
-	BUG();
-
- free:
-	/* Merge with previous? */
-	if (pcpu_size[i-1] >= 0) {
-		pcpu_size[i-1] += pcpu_size[i];
-		pcpu_num_used--;
-		memmove(&pcpu_size[i], &pcpu_size[i+1],
-			(pcpu_num_used - i) * sizeof(pcpu_size[0]));
-		i--;
-	}
-	/* Merge with next? */
-	if (i+1 < pcpu_num_used && pcpu_size[i+1] >= 0) {
-		pcpu_size[i] += pcpu_size[i+1];
-		pcpu_num_used--;
-		memmove(&pcpu_size[i+1], &pcpu_size[i+2],
-			(pcpu_num_used - (i+1)) * sizeof(pcpu_size[0]));
-	}
-}
-
 static unsigned int find_pcpusec(Elf_Ehdr *hdr,
 				 Elf_Shdr *sechdrs,
 				 const char *secstrings)
 {
 	return find_sec(hdr, sechdrs, secstrings, ".data.percpu");
 }
-
-static int percpu_modinit(void)
-{
-	pcpu_num_used = 2;
-	pcpu_num_allocated = 2;
-	pcpu_size = kmalloc(sizeof(pcpu_size[0]) * pcpu_num_allocated,
-			    GFP_KERNEL);
-	/* Static in-kernel percpu data (used). */
-	pcpu_size[0] = -ALIGN(__per_cpu_end-__per_cpu_start, SMP_CACHE_BYTES);
-	/* Free room. */
-	pcpu_size[1] = PERCPU_ENOUGH_ROOM + pcpu_size[0];
-	if (pcpu_size[1] < 0) {
-		printk(KERN_ERR "No per-cpu room for modules.\n");
-		pcpu_num_used = 1;
-	}
-
-	return 0;
-}	
-__initcall(percpu_modinit);
 #else /* ... !CONFIG_SMP */
-static inline void *percpu_modalloc(unsigned long size, unsigned long align)
-{
-	return NULL;
-}
-static inline void percpu_modfree(void *pcpuptr)
-{
-	BUG();
-}
 static inline unsigned int find_pcpusec(Elf_Ehdr *hdr,
 					Elf_Shdr *sechdrs,
 					const char *secstrings)
Index: linux-2.6.11-rc1-bk1-Percpu/include/linux/percpu.h
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/include/linux/percpu.h	2005-01-14 13:19:04.985580688 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/include/linux/percpu.h	2005-01-14 13:19:24.846561360 +1100
@@ -1,7 +1,7 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
 #include <linux/spinlock.h> /* For preempt_disable() */
-#include <linux/slab.h> /* For kmalloc() */
+#include <linux/slab.h> /* FIXME: remove this, fix hangers-on --RR */
 #include <linux/smp.h>
 #include <linux/string.h> /* For memset() */
 #include <asm/percpu.h>
@@ -20,24 +20,18 @@
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
-struct percpu_data {
-	void *ptrs[NR_CPUS];
-	void *blkp;
-};
-
 /* 
  * Use this to get to a cpu's version of the per-cpu object allocated using
- * alloc_percpu.  Non-atomic access to the current CPU's version should
- * probably be combined with get_cpu()/put_cpu().
+ * alloc_percpu.  If you want to get "this cpu's version", maybe you want
+ * to use get_cpu_ptr... 
  */ 
-#define per_cpu_ptr(ptr, cpu)                   \
-({                                              \
-        struct percpu_data *__p = (struct percpu_data *)~(unsigned long)(ptr); \
-        (__typeof__(ptr))__p->ptrs[(cpu)];	\
-})
+#define per_cpu_ptr(ptr, cpu)						\
+        ((__typeof__(ptr))((void *)ptr + __per_cpu_offset[(cpu)]))
 
-extern void *__alloc_percpu(size_t size, size_t align);
+extern void *__alloc_percpu(unsigned long size, unsigned long align);
 extern void free_percpu(const void *);
+extern void *percpu_modalloc(unsigned long size, unsigned long align);
+extern void percpu_modfree(void *freeme);
 
 #else /* CONFIG_SMP */
 
@@ -55,6 +49,14 @@
 	kfree(ptr);
 }
 
+static inline void *percpu_modalloc(unsigned long size, unsigned long align)
+{
+	return NULL;
+}
+	
+static inline void percpu_modfree(void *freeme)
+{
+}
 #endif /* CONFIG_SMP */
 
 /* Simple wrapper for the common case: zeros memory. */
Index: linux-2.6.11-rc1-bk1-Percpu/mm/slab.c
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/mm/slab.c	2005-01-13 12:11:12.000000000 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/mm/slab.c	2005-01-14 13:21:04.201457120 +1100
@@ -2476,51 +2476,6 @@
 
 EXPORT_SYMBOL(__kmalloc);
 
-#ifdef CONFIG_SMP
-/**
- * __alloc_percpu - allocate one copy of the object for every present
- * cpu in the system, zeroing them.
- * Objects should be dereferenced using the per_cpu_ptr macro only.
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
-		pdata->ptrs[i] = kmem_cache_alloc_node(
-				kmem_find_general_cachep(size, GFP_KERNEL),
-				cpu_to_node(i));
-
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
-
-EXPORT_SYMBOL(__alloc_percpu);
-#endif
-
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
@@ -2584,31 +2539,6 @@
 
 EXPORT_SYMBOL(kfree);
 
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
-	kfree(p);
-}
-
-EXPORT_SYMBOL(free_percpu);
-#endif
-
 unsigned int kmem_cache_size(kmem_cache_t *cachep)
 {
 	return obj_reallen(cachep);
Index: linux-2.6.11-rc1-bk1-Percpu/mm/Makefile
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/mm/Makefile	2005-01-13 12:11:12.000000000 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/mm/Makefile	2005-01-14 13:19:24.868558016 +1100
@@ -17,4 +17,4 @@
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
-
+obj-$(CONFIG_SMP)	+= percpu.o
Index: linux-2.6.11-rc1-bk1-Percpu/include/asm-generic/percpu.h
===================================================================
--- linux-2.6.11-rc1-bk1-Percpu.orig/include/asm-generic/percpu.h	2005-01-14 13:19:05.099563360 +1100
+++ linux-2.6.11-rc1-bk1-Percpu/include/asm-generic/percpu.h	2005-01-14 13:19:24.869557864 +1100
@@ -10,6 +10,8 @@
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
 
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
+#define __get_cpu_ptr(ptr) \
+	((__typeof__(ptr))((void *)ptr + __per_cpu_offset[smp_processor_id()]))
 
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
@@ -20,6 +22,8 @@
 			memcpy((pcpudst)+__per_cpu_offset[__i],	\
 			       (src), (size));			\
 } while (0)
+
+void setup_per_cpu_areas(void);
 #else /* ! SMP */
 
 #define DEFINE_PER_CPU(type, name) \
@@ -27,7 +31,10 @@
 
 #define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
-
+#define __get_cpu_ptr(ptr)			(ptr)
+static inline void setup_per_cpu_areas(void)
+{
+}
 #endif	/* SMP */
 
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

