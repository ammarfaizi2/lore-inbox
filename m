Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSJPSmR>; Wed, 16 Oct 2002 14:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbSJPSmR>; Wed, 16 Oct 2002 14:42:17 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:23979 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261246AbSJPSmJ>;
	Wed, 16 Oct 2002 14:42:09 -0400
Date: Thu, 17 Oct 2002 00:23:54 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] RCU helper patchset 1/2
Message-ID: <20021017002354.A2380@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I am breaking up the read_barrier_depends RCU helper patch in
akpm's tree and sending you two small patches out of it
(and deferring vowelized barriers for the time being :)).
This is the first broken out piece from read_barrier_depends.

This first RCU helper patch adds a read_barrier_depends() primitive
to all archs which is NOP for archs that doesn't require an rmb()
for data dependent reads when writes are ordered using a wmb().
In reality, only alpha requires an rmb(), the rest are NOPs.
It is likely to be necessary in most situations that would use RCU.
Please apply.

Description :
-------------
Sometime ago, during a discussion on lock-free lookups, it was
agreed that an additional memory barrier interface,
read_barrier_depends() that is lighter than an rmb(),
is necessary to make sure that data-dependent reads are not
re-ordered over this barrier. For many processors, data-dependency
enforces order, so this interface is a NOP, but for those that don't
(like alpha), it can be a rmb().

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
as Alpha, "y" could be set to 3 and "x" to 0.  rmb()
needs to be used here, not read_barrier_depends().

The original discussion can be found at -
http://marc.theaimsgroup.com/?t=100259422200002&r=1&w=2

Explanation of the need for read_barrier_depends()
can be found at http://lse.sf.net/locking/wmbdd.html

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


 asm-alpha/system.h  |    5 ++++
 asm-arm/system.h    |    3 ++
 asm-cris/system.h   |    3 ++
 asm-i386/system.h   |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 asm-ia64/system.h   |    3 ++
 asm-mips/system.h   |    4 +++
 asm-mips64/system.h |    3 ++
 asm-parisc/system.h |    3 ++
 asm-ppc/system.h    |    5 ++++
 asm-ppc64/system.h  |    5 ++++
 asm-s390/system.h   |    2 +
 asm-s390x/system.h  |    2 +
 asm-sh/system.h     |    3 ++
 asm-sparc/system.h  |    2 +
 asm-x86_64/system.h |    3 ++
 15 files changed, 102 insertions(+)

diff -urN linux-2.5.43-base/include/asm-alpha/system.h linux-2.5.43-rbd/include/asm-alpha/system.h
--- linux-2.5.43-base/include/asm-alpha/system.h	Sat Sep 28 03:20:20 2002
+++ linux-2.5.43-rbd/include/asm-alpha/system.h	Wed Oct 16 21:40:02 2002
@@ -151,14 +151,19 @@
 #define wmb() \
 __asm__ __volatile__("wmb": : :"memory")
 
+#define read_barrier_depends() \
+__asm__ __volatile__("mb": : :"memory")
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_read_barrier_depends()	barrier()
 #endif
 
 #define set_mb(var, value) \
diff -urN linux-2.5.43-base/include/asm-arm/system.h linux-2.5.43-rbd/include/asm-arm/system.h
--- linux-2.5.43-base/include/asm-arm/system.h	Sat Oct 12 23:44:15 2002
+++ linux-2.5.43-rbd/include/asm-arm/system.h	Wed Oct 16 21:58:55 2002
@@ -52,6 +52,7 @@
 #define mb() __asm__ __volatile__ ("" : : : "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define read_barrier_depends() do { } while(0)
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
 #define prepare_to_switch()    do { } while(0)
@@ -76,12 +77,14 @@
 #define smp_mb()		mb()
 #define smp_rmb()		rmb()
 #define smp_wmb()		wmb()
+#define smp_read_barrier_depends()		read_barrier_depends()
 
 #else
 
 #define smp_mb()		barrier()
 #define smp_rmb()		barrier()
 #define smp_wmb()		barrier()
