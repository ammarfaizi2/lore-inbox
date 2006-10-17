Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423051AbWJQLQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423051AbWJQLQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 07:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423059AbWJQLQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 07:16:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:57160 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423051AbWJQLQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 07:16:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Sa98vaql2Guq8HuPqRGb+j9O2DiUR/fitEaWw7DZUj1ErlISFVuvQ6lsEt0nXA7lyQLSaVT8vpGVjuTd4UZLzqC1MVPGzSQvZ2ZsoojwI3TNw89DZRbzwT2TBUJ9K/SvQeVVwFINElSljEUXUGlgabHrKdvG5uOS5oQSPhEKLQc=
Date: Tue, 17 Oct 2006 20:16:34 +0900
From: Tejun Heo <htejun@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@zeniv.linux.org.uk, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] file: kill unnecessary timer in fdtable_defer
Message-ID: <20061017111634.GD13677@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

free_fdtable_rc() schedules timer to reschedule fddef->wq if
schedule_work() on it returns 0.  However, schedule_work() guarantees
that the target work is executed at least once after the scheduling
regardless of its return value.  0 return simply means that the work
was already pending and thus no further action was required.

Another problem is that it used contant '5' as @expires argument to
mod_timer().

Kill unnecessary fddef->timer.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>
---

This patch was first posted on August 20th.  The original thread can
be seen at the following URL.

http://thread.gmane.org/gmane.linux.kernel/438712/focus=438712

Dipankar objected but the discussion was dropped in the middle.
Please read the thread for more info.  I still think this patch is
correct.

Andrew, please push this patch through -mm if this looks correct.

Thanks.

 file.c |   29 ++---------------------------
  1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 8e81775..d91db2c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -21,7 +21,6 @@ #include <linux/workqueue.h>
 struct fdtable_defer {
 	spinlock_t lock;
 	struct work_struct wq;
-	struct timer_list timer;
 	struct fdtable *next;
 };
 
@@ -75,22 +74,6 @@ static void __free_fdtable(struct fdtabl
 	kfree(fdt);
 }
 
-static void fdtable_timer(unsigned long data)
-{
-	struct fdtable_defer *fddef = (struct fdtable_defer *)data;
-
-	spin_lock(&fddef->lock);
-	/*
-	 * If someone already emptied the queue return.
-	 */
-	if (!fddef->next)
-		goto out;
-	if (!schedule_work(&fddef->wq))
-		mod_timer(&fddef->timer, 5);
-out:
-	spin_unlock(&fddef->lock);
-}
-
 static void free_fdtable_work(struct fdtable_defer *f)
 {
 	struct fdtable *fdt;
@@ -142,13 +125,8 @@ static void free_fdtable_rcu(struct rcu_
 		spin_lock(&fddef->lock);
 		fdt->next = fddef->next;
 		fddef->next = fdt;
-		/*
-		 * vmallocs are handled from the workqueue context.
-		 * If the per-cpu workqueue is running, then we
-		 * defer work scheduling through a timer.
-		 */
-		if (!schedule_work(&fddef->wq))
-			mod_timer(&fddef->timer, 5);
+		/* vmallocs are handled from the workqueue context */
+		schedule_work(&fddef->wq);
 		spin_unlock(&fddef->lock);
 		put_cpu_var(fdtable_defer_list);
 	}
@@ -352,9 +330,6 @@ static void __devinit fdtable_defer_list
 	struct fdtable_defer *fddef = &per_cpu(fdtable_defer_list, cpu);
 	spin_lock_init(&fddef->lock);
 	INIT_WORK(&fddef->wq, (void (*)(void *))free_fdtable_work, fddef);
-	init_timer(&fddef->timer);
-	fddef->timer.data = (unsigned long)fddef;
-	fddef->timer.function = fdtable_timer;
 	fddef->next = NULL;
 }
 
