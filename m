Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVCFWlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVCFWlF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVCFWiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:38:11 -0500
Received: from coderock.org ([193.77.147.115]:55471 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261556AbVCFWgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:36:48 -0500
Subject: [patch 05/14] char/hvsi: use wait_event_timeout()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:29 +0100
Message-Id: <20050306223630.55D7C1ED3D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please consider applying. This is my first wait-queue related patch, so comments
are very welcome.

Use wait_event_timeout() in place of custom wait-queue code. The
code is not changed in any way (I don't think), but is cleaned up quite a bit
(will get expanded to almost identical code).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/hvsi.c |   41 ++++-------------------------------------
 1 files changed, 4 insertions(+), 37 deletions(-)

diff -puN drivers/char/hvsi.c~wait_event_timeout-drivers_char_hvsi drivers/char/hvsi.c
--- kj/drivers/char/hvsi.c~wait_event_timeout-drivers_char_hvsi	2005-03-05 16:11:27.000000000 +0100
+++ kj-domen/drivers/char/hvsi.c	2005-03-05 16:11:27.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/sysrq.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/wait.h>
 #include <asm/hvcall.h>
 #include <asm/hvconsole.h>
 #include <asm/prom.h>
@@ -631,27 +632,10 @@ static int __init poll_for_state(struct 
 /* wait for irq handler to change our state */
 static int wait_for_state(struct hvsi_struct *hp, int state)
 {
-	unsigned long end_jiffies = jiffies + HVSI_TIMEOUT;
-	unsigned long timeout;
 	int ret = 0;
 
-	DECLARE_WAITQUEUE(myself, current);
-	set_current_state(TASK_INTERRUPTIBLE);
-	add_wait_queue(&hp->stateq, &myself);
-
-	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (hp->state == state)
-			break;
-		timeout = end_jiffies - jiffies;
-		if (time_after(jiffies, end_jiffies)) {
-			ret = -EIO;
-			break;
-		}
-		schedule_timeout(timeout);
-	}
-	remove_wait_queue(&hp->stateq, &myself);
-	set_current_state(TASK_RUNNING);
+	if(!wait_event_timeout(hp->stateq, (hp->state == state), jiffies + HVSI_TIMEOUT))
+		ret = -EIO;
 
 	return ret;
 }
@@ -868,24 +852,7 @@ static int hvsi_open(struct tty_struct *
 /* wait for hvsi_write_worker to empty hp->outbuf */
 static void hvsi_flush_output(struct hvsi_struct *hp)
 {
-	unsigned long end_jiffies = jiffies + HVSI_TIMEOUT;
-	unsigned long timeout;
-
-	DECLARE_WAITQUEUE(myself, current);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	add_wait_queue(&hp->emptyq, &myself);
-
-	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (hp->n_outbuf <= 0)
-			break;
-		timeout = end_jiffies - jiffies;
-		if (time_after(jiffies, end_jiffies))
-			break;
-		schedule_timeout(timeout);
-	}
-	remove_wait_queue(&hp->emptyq, &myself);
-	set_current_state(TASK_RUNNING);
+	wait_event_timeout(hp->emptyq, (hp->n_outbuf <= 0), jiffies + HVSI_TIMEOUT);
 
 	/* 'writer' could still be pending if it didn't see n_outbuf = 0 yet */
 	cancel_delayed_work(&hp->writer);
_
