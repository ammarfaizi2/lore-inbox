Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937912AbWLGBWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937912AbWLGBWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937914AbWLGBWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:22:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34139 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937912AbWLGBWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:22:20 -0500
Date: Wed, 6 Dec 2006 17:21:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org> <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Linus Torvalds wrote:
> 
> How about something like this?

I didn't get any answers on this. I'd like to get this issue resolved, but 
since I don't even use libphy on my main machine, I need somebody else to 
test it for me.

Just to remind you all, here's the patch again. This is identical to the 
previous version except for the trivial cleanup to use "work_pending()" 
instead of open-coding it in two places.

		Linus

----
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4044bb1..e175f39 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -587,8 +587,7 @@ int phy_stop_interrupts(struct phy_device *phydev)
 	 * Finish any pending work; we might have been scheduled
 	 * to be called from keventd ourselves, though.
 	 */
-	if (!current_is_keventd())
-		flush_scheduled_work();
+	run_scheduled_work(&phydev->phy_queue);
 
 	free_irq(phydev->irq, phydev);
 
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 4a3ea83..a601ed5 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -160,6 +160,7 @@ extern int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
+extern int FASTCALL(run_scheduled_work(struct work_struct *work));
 extern int FASTCALL(schedule_delayed_work(struct delayed_work *work, unsigned long delay));
 
 extern int schedule_delayed_work_on(int cpu, struct delayed_work *work, unsigned long delay);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8d1e7cb..36f9b78 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -103,6 +103,79 @@ static inline void *get_wq_data(struct work_struct *work)
 	return (void *) (work->management & WORK_STRUCT_WQ_DATA_MASK);
 }
 
+static int __run_work(struct cpu_workqueue_struct *cwq, struct work_struct *work)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cwq->lock, flags);
+	/*
+	 * We need to re-validate the work info after we've gotten
+	 * the cpu_workqueue lock. We can run the work now iff:
+	 *
+	 *  - the wq_data still matches the cpu_workqueue_struct
+	 *  - AND the work is still marked pending
+	 *  - AND the work is still on a list (which will be this
+	 *    workqueue_struct list)
+	 *
+	 * All these conditions are important, because we
+	 * need to protect against the work being run right
+	 * now on another CPU (all but the last one might be
+	 * true if it's currently running and has not been
+	 * released yet, for example).
+	 */
+	if (get_wq_data(work) == cwq
+	    && work_pending(work)
+	    && !list_empty(&work->entry)) {
+		work_func_t f = work->func;
+		list_del_init(&work->entry);
+		spin_unlock_irqrestore(&cwq->lock, flags);
+
+		if (!test_bit(WORK_STRUCT_NOAUTOREL, &work->management))
+			work_release(work);
+		f(work);
+
+		spin_lock_irqsave(&cwq->lock, flags);
+		cwq->remove_sequence++;
+		wake_up(&cwq->work_done);
+		ret = 1;
+	}
+	spin_unlock_irqrestore(&cwq->lock, flags);
+	return ret;
+}
+
+/**
+ * run_scheduled_work - run scheduled work synchronously
+ * @work: work to run
+ *
+ * This checks if the work was pending, and runs it
+ * synchronously if so. It returns a boolean to indicate
+ * whether it had any scheduled work to run or not.
+ *
+ * NOTE! This _only_ works for normal work_structs. You
+ * CANNOT use this for delayed work, because the wq data
+ * for delayed work will not point properly to the per-
+ * CPU workqueue struct, but will change!
+ */
+int fastcall run_scheduled_work(struct work_struct *work)
+{
+	for (;;) {
+		struct cpu_workqueue_struct *cwq;
+
+		if (!work_pending(work))
+			return 0;
+		if (list_empty(&work->entry))
+			return 0;
+		/* NOTE! This depends intimately on __queue_work! */
+		cwq = get_wq_data(work);
+		if (!cwq)
+			return 0;
+		if (__run_work(cwq, work))
+			return 1;
+	}
+}
+EXPORT_SYMBOL(run_scheduled_work);
+
 /* Preempt must be disabled. */
 static void __queue_work(struct cpu_workqueue_struct *cwq,
 			 struct work_struct *work)
