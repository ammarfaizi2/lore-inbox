Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273802AbRIRB6z>; Mon, 17 Sep 2001 21:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273803AbRIRB6q>; Mon, 17 Sep 2001 21:58:46 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:6916 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S273802AbRIRB6h>; Mon, 17 Sep 2001 21:58:37 -0400
Date: Mon, 17 Sep 2001 21:59:01 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch to ymfpci (set_current_state repositioning)
Message-ID: <20010917215901.A17220@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

please consider the patch below for 2.4.10. Suggested by Arjan van
de Ven and confirmed with Alan, DaveM (I hope that I understood right
what they explained to me).

Yours,
-- Pete

--- linux-2.4.9/drivers/sound/ymfpci.c	Sun Aug 12 10:51:42 2001
+++ linux-2.4.9-niph/drivers/sound/ymfpci.c	Mon Sep 17 18:35:09 2001
@@ -457,11 +457,12 @@
 	}
 #endif
 
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	while (ypcm->running) {
 		spin_unlock_irqrestore(&unit->reg_lock, flags);
-		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 		spin_lock_irqsave(&unit->reg_lock, flags);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 	}
 	spin_unlock_irqrestore(&unit->reg_lock, flags);
 
@@ -1198,12 +1199,13 @@
 	ret = 0;
 
 	add_wait_queue(&dmabuf->wait, &waita);
+	set_current_state(TASK_INTERRUPTIBLE);
 	while (count > 0) {
 		spin_lock_irqsave(&unit->reg_lock, flags);
 		if (unit->suspended) {
 			spin_unlock_irqrestore(&unit->reg_lock, flags);
-			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (signal_pending(current)) {
 				if (!ret) ret = -EAGAIN;
 				break;
@@ -1241,9 +1243,9 @@
 			   is TOO LATE for the process to be scheduled to run (scheduler latency)
 			   which results in a (potential) buffer overrun. And worse, there is
 			   NOTHING we can do to prevent it. */
-			set_current_state(TASK_INTERRUPTIBLE);
 			tmo = schedule_timeout(tmo);
 			spin_lock_irqsave(&state->unit->reg_lock, flags);
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (tmo == 0 && dmabuf->count == 0) {
 				printk(KERN_ERR "ymfpci%d: recording schedule timeout, "
 				    "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
@@ -1326,12 +1328,13 @@
 	redzone *= 3;	/* 2 redzone + 1 possible uncertainty reserve. */
 
 	add_wait_queue(&dmabuf->wait, &waita);
+	set_current_state(TASK_INTERRUPTIBLE);
 	while (count > 0) {
 		spin_lock_irqsave(&unit->reg_lock, flags);
 		if (unit->suspended) {
 			spin_unlock_irqrestore(&unit->reg_lock, flags);
-			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (signal_pending(current)) {
 				if (!ret) ret = -EAGAIN;
 				break;
@@ -1389,8 +1392,8 @@
 				if (!ret) ret = -EAGAIN;
 				break;
 			}
-			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
+			set_current_state(TASK_INTERRUPTIBLE);
 			if (signal_pending(current)) {
 				if (!ret) ret = -ERESTARTSYS;
 				break;
