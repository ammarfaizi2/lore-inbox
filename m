Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbTGDCWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbTGDCWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:22:04 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.23]:62679 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265671AbTGDCR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:17:59 -0400
Date: Thu, 03 Jul 2003 22:32:12 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH - RFC] [3/5] 64-bit network statistics - architecture specific
 code I.
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Message-id: <200307032232.21455.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_r1dw2UNqdSrt6f+6lNWrjw)"
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_r1dw2UNqdSrt6f+6lNWrjw)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

64-bit network statistics:
	Part 3 of 5 - architecture specific code I.

- -- 
Trust me, you don't want me doing _anything_ first thing in the morning.
		- Linus Torvalds


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BOcxwFP0+seVj/4RApLpAKC4O/Mf0XaX33R6Vj1uMX7cf99tTwCeOFWV
Y6BE1PGiw83GOEfbvECeR68=
=wFlU
-----END PGP SIGNATURE-----

--Boundary_(ID_r1dw2UNqdSrt6f+6lNWrjw)
Content-type: text/x-diff; charset=us-ascii; name=asm_1.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=asm_1.diff

diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-alpha/atomic.h linux-2.5.74-nx/include/asm-alpha/atomic.h
--- linux-2.5.74-vanilla/include/asm-alpha/atomic.h	2003-07-02 16:50:11.000000000 -0400
+++ linux-2.5.74-nx/include/asm-alpha/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -9,6 +9,10 @@
  * than regular operations.
  */
 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
 
 /*
  * Counter is volatile to make sure gcc doesn't try to be clever
@@ -111,4 +115,33 @@
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
 #endif /* _ALPHA_ATOMIC_H */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-arm/atomic.h linux-2.5.74-nx/include/asm-arm/atomic.h
--- linux-2.5.74-vanilla/include/asm-arm/atomic.h	2003-07-02 16:41:50.000000000 -0400
+++ linux-2.5.74-nx/include/asm-arm/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -12,6 +12,7 @@
  *   13-04-1997	RMK	Made functions atomic!
  *   07-12-1997	RMK	Upgraded for v2.1.
  *   26-08-1998	PJB	Added #ifdef __KERNEL__
+ *   02-07-2003	JS	Added locked_*
  */
 #ifndef __ASM_ARM_ATOMIC_H
 #define __ASM_ARM_ATOMIC_H
@@ -109,5 +110,32 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+
+	return tmp;
+}
+
 #endif
 #endif
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-arm26/atomic.h linux-2.5.74-nx/include/asm-arm26/atomic.h
--- linux-2.5.74-vanilla/include/asm-arm26/atomic.h	2003-07-02 16:46:23.000000000 -0400
+++ linux-2.5.74-nx/include/asm-arm26/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -12,6 +12,7 @@
  *   13-04-1997	RMK	Made functions atomic!
  *   07-12-1997	RMK	Upgraded for v2.1.
  *   26-08-1998	PJB	Added #ifdef __KERNEL__
+ *   02-07-2003	JS	Added locked_*
  *
  *  FIXME - its probably worth seeing what these compile into...
  */
@@ -111,5 +112,32 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+
+	return tmp;
+}
+
 #endif
 #endif
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-cris/atomic.h linux-2.5.74-nx/include/asm-cris/atomic.h
--- linux-2.5.74-vanilla/include/asm-cris/atomic.h	2003-07-02 16:49:13.000000000 -0400
+++ linux-2.5.74-nx/include/asm-cris/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -10,6 +10,11 @@
  * resource counting etc..
  */
 
+ /*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
 /*
  * Make sure gcc doesn't try to be clever and move things around
  * on us. We need to use _exactly_ the address the user gave us,
@@ -145,4 +150,33 @@
 #define smp_mb__before_atomic_inc()    barrier()
 #define smp_mb__after_atomic_inc()     barrier()
 
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
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-h8300/atomic.h linux-2.5.74-nx/include/asm-h8300/atomic.h
--- linux-2.5.74-vanilla/include/asm-h8300/atomic.h	2003-07-02 16:45:53.000000000 -0400
+++ linux-2.5.74-nx/include/asm-h8300/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -6,6 +6,11 @@
  * resource counting etc..
  */
 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
 typedef struct { int counter; } atomic_t;
 #define ATOMIC_INIT(i)	{ (i) }
 
@@ -104,4 +109,33 @@
 #define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
 #define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
 
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
 #endif /* __ARCH_H8300_ATOMIC __ */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-i386/atomic.h linux-2.5.74-nx/include/asm-i386/atomic.h
--- linux-2.5.74-vanilla/include/asm-i386/atomic.h	2003-07-02 16:43:50.000000000 -0400
+++ linux-2.5.74-nx/include/asm-i386/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -1,7 +1,13 @@
 #ifndef __ARCH_I386_ATOMIC__
 #define __ARCH_I386_ATOMIC__
 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
 #include <linux/config.h>
+#include <linux/types.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -201,4 +207,31 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <linux/spinlock.h>
+
+static inline void locked_add64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a += b;
+	spin_unlock(lock);
+}
+
+static inline void locked_set64(u_int64_t* a, u_int64_t b, spinlock_t* lock)
+{
+	spin_lock(lock);
+	*a = b;
+	spin_unlock(lock);
+}
+
+static inline u_int64_t locked_get64(u_int64_t* a, spinlock_t* lock)
+{
+	u_int64_t tmp;
+
+	spin_lock(lock);
+	tmp = *a;
+	spin_unlock(lock);
+
+	return tmp;
+}
+
 #endif
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-ia64/atomic.h linux-2.5.74-nx/include/asm-ia64/atomic.h
--- linux-2.5.74-vanilla/include/asm-ia64/atomic.h	2003-07-02 16:42:15.000000000 -0400
+++ linux-2.5.74-nx/include/asm-ia64/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -11,6 +11,7 @@
  *
  * Copyright (C) 1998, 1999, 2002 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
+ * Copyright (C) 2003 Josef "Jeff" Sipek <jeffpc@optonline.net>
  */
 #include <linux/types.h>
 
@@ -107,4 +108,21 @@
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
 #endif /* _ASM_IA64_ATOMIC_H */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-m68k/atomic.h linux-2.5.74-nx/include/asm-m68k/atomic.h
--- linux-2.5.74-vanilla/include/asm-m68k/atomic.h	2003-07-02 16:40:29.000000000 -0400
+++ linux-2.5.74-nx/include/asm-m68k/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -10,6 +10,11 @@
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */
 
+/*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
 typedef struct { int counter; } atomic_t;
 #define ATOMIC_INIT(i)	{ (i) }
 
@@ -55,4 +60,33 @@
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
 #endif /* __ARCH_M68K_ATOMIC __ */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-m68knommu/atomic.h linux-2.5.74-nx/include/asm-m68knommu/atomic.h
--- linux-2.5.74-vanilla/include/asm-m68knommu/atomic.h	2003-07-02 16:46:53.000000000 -0400
+++ linux-2.5.74-nx/include/asm-m68knommu/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -9,6 +9,11 @@
  */
 
 /*
+ * Authors:	?:				?
+ *		Josef "Jeff" Sipek:		<jeffpc@optonline.net>
+ */
+
+/*
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */
 
@@ -115,4 +120,33 @@
 #define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
 #define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
 
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
 #endif /* __ARCH_M68KNOMMU_ATOMIC __ */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-mips/atomic.h linux-2.5.74-nx/include/asm-mips/atomic.h
--- linux-2.5.74-vanilla/include/asm-mips/atomic.h	2003-07-02 16:39:22.000000000 -0400
+++ linux-2.5.74-nx/include/asm-mips/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -10,6 +10,7 @@
  * for more details.
  *
  * Copyright (C) 1996, 1997, 2000 by Ralf Baechle
+ * Copyright (C) 2003 by Josef "Jeff" Sipek <jeffpc@optonline.net>
  */
 #ifndef __ASM_ATOMIC_H
 #define __ASM_ATOMIC_H
@@ -277,6 +278,35 @@
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
 #endif /* defined(__KERNEL__) */
 
 #endif /* __ASM_ATOMIC_H */
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/asm-mips64/atomic.h linux-2.5.74-nx/include/asm-mips64/atomic.h
--- linux-2.5.74-vanilla/include/asm-mips64/atomic.h	2003-07-02 16:41:17.000000000 -0400
+++ linux-2.5.74-nx/include/asm-mips64/atomic.h	2003-07-03 15:11:00.000000000 -0400
@@ -10,6 +10,7 @@
  * for more details.
  *
  * Copyright (C) 1996, 1997, 1999, 2000 by Ralf Baechle
+ * Copyright (C) 2003 by Josef "Jeff" Sipek <jeffpc@optonline.net>
  */
 #ifndef _ASM_ATOMIC_H
 #define _ASM_ATOMIC_H
@@ -190,6 +191,35 @@
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
 #endif /* defined(__KERNEL__) */
 
 #endif /* _ASM_ATOMIC_H */

--Boundary_(ID_r1dw2UNqdSrt6f+6lNWrjw)--
