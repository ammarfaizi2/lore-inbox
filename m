Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSGRSzE>; Thu, 18 Jul 2002 14:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSGRSzE>; Thu, 18 Jul 2002 14:55:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18613 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318305AbSGRSyw>;
	Thu, 18 Jul 2002 14:54:52 -0400
Date: Fri, 19 Jul 2002 00:32:08 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] read_barrier_depends 2.5.26
Message-ID: <20020719003208.A6466@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch should also be considered for inclusion along with RCU.
This patch adds a read_barrier_depends(), lighter than rmb(), to be
used to ensure that data-dependant reads are not re-ordered over
this barrier. The patch also adds more descriptive names for
the other memory barrier interfaces as you had suggested -

http://marc.theaimsgroup.com/?l=linux-kernel&m=100290433130211&w=2

Also included are the list macros useful for use along with
RCU (as suggested by Alexey).

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

Description :
-------------

Sometime ago, during a discussion on lock-free lookups, it was
agreed that an additional memory barrier interface,
read_barrier_depends() that is lighter than an rmb(),
is necessary to make sure that data-dependent reads are not
re-ordered over this barrier. For many processors, data-dependency
enforces order, so this interface is a NOP, but for those that don't
(like alpha), it can be a read_barrier().

For example, the following code would force ordering (the initial
value of "a" is zero, "b" is one, and "p" is "&a"):

    CPU 0                           CPU 1

    b = 2;
    memory_barrier();
    p = &b;                         q = p;
                                    read_barrier_depends();
                                    d = *q;

because the read of "*q" depends on the read of "p" and these
two reads should be separated by a read_barrier_depends().  However,
the following code, with the same initial values for "a" and "b":

    CPU 0                           CPU 1

    a = 2;
    memory_barrier();
    b = 3;                          y = b;
                                    read_barrier_depends();
                                    x = a;

does not enforce ordering, since there is no data dependency between
the read of "a" and the read of "b".  Therefore, on some CPUs, such
as Alpha, "y" could be set to 3 and "x" to 0.  read_barrier()
needs to be used here, not read_barrier_depends().

The original discussion can be found at -
http://marc.theaimsgroup.com/?t=100259422200002&r=1&w=2

Explanation of the need for read_barrier_depends() 
can be found at http://lse.sf.net/locking/wmbdd.html

read_barrier_depends-2.5.26-1.patch
-----------------------------------

diff -urN linux-2.5.26-base/Documentation/DocBook/kernel-api.tmpl linux-2.5.26-read_barrier_depends/Documentation/DocBook/kernel-api.tmpl
--- linux-2.5.26-base/Documentation/DocBook/kernel-api.tmpl	Wed Jul 17 05:19:21 2002
+++ linux-2.5.26-read_barrier_depends/Documentation/DocBook/kernel-api.tmpl	Wed Jul 17 16:18:17 2002
@@ -41,9 +41,10 @@
 !Iinclude/linux/init.h
      </sect1>
 
-     <sect1><title>Atomic and pointer manipulation</title>
+     <sect1><title>Safe memory access and pointer manipulation</title>
 !Iinclude/asm-i386/atomic.h
 !Iinclude/asm-i386/unaligned.h
+!Iinclude/asm-i386/system.h
      </sect1>
 
 <!-- FIXME:
diff -urN linux-2.5.26-base/include/asm-alpha/system.h linux-2.5.26-read_barrier_depends/include/asm-alpha/system.h
--- linux-2.5.26-base/include/asm-alpha/system.h	Wed Jul 17 05:19:35 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-alpha/system.h	Wed Jul 17 16:18:17 2002
@@ -140,22 +140,31 @@
 struct task_struct;
 extern void alpha_switch_to(unsigned long, struct task_struct*);
 
-#define mb() \
+#define memory_barrier() \
 __asm__ __volatile__("mb": : :"memory")
 
