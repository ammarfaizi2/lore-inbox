Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268984AbUJTThg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268984AbUJTThg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269155AbUJTThb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:37:31 -0400
Received: from oss.sgi.com ([192.48.159.27]:16523 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id S268984AbUJTTgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:36:04 -0400
Date: Wed, 20 Oct 2004 12:36:04 -0700
From: John Hawkes <hawkes@oss.sgi.com>
Message-Id: <200410201936.i9KJa4FF026174@oss.sgi.com>
To: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com
Subject: [PATCH, 2.6.9] improved load_balance() tolerance for pinned tasks
Cc: hawkes@sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A large number of processes that are pinned to a single CPU results in
every other CPU's load_balance() seeing this overloaded CPU as "busiest",
yet move_tasks() never finds a task to pull-migrate.  This condition
occurs during module unload, but can also occur as a denial-of-service
using sys_sched_setaffinity().  Several hundred CPUs performing this
fruitless load_balance() will livelock on the busiest CPU's runqueue
lock.  A smaller number of CPUs will livelock if the pinned task count
gets high.  This simple patch remedies the more common first problem:
after a move_tasks() failure to migrate anything, the balance_interval
increments.  Using a simple increment, vs.  the more dramatic doubling of
the balance_interval, is conservative and yet also effective.

John Hawkes


Signed-off-by: John Hawkes <hawkes@sgi.com>




Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2004-10-19 15:04:11.000000000 -0700
+++ linux/kernel/sched.c	2004-10-19 15:09:50.000000000 -0700
@@ -2123,11 +2123,19 @@
 			 */
 			sd->nr_balance_failed = sd->cache_nice_tries;
 		}
-	} else
-		sd->nr_balance_failed = 0;
 
-	/* We were unbalanced, so reset the balancing interval */
-	sd->balance_interval = sd->min_interval;
+		/*
+		 * We were unbalanced, but unsuccessful in move_tasks(),
+		 * so bump the balance_interval to lessen the lock contention.
+		 */
+		if (sd->balance_interval < sd->max_interval)
+			sd->balance_interval++;
+	} else {
+                sd->nr_balance_failed = 0;
+
+		/* We were unbalanced, so reset the balancing interval */
+		sd->balance_interval = sd->min_interval;
+	}
 
 	return nr_moved;
 
