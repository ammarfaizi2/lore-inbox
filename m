Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVAOAtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVAOAtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVAOAta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:49:30 -0500
Received: from waste.org ([216.27.176.166]:8929 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262068AbVAOAtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:12 -0500
Date: Fri, 14 Jan 2005 18:49:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
Message-Id: <2.563253706@selenic.com>
Subject: [PATCH 1/10] random pt2: cleanup waitqueue logic, fix missed wakeup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original code checked in output pool for missed wakeup avoidance,
while waker (batch_entropy_process) checked input pool which could
result in a missed wakeup.

Move to wait_event_interruptible style
Delete superfluous waitqueue

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:27:58.178748133 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:27:58.951649596 -0800
@@ -1587,7 +1587,6 @@
 static ssize_t
 random_read(struct file * file, char __user * buf, size_t nbytes, loff_t *ppos)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	ssize_t n, retval = 0, count = 0;
 
 	if (nbytes == 0)
@@ -1613,20 +1612,20 @@
 				retval = -EAGAIN;
 				break;
 			}
+
+			DEBUG_ENT("sleeping?\n");
+
+			wait_event_interruptible(random_read_wait,
+				random_state->entropy_count >=
+						 random_read_wakeup_thresh);
+
+			DEBUG_ENT("awake\n");
+
 			if (signal_pending(current)) {
 				retval = -ERESTARTSYS;
 				break;
 			}
 
-			set_current_state(TASK_INTERRUPTIBLE);
-			add_wait_queue(&random_read_wait, &wait);
-
-			if (sec_random_state->entropy_count / 8 == 0)
-				schedule();
-
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&random_read_wait, &wait);
-
 			continue;
 		}
 
