Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278324AbRJMQ2S>; Sat, 13 Oct 2001 12:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278335AbRJMQ2I>; Sat, 13 Oct 2001 12:28:08 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:40080 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278326AbRJMQ14>; Sat, 13 Oct 2001 12:27:56 -0400
From: "Paul E. McKenney" <pmckenne@us.ibm.com>
Message-Id: <200110131628.f9DGSGW09534@eng4.beaverton.ibm.com>
Subject: Re: Re: RFC: patch to allow lock-free traversal of lists with insertion ^M
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Sat, 13 Oct 2001 09:28:15 -0700 (PDT)
Cc: torvalds@transmeta.com (Linus Torvalds), dipankar@in.ibm.com,
        linux-kernel@vger.kernel.org, paul.mckenney@us.ibm.com
In-Reply-To: <E15sJNF-0005Je-00@wagner> from "Rusty Russell" at Oct 13, 2001 04:38:21 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In message <Pine.LNX.4.33.0110120919130.31677-100000@penguin.transmeta.com> you
> write:
>> And hey, if you want to, feel free to create the regular
>> 
>>       #define read_barrier()          rmb()
>>       #define write_barrier()         wmb()
>>       #define memory_barrier()        mb()
>
>I agree... read_barrier_depends() then?
>
>Rusty.
>--
>Premature optmztion is rt of all evl. --DK

OK, here is an RFC patch with the read_barrier_depends().  (I know that
the indentation is messed up, will fix when I add the read_barrier()
and friends).

Thoughts?  Especially from people familiar with MIPS and PA-RISC?

					Thanx, Paul

diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-alpha/system.h linux-2.4.10.read_barrier_depends/include/asm-alpha/system.h
--- linux-2.4.10/include/asm-alpha/system.h	Sun Aug 12 10:38:47 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-alpha/system.h	Sat Oct 13 08:40:34 2001
@@ -148,16 +148,21 @@
 #define rmb() \
 __asm__ __volatile__("mb": : :"memory")
 
+#define read_barrier_depends() \
+__asm__ __volatile__("mb": : :"memory")
+
 #define wmb() \
 __asm__ __volatile__("wmb": : :"memory")
 
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-arm/system.h linux-2.4.10.read_barrier_depends/include/asm-arm/system.h
--- linux-2.4.10/include/asm-arm/system.h	Mon Nov 27 17:07:59 2000
+++ linux-2.4.10.read_barrier_depends/include/asm-arm/system.h	Sat Oct 13 08:40:40 2001
@@ -38,6 +38,7 @@
 
 #define mb() __asm__ __volatile__ ("" : : : "memory")
 #define rmb() mb()
+#define read_barrier_depends() do { } while(0)
 #define wmb() mb()
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
@@ -67,12 +68,14 @@
 
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
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-cris/system.h linux-2.4.10.read_barrier_depends/include/asm-cris/system.h
--- linux-2.4.10/include/asm-cris/system.h	Tue May  1 16:05:00 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-cris/system.h	Sat Oct 13 08:40:48 2001
@@ -143,15 +143,18 @@
 
 #define mb() __asm__ __volatile__ ("" : : : "memory")
 #define rmb() mb()
+#define read_barrier_depends() do { } while(0)
 #define wmb() mb()
 
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-i386/system.h linux-2.4.10.read_barrier_depends/include/asm-i386/system.h
--- linux-2.4.10/include/asm-i386/system.h	Sun Sep 23 10:31:01 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-i386/system.h	Sat Oct 13 08:40:54 2001
@@ -284,15 +284,18 @@
  */
 #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #define rmb()	mb()
+#define read_barrier_depends()	do { } while(0)
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-ia64/system.h linux-2.4.10.read_barrier_depends/include/asm-ia64/system.h
--- linux-2.4.10/include/asm-ia64/system.h	Tue Jul 31 10:30:09 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-ia64/system.h	Sat Oct 13 08:55:13 2001
@@ -85,6 +85,9 @@
  *		stores and that all following stores will be
  *		visible only after all previous stores.
  *   rmb():	Like wmb(), but for reads.
+ *   read_barrier_depends():	Like rmb(), but only for pairs
+ *		of loads where the second load depends on the
+ *		value loaded by the first.
  *   mb():	wmb()/rmb() combo, i.e., all previous memory
  *		accesses are visible before all subsequent
  *		accesses and vice versa.  This is also known as
@@ -98,15 +101,18 @@
  */
 #define mb()	__asm__ __volatile__ ("mf" ::: "memory")
 #define rmb()	mb()
+#define read_barrier_depends()	do { } while(0)
 #define wmb()	mb()
 
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-m68k/system.h linux-2.4.10.read_barrier_depends/include/asm-m68k/system.h
--- linux-2.4.10/include/asm-m68k/system.h	Mon Jun 11 19:15:27 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-m68k/system.h	Sat Oct 13 08:41:08 2001
@@ -80,12 +80,14 @@
 #define nop()		do { asm volatile ("nop"); barrier(); } while (0)
 #define mb()		barrier()
 #define rmb()		barrier()
+#define read_barrier_depends()		do { } while(0)
 #define wmb()		barrier()
 #define set_mb(var, value)    do { xchg(&var, value); } while (0)
 #define set_wmb(var, value)    do { var = value; wmb(); } while (0)
 
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-mips/system.h linux-2.4.10.read_barrier_depends/include/asm-mips/system.h
--- linux-2.4.10/include/asm-mips/system.h	Sun Sep  9 10:43:01 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-mips/system.h	Sat Oct 13 08:41:14 2001
@@ -150,6 +150,7 @@
 
 #include <asm/wbflush.h>
 #define rmb()	do { } while(0)
