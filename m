Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934531AbWKXKE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934531AbWKXKE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 05:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934529AbWKXKE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 05:04:27 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:15764 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S934533AbWKXKE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 05:04:26 -0500
Subject: [PATCH] Add missing spin_lock_irqsave_nested
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-8BU+aT/Kg7pK8SK5tUjV"
Date: Fri, 24 Nov 2006 11:04:48 +0100
Message-Id: <1164362688.28284.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8BU+aT/Kg7pK8SK5tUjV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

the latest tree has a change in net/irda/irlmp.c that uses the lockdep
annotation spin_lock_irqsave_nested. The only problem is that the
irqsave variant doesn't exists at the moment.

The attached patch is an attempt to fix this. It is only compile tested
and I hope that I did everything right. Please double-check, because I
don't touch these parts of the kernel code very often.

Regards

Marcel


--=-8BU+aT/Kg7pK8SK5tUjV
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

[PATCH] Add missing spin_lock_irqsave_nested

This patch adds the missing spin_lock_irqsave_nested annotation which
is used by net/irda/irlmp.c now.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit 45896a1478804f8849f670dd5ff9dd436a811009
tree 53b1f451f04b45c324178b06e8d386f2f3d2fb60
parent 1abbfb412b1610ec3a7ec0164108cee01191d9f5
author Marcel Holtmann <marcel@holtmann.org> Fri, 24 Nov 2006 11:02:41 +0100
committer Marcel Holtmann <marcel@holtmann.org> Fri, 24 Nov 2006 11:02:41 +0100

 include/linux/spinlock.h         |    2 ++
 include/linux/spinlock_api_smp.h |    2 ++
 include/linux/spinlock_api_up.h  |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index b800d2d..7f2b448 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -175,8 +175,10 @@ #define spin_lock(lock)			_spin_lock(loc
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define spin_lock_nested(lock, subclass) _spin_lock_nested(lock, subclass)
+# define spin_lock_irqsave_nested(lock, flags, subclass) flags = _spin_lock_irqsave_nested(lock, flags, subclass)
 #else
 # define spin_lock_nested(lock, subclass) _spin_lock(lock)
+# define spin_lock_irqsave_nested(lock, flags, subclass) flags = _spin_lock_irqsave(lock)
 #endif
 
 #define write_lock(lock)		_write_lock(lock)
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 8828b81..8a2307c 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -32,6 +32,8 @@ void __lockfunc _read_lock_irq(rwlock_t 
 void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(lock);
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 							__acquires(lock);
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
+							__acquires(lock);
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index 67faa04..76f834d 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -59,6 +59,7 @@ #define _spin_lock_irq(lock)			__LOCK_IR
 #define _read_lock_irq(lock)			__LOCK_IRQ(lock)
 #define _write_lock_irq(lock)			__LOCK_IRQ(lock)
 #define _spin_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
+#define _spin_lock_irqsave_nested(lock, flags, subclass)	__LOCK_IRQSAVE(lock, flags)
 #define _read_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
 #define _write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
 #define _spin_trylock(lock)			({ __LOCK(lock); 1; })

--=-8BU+aT/Kg7pK8SK5tUjV--

