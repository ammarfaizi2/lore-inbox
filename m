Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWHZQfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWHZQfk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 12:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWHZQfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 12:35:40 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:32917 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1422666AbWHZQfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 12:35:40 -0400
Date: Sun, 27 Aug 2006 00:59:49 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sys_ioprio_set: don't disable irqs
Message-ID: <20060826205949.GA1140@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is not good to disable interrupts while traversing all tasks in the system.
As I see it, sys_ioprio_get() doesn't need to do it at all, sys_ioprio_set()
does it for cfq_ioc_set_ioprio(), the latter can disable irqs itself.

Also, add a comment to explain why do we need tasklist_lock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/block/cfq-iosched.c~5_setpr	2006-08-27 00:37:03.000000000 +0400
+++ 2.6.18-rc4/block/cfq-iosched.c	2006-08-27 00:38:57.000000000 +0400
@@ -1421,14 +1421,14 @@ static inline void changed_ioprio(struct
 }
 
 /*
- * callback from sys_ioprio_set, irqs are disabled
+ * callback from sys_ioprio_set.
  */
 static int cfq_ioc_set_ioprio(struct io_context *ioc, unsigned int ioprio)
 {
 	struct cfq_io_context *cic;
 	struct rb_node *n;
 
-	spin_lock(&cfq_exit_lock);
+	spin_lock_irq(&cfq_exit_lock);
 
 	n = rb_first(&ioc->cic_root);
 	while (n != NULL) {
@@ -1438,7 +1438,7 @@ static int cfq_ioc_set_ioprio(struct io_
 		n = rb_next(n);
 	}
 
-	spin_unlock(&cfq_exit_lock);
+	spin_unlock_irq(&cfq_exit_lock);
 
 	return 0;
 }
--- 2.6.18-rc4/fs/ioprio.c~5_setpr	2006-08-27 00:37:03.000000000 +0400
+++ 2.6.18-rc4/fs/ioprio.c	2006-08-27 00:54:17.000000000 +0400
@@ -81,7 +81,12 @@ asmlinkage long sys_ioprio_set(int which
 	}
 
 	ret = -ESRCH;
-	read_lock_irq(&tasklist_lock);
+	/*
+	 * We want IOPRIO_WHO_PGRP/IOPRIO_WHO_USER to be "atomic",
+	 * so we can't use rcu_read_lock(). See re-copy of ->ioprio
+	 * in copy_process().
+	 */
+	read_lock(&tasklist_lock);
 	switch (which) {
 		case IOPRIO_WHO_PROCESS:
 			if (!who)
@@ -124,7 +129,7 @@ free_uid:
 			ret = -EINVAL;
 	}
 
-	read_unlock_irq(&tasklist_lock);
+	read_unlock(&tasklist_lock);
 	return ret;
 }
 
@@ -170,7 +175,7 @@ asmlinkage long sys_ioprio_get(int which
 	int ret = -ESRCH;
 	int tmpio;
 
-	read_lock_irq(&tasklist_lock);
+	read_lock(&tasklist_lock);
 	switch (which) {
 		case IOPRIO_WHO_PROCESS:
 			if (!who)
@@ -221,7 +226,7 @@ asmlinkage long sys_ioprio_get(int which
 			ret = -EINVAL;
 	}
 
-	read_unlock_irq(&tasklist_lock);
+	read_unlock(&tasklist_lock);
 	return ret;
 }
 