+#define smp_read_barrier_depends()		do { } while(0)
 
 #define clf()			__clf()
 #define stf()			__stf()
diff -urN linux-2.5.43-base/include/asm-cris/system.h linux-2.5.43-rbd/include/asm-cris/system.h
--- linux-2.5.43-base/include/asm-cris/system.h	Sat Sep 28 03:20:18 2002
+++ linux-2.5.43-rbd/include/asm-cris/system.h	Wed Oct 16 22:05:46 2002
@@ -150,15 +150,18 @@
 #define mb() __asm__ __volatile__ ("" : : : "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define read_barrier_depends() do { } while(0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()        mb()
 #define smp_rmb()       rmb()
 #define smp_wmb()       wmb()
+#define smp_read_barrier_depends()     read_barrier_depends()
 #else
 #define smp_mb()        barrier()
 #define smp_rmb()       barrier()
 #define smp_wmb()       barrier()
+#define smp_read_barrier_depends()     do { } while(0)
 #endif
 
 #define iret()
diff -urN linux-2.5.43-base/include/asm-i386/system.h linux-2.5.43-rbd/include/asm-i386/system.h
--- linux-2.5.43-base/include/asm-i386/system.h	Sat Sep 28 03:18:35 2002
+++ linux-2.5.43-rbd/include/asm-i386/system.h	Wed Oct 16 22:18:06 2002
@@ -286,6 +286,60 @@
 #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #define rmb()	mb()
 
+/**
+ * read_barrier_depends - Flush all pending reads that subsequents reads
+ * depend on.
+ *
+ * No data-dependent reads from memory-like regions are ever reordered
+ * over this barrier.  All reads preceding this primitive are guaranteed
+ * to access memory (but not necessarily other CPUs' caches) before any
+ * reads following this primitive that depend on the data return by
+ * any of the preceding reads.  This primitive is much lighter weight than
+ * rmb() on most CPUs, and is never heavier weight than is
+ * rmb().
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
+ * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
+ * in cases like thiswhere there are no data dependencies.
+ **/
+
+#define read_barrier_depends()	do { } while(0)
+
 #ifdef CONFIG_X86_OOSTORE
 #define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #else
@@ -296,10 +350,12 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #endif
 
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
diff -urN linux-2.5.43-base/include/asm-ia64/system.h linux-2.5.43-rbd/include/asm-ia64/system.h
--- linux-2.5.43-base/include/asm-ia64/system.h	Sat Sep 28 03:19:49 2002
+++ linux-2.5.43-rbd/include/asm-ia64/system.h	Wed Oct 16 22:19:14 2002
@@ -85,15 +85,18 @@
 #define mb()	__asm__ __volatile__ ("mf" ::: "memory")
 #define rmb()	mb()
 #define wmb()	mb()
+#define read_barrier_depends()	do { } while(0)
 
 #ifdef CONFIG_SMP
 # define smp_mb()	mb()
 # define smp_rmb()	rmb()
 # define smp_wmb()	wmb()
+# define smp_read_barrier_depends()	read_barrier_depends()
 #else
 # define smp_mb()	barrier()
 # define smp_rmb()	barrier()
 # define smp_wmb()	barrier()
+# define smp_read_barrier_depends()	do { } while(0)
 #endif
 
 /*
diff -urN linux-2.5.43-base/include/asm-mips/system.h linux-2.5.43-rbd/include/asm-mips/system.h
--- linux-2.5.43-base/include/asm-mips/system.h	Sat Sep 28 03:19:49 2002
+++ linux-2.5.43-rbd/include/asm-mips/system.h	Wed Oct 16 22:24:15 2002
@@ -146,6 +146,7 @@
 #define rmb()	do { } while(0)
 #define wmb()	wbflush()
 #define mb()	wbflush()
+#define read_barrier_depends()	do { } while(0)
 
 #else /* CONFIG_CPU_HAS_WB  */
 
