Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbWGZJAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbWGZJAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 05:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWGZJAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 05:00:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55269 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030461AbWGZJAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 05:00:15 -0400
Date: Wed, 26 Jul 2006 10:54:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 0/3] [-rt] Fixes the timeout-bug in the rtmutex/PI-futex.
Message-ID: <20060726085404.GA19151@elte.hu>
References: <Pine.LNX.4.64.0607230215480.11861@localhost.localdomain> <20060726084152.GA15909@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726084152.GA15909@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Esben Nielsen <nielsen.esben@googlemail.com> wrote:
> 
> > -- Hi,
> >  I finally got around to send in the a new version of my fixes to PI. 
> >  The main purpose is to fix the timeout bug of the rtmutex/PI-futex. 
> 
> there's quite a bit of whitespace damage in your patchqueue. For 
> example all the 'context' lines have an extra space at their 
> beginning, which causes 'patch' to fail on every single chunk. There's 
> also the occasional '8 spaces instead of a tab' buglet, probably 
> introduced while writing this code.

and i also had to do the fixes below to get it to build.

	Ingo

---
 include/linux/rtmutex.h |    2 +-
 kernel/rtmutex.c        |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-rt.q/include/linux/rtmutex.h
===================================================================
--- linux-rt.q.orig/include/linux/rtmutex.h
+++ linux-rt.q/include/linux/rtmutex.h
@@ -116,7 +116,7 @@ extern void rt_mutex_unlock(struct rt_mu
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters, tsk.pi_lock),	\
 	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
-	.boosting_prio	= MAX_PRIO					\
+	.boosting_prio	= MAX_PRIO,					\
 	INIT_RT_MUTEX_DEBUG(tsk)
 #else
 # define INIT_RT_MUTEXES(tsk)
Index: linux-rt.q/kernel/rtmutex.c
===================================================================
--- linux-rt.q.orig/kernel/rtmutex.c
+++ linux-rt.q/kernel/rtmutex.c
@@ -328,7 +328,7 @@ static int rt_mutex_adjust_prio_chain(ta
  * Calls the rt_mutex_adjust_prio_chain() above
  * whith unlocking and locking lock->wait_lock.
  */
-static void rt_mutex_adjust_prio_chain_unlock(struct rt_mutex *lock)
+static void rt_mutex_adjust_prio_chain_unlock(struct rt_mutex *lock __IP_DECL__)
 {
 	spin_unlock(&lock->wait_lock);
 	get_task_struct(current);
@@ -714,7 +714,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
 			task_blocks_on_rt_mutex(lock, &waiter, 0 __IP__);
 			/* Wakeup during boost ? */
 		else
-			rt_mutex_adjust_prio_chain_unlock(lock);
+			rt_mutex_adjust_prio_chain_unlock(lock __IP__);
 
 		/*
 		 * We got it while lock->wait_lock was unlocked ?
@@ -914,7 +914,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 			ret = task_blocks_on_rt_mutex(lock, &waiter,
 						      detect_deadlock __IP__);
 		else
-			rt_mutex_adjust_prio_chain_unlock(lock);
+			rt_mutex_adjust_prio_chain_unlock(lock __IP__);
 
 
 		/*
