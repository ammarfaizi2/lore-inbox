Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269241AbUINJt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269241AbUINJt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUINJt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:49:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50883 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269241AbUINJtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:49:46 -0400
Date: Tue, 14 Sep 2004 11:51:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched: add cond_resched_softirq()
Message-ID: <20040914095110.GA24094@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20040914093855.GA23258@elte.hu>
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


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch comes after preempt-lock-need-resched.patch.

it adds cond_resched_softirq() which can be used by _process context_
softirqs-disabled codepaths to preempt if necessary. The function will
enable softirqs before scheduling. (Later patches will use this
primitive.)

	Ingo

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-add-cond_resched_softirq.patch"


the attached patch comes after preempt-lock-need-resched.patch.

it adds cond_resched_softirq() which can be used by _process context_
softirqs-disabled codepaths to preempt if necessary. The function will
enable softirqs before scheduling. (Later patches will use this
primitive.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -955,9 +955,12 @@ static inline int need_resched(void)
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
  * value indicates whether a reschedule was done in fact.
+ * cond_resched_lock() will drop the spinlock before scheduling,
+ * cond_resched_softirq() will enable bhs before scheduling.
  */
 extern int cond_resched(void);
 extern int cond_resched_lock(spinlock_t * lock);
+extern int cond_resched_softirq(void);
 
 /*
  * Does a critical section need to be broken due to another
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -3589,6 +3589,22 @@ int cond_resched_lock(spinlock_t * lock)
 
 EXPORT_SYMBOL(cond_resched_lock);
 
+int __sched cond_resched_softirq(void)
+{
+	BUG_ON(!in_softirq());
+
+	if (need_resched()) {
+		__local_bh_enable();
+		__cond_resched();
+		local_bh_disable();
+		return 1;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(cond_resched_softirq);
+
+
 /**
  * yield - yield the current processor to other threads.
  *

--bg08WKrSYDhXBjb5--
