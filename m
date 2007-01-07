Return-Path: <linux-kernel-owner+w=401wt.eu-S932335AbXAGCPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbXAGCPy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbXAGCPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:15:54 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47926 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335AbXAGCPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:15:53 -0500
Date: Sun, 7 Jan 2007 03:14:40 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@localhost.localdomain
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
In-Reply-To: <20070104192223.GX17561@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0701070311450.5666@localhost.localdomain>
References: <459C4038.6020902@redhat.com> <20070103162643.5c479836.akpm@osdl.org>
 <459D3E8E.7000405@redhat.com> <20070104102659.8c61d510.akpm@osdl.org>
 <459D4897.4020408@redhat.com> <20070104105430.1de994a7.akpm@osdl.org>
 <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk>
 <20070104192223.GX17561@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 4 Jan 2007, Al Viro wrote:

> PS: what would be the sane strategy for timer series merge, BTW?

PPS: I still don't like it. It fixes a rather theoretical problem with 
absolutely no practical relevance.
PPPS: type safety is also possible with container_of(), the prototype 
patch below demonstrates how to check that the signature matches and 
additionally it doesn't require to convert everything at once. More 
sophisticated checks can be done by putting this information into a 
separate section, from where it can be extracted at compile/run time.

bye, Roman

---
 include/linux/timer.h |   24 ++++++++++++++++++++++++
 kernel/timer.c        |   18 +++++++++++++++++-
 kernel/workqueue.c    |   24 ++++++++++--------------
 3 files changed, 51 insertions(+), 15 deletions(-)

Index: linux-2.6-git/include/linux/timer.h
===================================================================
--- linux-2.6-git.orig/include/linux/timer.h	2007-01-06 20:45:02.000000000 +0100
+++ linux-2.6-git/include/linux/timer.h	2007-01-06 21:00:07.000000000 +0100
@@ -13,16 +13,40 @@ struct timer_list {
 
 	void (*function)(unsigned long);
 	unsigned long data;
+	unsigned long _sig;
 
 	struct tvec_t_base_s *base;
 };
 
+#define __timer_sig(type, member) ((offsetof(type, member) << 16) | sizeof(type))
+
+#define __TIMER_OLD_SIG	(0xa5005a)
+
+typedef void timer_cb_t(struct timer_list *);
+
+extern void __timer_init(struct timer_list *t, timer_cb_t *func, long sig);
+
+#define timer_init(ptr, member, func)				\
+	__timer_init(&(ptr)->member, func,			\
+		     __timer_sig(typeof(*ptr), member))
+
+#define timer_of(ptr, type, member) ({				\
+	const struct timer_list *_t = (ptr);			\
+	if (_t->_sig != __timer_sig(type, member)) {		\
+		WARN_ON(_t->_sig != -__timer_sig(type, member));\
+		return;						\
+	}							\
+	container_of(ptr, type, member);			\
+})
+
+
 extern struct tvec_t_base_s boot_tvec_bases;
 
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
+		._sig = __TIMER_OLD_SIG,			\
 		.base = &boot_tvec_bases,			\
 	}
 
