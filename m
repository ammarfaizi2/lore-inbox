Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275021AbTHFX3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275020AbTHFX3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:29:15 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:31958 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S275019AbTHFX3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:29:08 -0400
Date: Thu, 7 Aug 2003 01:28:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: cb-lkml@fish.zetnet.co.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Disk priority dependend on nice level...
Message-ID: <20030806232810.GA1623@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I ported `subj` to 2.6.0-test2. I do not yet have idea if it works,
but it compiles ;-).
								Pavel

--- clean/drivers/block/deadline-iosched.c	2003-07-27 22:31:10.000000000 +0200
+++ linux/drivers/block/deadline-iosched.c	2003-08-07 01:26:47.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/hash.h>
 #include <linux/rbtree.h>
+#include <linux/sched.h>
 
 /*
  * See Documentation/deadline-iosched.txt
@@ -106,6 +107,19 @@
 #define RQ_DATA(rq)	((struct deadline_rq *) (rq)->elevator_private)
 
 /*
+ * scale_deadline
+ */
+static int scale_deadline(int default_deadline)
+{
+	int prio = current->static_prio - MAX_RT_PRIO;
+	/* make priorities higher than nice -10 equal to nice -10 */
+	if (prio < 10)
+		prio = 10;
+	/* scale the deadline according to priority */
+	return default_deadline * prio/20;
+}
+
+/*
  * the back merge hash support functions
  */
 static inline void __deadline_del_drq_hash(struct deadline_rq *drq)
@@ -303,7 +317,7 @@
 	/*
 	 * set expire time (only used for reads) and add to fifo list
 	 */
-	drq->expires = jiffies + dd->fifo_expire[data_dir];
+	drq->expires = jiffies + scale_deadline(dd->fifo_expire[data_dir]);
 	list_add_tail(&drq->fifo, &dd->fifo_list[data_dir]);
 }
 
 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
