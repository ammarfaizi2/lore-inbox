Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWHDFpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWHDFpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWHDFpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:45:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:20400 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030332AbWHDFpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:45:02 -0400
Date: Thu, 3 Aug 2006 22:40:24 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Ingo Molnar <mingo@elte.hu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/23] cond_resched() fix
Message-ID: <20060804054024.GS769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cond_resched-fix.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew Morton <akpm@osdl.org>

[PATCH] cond_resched() fix

Fix a bug identified by Zou Nan hai <nanhai.zou@intel.com>:

If the system is in state SYSTEM_BOOTING, and need_resched() is true,
cond_resched() returns true even though it didn't reschedule.  Consequently
need_resched() remains true and JBD locks up.

Fix that by teaching cond_resched() to only return true if it really did call
schedule().

cond_resched_lock() and cond_resched_softirq() have a problem too.  If we're
in SYSTEM_BOOTING state and need_resched() is true, these functions will drop
the lock and will then try to call schedule(), but the SYSTEM_BOOTING state
will prevent schedule() from being called.  So on return, need_resched() will
still be true, but cond_resched_lock() has to return 1 to tell the caller that
the lock was dropped.  The caller will probably lock up.

Bottom line: if these functions dropped the lock, they _must_ call schedule()
to clear need_resched().   Make it so.

Also, uninline __cond_resched().  It's largeish, and slowpath.

Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/sched.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- linux-2.6.17.7.orig/kernel/sched.c
+++ linux-2.6.17.7/kernel/sched.c
@@ -4044,17 +4044,22 @@ asmlinkage long sys_sched_yield(void)
 	return 0;
 }
 
-static inline void __cond_resched(void)
+static inline int __resched_legal(int expected_preempt_count)
+{
+	if (unlikely(preempt_count() != expected_preempt_count))
+		return 0;
+	if (unlikely(system_state != SYSTEM_RUNNING))
+		return 0;
+	return 1;
+}
+
+static void __cond_resched(void)
 {
 	/*
 	 * The BKS might be reacquired before we have dropped
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
@@ -4064,13 +4069,12 @@ static inline void __cond_resched(void)
 
 int __sched cond_resched(void)
 {
-	if (need_resched()) {
+	if (need_resched() && __resched_legal(0)) {
 		__cond_resched();
 		return 1;
 	}
 	return 0;
 }
-
 EXPORT_SYMBOL(cond_resched);
 
 /*
@@ -4091,7 +4095,7 @@ int cond_resched_lock(spinlock_t *lock)
 		ret = 1;
 		spin_lock(lock);
 	}
-	if (need_resched()) {
+	if (need_resched() && __resched_legal(1)) {
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
 		__cond_resched();
@@ -4100,14 +4104,13 @@ int cond_resched_lock(spinlock_t *lock)
 	}
 	return ret;
 }
-
 EXPORT_SYMBOL(cond_resched_lock);
 
 int __sched cond_resched_softirq(void)
 {
 	BUG_ON(!in_softirq());
 
-	if (need_resched()) {
+	if (need_resched() && __resched_legal(0)) {
 		__local_bh_enable();
 		__cond_resched();
 		local_bh_disable();
@@ -4115,10 +4118,8 @@ int __sched cond_resched_softirq(void)
 	}
 	return 0;
 }
-
 EXPORT_SYMBOL(cond_resched_softirq);
 
-
 /**
  * yield - yield the current processor to other threads.
  *

--
