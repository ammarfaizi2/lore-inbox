Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWHaBFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWHaBFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 21:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWHaBFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 21:05:01 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:53456 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932279AbWHaBFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 21:05:00 -0400
Date: Wed, 30 Aug 2006 18:05:04 -0700
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       video4linux-list@redhat.com, kraxel@bytesex.org, haveblue@us.ibm.com,
       serue@us.ibm.com, Containers@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] kthread: tvaudio.c
Message-ID: <20060831010504.GB2198@us.ibm.com>
References: <20060829211555.GB1945@us.ibm.com> <20060829143902.a6aa2712.akpm@osdl.org> <44F5BD23.3000209@fr.ibm.com> <20060830094943.bad0d618.akpm@osdl.org> <1156959402.3852.82.camel@praia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156959402.3852.82.camel@praia>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replaced kernel_thread() with kthread_run() since kernel_thread() is
deprecated in drivers/modules.

Removed the completion and the wait queue which are now useless with
kthread. Also removed the allow_signal() call as signals don't apply
to kernel threads.

Fixed a small race condition when thread is stopped.

Please check if the timer vs. thread still works fine without the wait
queue.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Cc: Serge Hallyn <serue@us.ibm.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Containers@lists.osdl.org
Cc: video4linux-list@redhat.com
Cc: v4l-dvb-maintainer@linuxtv.org

 drivers/media/video/tvaudio.c |   42 ++++++++++++++++--------------------------
 1 files changed, 16 insertions(+), 26 deletions(-)

Index: lx26-18-rc5/drivers/media/video/tvaudio.c
===================================================================
--- lx26-18-rc5.orig/drivers/media/video/tvaudio.c	2006-08-29 14:02:44.000000000 -0700
+++ lx26-18-rc5/drivers/media/video/tvaudio.c	2006-08-30 17:52:17.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/i2c-algo-bit.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/kthread.h>

 #include <media/tvaudio.h>
 #include <media/v4l2-common.h>
@@ -124,11 +125,8 @@ struct CHIPSTATE {
 	int input;

 	/* thread */
-	pid_t                tpid;
-	struct completion    texit;
-	wait_queue_head_t    wq;
+	struct task_struct   *thread;
 	struct timer_list    wt;
-	int                  done;
 	int                  watch_stereo;
 	int 		     audmode;
 };
@@ -264,28 +262,23 @@ static int chip_cmd(struct CHIPSTATE *ch
 static void chip_thread_wake(unsigned long data)
 {
 	struct CHIPSTATE *chip = (struct CHIPSTATE*)data;
-	wake_up_interruptible(&chip->wq);
+	wake_up_process(chip->thread);
 }

 static int chip_thread(void *data)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct CHIPSTATE *chip = data;
 	struct CHIPDESC  *desc = chiplist + chip->type;

-	daemonize("%s", chip->c.name);
-	allow_signal(SIGTERM);
 	v4l_dbg(1, debug, &chip->c, "%s: thread started\n", chip->c.name);

 	for (;;) {
-		add_wait_queue(&chip->wq, &wait);
-		if (!chip->done) {
-			set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!kthread_should_stop())
 			schedule();
-		}
-		remove_wait_queue(&chip->wq, &wait);
+		set_current_state(TASK_RUNNING);
 		try_to_freeze();
-		if (chip->done || signal_pending(current))
+		if (kthread_should_stop())
 			break;
 		v4l_dbg(1, debug, &chip->c, "%s: thread wakeup\n", chip->c.name);

@@ -301,7 +294,6 @@ static int chip_thread(void *data)
 	}

 	v4l_dbg(1, debug, &chip->c, "%s: thread exiting\n", chip->c.name);
-	complete_and_exit(&chip->texit, 0);
 	return 0;
 }

@@ -1536,19 +1528,18 @@ static int chip_attach(struct i2c_adapte
 		chip_write(chip,desc->treblereg,desc->treblefunc(chip->treble));
 	}

-	chip->tpid = -1;
+	chip->thread = NULL;
 	if (desc->checkmode) {
 		/* start async thread */
 		init_timer(&chip->wt);
 		chip->wt.function = chip_thread_wake;
 		chip->wt.data     = (unsigned long)chip;
-		init_waitqueue_head(&chip->wq);
-		init_completion(&chip->texit);
-		chip->tpid = kernel_thread(chip_thread,(void *)chip,0);
-		if (chip->tpid < 0)
-			v4l_warn(&chip->c, "%s: kernel_thread() failed\n",
+		chip->thread = kthread_run(chip_thread, chip, chip->c.name);
+		if (IS_ERR(chip->thread)) {
+			v4l_warn(&chip->c, "%s: failed to create kthread\n",
 			       chip->c.name);
-		wake_up_interruptible(&chip->wq);
+			chip->thread = NULL;
+		}
 	}
 	return 0;
 }
@@ -1569,11 +1560,10 @@ static int chip_detach(struct i2c_client
 	struct CHIPSTATE *chip = i2c_get_clientdata(client);

 	del_timer_sync(&chip->wt);
-	if (chip->tpid >= 0) {
+	if (chip->thread) {
 		/* shutdown async thread */
-		chip->done = 1;
-		wake_up_interruptible(&chip->wq);
-		wait_for_completion(&chip->texit);
+		kthread_stop(chip->thread);
+		chip->thread = NULL;
 	}

 	i2c_detach_client(&chip->c);
