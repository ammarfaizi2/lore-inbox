Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316385AbSETVQw>; Mon, 20 May 2002 17:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316386AbSETVQv>; Mon, 20 May 2002 17:16:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31220 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316385AbSETVQq>; Mon, 20 May 2002 17:16:46 -0400
Subject: [PATCH] 2.4-ac: more scheduler updates (2/3)
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1021928919.925.314.camel@sinai>
Content-Type: multipart/mixed; boundary="=-/KLhwB+aKPbR91f1JIVz"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 May 2002 14:16:22 -0700
Message-Id: <1021929382.9901.4.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/KLhwB+aKPbR91f1JIVz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

This patch further cleans up the notion of maximum priority / maximum RT
priority and sets the stage for the user to set any value they choose. 
This patch does _not_ export any configure settings and it results in
the same object code as before.

If you did not like the previous version of this (which created
configure settings) then hopefully this version should be acceptable. 
It is in 2.5 now.

This depends on the first patch (chunk #1) since we move
sched_find_first_set around.  Otherwise the changes are orthogonal.

Patch is against 2.4.19-pre8-ac5, please apply.

	Robert Love


--=-/KLhwB+aKPbR91f1JIVz
Content-Disposition: attachment; filename=sched-maxrtprio-rml-2.4.19-pre8-ac5-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-maxrtprio-rml-2.4.19-pre8-ac5-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre8-ac5-rml/include/asm-i386/bitops.h linux/include=
/asm-i386/bitops.h
--- linux-2.4.19-pre8-ac5-rml/include/asm-i386/bitops.h	Mon May 20 14:07:09=
 2002
+++ linux/include/asm-i386/bitops.h	Mon May 20 14:08:56 2002
@@ -428,7 +428,7 @@
  * unlikely to be set. It's guaranteed that at least one of the 140
  * bits is cleared.
  */
-static inline int sched_find_first_bit(unsigned long *b)
+static inline int _sched_find_first_bit(unsigned long *b)
 {
 	if (unlikely(b[0]))
 		return __ffs(b[0]);
diff -urN linux-2.4.19-pre8-ac5-rml/include/linux/sched.h linux/include/lin=
ux/sched.h
--- linux-2.4.19-pre8-ac5-rml/include/linux/sched.h	Mon May 20 14:07:07 200=
2
+++ linux/include/linux/sched.h	Mon May 20 14:10:19 2002
@@ -162,6 +162,36 @@
 extern int current_is_keventd(void);
=20
 /*
+ * Priority of a process goes from 0..MAX_PRIO-1, valid RT
+ * priority is 0..MAX_RT_PRIO-1, and SCHED_OTHER tasks are
+ * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
+ * are inverted: lower p->prio value means higher priority.
+ *
+ * The MAX_RT_USER_PRIO value allows the actual maximum
+ * RT priority to be separate from the value exported to
+ * user-space.  This allows kernel threads to set their
+ * priority to a value higher than any user task. Note:
+ * MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
+ */
+
+#define MAX_USER_RT_PRIO	100
+#define MAX_RT_PRIO		MAX_USER_RT_PRIO
+
+#define MAX_PRIO		(MAX_RT_PRIO + 40)
+
+/*
+ * The maximum RT priority is configurable.  If the resulting
+ * bitmap is 160-bits , we can use a hand-coded routine which
+ * is optimal.  Otherwise, we fall back on a generic routine for
+ * finding the first set bit from an arbitrarily-sized bitmap.
+ */
+#if MAX_PRIO < 160 && MAX_PRIO > 127
+#define sched_find_first_bit(map)	_sched_find_first_bit(map)
+#else
+#define sched_find_first_bit(map)	find_first_bit(map, MAX_PRIO)
+#endif
+
+/*
  * The default fd array needs to be at least BITS_PER_LONG,
  * as this is the granularity returned by copy_fdset().
  */
@@ -478,8 +508,8 @@
     addr_limit:		KERNEL_DS,					\
     exec_domain:	&default_exec_domain,				\
     lock_depth:		-1,						\
-    prio:		120,						\
-    static_prio:	120,						\
+    prio:		MAX_PRIO-20,					\
+    static_prio:	MAX_PRIO-20,					\
     policy:		SCHED_OTHER,					\
     cpus_allowed:	-1,						\
     mm:			NULL,						\
diff -urN linux-2.4.19-pre8-ac5-rml/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre8-ac5-rml/kernel/sched.c	Mon May 20 14:07:07 2002
+++ linux/kernel/sched.c	Mon May 20 14:08:47 2002
@@ -26,20 +26,6 @@
 #include <linux/kernel_stat.h>
=20
 /*
- * Priority of a process goes from 0 to 139. The 0-99
- * priority range is allocated to RT tasks, the 100-139
- * range is for SCHED_OTHER tasks. Priority values are
- * inverted: lower p->prio value means higher priority.
- *=20
- * MAX_USER_RT_PRIO allows the actual maximum RT priority
- * to be separate from the value exported to user-space.
- * NOTE: MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
- */
-#define MAX_RT_PRIO		100
-#define MAX_USER_RT_PRIO	100
-#define MAX_PRIO		(MAX_RT_PRIO + 40)
-
-/*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
  * and back.

--=-/KLhwB+aKPbR91f1JIVz--

