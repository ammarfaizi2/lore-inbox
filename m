Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270569AbUJTUYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270569AbUJTUYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270500AbUJTUWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:22:43 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64418
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270527AbUJTUQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:16:19 -0400
Subject: [PATCH] SCSI: aic7xxx replace semaphores
From: Thomas Gleixner <tglx@tglx.de>
Reply-To: tglx@tglx.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098302891.25591.2.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 22:08:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use wait_event, completion instead of semaphores

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 2.6.9-bk-041020-thomas/drivers/scsi/aic7xxx/aic7xxx_osm.c |   84
++++++--------
 2.6.9-bk-041020-thomas/drivers/scsi/aic7xxx/aic7xxx_osm.h |    8 -
 2 files changed, 42 insertions(+), 50 deletions(-)

diff -puN drivers/scsi/aic7xxx/aic7xxx_osm.c~aic7xxx
drivers/scsi/aic7xxx/aic7xxx_osm.c
---
2.6.9-bk-041020/drivers/scsi/aic7xxx/aic7xxx_osm.c~aic7xxx	2004-10-20
16:06:12.000000000 +0200
+++ 2.6.9-bk-041020-thomas/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-10-20
16:13:23.000000000 +0200
@@ -1873,9 +1873,10 @@ ahc_platform_alloc(struct ahc_softc *ahc
 	ahc->platform_data->completeq_timer.data = (u_long)ahc;
 	ahc->platform_data->completeq_timer.function =
 	    (ahc_linux_callback_t *)ahc_linux_thread_run_complete_queue;
-	init_MUTEX_LOCKED(&ahc->platform_data->eh_sem);
-	init_MUTEX_LOCKED(&ahc->platform_data->dv_sem);
-	init_MUTEX_LOCKED(&ahc->platform_data->dv_cmd_sem);
+	init_waitqueue_head(&ahc->platform_data->eh_done);
+	init_waitqueue_head(&ahc->platform_data->dv_done);
+	init_waitqueue_head(&ahc->platform_data->dv_cmd_done);
+	init_completion(&ahc->platform_data->dv_exit);
 	tasklet_init(&ahc->platform_data->runq_tasklet, ahc_runq_tasklet,
 		     (unsigned long)ahc);
 	ahc->seltime = (aic7xxx_seltime & 0x3) << 4;
@@ -2156,7 +2157,7 @@ ahc_linux_start_dv(struct ahc_softc *ahc
 		ahc_linux_freeze_simq(ahc);
 
 		/* Wake up the DV kthread */
-		up(&ahc->platform_data->dv_sem);
+		wake_up(&ahc->platform_data->dv_done);
 	}
 }
 
@@ -2169,39 +2170,22 @@ ahc_linux_kill_dv_thread(struct ahc_soft
 	if (ahc->platform_data->dv_pid != 0) {
 		ahc->platform_data->flags |= AHC_DV_SHUTDOWN;
 		ahc_unlock(ahc, &s);
-		up(&ahc->platform_data->dv_sem);
+		wake_up(&ahc->platform_data->dv_done);
 
-		/*
-		 * Use the eh_sem as an indicator that the
-		 * dv thread is exiting.  Note that the dv
-		 * thread must still return after performing
-		 * the up on our semaphore before it has
-		 * completely exited this module.  Unfortunately,
-		 * there seems to be no easy way to wait for the
-		 * exit of a thread for which you are not the
-		 * parent (dv threads are parented by init).
-		 * Cross your fingers...
-		 */
-		down(&ahc->platform_data->eh_sem);
-
-		/*
-		 * Mark the dv thread as already dead.  This
-		 * avoids attempting to kill it a second time.
-		 * This is necessary because we must kill the
-		 * DV thread before calling ahc_free() in the
-		 * module shutdown case to avoid bogus locking
-		 * in the SCSI mid-layer, but we ahc_free() is
-		 * called without killing the DV thread in the
-		 * instance detach case, so ahc_platform_free()
-		 * calls us again to verify that the DV thread
-		 * is dead.
-		 */
-		ahc->platform_data->dv_pid = 0;
+		/* Wait until the thread has exited */
+		wait_for_completion(&ahc->platform_data->dv_exit);
 	} else {
 		ahc_unlock(ahc, &s);
 	}
 }
 
