Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269239AbUINJix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269239AbUINJix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269090AbUINJix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:38:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15808 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269240AbUINJh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:37:56 -0400
Date: Tue, 14 Sep 2004 11:38:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] preempt-lock-need-resched.patch, 2.6.9-rc2
Message-ID: <20040914093855.GA23258@elte.hu>
References: <20040914091529.GA21553@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20040914091529.GA21553@elte.hu>
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


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached preempt-lock-need-resched.patch is ontop of the preempt-smp
and preempt-cleanups patches. It adds lock_need_resched() which is to
check for the necessity of lock-break in a critical section. Used by
later latency-break patches.

tested on x86, should work on all architectures.

	Ingo

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="preempt-lock-need-resched.patch"


the attached preempt-lock-need-resched.patch is ontop of the preempt-smp
and preempt-cleanups patches. It adds lock_need_resched() which is to
check for the necessity of lock-break in a critical section. Used by
later latency-break patches.

tested on x86, should work on all architectures.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -969,6 +972,17 @@ extern int cond_resched_lock(spinlock_t 
 # define need_lockbreak(lock) 0
 #endif
 
+/*
+ * Does a critical section need to be broken due to another
+ * task waiting or preemption being signalled:
+ */
+static inline int lock_need_resched(spinlock_t *lock)
+{
+	if (need_lockbreak(lock) || need_resched())
+		return 1;
+	return 0;
+}
+
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
    callers must hold sighand->siglock.  */

--0OAP2g/MAC+5xKAE--