Index: linux-2.6-git/kernel/timer.c
===================================================================
--- linux-2.6-git.orig/kernel/timer.c	2007-01-06 20:45:02.000000000 +0100
+++ linux-2.6-git/kernel/timer.c	2007-01-06 21:00:07.000000000 +0100
@@ -226,6 +226,11 @@ static void internal_add_timer(tvec_base
 	unsigned long idx = expires - base->timer_jiffies;
 	struct list_head *vec;
 
+	if (!timer->_sig) {
+		WARN_ON(1);
+		timer->_sig = __TIMER_OLD_SIG;
+	}
+
 	if (idx < TVR_SIZE) {
 		int i = expires & TVR_MASK;
 		vec = base->tv1.vec + i;
@@ -271,11 +276,22 @@ static void internal_add_timer(tvec_base
  */
 void fastcall init_timer(struct timer_list *timer)
 {
+	timer->_sig = __TIMER_OLD_SIG;
 	timer->entry.next = NULL;
 	timer->base = __raw_get_cpu_var(tvec_bases);
 }
 EXPORT_SYMBOL(init_timer);
 
+extern void __timer_init(struct timer_list *t, timer_cb_t *func, long sig)
+{
+	t->function = (void *)func;
+	t->_sig = -sig;
+	func(t);
+	t->_sig = sig;
+	t->entry.next = NULL;
+	t->base = __raw_get_cpu_var(tvec_bases);
+}
+
 static inline void detach_timer(struct timer_list *timer,
 					int clear_pending)
 {
@@ -567,7 +583,7 @@ static inline void __run_timers(tvec_bas
 
 			timer = list_entry(head->next,struct timer_list,entry);
  			fn = timer->function;
- 			data = timer->data;
+ 			data = timer->_sig == __TIMER_OLD_SIG ? timer->data : (unsigned long)timer;
 
 			set_running_timer(base, timer);
 			detach_timer(timer, 1);
Index: linux-2.6-git/kernel/workqueue.c
===================================================================
--- linux-2.6-git.orig/kernel/workqueue.c	2007-01-06 19:51:40.000000000 +0100
+++ linux-2.6-git/kernel/workqueue.c	2007-01-06 21:02:59.000000000 +0100
@@ -218,9 +218,9 @@ int fastcall queue_work(struct workqueue
 }
 EXPORT_SYMBOL_GPL(queue_work);
 
-static void delayed_work_timer_fn(unsigned long __data)
+static void delayed_work_timer_fn(struct timer_list *timer)
 {
-	struct delayed_work *dwork = (struct delayed_work *)__data;
+	struct delayed_work *dwork = timer_of(timer, struct delayed_work, timer);
 	struct workqueue_struct *wq = get_wq_data(&dwork->work);
 	int cpu = smp_processor_id();
 
@@ -242,22 +242,20 @@ int fastcall queue_delayed_work(struct w
 			struct delayed_work *dwork, unsigned long delay)
 {
 	int ret = 0;
-	struct timer_list *timer = &dwork->timer;
 	struct work_struct *work = &dwork->work;
 
 	if (delay == 0)
 		return queue_work(wq, work);
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING, work_data_bits(work))) {
-		BUG_ON(timer_pending(timer));
+		BUG_ON(timer_pending(&dwork->timer));
 		BUG_ON(!list_empty(&work->entry));
 
 		/* This stores wq for the moment, for the timer_fn */
 		set_wq_data(work, wq);
-		timer->expires = jiffies + delay;
-		timer->data = (unsigned long)dwork;
-		timer->function = delayed_work_timer_fn;
-		add_timer(timer);
+		timer_init(dwork, timer, delayed_work_timer_fn);
+		dwork->timer.expires = jiffies + delay;
+		add_timer(&dwork->timer);
 		ret = 1;
 	}
 	return ret;
@@ -277,19 +275,17 @@ int queue_delayed_work_on(int cpu, struc
 			struct delayed_work *dwork, unsigned long delay)
 {
 	int ret = 0;
-	struct timer_list *timer = &dwork->timer;
 	struct work_struct *work = &dwork->work;
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING, work_data_bits(work))) {
-		BUG_ON(timer_pending(timer));
+		BUG_ON(timer_pending(&dwork->timer));
 		BUG_ON(!list_empty(&work->entry));
 
 		/* This stores wq for the moment, for the timer_fn */
 		set_wq_data(work, wq);
-		timer->expires = jiffies + delay;
-		timer->data = (unsigned long)dwork;
-		timer->function = delayed_work_timer_fn;
-		add_timer_on(timer, cpu);
+		timer_init(dwork, timer, delayed_work_timer_fn);
+		dwork->timer.expires = jiffies + delay;
+		add_timer_on(&dwork->timer, cpu);
 		ret = 1;
 	}
 	return ret;
