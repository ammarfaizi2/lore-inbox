Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270427AbTGPIdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270429AbTGPIcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:32:33 -0400
Received: from dp.samba.org ([66.70.73.150]:11939 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270427AbTGPIZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:25:59 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 5/5] local_t for Sparc64
Date: Wed, 16 Jul 2003 18:39:44 +1000
Message-Id: <20030716084051.3DD002C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave was first with an arch-specific version.

Name: local_t for sparc64
Author: "David S. Miller" <davem@redhat.com>
Status: Tested on 2.6.0-test1
Depends: Percpu/local_t.patch.gz
Depends: Misc/i386_linker_symbols.patch.gz

D: Ok, here are the bits for sparc64.  Platforms, such as PPC64 and Alpha
D: (and in fact any "load linked/store conditional" like platform other
D: than IA64), probably wants to do something similar.
D: 
D: It also fixes the compile errors I got due to the kernel/profile.c
D: 
D: I'm currently running a 2.6.0-test1 kernel on my main devel machine
D: using your patch plus this stuff below.
D: 
D: [davem@nuts percpu-2.5]$ dmesg | grep local_test
D: local_test 0: 5000 1000 557792570 557798570
D: local_test 1: 4999 0 0 4999
D: [davem@nuts percpu-2.5]$

--- ./arch/sparc64/kernel/sparc64_ksyms.c.~1~	Mon Jul 14 21:35:42 2003
+++ ./arch/sparc64/kernel/sparc64_ksyms.c	Mon Jul 14 21:36:01 2003
@@ -176,6 +176,8 @@ EXPORT_SYMBOL(up);
 /* Atomic counter implementation. */
 EXPORT_SYMBOL(__atomic_add);
 EXPORT_SYMBOL(__atomic_sub);
+EXPORT_SYMBOL(__atomic64_add);
+EXPORT_SYMBOL(__atomic64_sub);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
--- ./arch/sparc64/kernel/time.c.~1~	Mon Jul 14 21:56:53 2003
+++ ./arch/sparc64/kernel/time.c	Mon Jul 14 21:57:08 2003
@@ -41,6 +41,7 @@
 #include <asm/isa.h>
 #include <asm/starfire.h>
 #include <asm/smp.h>
