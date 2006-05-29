Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWE2Vdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWE2Vdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWE2Vcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:32:55 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:61368 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751360AbWE2V0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:14 -0400
Date: Mon, 29 May 2006 23:26:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 43/61] lock validator: special locking: completions
Message-ID: <20060529212635.GQ3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (multi-initialized) locking code to the lock validator.
Has no effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
---
 include/linux/completion.h |    6 +-----
 kernel/sched.c             |    8 ++++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

Index: linux/include/linux/completion.h
===================================================================
--- linux.orig/include/linux/completion.h
+++ linux/include/linux/completion.h
@@ -21,11 +21,7 @@ struct completion {
 #define DECLARE_COMPLETION(work) \
 	struct completion work = COMPLETION_INITIALIZER(work)
 
-static inline void init_completion(struct completion *x)
-{
-	x->done = 0;
-	init_waitqueue_head(&x->wait);
-}
+extern void init_completion(struct completion *x);
 
 extern void FASTCALL(wait_for_completion(struct completion *));
 extern int FASTCALL(wait_for_completion_interruptible(struct completion *x));
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -3569,6 +3569,14 @@ __wake_up_sync(wait_queue_head_t *q, uns
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
+void init_completion(struct completion *x)
+{
+	x->done = 0;
+	__init_waitqueue_head(&x->wait);
+}
+
+EXPORT_SYMBOL(init_completion);
+
 void fastcall complete(struct completion *x)
 {
 	unsigned long flags;
