Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292707AbSCWJSX>; Sat, 23 Mar 2002 04:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292708AbSCWJSI>; Sat, 23 Mar 2002 04:18:08 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:49028 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S292707AbSCWJRr>; Sat, 23 Mar 2002 04:17:47 -0500
Date: Sat, 23 Mar 2002 13:55:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] memory barriers
Message-ID: <20020323135555.A21063@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime ago, during a discussion on lock-free lookups, it was
agreed that an additional memory barrier interface,
read_barrier_depends() that is lighter than an rmb(),
is necessary to make sure that data-dependent reads are not
re-ordered over this barrier. For many processors, data-dependency 
enforces order, so this interface is a NOP, but for alpha it is an rmb().
The discussion can be found at -

http://marc.theaimsgroup.com/?t=100259422200002&r=1&w=2

Sprinkling some witty remarks about IBM's warped sense of mnemonics,
Linus suggested that the all barrier inteface names might as well
be made more explicit.

http://marc.theaimsgroup.com/?l=linux-kernel&m=100290433130211&w=2
 
Paul McKenney wrote a patch that has all these -

memory_barrier()
read_barrier()
read_barrier_depends()
write_barrier()

Existing barrier interfaces of course continue to be supported.

I am including a 2.5.7 port of Paul's patch and I will be maintaining
it. If there are no major issues with it, I would like to submit
it to Linus. The patch has been verified UP/SMP in i386.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

barriers-2.5.7-1.patch
----------------------

diff -urN linux-2.5.7-base/Documentation/DocBook/kernel-api.tmpl linux-2.5.7-barriers/Documentation/DocBook/kernel-api.tmpl
--- linux-2.5.7-base/Documentation/DocBook/kernel-api.tmpl	Tue Mar 19 02:07:02 2002
+++ linux-2.5.7-barriers/Documentation/DocBook/kernel-api.tmpl	Fri Mar 22 22:09:33 2002
@@ -41,9 +41,10 @@
 !Iinclude/linux/init.h
      </sect1>
 
-     <sect1><title>Atomic and pointer manipulation</title>
+     <sect1><title>Safe memory access and pointer manipulation</title>
 !Iinclude/asm-i386/atomic.h
 !Iinclude/asm-i386/unaligned.h
+!Iinclude/asm-i386/system.h
      </sect1>
 
      <sect1><title>Delaying, scheduling, and timer routines</title>
diff -urN linux-2.5.7-base/include/asm-alpha/system.h linux-2.5.7-barriers/include/asm-alpha/system.h
--- linux-2.5.7-base/include/asm-alpha/system.h	Tue Mar 19 02:07:03 2002
+++ linux-2.5.7-barriers/include/asm-alpha/system.h	Fri Mar 22 22:09:33 2002
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
 
diff -urN linux-2.5.7-base/include/asm-arm/system.h linux-2.5.7-barriers/include/asm-arm/system.h
--- linux-2.5.7-base/include/asm-arm/system.h	Tue Mar 19 02:07:06 2002
+++ linux-2.5.7-barriers/include/asm-arm/system.h	Fri Mar 22 22:09:33 2002
@@ -38,11 +38,16 @@
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
@@ -70,12 +75,14 @@
 
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
diff -urN linux-2.5.7-base/include/asm-cris/system.h linux-2.5.7-barriers/include/asm-cris/system.h
--- linux-2.5.7-base/include/asm-cris/system.h	Tue Mar 19 02:07:03 2002
+++ linux-2.5.7-barriers/include/asm-cris/system.h	Fri Mar 22 22:09:33 2002
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
 
diff -urN linux-2.5.7-base/include/asm-i386/system.h linux-2.5.7-barriers/include/asm-i386/system.h
--- linux-2.5.7-base/include/asm-i386/system.h	Tue Mar 19 02:07:02 2002
+++ linux-2.5.7-barriers/include/asm-i386/system.h	Fri Mar 22 22:09:33 2002
@@ -285,23 +285,182 @@
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
 
diff -urN linux-2.5.7-base/include/asm-ia64/system.h linux-2.5.7-barriers/include/asm-ia64/system.h
--- linux-2.5.7-base/include/asm-ia64/system.h	Tue Mar 19 02:07:13 2002
+++ linux-2.5.7-barriers/include/asm-ia64/system.h	Fri Mar 22 22:09:33 2002
@@ -71,33 +71,43 @@
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
 
