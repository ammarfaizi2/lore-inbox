Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268439AbUIPXV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268439AbUIPXV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUIPXG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:06:26 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:24015 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268321AbUIPXFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:05:19 -0400
Date: Thu, 16 Sep 2004 16:03:51 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, lse-tech@lists.sourceforge.net,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Message-Id: <20040916230351.23023.75244.58133@tomahawk.engr.sgi.com>
In-Reply-To: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>
References: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>
Subject: [PATCH 1/3] lockmeter: fixed-up: lockmeter fixes for preempt case
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated lockmeter-preempt-fix.patch.

Signed-off-by: Ray Bryant <raybry@sgi.com>

Index: linux-2.6.9-rc2-mm1/kernel/lockmeter.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/kernel/lockmeter.c	2004-09-16 11:03:05.000000000 -0700
+++ linux-2.6.9-rc2-mm1/kernel/lockmeter.c	2004-09-16 12:03:20.000000000 -0700
@@ -1236,18 +1236,58 @@
 EXPORT_SYMBOL(_write_trylock);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+/*
+ * This could be a long-held lock.  If another CPU holds it for a long time,
+ * and that CPU is not asked to reschedule then *this* CPU will spin on the
+ * lock for a long time, even if *this* CPU is asked to reschedule.
+ *
+ * So what we do here, in the slow (contended) path is to spin on the lock by
+ * hand while permitting preemption.
+ *
+ * Called inside preempt_disable().
+ */
+static inline void __preempt_spin_lock(spinlock_t *lock, void *caller_pc)
+{
+	if (preempt_count() > 1) {
+		_metered_spin_lock(lock, caller_pc);
+		return;
+	}
+
+	do {
+		preempt_enable();
+		while (spin_is_locked(lock))
+			cpu_relax();
+		preempt_disable();
+	} while (!_metered_spin_trylock(lock, caller_pc));
+}
+
 void __lockfunc _spin_lock(spinlock_t *lock)
 {
 	preempt_disable();
 	if (unlikely(!_metered_spin_trylock(lock, __builtin_return_address(0))))
-		__preempt_spin_lock(lock);
+		__preempt_spin_lock(lock, __builtin_return_address(0));
+}
+
+static inline void __preempt_write_lock(rwlock_t *lock, void *caller_pc)
+{
+	if (preempt_count() > 1) {
+		_metered_write_lock(lock, caller_pc);
+		return;
+	}
+
+	do {
+		preempt_enable();
+		while (rwlock_is_locked(lock))
+			cpu_relax();
+		preempt_disable();
+	} while (!_metered_write_trylock(lock,caller_pc));
 }
 
 void __lockfunc _write_lock(rwlock_t *lock)
 {
 	preempt_disable();
 	if (unlikely(!_metered_write_trylock(lock, __builtin_return_address(0))))
-		__preempt_write_lock(lock);
+		__preempt_write_lock(lock, __builtin_return_address(0));
 }
 #else
 void __lockfunc _spin_lock(spinlock_t *lock)
@@ -1458,3 +1498,13 @@
 	return 0;
 }
 EXPORT_SYMBOL(_spin_trylock_bh);
+
+int in_lock_functions(unsigned long addr)
+{
+	/* Linker adds these: start and end of __lockfunc functions */
+	extern char __lock_text_start[], __lock_text_end[];
+
+	return addr >= (unsigned long)__lock_text_start
+	&& addr < (unsigned long)__lock_text_end;
+}
+EXPORT_SYMBOL(in_lock_functions);

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
