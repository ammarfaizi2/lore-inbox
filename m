Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318030AbSHIAhp>; Thu, 8 Aug 2002 20:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSHIAhp>; Thu, 8 Aug 2002 20:37:45 -0400
Received: from ppp-217-133-219-100.dialup.tiscali.it ([217.133.219.100]:11193
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318030AbSHIAhm>; Thu, 8 Aug 2002 20:37:42 -0400
Subject: [PATCH] [2.5] (v2) asm-generic/atomic.h and changes to arm, parisc,
	mips, m68k, sh, cris to use it
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20020809002958.B20257@flint.arm.linux.org.uk>
References: <1028842995.1669.70.camel@ldb> 
	<20020809002958.B20257@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-TECEcGUwhg9CNBmM4qm1"
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2002 02:41:18 +0200
Message-Id: <1028853678.28699.228.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TECEcGUwhg9CNBmM4qm1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry, the patch I sent was total crap.

Not only the simple operations were unsafe, but they also didn't work
because GCC splits volatile read-change-writes...
Furthermore the complex operation caused two loads of v->counter still
beacuse of volatile.

The following patch replaces the asm-generic and asm-m68k parts of the
original patch with hopefully decent code.

The code is now equivalent to the old ARM one (I have separated the
add/sub from the counter store for more clarity, but this shouldn't have
any adverse effect) and m68k continues to use its inline assembly but
uses asm-generic/atomic.h for basic definitions, barriers and complex
operations.


diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-sh --exclude=asm-cris --exclude=asm-arm --exclude=asm-parisc --exclude=parisc --exclude=asm-mips --exclude=asm-i386 a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
--- a/include/asm-generic/atomic.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/asm-generic/atomic.h	2002-08-09 02:14:30.000000000 +0200
@@ -0,0 +1,167 @@
+/*
+ *  linux/include/asm-generic/atomic.h
+ *
+ *  Copyright (c) 2002 Luca Barbieri.
+ *  Portions Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __ASM_GENERIC_ATOMIC_H
+#define __ASM_GENERIC_ATOMIC_H
+
+#include <linux/config.h>
+
+#ifndef __ARCH_ATOMIC_HAVE_BASIC
+typedef struct {
+	volatile int counter;
+} atomic_t;
+#endif
+
+#ifdef __KERNEL__
+
+#ifndef __ARCH_ATOMIC_HAVE_BASIC
+#define ATOMIC_INIT(i)	{ (i) }
+
+#define atomic_read(v)   ((v)->counter)
+#define atomic_set(v, i) (((v)->counter) = (i))
+#endif
+
+#ifndef __ARCH_ATOMIC_HAVE_LOCK
+#ifndef CONFIG_SMP
+#include <asm/system.h>
+
+#define atomic_lock(v)   do {unsigned long flags; local_irq_save(flags);
+#define atomic_unlock(v) local_irq_restore(flags);} while(0)
+
+#else
+
+#include <linux/spinlock.h>
+
+#ifndef atomic_to_spinlock
+/* we have an array of spinlocks for our atomic_ts, and a hash function
+ * to get the right index */
+/* NOTE: unless there are really a lot of CPUs ATOMIC_HASH_SIZE = 1 is
+         probably the fastest
+*/
+#ifndef ATOMIC_HASH_SIZE
+#define ATOMIC_HASH_SIZE 1
+#endif
+
+#ifdef __INIT_GLOBAL__
+spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] = {
+	[0 ... (ATOMIC_HASH_SIZE-1)]  = SPIN_LOCK_UNLOCKED
+};
+#else
+extern spinlock_t __atomic_hash[ATOMIC_HASH_SIZE];
+#endif
+
+#if ATOMIC_HASH_SIZE > 1
+/* This can probably be greatly improved. */
+#include <linux/cache.h>
+#define atomic_to_spinlock(v) (&__atomic_hash[(((unsigned long)v / sizeof(struct atomic_t)) + ((unsigned long)v / L1_CACHE_BYTES)) % ATOMIC_HASH_SIZE])
+#else
+#define atomic_to_spinlock(v) (&__atomic_hash[0])
+#endif
+#endif
+
+#define atomic_lock(v)   do {unsigned long flags; spin_lock_irqsave(atomic_to_spinlock(v), flags)
+#define atomic_unlock(v) spin_unlock_irqrestore(atomic_to_spinlock(v), flags); } while(0)
+#endif 
+#endif /* CONFIG_SMP */
+
+#ifndef __ARCH_ATOMIC_HAVE_SIMPLE
+static inline void atomic_add(int i, atomic_t *v)
+{
+	atomic_lock(v);
+	v->counter += i;
+	atomic_unlock(v);
+}
+
+static inline void atomic_sub(int i, atomic_t *v)
+{
+	atomic_lock(v);
+	v->counter -= i;
+	atomic_unlock(v);
+}
+
+#define atomic_inc(v) atomic_add(1, (v))
+#define atomic_dec(v) atomic_sub(1, (v))
+#endif
+
+#ifndef __ARCH_ATOMIC_HAVE_COMPLEX
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	int new;
+
+	atomic_lock(v);
+	new = v->counter;
+	new += i;
+	v->counter = new;
+	atomic_unlock(v);
+
+	return new;
+}
+
+static inline int atomic_sub_return(int i, atomic_t *v)
+{
+	int new;
+
+	atomic_lock(v);
+	new = v->counter;
+	new -= i;
+	v->counter = new;
+	atomic_unlock(v);
+
+	return new;
+}
+
+#define atomic_dec_return(v) atomic_sub_return(1, (v))
+#define atomic_inc_return(v) atomic_add_return(1, (v))
+
+#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
+#define atomic_add_and_test(i,v) (atomic_add_return((i), (v)) == 0)
+#define atomic_dec_and_test(v)  (atomic_dec_return((v)) == 0)
+#define atomic_inc_and_test(v)  (atomic_inc_return((v)) == 0)
+
+#define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)
+#define atomic_sub_negative(i,v) (atomic_sub_return(i, v) < 0)
+#endif
+
+#if !defined(CONFIG_SMP) && !defined(__ARCH_ATOMIC_HAVE_MASK)
+#define atomic_lock_mask(v)   atomic_lock(0)
+#define atomic_unlock_mask(v) atomic_unlock(0)
+
+static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
+{
+	atomic_lock_mask(addr);
+	*addr &= ~mask;
+	atomic_unlock_mask(addr);
+}
+
+static inline void atomic_set_mask(unsigned long mask, unsigned long *addr)
+{
+	atomic_lock_mask(addr);
+	*addr |= mask;
+	atomic_unlock_mask(addr);
+}
+
+static inline void atomic_change_mask(unsigned long mask, unsigned long *addr)
+{
+	atomic_lock_mask(addr);
+	*addr ^= mask;
+	atomic_unlock_mask(addr);
+}
+#endif
+
+#ifndef __ARCH_ATOMIC_HAVE_BARRIERS
+#define smp_mb__before_atomic_dec()	barrier()
+#define smp_mb__after_atomic_dec()	barrier()
+#define smp_mb__before_atomic_inc()	barrier()
+#define smp_mb__after_atomic_inc()	barrier()
+#endif
+
+#endif
+#endif
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-sh --exclude=asm-cris --exclude=asm-arm --exclude=asm-parisc --exclude=parisc --exclude=asm-mips --exclude=asm-i386 a/include/asm-m68k/atomic.h b/include/asm-m68k/atomic.h
--- a/include/asm-m68k/atomic.h	2002-07-20 21:11:06.000000000 +0200
+++ b/include/asm-m68k/atomic.h	2002-08-09 02:04:35.000000000 +0200
@@ -10,11 +10,10 @@
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */
 
