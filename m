Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUEZHKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUEZHKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265330AbUEZHKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:10:05 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:65514 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265314AbUEZHJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:09:59 -0400
Date: Wed, 26 May 2004 03:11:07 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Keith Owens <kaos@sgi.com>
Subject: [PATCH][2.6-mm] i386: enable interrupts on contention in spin_lock_irq
Message-ID: <Pine.LNX.4.58.0405260250310.1794@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This little bit was missing from the previous patch. It will enable
interrupts whilst a cpu is spinning on a lock in spin_lock_irq as well as
spin_lock_irqsave. UP/SMP compile and runtime/stress tested on i386,
UP/SMP compile tested on amd64.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

 include/asm-i386/spinlock.h |    1 +
 include/linux/spinlock.h    |    9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6.6-mm5/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm5/include/asm-i386/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.6-mm5/include/asm-i386/spinlock.h	22 May 2004 16:45:24 -0000	1.1.1.1
+++ linux-2.6.6-mm5/include/asm-i386/spinlock.h	26 May 2004 05:36:34 -0000
@@ -174,6 +174,7 @@ here:
 		:"=m" (lock->lock) : : "memory");
 }

+#define _raw_spin_lock_irq(lock)	_raw_spin_lock_flags(lock, X86_EFLAGS_IF)
 static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
Index: linux-2.6.6-mm5/include/linux/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm5/include/linux/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.6-mm5/include/linux/spinlock.h	22 May 2004 16:45:22 -0000	1.1.1.1
+++ linux-2.6.6-mm5/include/linux/spinlock.h	26 May 2004 06:36:55 -0000
@@ -44,9 +44,14 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>

+#ifndef _raw_spin_lock_irq
+#define _raw_spin_lock_irq(lock)		_raw_spin_lock(lock)
+#endif
+
 #else

-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define _raw_spin_lock_flags(lock, flags)	_raw_spin_lock(lock)
+#define _raw_spin_lock_irq(lock)		_raw_spin_lock(lock)

 #if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
 # define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
@@ -289,7 +294,7 @@ do { \
 do { \
 	local_irq_disable(); \
 	preempt_disable(); \
-	_raw_spin_lock(lock); \
+	_raw_spin_lock_irq(lock); \
 } while (0)

 #define spin_lock_bh(lock) \
