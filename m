Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVCFKe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVCFKe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 05:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCFKdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 05:33:21 -0500
Received: from coderock.org ([193.77.147.115]:57256 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261363AbVCFKcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 05:32:17 -0500
Subject: [patch 6/6] cdrom/mcdx: remove interruptible_sleep_on_timeout() usage
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 11:32:08 +0100
Message-Id: <20050306103208.671521F202@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



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


 kj-domen/drivers/cdrom/mcdx.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff -puN drivers/cdrom/mcdx.c~int_sleep_on-drivers_cdrom_mcdx drivers/cdrom/mcdx.c
--- kj/drivers/cdrom/mcdx.c~int_sleep_on-drivers_cdrom_mcdx	2005-03-05 16:13:16.000000000 +0100
+++ kj-domen/drivers/cdrom/mcdx.c	2005-03-05 16:13:16.000000000 +0100
@@ -67,6 +67,7 @@ static const char *mcdx_c_version
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 #include <asm/io.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
@@ -837,11 +838,14 @@ static void mcdx_delay(struct s_drive_st
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
@@ -909,11 +913,9 @@ static int mcdx_talk(struct s_drive_stuf
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
 
@@ -1000,7 +1002,7 @@ static int mcdx_talk(struct s_drive_stuf
 #endif
 
 	stuffp->lock = 0;
-	wake_up_interruptible(&stuffp->lockq);
+	wake_up(&stuffp->lockq);
 
 	xtrace(TALK, "talk() done with 0x%02x\n", st);
 	return st;
@@ -1322,6 +1324,7 @@ static int mcdx_xfer(struct s_drive_stuf
 	Return:	-1 on timeout or other error
 			else status byte (as in stuff->st) */
 {
+	DEFINE_WAIT(wait);
 	int border;
 	int done = 0;
 	long timeout;
@@ -1336,9 +1339,7 @@ static int mcdx_xfer(struct s_drive_stuf
 		return -1;
 	}
 
-	while (stuffp->lock) {
-		interruptible_sleep_on(&stuffp->lockq);
-	}
+	wait_event(stuffp->lockq, !stuffp->lock);
 
 	if (stuffp->valid && (sector >= stuffp->pending)
 	    && (sector < stuffp->low_border)) {
@@ -1360,10 +1361,10 @@ static int mcdx_xfer(struct s_drive_stuf
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
@@ -1379,7 +1380,7 @@ static int mcdx_xfer(struct s_drive_stuf
 				stuffp->busy = 0;
 				stuffp->valid = 0;
 
-				wake_up_interruptible(&stuffp->lockq);
+				wake_up(&stuffp->lockq);
 				xtrace(XFER, "transfer() done (-1)\n");
 				return -1;
 			}
@@ -1415,7 +1416,7 @@ static int mcdx_xfer(struct s_drive_stuf
 		} while (++(stuffp->pending) < border);
 
 		stuffp->lock = 0;
-		wake_up_interruptible(&stuffp->lockq);
+		wake_up(&stuffp->lockq);
 
 	} else {
 
_
