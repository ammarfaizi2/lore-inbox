Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313925AbSERWMV>; Sat, 18 May 2002 18:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314051AbSERWMU>; Sat, 18 May 2002 18:12:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61174 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S313925AbSERWMS>; Sat, 18 May 2002 18:12:18 -0400
Subject: Re: [PATCH] 2.5: user-configurable maximum RT priorities
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1021667491.920.120.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 May 2002 15:12:18 -0700
Message-Id: <1021759938.6754.193.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For 2.5.16, Linus took the main chunk of the user-configurable maximum
RT priorities patch.  The configure code to export a setting was not
exported, however.

For those interested, this patch creates configure items and associated
help to allow seamless compile-time setting of both the maximum priority
and the maximum RT priority exported to user-space.

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
kernel threads higher priorities than any existing user task.

This patch is against 2.5.16.  Enjoy,

	Robert Love

diff -urN linux-2.5.16/include/asm-i386/bitops.h linux/include/asm-i386/bitops.h
--- linux-2.5.16/include/asm-i386/bitops.h	Sat May 18 00:46:07 2002
+++ linux/include/asm-i386/bitops.h	Sat May 18 15:03:20 2002
@@ -422,7 +422,7 @@
  * unlikely to be set. It's guaranteed that at least one of the 140
  * bits is cleared.
  */
-static inline int sched_find_first_bit(unsigned long *b)
+static inline int _sched_find_first_bit(unsigned long *b)
 {
 	if (unlikely(b[0]))
 		return __ffs(b[0]);
diff -urN linux-2.5.16/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.16/include/linux/sched.h	Sat May 18 00:45:57 2002
+++ linux/include/linux/sched.h	Sat May 18 15:03:21 2002
@@ -217,13 +217,40 @@
  * user-space.  This allows kernel threads to set their
  * priority to a value higher than any user task. Note:
  * MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
+ *
+ * Both values are configurable at compile-time.
  */
 
+#if CONFIG_MAX_USER_RT_PRIO < 100
 #define MAX_USER_RT_PRIO	100
+#elif CONFIG_MAX_USER_RT_PRIO > 1000
+#define MAX_USER_RT_PRIO	1000
+#else
+#define MAX_USER_RT_PRIO	CONFIG_MAX_USER_RT_PRIO
+#endif
+
+#if CONFIG_MAX_RT_PRIO < 0
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
+#elif CONFIG_MAX_RT_PRIO > 200
+#define MAX_RT_PRIO		(MAX_USER_RT_PRIO + 200)
+#else
+#define MAX_RT_PRIO		(MAX_USER_RT_PRIO + CONFIG_MAX_RT_PRIO)
+#endif
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
- 
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
 /*
  * Some day this will be a full-fledged user tracking system..
  */
diff -urN linux-2.5.16/init/Config.help linux/init/Config.help
--- linux-2.5.16/init/Config.help	Sat May 18 00:45:56 2002
+++ linux/init/Config.help	Sat May 18 15:03:21 2002
@@ -80,6 +80,36 @@
   building a kernel for install/rescue disks or your system is very
   limited in memory.
 
+Maximum User Real-Time Priority
+  The maximum user real-time priority. Tasks with priorities from
+  zero through one less than this value are scheduled as real-time.
+  To the application, a higher priority value implies a higher
+  priority task.
+
+  The minimum allowed value is 100 and the maximum allowed value
+  is (arbitrary) 1000. Values specified outside this range will
+  be rounded accordingly during compile-time. The default is 100.
+  Setting this higher than 100 is safe but will result in slightly
+  more processing overhead in the scheduler. 
+
+  Unless you are doing specialized real-time computing and require
+  a much larger range than usual, the default is fine.
+
+Maximum Kernel Real-Time Priority
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
 CONFIG_MODULES
   Kernel modules are small pieces of compiled code which can be
   inserted in or removed from the running kernel, using the programs
diff -urN linux-2.5.16/init/Config.in linux/init/Config.in
--- linux-2.5.16/init/Config.in	Sat May 18 00:45:58 2002
+++ linux/init/Config.in	Sat May 18 15:03:21 2002
@@ -9,6 +9,8 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+int 'Maximum User Real-Time Priority' CONFIG_MAX_USER_RT_PRIO 100
+int 'Maximum Kernel Real-time Priority' CONFIG_MAX_RT_PRIO 0
 endmenu
 
 mainmenu_option next_comment


