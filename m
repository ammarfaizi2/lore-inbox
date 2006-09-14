Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWINApi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWINApi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 20:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWINApi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 20:45:38 -0400
Received: from twin.jikos.cz ([213.151.79.26]:62082 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751281AbWINAph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 20:45:37 -0400
Date: Thu, 14 Sep 2006 02:44:20 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [PATCH 2/3] Synaptics - fix lockdep warnings 
In-Reply-To: <Pine.LNX.4.64.0609140239000.22181@twin.jikos.cz>
Message-ID: <Pine.LNX.4.64.0609140240490.22181@twin.jikos.cz>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
 <Pine.LNX.4.64.0609140239000.22181@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces spin_lock_irqsave_nested(), as it is needed when 
annotating nested irqsave-spinlocks for lockdep.

This is needed to cope with serio_interrupt() being recursively called 
from synaptics_pass_pt_packet(). More users could arise.

Implementation stolen from Arjan [1], whose patch didn't make it neither 
into mainline nor -mm.

If applicable, please apply.

[1] http://lkml.org/lkml/2006/6/1/122

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

diff -rup linux-2.6.18-rc6-mm2.orig/include/linux/spinlock_api_smp.h linux-2.6.18-rc6-mm2/include/linux/spinlock_api_smp.h
--- linux-2.6.18-rc6-mm2.orig/include/linux/spinlock_api_smp.h	2006-09-14 00:49:35.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/linux/spinlock_api_smp.h	2006-09-14 01:24:08.000000000 +0200
@@ -32,6 +32,8 @@ void __lockfunc _read_lock_irq(rwlock_t 
 void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(lock);
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 							__acquires(lock);
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
+							__acquires(spinlock_t);
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
diff -rup linux-2.6.18-rc6-mm2.orig/include/linux/spinlock_api_up.h linux-2.6.18-rc6-mm2/include/linux/spinlock_api_up.h
--- linux-2.6.18-rc6-mm2.orig/include/linux/spinlock_api_up.h	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/linux/spinlock_api_up.h	2006-09-14 01:24:05.000000000 +0200
@@ -59,6 +59,7 @@
 #define _read_lock_irq(lock)			__LOCK_IRQ(lock)
 #define _write_lock_irq(lock)			__LOCK_IRQ(lock)
 #define _spin_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
+#define _spin_lock_irqsave_nested(lock, flags, subclass) __LOCK_IRQSAVE(lock, flags, subclass)
 #define _read_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
 #define _write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
 #define _spin_trylock(lock)			({ __LOCK(lock); 1; })
diff -rup linux-2.6.18-rc6-mm2.orig/include/linux/spinlock.h linux-2.6.18-rc6-mm2/include/linux/spinlock.h
--- linux-2.6.18-rc6-mm2.orig/include/linux/spinlock.h	2006-09-14 00:49:35.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/linux/spinlock.h	2006-09-14 01:24:12.000000000 +0200
@@ -186,6 +186,11 @@ do {								\
 #define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
 #define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
 #define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define spin_lock_irqsave_nested(lock, flags, subclass)	flags = _spin_lock_irqsave_nested(lock, subclass)
+#else
+#define spin_lock_irqsave_nested(lock, flags, subclass)	flags = _spin_lock_irqsave(lock)
+#endif
 #else
 #define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
 #define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
diff -rup linux-2.6.18-rc6-mm2.orig/kernel/spinlock.c linux-2.6.18-rc6-mm2/kernel/spinlock.c
--- linux-2.6.18-rc6-mm2.orig/kernel/spinlock.c	2006-09-14 00:49:35.000000000 +0200
+++ linux-2.6.18-rc6-mm2/kernel/spinlock.c	2006-09-14 01:27:17.000000000 +0200
@@ -304,6 +304,27 @@ void __lockfunc _spin_lock_nested(spinlo
 }
 
 EXPORT_SYMBOL(_spin_lock_nested);
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	spin_acquire(&lock->dep_map, subtype, 0, _RET_IP_);
+	/*
+	 * On lockdep we dont want the hand-coded irq-enable of
+	 * _raw_spin_lock_flags() code, because lockdep assumes
+	 * that interrupts are not re-enabled during lock-acquire:
+	 */
+#ifdef CONFIG_PROVE_SPIN_LOCKING
+	_raw_spin_lock(lock);
+#else
+	_raw_spin_lock_flags(lock, &flags);
+#endif
+	return flags;
+}
+
+EXPORT_SYMBOL(_spin_lock_irqsave_nested);
 
 #endif
 