-typedef struct { int counter; } atomic_t;
-#define ATOMIC_INIT(i)	{ (i) }
-
-#define atomic_read(v)		((v)->counter)
-#define atomic_set(v, i)	(((v)->counter) = i)
+#define __ARCH_ATOMIC_HAVE_SIMPLE
+#define __ARCH_ATOMIC_HAVE_MASK
+#include <asm-generic/atomic.h>
+#undef atomic_dec_and_test
 
 static __inline__ void atomic_add(int i, atomic_t *v)
 {
@@ -49,10 +48,4 @@
 #define atomic_set_mask(mask, v) \
 	__asm__ __volatile__("orl %1,%0" : "=m" (*v) : "id" (mask),"0"(*v))
 
-/* Atomic operations are already serializing */
-#define smp_mb__before_atomic_dec()	barrier()
-#define smp_mb__after_atomic_dec()	barrier()
-#define smp_mb__before_atomic_inc()	barrier()
-#define smp_mb__after_atomic_inc()	barrier()
-
 #endif /* __ARCH_M68K_ATOMIC __ */
diff --exclude-from=/home/ldb/src/linux-exclude -urNd --exclude=asm-sh --exclude=asm-cris --exclude=asm-arm --exclude=asm-parisc --exclude=parisc --exclude=asm-mips --exclude=asm-i386 a/init/main.c b/init/main.c
--- a/init/main.c	2002-08-02 01:19:14.000000000 +0200
+++ b/init/main.c	2002-08-09 01:51:18.000000000 +0200
@@ -10,6 +10,7 @@
  */
 
 #define __KERNEL_SYSCALLS__
+#define __INIT_GLOBAL__
 
 #include <linux/config.h>
 #include <linux/proc_fs.h>

--=-TECEcGUwhg9CNBmM4qm1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9Uw+tdjkty3ft5+cRAhIGAJ9KYmi2DGXZcFaK+z6KzyrOPBwYQQCgnaQq
7WQmbMnCyTb3ggmu6VBFGVA=
=vpci
-----END PGP SIGNATURE-----

--=-TECEcGUwhg9CNBmM4qm1--
