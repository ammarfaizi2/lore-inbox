Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWJ3Njx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWJ3Njx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWJ3Njx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:39:53 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:45337 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932182AbWJ3Njw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:39:52 -0500
Subject: [PATCH 1/2] lockdep: spin_lock_irqsave_nested() -v2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Jiri Kosina <jikos@jikos.cz>,
       Marcel Holtmann <marcel@holtmann.org>,
       David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20061030131241.GA1657@ff.dom.local>
References: <20061030131241.GA1657@ff.dom.local>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 14:40:48 +0100
Message-Id: <1162215648.24143.186.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*sigh*, I truly am cursed today :-(

how about this...
---

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: spin_lock_irqsave_nested()

Introduce spin_lock_irqsave_nested(); implementation from:
 http://lkml.org/lkml/2006/6/1/122
Patch from:
 http://lkml.org/lkml/2006/9/13/258

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Jiri Kosina <jikos@jikos.cz>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/spinlock.h         |    6 ++++++
 include/linux/spinlock_api_smp.h |    2 ++
 kernel/spinlock.c                |   22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+)

Index: linux-2.6/include/linux/spinlock_api_smp.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock_api_smp.h
+++ linux-2.6/include/linux/spinlock_api_smp.h
@@ -32,6 +32,8 @@ void __lockfunc _read_lock_irq(rwlock_t 
 void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(lock);
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 							__acquires(lock);
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
+							__acquires(lock);
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
Index: linux-2.6/include/linux/spinlock.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock.h
+++ linux-2.6/include/linux/spinlock.h
@@ -186,10 +186,16 @@ do {								\
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
 #define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)
+#define spin_lock_irqsave_nested(lock, flags, subclass)	_spin_lock_irqsave(lock, flags)
 #endif
 
 #define spin_lock_irq(lock)		_spin_lock_irq(lock)
Index: linux-2.6/kernel/spinlock.c
===================================================================
--- linux-2.6.orig/kernel/spinlock.c
+++ linux-2.6/kernel/spinlock.c
@@ -294,6 +294,28 @@ void __lockfunc _spin_lock_nested(spinlo
 
 EXPORT_SYMBOL(_spin_lock_nested);
 
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
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
+
 #endif
 
 void __lockfunc _spin_unlock(spinlock_t *lock)