+#define read_barrier_depends()	do { } while(0)
 #define wmb()	wbflush()
 #define mb()	wbflush()
 
@@ -166,6 +167,7 @@
 	: /* no input */				\
 	: "memory")
 #define rmb() mb()
+#define read_barrier_depends()	do { } while(0)
 #define wmb() mb()
 
 #endif /* CONFIG_CPU_HAS_WB  */
@@ -173,10 +175,12 @@
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-mips64/system.h linux-2.4.10.read_barrier_depends/include/asm-mips64/system.h
--- linux-2.4.10/include/asm-mips64/system.h	Wed Jul  4 11:50:39 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-mips64/system.h	Sat Oct 13 08:41:22 2001
@@ -147,15 +147,18 @@
 	: /* no input */				\
 	: "memory")
 #define rmb() mb()
+#define read_barrier_depends()	do { } while(0)
 #define wmb() mb()
 
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-parisc/system.h linux-2.4.10.read_barrier_depends/include/asm-parisc/system.h
--- linux-2.4.10/include/asm-parisc/system.h	Wed Dec  6 11:46:39 2000
+++ linux-2.4.10.read_barrier_depends/include/asm-parisc/system.h	Sat Oct 13 08:41:28 2001
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
 
@@ -122,6 +124,7 @@
 
 #define mb()  __asm__ __volatile__ ("sync" : : :"memory")
 #define wmb() mb()
+#define read_barrier_depends()	do { } while(0)
 
 extern unsigned long __xchg(unsigned long, unsigned long *, int);
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-ppc/system.h linux-2.4.10.read_barrier_depends/include/asm-ppc/system.h
--- linux-2.4.10/include/asm-ppc/system.h	Tue Aug 28 06:58:33 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-ppc/system.h	Sat Oct 13 08:41:56 2001
@@ -24,6 +24,8 @@
  *
  * mb() prevents loads and stores being reordered across this point.
  * rmb() prevents loads being reordered across this point.
+ * read_barrier_depends() prevents data-dependant loads being reordered
+ *	across this point (nop on PPC).
  * wmb() prevents stores being reordered across this point.
  *
  * We can use the eieio instruction for wmb, but since it doesn't
@@ -32,6 +34,7 @@
  */
 #define mb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
+#define read_barrier_depends()  do { } while(0)
 #define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
@@ -40,10 +43,12 @@
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-s390/system.h linux-2.4.10.read_barrier_depends/include/asm-s390/system.h
--- linux-2.4.10/include/asm-s390/system.h	Wed Jul 25 14:12:02 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-s390/system.h	Sat Oct 13 08:42:08 2001
@@ -117,9 +117,11 @@
 # define SYNC_OTHER_CORES(x)   eieio() 
 #define mb()    eieio()
 #define rmb()   eieio()
+#define read_barrier_depends() do { } while(0)
 #define wmb()   eieio()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
+#define smp_read_barrier_depends()    read_barrier_depends()
 #define smp_wmb()      wmb()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-s390x/system.h linux-2.4.10.read_barrier_depends/include/asm-s390x/system.h
--- linux-2.4.10/include/asm-s390x/system.h	Wed Jul 25 14:12:03 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-s390x/system.h	Sat Oct 13 08:42:14 2001
@@ -130,9 +130,11 @@
 # define SYNC_OTHER_CORES(x)   eieio() 
 #define mb()    eieio()
 #define rmb()   eieio()
+#define read_barrier_depends()	do { } while(0)
 #define wmb()   eieio()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
+#define smp_read_barrier_depends()    read_barrier_depends()
 #define smp_wmb()      wmb()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-sh/system.h linux-2.4.10.read_barrier_depends/include/asm-sh/system.h
--- linux-2.4.10/include/asm-sh/system.h	Sat Sep  8 12:29:09 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-sh/system.h	Sat Oct 13 08:43:04 2001
@@ -88,15 +88,18 @@
 
 #define mb()	__asm__ __volatile__ ("": : :"memory")
 #define rmb()	mb()
+#define read_barrier_depends()	do { } while(0)
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 
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
 
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-sparc/system.h linux-2.4.10.read_barrier_depends/include/asm-sparc/system.h
--- linux-2.4.10/include/asm-sparc/system.h	Tue Oct  3 09:24:41 2000
+++ linux-2.4.10.read_barrier_depends/include/asm-sparc/system.h	Sat Oct 13 08:43:09 2001
@@ -277,11 +277,13 @@
 /* XXX Change this if we ever use a PSO mode kernel. */
 #define mb()	__asm__ __volatile__ ("" : : : "memory")
 #define rmb()	mb()
+#define read_barrier_depends()	do { } while(0)
 #define wmb()	mb()
 #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
 #define set_wmb(__var, __value) set_mb(__var, __value)
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
 
 #define nop() __asm__ __volatile__ ("nop");
diff -urN -X /home/mckenney/dontdiff linux-2.4.10/include/asm-sparc64/system.h linux-2.4.10.read_barrier_depends/include/asm-sparc64/system.h
--- linux-2.4.10/include/asm-sparc64/system.h	Fri Sep  7 11:01:20 2001
+++ linux-2.4.10.read_barrier_depends/include/asm-sparc64/system.h	Sat Oct 13 08:43:14 2001
@@ -99,6 +99,7 @@
 #define mb()		\
 	membar("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad");
 #define rmb()		membar("#LoadLoad")
+#define read_barrier_depends()		do { } while(0)
 #define wmb()		membar("#StoreStore")
 #define set_mb(__var, __value) \
 	do { __var = __value; membar("#StoreLoad | #StoreStore"); } while(0)
@@ -108,10 +109,12 @@
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
 
