Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVATMJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVATMJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 07:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVATMJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 07:09:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:46473 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262130AbVATMJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 07:09:15 -0500
Date: Thu, 20 Jan 2005 13:09:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/3] spinlock fix #3: type-checking spinlock primitives, x86
Message-ID: <20050120120905.GA3493@elte.hu>
References: <20050120114317.GA29876@elte.hu> <20050120115947.GA31305@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120115947.GA31305@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch would have caught the bug in -BK-curr (that patch #1 fixes),
via a compiler warning. Test-built/booted on x86.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -36,7 +36,10 @@ typedef struct {
 
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
 
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
+static inline void spin_lock_init(spinlock_t *lock)
+{
+	*lock = SPIN_LOCK_UNLOCKED;
+}
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
@@ -45,8 +48,17 @@ typedef struct {
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
+static inline int spin_is_locked(spinlock_t *lock)
+{
+	return *(volatile signed char *)(&lock->lock) <= 0;
+}
+
+static inline void spin_unlock_wait(spinlock_t *lock)
+{
+	do {
+		barrier();
+	} while (spin_is_locked(lock));
+}
 
 #define spin_lock_string \
 	"\n1:\t" \
