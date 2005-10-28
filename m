Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVJ1HBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVJ1HBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVJ1HBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:01:10 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:32684 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S965136AbVJ1HBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:01:01 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.14-rc-mm1 include/linux/spinlock_up.h: make compilable without CONFIG_DEBUG_SPINLOCK
Date: Thu, 27 Oct 2005 23:53:46 -0700
Message-ID: <001301c5db8c$59279d80$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.14-rc5-mm1 code fails to compile on a uniprocessor
system if CONFIG_DEBUG_SPINLOCK is not specified.  This seems
to be a simple error in the (MM) spinlock_up.h header where the
_raw_{read,write}_unlock macros are defined only in the DEBUG
branch, yet, in MM, are required in all cases.

The patch will apply cleanly to both 2.6.14 and 2.6.14-rc5-mm1,
however it is not required in 2.6.14 (though it seems to do no
harm).  The patch is confusing because it (effectively) moves
the #endif up rather than moving the _raw macros down.

Signed-off-by: John Bowler <jbowler@acm.org>

--- linux-2.6.14-rc5/include/linux/spinlock_up.h	2005-10-26 08:37:20.164248408 -0700
+++ patched/include/linux/spinlock_up.h	2005-10-26 12:15:13.458898975 -0700
@@ -47,6 +47,14 @@ static inline void __raw_spin_unlock(raw
 	lock->slock = 1;
 }
 
+#else /* DEBUG_SPINLOCK */
+#define __raw_spin_is_locked(lock)	((void)(lock), 0)
+/* for sched.c and kernel_lock.c: */
+# define __raw_spin_lock(lock)		do { (void)(lock); } while (0)
+# define __raw_spin_unlock(lock)	do { (void)(lock); } while (0)
+# define __raw_spin_trylock(lock)	({ (void)(lock); 1; })
+#endif /* DEBUG_SPINLOCK */
+
 /*
  * Read-write spinlocks. No debug version.
  */
@@ -57,14 +65,6 @@ static inline void __raw_spin_unlock(raw
 #define __raw_read_unlock(lock)		do { (void)(lock); } while (0)
 #define __raw_write_unlock(lock)	do { (void)(lock); } while (0)
 
-#else /* DEBUG_SPINLOCK */
-#define __raw_spin_is_locked(lock)	((void)(lock), 0)
-/* for sched.c and kernel_lock.c: */
-# define __raw_spin_lock(lock)		do { (void)(lock); } while (0)
-# define __raw_spin_unlock(lock)	do { (void)(lock); } while (0)
-# define __raw_spin_trylock(lock)	({ (void)(lock); 1; })
-#endif /* DEBUG_SPINLOCK */
-
 #define __raw_read_can_lock(lock)	(((void)(lock), 1))
 #define __raw_write_can_lock(lock)	(((void)(lock), 1))
 

