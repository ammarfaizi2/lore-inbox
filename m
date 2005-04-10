Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVDJSrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVDJSrc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVDJSr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:47:26 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:36749 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261561AbVDJSpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:45:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=GFxHQTuiXD4UrqoBkJgQZkZDBBOuBiaUrKqtC9cNbpmOX1swoJ4qh/uyAuM6OOPrTmnrEvTKbpMLm7rXh5XfImOyXrFHOKDU4+b7K7M/HtNTY67LCZpv+VjGsBYRGyawawnPsUBbEZstEC1CZ4rG7w3ZcM+nQ8FiOaLRWt4Ssw8=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       gibbs@scsiguy.com
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050410184214.4AAD0992@htj.dyndns.org>
In-Reply-To: <20050410184214.4AAD0992@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 01/07] scsi: make aic7xxx use its own timer instead of scmd->eh_timeout
Message-ID: <20050410184214.8C6D12FE@htj.dyndns.org>
Date: Mon, 11 Apr 2005 03:45:11 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_scsi_timer_update_aic7xxx.patch

	aic7xxx used scmd->eh_timeout in its dv routines.  This kind
	of usage requires knowledge of and creates dependency into the
	SCSI midlayer unnecessarily.  This patch makes aic7xxx driver
	use its own timer instead of scmd->eh_timeout.
	Suggested by Christoph Hellwig.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 aic79xx_osm.c |   24 ++++++++++++++++--------
 aic7xxx_osm.c |   24 ++++++++++++++++--------
 2 files changed, 32 insertions(+), 16 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/aic7xxx/aic79xx_osm.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-04-11 03:42:10.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-04-11 03:42:11.000000000 +0900
@@ -460,7 +460,7 @@ static void ahd_linux_initialize_scsi_bu
 static void ahd_linux_size_nseg(void);
 static void ahd_linux_thread_run_complete_queue(struct ahd_softc *ahd);
 static void ahd_linux_start_dv(struct ahd_softc *ahd);
-static void ahd_linux_dv_timeout(struct scsi_cmnd *cmd);
+static void ahd_linux_dv_timeout(unsigned long data);
 static int  ahd_linux_dv_thread(void *data);
 static void ahd_linux_kill_dv_thread(struct ahd_softc *ahd);
 static void ahd_linux_dv_target(struct ahd_softc *ahd, u_int target);
