Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUCEHpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 02:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUCEHpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 02:45:46 -0500
Received: from neon.tcs.hut.fi ([130.233.215.20]:29203 "EHLO neon.tcs.hut.fi")
	by vger.kernel.org with ESMTP id S262044AbUCEHpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 02:45:43 -0500
Date: Fri, 5 Mar 2004 09:45:41 +0200 (EET)
From: Ville Nuorvala <vnuorval@tcs.hut.fi>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.4-rc2]: define __attribute_const__ for userspace includes
Message-ID: <Pine.LNX.4.58.0403050855200.18470@rhea.tcs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since at least the __attribute_const__ macro leaks into userspace via
include/linux/if_tunnel.h, it causes a syntax error unless it is defined
outside the #ifdef __KERNEL__ block in include/linux/compiler.h.

The patch below fixes this (and possibly other similar cases).

Thanks,
Ville

===== include/linux/compiler.h 1.23 vs edited =====
--- 1.23/include/linux/compiler.h	Thu Feb 19 08:54:05 2004
+++ edited/include/linux/compiler.h	Fri Mar  5 09:22:08 2004
@@ -39,6 +39,20 @@
 #define likely(x)	__builtin_expect(!!(x), 1)
 #define unlikely(x)	__builtin_expect(!!(x), 0)

+/* Optimization barrier */
+#ifndef barrier
+# define barrier() __memory_barrier()
+#endif
+
+#ifndef RELOC_HIDE
+# define RELOC_HIDE(ptr, off)					\
+  ({ unsigned long __ptr;					\
+     __ptr = (unsigned long) (ptr);				\
+    (typeof(ptr)) (__ptr + (off)); })
+#endif
+
+#endif /* __KERNEL__ */
+
 /*
  * Allow us to mark functions as 'deprecated' and have gcc emit a nice
  * warning for each use, in hopes of speeding the functions removal.
@@ -99,19 +113,5 @@
 #ifndef noinline
 #define noinline
 #endif
-
-/* Optimization barrier */
-#ifndef barrier
-# define barrier() __memory_barrier()
-#endif
-
-#ifndef RELOC_HIDE
-# define RELOC_HIDE(ptr, off)					\
-  ({ unsigned long __ptr;					\
-     __ptr = (unsigned long) (ptr);				\
-    (typeof(ptr)) (__ptr + (off)); })
-#endif
-
-#endif /* __KERNEL__ */

 #endif /* __LINUX_COMPILER_H */

--
Ville Nuorvala
Research Assistant, Institute of Digital Communications,
Helsinki University of Technology
email: vnuorval@tcs.hut.fi, phone: +358 (0)9 451 5257
