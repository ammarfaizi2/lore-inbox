Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263807AbUECXY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUECXY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbUECXY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:24:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:32977 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263807AbUECXYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:24:55 -0400
Date: Mon, 3 May 2004 16:27:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikkel Christiansen <mixxel@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: workqueue and pending
Message-Id: <20040503162719.54fb7020.akpm@osdl.org>
In-Reply-To: <40962F75.8000200@cs.auc.dk>
References: <40962F75.8000200@cs.auc.dk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikkel Christiansen <mixxel@cs.auc.dk> wrote:
>
> We're trying to use the workqueue interface for scheduling a delayed 
> gargage collector.
> Since we only need a single delayed thread we used the DECLEARE_WORK macro.
> 
> The problem is that once we call cancel_delayed_work we can't schedule 
> work again.

It looks like nobody has tried to do that yet.

> Having looked at the code i noticed that cancel_delayed_work only 
> deletes the timer but
> doesn't set clear the "pending" bit, thus any call to 
> schedule_delayed_work is ignorred.

Does this work?

--- 25/include/linux/workqueue.h~cancel_delayed_work-fix	Mon May  3 16:24:46 2004
+++ 25-akpm/include/linux/workqueue.h	Mon May  3 16:26:01 2004
@@ -7,6 +7,7 @@
 
 #include <linux/timer.h>
 #include <linux/linkage.h>
+#include <linux/bitops.h>
 
 struct workqueue_struct;
 
@@ -75,8 +76,11 @@ extern void init_workqueues(void);
  */
 static inline int cancel_delayed_work(struct work_struct *work)
 {
-	return del_timer_sync(&work->timer);
+	int ret;
+
+	ret = del_timer_sync(&work->timer);
+	clear_bit(0, &work->pending);
+	return ret;
 }
 
 #endif
-

_

