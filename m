Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbSLEGwP>; Thu, 5 Dec 2002 01:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbSLEGwP>; Thu, 5 Dec 2002 01:52:15 -0500
Received: from dp.samba.org ([66.70.73.150]:42408 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267239AbSLEGwL>;
	Thu, 5 Dec 2002 01:52:11 -0500
Date: Thu, 5 Dec 2002 17:56:24 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] introducing io_barrier
Message-ID: <20021205065624.GD12543@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Currently we have three memory barrier primitives: mb, rmb and wmb.
On ppc64 a full memory barrier (sync) can be very expensive, so the
architecture has lighter weight barriers that can be used for rmb (lwsync)
and wmb (eieio).

This works well until drivers start using these lighter weight barriers.
eg from the e1000 driver:

        tx_desc->lower.data |= cpu_to_le32(E1000_TXD_CMD_EOP);

        /* Force memory writes to complete before letting h/w
         * know there are new descriptors to fetch.  (Only
         * applicable for weak-ordered memory model archs,
         * such as IA-64). */
        wmb();

        tx_ring->next_to_use = i;
        E1000_WRITE_REG(&adapter->hw, TDT, i);

wmb (eieio) guarantees to order stores to cacheable memory or
stores to non cacheable memory (ie IO) but will not order
between the two. So in the above example, E1000_WRITE_REG could
complete before the store to tx_desc->lower.data.

My first response was to create io_barrier, io_barrier_read and
io_barrier_write to match mb, rmb and wmb. However considering
how badly we handle the current memory barriers I decided to restrict
it to one function that will order between all cacheable and non
cacheable memory - io_barrier. Architectures can optimise as they
wish, Ive started them off as being a full memory barrier.

Thoughts?

Anton

===== include/asm-alpha/system.h 1.14 vs edited =====
--- 1.14/include/asm-alpha/system.h	Fri Nov  1 22:49:13 2002
+++ edited/include/asm-alpha/system.h	Thu Dec  5 17:02:29 2002
@@ -155,6 +155,8 @@
 #define read_barrier_depends() \
 __asm__ __volatile__("mb": : :"memory")
 
+#define io_barrier()	mb()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
===== include/asm-arm/system.h 1.13 vs edited =====
--- 1.13/include/asm-arm/system.h	Wed Oct 30 22:55:14 2002
+++ edited/include/asm-arm/system.h	Thu Dec  5 17:02:19 2002
@@ -63,6 +63,7 @@
 #define rmb() mb()
 #define wmb() mb()
 #define read_barrier_depends() do { } while(0)
+#define io_barrier()	mb()
 #define set_mb(var, value)  do { var = value; mb(); } while (0)
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
===== include/asm-cris/system.h 1.7 vs edited =====
--- 1.7/include/asm-cris/system.h	Sat Oct 19 12:02:56 2002
+++ edited/include/asm-cris/system.h	Thu Dec  5 17:02:13 2002
@@ -151,6 +151,7 @@
 #define rmb() mb()
 #define wmb() mb()
 #define read_barrier_depends() do { } while(0)
+#define io_barrier()	mb()
 #define set_mb(var, value)  do { var = value; mb(); } while (0)
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
===== include/asm-i386/system.h 1.20 vs edited =====
--- 1.20/include/asm-i386/system.h	Fri Nov 22 05:03:25 2002
+++ edited/include/asm-i386/system.h	Thu Dec  5 17:02:02 2002
@@ -344,6 +344,7 @@
  **/
 
 #define read_barrier_depends()	do { } while(0)
+#define io_barrier()	mb()
 
 #ifdef CONFIG_X86_OOSTORE
 #define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
===== include/asm-ia64/system.h 1.25 vs edited =====
--- 1.25/include/asm-ia64/system.h	Fri Nov  1 16:45:22 2002
+++ edited/include/asm-ia64/system.h	Thu Dec  5 17:01:23 2002
@@ -87,6 +87,7 @@
 #define rmb()	mb()
 #define wmb()	mb()
 #define read_barrier_depends()	do { } while(0)
