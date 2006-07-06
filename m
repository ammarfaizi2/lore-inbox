Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWGFI2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWGFI2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWGFI2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:28:15 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4013 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965018AbWGFI2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:28:14 -0400
Date: Thu, 6 Jul 2006 10:23:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060706082341.GB24492@elte.hu>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: uninline init_waitqueue_*() functions
From: Ingo Molnar <mingo@elte.hu>

uninline more wait.h inline functions.

allyesconfig vmlinux size delta:

  text            data    bss     dec          filename
  20736884        6073834 3075176 29885894     vmlinux.before
  20721009        6073966 3075176 29870151     vmlinux.after

~18 bytes per callsite, 15K of text size (~0.1%) saved.

(as an added bonus this also removes a lockdep annotation.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/wait.h |   29 +++--------------------------
 kernel/wait.c        |   26 ++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 28 deletions(-)

Index: linux/include/linux/wait.h
===================================================================
--- linux.orig/include/linux/wait.h
+++ linux/include/linux/wait.h
@@ -77,32 +77,9 @@ struct task_struct;
 #define __WAIT_BIT_KEY_INITIALIZER(word, bit)				\
 	{ .flags = word, .bit_nr = bit, }
 
-/*
- * lockdep: we want one lock-class for all waitqueue locks.
- */
-extern struct lock_class_key waitqueue_lock_key;
-
-static inline void init_waitqueue_head(wait_queue_head_t *q)
-{
-	spin_lock_init(&q->lock);
-	lockdep_set_class(&q->lock, &waitqueue_lock_key);
-	INIT_LIST_HEAD(&q->task_list);
-}
-
-static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
-{
-	q->flags = 0;
-	q->private = p;
-	q->func = default_wake_function;
-}
-
-static inline void init_waitqueue_func_entry(wait_queue_t *q,
-					wait_queue_func_t func)
-{
-	q->flags = 0;
-	q->private = NULL;
-	q->func = func;
-}
+extern void init_waitqueue_head(wait_queue_head_t *q);
+extern void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p);
+extern void init_waitqueue_func_entry(wait_queue_t *q, wait_queue_func_t func);
 
 static inline int waitqueue_active(wait_queue_head_t *q)
 {
Index: linux/kernel/wait.c
===================================================================
--- linux.orig/kernel/wait.c
+++ linux/kernel/wait.c
@@ -10,9 +10,31 @@
 #include <linux/wait.h>
 #include <linux/hash.h>
 
-struct lock_class_key waitqueue_lock_key;
+void init_waitqueue_head(wait_queue_head_t *q)
+{
+	spin_lock_init(&q->lock);
+	INIT_LIST_HEAD(&q->task_list);
+}
+
+EXPORT_SYMBOL(init_waitqueue_head);
+
+void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
+{
+	q->flags = 0;
+	q->private = p;
+	q->func = default_wake_function;
+}
+
+EXPORT_SYMBOL(init_waitqueue_entry);
+
+void init_waitqueue_func_entry(wait_queue_t *q, wait_queue_func_t func)
+{
+	q->flags = 0;
+	q->private = NULL;
+	q->func = func;
+}
 
-EXPORT_SYMBOL(waitqueue_lock_key);
+EXPORT_SYMBOL(init_waitqueue_func_entry);
 
 void fastcall add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
 {
