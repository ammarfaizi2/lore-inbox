Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWGFJRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWGFJRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWGFJRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:17:23 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:48021 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965119AbWGFJRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:17:22 -0400
Date: Thu, 6 Jul 2006 11:12:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: [patch] uninline init_waitqueue_head()
Message-ID: <20060706091247.GA26933@elte.hu>
References: <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706082341.GB24492@elte.hu> <20060706020257.1e9b621e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706020257.1e9b621e.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> On my x86_64 typicalconfig
> (http://www.zip.com.au/~akpm/linux/patches/stuff/config-x)
> 
> everything inlined:
> 
>    text    data     bss     dec     hex filename
> 4079169  702440  280184 5061793  4d3ca1 vmlinux
> 
> uninline init_waitqueue_head:
> 
> 4076921  702456  280184 5059561  4d33e9 vmlinux
> 
> uninline init_waitqueue_head+init_waitqueue_entry
> 
> box:/usr/src/25> size vmlinux
>    text    data     bss     dec     hex filename
> 4077017  702472  280184 5059673  4d3459 vmlinux
> 
> uninline init_waitqueue_head+init_waitqueue_entry+init_waitqueue_func_entry
> 
> box:/usr/src/25> size vmlinux
>    text    data     bss     dec     hex filename
> 4077128  702496  280184 5059808  4d34e0 vmlinux
> 
> So we only want to uninline init_waitqueue_head().

yeah, i played with that too and concluded that it's a small win on i386
:-) Anyway, updated patch below - i agree that the biggest item is
init_waitqueue_head().

	Ingo

---------------->
Subject: uninline init_waitqueue_head()
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
 include/linux/wait.h |   12 +-----------
 kernel/wait.c        |    8 ++++++--
 2 files changed, 7 insertions(+), 13 deletions(-)

Index: linux/include/linux/wait.h
===================================================================
--- linux.orig/include/linux/wait.h
+++ linux/include/linux/wait.h
@@ -77,17 +77,7 @@ struct task_struct;
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
+extern void init_waitqueue_head(wait_queue_head_t *q);
 
 static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
 {
Index: linux/kernel/wait.c
===================================================================
--- linux.orig/kernel/wait.c
+++ linux/kernel/wait.c
@@ -10,9 +10,13 @@
 #include <linux/wait.h>
 #include <linux/hash.h>
 
-struct lock_class_key waitqueue_lock_key;
+void init_waitqueue_head(wait_queue_head_t *q)
+{
+	spin_lock_init(&q->lock);
+	INIT_LIST_HEAD(&q->task_list);
+}
 
-EXPORT_SYMBOL(waitqueue_lock_key);
+EXPORT_SYMBOL(init_waitqueue_head);
 
 void fastcall add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
 {