+#define io_barrier()	mb()
 
 #ifdef CONFIG_SMP
 # define smp_mb()	mb()
===== include/asm-m68k/system.h 1.7 vs edited =====
--- 1.7/include/asm-m68k/system.h	Wed Sep 11 00:18:46 2002
+++ edited/include/asm-m68k/system.h	Thu Dec  5 17:03:33 2002
@@ -74,6 +74,7 @@
 #define mb()		barrier()
 #define rmb()		barrier()
 #define wmb()		barrier()
+#define io_barrier()	mb()
 #define set_mb(var, value)    do { xchg(&var, value); } while (0)
 #define set_wmb(var, value)    do { var = value; wmb(); } while (0)
 
===== include/asm-m68knommu/system.h 1.1 vs edited =====
--- 1.1/include/asm-m68knommu/system.h	Sat Nov  2 03:37:46 2002
+++ edited/include/asm-m68knommu/system.h	Thu Dec  5 17:03:41 2002
@@ -94,6 +94,7 @@
 #define mb()   asm volatile (""   : : :"memory")
 #define rmb()  asm volatile (""   : : :"memory")
 #define wmb()  asm volatile (""   : : :"memory")
+#define io_barrier()	mb()
 #define set_rmb(var, value)    do { xchg(&var, value); } while (0)
 #define set_mb(var, value)     set_rmb(var, value)
 #define set_wmb(var, value)    do { var = value; wmb(); } while (0)
===== include/asm-mips/system.h 1.5 vs edited =====
--- 1.5/include/asm-mips/system.h	Thu Oct 17 08:24:15 2002
+++ edited/include/asm-mips/system.h	Thu Dec  5 17:00:43 2002
@@ -147,6 +147,7 @@
 #define wmb()	wbflush()
 #define mb()	wbflush()
 #define read_barrier_depends()	do { } while(0)
+#define io_barrier()	mb()
 
 #else /* CONFIG_CPU_HAS_WB  */
 
===== include/asm-mips64/system.h 1.4 vs edited =====
--- 1.4/include/asm-mips64/system.h	Thu Oct 17 08:21:41 2002
+++ edited/include/asm-mips64/system.h	Thu Dec  5 17:00:39 2002
@@ -143,6 +143,7 @@
 #define rmb() mb()
 #define wmb() mb()
 #define read_barrier_depends()	do { } while(0)
+#define io_barrier()	mb()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
===== include/asm-parisc/system.h 1.5 vs edited =====
--- 1.5/include/asm-parisc/system.h	Mon Oct 21 15:34:40 2002
+++ edited/include/asm-parisc/system.h	Thu Dec  5 17:00:32 2002
@@ -132,6 +132,7 @@
 #define smp_wmb()	mb()
 #define smp_read_barrier_depends()	do { } while(0)
 #define read_barrier_depends()		do { } while(0)
+#define io_barrier()	mb()
 
 #define set_mb(var, value)		do { var = value; mb(); } while (0)
 #define set_wmb(var, value)		do { var = value; wmb(); } while (0)
===== include/asm-ppc/system.h 1.15 vs edited =====
--- 1.15/include/asm-ppc/system.h	Sat Oct 19 12:01:36 2002
+++ edited/include/asm-ppc/system.h	Thu Dec  5 17:00:26 2002
@@ -33,6 +33,7 @@
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
 #define read_barrier_depends()  do { } while(0)
+#define io_barrier()	mb()
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
 #define set_wmb(var, value)	do { var = value; wmb(); } while (0)
===== include/asm-ppc64/system.h 1.13 vs edited =====
--- 1.13/include/asm-ppc64/system.h	Fri Nov 22 16:33:12 2002
+++ edited/include/asm-ppc64/system.h	Thu Dec  5 16:57:44 2002
@@ -36,6 +36,7 @@
 #define rmb()  __asm__ __volatile__ ("lwsync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
 #define read_barrier_depends()  do { } while(0)
