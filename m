Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWHTQTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWHTQTr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWHTQTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:19:47 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:48519 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750860AbWHTQTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:19:47 -0400
Date: Mon, 21 Aug 2006 00:43:45 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] sys_ioprio_set: don't disable irqs
Message-ID: <20060820204345.GA5750@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is not good to disable interrupts while traversing all tasks in the
system. As I see it, sys_ioprio_get() doesn't need to cli() at all,
sys_ioprio_set() does it for cfq_ioc_set_ioprio() which can do it itself.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/block/cfq-iosched.c~5_setpr	2006-08-09 22:00:44.000000000 +0400
+++ 2.6.18-rc4/block/cfq-iosched.c	2006-08-20 21:23:25.000000000 +0400
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
--- 2.6.18-rc4/fs/ioprio.c~5_setpr	2006-08-20 20:16:39.000000000 +0400
+++ 2.6.18-rc4/fs/ioprio.c	2006-08-20 21:21:26.000000000 +0400
@@ -81,7 +81,7 @@ asmlinkage long sys_ioprio_set(int which
 	}
 
 	ret = -ESRCH;
-	read_lock_irq(&tasklist_lock);
+	read_lock(&tasklist_lock);
 	switch (which) {
 		case IOPRIO_WHO_PROCESS:
 			if (!who)
@@ -124,7 +124,7 @@ free_uid:
 			ret = -EINVAL;
 	}
 
-	read_unlock_irq(&tasklist_lock);
+	read_unlock(&tasklist_lock);
 	return ret;
 }
 
@@ -170,7 +170,7 @@ asmlinkage long sys_ioprio_get(int which
 	int ret = -ESRCH;
 	int tmpio;
 
-	read_lock_irq(&tasklist_lock);
+	read_lock(&tasklist_lock);
 	switch (which) {
 		case IOPRIO_WHO_PROCESS:
 			if (!who)
@@ -221,7 +221,7 @@ asmlinkage long sys_ioprio_get(int which
 			ret = -EINVAL;
 	}
 
-	read_unlock_irq(&tasklist_lock);
+	read_unlock(&tasklist_lock);
 	return ret;
 }
 