-#define rmb() \
+#define read_barrier() \
 __asm__ __volatile__("mb": : :"memory")
 
-#define wmb() \
+#define read_barrier_depends() \
+__asm__ __volatile__("mb": : :"memory")
+
+#define write_barrier() \
 __asm__ __volatile__("wmb": : :"memory")
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	barrier()
 #define smp_wmb()	barrier()
 #endif
 
diff -urN linux-2.5.26-base/include/asm-arm/system.h linux-2.5.26-read_barrier_depends/include/asm-arm/system.h
--- linux-2.5.26-base/include/asm-arm/system.h	Wed Jul 17 05:19:26 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-arm/system.h	Wed Jul 17 16:18:17 2002
@@ -49,11 +49,16 @@
  */
 #include <asm/proc/system.h>
 
-#define mb() __asm__ __volatile__ ("" : : : "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define memory_barrier() __asm__ __volatile__ ("" : : : "memory")
+#define read_barrier() memory_barrier()
+#define read_barrier_depends() do { } while(0)
+#define write_barrier() memory_barrier()
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #define prepare_to_switch()    do { } while(0)
 
 /*
@@ -86,12 +91,14 @@
 
 #define smp_mb()		mb()
 #define smp_rmb()		rmb()
+#define smp_read_barrier_depends()		read_barrier_depends()
 #define smp_wmb()		wmb()
 
 #else
 
 #define smp_mb()		barrier()
 #define smp_rmb()		barrier()
+#define smp_read_barrier_depends()		do { } while(0)
 #define smp_wmb()		barrier()
 
 #define cli()			__cli()
diff -urN linux-2.5.26-base/include/asm-cris/system.h linux-2.5.26-read_barrier_depends/include/asm-cris/system.h
--- linux-2.5.26-base/include/asm-cris/system.h	Wed Jul 17 05:19:34 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-cris/system.h	Wed Jul 17 16:18:17 2002
@@ -147,17 +147,24 @@
 #endif
 }
 
-#define mb() __asm__ __volatile__ ("" : : : "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define memory_barrier() __asm__ __volatile__ ("" : : : "memory")
+#define read_barrier() memory_barrier()
+#define read_barrier_depends() do { } while(0)
+#define write_barrier() memory_barrier()
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #ifdef CONFIG_SMP
 #define smp_mb()        mb()
 #define smp_rmb()       rmb()
+#define smp_read_barrier_depends()     read_barrier_depends()
 #define smp_wmb()       wmb()
 #else
 #define smp_mb()        barrier()
 #define smp_rmb()       barrier()
+#define smp_read_barrier_depends()     do { } while(0)
 #define smp_wmb()       barrier()
 #endif
 
diff -urN linux-2.5.26-base/include/asm-i386/system.h linux-2.5.26-read_barrier_depends/include/asm-i386/system.h
--- linux-2.5.26-base/include/asm-i386/system.h	Wed Jul 17 05:19:22 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-i386/system.h	Wed Jul 17 16:18:17 2002
@@ -287,23 +287,182 @@
  * Some non intel clones support out of order store. wmb() ceases to be a
  * nop for these.
  */
