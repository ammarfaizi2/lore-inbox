Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUCYX6C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUCYX6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:58:02 -0500
Received: from waste.org ([209.173.204.2]:45209 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263574AbUCYX54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:57:56 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.524465763@selenic.com>
Message-Id: <3.524465763@selenic.com>
Subject: [PATCH 2/22] /dev/random: Cleanup sleep logic
Date: Thu, 25 Mar 2004 17:57:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleanup /dev/random sleep logic

Original code checked in output pool rather than input pool for wakeup
Move to wait_event_interruptible style
Delete superfluous waitqueue


 tiny-mpm/drivers/char/random.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff -puN drivers/char/random.c~fix-random-wait drivers/char/random.c
--- tiny/drivers/char/random.c~fix-random-wait	2004-03-20 13:35:06.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:35:06.000000000 -0600
@@ -1556,9 +1556,8 @@ void rand_initialize_disk(struct gendisk
 static ssize_t
 random_read(struct file * file, char * buf, size_t nbytes, loff_t *ppos)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	ssize_t			n, retval = 0, count = 0;
-	
+	ssize_t	n, retval = 0, count = 0;
+
 	if (nbytes == 0)
 		return 0;
 
@@ -1582,20 +1581,20 @@ random_read(struct file * file, char * b
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
 

_
