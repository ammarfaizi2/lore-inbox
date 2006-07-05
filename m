Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWGEIxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWGEIxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGEIxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:53:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:65162 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932411AbWGEIxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:53:52 -0400
Date: Wed, 5 Jul 2006 10:49:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705084914.GA8798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: uninline init_waitqueue_*() functions
From: Ingo Molnar <mingo@elte.hu>

some wait.h inlines are way too large: init_waitqueue_entry() and
init_waitqueue_func_entry() generate 20-30 bytes of inlined code
per call site, and init_waitqueue_head() is 30-40 bytes (on x86).

allyesconfig vmlinux size delta:

  text            data    bss     dec          filename
  21459355        6286210 4520408 32265973     vmlinux.before
  21424564        6281246 4516912 32222722     vmlinux.after

So 34K (0.16%) of kernel text saved. Not too bad.

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
