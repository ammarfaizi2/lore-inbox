Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWEMXeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWEMXeg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWEMXeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:34:36 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:21937 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964798AbWEMXef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:34:35 -0400
Date: Sat, 13 May 2006 19:34:22 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: akpm@osdl.org
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] update comment in rtmutex.c and friends
Message-ID: <Pine.LNX.4.58.0605131846250.2208@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The documented state in both the code and the rt-mutex.txt has a slight
incorrect statement.  They state that if the owner of the mutex is NULL,
and the "mutex has waiters" bit is set that it is an invalid state.

This is not true. To synchronize with an owner releasing the mutex, the
owner field must have the "mutex has waiters" bit set before trying to
grab the lock.  This prevents the owner from releasing the lock without going
into the slow unlock path.  But if the mutex doesn't have an owner, then
before the current process grabs the lock, it sets the "mutex has waiters"
bit.  But in this case it will grab the lock and clear the bit. So the
"mutex has waiters" bit and owner == NULL is a transitional state.

This patch comments this case.

-- Steve


Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/Documentation/rt-mutex.txt
===================================================================
--- linux-2.6.17-rc3-mm1.orig/Documentation/rt-mutex.txt	2006-05-13 18:39:29.000000000 -0400
+++ linux-2.6.17-rc3-mm1/Documentation/rt-mutex.txt	2006-05-13 18:44:00.000000000 -0400
@@ -53,7 +53,7 @@ waiters" state.
  owner		bit1	bit0
  NULL		0	0	mutex is free (fast acquire possible)
  NULL		0	1	invalid state
- NULL		1	0	invalid state
+ NULL		1	0	Transitional state*
  NULL		1	1	invalid state
  taskpointer	0	0	mutex is held (fast release possible)
  taskpointer	0	1	task is pending owner
@@ -72,3 +72,8 @@ uninterrupted workflow of high-prio task
 takes/releases locks that have lower-prio waiters. Without this
 optimization the higher-prio thread would ping-pong to the lower-prio
 task [because at unlock time we always assign a new owner].
+
+(*) The "mutex has waiters" bit gets set to take the lock. If the lock
+doesn't already have an owner, this bit is quickly cleared if there are
+no waiters.  So this is a transitional state to synchronize with looking
+at the owner field of the mutex and the mutex owner releasing the lock.
\ No newline at end of file
Index: linux-2.6.17-rc3-mm1/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/kernel/rtmutex.c	2006-05-13 17:50:24.000000000 -0400
+++ linux-2.6.17-rc3-mm1/kernel/rtmutex.c	2006-05-13 18:38:35.000000000 -0400
@@ -31,7 +31,7 @@
  * owner	bit1	bit0
  * NULL		0	0	lock is free (fast acquire possible)
  * NULL		0	1	invalid state
- * NULL		1	0	invalid state
+ * NULL		1	0	Transitional State*
  * NULL		1	1	invalid state
  * taskpointer	0	0	lock is held (fast release possible)
  * taskpointer	0	1	task is pending owner
@@ -46,9 +46,15 @@
  *
  * The fast atomic compare exchange based acquire and release is only
  * possible when bit 0 and 1 of lock->owner are 0.
+ *
+ * (*) There's a small time where the owner can be NULL and the
+ * "lock has waiters" bit is set.  This can happen when grabbing the lock.
+ * To prevent a cmpxchg of the owner releasing the lock, we need to set this
+ * bit before looking at the lock, hence the reason this is a transitional
+ * state.
  */

-static void
+static vid
 rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
 		   unsigned long mask)
 {
@@ -365,6 +371,7 @@ static int try_to_take_rt_mutex(struct r
 	 * Note, that this might set lock->owner =
 	 * RT_MUTEX_HAS_WAITERS in the case the lock is not contended
 	 * any more. This is fixed up when we take the ownership.
+	 * This is the transitional state explained at the top of this file.
 	 */
 	mark_rt_mutex_waiters(lock);

