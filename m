Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbULAX6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbULAX6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbULAX6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:58:19 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20971 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261502AbULAXny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:43:54 -0500
Date: Wed, 1 Dec 2004 15:43:20 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V12 [3/7]: universal cmpxchg for i386
In-Reply-To: <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412011542550.5721@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
        * Make cmpxchg and cmpxchg8b generally available on the i386
	  platform.
        * Provide emulation of cmpxchg suitable for uniprocessor if
	  build and run on 386.
        * Provide emulation of cmpxchg8b suitable for uniprocessor
	  systems if build and run on 386 or 486.
	* Provide an inline function to atomically get a 64 bit value
	  via cmpxchg8b in an SMP system (courtesy of Nick Piggin)
	  (important for i386 PAE mode and other places where atomic
	  64 bit operations are useful)

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/arch/i386/Kconfig
===================================================================
--- linux-2.6.9.orig/arch/i386/Kconfig	2004-11-15 11:13:34.000000000 -0800
+++ linux-2.6.9/arch/i386/Kconfig	2004-11-19 10:02:54.000000000 -0800
@@ -351,6 +351,11 @@
 	depends on !M386
 	default y

+config X86_CMPXCHG8B
+	bool
+	depends on !M386 && !M486
+	default y
+
 config X86_XADD
 	bool
 	depends on !M386
Index: linux-2.6.9/arch/i386/kernel/cpu/intel.c
===================================================================
--- linux-2.6.9.orig/arch/i386/kernel/cpu/intel.c	2004-11-15 11:13:34.000000000 -0800
+++ linux-2.6.9/arch/i386/kernel/cpu/intel.c	2004-11-19 10:38:26.000000000 -0800
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include <linux/smp.h>
 #include <linux/thread_info.h>
+#include <linux/module.h>

 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -287,5 +288,103 @@
 	return 0;
 }

+#ifndef CONFIG_X86_CMPXCHG
+unsigned long cmpxchg_386_u8(volatile void *ptr, u8 old, u8 new)
+{
+	u8 prev;
+	unsigned long flags;
+	/*
+	 * Check if the kernel was compiled for an old cpu but the
+	 * currently running cpu can do cmpxchg after all
+	 * All CPUs except 386 support CMPXCHG
+	 */
+	if (cpu_data->x86 > 3)
+		return __cmpxchg(ptr, old, new, sizeof(u8));
+
+	/* Poor man's cmpxchg for 386. Unsuitable for SMP */
+	local_irq_save(flags);
+	prev = *(u8 *)ptr;
+	if (prev == old)
+		*(u8 *)ptr = new;
+	local_irq_restore(flags);
+	return prev;
+}
+
+EXPORT_SYMBOL(cmpxchg_386_u8);
+
+unsigned long cmpxchg_386_u16(volatile void *ptr, u16 old, u16 new)
+{
+	u16 prev;
+	unsigned long flags;
+	/*
+	 * Check if the kernel was compiled for an old cpu but the
+	 * currently running cpu can do cmpxchg after all
+	 * All CPUs except 386 support CMPXCHG
+	 */
+	if (cpu_data->x86 > 3)
+		return __cmpxchg(ptr, old, new, sizeof(u16));
+
+	/* Poor man's cmpxchg for 386. Unsuitable for SMP */
+	local_irq_save(flags);
+	prev = *(u16 *)ptr;
+	if (prev == old)
+		*(u16 *)ptr = new;
+	local_irq_restore(flags);
+	return prev;
+}
+
+EXPORT_SYMBOL(cmpxchg_386_u16);
+
+unsigned long cmpxchg_386_u32(volatile void *ptr, u32 old, u32 new)
+{
+	u32 prev;
+	unsigned long flags;
+	/*
+	 * Check if the kernel was compiled for an old cpu but the
+	 * currently running cpu can do cmpxchg after all
+	 * All CPUs except 386 support CMPXCHG
+	 */
+	if (cpu_data->x86 > 3)
+		return __cmpxchg(ptr, old, new, sizeof(u32));
+
+	/* Poor man's cmpxchg for 386. Unsuitable for SMP */
+	local_irq_save(flags);
+	prev = *(u32 *)ptr;
+	if (prev == old)
+		*(u32 *)ptr = new;
+	local_irq_restore(flags);
+	return prev;
+}
+
+EXPORT_SYMBOL(cmpxchg_386_u32);
+#endif
+
+#ifndef CONFIG_X86_CMPXCHG8B
+unsigned long long cmpxchg8b_486(volatile unsigned long long *ptr,
+	       unsigned long long old, unsigned long long newv)
+{
+	unsigned long long prev;
+	unsigned long flags;
+
+	/*
+	 * Check if the kernel was compiled for an old cpu but
+	 * we are running really on a cpu capable of cmpxchg8b
+	 */
+
+	if (cpu_has(cpu_data, X86_FEATURE_CX8))
+		return __cmpxchg8b(ptr, old, newv);
+
+	/* Poor mans cmpxchg8b for 386 and 486. Not suitable for SMP */
+	local_irq_save(flags);
+	prev = *ptr;
+	if (prev == old)
+		*ptr = newv;
+	local_irq_restore(flags);
+	return prev;
+}
+
+EXPORT_SYMBOL(cmpxchg8b_486);
+#endif
+
 // arch_initcall(intel_cpu_init);

