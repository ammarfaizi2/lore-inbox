Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270121AbUJTKND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270121AbUJTKND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270149AbUJTKMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:12:05 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:35234
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270354AbUJTKFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:05:54 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <20041020074049.GA20963@elte.hu>
References: <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <1098229098.26927.40.camel@cmn37.stanford.edu>
	 <1098229166.12223.1153.camel@thomas> <1098248541.12223.1450.camel@thomas>
	 <20041020074049.GA20963@elte.hu>
Content-Type: multipart/mixed; boundary="=-Iwe+ymsD8ukbxbqrvyCF"
Organization: linutronix
Message-Id: <1098266273.12223.1511.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 11:57:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Iwe+ymsD8ukbxbqrvyCF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-10-20 at 09:40, Ingo Molnar wrote:
> > - scsi_error_handler() fix
> > - device subsystem device_remove locking fix
> 
> thanks, i've applied these. The block/loop.c assert reported by Rui
> seems to be a similar problem too.

Yep, it's all the same scheme. Most of the offending code uses
MUTEX_LOCKED in an init function and plays the down, and up from a
different context game, which triggers the deadlock/owner verify. Not
hard to fix, but at some places it takes a bit, until you see the
intention of the driver hacker. 

The most surprising one was in driver/base. I did not expect that new
2.5/6 code uses those tricks too.

Fixes for aic7xxx and sym53c8xx_2 attached.

tglx


--=-Iwe+ymsD8ukbxbqrvyCF
Content-Disposition: attachment; filename=aic7xxx.diff
Content-Type: text/x-patch; name=aic7xxx.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U7/drivers/scsi/aic7xxx/aic7xxx_osm.c 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- 2.6.9-rc4-mm1-RT-U7/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-10-12 09:41:33.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-10-20 09:33:59.000000000 +0200
@@ -1873,9 +1873,10 @@
 	ahc->platform_data->completeq_timer.data = (u_long)ahc;
 	ahc->platform_data->completeq_timer.function =
 	    (ahc_linux_callback_t *)ahc_linux_thread_run_complete_queue;
-	init_MUTEX_LOCKED(&ahc->platform_data->eh_sem);
-	init_MUTEX_LOCKED(&ahc->platform_data->dv_sem);
-	init_MUTEX_LOCKED(&ahc->platform_data->dv_cmd_sem);
+	init_waitqueue_head(&ahc->platform_data->eh_sem);
+	init_waitqueue_head(&ahc->platform_data->dv_sem);
+	init_waitqueue_head(&ahc->platform_data->dv_cmd_sem);
+	init_completion(&ahc->platform_data->dv_exit);
 	tasklet_init(&ahc->platform_data->runq_tasklet, ahc_runq_tasklet,
 		     (unsigned long)ahc);
 	ahc->seltime = (aic7xxx_seltime & 0x3) << 4;
@@ -2156,7 +2157,7 @@
 		ahc_linux_freeze_simq(ahc);
 
 		/* Wake up the DV kthread */
-		up(&ahc->platform_data->dv_sem);
+		wake_up(&ahc->platform_data->dv_sem);
 	}
 }
 
