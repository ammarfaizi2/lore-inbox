Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWDRONW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWDRONW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWDRONW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:13:22 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:48360 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932125AbWDRONV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:13:21 -0400
Subject: [PATCH -rt] Remove false BUG_ON from rtmutex.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
In-Reply-To: <1145324887.17085.35.camel@localhost.localdomain>
References: <1145324887.17085.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 10:13:10 -0400
Message-Id: <1145369590.17085.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Here's a patch to remove the BUG_ON in rtmutex.c.  I previously showed
that the condition in that particular BUG_ON can legitimately be the
case.

Once again, if you have processes A, B, C, D, and E holding the
following locks in this scenario:

 L1 <=blocks= A
               <=owns= L2 <=blocks= B <=owns= L4 <=blocks= D
               <=owns= L3 <=blocks= C <=owns= L5 <=blocks= E

Where the priorities of these tasks are

    B,C < A < D = E

B and C are less than A and A is less than D and E where D and E are
equal (actually it probably works when D and E are not equal too).

As D and E climb the chain, there's a very slight race condition that
could allow for the condition in the offending BUG_ON to be true.

This patch removes that BUG_ON.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt16/kernel/rtmutex.c
===================================================================
--- linux-2.6.16-rt16.orig/kernel/rtmutex.c	2006-04-17 14:49:43.000000000 -0400
+++ linux-2.6.16-rt16/kernel/rtmutex.c	2006-04-18 09:57:54.000000000 -0400
@@ -232,10 +232,8 @@ static int rt_mutex_adjust_prio_chain(ta
 	 * When deadlock detection is off then we check, if further
 	 * priority adjustment is necessary.
 	 */
-	if (!detect_deadlock && waiter->list_entry.prio == task->prio) {
-		BUG_ON(waiter->pi_list_entry.prio != waiter->list_entry.prio);
+	if (!detect_deadlock && waiter->list_entry.prio == task->prio)
 		goto out_unlock_pi;
-	}
 
 	lock = waiter->lock;
 	if (!spin_trylock(&lock->wait_lock)) {


