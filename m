Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423219AbWF1IEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423219AbWF1IEy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423221AbWF1IEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:04:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423214AbWF1IEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:04:34 -0400
Date: Wed, 28 Jun 2006 01:04:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zou Nan hai <nanhai.zou@intel.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
Message-Id: <20060628010422.dc73b7e9.akpm@osdl.org>
In-Reply-To: <1151474577.6052.33.camel@linux-znh>
References: <1151470123.6052.17.camel@linux-znh>
	<20060627234005.dda13686.akpm@osdl.org>
	<20060628063859.GA9726@elte.hu>
	<20060627235500.8c2c290e.akpm@osdl.org>
	<1151473582.6052.28.camel@linux-znh>
	<20060628004029.efcc8a03.akpm@osdl.org>
	<1151474577.6052.33.camel@linux-znh>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2006 14:02:57 +0800
Zou Nan hai <nanhai.zou@intel.com> wrote:

> > > However I think cond_resched_lock and cond_resched_softirq also need fix
> > > to make the semantic consistent.
> > > 
> > > Please check the following patch.
> > > 
> > 
> > Ah.  I think the return value from these functions should mean "something
> > disruptive happened", if you like.
> > 
> > See, the callers of cond_resched_lock() aren't interested in whether
> > cond_resched_lock() actually called schedule().  They want to know whether
> > cond_resched_lock() dropped the lock.  Because if the lock was dropped, the
> > caller needs to take some special action, regardless of whether schedule()
> > was finally called.
> > 
> > So I think the patch I queued is OK, agree?
> 
>   I am afraid the code like cond_resched_lock check in
> fs/jbd/checkpoint.c log_do_checkpoint may fall into endless retry in
> some condition, will it?

Oh crap, yes.  If need_resched() and system_state==SYSTEM_BOOTING then
cond_resched_lock() will drop the lock but won't schedule.  So it'll return
true but won't clear need_resched() and the caller will lock up.

So if cond_resched_foo() ends up dropping the lock it _must_ call
schedule() to clear need_resched().

So, how about this (it needs some code comments!)


diff -puN kernel/sched.c~cond_resched-fix kernel/sched.c
--- a/kernel/sched.c~cond_resched-fix
+++ a/kernel/sched.c
@@ -4386,6 +4386,15 @@ asmlinkage long sys_sched_yield(void)
 	return 0;
 }
 
+static inline int __resched_legal(void)
+{
+	if (unlikely(preempt_count()))
+		return 0;
+	if (unlikely(system_state != SYSTEM_RUNNING))
+		return 0;
+	return 1;
+}
+
 static inline void __cond_resched(void)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
@@ -4396,10 +4405,6 @@ static inline void __cond_resched(void)
 	 * PREEMPT_ACTIVE, which could trigger a second
 	 * cond_resched() call.
 	 */
-	if (unlikely(preempt_count()))
-		return;
-	if (unlikely(system_state != SYSTEM_RUNNING))
-		return;
 	do {
 		add_preempt_count(PREEMPT_ACTIVE);
 		schedule();
@@ -4409,13 +4414,12 @@ static inline void __cond_resched(void)
 
 int __sched cond_resched(void)
 {
-	if (need_resched()) {
+	if (need_resched() && __resched_legal()) {
 		__cond_resched();
 		return 1;
 	}
 	return 0;
 }
-
 EXPORT_SYMBOL(cond_resched);
 
 /*
@@ -4436,7 +4440,7 @@ int cond_resched_lock(spinlock_t *lock)
 		ret = 1;
 		spin_lock(lock);
 	}
-	if (need_resched()) {
+	if (need_resched() && __resched_legal()) {
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
 		__cond_resched();
@@ -4445,14 +4449,13 @@ int cond_resched_lock(spinlock_t *lock)
 	}
 	return ret;
 }
-
 EXPORT_SYMBOL(cond_resched_lock);
 
 int __sched cond_resched_softirq(void)
 {
 	BUG_ON(!in_softirq());
 
-	if (need_resched()) {
+	if (need_resched() && __resched_legal()) {
 		__local_bh_enable();
 		__cond_resched();
 		local_bh_disable();
@@ -4460,10 +4463,8 @@ int __sched cond_resched_softirq(void)
 	}
 	return 0;
 }
-
 EXPORT_SYMBOL(cond_resched_softirq);
 
-
 /**
  * yield - yield the current processor to other threads.
  *
_

