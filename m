Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270442AbUJTTjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270442AbUJTTjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270471AbUJTTjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:39:00 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:53410
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269155AbUJTThm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:37:42 -0400
Subject: [PATCH] SCSI: Replace semaphores with wait_even
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       SCSI <linux-scsi@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098300579.20821.65.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 21:29:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use wait_event instead of semaphores. Semaphores are slower
and trigger owner conflicts during semaphore debugging.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 2.6.9-bk-041020-thomas/drivers/scsi/hosts.c      |    2 +-
 2.6.9-bk-041020-thomas/drivers/scsi/scsi_error.c |   19
++++++++-----------
 2.6.9-bk-041020-thomas/include/scsi/scsi_host.h  |    2 +-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff -puN drivers/scsi/scsi_error.c~scsihost drivers/scsi/scsi_error.c
--- 2.6.9-bk-041020/drivers/scsi/scsi_error.c~scsihost	2004-10-20
15:58:57.000000000 +0200
+++ 2.6.9-bk-041020-thomas/drivers/scsi/scsi_error.c	2004-10-20
16:02:57.000000000 +0200
@@ -49,7 +49,7 @@
 void scsi_eh_wakeup(struct Scsi_Host *shost)
 {
 	if (shost->host_busy == shost->host_failed) {
-		up(shost->eh_wait);
+		wake_up(shost->eh_wait);
 		SCSI_LOG_ERROR_RECOVERY(5,
 				printk("Waking error handler thread\n"));
 	}
@@ -1598,7 +1598,7 @@ int scsi_error_handler(void *data)
 {
 	struct Scsi_Host *shost = (struct Scsi_Host *) data;
 	int rtn;
-	DECLARE_MUTEX_LOCKED(sem);
+ 	DECLARE_WAIT_QUEUE_HEAD(eh_wait);
 
 	/*
 	 *    Flush resources
@@ -1608,7 +1608,7 @@ int scsi_error_handler(void *data)
 
 	current->flags |= PF_NOFREEZE;
 
-	shost->eh_wait = &sem;
+	shost->eh_wait = &eh_wait;
 	shost->ehandler = current;
 
 	/*
@@ -1630,15 +1630,12 @@ int scsi_error_handler(void *data)
 						  " sleeping\n",shost->host_no));
 
 		/*
-		 * Note - we always use down_interruptible with the semaphore
-		 * even if the module was loaded as part of the kernel.  The
-		 * reason is that down() will cause this thread to be counted
-		 * in the load average as a running process, and down
-		 * interruptible doesn't.  Given that we need to allow this
-		 * thread to die if the driver was loaded as a module, using
-		 * semaphores isn't unreasonable.
+		 * Wait, until somebody decides to wake us due to an error
+		 * or because we should be killed
 		 */
-		down_interruptible(&sem);
+		wait_event_interruptible(eh_wait, shost->eh_kill ||
+				(shost->host_busy == shost->host_failed));
+
 		if (shost->eh_kill)
 			break;
 
diff -puN drivers/scsi/hosts.c~scsihost drivers/scsi/hosts.c
--- 2.6.9-bk-041020/drivers/scsi/hosts.c~scsihost	2004-10-20
16:00:04.000000000 +0200
+++ 2.6.9-bk-041020-thomas/drivers/scsi/hosts.c	2004-10-20
16:00:35.000000000 +0200
@@ -157,7 +157,7 @@ static void scsi_host_dev_release(struct
 		DECLARE_COMPLETION(sem);
 		shost->eh_notify = &sem;
 		shost->eh_kill = 1;
-		up(shost->eh_wait);
+		wake_up(shost->eh_wait);
 		wait_for_completion(&sem);
 		shost->eh_notify = NULL;
 	}
diff -puN include/scsi/scsi_host.h~scsihost include/scsi/scsi_host.h
--- 2.6.9-bk-041020/include/scsi/scsi_host.h~scsihost	2004-10-20
16:00:12.000000000 +0200
+++ 2.6.9-bk-041020-thomas/include/scsi/scsi_host.h	2004-10-20
16:00:29.000000000 +0200
@@ -396,7 +396,7 @@ struct Scsi_Host {
 
 	struct list_head	eh_cmd_q;
 	struct task_struct    * ehandler;  /* Error recovery thread. */
-	struct semaphore      * eh_wait;   /* The error recovery thread waits
+	wait_queue_head_t     * eh_wait;   /* The error recovery thread waits
 					      on this. */
 	struct completion     * eh_notify; /* wait for eh to begin or end */
 	struct semaphore      * eh_action; /* Wait for specific actions on the
_


