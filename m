Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUA1Pmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266061AbUA1PlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:41:14 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:4875 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266052AbUA1PkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:40:23 -0500
Date: Wed, 28 Jan 2004 23:39:38 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 3/8] autofs4-2.6 - to support autofs 4.1.x
Message-ID: <Pine.LNX.4.58.0401282317180.17471@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch:

3-autofs4-2.6.0-test9-waitq1.patch

interruptible_sleep_on open to race. Includes workaround to what appears
to be a scheduling problem (a nice(-1) in the daemon makes the problem go
away). Don't think anyone agrees with this view though. It was suggested
this code needed to be rewritten to fix the problem but after several days
I couldn't come up with anything that worked for me. The work around 
remains for older versions of the daemon.

diff -Nur linux-2.6.0-0.test9.fill_super/fs/autofs4/autofs_i.h linux-2.6.0-0.test9.waitq1/fs/autofs4/autofs_i.h
--- linux-2.6.0-0.test9.fill_super/fs/autofs4/autofs_i.h	2003-11-15 09:26:07.000000000 +0800
+++ linux-2.6.0-0.test9.waitq1/fs/autofs4/autofs_i.h	2003-11-30 08:54:03.000000000 +0800
@@ -77,6 +77,7 @@
 struct autofs_wait_queue {
 	wait_queue_head_t queue;
 	struct autofs_wait_queue *next;
+	struct task_struct *owner;
 	autofs_wqt_t wait_queue_token;
 	/* We use the following to see what we are waiting for */
 	int hash;
diff -Nur linux-2.6.0-0.test9.fill_super/fs/autofs4/waitq.c linux-2.6.0-0.test9.waitq1/fs/autofs4/waitq.c
--- linux-2.6.0-0.test9.fill_super/fs/autofs4/waitq.c	2003-11-15 09:26:07.000000000 +0800
+++ linux-2.6.0-0.test9.waitq1/fs/autofs4/waitq.c	2003-11-30 08:58:47.000000000 +0800
@@ -37,7 +37,7 @@
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name);
 		wq->name = NULL;
-		wake_up(&wq->queue);
+		wake_up_interruptible(&wq->queue);
 		wq = nwq;
 	}
 	if (sbi->pipe) {
@@ -204,7 +204,18 @@
 		recalc_sigpending();
 		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 
-		interruptible_sleep_on(&wq->queue);
+		wait_event_interruptible(wq->queue, wq->name == NULL);
+
+		/*
+		 * FIXME: Call never returns if wait owner is not first out.
+		 *   A nice(-1) in the daemon makes the problem go away.
+		 *   The workaround is left for people running old versions
+		 *   of the daemon.
+		 */
+		if (waitqueue_active(&wq->queue) && current != wq->owner) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ/10);
+		}
 
 		spin_lock_irqsave(&current->sighand->siglock, irqflags);
 		current->blocked = oldset;
@@ -243,7 +254,7 @@
 	if (--wq->wait_ctr == 0)	/* Is anyone still waiting for this guy? */
 		kfree(wq);
 	else
-		wake_up(&wq->queue);
+		wake_up_interruptible(&wq->queue);
 
 	return 0;
 }

