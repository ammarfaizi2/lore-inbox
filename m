Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269286AbUINLcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269286AbUINLcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269299AbUINL2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:28:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44932 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269319AbUINL1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:27:02 -0400
Date: Tue, 14 Sep 2004 13:25:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch] fix keventd execution dependency
Message-ID: <20040914112548.GB592@elte.hu>
References: <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914110838.GA32466@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20040914110838.GA32466@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


We dont want to execute off keventd since it might hold a semaphore our
callers hold too. This can happen when kthread_create() is called from
within keventd. This happened due to the IRQ threading patches but it
could happen with other code too.

	Ingo

--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-keventd.patch"


We dont want to execute off keventd since it might hold a semaphore our
callers hold too. This can happen when kthread_create() is called from
within keventd. This happened due to the IRQ threading patches but it
could happen with other code too.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/kthread.c.orig	
+++ linux/kernel/kthread.c	
@@ -14,6 +14,12 @@
 #include <linux/module.h>
 #include <asm/semaphore.h>
 
+/*
+ * We dont want to execute off keventd since it might
+ * hold a semaphore our callers hold too:
+ */
+static struct workqueue_struct *helper_wq;
+
 struct kthread_create_info
 {
 	/* Information passed to kthread() from keventd. */
@@ -126,12 +132,13 @@ struct task_struct *kthread_create(int (
 	init_completion(&create.started);
 	init_completion(&create.done);
 
-	/* If we're being called to start the first workqueue, we
-	 * can't use keventd. */
-	if (!keventd_up())
+	/*
+	 * The workqueue needs to start up first:
+	 */
+	if (!helper_wq)
 		work.func(work.data);
 	else {
-		schedule_work(&work);
+		queue_work(helper_wq, &work);
 		wait_for_completion(&create.done);
 	}
 	if (!IS_ERR(create.result)) {
@@ -183,3 +190,13 @@ int kthread_stop(struct task_struct *k)
 	return ret;
 }
 EXPORT_SYMBOL(kthread_stop);
+
+static __init int helper_init(void)
+{
+	helper_wq = create_singlethread_workqueue("kthread");
+	BUG_ON(!helper_wq);
+
+	return 0;
+}
+core_initcall(helper_init);
+

--Bn2rw/3z4jIqBvZU--