diff -urN linux-2.5.7-base/include/asm-m68k/system.h linux-2.5.7-barriers/include/asm-m68k/system.h
--- linux-2.5.7-base/include/asm-m68k/system.h	Tue Mar 19 02:07:07 2002
+++ linux-2.5.7-barriers/include/asm-m68k/system.h	Fri Mar 22 22:09:33 2002
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
 
 
diff -urN linux-2.5.7-base/include/asm-mips/system.h linux-2.5.7-barriers/include/asm-mips/system.h
--- linux-2.5.7-base/include/asm-mips/system.h	Tue Mar 19 02:07:13 2002
+++ linux-2.5.7-barriers/include/asm-mips/system.h	Fri Mar 22 22:09:33 2002
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
 
diff -urN linux-2.5.7-base/include/asm-mips64/system.h linux-2.5.7-barriers/include/asm-mips64/system.h
--- linux-2.5.7-base/include/asm-mips64/system.h	Tue Mar 19 02:07:13 2002
+++ linux-2.5.7-barriers/include/asm-mips64/system.h	Fri Mar 22 22:09:33 2002
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
 
diff -urN linux-2.5.7-base/include/asm-parisc/system.h linux-2.5.7-barriers/include/asm-parisc/system.h
--- linux-2.5.7-base/include/asm-parisc/system.h	Tue Mar 19 02:07:03 2002
+++ linux-2.5.7-barriers/include/asm-parisc/system.h	Fri Mar 22 22:09:33 2002
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
 
diff -urN linux-2.5.7-base/include/asm-ppc/system.h linux-2.5.7-barriers/include/asm-ppc/system.h
--- linux-2.5.7-base/include/asm-ppc/system.h	Tue Mar 19 02:07:13 2002
+++ linux-2.5.7-barriers/include/asm-ppc/system.h	Fri Mar 22 22:09:33 2002
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
 
diff -urN linux-2.5.7-base/include/asm-s390/system.h linux-2.5.7-barriers/include/asm-s390/system.h
--- linux-2.5.7-base/include/asm-s390/system.h	Tue Mar 19 02:07:14 2002
+++ linux-2.5.7-barriers/include/asm-s390/system.h	Fri Mar 22 22:09:33 2002
@@ -115,15 +115,21 @@
 
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
diff -urN linux-2.5.7-base/include/asm-s390x/system.h linux-2.5.7-barriers/include/asm-s390x/system.h
--- linux-2.5.7-base/include/asm-s390x/system.h	Tue Mar 19 02:07:18 2002
+++ linux-2.5.7-barriers/include/asm-s390x/system.h	Fri Mar 22 22:09:33 2002
@@ -128,11 +128,13 @@
 
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
@@ -140,6 +142,10 @@
 #define set_mb(var, value)      do { var = value; mb(); } while (0)
 #define set_wmb(var, value)     do { var = value; wmb(); } while (0)
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 /* interrupt control.. */
 #define __sti() ({ \
         unsigned long dummy; \
diff -urN linux-2.5.7-base/include/asm-sh/system.h linux-2.5.7-barriers/include/asm-sh/system.h
--- linux-2.5.7-base/include/asm-sh/system.h	Tue Mar 19 02:07:18 2002
+++ linux-2.5.7-barriers/include/asm-sh/system.h	Fri Mar 22 22:09:33 2002
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
 
diff -urN linux-2.5.7-base/include/asm-sparc/system.h linux-2.5.7-barriers/include/asm-sparc/system.h
--- linux-2.5.7-base/include/asm-sparc/system.h	Tue Mar 19 02:07:17 2002
+++ linux-2.5.7-barriers/include/asm-sparc/system.h	Fri Mar 22 22:09:33 2002
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
diff -urN linux-2.5.7-base/include/asm-sparc64/system.h linux-2.5.7-barriers/include/asm-sparc64/system.h
--- linux-2.5.7-base/include/asm-sparc64/system.h	Tue Mar 19 02:07:02 2002
+++ linux-2.5.7-barriers/include/asm-sparc64/system.h	Fri Mar 22 22:09:33 2002
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
 
