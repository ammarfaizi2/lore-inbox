Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbTFWDHE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 23:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbTFWDHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 23:07:04 -0400
Received: from dp.samba.org ([66.70.73.150]:61579 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264984AbTFWDHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 23:07:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: jgarzik@pobox.com, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue.c neatening II
Date: Mon, 23 Jun 2003 13:20:25 +1000
Message-Id: <20030623032108.925012C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus applied my patch before Jeff's critique.  Here's the fix.

Linus, please apply.
Rusty.

Name: Workqueue Exit Neatening
Author: Rusty Russell
Status: Tested on 2.5.73

D: Jeff Garzik points out the initializing the exit completion at
D: exit time is foolish: we should just initialize it at creation time
D: live everything else in that structure, and avoid the memory barrier.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22396-linux-2.5.73/kernel/workqueue.c .22396-linux-2.5.73.updated/kernel/workqueue.c
--- .22396-linux-2.5.73/kernel/workqueue.c	2003-06-23 10:52:59.000000000 +1000
+++ .22396-linux-2.5.73.updated/kernel/workqueue.c	2003-06-23 12:01:18.000000000 +1000
@@ -275,6 +275,7 @@ static int create_workqueue_thread(struc
 	INIT_LIST_HEAD(&cwq->worklist);
 	init_waitqueue_head(&cwq->more_work);
 	init_waitqueue_head(&cwq->work_done);
+	init_completion(&cwq->exit);
 
 	init_completion(&startup.done);
 	startup.cwq = cwq;
@@ -320,10 +321,7 @@ static void cleanup_workqueue_thread(str
 
 	cwq = wq->cpu_wq + cpu;
 	if (cwq->thread) {
-		printk("Cleaning up workqueue thread for %i\n", cpu);
-		/* Initiate an exit and wait for it: */
-		init_completion(&cwq->exit);
-		wmb(); /* Thread must see !cwq->thread after completion init */
+		/* Tell thread to exit and wait for it. */
 		cwq->thread = NULL;
 		wake_up(&cwq->more_work);
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