+#include <asm/sections.h>
 
 spinlock_t mostek_lock = SPIN_LOCK_UNLOCKED;
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
@@ -449,7 +450,6 @@ void sparc64_do_profile(struct pt_regs *
 		return;
 
 	{
-		extern int _stext;
 		extern int rwlock_impl_begin, rwlock_impl_end;
 		extern int atomic_impl_begin, atomic_impl_end;
 		extern int __memcpy_begin, __memcpy_end;
@@ -468,7 +468,7 @@ void sparc64_do_profile(struct pt_regs *
 		     pc < (unsigned long) &__bitops_end))
 			pc = o7;
 
-		pc -= (unsigned long) &_stext;
+		pc -= (unsigned long) _stext;
 		pc >>= prof_shift;
 
 		if(pc >= prof_len)
--- ./arch/sparc64/lib/atomic.S.~1~	Mon Jul 14 21:27:48 2003
+++ ./arch/sparc64/lib/atomic.S	Mon Jul 14 21:28:57 2003
@@ -33,4 +33,27 @@ __atomic_sub: /* %o0 = increment, %o1 = 
 	 membar	#StoreLoad | #StoreStore
 	retl
 	 sub	%g7, %o0, %o0
+
+	.globl	__atomic64_add
+__atomic64_add: /* %o0 = increment, %o1 = atomic_ptr */
+	ldx	[%o1], %g5
+	add	%g5, %o0, %g7
+	casx	[%o1], %g5, %g7
+	cmp	%g5, %g7
+	bne,pn	%xcc, __atomic64_add
+	 membar	#StoreLoad | #StoreStore
+	retl
+	 add	%g7, %o0, %o0
+
+	.globl	__atomic64_sub
+__atomic64_sub: /* %o0 = increment, %o1 = atomic_ptr */
+	ldx	[%o1], %g5
+	sub	%g5, %o0, %g7
+	casx	[%o1], %g5, %g7
+	cmp	%g5, %g7
+	bne,pn	%xcc, __atomic64_sub
+	 membar	#StoreLoad | #StoreStore
+	retl
+	 sub	%g7, %o0, %o0
+
 atomic_impl_end:
--- ./arch/sparc64/mm/fault.c.~1~	Mon Jul 14 21:46:56 2003
+++ ./arch/sparc64/mm/fault.c	Mon Jul 14 21:47:11 2003
@@ -26,6 +26,7 @@
 #include <asm/uaccess.h>
 #include <asm/asi.h>
 #include <asm/lsu.h>
+#include <asm/sections.h>
 
 #define ELEMENTS(arr) (sizeof (arr)/sizeof (arr[0]))
 
@@ -320,10 +321,9 @@ asmlinkage void do_sparc64_fault(struct 
 
 	if (regs->tstate & TSTATE_PRIV) {
 		unsigned long tpc = regs->tpc;
-		extern unsigned int _etext;
 
 		/* Sanity check the PC. */
-		if ((tpc >= KERNBASE && tpc < (unsigned long) &_etext) ||
+		if ((tpc >= KERNBASE && tpc < (unsigned long) _etext) ||
 		    (tpc >= MODULES_VADDR && tpc < MODULES_END)) {
 			/* Valid, no problems... */
 		} else {
--- ./arch/sparc64/mm/init.c.~1~	Mon Jul 14 21:47:48 2003
+++ ./arch/sparc64/mm/init.c	Mon Jul 14 23:34:34 2003
@@ -35,6 +35,7 @@
 #include <asm/starfire.h>
 #include <asm/tlb.h>
 #include <asm/spitfire.h>
+#include <asm/sections.h>
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
@@ -56,8 +57,8 @@ unsigned long tlb_context_cache = CTX_FI
 #define CTX_BMAP_SLOTS (1UL << (CTX_VERSION_SHIFT - 6))
 unsigned long mmu_context_bmap[CTX_BMAP_SLOTS];
 
-/* References to section boundaries */
-extern char __init_begin, __init_end, _start, _end, etext, edata;
+/* References to special section boundaries */
+extern char  _start[], _end[];
 
 /* Initial ramdisk setup */
 extern unsigned int sparc_ramdisk_image;
@@ -1333,7 +1334,7 @@ unsigned long __init bootmem_init(unsign
 	 * image.  The kernel is hard mapped below PAGE_OFFSET in a
 	 * 4MB locked TLB translation.
 	 */
-	start_pfn  = PAGE_ALIGN((unsigned long) &_end) -
+	start_pfn  = PAGE_ALIGN((unsigned long) _end) -
 		((unsigned long) KERNBASE);
 
 	/* Adjust up to the physical address where the kernel begins. */
@@ -1349,7 +1350,7 @@ unsigned long __init bootmem_init(unsign
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Now have to check initial ramdisk, so that bootmap does not overwrite it */
 	if (sparc_ramdisk_image) {
-		if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
+		if (sparc_ramdisk_image >= (unsigned long)_end - 2 * PAGE_SIZE)
 			sparc_ramdisk_image -= KERNBASE;
 		initrd_start = sparc_ramdisk_image + phys_base;
 		initrd_end = initrd_start + sparc_ramdisk_size;
@@ -1426,7 +1427,7 @@ void __init paging_init(void)
 
 	set_bit(0, mmu_context_bmap);
 
-	real_end = (unsigned long)&_end;
+	real_end = (unsigned long)_end;
 	if ((real_end > ((unsigned long)KERNBASE + 0x400000)))
 		bigkernel = 1;
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -1718,7 +1719,7 @@ void __init mem_init(void)
 	memset(sparc64_valid_addr_bitmap, 0, i << 3);
 
 	addr = PAGE_OFFSET + phys_base;
-	last = PAGE_ALIGN((unsigned long)&_end) -
+	last = PAGE_ALIGN((unsigned long)_end) -
 		((unsigned long) KERNBASE);
 	last += PAGE_OFFSET + phys_base;
 	while (addr < last) {
@@ -1745,11 +1746,11 @@ void __init mem_init(void)
 	SetPageReserved(mem_map_zero);
 	clear_page(page_address(mem_map_zero));
 
-	codepages = (((unsigned long) &etext) - ((unsigned long)&_start));
+	codepages = (((unsigned long) _etext) - ((unsigned long) _start));
 	codepages = PAGE_ALIGN(codepages) >> PAGE_SHIFT;
-	datapages = (((unsigned long) &edata) - ((unsigned long)&etext));
+	datapages = (((unsigned long) _edata) - ((unsigned long) _etext));
 	datapages = PAGE_ALIGN(datapages) >> PAGE_SHIFT;
-	initpages = (((unsigned long) &__init_end) - ((unsigned long) &__init_begin));
+	initpages = (((unsigned long) __init_end) - ((unsigned long) __init_begin));
 	initpages = PAGE_ALIGN(initpages) >> PAGE_SHIFT;
 
 #ifndef CONFIG_SMP
@@ -1812,9 +1813,9 @@ void free_initmem (void)
 	/*
 	 * The init section is aligned to 8k in vmlinux.lds. Page align for >8k pagesizes.
 	 */
-	addr = PAGE_ALIGN((unsigned long)(&__init_begin));
-	initend = (unsigned long)(&__init_end) & PAGE_MASK;
+	addr = PAGE_ALIGN((unsigned long)(__init_begin));
+	initend = (unsigned long)(__init_end) & PAGE_MASK;
 	for (; addr < initend; addr += PAGE_SIZE) {
 		unsigned long page;
 		struct page *p;
--- ./include/asm-sparc64/atomic.h.~1~	Mon Jul 14 21:26:41 2003
+++ ./include/asm-sparc64/atomic.h	Mon Jul 14 21:30:23 2003
@@ -9,25 +9,46 @@
 #define __ARCH_SPARC64_ATOMIC__
 
 typedef struct { volatile int counter; } atomic_t;
-#define ATOMIC_INIT(i)	{ (i) }
+typedef struct { volatile long counter; } atomic64_t;
+
+#define ATOMIC_INIT(i)		{ (i) }
+#define ATOMIC64_INIT(i)	{ (i) }
 
 #define atomic_read(v)		((v)->counter)
+#define atomic64_read(v)	((v)->counter)
+
 #define atomic_set(v, i)	(((v)->counter) = i)
+#define atomic64_set(v, i)	(((v)->counter) = i)
 
 extern int __atomic_add(int, atomic_t *);
+extern int __atomic64_add(int, atomic64_t *);
+
 extern int __atomic_sub(int, atomic_t *);
+extern int __atomic64_sub(int, atomic64_t *);
 
 #define atomic_add(i, v) ((void)__atomic_add(i, v))
+#define atomic64_add(i, v) ((void)__atomic64_add(i, v))
+
 #define atomic_sub(i, v) ((void)__atomic_sub(i, v))
+#define atomic64_sub(i, v) ((void)__atomic64_sub(i, v))
 
 #define atomic_dec_return(v) __atomic_sub(1, v)
+#define atomic64_dec_return(v) __atomic64_sub(1, v)
+
 #define atomic_inc_return(v) __atomic_add(1, v)
+#define atomic64_inc_return(v) __atomic64_add(1, v)
 
 #define atomic_sub_and_test(i, v) (__atomic_sub(i, v) == 0)
+#define atomic64_sub_and_test(i, v) (__atomic64_sub(i, v) == 0)
+
 #define atomic_dec_and_test(v) (__atomic_sub(1, v) == 0)
+#define atomic64_dec_and_test(v) (__atomic64_sub(1, v) == 0)
 
 #define atomic_inc(v) ((void)__atomic_add(1, v))
+#define atomic64_inc(v) ((void)__atomic64_add(1, v))
+
 #define atomic_dec(v) ((void)__atomic_sub(1, v))
+#define atomic64_dec(v) ((void)__atomic64_sub(1, v))
 
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
--- ./include/asm-sparc64/local.h.~1~	Mon Jul 14 21:36:30 2003
+++ ./include/asm-sparc64/local.h	Mon Jul 14 21:35:16 2003
@@ -0,0 +1,40 @@
+#ifndef _ARCH_SPARC64_LOCAL_H
+#define _ARCH_SPARC64_LOCAL_H
+
+#include <linux/percpu.h>
+#include <asm/atomic.h>
+
+typedef atomic64_t local_t;
+
+#define LOCAL_INIT(i)	ATOMIC64_INIT(i)
+#define local_read(v)	atomic64_read(v)
+#define local_set(v,i)	atomic64_set(v,i)
+
+#define local_inc(v)	atomic64_inc(v)
+#define local_dec(v)	atomic64_inc(v)
+#define local_add(i, v)	atomic64_add(i, v)
+#define local_sub(i, v)	atomic64_sub(i, v)
+
+#define __local_inc(v)		((v)->counter++)
+#define __local_dec(v)		((v)->counter++)
+#define __local_add(i,v)	((v)->counter+=(i))
+#define __local_sub(i,v)	((v)->counter-=(i))
+
+/* Use these for per-cpu local_t variables: on some archs they are
+ * much more efficient than these naive implementations.  Note they take
+ * a variable, not an address.
+ */
+#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
+#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
+
+#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
+#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
+#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
+#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
+
+#define __cpu_local_inc(v)	__local_inc(&__get_cpu_var(v))
+#define __cpu_local_dec(v)	__local_dec(&__get_cpu_var(v))
+#define __cpu_local_add(i, v)	__local_add((i), &__get_cpu_var(v))
+#define __cpu_local_sub(i, v)	__local_sub((i), &__get_cpu_var(v))
+
+#endif /* _ARCH_SPARC64_LOCAL_H */
--- ./include/asm-sparc64/sections.h.~1~	Mon Jul 14 21:42:45 2003
+++ ./include/asm-sparc64/sections.h	Mon Jul 14 21:42:32 2003
@@ -0,0 +1,7 @@
+#ifndef _SPARC64_SECTIONS_H
+#define _SPARC64_SECTIONS_H
+
+/* nothing to see, move along */
+#include <asm-generic/sections.h>
+
+#endif

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
