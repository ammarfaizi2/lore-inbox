Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281304AbRKHCXw>; Wed, 7 Nov 2001 21:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281298AbRKHCXo>; Wed, 7 Nov 2001 21:23:44 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:27362 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281293AbRKHCXc>; Wed, 7 Nov 2001 21:23:32 -0500
From: "Paul E. McKenney" <pmckenne@us.ibm.com>
Message-Id: <200111080222.fA82MCt14535@eng4.beaverton.ibm.com>
Subject: Re: [PATCH] read_barrier.v2.4.14.patch.2001.11.06
To: linux-kernel@vger.kernel.org
Date: Wed, 7 Nov 2001 18:22:11 -0800 (PST)
In-Reply-To: <200111070216.fA72GY602242@eng4.beaverton.ibm.com> from "Paul E. McKenney" at Nov 06, 2001 05:16:32 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to several of you who noted that I used "-x" rather than "-X"...

The updated patch below avoids dropping extraneous files into your source
tree.

							Thanx, Paul

>Hello!
>
>Interpreting silence as assent...  ;-)
>
>Here is a patch containing read_barrier_depends(), memory_barrier(),
>read_barrier(), and write_barrier(), as discussed on lkml a while back.
>(See http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.1/1430.html)
>
>This patch defines read_barrier_depends() as in the previous patch.
>In the name of backwards compatibility, it defines mb(), rmb(), and wmb()
>in terms of the new memory_barrier(), read_barrier(), and write_barrier()
>in each architecture.  If this approach is acceptable, I will follow up
>with patches to change the existing uses of smp_mb(), smp_rmb(), smp_wmb(),
>mb(), rmb(), and wmb() to instead use the new names.  Finally, I will
>produce patches to remove the definitions of the old names.
>
>Thoughts?


diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-alpha/system.h linux-2.4.14.read_barrier/include/asm-alpha/system.h
--- linux-2.4.14/include/asm-alpha/system.h	Thu Oct  4 18:47:08 2001
+++ linux-2.4.14.read_barrier/include/asm-alpha/system.h	Tue Nov  6 16:46:52 2001
@@ -142,22 +142,31 @@
 
 extern struct task_struct* alpha_switch_to(unsigned long, struct task_struct*);
 
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-arm/system.h linux-2.4.14.read_barrier/include/asm-arm/system.h
--- linux-2.4.14/include/asm-arm/system.h	Mon Nov 27 17:07:59 2000
+++ linux-2.4.14.read_barrier/include/asm-arm/system.h	Tue Nov  6 16:48:09 2001
@@ -36,11 +36,16 @@
  */
 #include <asm/proc/system.h>
 
-#define mb() __asm__ __volatile__ ("" : : : "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define memory_barrier() __asm__ __volatile__ ("" : : : "memory")
+#define read_barrier() mb()
+#define read_barrier_depends() do { } while(0)
+#define write_barrier() mb()
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #define prepare_to_switch()    do { } while(0)
 
 /*
@@ -67,12 +72,14 @@
 
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
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-cris/system.h linux-2.4.14.read_barrier/include/asm-cris/system.h
--- linux-2.4.14/include/asm-cris/system.h	Mon Oct  8 11:43:54 2001
+++ linux-2.4.14.read_barrier/include/asm-cris/system.h	Tue Nov  6 16:48:38 2001
@@ -147,17 +147,24 @@
 #endif
 }
 
-#define mb() __asm__ __volatile__ ("" : : : "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define memory_barrier() __asm__ __volatile__ ("" : : : "memory")
+#define read_barrier() mb()
+#define read_barrier_depends() do { } while(0)
+#define write_barrier() mb()
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-i386/system.h linux-2.4.14.read_barrier/include/asm-i386/system.h
--- linux-2.4.14/include/asm-i386/system.h	Mon Nov  5 12:42:13 2001
+++ linux-2.4.14.read_barrier/include/asm-i386/system.h	Tue Nov  6 16:49:45 2001
@@ -286,22 +286,32 @@
  * nop for these.
  */
  
-#define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
-#define rmb()	mb()
+#define memory_barrier() \
+		__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#define read_barrier()	mb()
+#define read_barrier_depends()	do { } while(0)
 
 #ifdef CONFIG_X86_OOSTORE
