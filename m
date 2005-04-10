Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVDJTI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVDJTI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 15:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVDJTIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 15:08:38 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:54486 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261565AbVDJTHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 15:07:45 -0400
Subject: [PATCH] re-export cancel_rearming_delayed_workqueue
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 14:07:23 -0500
Message-Id: <1113160044.6737.12.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was unexported by Arjan because we have no current users.

However, during a conversion from tasklets to workqueues of the parisc
led functions, we ran across a case where this was needed.  In
particular, the open coded equivalent of
cancel_rearming_delayed_workqueue was implemented incorrectly, which is,
I think, all the evidence necessary that this is a useful API.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

===== include/linux/workqueue.h 1.10 vs edited =====
--- 1.10/include/linux/workqueue.h	2005-02-15 15:56:55 -06:00
+++ edited/include/linux/workqueue.h	2005-04-05 11:13:50 -05:00
@@ -71,6 +71,8 @@
 
 extern void init_workqueues(void);
 void cancel_rearming_delayed_work(struct work_struct *work);
+void cancel_rearming_delayed_workqueue(struct workqueue_struct *,
+				       struct work_struct *);
 
 /*
  * Kill off a pending schedule_delayed_work().  Note that the work callback
===== kernel/workqueue.c 1.33 vs edited =====
--- 1.33/kernel/workqueue.c	2005-02-22 21:23:08 -06:00
+++ edited/kernel/workqueue.c	2005-04-05 11:13:52 -05:00
@@ -429,12 +429,13 @@
  * @wq:   the controlling workqueue structure
  * @work: the delayed work struct
  */
-static void cancel_rearming_delayed_workqueue(struct workqueue_struct *wq,
-					struct work_struct *work)
+void cancel_rearming_delayed_workqueue(struct workqueue_struct *wq,
+				       struct work_struct *work)
 {
 	while (!cancel_delayed_work(work))
 		flush_workqueue(wq);
 }
+EXPORT_SYMBOL(cancel_rearming_delayed_workqueue);
 
 /**
  * cancel_rearming_delayed_work - reliably kill off a delayed keventd


