Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUFCKET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUFCKET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 06:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUFCKET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 06:04:19 -0400
Received: from ozlabs.org ([203.10.76.45]:25236 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262351AbUFCKEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 06:04:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16574.63493.462869.55935@cargo.ozlabs.ibm.com>
Date: Thu, 3 Jun 2004 20:05:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Add _raw_write_trylock
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried compiling a PPC32 kernel with PREEMPT + SMP and it failed
because we didn't have a _raw_write_trylock.  This patch adds
_raw_write_trylock, moves the exports of _raw_*lock from
arch/ppc/kernel/ppc_ksyms.c to arch/ppc/lib/locks.c, and makes
__spin_trylock static since it is only used in locks.c.

Signed-off-by: Paul Mackerras <paulus@samba.org>

Please apply.

Paul.

diff -urN linux-2.5/arch/ppc/kernel/ppc_ksyms.c pmac-2.5/arch/ppc/kernel/ppc_ksyms.c
--- linux-2.5/arch/ppc/kernel/ppc_ksyms.c	2004-05-30 11:50:25.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/ppc_ksyms.c	2004-06-03 19:50:57.433970416 +1000
@@ -200,15 +200,6 @@
 EXPORT_SYMBOL(giveup_altivec);
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SMP
-#ifdef CONFIG_DEBUG_SPINLOCK
-EXPORT_SYMBOL(_raw_spin_lock);
-EXPORT_SYMBOL(_raw_spin_unlock);
-EXPORT_SYMBOL(_raw_spin_trylock);
-EXPORT_SYMBOL(_raw_read_lock);
-EXPORT_SYMBOL(_raw_read_unlock);
-EXPORT_SYMBOL(_raw_write_lock);
-EXPORT_SYMBOL(_raw_write_unlock);
-#endif
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_hw_index);
 EXPORT_SYMBOL(synchronize_irq);
diff -urN linux-2.5/arch/ppc/lib/locks.c pmac-2.5/arch/ppc/lib/locks.c
--- linux-2.5/arch/ppc/lib/locks.c	2003-09-27 19:46:43.000000000 +1000
+++ pmac-2.5/arch/ppc/lib/locks.c	2004-06-03 19:51:32.593950352 +1000
@@ -22,7 +22,7 @@
  * since they may inhibit forward progress by other CPUs in getting
  * a lock.
  */
-unsigned long __spin_trylock(volatile unsigned long *lock)
+static inline unsigned long __spin_trylock(volatile unsigned long *lock)
 {
 	unsigned long ret;
 
@@ -62,6 +62,7 @@
 	lock->owner_pc = (unsigned long)__builtin_return_address(0);
 	lock->owner_cpu = cpu;
 }
+EXPORT_SYMBOL(_raw_spin_lock);
 
 int _raw_spin_trylock(spinlock_t *lock)
 {
@@ -71,6 +72,7 @@
 	lock->owner_pc = (unsigned long)__builtin_return_address(0);
 	return 1;
 }
+EXPORT_SYMBOL(_raw_spin_trylock);
 
 void _raw_spin_unlock(spinlock_t *lp)
 {
@@ -86,6 +88,7 @@
 	wmb();
 	lp->lock = 0;
 }
+EXPORT_SYMBOL(_raw_spin_unlock);
 
 
 /*
@@ -119,6 +122,7 @@
 	}
 	wmb();
 }
+EXPORT_SYMBOL(_raw_read_lock);
 
 void _raw_read_unlock(rwlock_t *rw)
 {
@@ -129,6 +133,7 @@
 	wmb();
 	atomic_dec((atomic_t *) &(rw)->lock);
 }
+EXPORT_SYMBOL(_raw_read_unlock);
 
 void _raw_write_lock(rwlock_t *rw)
 {
@@ -169,6 +174,22 @@
 	}
 	wmb();
 }
+EXPORT_SYMBOL(_raw_write_lock);
+
+int _raw_write_trylock(rwlock_t *rw)
+{
+	if (test_and_set_bit(31, &(rw)->lock)) /* someone has a write lock */
+		return 0;
+
+	if ((rw)->lock & ~(1<<31)) {	/* someone has a read lock */
+		/* clear our write lock and wait for reads to go away */
+		clear_bit(31,&(rw)->lock);
+		return 0;
+	}
+	wmb();
+	return 1;
+}
+EXPORT_SYMBOL(_raw_write_trylock);
 
 void _raw_write_unlock(rwlock_t *rw)
 {
@@ -179,5 +200,6 @@
 	wmb();
 	clear_bit(31,&(rw)->lock);
 }
+EXPORT_SYMBOL(_raw_write_unlock);
 
 #endif
diff -urN linux-2.5/include/asm-ppc/spinlock.h pmac-2.5/include/asm-ppc/spinlock.h
--- linux-2.5/include/asm-ppc/spinlock.h	2004-05-11 07:53:05.000000000 +1000
+++ pmac-2.5/include/asm-ppc/spinlock.h	2004-06-03 13:04:33.000000000 +1000
@@ -65,7 +65,6 @@
 extern void _raw_spin_lock(spinlock_t *lock);
 extern void _raw_spin_unlock(spinlock_t *lock);
 extern int _raw_spin_trylock(spinlock_t *lock);
-extern unsigned long __spin_trylock(volatile unsigned long *lock);
 
 #endif
 
@@ -136,6 +135,26 @@
 	: "cr0", "memory");
 }
 
+static __inline__ int _raw_write_trylock(rwlock_t *rw)
+{
+	unsigned int tmp;
+
+	__asm__ __volatile__(
+"2:	lwarx	%0,0,%1\n\	# write_trylock\n\
+	cmpwi	0,%0,0\n\
+	bne-	1f\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%2,0,%1\n\
+	bne-	2b\n\
+	isync\n\
+1:"
+	: "=&r"(tmp)
+	: "r"(&rw->lock), "r"(-1)
+	: "cr0", "memory");
+
+	return tmp == 0;
+}
+
 static __inline__ void _raw_write_lock(rwlock_t *rw)
 {
 	unsigned int tmp;
@@ -169,6 +188,7 @@
 extern void _raw_read_unlock(rwlock_t *rw);
 extern void _raw_write_lock(rwlock_t *rw);
 extern void _raw_write_unlock(rwlock_t *rw);
+extern int _raw_write_trylock(rwlock_t *rw);
 
 #endif
 