@@ -161,6 +162,7 @@
 	: "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define read_barrier_depends()	do { } while(0)
 
 #endif /* CONFIG_CPU_HAS_WB  */
 
@@ -168,10 +170,12 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #endif
 
 #define set_mb(var, value) \
diff -urN linux-2.5.43-base/include/asm-mips64/system.h linux-2.5.43-rbd/include/asm-mips64/system.h
--- linux-2.5.43-base/include/asm-mips64/system.h	Sat Sep 28 03:19:49 2002
+++ linux-2.5.43-rbd/include/asm-mips64/system.h	Wed Oct 16 22:21:41 2002
@@ -142,15 +142,18 @@
 	: "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define read_barrier_depends()	do { } while(0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #endif
 
 #define set_mb(var, value) \
diff -urN linux-2.5.43-base/include/asm-parisc/system.h linux-2.5.43-rbd/include/asm-parisc/system.h
--- linux-2.5.43-base/include/asm-parisc/system.h	Sat Sep 28 03:19:02 2002
+++ linux-2.5.43-rbd/include/asm-parisc/system.h	Wed Oct 16 22:26:25 2002
@@ -51,6 +51,7 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	do { } while(0)
 #else
 /* This is simply the barrier() macro from linux/kernel.h but when serial.c
  * uses tqueue.h uses smp_mb() defined using barrier(), linux/kernel.h
@@ -59,6 +60,7 @@
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #endif
 
 /* interrupt control */
@@ -120,6 +122,7 @@
 
 #define mb()  __asm__ __volatile__ ("sync" : : :"memory")
 #define wmb() mb()
+#define read_barrier_depends()	do { } while(0)
 
 extern unsigned long __xchg(unsigned long, unsigned long *, int);
 
diff -urN linux-2.5.43-base/include/asm-ppc/system.h linux-2.5.43-rbd/include/asm-ppc/system.h
--- linux-2.5.43-base/include/asm-ppc/system.h	Sat Sep 28 03:19:49 2002
+++ linux-2.5.43-rbd/include/asm-ppc/system.h	Wed Oct 16 22:27:45 2002
@@ -22,6 +22,8 @@
  * mb() prevents loads and stores being reordered across this point.
  * rmb() prevents loads being reordered across this point.
  * wmb() prevents stores being reordered across this point.
+ * read_barrier_depends() prevents data-dependant loads being reordered
+ *	across this point (nop on PPC).
  *
  * We can use the eieio instruction for wmb, but since it doesn't
  * give any ordering guarantees about loads, we have to use the
@@ -30,6 +32,7 @@
 #define mb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
+#define read_barrier_depends()  do { } while(0)
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
 #define set_wmb(var, value)	do { var = value; wmb(); } while (0)
@@ -38,10 +41,12 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #else
 #define smp_mb()	__asm__ __volatile__("": : :"memory")
 #define smp_rmb()	__asm__ __volatile__("": : :"memory")
 #define smp_wmb()	__asm__ __volatile__("": : :"memory")
+#define smp_read_barrier_depends()	do { } while(0)
 #endif /* CONFIG_SMP */
 
 #ifdef __KERNEL__
diff -urN linux-2.5.43-base/include/asm-ppc64/system.h linux-2.5.43-rbd/include/asm-ppc64/system.h
--- linux-2.5.43-base/include/asm-ppc64/system.h	Sat Sep 28 03:19:53 2002
+++ linux-2.5.43-rbd/include/asm-ppc64/system.h	Wed Oct 16 22:35:53 2002
@@ -25,6 +25,8 @@
  * mb() prevents loads and stores being reordered across this point.
  * rmb() prevents loads being reordered across this point.
  * wmb() prevents stores being reordered across this point.
+ * read_barrier_depends() prevents data-dependant loads being reordered
+ *	across this point (nop on PPC).
  *
  * We can use the eieio instruction for wmb, but since it doesn't
  * give any ordering guarantees about loads, we have to use the
@@ -33,6 +35,7 @@
 #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
 #define rmb()  __asm__ __volatile__ ("lwsync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
