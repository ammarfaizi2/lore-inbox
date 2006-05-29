Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWE2Vcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWE2Vcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWE2V0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:26:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:185 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751367AbWE2V0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:18 -0400
Date: Mon, 29 May 2006 23:26:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 44/61] lock validator: special locking: waitqueues
Message-ID: <20060529212639.GR3155@elte.hu>
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

map special (multi-initialized) locking code to the lock validator.
Has no effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
---
 include/linux/wait.h |   11 +++++++++--
 kernel/wait.c        |    9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

Index: linux/include/linux/wait.h
===================================================================
--- linux.orig/include/linux/wait.h
+++ linux/include/linux/wait.h
@@ -77,12 +77,19 @@ struct task_struct;
 #define __WAIT_BIT_KEY_INITIALIZER(word, bit)				\
 	{ .flags = word, .bit_nr = bit, }
 
-static inline void init_waitqueue_head(wait_queue_head_t *q)
+/*
+ * lockdep: we want one lock-type for all waitqueue locks.
+ */
+extern struct lockdep_type_key waitqueue_lock_key;
+
+static inline void __init_waitqueue_head(wait_queue_head_t *q)
 {
-	spin_lock_init(&q->lock);
+	spin_lock_init_key(&q->lock, &waitqueue_lock_key);
 	INIT_LIST_HEAD(&q->task_list);
 }
 
+extern void init_waitqueue_head(wait_queue_head_t *q);
+
 static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
 {
 	q->flags = 0;
Index: linux/kernel/wait.c
===================================================================
--- linux.orig/kernel/wait.c
+++ linux/kernel/wait.c
@@ -11,6 +11,15 @@
 #include <linux/wait.h>
 #include <linux/hash.h>
 
+struct lockdep_type_key waitqueue_lock_key;
+
+void init_waitqueue_head(wait_queue_head_t *q)
+{
+	__init_waitqueue_head(q);
+}
+
+EXPORT_SYMBOL(init_waitqueue_head);
+
 void fastcall add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
 {
 	unsigned long flags;