@@ -2169,39 +2170,22 @@
 	if (ahc->platform_data->dv_pid != 0) {
 		ahc->platform_data->flags |= AHC_DV_SHUTDOWN;
 		ahc_unlock(ahc, &s);
-		up(&ahc->platform_data->dv_sem);
+		wake_up(&ahc->platform_data->dv_sem);
 
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
@@ -2235,11 +2219,9 @@
 	unlock_kernel();
 
 	while (1) {
-		/*
-		 * Use down_interruptible() rather than down() to
-		 * avoid inclusion in the load average.
-		 */
-		down_interruptible(&ahc->platform_data->dv_sem);
+		/* Wait for work */
+		wait_event_interruptible(ahc->platform_data->dv_sem,
+					 AHC_WAIT_FOR_WORK);
 
 		/* Check to see if we've been signaled to exit */
 		ahc_lock(ahc, &s);
@@ -2262,7 +2244,8 @@
 		while (LIST_FIRST(&ahc->pending_scbs) != NULL) {
 			ahc->platform_data->flags |= AHC_DV_WAIT_SIMQ_EMPTY;
 			ahc_unlock(ahc, &s);
-			down_interruptible(&ahc->platform_data->dv_sem);
+			wait_event_interruptible(ahc->platform_data->dv_sem,
+						 AHC_WAIT_FOR_SIMQ_EMPTY);
 			ahc_lock(ahc, &s);
 		}
 
@@ -2273,7 +2256,8 @@
 		while (AHC_DV_SIMQ_FROZEN(ahc) == 0) {
 			ahc->platform_data->flags |= AHC_DV_WAIT_SIMQ_RELEASE;
 			ahc_unlock(ahc, &s);
-			down_interruptible(&ahc->platform_data->dv_sem);
+			wait_event_interruptible(ahc->platform_data->dv_sem,
+						 AHC_WAIT_FOR_SIMQ_RELEASE);
 			ahc_lock(ahc, &s);
 		}
 		ahc_unlock(ahc, &s);
@@ -2291,7 +2275,9 @@
 		 */
 		ahc_linux_release_simq((u_long)ahc);
 	}
-	up(&ahc->platform_data->eh_sem);
+	/* Mark it as gone */
+	ahc->platform_data->dv_pid = 0;
+	complete(&ahc->platform_data->dv_exit);
 	return (0);
 }
 
@@ -2454,7 +2440,9 @@
 #else
 		spin_unlock_irqrestore(&io_request_lock, s);
 #endif
-		down_interruptible(&ahc->platform_data->dv_cmd_sem);
+		wait_event_interruptible(ahc->platform_data->dv_cmd_sem,
+					 !timer_pending(&cmd->eh_timeout));
+					 
 		/*
 		 * Wait for the SIMQ to be released so that DV is the
 		 * only reason the queue is frozen.
@@ -2463,7 +2451,8 @@
 		while (AHC_DV_SIMQ_FROZEN(ahc) == 0) {
 			ahc->platform_data->flags |= AHC_DV_WAIT_SIMQ_RELEASE;
 			ahc_unlock(ahc, &s);
-			down_interruptible(&ahc->platform_data->dv_sem);
+			wait_event_interruptible(ahc->platform_data->dv_sem,
+						 AHC_WAIT_FOR_SIMQ_RELEASE);
 			ahc_lock(ahc, &s);
 		}
 		ahc_unlock(ahc, &s);
@@ -3404,7 +3393,7 @@
 #endif
 
 	/* Wake up the state machine */
-	up(&ahc->platform_data->dv_cmd_sem);
+	wake_up(&ahc->platform_data->dv_cmd_sem);
 }
 
 static void
@@ -4164,7 +4153,7 @@
 			ahc_set_transaction_status(scb, CAM_CMD_TIMEOUT);
 		if ((ahc->platform_data->flags & AHC_UP_EH_SEMAPHORE) != 0) {
 			ahc->platform_data->flags &= ~AHC_UP_EH_SEMAPHORE;
-			up(&ahc->platform_data->eh_sem);
+			wake_up(&ahc->platform_data->eh_sem);
 		}
 	}
 
@@ -4174,7 +4163,7 @@
 	if ((ahc->platform_data->flags & AHC_DV_WAIT_SIMQ_EMPTY) != 0
 	 && LIST_FIRST(&ahc->pending_scbs) == NULL) {
 		ahc->platform_data->flags &= ~AHC_DV_WAIT_SIMQ_EMPTY;
-		up(&ahc->platform_data->dv_sem);
+		wake_up(&ahc->platform_data->dv_sem);
 	}
 		
 }
@@ -4563,7 +4552,7 @@
 	ahc_lock(ahc, &s);
 	if ((ahc->platform_data->flags & AHC_UP_EH_SEMAPHORE) != 0) {
 		ahc->platform_data->flags &= ~AHC_UP_EH_SEMAPHORE;
-		up(&ahc->platform_data->eh_sem);
+		wake_up(&ahc->platform_data->eh_sem);
 	}
 	ahc_unlock(ahc, &s);
 }
