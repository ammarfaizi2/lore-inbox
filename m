Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWDYQjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWDYQjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWDYQjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:39:11 -0400
Received: from www.osadl.org ([213.239.205.134]:46464 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751600AbWDYQjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:39:10 -0400
Message-Id: <20060425162420.710609000@localhost.localdomain>
References: <20060425162414.896662000@localhost.localdomain>
Date: Tue, 25 Apr 2006 16:41:05 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 1/4] rtmutex: Remove buggy BUG_ON in PI boosting code
Content-Disposition: inline; filename=rtmutex-bugon-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt <rostedt@goodmis.org>

The condition in that particular BUG_ON can legitimately be the
case, if you have processes A, B, C, D, and E holding the
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

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/rtmutex.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.17-rc1-mm3/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/rtmutex.c
+++ linux-2.6.17-rc1-mm3/kernel/rtmutex.c
@@ -209,10 +209,8 @@ static int rt_mutex_adjust_prio_chain(ta
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

--