- 
-#define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
-#define rmb()	mb()
+
+/**
+ * memory_barrier - Flush all pending memory accesses
+ *
+ * No access of memory-like regions is ever reordered over this barrier.
+ * All stores preceding this primitive are guaranteed to be visible to
+ * the memory interconnect (but not necessarily to other CPUs) before
+ * any stores following this primitive.  All reads preceding this primitive
+ * are guaranteed to access memory (but not necessarily other CPUs' caches)
+ * before any reads following this primitive.
+ *
+ * These ordering constraints are respected by both the local CPU
+ * and the compiler.
+ *
+ * This primitive combines the effects of the read_barrier() and
+ * write_barrier() primitives.
+ *
+ * Ordering is not guaranteed by anything other than these primitives,
+ * not even by data dependencies.  For example, if variable "a" is initially
+ * zero, "b" is initially 1, and pointer "p" initially points to "a", the
+ * following code sequences:
+ *
+ * <programlisting>
+ *	CPU 0				CPU 1
+ *
+ *	b = 2;
+ *	memory_barrier();
+ *	p = &b;				d = *p;
+ * </programlisting>
+ *
+ * could result in variable "d" being set to "1", despite the intuition
+ * that it should always be either "0" or "2", and the fact that the
+ * intuition would be correct on many CPUs.  Alpha is an example CPU
+ * that can exhibit this counter-intuitive behavior, see http://....
+ * for a clear statement of this fact, and http://... for an example
+ * of how this can happen.
+ *
+ * The above code must instead be written as follows:
+ *
+ * <programlisting>
+ *	CPU 0				CPU 1
+ *
+ *	b = 2;
+ *	memory_barrier();
+ *	p = &b;				q = p;
+ *					memory_barrier();
+ *					d = *q;
+ * </programlisting>
+ *
+ * In this example, CPU 0 could execute a write_barrier() and
+ * CPU 1 either a read_barrier() or the lighter-weight
+ * read_barrier_depends().
+ **/
+
+#define memory_barrier() \
+		__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+
+/**
+ * read_barrier - Flush all pending reads
+ *
+ * No reads from memory-like regions are ever reordered over this barrier.
+ * All reads preceding this primitive are guaranteed to access memory
+ * (but not necessarily other CPUs' caches) before any reads following
+ * this primitive.  A corresponding write_barrier() is required in
+ * the update code, or there will be no ordering for read_barrier()
+ * to observe.  Yes, a few CPUs (such as i386) force ordered writes,
+ * but most CPUs will not unless explicitly told to do so with
+ * write_barrier().
+ *
+ * These ordering constraints are respected by both the local CPU
+ * and the compiler.
+ *
+ * This primitive combines the effects of the read_barrier() and
+ * write_barrier() primitives.
+ *
+ * Ordering is not guaranteed by anything other than these primitives,
+ * not even by data dependencies.  See the documentation for
+ * memory_barrier() for examples and URLs to more information.
+ **/
+
+#define read_barrier()	memory_barrier()
+
+/**
+ * read_barrier_depends - Flush all pending reads that subsequents reads
+ * depend on.
+ *
+ * No data-dependent reads from memory-like regions are ever reordered
+ * over this barrier.  All reads preceding this primitive are guaranteed
+ * to access memory (but not necessarily other CPUs' caches) before any
+ * reads following this primitive that depend on the data return by
+ * any of the preceding reads.  This primitive is much lighter weight than
+ * read_barrier() on most CPUs, and is never heavier weight than is
+ * read_barrier().
+ *
+ * These ordering constraints are respected by both the local CPU
+ * and the compiler.
+ *
+ * Ordering is not guaranteed by anything other than these primitives,
+ * not even by data dependencies.  See the documentation for
+ * memory_barrier() for examples and URLs to more information.
+ *
+ * For example, the following code would force ordering (the initial
+ * value of "a" is zero, "b" is one, and "p" is "&a"):
+ *
+ * <programlisting>
+ *	CPU 0				CPU 1
+ *
+ *	b = 2;
+ *	memory_barrier();
+ *	p = &b;				q = p;
+ *					read_barrier_depends();
+ *					d = *q;
+ * </programlisting>
+ *
+ * because the read of "*q" depends on the read of "p" and these
+ * two reads are separated by a read_barrier_depends().  However,
+ * the following code, with the same initial values for "a" and "b":
+ *
+ * <programlisting>
+ *	CPU 0				CPU 1
+ *
+ *	a = 2;
+ *	memory_barrier();
+ *	b = 3;				y = b;
+ *					read_barrier_depends();
+ *					x = a;
+ * </programlisting>
+ *
+ * does not enforce ordering, since there is no data dependency between
+ * the read of "a" and the read of "b".  Therefore, on some CPUs, such
+ * as Alpha, "y" could be set to 3 and "x" to 0.  Use read_barrier()
+ * in cases like thiswhere there are no data dependencies.
+ **/
+
+#define read_barrier_depends()	do { } while(0)
 
 #ifdef CONFIG_X86_OOSTORE
