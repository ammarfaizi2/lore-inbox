Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752662AbWAHSDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbWAHSDL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbWAHSDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:03:11 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:31460 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1752662AbWAHSDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:03:09 -0500
Message-ID: <43C165BC.F7C6DCF5@tv-sign.ru>
Date: Sun, 08 Jan 2006 22:19:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

->donelist becomes != NULL only in rcu_process_callbacks().

rcu_process_callbacks() always calls rcu_do_batch() when
->donelist != NULL.

rcu_do_batch() schedules rcu_process_callbacks() again if
->donelist was not flushed entirely.

So ->donelist != NULL means that rcu_tasklet is either
TASKLET_STATE_SCHED or TASKLET_STATE_RUN, we don't need to
check it in __rcu_pending().

[ This patch was tested with rcutorture.ko, I don't understand
  it's output, but it says "End of test: SUCCESS". So if this
  patch incorrect blame Paul, not me! ]

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15/kernel/rcupdate.c~2_DONE	2006-01-08 21:35:21.000000000 +0300
+++ 2.6.15/kernel/rcupdate.c	2006-01-08 21:55:45.000000000 +0300
@@ -454,10 +454,6 @@ static int __rcu_pending(struct rcu_ctrl
 	if (!rdp->curlist && rdp->nxtlist)
 		return 1;
 
-	/* This cpu has finished callbacks to invoke */
-	if (rdp->donelist)
-		return 1;
-
 	/* The rcu core waits for a quiescent state from the cpu */
 	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
 		return 1;
