Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316624AbSEQRcR>; Fri, 17 May 2002 13:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316625AbSEQRcQ>; Fri, 17 May 2002 13:32:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46067 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316624AbSEQRcP>; Fri, 17 May 2002 13:32:15 -0400
Subject: [PATCH] 2.4-ac: user-configurable maximum RT priorities
From: Robert Love <rml@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Content-Type: multipart/mixed; boundary="=-cewViXG9sV2KVPi7eqwI"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 May 2002 10:32:15 -0700
Message-Id: <1021656735.6754.95.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cewViXG9sV2KVPi7eqwI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached patch, against 2.4.19-pre8-ac4, creates a compile-time choice
for setting the maximum user and kernel (now separate) real-time
priority.  The patch also does the work of making sure these values are
honored - i.e., cleaning up magic numbers - but most of that was done in
my original MAX_PRIO cleanup.

The maximum user-space exported RT priority is MAX_USER_RT_PRIO and is
set via CONFIG_MAX_USER_RT_PRIO.  It defaults to 100 and has a maximum
of (arbitrarily) 1000.  Anything outside these ranges will be silently
rounded accordingly.  The default RT prios are 0..99 - thus this will
allow priorities to go to 0..999 if desired.

The maximum kernel RT priority is MAX_RT_PRIO and is set via
CONFIG_MAX_RT_PRIO.  It is the absolute maximum priority and is not
exported to user-space.  The configure setting is actually an offset
from MAX_USER_RT_PRIO and thus defaults to zero (i.e. they are the
same).  The maximum allowed is 200.  This would be useful for giving
kernel threads higher priorities than any existing user task.  This
change is possible by the MAX_RT_PRIO cleanup Ingo and I did.

Setting these higher will not break anything but obviously applications
will need to explicit ask for the new priorities.  Since the user is not
allowed to set them lower, there is no risk of breakage.  Since
increasing the priority space increases the size of the priority bitmap,
there is an increase in scheduling overhead.  I have not measured it but
I assume it is negligible.  People who are interested in more real-time
priorities typically have lots of RT tasks, and thus the size of the
bitmask is less relevant since the first bit will always be set early.

Applying this patch and accepting the defaults results in the same
object code as previous.  Those desiring higher values can make the
changes accordingly.  Enjoy.

	Robert Love



--=-cewViXG9sV2KVPi7eqwI
Content-Disposition: attachment;
	filename=sched-configurable-priorities-rml-2.4.19-pre8-ac4-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch;
	name=sched-configurable-priorities-rml-2.4.19-pre8-ac4-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre8-ac4/Documentation/Configure.help linux/Document=
ation/Configure.help
--- linux-2.4.19-pre8-ac4/Documentation/Configure.help	Wed May 15 12:53:48 =
2002
+++ linux/Documentation/Configure.help	Thu May 16 16:11:33 2002
@@ -3945,6 +3945,38 @@
   you have use for it; the module is called binfmt_misc.o. If you
   don't know what to answer at this point, say Y.
=20
+Maximum User Real-Time Priority
+CONFIG_MAX_USER_RT_PRIO
+  The maximum user real-time priority. Tasks with priorities from
+  zero through one less than this value are scheduled as real-time.
+  To the application, a higher priority value implies a higher
+  priority task.
+
+  The minimum allowed value is 100 and the maximum allowed value
+  is (arbitrary) 1000. Values specified outside this range will
+  be rounded accordingly during compile-time. The default is 100.
+  Setting this higher than 100 is safe but will result in slightly
+  more processing overhead in the scheduler.=20
+
+  Unless you are doing specialized real-time computing and require
+  a much larger range than usual, the default is fine.
+
+Maximum Kernel Real-Time Priority
+CONFIG_MAX_RT_PRIO
+  The difference between the maximum real-time priority and the
+  maximum user real-time priority.  Usually this value is zero,
+  which sets the maximum real-time priority to the same as the
+  maximum user real-time priority.  Setting this higher,
+  however, will allow kernel threads to set their priority to a
+  value higher than any user task. This is safe, but will result
+  in slightly more processing overhead in the scheduler.
+
+  This value can be at most 200.  The default is zero, i.e. the
+  maximum priority and maximum user priority are the same.
+
+  Unless you are doing specialized real-time programming with
+  kernel threads, the default is fine.
+
 Kernel support for JAVA binaries
 CONFIG_BINFMT_JAVA
   If you say Y here, the kernel will load and execute Java J-code