-#define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+
+/**
+ * write_barrier - Flush all pending writes
+ *
+ * No writes from memory-like regions are ever reordered over this barrier.
+ * All writes preceding this primitive are guaranteed to store to memory
+ * (but not necessarily to other CPUs' caches) before any writes following
+ * this primitive.  A corresponding read_barrier() or read_barrier_depends()
+ * is required in the read-side code to force the read-side CPUs to observe
+ * the ordering.
+ *
+ * These ordering constraints are respected by both the local CPU
+ * and the compiler.
+ *
+ * Ordering is not guaranteed by anything other than these primitives,
+ * not even by data dependencies.  See the documentation for
+ * memory_barrier() for examples and URLs for more information.
+ **/
+
+#define write_barrier() \
+		__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #else
-#define wmb()	__asm__ __volatile__ ("": : :"memory")
+#define write_barrier() \
+		__asm__ __volatile__ ("": : :"memory")
 #endif
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 #endif
 
diff -urN linux-2.5.26-base/include/asm-ia64/system.h linux-2.5.26-read_barrier_depends/include/asm-ia64/system.h
--- linux-2.5.26-base/include/asm-ia64/system.h	Wed Jul 17 05:19:32 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-ia64/system.h	Wed Jul 17 16:18:17 2002
@@ -64,33 +64,43 @@
  * architecturally visible effects of a memory access have occurred
  * (at a minimum, this means the memory has been read or written).
  *
- *   wmb():	Guarantees that all preceding stores to memory-
+ *   write_barrier():	Guarantees that all preceding stores to memory-
  *		like regions are visible before any subsequent
  *		stores and that all following stores will be
  *		visible only after all previous stores.
- *   rmb():	Like wmb(), but for reads.
- *   mb():	wmb()/rmb() combo, i.e., all previous memory
+ *   read_barrier():	Like wmb(), but for reads.
+ *   read_barrier_depends():	Like rmb(), but only for pairs
+ *		of loads where the second load depends on the
+ *		value loaded by the first.
+ *   memory_barrier():	wmb()/rmb() combo, i.e., all previous memory
  *		accesses are visible before all subsequent
  *		accesses and vice versa.  This is also known as
  *		a "fence."
  *
- * Note: "mb()" and its variants cannot be used as a fence to order
- * accesses to memory mapped I/O registers.  For that, mf.a needs to
+ * Note: "memory_barrier()" and its variants cannot be used as a fence to
+ * order accesses to memory mapped I/O registers.  For that, mf.a needs to
  * be used.  However, we don't want to always use mf.a because (a)
  * it's (presumably) much slower than mf and (b) mf.a is supported for
  * sequential memory pages only.
  */
-#define mb()	__asm__ __volatile__ ("mf" ::: "memory")
-#define rmb()	mb()
-#define wmb()	mb()
+#define memory_barrier()	__asm__ __volatile__ ("mf" ::: "memory")
+#define read_barrier()		memory_barrier()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		memory_barrier()
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #ifdef CONFIG_SMP
 # define smp_mb()	mb()
 # define smp_rmb()	rmb()
+# define smp_read_barrier_depends()	read_barrier_depends()
 # define smp_wmb()	wmb()
 #else
 # define smp_mb()	barrier()
 # define smp_rmb()	barrier()
+# define smp_read_barrier_depends()	do { } while(0)
 # define smp_wmb()	barrier()
 #endif
 
