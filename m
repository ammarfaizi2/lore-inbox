Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264119AbUEMLuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUEMLuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 07:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUEMLuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 07:50:39 -0400
Received: from ozlabs.org ([203.10.76.45]:25478 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264119AbUEMLuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 07:50:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16547.24834.995594.457329@cargo.ozlabs.ibm.com>
Date: Thu, 13 May 2004 21:50:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] strengthen I/O and memory barriers
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I sent the recent patch to include/asm-ppc64/io.h which put
stronger barriers in the I/O accessor macros, Paul McKenney pointed
out to me that a writex/outx could still slide out from inside a
spinlocked region.  This patch makes the barriers a bit stronger so
that this can't happen.  It means that we need to use a sync
instruction for wmb (a full "heavyweight" sync), since drivers rely on
wmb for ordering between writes to system memory and writes to a
device.

I have left smb_wmb() as a lighter-weight barrier that orders stores,
and doesn't impose an ordering between cacheable and non-cacheable
accesses (the amusingly-named eieio instruction).  I am assuming here
that smp_wmb is only used for ordering stores to system memory so that
another cpu will see them in order.  It can't be used for enforcing
any ordering that a device will see, because it is just a gcc barrier
on UP.

This also changes the spinlock/rwlock unlock code to use lwsync
("light-weight sync") rather than eieio, since eieio doesn't order
loads, and we need to ensure that loads stay inside the spinlocked
region.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc64/kernel/misc.S g5-ppc64/arch/ppc64/kernel/misc.S
--- linux-2.5/arch/ppc64/kernel/misc.S	2004-05-11 07:53:04.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/misc.S	2004-05-13 21:17:44.750913072 +1000
@@ -316,6 +316,8 @@
 	eieio
 	stbu	r5,1(r4)
 	bdnz	00b
+	twi	0,r5,0
+	isync
 	blr
 
 _GLOBAL(_outsb)
@@ -325,8 +327,8 @@
 	blelr-
 00:	lbzu	r5,1(r4)
 	stb	r5,0(r3)
-	eieio
 	bdnz	00b
+	sync
 	blr	
 
 _GLOBAL(_insw)
@@ -338,6 +340,8 @@
 	eieio
 	sthu	r5,2(r4)
 	bdnz	00b
+	twi	0,r5,0
+	isync
 	blr
 
 _GLOBAL(_outsw)
@@ -346,9 +350,9 @@
 	subi	r4,r4,2
 	blelr-
 00:	lhzu	r5,2(r4)
-	eieio
 	sthbrx	r5,0,r3	
 	bdnz	00b
+	sync
 	blr	
 
 _GLOBAL(_insl)
@@ -360,6 +364,8 @@
 	eieio
 	stwu	r5,4(r4)
 	bdnz	00b
+	twi	0,r5,0
+	isync
 	blr
 
 _GLOBAL(_outsl)
@@ -369,8 +375,8 @@
 	blelr-
 00:	lwzu	r5,4(r4)
 	stwbrx	r5,0,r3
-	eieio
 	bdnz	00b
+	sync
 	blr	
 
 /* _GLOBAL(ide_insw) now in drivers/ide/ide-iops.c */
@@ -383,6 +389,8 @@
 	eieio
 	sthu	r5,2(r4)
 	bdnz	00b
+	twi	0,r5,0
+	isync
 	blr
 
 /* _GLOBAL(ide_outsw) now in drivers/ide/ide-iops.c */
@@ -393,8 +401,8 @@
 	blelr-
 00:	lhzu	r5,2(r4)
 	sth	r5,0(r3)
-	eieio
 	bdnz	00b
+	sync
 	blr	
 
 _GLOBAL(_insl_ns)
@@ -406,6 +414,8 @@
 	eieio
 	stwu	r5,4(r4)
 	bdnz	00b
+	twi	0,r5,0
+	isync
 	blr
 
 _GLOBAL(_outsl_ns)
