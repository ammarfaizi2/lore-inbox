Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWHTNPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWHTNPt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 09:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWHTNPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 09:15:48 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:47971 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750767AbWHTNPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 09:15:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=HulSXaKEDxHzZayNWpHFeKYdnRJKI1pAf9XpDQBiOOKNF3AkljBRoLOzKvItAsOkQEqYhSArgKIUqlqQGEDPnz36j2d8wUux08kuSzXM2w7y+DImok2lNDY/1TvPjvvkj9nTWCCVOa2SR3hgXLVsVd+gylUTwf/pdxL58svDfyg=
Date: Sun, 20 Aug 2006 22:15:42 +0900
From: Tejun Heo <htejun@gmail.com>
To: viro@zeniv.linux.org.uk, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] file: kill unnecessary timer in fdtable_defer
Message-ID: <20060820131542.GN6371@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
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
 fs/file.c |   29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

Index: work/fs/file.c
===================================================================
--- work.orig/fs/file.c
+++ work/fs/file.c
@@ -21,7 +21,6 @@
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
@@ -362,9 +340,6 @@ static void __devinit fdtable_defer_list
 	struct fdtable_defer *fddef = &per_cpu(fdtable_defer_list, cpu);
 	spin_lock_init(&fddef->lock);
 	INIT_WORK(&fddef->wq, (void (*)(void *))free_fdtable_work, fddef);
-	init_timer(&fddef->timer);
-	fddef->timer.data = (unsigned long)fddef;
-	fddef->timer.function = fdtable_timer;
 	fddef->next = NULL;
 }
 
