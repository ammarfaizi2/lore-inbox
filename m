Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290654AbSAYM02>; Fri, 25 Jan 2002 07:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290652AbSAYM0S>; Fri, 25 Jan 2002 07:26:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11161 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290651AbSAYM0I>;
	Fri, 25 Jan 2002 07:26:08 -0500
Date: Fri, 25 Jan 2002 15:23:39 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] yield-fixes 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201251510300.7207-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below fixes two yield()-usage bugs introduced by the new
scheduler. In the first O(1) scheduler iterations i've added TASK_YIELDED,
which made the setting of p->state unnecessery before calling yield(). But
later i cleaned up yield() further, again enabling the yielding of
non-running tasks. But the places which need to set p->state were not
reverted to the pre-TASK_YIELDED behavior.

the bug was seen live by Arjan van de Ven (in the 2.4 kernel), it causes
'stuck' shells under heavy IO and VM load.

	Ingo

--- linux/fs/buffer.c.orig	Fri Jan 25 12:40:11 2002
+++ linux/fs/buffer.c	Fri Jan 25 12:40:18 2002
@@ -724,6 +724,7 @@
 	wakeup_bdflush();
 	try_to_free_pages(zone, GFP_NOFS, 0);
 	run_task_queue(&tq_disk);
+	__set_current_state(TASK_RUNNING);
 	yield();
 }

--- linux/mm/page_alloc.c.orig	Fri Jan 25 12:43:42 2002
+++ linux/mm/page_alloc.c	Fri Jan 25 12:43:50 2002
@@ -394,6 +394,7 @@
 		return NULL;

 	/* Yield for kswapd, and try again */
+	__set_current_state(TASK_RUNNING);
 	yield();
 	goto rebalance;
 }