+#define io_barrier()	mb()
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
 #define set_wmb(var, value)	do { var = value; wmb(); } while (0)
===== include/asm-s390/system.h 1.13 vs edited =====
--- 1.13/include/asm-s390/system.h	Thu Oct 17 08:28:47 2002
+++ edited/include/asm-s390/system.h	Thu Dec  5 17:05:20 2002
@@ -228,6 +228,7 @@
 #define rmb()   eieio()
 #define wmb()   eieio()
 #define read_barrier_depends() do { } while(0)
+#define io_barrier()	mb()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
 #define smp_wmb()      wmb()
===== include/asm-s390x/system.h 1.12 vs edited =====
--- 1.12/include/asm-s390x/system.h	Thu Oct 17 08:29:42 2002
+++ edited/include/asm-s390x/system.h	Thu Dec  5 17:05:23 2002
@@ -239,6 +239,7 @@
 #define rmb()   eieio()
 #define wmb()   eieio()
 #define read_barrier_depends()	do { } while(0)
+#define io_barrier()	mb()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
 #define smp_wmb()      wmb()
===== include/asm-sh/system.h 1.5 vs edited =====
--- 1.5/include/asm-sh/system.h	Thu Oct 17 08:31:38 2002
+++ edited/include/asm-sh/system.h	Thu Dec  5 16:59:54 2002
@@ -90,6 +90,7 @@
 #define rmb()	mb()
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 #define read_barrier_depends()	do { } while(0)
+#define io_barrier()	mb()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
===== include/asm-sparc/system.h 1.12 vs edited =====
--- 1.12/include/asm-sparc/system.h	Wed Dec  4 09:35:17 2002
+++ edited/include/asm-sparc/system.h	Thu Dec  5 16:59:45 2002
@@ -297,6 +297,7 @@
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
 #define smp_read_barrier_depends()	do { } while(0)
+#define io_barrier()	mb()
 
 #define nop() __asm__ __volatile__ ("nop");
 
===== include/asm-sparc64/system.h 1.21 vs edited =====
--- 1.21/include/asm-sparc64/system.h	Tue Dec  3 05:11:13 2002
+++ edited/include/asm-sparc64/system.h	Thu Dec  5 17:05:02 2002
@@ -85,6 +85,7 @@
 #define rmb()		membar("#LoadLoad")
 #define wmb()		membar("#StoreStore")
 #define read_barrier_depends()		do { } while(0)
+#define io_barrier()	mb()
 #define set_mb(__var, __value) \
 	do { __var = __value; membar("#StoreLoad | #StoreStore"); } while(0)
 #define set_wmb(__var, __value) \
===== include/asm-v850/system.h 1.1 vs edited =====
--- 1.1/include/asm-v850/system.h	Sat Nov  2 03:38:12 2002
+++ edited/include/asm-v850/system.h	Thu Dec  5 17:04:27 2002
@@ -67,6 +67,7 @@
 #define mb()			__asm__ __volatile__ ("" ::: "memory")
 #define rmb()			mb ()
 #define wmb()			mb ()
+#define io_barrier()		mb()
 #define set_rmb(var, value)	do { xchg (&var, value); } while (0)
 #define set_mb(var, value)	set_rmb (var, value)
 #define set_wmb(var, value)	do { var = value; wmb (); } while (0)
===== include/asm-x86_64/system.h 1.8 vs edited =====
--- 1.8/include/asm-x86_64/system.h	Thu Oct 17 08:34:02 2002
+++ edited/include/asm-x86_64/system.h	Thu Dec  5 17:03:58 2002
@@ -233,6 +233,7 @@
 #define rmb()	asm volatile("lfence":::"memory")
 #define wmb()	asm volatile("sfence":::"memory")
 #define read_barrier_depends()	do {} while(0)
+#define io_barrier()	mb()
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