+#define AHC_WAIT_FOR_WORK \
+	(ahc->platform_data->flags & (AHC_DV_SHUTDOWN | AHC_DV_ACTIVE))
+#define AHC_WAIT_FOR_SIMQ_EMPTY \
+	(!(ahc->platform_data->flags & AHC_DV_WAIT_SIMQ_EMPTY))
+#define AHC_WAIT_FOR_SIMQ_RELEASE \
+	(!(ahc->platform_data->flags & AHC_DV_WAIT_SIMQ_RELEASE))
+
 static int
 ahc_linux_dv_thread(void *data)
 {
@@ -2235,11 +2219,9 @@ ahc_linux_dv_thread(void *data)
 	unlock_kernel();
 
 	while (1) {
-		/*
-		 * Use down_interruptible() rather than down() to
-		 * avoid inclusion in the load average.
-		 */
-		down_interruptible(&ahc->platform_data->dv_sem);
+		/* Wait for work */
+		wait_event_interruptible(ahc->platform_data->dv_done,
+					 AHC_WAIT_FOR_WORK);
 
 		/* Check to see if we've been signaled to exit */
 		ahc_lock(ahc, &s);
@@ -2262,7 +2244,8 @@ ahc_linux_dv_thread(void *data)
 		while (LIST_FIRST(&ahc->pending_scbs) != NULL) {
 			ahc->platform_data->flags |= AHC_DV_WAIT_SIMQ_EMPTY;
 			ahc_unlock(ahc, &s);
-			down_interruptible(&ahc->platform_data->dv_sem);
+			wait_event_interruptible(ahc->platform_data->dv_done,
+						 AHC_WAIT_FOR_SIMQ_EMPTY);
 			ahc_lock(ahc, &s);
 		}
 
@@ -2273,7 +2256,8 @@ ahc_linux_dv_thread(void *data)
 		while (AHC_DV_SIMQ_FROZEN(ahc) == 0) {
 			ahc->platform_data->flags |= AHC_DV_WAIT_SIMQ_RELEASE;
 			ahc_unlock(ahc, &s);
-			down_interruptible(&ahc->platform_data->dv_sem);
+			wait_event_interruptible(ahc->platform_data->dv_done,
+						 AHC_WAIT_FOR_SIMQ_RELEASE);
 			ahc_lock(ahc, &s);
 		}
 		ahc_unlock(ahc, &s);
@@ -2291,7 +2275,9 @@ ahc_linux_dv_thread(void *data)
 		 */
 		ahc_linux_release_simq((u_long)ahc);
 	}
-	up(&ahc->platform_data->eh_sem);
+	/* Mark it as gone */
+	ahc->platform_data->dv_pid = 0;
+	complete(&ahc->platform_data->dv_exit);
 	return (0);
 }
 
@@ -2454,7 +2440,9 @@ ahc_linux_dv_target(struct ahc_softc *ah
 #else
 		spin_unlock_irqrestore(&io_request_lock, s);
 #endif
-		down_interruptible(&ahc->platform_data->dv_cmd_sem);
+		wait_event_interruptible(ahc->platform_data->dv_cmd_done,
+					 !timer_pending(&cmd->eh_timeout));
+
 		/*
 		 * Wait for the SIMQ to be released so that DV is the
 		 * only reason the queue is frozen.
@@ -2463,7 +2451,8 @@ ahc_linux_dv_target(struct ahc_softc *ah
 		while (AHC_DV_SIMQ_FROZEN(ahc) == 0) {
 			ahc->platform_data->flags |= AHC_DV_WAIT_SIMQ_RELEASE;
 			ahc_unlock(ahc, &s);
-			down_interruptible(&ahc->platform_data->dv_sem);
+			wait_event_interruptible(ahc->platform_data->dv_done,
+						 AHC_WAIT_FOR_SIMQ_RELEASE);
 			ahc_lock(ahc, &s);
 		}
 		ahc_unlock(ahc, &s);
@@ -3404,7 +3393,7 @@ ahc_linux_dv_complete(struct scsi_cmnd *
 #endif
 
 	/* Wake up the state machine */
-	up(&ahc->platform_data->dv_cmd_sem);
+	wake_up(&ahc->platform_data->dv_cmd_done);
 }
 
 static void