diff -urN linux-2.4.19-pre8-ac4/arch/i386/config.in linux/arch/i386/config.=
in
--- linux-2.4.19-pre8-ac4/arch/i386/config.in	Wed May 15 12:53:43 2002
+++ linux/arch/i386/config.in	Thu May 16 16:11:52 2002
@@ -271,6 +271,8 @@
=20
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
+int 'Maximum User Real-Time Priority' CONFIG_MAX_USER_RT_PRIO 100
+int 'Maximum Kernel Real-time Priority' CONFIG_MAX_RT_PRIO 0
 bool 'Sysctl support' CONFIG_SYSCTL
 if [ "$CONFIG_PROC_FS" =3D "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
diff -urN linux-2.4.19-pre8-ac4/include/asm-i386/mmu_context.h linux/includ=
e/asm-i386/mmu_context.h
--- linux-2.4.19-pre8-ac4/include/asm-i386/mmu_context.h	Wed May 15 12:53:4=
2 2002
+++ linux/include/asm-i386/mmu_context.h	Thu May 16 16:35:53 2002
@@ -12,7 +12,7 @@
  * unlikely to be set. It's guaranteed that at least one of the 140
  * bits is cleared.
  */
-static inline int sched_find_first_bit(unsigned long *b)
+static inline int _sched_find_first_bit(unsigned long *b)
 {
 	if (unlikely(b[0]))
 		return __ffs(b[0]);
diff -urN linux-2.4.19-pre8-ac4/include/linux/sched.h linux/include/linux/s=
ched.h
--- linux-2.4.19-pre8-ac4/include/linux/sched.h	Wed May 15 12:53:42 2002
+++ linux/include/linux/sched.h	Thu May 16 16:35:22 2002
@@ -163,6 +163,51 @@
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
+ *
+ * Both values are configurable at compile-time.
+ */
+
+#if CONFIG_MAX_USER_RT_PRIO < 100
+#define MAX_USER_RT_PRIO	100
+#elif CONFIG_MAX_USER_RT_PRIO > 1000
+#define MAX_USER_RT_PRIO	1000
+#else
+#define MAX_USER_RT_PRIO	CONFIG_MAX_USER_RT_PRIO
+#endif
+
+#if CONFIG_MAX_RT_PRIO < 0
+#define MAX_RT_PRIO		MAX_USER_RT_PRIO
+#elif CONFIG_MAX_RT_PRIO > 200
+#define MAX_RT_PRIO		(MAX_USER_RT_PRIO + 200)
+#else
+#define MAX_RT_PRIO		(MAX_USER_RT_PRIO + CONFIG_MAX_RT_PRIO)
+#endif
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
@@ -479,8 +524,8 @@
     addr_limit:		KERNEL_DS,					\
     exec_domain:	&default_exec_domain,				\
     lock_depth:		-1,						\
-    prio:		120,						\
-    static_prio:	120,						\
+    prio:		MAX_PRIO - 20,					\
+    static_prio:	MAX_PRIO - 20,					\
     policy:		SCHED_OTHER,					\
     cpus_allowed:	-1,						\
     mm:			NULL,						\
diff -urN linux-2.4.19-pre8-ac4/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre8-ac4/kernel/sched.c	Wed May 15 12:53:42 2002
+++ linux/kernel/sched.c	Thu May 16 16:08:35 2002
@@ -22,20 +22,6 @@
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

--=-cewViXG9sV2KVPi7eqwI--

