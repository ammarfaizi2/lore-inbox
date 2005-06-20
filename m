Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVFTX51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVFTX51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVFTW7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:59:55 -0400
Received: from coderock.org ([193.77.147.115]:29337 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261703AbVFTV4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:56:02 -0400
Message-Id: <20050620215150.417217000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:50 +0200
From: domen@coderock.org
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 4/4] cdrom/mcdx: remove interruptible_sleep_on_timeout() usage
Content-Disposition: inline; filename=int_sleep_on-drivers_cdrom_mcdx.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Remove deprecated interruptible_sleep_on_timeout() function calls
and replace with direct wait-queue usage or wait_event() as appropriate. The
former replacements result in the same code. The latter change the tasks from
interruptible to uninterruptible, as signals were not being checked in the
current code. The corresponding wake_up() calls were fixed as well. This patch
will result in some slightly different debug output (for instance, one output
instead of one per iteration). Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 mcdx.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

Index: quilt/drivers/cdrom/mcdx.c
===================================================================
--- quilt.orig/drivers/cdrom/mcdx.c
+++ quilt/drivers/cdrom/mcdx.c
@@ -67,6 +67,7 @@ static const char *mcdx_c_version
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 #include <asm/io.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
@@ -835,11 +836,14 @@ static void mcdx_delay(struct s_drive_st
  *	May be we could use a simple count loop w/ jumps to itself, but
  *	I wanna make this independent of cpu speed. [1 jiffy is 1/HZ] sec */
 {
+	DEFINE_WAIT(wait);
 	if (jifs < 0)
 		return;
 
 	xtrace(SLEEP, "*** delay: sleepq\n");
-	interruptible_sleep_on_timeout(&stuff->sleepq, jifs);
+	prepare_to_wait(&stuff->sleepq, &wait, TASK_INTERRUPTIBLE);
+	schedule_timeout(jifs);
+	finish_wait(&stuff->sleepq, &wait);
 	xtrace(SLEEP, "delay awoken\n");
 	if (signal_pending(current)) {
 		xtrace(SLEEP, "got signal\n");
@@ -907,11 +911,9 @@ static int mcdx_talk(struct s_drive_stuf
 	if ((discard = (buffer == NULL)))
 		buffer = &c;
 
-	while (stuffp->lock) {
-		xtrace(SLEEP, "*** talk: lockq\n");
-		interruptible_sleep_on(&stuffp->lockq);
-		xtrace(SLEEP, "talk: awoken\n");
-	}
+	xtrace(SLEEP, "*** talk: lockq\n");
+	wait_event(stuffp->lockq, !stuffp->lock);
+	xtrace(SLEEP, "talk: awoken\n");
 
 	stuffp->lock = 1;
 
@@ -998,7 +1000,7 @@ static int mcdx_talk(struct s_drive_stuf
 #endif
 
 	stuffp->lock = 0;
-	wake_up_interruptible(&stuffp->lockq);
+	wake_up(&stuffp->lockq);
 
 	xtrace(TALK, "talk() done with 0x%02x\n", st);
 	return st;
@@ -1320,6 +1322,7 @@ static int mcdx_xfer(struct s_drive_stuf
 	Return:	-1 on timeout or other error
 			else status byte (as in stuff->st) */
 {
+	DEFINE_WAIT(wait);
 	int border;
 	int done = 0;
 	long timeout;
@@ -1334,9 +1337,7 @@ static int mcdx_xfer(struct s_drive_stuf
 		return -1;
 	}
 
-	while (stuffp->lock) {
-		interruptible_sleep_on(&stuffp->lockq);
-	}
+	wait_event(stuffp->lockq, !stuffp->lock);
 
 	if (stuffp->valid && (sector >= stuffp->pending)
 	    && (sector < stuffp->low_border)) {
@@ -1358,10 +1359,10 @@ static int mcdx_xfer(struct s_drive_stuf
 		do {
 
 			while (stuffp->busy) {
-
-				timeout =
-				    interruptible_sleep_on_timeout
-				    (&stuffp->busyq, 5 * HZ);
+				prepare_to_wait(&stuffp->busyq, &wait,
+						TASK_INTERRUPTIBLE);
+				timeout = schedule_timeout(5*HZ);
+				finish_wait(&stuffp->busyq, &wait);
 
 				if (!stuffp->introk) {
 					xtrace(XFER,
@@ -1377,7 +1378,7 @@ static int mcdx_xfer(struct s_drive_stuf
 				stuffp->busy = 0;
 				stuffp->valid = 0;
 
-				wake_up_interruptible(&stuffp->lockq);
+				wake_up(&stuffp->lockq);
 				xtrace(XFER, "transfer() done (-1)\n");
 				return -1;
 			}
@@ -1413,7 +1414,7 @@ static int mcdx_xfer(struct s_drive_stuf
 		} while (++(stuffp->pending) < border);
 
 		stuffp->lock = 0;
-		wake_up_interruptible(&stuffp->lockq);
+		wake_up(&stuffp->lockq);
 
 	} else {
 

--
