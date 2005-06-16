Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVFPScX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVFPScX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 14:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVFPScW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 14:32:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261774AbVFPSbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 14:31:35 -0400
Date: Thu, 16 Jun 2005 11:31:29 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Wilk <davidwilk@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: assertion failure in fs/jbd/checkpoint.c persists in 2.6.11.12
Message-ID: <20050616183129.GH9153@shell0.pdx.osdl.net>
References: <a4403ff605061611134318f0fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4403ff605061611134318f0fb@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Wilk (davidwilk@gmail.com) wrote:
> We've been plagued buy this ext3 bug since 2.6.10, and it only happens
> on heavily loaded postgres systems.  We run our postgres DB on ext3
> data=journal on a dmcrypt partition.  Our kernel is also patched with
> grsec, but that doesn't appear to play any role.

Can you recreate w/out grsec, and w/out dm-crypt?  IOW, just ext3 plus
your load?

> After upgrading to 2.6.11.12 (specifically for the ext3 checkpoint.c
> fix) we noticed two things.  The assertion failure persists, and now
> we get a condition where a postgres process will spin in state 'D'
> forever and hog 100% of a CPU (in system, not user).
> 
> I've attached the trace in plain text so the formatting doesn't get screwed.
> 
> Let me know if anyone would like more information.  I'm no programmer,
> but I'd like to help in any way that I can.

Would you mind trying this patch:

From: Jan Kara <jack@suse.cz>

On one path, cond_resched_lock() fails to return true if it dropped the lock. 
We think this might be causing the crashes in JBD's log_do_checkpoint().

(chrisw: backport to 2.6.11.12)
---

 kernel/sched.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

Index: release-2.6.11/kernel/sched.c
===================================================================
--- release-2.6.11.orig/kernel/sched.c
+++ release-2.6.11/kernel/sched.c
@@ -3788,11 +3788,14 @@ EXPORT_SYMBOL(cond_resched);
  */
 int cond_resched_lock(spinlock_t * lock)
 {
+	int ret = 0;
+
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
 	if (lock->break_lock) {
 		lock->break_lock = 0;
 		spin_unlock(lock);
 		cpu_relax();
+		ret = 1;
 		spin_lock(lock);
 	}
 #endif
@@ -3800,10 +3803,10 @@ int cond_resched_lock(spinlock_t * lock)
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
 		__cond_resched();
+		ret = 1;
 		spin_lock(lock);
-		return 1;
 	}
-	return 0;
+	return ret;
 }
 
 EXPORT_SYMBOL(cond_resched_lock);