@@ -4600,7 +4589,7 @@
 	if (AHC_DV_SIMQ_FROZEN(ahc)
 	 && ((ahc->platform_data->flags & AHC_DV_WAIT_SIMQ_RELEASE) != 0)) {
 		ahc->platform_data->flags &= ~AHC_DV_WAIT_SIMQ_RELEASE;
-		up(&ahc->platform_data->dv_sem);
+		wake_up(&ahc->platform_data->dv_sem);
 	}
 	ahc_schedule_runq(ahc);
 	ahc_unlock(ahc, &s);
@@ -4952,7 +4941,8 @@
 		timer.function = ahc_linux_sem_timeout;
 		add_timer(&timer);
 		printf("Recovery code sleeping\n");
-		down(&ahc->platform_data->eh_sem);
+		wait_event(ahc->platform_data->eh_sem,
+			   !(ahc->platform_data->flags & AHC_UP_EH_SEMAPHORE));
 		printf("Recovery code awake\n");
         	ret = del_timer_sync(&timer);
 		if (ret == 0) {
diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U7/drivers/scsi/aic7xxx/aic7xxx_osm.h 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- 2.6.9-rc4-mm1-RT-U7/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-10-12 09:41:33.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-10-20 09:31:55.000000000 +0200
@@ -534,11 +534,13 @@
 	pid_t			 dv_pid;
 	struct timer_list	 completeq_timer;
 	struct timer_list	 reset_timer;
-	struct semaphore	 eh_sem;
-	struct semaphore	 dv_sem;
-	struct semaphore	 dv_cmd_sem;	/* XXX This needs to be in
-						 * the target struct
+	wait_queue_head_t	 eh_sem;
+	wait_queue_head_t	 dv_sem;
+	wait_queue_head_t	 dv_cmd_sem;	/* XXX This needs to be in
+   						 * the target struct
 						 */
+	struct completion	 dv_exit;
+	
 	struct scsi_device	*dv_scsi_dev;
 	struct Scsi_Host        *host;		/* pointer to scsi host */
 #define AHC_LINUX_NOIRQ	((uint32_t)~0)

--=-Iwe+ymsD8ukbxbqrvyCF
Content-Disposition: attachment; filename=sym_glue.c.diff
Content-Type: text/x-patch; name=sym_glue.c.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U7/drivers/scsi/sym53c8xx_2/sym_glue.c 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/sym53c8xx_2/sym_glue.c
--- 2.6.9-rc4-mm1-RT-U7/drivers/scsi/sym53c8xx_2/sym_glue.c	2004-10-12 09:41:38.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/sym53c8xx_2/sym_glue.c	2004-10-20 10:09:04.000000000 +0200
@@ -135,7 +135,7 @@
  *  It is allocated on the eh thread stack.
  */
 struct sym_eh_wait {
-	struct semaphore sem;
+	struct completion done;
 	struct timer_list timer;
 	void (*old_done)(struct scsi_cmnd *);
 	int to_do;
@@ -798,7 +798,7 @@
 
 	/* Wake up the eh thread if it wants to sleep */
 	if (ep->to_do == SYM_EH_DO_WAIT)
-		up(&ep->sem);
+		complete(&ep->done);
 }
 
 /*
@@ -858,7 +858,7 @@
 	case SYM_EH_DO_IGNORE:
 		break;
 	case SYM_EH_DO_WAIT:
-		init_MUTEX_LOCKED(&ep->sem);
+		init_completion(&ep->done);
 		/* fall through */
 	case SYM_EH_DO_COMPLETE:
 		ep->old_done = cmd->scsi_done;
@@ -909,7 +909,7 @@
 		ep->timed_out = 1;	/* Be pessimistic for once :) */
 		add_timer(&ep->timer);
 		spin_unlock_irq(np->s.host->host_lock);
-		down(&ep->sem);
+		wait_for_completion(&ep->done);
 		spin_lock_irq(np->s.host->host_lock);
 		if (ep->timed_out)
 			sts = -2;

--=-Iwe+ymsD8ukbxbqrvyCF--