@@ -4164,7 +4153,7 @@ ahc_done(struct ahc_softc *ahc, struct s
 			ahc_set_transaction_status(scb, CAM_CMD_TIMEOUT);
 		if ((ahc->platform_data->flags & AHC_UP_EH_SEMAPHORE) != 0) {
 			ahc->platform_data->flags &= ~AHC_UP_EH_SEMAPHORE;
-			up(&ahc->platform_data->eh_sem);
+			wake_up(&ahc->platform_data->eh_done);
 		}
 	}
 
@@ -4174,7 +4163,7 @@ ahc_done(struct ahc_softc *ahc, struct s
 	if ((ahc->platform_data->flags & AHC_DV_WAIT_SIMQ_EMPTY) != 0
 	 && LIST_FIRST(&ahc->pending_scbs) == NULL) {
 		ahc->platform_data->flags &= ~AHC_DV_WAIT_SIMQ_EMPTY;
-		up(&ahc->platform_data->dv_sem);
+		wake_up(&ahc->platform_data->dv_done);
 	}
 		
 }
@@ -4563,7 +4552,7 @@ ahc_linux_sem_timeout(u_long arg)
 	ahc_lock(ahc, &s);
 	if ((ahc->platform_data->flags & AHC_UP_EH_SEMAPHORE) != 0) {
 		ahc->platform_data->flags &= ~AHC_UP_EH_SEMAPHORE;
-		up(&ahc->platform_data->eh_sem);
+		wake_up(&ahc->platform_data->eh_done);
 	}
 	ahc_unlock(ahc, &s);
 }
@@ -4600,7 +4589,7 @@ ahc_linux_release_simq(u_long arg)
 	if (AHC_DV_SIMQ_FROZEN(ahc)
 	 && ((ahc->platform_data->flags & AHC_DV_WAIT_SIMQ_RELEASE) != 0)) {
 		ahc->platform_data->flags &= ~AHC_DV_WAIT_SIMQ_RELEASE;
-		up(&ahc->platform_data->dv_sem);
+		wake_up(&ahc->platform_data->dv_done);
 	}
 	ahc_schedule_runq(ahc);
 	ahc_unlock(ahc, &s);
@@ -4952,7 +4941,8 @@ done:
 		timer.function = ahc_linux_sem_timeout;
 		add_timer(&timer);
 		printf("Recovery code sleeping\n");
-		down(&ahc->platform_data->eh_sem);
+		wait_event(ahc->platform_data->eh_done,
+			   !(ahc->platform_data->flags & AHC_UP_EH_SEMAPHORE));
 		printf("Recovery code awake\n");
         	ret = del_timer_sync(&timer);
 		if (ret == 0) {
diff -puN drivers/scsi/aic7xxx/aic7xxx_osm.h~aic7xxx
drivers/scsi/aic7xxx/aic7xxx_osm.h
---
2.6.9-bk-041020/drivers/scsi/aic7xxx/aic7xxx_osm.h~aic7xxx	2004-10-20
16:06:23.000000000 +0200
+++ 2.6.9-bk-041020-thomas/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-10-20
16:08:38.000000000 +0200
@@ -534,11 +534,13 @@ struct ahc_platform_data {
 	pid_t			 dv_pid;
 	struct timer_list	 completeq_timer;
 	struct timer_list	 reset_timer;
-	struct semaphore	 eh_sem;
-	struct semaphore	 dv_sem;
-	struct semaphore	 dv_cmd_sem;	/* XXX This needs to be in
+	wait_queue_head_t	 eh_done;
+	wait_queue_head_t	 dv_done;
+	wait_queue_head_t	 dv_cmd_done;	/* XXX This needs to be in
 						 * the target struct
 						 */
+	struct completion	 dv_exit;
+
 	struct scsi_device	*dv_scsi_dev;
 	struct Scsi_Host        *host;		/* pointer to scsi host */
 #define AHC_LINUX_NOIRQ	((uint32_t)~0)
_


