Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbTGDCVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbTGDCVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:21:08 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.9]:59480 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265686AbTGDCSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:18:12 -0400
Date: Thu, 03 Jul 2003 22:32:26 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH - RFC] [4/5] 64-bit network statistics - architecture specific
 code II.
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Message-id: <200307032232.34697.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_eN7OVBwmm7i7QGRsQMAPeA)"
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_eN7OVBwmm7i7QGRsQMAPeA)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

64-bit network statistics:
	Part 4 of 5 - architecture specific code II.

- -- 
Failure is not an option,
It comes bundled with your Microsoft product.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BOc+wFP0+seVj/4RAibpAJ9Wz1kJS9OLt+FFmndoIwARzsYYLgCgm6sw
NPXJ3m2VtVGMcu8dWrQ0okQ=
=zr+2
-----END PGP SIGNATURE-----

--Boundary_(ID_eN7OVBwmm7i7QGRsQMAPeA)
Content-type: text/x-diff; charset=us-ascii; name=asm_2.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=asm_2.diff

diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-parisc/atomic.h linux-2.5.74-nx/include/asm-parisc/atomic.h
--- linux-2.5.74-vanilla/include/asm-parisc/atomic.h	2003-07-02 16:45:10.000000000 -0400
+++ linux-2.5.74-nx/include/asm-parisc/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -5,6 +5,7 @@
 #include <asm/system.h>
 
 /* Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>.  */
+/* Copyright (C) 2003 Josef "Jeff" Sipek <jeffpc@optonline.net>. */
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -196,4 +197,45 @@
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+#ifdef CONFIG_PARISC64
+	*a += b;	// 64-bit environment
+#else
+	spin_lock(lock);
+	*a += b;
+	spin_lock(unlock);
+	#warning need to check implementation linux/include/asm-parisc/atomic.h: locked_add64() for 32-bit environment
+#endif
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+#ifdef CONFIG_PARISC64
+	*a = b;	// 64-bit environment
+#else
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm-parisc/atomic.h: locked_set64() for 32-bit environment
+#endif
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+#ifdef CONFIG_PARISC64
+	return *a;	// 64-bit environment
+#else
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm-parisc/atomic.h: locked_get64() for 32-bit environment
+	return tmp;
+#endif
+}
+
 #endif
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-ppc/atomic.h linux-2.5.74-nx/include/asm-ppc/atomic.h
--- linux-2.5.74-vanilla/include/asm-ppc/atomic.h	2003-07-02 16:43:39.000000000 -0400
+++ linux-2.5.74-nx/include/asm-ppc/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -1,6 +1,11 @@
 /*
  * PowerPC atomic operations
  */
+ 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
 
 #ifndef _ASM_PPC_ATOMIC_H_ 
 #define _ASM_PPC_ATOMIC_H_
@@ -200,5 +205,34 @@
 #define smp_mb__before_atomic_inc()	__MB
 #define smp_mb__after_atomic_inc()	__MB
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_add64()
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_set64()
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_get64()
+	return tmp;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_PPC_ATOMIC_H_ */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-ppc64/atomic.h linux-2.5.74-nx/include/asm-ppc64/atomic.h
--- linux-2.5.74-vanilla/include/asm-ppc64/atomic.h	2003-07-02 16:57:33.000000000 -0400
+++ linux-2.5.74-nx/include/asm-ppc64/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -10,6 +10,11 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
 #ifndef _ASM_PPC64_ATOMIC_H_ 
 #define _ASM_PPC64_ATOMIC_H_
 
@@ -182,4 +187,33 @@
 #define smp_mb__before_atomic_inc()     smp_mb()
 #define smp_mb__after_atomic_inc()      smp_mb()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_add64()
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_set64()
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_get64()
+	return tmp;
+}
+
 #endif /* _ASM_PPC64_ATOMIC_H_ */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-s390/atomic.h linux-2.5.74-nx/include/asm-s390/atomic.h
--- linux-2.5.74-vanilla/include/asm-s390/atomic.h	2003-07-02 16:41:06.000000000 -0400
+++ linux-2.5.74-nx/include/asm-s390/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -8,6 +8,8 @@
  *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Denis Joseph Barrow
+ *  
+ *               Josef "Jeff" Sipek (jeffpc@optonline.net)
  *
  *  Derived from "include/asm-i386/bitops.h"
  *    Copyright (C) 1992, Linus Torvalds
