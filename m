Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269701AbUINVST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269701AbUINVST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269722AbUINVPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:15:45 -0400
Received: from holomorphy.com ([207.189.100.168]:36246 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269199AbUINVGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:06:22 -0400
Date: Tue, 14 Sep 2004 14:06:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@ximian.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914210610.GN9106@holomorphy.com>
References: <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095185103.23385.1.camel@betsy.boston.ximian.com> <20040914185212.GY9106@holomorphy.com> <1095188569.23385.11.camel@betsy.boston.ximian.com> <20040914192104.GB9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914192104.GB9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 03:02:49PM -0400, Robert Love wrote:
>> I'd love to just throw away all the BKL users, too, William.  But
>> pragmatism and my cautious sense of reality tells me that the BKL is not
>> going anywhere anytime soon.  We might get it down to 1% of its previous
>> usage, but it is awful intertwined in some places.  It will take some
>> time.

On Tue, Sep 14, 2004 at 12:21:04PM -0700, William Lee Irwin III wrote:
> Far from "just throw away" -- this is hard work! Very hard work, and a
> number of people have already tried and failed.

Well, since sleep_on() and relatives require the BKL for safety and
otherwise are unsafe, here's a patch to mark them deprecated, suggested
by Arjan van de Ven and others. vs. 2.6.9-rc1-mm5. Compiletested on x86-64.


-- wli


Index: mm5-2.6.9-rc1/include/linux/wait.h
===================================================================
--- mm5-2.6.9-rc1.orig/include/linux/wait.h	2004-09-13 16:27:50.000000000 -0700
+++ mm5-2.6.9-rc1/include/linux/wait.h	2004-09-14 13:36:00.766337272 -0700
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/compiler.h>
 #include <asm/system.h>
 #include <asm/current.h>
 
@@ -281,12 +282,33 @@
  * They are racy.  DO NOT use them, use the wait_event* interfaces above.  
  * We plan to remove these interfaces during 2.7.
  */
-extern void FASTCALL(sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
-				      signed long timeout));
-extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
-						    signed long timeout));
+
+void FASTCALL(__sleep_on(wait_queue_head_t *));
+long FASTCALL(__sleep_on_timeout(wait_queue_head_t *, signed long));
+void FASTCALL(__interruptible_sleep_on(wait_queue_head_t *));
+long FASTCALL(__interruptible_sleep_on_timeout(wait_queue_head_t *, signed long));
+
+static inline void __deprecated sleep_on(wait_queue_head_t *q)
+{
+	__sleep_on(q);
+}
+
+static inline long __deprecated
+sleep_on_timeout(wait_queue_head_t *q, signed long timeout)
+{
+	__sleep_on_timeout(q, timeout);
+}
+
+static inline __deprecated void interruptible_sleep_on(wait_queue_head_t *q)
+{
+	__interruptible_sleep_on(q);
+}
+
+static inline long __deprecated
+interruptible_sleep_on_timeout(wait_queue_head_t *q, signed long timeout)
+{
+	__interruptible_sleep_on_timeout(q, timeout);
+}
 
 /*
  * Waitqueues which are removed from the waitqueue_head at wakeup time
Index: mm5-2.6.9-rc1/kernel/sched.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/sched.c	2004-09-14 09:01:46.000000000 -0700
+++ mm5-2.6.9-rc1/kernel/sched.c	2004-09-14 13:36:22.743996160 -0700
@@ -2633,7 +2633,7 @@
 	__remove_wait_queue(q, &wait);			\
 	spin_unlock_irqrestore(&q->lock, flags);
 
-void fastcall __sched interruptible_sleep_on(wait_queue_head_t *q)
+void fastcall __sched __interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -2644,9 +2644,9 @@
 	SLEEP_ON_TAIL
 }
 
-EXPORT_SYMBOL(interruptible_sleep_on);
+EXPORT_SYMBOL(__interruptible_sleep_on);
 
-long fastcall __sched interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long fastcall __sched __interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -2659,9 +2659,9 @@
 	return timeout;
 }
 
-EXPORT_SYMBOL(interruptible_sleep_on_timeout);
+EXPORT_SYMBOL(__interruptible_sleep_on_timeout);
 
-void fastcall __sched sleep_on(wait_queue_head_t *q)
+void fastcall __sched __sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -2672,9 +2672,9 @@
 	SLEEP_ON_TAIL
 }
 
-EXPORT_SYMBOL(sleep_on);
+EXPORT_SYMBOL(__sleep_on);
 
-long fastcall __sched sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long fastcall __sched __sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -2687,7 +2687,7 @@
 	return timeout;
 }
 
-EXPORT_SYMBOL(sleep_on_timeout);
+EXPORT_SYMBOL(__sleep_on_timeout);
 
 void set_user_nice(task_t *p, long nice)
 {
