Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbTIOOft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbTIOOfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:35:48 -0400
Received: from dp.samba.org ([66.70.73.150]:26756 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261429AbTIOOfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:35:39 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier 
In-reply-to: Your message of "Fri, 12 Sep 2003 15:33:04 -0300."
             <3F621160.5020502@terra.com.br> 
Date: Mon, 15 Sep 2003 19:39:13 +1000
Message-Id: <20030915143538.009B32C0C3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3F621160.5020502@terra.com.br> you write:
> >     Kills an unneeded set_current_state after schedule_timeout, since it 
> > already guarantees that the task will be TASK_RUNNING.

In fact, furthur cleanups are possible.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Clean up futex task state setting
Author: Rusty Russell, Felipe W Damasio <felipewd@terra.com.br>
Depends: Misc/futex-jamie-plus1.patch.gz
Status: Trivial

D: Felipe points out that set_task_state is overkill.  In fact,
D: futex_lock protects us so we can set if after the queued test,
D: simplifying the whole function slightly

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7327-2.6.0-test5-bk3-futex-task_state.pre/kernel/futex.c .7327-2.6.0-test5-bk3-futex-task_state/kernel/futex.c
--- .7327-2.6.0-test5-bk3-futex-task_state.pre/kernel/futex.c	2003-09-15 19:37:14.000000000 +1000
+++ .7327-2.6.0-test5-bk3-futex-task_state/kernel/futex.c	2003-09-15 19:37:14.000000000 +1000
@@ -374,20 +374,16 @@ static int futex_wait(unsigned long uadd
 	 */
 	add_wait_queue(&q.waiters, &wait);
 	spin_lock(&futex_lock);
-	set_current_state(TASK_INTERRUPTIBLE);
 
 	if (unlikely(list_empty(&q.list))) {
-		/*
-		 * We were woken already.
-		 */
+		/* We were woken already. */
 		spin_unlock(&futex_lock);
-		set_current_state(TASK_RUNNING);
 		return 0;
 	}
 
+	__set_current_state(TASK_INTERRUPTIBLE);
 	spin_unlock(&futex_lock);
 	time = schedule_timeout(time);
-	set_current_state(TASK_RUNNING);
 
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because