diff -urN linux-2.5.26-base/include/asm-m68k/system.h linux-2.5.26-read_barrier_depends/include/asm-m68k/system.h
--- linux-2.5.26-base/include/asm-m68k/system.h	Wed Jul 17 05:19:27 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-m68k/system.h	Wed Jul 17 16:18:17 2002
@@ -78,14 +78,20 @@
  * Not really required on m68k...
  */
 #define nop()		do { asm volatile ("nop"); barrier(); } while (0)
-#define mb()		barrier()
-#define rmb()		barrier()
-#define wmb()		barrier()
+#define memory_barrier()	barrier()
+#define read_barrier()		barrier()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		barrier()
 #define set_mb(var, value)    do { xchg(&var, value); } while (0)
 #define set_wmb(var, value)    do { var = value; wmb(); } while (0)
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 
 
diff -urN linux-2.5.26-base/include/asm-mips/system.h linux-2.5.26-read_barrier_depends/include/asm-mips/system.h
--- linux-2.5.26-base/include/asm-mips/system.h	Wed Jul 17 05:19:32 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-mips/system.h	Wed Jul 17 16:18:17 2002
@@ -149,13 +149,14 @@
 #ifdef CONFIG_CPU_HAS_WB
 
 #include <asm/wbflush.h>
-#define rmb()	do { } while(0)
-#define wmb()	wbflush()
-#define mb()	wbflush()
+#define read_barrier()		do { } while(0)
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		wbflush()
+#define memory_barrier()	wbflush()
 
 #else /* CONFIG_CPU_HAS_WB  */
 
