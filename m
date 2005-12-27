Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVL0QbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVL0QbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 11:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVL0QbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 11:31:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:44701 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750843AbVL0QbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 11:31:06 -0500
Date: Tue, 27 Dec 2005 10:30:59 -0600
From: Jack Steiner <steiner@sgi.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Fix memory ordering problem in wake_futex()
Message-ID: <20051227163059.GA2381@sgi.com>
References: <20051223163816.GA30906@sgi.com> <20051224134523.GA7187@sgi.com> <20051224181325.GH24601@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051224181325.GH24601@pb15.lixom.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


Here is a fix for a ugly race condition that occurs in wake_futex(). The
failure was detected on IA64 but may also occur on other architectures.

On IA64, locks are released using a "st.rel" instruction. This ensures that
preceding "stores" are visible before the lock is released but does NOT prevent
a "store" that follows the "st.rel" from becoming visible before the "st.rel".

The failure I saw is a task that owned a futex_q resumed prematurely and
was context-switch off of the cpu. The task's switch_stack occupied the same
space as the futex_q. The store to q->lock_ptr in futex_wait()overwrote the 
ar.bspstore in the switch_stack. When the task resumed, it ran with a corrupted 
ar.bspstore.  Things went downhill from there.

Without the fix, the application fails roughly every 10 minutes. With
the fix, it ran over 16 hours without a failure.

----
Fix a memory ordering problem that occurs on IA64. The "store" to q->lock_ptr
in wake_futex() can become visible before wake_up_all() clears the lock in the
futex_q.



	Signed-off-by: Jack Steiner <steiner@sgi.com>





Index: linux/kernel/futex.c
===================================================================
--- linux.orig/kernel/futex.c	2005-12-24 15:09:23.381357908 -0600
+++ linux/kernel/futex.c	2005-12-24 15:14:26.362119396 -0600
@@ -262,15 +262,18 @@ static void wake_futex(struct futex_q *q
 	list_del_init(&q->list);
 	if (q->filp)
 		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
-	/*
-	 * The lock in wake_up_all() is a crucial memory barrier after the
-	 * list_del_init() and also before assigning to q->lock_ptr.
-	 */
 	wake_up_all(&q->waiters);
+
 	/*
 	 * The waiting task can free the futex_q as soon as this is written,
 	 * without taking any locks.  This must come last.
+	 *
+	 * A memory barrier is required here to prevent the following store
+	 * to lock_ptr from getting ahead of the wakeup. Clearing the lock
+	 * at the end of wake_up_all() is not a write barrier on all
+	 * architectures.
 	 */
+	smp_wmb();
 	q->lock_ptr = NULL;
 }
 