@@ -2628,6 +2628,7 @@ ahd_linux_dv_target(struct ahd_softc *ah
 	struct	 ahd_devinfo devinfo;
 	struct	 ahd_linux_target *targ;
 	struct	 scsi_cmnd *cmd;
+	struct	 timer_list timer;
 	struct	 scsi_device *scsi_dev;
 	struct	 scsi_sense_data *sense;
 	uint8_t *buffer;
@@ -2723,8 +2724,7 @@ ahd_linux_dv_target(struct ahd_softc *ah
 		}
 
 		/* Queue the command and wait for it to complete */
-		/* Abuse eh_timeout in the scsi_cmnd struct for our purposes */
-		init_timer(&cmd->eh_timeout);
+		init_timer(&timer);
 #ifdef AHD_DEBUG
 		if ((ahd_debug & AHD_SHOW_MESSAGES) != 0)
 			/*
@@ -2734,7 +2734,10 @@ ahd_linux_dv_target(struct ahd_softc *ah
 			 */
 			timeout += HZ;
 #endif
-		scsi_add_timer(cmd, timeout, ahd_linux_dv_timeout);
+		timer.expires = jiffies + timeout;
+		timer.function = ahd_linux_dv_timeout;
+		timer.data = (unsigned long)cmd;
+		add_timer(&timer);
 		/*
 		 * In 2.5.X, it is assumed that all calls from the
 		 * "midlayer" (which we are emulating) will have the
@@ -2754,6 +2757,13 @@ ahd_linux_dv_target(struct ahd_softc *ah
 #endif
 		down_interruptible(&ahd->platform_data->dv_cmd_sem);
 		/*
+		 * Although the timer could have gone off while we're
+		 * on normal completion path before reaching the
+		 * following line, it's safe because we use
+		 * cmd->host_scribble for synchronization.
+		 */
+		del_timer(&timer);
+		/*
 		 * Wait for the SIMQ to be released so that DV is the
 		 * only reason the queue is frozen.
 		 */
@@ -3636,8 +3646,9 @@ ahd_linux_fallback(struct ahd_softc *ahd
 }
 
 static void
-ahd_linux_dv_timeout(struct scsi_cmnd *cmd)
+ahd_linux_dv_timeout(unsigned long data)
 {
+	struct	scsi_cmnd *cmd = (void *)data;
 	struct	ahd_softc *ahd;
 	struct	scb *scb;
 	u_long	flags;
@@ -3698,9 +3709,6 @@ ahd_linux_dv_complete(struct scsi_cmnd *
 
 	ahd = *((struct ahd_softc **)cmd->device->host->hostdata);
 
-	/* Delete the DV timer before it goes off! */
-	scsi_delete_timer(cmd);
-
 #ifdef AHD_DEBUG
 	if (ahd_debug & AHD_SHOW_DV)
 		printf("%s:%c:%d: Command completed, status= 0x%x\n",
Index: scsi-reqfn-export/drivers/scsi/aic7xxx/aic7xxx_osm.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-04-11 03:42:10.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-04-11 03:42:11.000000000 +0900
@@ -477,7 +477,7 @@ static void ahc_linux_initialize_scsi_bu
 static void ahc_linux_size_nseg(void);
 static void ahc_linux_thread_run_complete_queue(struct ahc_softc *ahc);
 static void ahc_linux_start_dv(struct ahc_softc *ahc);
-static void ahc_linux_dv_timeout(struct scsi_cmnd *cmd);
+static void ahc_linux_dv_timeout(unsigned long data);
 static int  ahc_linux_dv_thread(void *data);
 static void ahc_linux_kill_dv_thread(struct ahc_softc *ahc);
 static void ahc_linux_dv_target(struct ahc_softc *ahc, u_int target);
@@ -2310,6 +2310,7 @@ ahc_linux_dv_target(struct ahc_softc *ah
 	struct	 ahc_devinfo devinfo;
 	struct	 ahc_linux_target *targ;
 	struct	 scsi_cmnd *cmd;
+	struct	 timer_list timer;
 	struct	 scsi_device *scsi_dev;
 	struct	 scsi_sense_data *sense;
 	uint8_t *buffer;
@@ -2407,8 +2408,7 @@ ahc_linux_dv_target(struct ahc_softc *ah
 		}
 
 		/* Queue the command and wait for it to complete */
-		/* Abuse eh_timeout in the scsi_cmnd struct for our purposes */
-		init_timer(&cmd->eh_timeout);
+		init_timer(&timer);
 #ifdef AHC_DEBUG
 		if ((ahc_debug & AHC_SHOW_MESSAGES) != 0)
 			/*
@@ -2418,7 +2418,10 @@ ahc_linux_dv_target(struct ahc_softc *ah
 			 */
 			timeout += HZ;
 #endif
-		scsi_add_timer(cmd, timeout, ahc_linux_dv_timeout);
+		timer.expires = jiffies + timeout;
+		timer.function = ahc_linux_dv_timeout;
+		timer.data = (unsigned long)cmd;
+		add_timer(&timer);
 		/*
 		 * In 2.5.X, it is assumed that all calls from the
 		 * "midlayer" (which we are emulating) will have the
@@ -2438,6 +2441,13 @@ ahc_linux_dv_target(struct ahc_softc *ah
 #endif
 		down_interruptible(&ahc->platform_data->dv_cmd_sem);
 		/*
+		 * Although the timer could have gone off while we're
+		 * on normal completion path before reaching the
+		 * following line, it's safe because we use
+		 * cmd->host_scribble for synchronization.
+		 */
+		del_timer(&timer);
+		/*
 		 * Wait for the SIMQ to be released so that DV is the
 		 * only reason the queue is frozen.
 		 */
@@ -3313,8 +3323,9 @@ ahc_linux_fallback(struct ahc_softc *ahc
 }
 
 static void
-ahc_linux_dv_timeout(struct scsi_cmnd *cmd)
+ahc_linux_dv_timeout(unsigned long data)
 {
+	struct	scsi_cmnd *cmd = (void *)data;
 	struct	ahc_softc *ahc;
 	struct	scb *scb;
 	u_long	flags;
@@ -3375,9 +3386,6 @@ ahc_linux_dv_complete(struct scsi_cmnd *
 
 	ahc = *((struct ahc_softc **)cmd->device->host->hostdata);
 
-	/* Delete the DV timer before it goes off! */
-	scsi_delete_timer(cmd);
-
 #ifdef AHC_DEBUG
 	if (ahc_debug & AHC_SHOW_DV)
 		printf("%s:%d:%d: Command completed, status= 0x%x\n",

