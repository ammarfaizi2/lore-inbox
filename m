Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266255AbUAVM6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 07:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266256AbUAVM6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 07:58:15 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:33431 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266255AbUAVM5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 07:57:55 -0500
Subject: Races in sleep_on()
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040122005436.5895d7bb.akpm@osdl.org>
References: <E1AjOdk-0000pG-Ah@thunk.org> <874qup9dml.fsf@rover.gag.com>
	 <20040121231522.GC3780@thunk.org>
	 <1074757117.16045.201.camel@imladris.demon.co.uk>
	 <20040122083643.GM1016@holomorphy.com>
	 <1074760818.16750.1026.camel@hades.cambridge.redhat.com>
	 <20040122005436.5895d7bb.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074776272.28136.64.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Thu, 22 Jan 2004 12:57:52 +0000
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-22 at 00:54 -0800, Andrew Morton wrote:
> > Yes. That's why I advocated the BUG_ON(!BKL) a _long_ time ago. Arjan
> > had a huge list of bogus callers even in 2.4. 
> 
> So...  do me a patch which does a WARN_ON()?  Make sure that it shuts
> itself up after the first five messages so people don't hate us too much.
> 
> To get best coverage you'll need to make the !CONFIG_SMP&&!CONFIG_PREEMPT
> version of lock_kernel() set a flag or something.

Since the spinlock is a NOP anyway there doesn't seem to be any harm in
just letting the UP version use the same code as the SMP/PREEMPT
versions. 

I've done the _timeout versions too, despite the frequent whinge that
'it's OK if we miss wakeups because we time out eventually anyway'. That
argument was never acceptable to me anyway.

===== include/linux/smp_lock.h 1.7 vs edited =====
--- 1.7/include/linux/smp_lock.h	Mon Jan 19 23:38:11 2004
+++ edited/include/linux/smp_lock.h	Thu Jan 22 09:15:17 2004
@@ -5,7 +5,9 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+#define BKL_DEBUG /* For testing for sleep_on() abuse */
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT) || defined(BKL_DEBUG)
 
 extern spinlock_t kernel_flag;
 
===== kernel/sched.c 1.236 vs edited =====
--- 1.236/kernel/sched.c	Mon Jan 19 23:38:12 2004
+++ edited/kernel/sched.c	Thu Jan 22 10:49:55 2004
@@ -1903,10 +1903,21 @@
 	__remove_wait_queue(q, &wait);			\
 	spin_unlock_irqrestore(&q->lock, flags);
 
+#define SLEEP_ON_BKLCHECK				\
+	if (unlikely(!kernel_locked()) &&		\
+	    sleep_on_bkl_warnings < 10) {		\
+		sleep_on_bkl_warnings++;		\
+		WARN_ON(1);				\
+	}
+
+static int sleep_on_bkl_warnings;
+
 void interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
+	SLEEP_ON_BKLCHECK
+
 	current->state = TASK_INTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
@@ -1920,6 +1931,8 @@
 {
 	SLEEP_ON_VAR
 
+	SLEEP_ON_BKLCHECK
+
 	current->state = TASK_INTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
@@ -1935,6 +1948,8 @@
 {
 	SLEEP_ON_VAR
 
+	SLEEP_ON_BKLCHECK
+
 	current->state = TASK_UNINTERRUPTIBLE;
 
 	SLEEP_ON_HEAD
@@ -1947,6 +1962,8 @@
 long sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
+
+	SLEEP_ON_BKLCHECK
 
 	current->state = TASK_UNINTERRUPTIBLE;
 


-- 
dwmw2