+#define read_barrier_depends()  do { } while(0)
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
 #define set_wmb(var, value)	do { var = value; wmb(); } while (0)
@@ -41,10 +44,12 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()  read_barrier_depends()
 #else
 #define smp_mb()	__asm__ __volatile__("": : :"memory")
 #define smp_rmb()	__asm__ __volatile__("": : :"memory")
 #define smp_wmb()	__asm__ __volatile__("": : :"memory")
+#define smp_read_barrier_depends()  do { } while(0)
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_KERNEL
diff -urN linux-2.5.43-base/include/asm-s390/system.h linux-2.5.43-rbd/include/asm-s390/system.h
--- linux-2.5.43-base/include/asm-s390/system.h	Sat Oct 12 23:44:44 2002
+++ linux-2.5.43-rbd/include/asm-s390/system.h	Wed Oct 16 22:28:47 2002
@@ -227,9 +227,11 @@
 #define mb()    eieio()
 #define rmb()   eieio()
 #define wmb()   eieio()
+#define read_barrier_depends() do { } while(0)
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
 #define smp_wmb()      wmb()
+#define smp_read_barrier_depends()    read_barrier_depends()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
 
diff -urN linux-2.5.43-base/include/asm-s390x/system.h linux-2.5.43-rbd/include/asm-s390x/system.h
--- linux-2.5.43-base/include/asm-s390x/system.h	Sat Oct 12 23:44:44 2002
+++ linux-2.5.43-rbd/include/asm-s390x/system.h	Wed Oct 16 22:29:42 2002
@@ -238,9 +238,11 @@
 #define mb()    eieio()
 #define rmb()   eieio()
 #define wmb()   eieio()
+#define read_barrier_depends()	do { } while(0)
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
 #define smp_wmb()      wmb()
+#define smp_read_barrier_depends()    read_barrier_depends()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
 
diff -urN linux-2.5.43-base/include/asm-sh/system.h linux-2.5.43-rbd/include/asm-sh/system.h
--- linux-2.5.43-base/include/asm-sh/system.h	Sat Sep 28 03:20:32 2002
+++ linux-2.5.43-rbd/include/asm-sh/system.h	Wed Oct 16 22:31:38 2002
@@ -89,15 +89,18 @@
 #define mb()	__asm__ __volatile__ ("": : :"memory")
 #define rmb()	mb()
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
+#define read_barrier_depends()	do { } while(0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #endif
 
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
diff -urN linux-2.5.43-base/include/asm-sparc/system.h linux-2.5.43-rbd/include/asm-sparc/system.h
--- linux-2.5.43-base/include/asm-sparc/system.h	Sat Sep 28 03:20:25 2002
+++ linux-2.5.43-rbd/include/asm-sparc/system.h	Wed Oct 16 22:32:37 2002
@@ -310,11 +310,13 @@
 #define mb()	__asm__ __volatile__ ("" : : : "memory")
 #define rmb()	mb()
 #define wmb()	mb()
+#define read_barrier_depends()	do { } while(0)
 #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
 #define set_wmb(__var, __value) set_mb(__var, __value)
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 
 #define nop() __asm__ __volatile__ ("nop");
 
diff -urN linux-2.5.43-base/include/asm-x86_64/system.h linux-2.5.43-rbd/include/asm-x86_64/system.h
--- linux-2.5.43-base/include/asm-x86_64/system.h	Wed Oct 16 19:19:19 2002
+++ linux-2.5.43-rbd/include/asm-x86_64/system.h	Wed Oct 16 22:34:02 2002
@@ -215,10 +215,12 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	do {} while(0)
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_read_barrier_depends()	do {} while(0)
 #endif
 
     
@@ -230,6 +232,7 @@
 #define mb() 	asm volatile("mfence":::"memory")
 #define rmb()	asm volatile("lfence":::"memory")
 #define wmb()	asm volatile("sfence":::"memory")
+#define read_barrier_depends()	do {} while(0)
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 

