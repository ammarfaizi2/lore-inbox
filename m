Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVDLLT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVDLLT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVDLLQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:16:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262296AbVDLKd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:56 -0400
Message-Id: <200504121033.j3CAXgHl005953@shell0.pdx.osdl.net>
Subject: [patch 197/198] md: close a small race in md thread deregistration
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, neilb@cse.unsw.edu.au
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: NeilBrown <neilb@cse.unsw.edu.au>

There is a tiny race when de-registering an MD thread, in that the thread
could disappear before it is set a SIGKILL, causing send_sig to have
problems.  

This is most easily closed by holding tasklist_lock between enabling the
thread to exit (setting ->run to NULL) and telling it to exit.

(akpm: ick.  Needs to use kthread API and stop using signals)

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/md/md.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff -puN drivers/md/md.c~md-close-a-small-race-in-md-thread-deregistration drivers/md/md.c
--- 25/drivers/md/md.c~md-close-a-small-race-in-md-thread-deregistration	2005-04-12 03:21:50.230500704 -0700
+++ 25-akpm/drivers/md/md.c	2005-04-12 03:21:50.236499792 -0700
@@ -2840,16 +2840,6 @@ mdk_thread_t *md_register_thread(void (*
 	return thread;
 }
 
-static void md_interrupt_thread(mdk_thread_t *thread)
-{
-	if (!thread->tsk) {
-		MD_BUG();
-		return;
-	}
-	dprintk("interrupting MD-thread pid %d\n", thread->tsk->pid);
-	send_sig(SIGKILL, thread->tsk, 1);
-}
-
 void md_unregister_thread(mdk_thread_t *thread)
 {
 	struct completion event;
@@ -2857,9 +2847,15 @@ void md_unregister_thread(mdk_thread_t *
 	init_completion(&event);
 
 	thread->event = &event;
+
+	/* As soon as ->run is set to NULL, the task could disappear,
+	 * so we need to hold tasklist_lock until we have sent the signal
+	 */
+	dprintk("interrupting MD-thread pid %d\n", thread->tsk->pid);
+	read_lock(&tasklist_lock);
 	thread->run = NULL;
-	thread->name = NULL;
-	md_interrupt_thread(thread);
+	send_sig(SIGKILL, thread->tsk, 1);
+	read_unlock(&tasklist_lock);
 	wait_for_completion(&event);
 	kfree(thread);
 }
_