-#define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-ia64/system.h linux-2.4.14.read_barrier/include/asm-ia64/system.h
--- linux-2.4.14/include/asm-ia64/system.h	Tue Jul 31 10:30:09 2001
+++ linux-2.4.14.read_barrier/include/asm-ia64/system.h	Tue Nov  6 16:50:56 2001
@@ -80,33 +80,43 @@
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
+#define read_barrier()		mb()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		mb()
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-m68k/system.h linux-2.4.14.read_barrier/include/asm-m68k/system.h
--- linux-2.4.14/include/asm-m68k/system.h	Thu Oct 25 13:53:55 2001
+++ linux-2.4.14.read_barrier/include/asm-m68k/system.h	Tue Nov  6 16:51:50 2001
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
 
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-mips/system.h linux-2.4.14.read_barrier/include/asm-mips/system.h
--- linux-2.4.14/include/asm-mips/system.h	Sun Sep  9 10:43:01 2001
+++ linux-2.4.14.read_barrier/include/asm-mips/system.h	Tue Nov  6 16:53:02 2001
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
+#define read_barrier() mb()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier() mb()
 
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-mips64/system.h linux-2.4.14.read_barrier/include/asm-mips64/system.h
--- linux-2.4.14/include/asm-mips64/system.h	Wed Jul  4 11:50:39 2001
+++ linux-2.4.14.read_barrier/include/asm-mips64/system.h	Tue Nov  6 16:53:35 2001
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
+#define read_barrier() mb()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier() mb()
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-parisc/system.h linux-2.4.14.read_barrier/include/asm-parisc/system.h
--- linux-2.4.14/include/asm-parisc/system.h	Wed Dec  6 11:46:39 2000
+++ linux-2.4.14.read_barrier/include/asm-parisc/system.h	Tue Nov  6 16:54:55 2001
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
+#define read_barrier() mb()
+#define write_barrier() mb()
+#define read_barrier_depends()	do { } while(0)
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 extern unsigned long __xchg(unsigned long, unsigned long *, int);
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-ppc/system.h linux-2.4.14.read_barrier/include/asm-ppc/system.h
--- linux-2.4.14/include/asm-ppc/system.h	Tue Aug 28 06:58:33 2001
+++ linux-2.4.14.read_barrier/include/asm-ppc/system.h	Tue Nov  6 16:55:47 2001
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-s390/system.h linux-2.4.14.read_barrier/include/asm-s390/system.h
--- linux-2.4.14/include/asm-s390/system.h	Wed Jul 25 14:12:02 2001
+++ linux-2.4.14.read_barrier/include/asm-s390/system.h	Tue Nov  6 16:56:13 2001
@@ -115,14 +115,20 @@
 
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
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 
 #define set_mb(var, value)      do { var = value; mb(); } while (0)
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-s390x/system.h linux-2.4.14.read_barrier/include/asm-s390x/system.h
--- linux-2.4.14/include/asm-s390x/system.h	Wed Jul 25 14:12:03 2001
+++ linux-2.4.14.read_barrier/include/asm-s390x/system.h	Tue Nov  6 16:56:44 2001
@@ -128,17 +128,23 @@
 
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
 
 #define set_mb(var, value)      do { var = value; mb(); } while (0)
 #define set_wmb(var, value)     do { var = value; wmb(); } while (0)
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 /* interrupt control.. */
 #define __sti() ({ \
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-sh/system.h linux-2.4.14.read_barrier/include/asm-sh/system.h
--- linux-2.4.14/include/asm-sh/system.h	Sat Sep  8 12:29:09 2001
+++ linux-2.4.14.read_barrier/include/asm-sh/system.h	Tue Nov  6 16:57:42 2001
@@ -86,17 +86,24 @@
 
 extern void __xchg_called_with_bad_pointer(void);
 
-#define mb()	__asm__ __volatile__ ("": : :"memory")
-#define rmb()	mb()
-#define wmb()	__asm__ __volatile__ ("": : :"memory")
+#define memory_barrier()	__asm__ __volatile__ ("": : :"memory")
+#define read_barrier()		mb()
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-sparc/system.h linux-2.4.14.read_barrier/include/asm-sparc/system.h
--- linux-2.4.14/include/asm-sparc/system.h	Tue Oct 30 15:08:11 2001
+++ linux-2.4.14.read_barrier/include/asm-sparc/system.h	Tue Nov  6 16:58:11 2001
@@ -275,14 +275,20 @@
 #endif
 
 /* XXX Change this if we ever use a PSO mode kernel. */
-#define mb()	__asm__ __volatile__ ("" : : : "memory")
-#define rmb()	mb()
-#define wmb()	mb()
+#define memory_barrier()	__asm__ __volatile__ ("" : : : "memory")
+#define read_barrier()		mb()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		mb()
 #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
 #define set_wmb(__var, __value) set_mb(__var, __value)
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #define nop() __asm__ __volatile__ ("nop");
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.14/include/asm-sparc64/system.h linux-2.4.14.read_barrier/include/asm-sparc64/system.h
--- linux-2.4.14/include/asm-sparc64/system.h	Fri Sep  7 11:01:20 2001
+++ linux-2.4.14.read_barrier/include/asm-sparc64/system.h	Tue Nov  6 16:59:02 2001
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
 