Index: linux-2.6.9/include/asm-i386/system.h
===================================================================
--- linux-2.6.9.orig/include/asm-i386/system.h	2004-11-15 11:13:38.000000000 -0800
+++ linux-2.6.9/include/asm-i386/system.h	2004-11-19 10:49:46.000000000 -0800
@@ -149,6 +149,9 @@
 #define __xg(x) ((struct __xchg_dummy *)(x))


+#define ll_low(x)	*(((unsigned int*)&(x))+0)
+#define ll_high(x)	*(((unsigned int*)&(x))+1)
+
 /*
  * The semantics of XCHGCMP8B are a bit strange, this is why
  * there is a loop and the loading of %%eax and %%edx has to
@@ -184,8 +187,6 @@
 {
 	__set_64bit(ptr,(unsigned int)(value), (unsigned int)((value)>>32ULL));
 }
-#define ll_low(x)	*(((unsigned int*)&(x))+0)
-#define ll_high(x)	*(((unsigned int*)&(x))+1)

 static inline void __set_64bit_var (unsigned long long *ptr,
 			 unsigned long long value)
@@ -203,6 +204,26 @@
  __set_64bit(ptr, (unsigned int)(value), (unsigned int)((value)>>32ULL) ) : \
  __set_64bit(ptr, ll_low(value), ll_high(value)) )

+static inline unsigned long long __get_64bit(unsigned long long * ptr)
+{
+	unsigned long long ret;
+	__asm__ __volatile__ (
+		"\n1:\t"
+		"movl (%1), %%eax\n\t"
+		"movl 4(%1), %%edx\n\t"
+		"movl %%eax, %%ebx\n\t"
+		"movl %%edx, %%ecx\n\t"
+		LOCK_PREFIX "cmpxchg8b (%1)\n\t"
+		"jnz 1b"
+		:	"=A"(ret)
+		:	"D"(ptr)
+		:	"ebx", "ecx", "memory");
+	return ret;
+}
+
+#define get_64bit(ptr) __get_64bit(ptr)
+
+
 /*
  * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
  * Note 2: xchg has side effect, so that attribute volatile is necessary,
@@ -240,7 +261,41 @@
  */

 #ifdef CONFIG_X86_CMPXCHG
+
 #define __HAVE_ARCH_CMPXCHG 1
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o), \
+					(unsigned long)(n), sizeof(*(ptr))))
+
+#else
+
+/*
+ * Building a kernel capable running on 80386. It may be necessary to
+ * simulate the cmpxchg on the 80386 CPU. For that purpose we define
+ * a function for each of the sizes we support.
+ */
+
+extern unsigned long cmpxchg_386_u8(volatile void *, u8, u8);
+extern unsigned long cmpxchg_386_u16(volatile void *, u16, u16);
+extern unsigned long cmpxchg_386_u32(volatile void *, u32, u32);
+
+static inline unsigned long cmpxchg_386(volatile void *ptr, unsigned long old,
+				      unsigned long new, int size)
+{
+	switch (size) {
+	case 1:
+		return cmpxchg_386_u8(ptr, old, new);
+	case 2:
+		return cmpxchg_386_u16(ptr, old, new);
+	case 4:
+		return cmpxchg_386_u32(ptr, old, new);
+	}
+	return old;
+}
+
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))cmpxchg_386((ptr), (unsigned long)(o), \
+					(unsigned long)(n), sizeof(*(ptr))))
 #endif

 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
@@ -270,10 +325,32 @@
 	return old;
 }

-#define cmpxchg(ptr,o,n)\
-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
-					(unsigned long)(n),sizeof(*(ptr))))
-
+static inline unsigned long long __cmpxchg8b(volatile unsigned long long *ptr,
+		unsigned long long old, unsigned long long newv)
+{
+	unsigned long long prev;
+	__asm__ __volatile__(
+	LOCK_PREFIX "cmpxchg8b (%4)"
+		: "=A" (prev)
+		: "0" (old), "c" ((unsigned long)(newv >> 32)),
+		  "b" ((unsigned long)(newv & 0xffffffffULL)), "D" (ptr)
+		: "memory");
+	return prev;
+}
+
+#ifdef CONFIG_X86_CMPXCHG8B
+#define cmpxchg8b __cmpxchg8b
+#else
+/*
+ * Building a kernel capable of running on 80486 and 80386. Both
+ * do not support cmpxchg8b. Call a function that emulates the
+ * instruction if necessary.
+ */
+extern unsigned long long cmpxchg8b_486(volatile unsigned long long *,
+		unsigned long long, unsigned long long);
+#define cmpxchg8b cmpxchg8b_486
+#endif
+
 #ifdef __KERNEL__
 struct alt_instr {
 	__u8 *instr; 		/* original instruction */

