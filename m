Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267192AbSLKPga>; Wed, 11 Dec 2002 10:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbSLKPga>; Wed, 11 Dec 2002 10:36:30 -0500
Received: from pc2-cmbg2-4-cust80.cmbg.cable.ntl.com ([80.2.247.80]:43000 "EHLO
	flat") by vger.kernel.org with ESMTP id <S267192AbSLKPg2>;
	Wed, 11 Dec 2002 10:36:28 -0500
From: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] use nice values in deadline IO scheduler
Date: Wed, 11 Dec 2002 15:44:16 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212111544.17336.cb-lkml@fish.zetnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This untested patch uses the nice value of the current task to scale the 
deadline for new read requests.

Does current contain a pointer to the task which caused the IO request at 
this point? Is there any other reason why this might be a daft thing to do?

--- drivers/block/deadline-iosched.c~std	2002-12-11 14:33:48.000000000 +0000
+++ drivers/block/deadline-iosched.c	2002-12-11 15:17:58.000000000 +0000
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/compiler.h>
 #include <linux/hash.h>
+#include <linux/sched.h>
 
 /*
  * feel free to try other values :-). read_expire value is the timeout for
@@ -81,6 +82,19 @@ static kmem_cache_t *drq_pool;
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
  * rq hash
  */
 static inline void __deadline_del_rq_hash(struct deadline_rq *drq)
@@ -440,7 +454,7 @@ deadline_add_request(request_queue_t *q,
 		/*
 		 * set expire time and add to fifo list
 		 */
-		drq->expires = jiffies + dd->read_expire;
+		drq->expires = jiffies + scale_deadline(dd->read_expire);
 		list_add_tail(&drq->fifo, &dd->read_fifo);
 	}
 }

