Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWAZDzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWAZDzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWAZDtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:33 -0500
Received: from [202.53.187.9] ([202.53.187.9]:20715 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932248AbWAZDtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:25 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 12/23] [Suspend2] Split freezing of threads according to whether user/kernelspace.
Date: Thu, 26 Jan 2006 13:45:51 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034551.3178.53576.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Split the freezing of threads according to whether they're userspace or
kernelspace threads. We use separate completion handlers, thereby allowing
for the possibility of thawing kernel space without thawing userspace.
This will be used to allow memory to be freed without it racing against
userspace.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   71 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 444a163..a3aca9a 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -45,8 +45,11 @@
  */
 #define TIMEOUT	(6 * HZ)
 
-DECLARE_COMPLETION(thaw);
-static atomic_t nr_frozen;
+
+DECLARE_COMPLETION(kernelspace_thaw);
+DECLARE_COMPLETION(userspace_thaw);
+static atomic_t nr_userspace_frozen;
+static atomic_t nr_kernelspace_frozen;
 
 struct frozen_fs
 {
@@ -120,32 +123,62 @@ static int freezeable(struct task_struct
 	return 1;
 }
 
+static void __freeze_process(struct completion *completion_handler,
+				atomic_t *nr_frozen)
+{
+	long save;
+
+	freezer_message("%s (%d) frozen.\n",
+			current->comm, current->pid);
+	save = current->state;
+	
+	atomic_inc(nr_frozen);
+	wait_for_completion(completion_handler);
+	atomic_dec(nr_frozen);
+	
+	current->state = save;
+	freezer_message("%s (%d) leaving freezer.\n",
+			current->comm, current->pid);
+}
+
 /*
  * Invoked by the task todo list notifier when the task to be
  * frozen is running.
  */
 static int freeze_process(struct notifier_block *nl, unsigned long x, void *v)
 {
-	/* Hmm, should we be allowed to suspend when there are realtime
-	   processes around? */
-	long save;
-	save = current->state;
-	pr_debug("%s frozen\n", current->comm);
+	unsigned long flags;
+
+	might_sleep();
+
+	/* Locking to handle race against waking the process in
+	 * freeze threads. */
+	spin_lock_irqsave(&current->sighand->siglock, flags);
 	current->flags |= PF_FROZEN;
-	notifier_chain_unregister(&current->todo, nl);
-	kfree(nl);
-	freezer_message("=");
-
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* We sent fake signal, clean it up */
-	atomic_inc(&nr_frozen);
-	spin_unlock_irq(&current->sighand->siglock);
 
-	wait_for_completion(&thaw);
+	if (nl)
+		notifier_chain_unregister(&current->todo, nl);
+
+	recalc_sigpending();
+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+
+	if (nl)
+		kfree(nl);
+
+	if (test_freezer_state(FREEZER_ON)) {
+		if (current->mm)
+			__freeze_process(&userspace_thaw, &nr_userspace_frozen);
+		else
+			__freeze_process(&kernelspace_thaw,
+					&nr_kernelspace_frozen);
+	}
+
+	spin_lock_irqsave(&current->sighand->siglock, flags);
+	recalc_sigpending();
+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+
 	current->flags &= ~PF_FROZEN;
-	atomic_dec(&nr_frozen);
-	pr_debug("%s thawed\n", current->comm);
-	current->state = save;
+
 	return 0;
 }
 

--
Nigel Cunningham		nigel at suspend2 dot net
