Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422753AbWHXXJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWHXXJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbWHXXJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:09:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:40586 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422753AbWHXXJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:09:03 -0400
Subject: [PATCH] Pass a lock expression to __cond_lock, like __acquire and
	__release
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 16:09:04 -0700
Message-Id: <1156460944.3418.42.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, __acquire and __release take a lock expression, but __cond_lock
takes only a condition, not the lock acquired if the expression evaluates to
true.  Change __cond_lock to accept a lock expression, and change all the
callers to pass in a lock expression.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 include/linux/compiler.h |    4 ++--
 include/linux/spinlock.h |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 9b4f110..b3963cf 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -14,7 +14,7 @@ # define __acquires(x)	__attribute__((co
 # define __releases(x)	__attribute__((context(1,0)))
 # define __acquire(x)	__context__(1)
 # define __release(x)	__context__(-1)
-# define __cond_lock(x)	((x) ? ({ __context__(1); 1; }) : 0)
+# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 extern void __chk_user_ptr(void __user *);
 extern void __chk_io_ptr(void __iomem *);
 #else
@@ -31,7 +31,7 @@ # define __acquires(x)
 # define __releases(x)
 # define __acquire(x) (void)0
 # define __release(x) (void)0
-# define __cond_lock(x) (x)
+# define __cond_lock(x,c) (c)
 #endif
 
 #ifdef __KERNEL__
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 31473db..6c1a489 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -167,9 +167,9 @@ #define write_can_lock(rwlock)		__raw_wr
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
  * methods are defined as nops in the case they are not required.
  */
-#define spin_trylock(lock)		__cond_lock(_spin_trylock(lock))
-#define read_trylock(lock)		__cond_lock(_read_trylock(lock))
-#define write_trylock(lock)		__cond_lock(_write_trylock(lock))
+#define spin_trylock(lock)		__cond_lock(lock, _spin_trylock(lock))
+#define read_trylock(lock)		__cond_lock(lock, _read_trylock(lock))
+#define write_trylock(lock)		__cond_lock(lock, _write_trylock(lock))
 
 #define spin_lock(lock)			_spin_lock(lock)
 
@@ -236,7 +236,7 @@ #define write_unlock_irqrestore(lock, fl
 					_write_unlock_irqrestore(lock, flags)
 #define write_unlock_bh(lock)		_write_unlock_bh(lock)
 
-#define spin_trylock_bh(lock)		__cond_lock(_spin_trylock_bh(lock))
+#define spin_trylock_bh(lock)	__cond_lock(lock, _spin_trylock_bh(lock))
 
 #define spin_trylock_irq(lock) \
 ({ \
@@ -264,7 +264,7 @@ #include <asm/atomic.h>
  */
 extern int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
 #define atomic_dec_and_lock(atomic, lock) \
-		__cond_lock(_atomic_dec_and_lock(atomic, lock))
+		__cond_lock(lock, _atomic_dec_and_lock(atomic, lock))
 
 /**
  * spin_can_lock - would spin_trylock() succeed?
-- 
1.4.1.1


