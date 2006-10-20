Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945913AbWJTNPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945913AbWJTNPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946094AbWJTNPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:15:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:31623 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1945913AbWJTNPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:15:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=C+yMVNKvSZkxoHgmx8/8wQd/t/fQoLOS2OmtCSwXO39vo5KiI+uZrTxfAyc6a02BvCiBuKyZOIAAvwXbERQNlA9HoLzU2+czscwKRqoIYeZ9gkyZ8a4T+1N67T/ZzIxMHFV9m0k/kE7Yeq20KXe324+QJV1d48KxA0D38bpaE9s=
Date: Fri, 20 Oct 2006 17:15:44 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Enforce "unsigned long flags;" when spinlocking
Message-ID: <20061020131544.GC17199@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make it break or warn if you pass to spin_lock_irqsave() and friends
something different from "unsigned long flags;". Suprisingly large amount of
these was caught by recent commit c53421b18f205c5f97c604ae55c6a921f034b0f6 .

Idea is largely from FRV typechecking.

Note #1: checking with sparse is still needed, because a driver can save and
         pass around flags or something. So far patch is very intrusive.
Note #2: techically, we should break only if sizeof(flags) < sizeof(unsigned long),
         but hey, there is opportunity to escalate. Thus !=
Note #3: yes, would break every single buggy out-of-tree module.

Signed-off-by: Alexey "altruistic today" Dobriyan <adobriyan@gmail.com>
---

 include/linux/irqflags.h |   11 ++++++-
 include/linux/spinlock.h |   68 ++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 65 insertions(+), 14 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -49,11 +49,18 @@ #define local_irq_enable() \
 	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
 #define local_irq_disable() \
 	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
-#define local_irq_save(flags) \
-	do { raw_local_irq_save(flags); trace_hardirqs_off(); } while (0)
+#define local_irq_save(flags)						\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		raw_local_irq_save(flags);				\
+		trace_hardirqs_off();					\
+	} while (0)
 
 #define local_irq_restore(flags)				\
 	do {							\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
 		if (raw_irqs_disabled_flags(flags)) {		\
 			raw_local_irq_restore(flags);		\
 			trace_hardirqs_off();			\
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -183,13 +183,43 @@ #define write_lock(lock)		_write_lock(lo
 #define read_lock(lock)			_read_lock(lock)
 
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-#define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
-#define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
-#define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
+#define spin_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		flags = _spin_lock_irqsave(lock);			\
+	} while (0);
+#define read_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		flags = _read_lock_irqsave(lock);			\
+	} while (0)
+#define write_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		flags = _write_lock_irqsave(lock);			\
+	} while (0)
 #else
-#define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
-#define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
-#define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)
+#define spin_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		_spin_lock_irqsave(lock, flags);			\
+	} while (0)
+#define read_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		_read_lock_irqsave(lock, flags);			\
+	} while (0)
+#define write_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		_write_lock_irqsave(lock, flags);			\
+	} while (0)
 #endif
 
 #define spin_lock_irq(lock)		_spin_lock_irq(lock)
@@ -224,22 +254,36 @@ # define write_unlock_irq(lock) \
     do { __raw_write_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
 #endif
 
-#define spin_unlock_irqrestore(lock, flags) \
-					_spin_unlock_irqrestore(lock, flags)
+#define spin_unlock_irqrestore(lock, flags)				\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		_spin_unlock_irqrestore(lock, flags);			\
+	} while (0)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
 
-#define read_unlock_irqrestore(lock, flags) \
-					_read_unlock_irqrestore(lock, flags)
+#define read_unlock_irqrestore(lock, flags)				\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		_read_unlock_irqrestore(lock, flags);			\
+	} while (0)
 #define read_unlock_bh(lock)		_read_unlock_bh(lock)
 
-#define write_unlock_irqrestore(lock, flags) \
-					_write_unlock_irqrestore(lock, flags)
+#define write_unlock_irqrestore(lock, flags)				\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+		_write_unlock_irqrestore(lock, flags);			\
+	} while (0)
 #define write_unlock_bh(lock)		_write_unlock_bh(lock)
 
 #define spin_trylock_bh(lock)	__cond_lock(lock, _spin_trylock_bh(lock))
 
 #define spin_trylock_irq(lock) \
 ({ \
+	BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+	typecheck(unsigned long, flags);			\
 	local_irq_disable(); \
 	spin_trylock(lock) ? \
 	1 : ({ local_irq_enable(); 0;  }); \

