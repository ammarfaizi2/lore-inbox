Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVCFWlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVCFWlA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVCFWk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:40:56 -0500
Received: from coderock.org ([193.77.147.115]:57775 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261562AbVCFWg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:36:56 -0500
Subject: [patch 07/14] char/lp: remove interruptible_sleep_on_timeout() usage
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:36 +0100
Message-Id: <20050306223637.36E621EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Replace deprecated interruptible_sleep_on_timeout() function calls
with direct wait-queue usage. There may be an existing problem with this driver,
as I am not finding any wake_up_interruptible() callers for the waitq. 
Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/lp.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -puN drivers/char/lp.c~int_sleep_on-drivers_char_lp drivers/char/lp.c
--- kj/drivers/char/lp.c~int_sleep_on-drivers_char_lp	2005-03-05 16:12:05.000000000 +0100
+++ kj-domen/drivers/char/lp.c	2005-03-05 16:12:05.000000000 +0100
@@ -127,6 +127,7 @@
 #include <linux/poll.h>
 #include <linux/console.h>
 #include <linux/device.h>
+#include <linux/wait.h>
 
 #include <linux/parport.h>
 #undef LP_STATS
@@ -218,6 +219,7 @@ static int lp_reset(int minor)
 
 static void lp_error (int minor)
 {
+	DEFINE_WAIT(wait);
 	int polling;
 
 	if (LP_F(minor) & LP_ABORT)
@@ -225,8 +227,9 @@ static void lp_error (int minor)
 
 	polling = lp_table[minor].dev->port->irq == PARPORT_IRQ_NONE;
 	if (polling) lp_release_parport (&lp_table[minor]);
-	interruptible_sleep_on_timeout (&lp_table[minor].waitq,
-					LP_TIMEOUT_POLLED);
+	prepare_to_wait(&lp_table[minor].waitq, &wait, TASK_INTERRUPTIBLE);
+	schedule_timeout(LP_TIMEOUT_POLLED);
+	finish_wait(&lp_table[minor].waitq, &wait);
 	if (polling) lp_claim_parport_or_block (&lp_table[minor]);
 	else parport_yield_blocking (lp_table[minor].dev);
 }
@@ -410,6 +413,7 @@ static ssize_t lp_write(struct file * fi
 static ssize_t lp_read(struct file * file, char __user * buf,
 		       size_t count, loff_t *ppos)
 {
+	DEFINE_WAIT(wait);
 	unsigned int minor=iminor(file->f_dentry->d_inode);
 	struct parport *port = lp_table[minor].dev->port;
 	ssize_t retval = 0;
@@ -458,9 +462,11 @@ static ssize_t lp_read(struct file * fil
 				retval = -EIO;
 				goto out;
 			}
-		} else
-			interruptible_sleep_on_timeout (&lp_table[minor].waitq,
-							LP_TIMEOUT_POLLED);
+		} else {
+			prepare_to_wait(&lp_table[minor].waitq, &wait, TASK_INTERRUPTIBLE);
+			schedule_timeout(LP_TIMEOUT_POLLED);
+			finish_wait(&lp_table[minor].waitq, &wait);
+		}
 
 		if (signal_pending (current)) {
 			retval = -ERESTARTSYS;
_