@@ -415,8 +425,8 @@
 	blelr-
 00:	lwzu	r5,4(r4)
 	stw	r5,0(r3)
-	eieio
 	bdnz	00b
+	sync
 	blr	
 
 _GLOBAL(abs)
diff -urN linux-2.5/include/asm-ppc64/io.h g5-ppc64/include/asm-ppc64/io.h
--- linux-2.5/include/asm-ppc64/io.h	2004-05-11 13:19:51.000000000 +1000
+++ g5-ppc64/include/asm-ppc64/io.h	2004-05-11 16:24:47.000000000 +1000
@@ -240,14 +240,14 @@
 {
 	int ret;
 
-	__asm__ __volatile__("eieio; lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
 static inline void out_8(volatile unsigned char *addr, int val)
 {
-	__asm__ __volatile__("sync; stb%U0%X0 %1,%0"
+	__asm__ __volatile__("stb%U0%X0 %1,%0; sync"
 			     : "=m" (*addr) : "r" (val));
 }
 
@@ -255,7 +255,7 @@
 {
 	int ret;
 
-	__asm__ __volatile__("eieio; lhbrx %0,0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("lhbrx %0,0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "r" (addr), "m" (*addr));
 	return ret;
 }
@@ -264,20 +264,20 @@
 {
 	int ret;
 
-	__asm__ __volatile__("eieio; lhz%U1%X1 %0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("lhz%U1%X1 %0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
 static inline void out_le16(volatile unsigned short *addr, int val)
 {
-	__asm__ __volatile__("sync; sthbrx %1,0,%2"
+	__asm__ __volatile__("sthbrx %1,0,%2; sync"
 			     : "=m" (*addr) : "r" (val), "r" (addr));
 }
 
 static inline void out_be16(volatile unsigned short *addr, int val)
 {
-	__asm__ __volatile__("sync; sth%U0%X0 %1,%0"
+	__asm__ __volatile__("sth%U0%X0 %1,%0; sync"
 			     : "=m" (*addr) : "r" (val));
 }
 
@@ -285,7 +285,7 @@
 {
 	unsigned ret;
 
-	__asm__ __volatile__("eieio; lwbrx %0,0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("lwbrx %0,0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "r" (addr), "m" (*addr));
 	return ret;
 }
@@ -294,20 +294,20 @@
 {
 	unsigned ret;
 
-	__asm__ __volatile__("eieio; lwz%U1%X1 %0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
 static inline void out_le32(volatile unsigned *addr, int val)
 {
-	__asm__ __volatile__("sync; stwbrx %1,0,%2" : "=m" (*addr)
+	__asm__ __volatile__("stwbrx %1,0,%2; sync" : "=m" (*addr)
 			     : "r" (val), "r" (addr));
 }
 
 static inline void out_be32(volatile unsigned *addr, int val)
 {
-	__asm__ __volatile__("sync; stw%U0%X0 %1,%0; eieio"
+	__asm__ __volatile__("stw%U0%X0 %1,%0; eieio"
 			     : "=m" (*addr) : "r" (val));
 }
 
@@ -316,7 +316,7 @@
 	unsigned long tmp, ret;
 
 	__asm__ __volatile__(
-			     "eieio; ld %1,0(%2)\n"
+			     "ld %1,0(%2)\n"
 			     "twi 0,%1,0\n"
 			     "isync\n"
 			     "rldimi %0,%1,5*8,1*8\n"
@@ -334,7 +334,7 @@
 {
 	unsigned long ret;
 
-	__asm__ __volatile__("eieio; ld %0,0(%1); twi 0,%0,0; isync"
+	__asm__ __volatile__("ld %0,0(%1); twi 0,%0,0; isync"
 			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
@@ -351,13 +351,14 @@
 			     "rldicl %1,%1,32,0\n"
 			     "rlwimi %0,%1,8,8,31\n"
 			     "rlwimi %0,%1,24,16,23\n"
-			     "sync; std %0,0(%2)\n"
+			     "std %0,0(%2)\n"
+			     "sync"
 			     : "=r" (tmp) : "r" (val), "b" (addr) , "m" (*addr));
 }
 
 static inline void out_be64(volatile unsigned long *addr, int val)
 {
-	__asm__ __volatile__("sync; std %1,0(%0)" : "=m" (*addr) : "r" (val));
+	__asm__ __volatile__("std %1,0(%0); sync" : "=m" (*addr) : "r" (val));
 }
 
 #ifndef CONFIG_PPC_ISERIES 
diff -urN linux-2.5/include/asm-ppc64/spinlock.h g5-ppc64/include/asm-ppc64/spinlock.h
--- linux-2.5/include/asm-ppc64/spinlock.h	2004-05-11 07:53:05.000000000 +1000
+++ g5-ppc64/include/asm-ppc64/spinlock.h	2004-05-11 16:10:12.000000000 +1000
@@ -28,7 +28,7 @@
 
 static __inline__ void _raw_spin_unlock(spinlock_t *lock)
 {
-	__asm__ __volatile__("eieio	# spin_unlock": : :"memory");
+	__asm__ __volatile__("lwsync	# spin_unlock": : :"memory");
 	lock->lock = 0;
 }
 
@@ -159,7 +159,7 @@
 
 static __inline__ void _raw_write_unlock(rwlock_t *rw)
 {
-	__asm__ __volatile__("eieio		# write_unlock": : :"memory");
+	__asm__ __volatile__("lwsync		# write_unlock": : :"memory");
 	rw->lock = 0;
 }
 
@@ -223,7 +223,7 @@
 	unsigned int tmp;
 
 	__asm__ __volatile__(
-	"eieio				# read_unlock\n\
+	"lwsync				# read_unlock\n\
 1:	lwarx		%0,0,%1\n\
 	addic		%0,%0,-1\n\
 	stwcx.		%0,0,%1\n\
diff -urN linux-2.5/include/asm-ppc64/system.h g5-ppc64/include/asm-ppc64/system.h
--- linux-2.5/include/asm-ppc64/system.h	2004-04-13 09:25:10.000000000 +1000
+++ g5-ppc64/include/asm-ppc64/system.h	2004-05-11 16:09:43.000000000 +1000
@@ -29,22 +29,26 @@
  * read_barrier_depends() prevents data-dependent loads being reordered
  *	across this point (nop on PPC).
  *
- * We can use the eieio instruction for wmb, but since it doesn't
- * give any ordering guarantees about loads, we have to use the
- * stronger but slower sync instruction for mb and rmb.
+ * We have to use the sync instructions for mb(), since lwsync doesn't
+ * order loads with respect to previous stores.  Lwsync is fine for
+ * rmb(), though.
+ * For wmb(), we use sync since wmb is used in drivers to order
+ * stores to system memory with respect to writes to the device.
+ * However, smp_wmb() can be a lighter-weight eieio barrier on
+ * SMP since it is only used to order updates to system memory.
  */
 #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
 #define rmb()  __asm__ __volatile__ ("lwsync" : : : "memory")
-#define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
+#define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define read_barrier_depends()  do { } while(0)
 
-#define set_mb(var, value)	do { var = value; mb(); } while (0)
-#define set_wmb(var, value)	do { var = value; wmb(); } while (0)
+#define set_mb(var, value)	do { var = value; smp_mb(); } while (0)
+#define set_wmb(var, value)	do { var = value; smp_wmb(); } while (0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
-#define smp_wmb()	wmb()
+#define smp_wmb()	__asm__ __volatile__ ("eieio" : : : "memory")
 #define smp_read_barrier_depends()  read_barrier_depends()
 #else
 #define smp_mb()	__asm__ __volatile__("": : :"memory")
