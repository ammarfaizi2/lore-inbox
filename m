Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVLHP0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVLHP0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 10:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVLHP0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 10:26:05 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:27862 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751186AbVLHP0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 10:26:04 -0500
Subject: [PATCH -RT]  Deadlock on down_trylock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 10:25:44 -0500
Message-Id: <1134055545.6279.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I've just uncovered a nasty little deadlock in rt.c wrt __down_trylock.
It started with the following code in fs/ext3/super.c (Always it's
because of ext3 ;)

static void ext3_write_super (struct super_block * sb)
{
	if (down_trylock(&sb->s_lock) == 0)
		BUG();
	sb->s_dirt = 0;
}

Now what it is doing here is testing to make sure that the down_trylock
fails. Sort of a assert_is_spin_locked for a semaphore.  But
unfortunately, my pi_locking code in rt.c doesn't account for this.

The locking order of the task->pi_lock and lock->wait_lock is very
dependent on the order of locks taken in the kernel that would not cause
a deadlock.  But trylock is not bound to this order, and it is even OK,
as seen above in ext3, for an owner to grab a lock that it owns with
trylock.

So to handle this, I'm supplying the following patch.  My machine with
my kernel and debugging would take about one or two hours to crash on
this, and it hasn't reached that point yet. But I believe that this
patch should fix the problem.  If my machine locks up again, I'll let
you know, and supply another patch ASAP.

-- Steve

PS.  Whose lovely idea was it to have spin_trylock return a one on
success, and down_trylock return a zero on success???  It took me a few
tries to get this right! (but please review it just in case)


Index: linux-2.6.14-rt22/kernel/rt.c
===================================================================
--- linux-2.6.14-rt22.orig/kernel/rt.c	2005-12-06 21:44:53.000000000 -0500
+++ linux-2.6.14-rt22/kernel/rt.c	2005-12-08 09:59:04.000000000 -0500
@@ -1970,7 +1970,15 @@
 	trace_lock_irqsave(&trace_lock, flags, ti);
 	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
 	_raw_spin_lock(&task->pi_lock);
-	_raw_spin_lock(&lock->wait_lock);
+	/*
+	 * It is OK for the owner of the lock to do a trylock on
+	 * a lock it owns, so to prevent deadlocking, we must
+	 * do a trylock here, since another process may be trying
+	 * to grab this lock, and the order of these locks is
+	 * very important.
+	 */
+	if (!_raw_spin_trylock(&lock->wait_lock))
+		goto failed;
 
 	old_owner = lock_owner(lock);
 	init_lists(lock);
@@ -1987,6 +1995,7 @@
 		ret = 1;
 	}
 	_raw_spin_unlock(&lock->wait_lock);
+failed:
 	_raw_spin_unlock(&task->pi_lock);
 	trace_unlock_irqrestore(&trace_lock, flags, ti);
 