@@ -165,5 +167,34 @@
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_add64()
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_set64()
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_get64()
+	return tmp;
+}
+
 #endif                                 /* __ARCH_S390_ATOMIC __            */
 
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-sh/atomic.h linux-2.5.74-nx/include/asm-sh/atomic.h
--- linux-2.5.74-vanilla/include/asm-sh/atomic.h	2003-07-02 16:53:39.000000000 -0400
+++ linux-2.5.74-nx/include/asm-sh/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -6,6 +6,11 @@
  * resource counting etc..
  *
  */
+ 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
 
 typedef struct { volatile int counter; } atomic_t;
 
@@ -99,4 +104,33 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_add64()
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_set64()
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_get64()
+	return tmp;
+}
+
 #endif /* __ASM_SH_ATOMIC_H */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-sparc/atomic.h linux-2.5.74-nx/include/asm-sparc/atomic.h
--- linux-2.5.74-vanilla/include/asm-sparc/atomic.h	2003-07-02 16:50:22.000000000 -0400
+++ linux-2.5.74-nx/include/asm-sparc/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -4,6 +4,11 @@
  * Copyright (C) 2000 Anton Blanchard (anton@linuxcare.com.au)
  */
 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
 #ifndef __ARCH_SPARC_ATOMIC__
 #define __ARCH_SPARC_ATOMIC__
 
@@ -106,6 +111,35 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_add64()
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_set64()
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_get64()
+	return tmp;
+}
+
 #endif /* !(__KERNEL__) */
 
 #endif /* !(__ARCH_SPARC_ATOMIC__) */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-sparc64/atomic.h linux-2.5.74-nx/include/asm-sparc64/atomic.h
--- linux-2.5.74-vanilla/include/asm-sparc64/atomic.h	2003-07-02 16:56:02.000000000 -0400
+++ linux-2.5.74-nx/include/asm-sparc64/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -3,6 +3,7 @@
  *           stuff.
  *
  * Copyright (C) 1996, 1997, 2000 David S. Miller (davem@redhat.com)
+ * Copyright (C) 2003 Josef "Jeff" Sipek (jeffpc@optonline.net)
  */
 
 #ifndef __ARCH_SPARC64_ATOMIC__
@@ -35,4 +36,21 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	*a += b;
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	*a = b;
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	return *a;
+}
+
 #endif /* !(__ARCH_SPARC64_ATOMIC__) */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-um/atomic.h linux-2.5.74-nx/include/asm-um/atomic.h
--- linux-2.5.74-vanilla/include/asm-um/atomic.h	2003-07-02 16:48:33.000000000 -0400
+++ linux-2.5.74-nx/include/asm-um/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -1,6 +1,40 @@
 #ifndef __UM_ATOMIC_H
 #define __UM_ATOMIC_H
 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
 #include "asm/arch/atomic.h"
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_add64()
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_set64()
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_get64()
+	return tmp;
+}
+
 #endif
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-v850/atomic.h linux-2.5.74-nx/include/asm-v850/atomic.h
--- linux-2.5.74-vanilla/include/asm-v850/atomic.h	2003-07-02 16:49:32.000000000 -0400
+++ linux-2.5.74-nx/include/asm-v850/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -11,6 +11,11 @@
  * Written by Miles Bader <miles@gnu.org>
  */
 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
 #ifndef __V850_ATOMIC_H__
 #define __V850_ATOMIC_H__
 
@@ -86,4 +91,33 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_add64()
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_set64()
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+	#warning need to check implementation linux/include/asm/atomic.h: locked_get64()
+	return tmp;
+}
+
 #endif /* __V850_ATOMIC_H__ */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-x86_64/atomic.h linux-2.5.74-nx/include/asm-x86_64/atomic.h
--- linux-2.5.74-vanilla/include/asm-x86_64/atomic.h	2003-07-02 16:57:13.000000000 -0400
+++ linux-2.5.74-nx/include/asm-x86_64/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -1,6 +1,11 @@
 #ifndef __ARCH_X86_64_ATOMIC__
 #define __ARCH_X86_64_ATOMIC__
 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
 #include <linux/config.h>
 
 /* atomic_t should be 32 bit signed type */
@@ -203,4 +208,21 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	*a += b;
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	*a = b;
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	return *a;
+}
+
 #endif

--Boundary_(ID_eN7OVBwmm7i7QGRsQMAPeA)--
