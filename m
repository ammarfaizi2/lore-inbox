Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUJEDy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUJEDy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 23:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268664AbUJEDy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 23:54:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:43934 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267619AbUJEDx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 23:53:59 -0400
Date: Mon, 4 Oct 2004 20:51:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: jstubbs@work-at.co.jp, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Message-Id: <20041004205136.49317eb7.akpm@osdl.org>
In-Reply-To: <52brfhvs46.fsf@topspin.com>
References: <200410041611.17000.jstubbs@work-at.co.jp>
	<20041004013548.26e853fc.akpm@osdl.org>
	<200410041931.00159.jstubbs@work-at.co.jp>
	<20041004120535.3c68115a.akpm@osdl.org>
	<52brfhvs46.fsf@topspin.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
> 	@@ -2375,7 +2372,7 @@ void ip_vs_control_cleanup(void)
>  	 {
>  	 	EnterFunction(2);
>  	 	ip_vs_trash_cleanup();
>  	-	del_timer_sync(&defense_timer);
>  	+	cancel_delayed_work(&defense_work);
> 
>  Do we need a flush_scheduled_work() here to be totally safe?  Not sure
>  if it could ever really happen but it seems the module could at least
>  theoretically be unloaded with update_defense_level() still running...

Excellent point.  We don't appear to have a function which does that.

How does this look?

(It's probably wrong, actually.  THis stuff's tricky.  In particular, the
work handler *has* to re-add the delayed work, 100% of the time.)




Add library functions to reliably kill off a delayed work whose handler
re-adds the delayed work.  One for keventd, one for caller-owned workqueues.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/workqueue.h |    3 +++
 25-akpm/kernel/workqueue.c        |   25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff -puN kernel/workqueue.c~cancel_rearming_delayed_work kernel/workqueue.c
--- 25/kernel/workqueue.c~cancel_rearming_delayed_work	2004-10-04 20:48:23.397238464 -0700
+++ 25-akpm/kernel/workqueue.c	2004-10-04 20:48:23.402237704 -0700
@@ -423,6 +423,31 @@ void flush_scheduled_work(void)
 	flush_workqueue(keventd_wq);
 }
 
+/**
+ * cancel_rearming_delayed_workqueue - reliably kill off a delayed
+ *			work whose handler rearms the delayed work.
+ * @wq:   the controlling workqueue structure
+ * @work: the delayed work struct
+ */
+void cancel_rearming_delayed_workqueue(struct workqueue_struct *wq,
+					struct work_struct *work)
+{
+	while (!cancel_delayed_work(work))
+		flush_workqueue(wq);
+}
+EXPORT_SYMBOL(cancel_rearming_delayed_workqueue);
+
+/**
+ * cancel_rearming_delayed_work - reliably kill off a delayed keventd
+ *			work whose handler rearms the delayed work.
+ * @work: the delayed work struct
+ */
+void cancel_rearming_delayed_work(struct work_struct *work)
+{
+	cancel_rearming_delayed_workqueue(keventd_wq, work);
+}
+EXPORT_SYMBOL(cancel_rearming_delayed_work);
+
 int keventd_up(void)
 {
 	return keventd_wq != NULL;
diff -puN include/linux/workqueue.h~cancel_rearming_delayed_work include/linux/workqueue.h
--- 25/include/linux/workqueue.h~cancel_rearming_delayed_work	2004-10-04 20:48:23.398238312 -0700
+++ 25-akpm/include/linux/workqueue.h	2004-10-04 20:48:23.403237552 -0700
@@ -70,6 +70,9 @@ extern int current_is_keventd(void);
 extern int keventd_up(void);
 
 extern void init_workqueues(void);
+void cancel_rearming_delayed_workqueue(struct workqueue_struct *wq,
+					struct work_struct *work);
+void cancel_rearming_delayed_work(struct work_struct *work);
 
 /*
  * Kill off a pending schedule_delayed_work().  Note that the work callback
_