-#define mb()						\
+#define memory_barrier()				\
 __asm__ __volatile__(					\
 	"# prevent instructions being moved around\n\t"	\
 	".set\tnoreorder\n\t"				\
@@ -165,18 +166,25 @@
 	: /* no output */				\
 	: /* no input */				\
 	: "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define read_barrier() memory_barrier()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier() memory_barrier()
 
 #endif /* CONFIG_CPU_HAS_WB  */
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 #endif
 
diff -urN linux-2.5.26-base/include/asm-mips64/system.h linux-2.5.26-read_barrier_depends/include/asm-mips64/system.h
--- linux-2.5.26-base/include/asm-mips64/system.h	Wed Jul 17 05:19:32 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-mips64/system.h	Wed Jul 17 16:18:17 2002
@@ -137,7 +137,7 @@
 /*
  * These are probably defined overly paranoid ...
  */
-#define mb()						\
+#define memory_barrier()				\
 __asm__ __volatile__(					\
 	"# prevent instructions being moved around\n\t"	\
 	".set\tnoreorder\n\t"				\
@@ -146,16 +146,23 @@
 	: /* no output */				\
 	: /* no input */				\
 	: "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define read_barrier() memory_barrier()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier() memory_barrier()
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 #endif
 
diff -urN linux-2.5.26-base/include/asm-parisc/system.h linux-2.5.26-read_barrier_depends/include/asm-parisc/system.h
--- linux-2.5.26-base/include/asm-parisc/system.h	Wed Jul 17 05:19:24 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-parisc/system.h	Wed Jul 17 16:18:17 2002
@@ -50,6 +50,7 @@
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	wmb()
 #else
 /* This is simply the barrier() macro from linux/kernel.h but when serial.c
@@ -58,6 +59,7 @@
  */
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
 #endif
 
@@ -120,8 +122,14 @@
 		: "r" (gr), "i" (cr))
 
 
-#define mb()  __asm__ __volatile__ ("sync" : : :"memory")
-#define wmb() mb()
+#define memory_barrier()  __asm__ __volatile__ ("sync" : : :"memory")
+#define read_barrier() memory_barrier()
+#define write_barrier() memory_barrier()
+#define read_barrier_depends()	do { } while(0)
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 extern unsigned long __xchg(unsigned long, unsigned long *, int);
 
diff -urN linux-2.5.26-base/include/asm-ppc/system.h linux-2.5.26-read_barrier_depends/include/asm-ppc/system.h
--- linux-2.5.26-base/include/asm-ppc/system.h	Wed Jul 17 05:19:32 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-ppc/system.h	Wed Jul 17 16:18:17 2002
@@ -22,17 +22,24 @@
  * providing an ordering (separately) for (a) cacheable stores and (b)
  * loads and stores to non-cacheable memory (e.g. I/O devices).
  *
- * mb() prevents loads and stores being reordered across this point.
- * rmb() prevents loads being reordered across this point.
- * wmb() prevents stores being reordered across this point.
+ * memory_barrier() prevents loads and stores being reordered across this point.
+ * read_barrier() prevents loads being reordered across this point.
+ * read_barrier_depends() prevents data-dependant loads being reordered
+ *	across this point (nop on PPC).
+ * write_barrier() prevents stores being reordered across this point.
  *
  * We can use the eieio instruction for wmb, but since it doesn't
  * give any ordering guarantees about loads, we have to use the
  * stronger but slower sync instruction for mb and rmb.
  */
-#define mb()  __asm__ __volatile__ ("sync" : : : "memory")
-#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
-#define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
+#define memory_barrier()  __asm__ __volatile__ ("sync" : : : "memory")
+#define read_barrier()  __asm__ __volatile__ ("sync" : : : "memory")
+#define read_barrier_depends()  do { } while(0)
+#define write_barrier()  __asm__ __volatile__ ("eieio" : : : "memory")
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
 #define set_wmb(var, value)	do { var = value; wmb(); } while (0)
@@ -40,10 +47,12 @@
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	__asm__ __volatile__("": : :"memory")
 #define smp_rmb()	__asm__ __volatile__("": : :"memory")
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("": : :"memory")
 #endif /* CONFIG_SMP */
 
diff -urN linux-2.5.26-base/include/asm-s390/system.h linux-2.5.26-read_barrier_depends/include/asm-s390/system.h
--- linux-2.5.26-base/include/asm-s390/system.h	Wed Jul 17 05:19:38 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-s390/system.h	Wed Jul 17 16:18:17 2002
@@ -118,15 +118,21 @@
 
 #define eieio()  __asm__ __volatile__ ("BCR 15,0") 
 # define SYNC_OTHER_CORES(x)   eieio() 
-#define mb()    eieio()
-#define rmb()   eieio()
-#define wmb()   eieio()
+#define memory_barrier()    eieio()
+#define read_barrier()   eieio()
+#define read_barrier_depends() do { } while(0)
+#define write_barrier()   eieio()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
+#define smp_read_barrier_depends()    read_barrier_depends()
 #define smp_wmb()      wmb()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 
 #define set_mb(var, value)      do { var = value; mb(); } while (0)
 #define set_wmb(var, value)     do { var = value; wmb(); } while (0)
diff -urN linux-2.5.26-base/include/asm-s390x/system.h linux-2.5.26-read_barrier_depends/include/asm-s390x/system.h
--- linux-2.5.26-base/include/asm-s390x/system.h	Wed Jul 17 05:19:38 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-s390x/system.h	Wed Jul 17 16:18:17 2002
@@ -131,11 +131,13 @@
 
 #define eieio()  __asm__ __volatile__ ("BCR 15,0") 
 # define SYNC_OTHER_CORES(x)   eieio() 
-#define mb()    eieio()
-#define rmb()   eieio()
-#define wmb()   eieio()
+#define memory_barrier()    eieio()
+#define read_barrier()   eieio()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()   eieio()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
+#define smp_read_barrier_depends()    read_barrier_depends()
 #define smp_wmb()      wmb()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
@@ -143,6 +145,10 @@
 #define set_mb(var, value)      do { var = value; mb(); } while (0)
 #define set_wmb(var, value)     do { var = value; wmb(); } while (0)
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 /* interrupt control.. */
 #define __sti() ({ \
         unsigned long __dummy; \
diff -urN linux-2.5.26-base/include/asm-sh/system.h linux-2.5.26-read_barrier_depends/include/asm-sh/system.h
--- linux-2.5.26-base/include/asm-sh/system.h	Wed Jul 17 05:19:37 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-sh/system.h	Wed Jul 17 16:18:17 2002
@@ -86,17 +86,24 @@
 
 extern void __xchg_called_with_bad_pointer(void);
 
-#define mb()	__asm__ __volatile__ ("": : :"memory")
-#define rmb()	mb()
-#define wmb()	__asm__ __volatile__ ("": : :"memory")
+#define memory_barrier()	__asm__ __volatile__ ("": : :"memory")
+#define read_barrier()		memory_barrier()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		__asm__ __volatile__ ("": : :"memory")
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 #endif
 
diff -urN linux-2.5.26-base/include/asm-sparc/system.h linux-2.5.26-read_barrier_depends/include/asm-sparc/system.h
--- linux-2.5.26-base/include/asm-sparc/system.h	Wed Jul 17 05:19:36 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-sparc/system.h	Wed Jul 17 16:18:17 2002
@@ -275,15 +275,21 @@
 #endif
 
 /* XXX Change this if we ever use a PSO mode kernel. */
-#define mb()	__asm__ __volatile__ ("" : : : "memory")
-#define rmb()	mb()
-#define wmb()	mb()
+#define memory_barrier()	__asm__ __volatile__ ("" : : : "memory")
+#define read_barrier()		memory_barrier()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		memory_barrier()
 #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
 #define set_wmb(__var, __value) set_mb(__var, __value)
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #define nop() __asm__ __volatile__ ("nop");
 
 /* This has special calling conventions */
diff -urN linux-2.5.26-base/include/asm-sparc64/system.h linux-2.5.26-read_barrier_depends/include/asm-sparc64/system.h
--- linux-2.5.26-base/include/asm-sparc64/system.h	Wed Jul 17 05:19:22 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-sparc64/system.h	Wed Jul 17 16:18:17 2002
@@ -96,22 +96,29 @@
 #define nop() 		__asm__ __volatile__ ("nop")
 
 #define membar(type)	__asm__ __volatile__ ("membar " type : : : "memory");
-#define mb()		\
+#define memory_barrier()		\
 	membar("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad");
-#define rmb()		membar("#LoadLoad")
-#define wmb()		membar("#StoreStore")
+#define read_barrier()			membar("#LoadLoad")
+#define read_barrier_depends()		do { } while(0)
+#define write_barrier()			membar("#StoreStore")
 #define set_mb(__var, __value) \
 	do { __var = __value; membar("#StoreLoad | #StoreStore"); } while(0)
 #define set_wmb(__var, __value) \
 	do { __var = __value; membar("#StoreStore"); } while(0)
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
 #endif
 
diff -urN linux-2.5.26-base/include/asm-x86_64/system.h linux-2.5.26-read_barrier_depends/include/asm-x86_64/system.h
--- linux-2.5.26-base/include/asm-x86_64/system.h	Wed Jul 17 05:19:29 2002
+++ linux-2.5.26-read_barrier_depends/include/asm-x86_64/system.h	Wed Jul 17 16:18:17 2002
@@ -218,10 +218,12 @@
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	do {} while(0)
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do {} while(0)
 #define smp_wmb()	barrier()
 #endif
 
@@ -231,9 +233,15 @@
  * And yes, this is required on UP too when we're talking
  * to devices.
  */
-#define mb() 	asm volatile("mfence":::"memory")
-#define rmb()	asm volatile("lfence":::"memory")
-#define wmb()	asm volatile("sfence":::"memory")
+#define memory_barrier()	asm volatile("mfence":::"memory")
+#define read_barrier()		asm volatile("lfence":::"memory")
+#define read_barrier_depends()	do {} while(0)
+#define write_barrier()		asm volatile("sfence":::"memory")
+
+#define mb() 	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
diff -urN linux-2.5.26-base/include/linux/list.h linux-2.5.26-read_barrier_depends/include/linux/list.h
--- linux-2.5.26-base/include/linux/list.h	Wed Jul 17 05:19:23 2002
+++ linux-2.5.26-read_barrier_depends/include/linux/list.h	Wed Jul 17 16:18:17 2002
@@ -4,6 +4,7 @@
 #if defined(__KERNEL__) || defined(_LVM_H_INCLUDE)
 
 #include <linux/prefetch.h>
+#include <asm/system.h>
 
 /*
  * Simple doubly linked list implementation.
@@ -30,6 +31,10 @@
 	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
 } while (0)
 
+#define INIT_LIST_HEAD_RCU(ptr) do { \
+	(ptr)->next = (ptr); (ptr)->prev = (ptr); read_barrier_depends(); \
+} while (0)
+
 /*
  * Insert a new entry between two known consecutive entries. 
  *
@@ -71,6 +76,49 @@
 }
 
 /*
+ * Insert a new entry between two known consecutive entries. 
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static __inline__ void __list_add_rcu(struct list_head * new,
+	struct list_head * prev,
+	struct list_head * next)
+{
+	new->next = next;
+	new->prev = prev;
+	wmb();
+	next->prev = new;
+	prev->next = new;
+}
+
+/**
+ * list_add_rcu - add a new entry to rcu-protected list
+ * @new: new entry to be added
+ * @head: list head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
+static __inline__ void list_add_rcu(struct list_head *new, struct list_head *head)
+{
+	__list_add_rcu(new, head, head->next);
+}
+
+/**
+ * list_add_tail_rcu - add a new entry to rcu-protected list
+ * @new: new entry to be added
+ * @head: list head to add it before
+ *
+ * Insert a new entry before the specified head.
+ * This is useful for implementing queues.
+ */
+static __inline__ void list_add_tail_rcu(struct list_head *new, struct list_head *head)
+{
+	__list_add_rcu(new, head->prev, head);
+}
+
+/*
  * Delete a list entry by making the prev/next entries
  * point to each other.
  *
@@ -96,13 +144,25 @@
 }
 
 /**
+ * list_del_rcu - deletes entry from list without re-initialization
+ * @entry: the element to delete from the list.
+ * Note: list_empty on entry does not return true after this, 
+ * the entry is in an undefined state. It is useful for RCU based
+ * lockfree traversal.
+ */
+static inline void list_del_rcu(list_t *entry)
+{
+	__list_del(entry->prev, entry->next);
+}
+
+/**
  * list_del_init - deletes entry from list and reinitialize it.
  * @entry: the element to delete from the list.
  */
 static inline void list_del_init(list_t *entry)
 {
 	__list_del(entry->prev, entry->next);
-	INIT_LIST_HEAD(entry); 
+	INIT_LIST_HEAD(entry);
 }
 
 /**
@@ -213,6 +273,26 @@
 	for (pos = (head)->next, n = pos->next; pos != (head); \
 		pos = n, n = pos->next)
 
+/**
+ * list_for_each_rcu	-	iterate over an rcu-protected list
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @head:	the head for your list.
+ */
+#define list_for_each_rcu(pos, head) \
+	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
+        	pos = pos->next, ({ read_barrier_depends(); 0}), prefetch(pos->next))
+        	
+/**
+ * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
+ *					against removal of list entry
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @n:		another &struct list_head to use as temporary storage
+ * @head:	the head for your list.
+ */
+#define list_for_each_safe_rcu(pos, n, head) \
+	for (pos = (head)->next, n = pos->next; pos != (head); \
+		pos = n, ({ read_barrier_depends(); 0}), n = pos->next)
+
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
 #endif
