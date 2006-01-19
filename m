Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWASN26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWASN26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 08:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbWASN25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 08:28:57 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:57758 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1161146AbWASN25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 08:28:57 -0500
Message-ID: <43CFA5FD.BE1B2978@tv-sign.ru>
Date: Thu, 19 Jan 2006 17:45:17 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] BUILD_LOCK_OPS: cleanup preempt_disable() usage
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the code from:

	preempt_disable();
	for (;;) {
		...
		preempt_disable();
	}
to:
	for (;;) {
		preempt_disable();
		...
	}

which seems more clean to me and saves a couple of bytes for
each function.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15/kernel/spinlock.c~	2005-09-17 18:57:30.000000000 +0400
+++ 2.6.15/kernel/spinlock.c	2006-01-19 19:57:42.000000000 +0300
@@ -179,16 +179,16 @@ EXPORT_SYMBOL(_write_lock);
 #define BUILD_LOCK_OPS(op, locktype)					\
 void __lockfunc _##op##_lock(locktype##_t *lock)			\
 {									\
-	preempt_disable();						\
 	for (;;) {							\
+		preempt_disable();					\
 		if (likely(_raw_##op##_trylock(lock)))			\
 			break;						\
 		preempt_enable();					\
+									\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
 		while (!op##_can_lock(lock) && (lock)->break_lock)	\
 			cpu_relax();					\
-		preempt_disable();					\
 	}								\
 	(lock)->break_lock = 0;						\
 }									\
@@ -199,19 +199,18 @@ unsigned long __lockfunc _##op##_lock_ir
 {									\
 	unsigned long flags;						\
 									\
-	preempt_disable();						\
 	for (;;) {							\
+		preempt_disable();					\
 		local_irq_save(flags);					\
 		if (likely(_raw_##op##_trylock(lock)))			\
 			break;						\
 		local_irq_restore(flags);				\
-									\
 		preempt_enable();					\
+									\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
 		while (!op##_can_lock(lock) && (lock)->break_lock)	\
 			cpu_relax();					\
-		preempt_disable();					\
 	}								\
 	(lock)->break_lock = 0;						\
 	return flags;							\
