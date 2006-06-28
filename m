Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWF1HcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWF1HcP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWF1HcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:32:15 -0400
Received: from mga03.intel.com ([143.182.124.21]:61194 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030466AbWF1HcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:32:14 -0400
X-IronPort-AV: i="4.06,186,1149490800"; 
   d="scan'208"; a="58476065:sNHT94139080"
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
From: Zou Nan hai <nanhai.zou@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060627235500.8c2c290e.akpm@osdl.org>
References: <1151470123.6052.17.camel@linux-znh>
	 <20060627234005.dda13686.akpm@osdl.org> <20060628063859.GA9726@elte.hu>
	 <20060627235500.8c2c290e.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1151473582.6052.28.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Jun 2006 13:46:22 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 14:55, Andrew Morton wrote:
> On Wed, 28 Jun 2006 08:38:59 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > > We see system hang in ext3 jbd code
> > > > when Linux install program anaconda copying 
> > > > packages. 
> > > > 
> > > > That is because anaconda is invoked from linuxrc 
> > > > in initrd when system_state is still SYSTEM_BOOTING.
> > 
> > [ argh ...! ]
> 
> That's what I thought  ;)
> 
> > > > Thus the cond_resched checks in  journal_commit_transaction 
> > > > will always return 1 without actually schedule, 
> > > > then the system fall into deadloop.
> > > 
> > > That's a bug in cond_resched().
> > > 
> > > Something like this..
> > 
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> > 
> 
> Thanks.  Zou, it'd be great if you could test this in your setup, please. 
> I've tagged it as 2.6.17.x material.

Andrew, 
   I am building the env to test.
   The patch was my original idea, but I was afraid of breaking any code
that rely on the OLD wrong cond_sched semantic. However later I did a
grep found that there is very few code that checks the return value of
cond_resched. So the patch should be safe. 

However I think cond_resched_lock and cond_resched_softirq also need fix
to make the semantic consistent.

Please check the following patch.

Zou Nan hai

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

--- linux-2.6.17/kernel/sched.c	2006-06-18 09:49:35.000000000 +0800
+++ linux-2.6.17-fix/kernel/sched.c	2006-06-28 13:34:39.000000000 +0800
@@ -4044,7 +4044,7 @@ asmlinkage long sys_sched_yield(void)
 	return 0;
 }
 
-static inline void __cond_resched(void)
+static inline int __cond_resched(void)
 {
 	/*
 	 * The BKS might be reacquired before we have dropped
@@ -4052,22 +4052,21 @@ static inline void __cond_resched(void)
 	 * cond_resched() call.
 	 */
 	if (unlikely(preempt_count()))
-		return;
+		return 0;
 	if (unlikely(system_state != SYSTEM_RUNNING))
-		return;
+		return 0;
 	do {
 		add_preempt_count(PREEMPT_ACTIVE);
 		schedule();
 		sub_preempt_count(PREEMPT_ACTIVE);
 	} while (need_resched());
+	return 1;
 }
 
 int __sched cond_resched(void)
 {
-	if (need_resched()) {
-		__cond_resched();
-		return 1;
-	}
+	if (need_resched())
+		return __cond_resched();
 	return 0;
 }
 
@@ -4094,8 +4093,7 @@ int cond_resched_lock(spinlock_t *lock)
 	if (need_resched()) {
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
-		__cond_resched();
-		ret = 1;
+		ret |= __cond_resched();
 		spin_lock(lock);
 	}
 	return ret;
@@ -4106,14 +4104,13 @@ EXPORT_SYMBOL(cond_resched_lock);
 int __sched cond_resched_softirq(void)
 {
 	BUG_ON(!in_softirq());
-
+	int ret = 0;
 	if (need_resched()) {
 		__local_bh_enable();
-		__cond_resched();
+		ret = __cond_resched();
 		local_bh_disable();
-		return 1;
 	}
-	return 0;
+	return ret;
 }
 
 EXPORT_SYMBOL(cond_resched_softirq);


