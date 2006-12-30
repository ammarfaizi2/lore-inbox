Return-Path: <linux-kernel-owner+w=401wt.eu-S1755083AbWL3Ctl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbWL3Ctl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 21:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWL3Ctl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 21:49:41 -0500
Received: from mga03.intel.com ([143.182.124.21]:4054 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755083AbWL3Ctk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 21:49:40 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,220,1165219200"; 
   d="scan'208"; a="163611200:sNHT46330529"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, <zach.brown@oracle.com>
Cc: <linux-aio@kvack.org>, <linux-kernel@vger.kernel.org>,
       "'Benjamin LaHaise'" <bcrl@kvack.org>, <suparna@in.ibm.com>
Subject: [patch] aio: streamline read events after woken up
Date: Fri, 29 Dec 2006 18:49:39 -0800
Message-ID: <000301c72bbd$26a37b90$d634030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccrvSZnRLqfWMyUSJKfhN8xeMw8jg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The read event loop in the blocking path is also inefficient. For every
event it reap (if not blocking), it does the following in a loop:

      while (i < nr) {
            prepare_to_wait_exclusive
            aio_read_evt
            finish_wait
            ...
      }

Given the previous patch "aio: add per task aio wait event condition"
that we properly wake up event waiting process knowing that we have
enough events to reap, it's just plain waste of time to insert itself
into a wait queue, and then immediately remove itself from the wait
queue for *every* event reap iteration.

This patch factors out the wait queue insertion/deletion out of the event
reap loop, streamlines the event reaping after the process wakes up.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./fs/aio.c.orig	2006-12-24 17:04:52.000000000 -0800
+++ ./fs/aio.c	2006-12-24 17:05:10.000000000 -0800
@@ -1174,42 +1174,40 @@ retry:
 	}
 
 	aio_init_wait(&wait);
+wait:
+	prepare_to_wait_exclusive(&ctx->wait, &wait.wait, TASK_INTERRUPTIBLE);
+	ret = aio_read_evt(ctx, &ent);
+	if (!ret) {
+		wait.nr_wait = min_nr - i;
+		schedule();
+		if (signal_pending(tsk))
+			ret = -EINTR;
+	}
+	finish_wait(&ctx->wait, &wait.wait);
+
+	if (ret < 0)
+		goto out_cleanup;
+
 	while (likely(i < nr)) {
-		do {
-			prepare_to_wait_exclusive(&ctx->wait, &wait.wait,
-						  TASK_INTERRUPTIBLE);
-			ret = aio_read_evt(ctx, &ent);
-			if (ret)
-				break;
-			if (min_nr <= i)
-				break;
-			ret = 0;
-			if (to.timed_out)	/* Only check after read evt */
-				break;
-			wait.nr_wait = min_nr - i;
-			schedule();
-			if (signal_pending(tsk)) {
-				ret = -EINTR;
+		if (ret) {
+			if (unlikely(copy_to_user(event, &ent, sizeof(ent)))) {
+				dprintk("aio: lost an event due to EFAULT.\n");
+				ret = -EFAULT;
 				break;
 			}
-			/*ret = aio_read_evt(ctx, &ent);*/
-		} while (1) ;
-		finish_wait(&ctx->wait, &wait.wait);
-
-		if (unlikely(ret <= 0))
-			break;
+			event++;
+			i++;
+		}
 
-		ret = -EFAULT;
-		if (unlikely(copy_to_user(event, &ent, sizeof(ent)))) {
-			dprintk("aio: lost an event due to EFAULT.\n");
+		ret = aio_read_evt(ctx, &ent);
+		if (unlikely(!ret)) {
+			if (i < min_nr && !to.timed_out)
+				goto wait;
 			break;
 		}
-
-		/* Good, event copied to userland, update counts. */
-		event ++;
-		i ++;
 	}
 
+out_cleanup:
 	if (timeout)
 		clear_timeout(&to);
 out:
