Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVDLKbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVDLKbC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVDLKbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:31:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:51655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262104AbVDLKaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:30:52 -0400
Message-Id: <200504121030.j3CAUkiQ005143@shell0.pdx.osdl.net>
Subject: [patch 008/198] re-export cancel_rearming_delayed_workqueue
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, James.Bottomley@SteelEye.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: James Bottomley <James.Bottomley@SteelEye.com>

This was unexported by Arjan because we have no current users.

However, during a conversion from tasklets to workqueues of the parisc led
functions, we ran across a case where this was needed.  In particular, the
open coded equivalent of cancel_rearming_delayed_workqueue was implemented
incorrectly, which is, I think, all the evidence necessary that this is a
useful API.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/workqueue.h |    2 ++
 25-akpm/kernel/workqueue.c        |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff -puN include/linux/workqueue.h~re-export-cancel_rearming_delayed_workqueue include/linux/workqueue.h
--- 25/include/linux/workqueue.h~re-export-cancel_rearming_delayed_workqueue	2005-04-12 03:21:05.391317296 -0700
+++ 25-akpm/include/linux/workqueue.h	2005-04-12 03:21:05.396316536 -0700
@@ -71,6 +71,8 @@ extern int keventd_up(void);
 
 extern void init_workqueues(void);
 void cancel_rearming_delayed_work(struct work_struct *work);
+void cancel_rearming_delayed_workqueue(struct workqueue_struct *,
+				       struct work_struct *);
 
 /*
  * Kill off a pending schedule_delayed_work().  Note that the work callback
diff -puN kernel/workqueue.c~re-export-cancel_rearming_delayed_workqueue kernel/workqueue.c
--- 25/kernel/workqueue.c~re-export-cancel_rearming_delayed_workqueue	2005-04-12 03:21:05.392317144 -0700
+++ 25-akpm/kernel/workqueue.c	2005-04-12 03:21:05.397316384 -0700
@@ -429,12 +429,13 @@ void flush_scheduled_work(void)
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
_
