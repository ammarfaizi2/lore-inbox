Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSFPSWz>; Sun, 16 Jun 2002 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316496AbSFPSWy>; Sun, 16 Jun 2002 14:22:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2052 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316492AbSFPSWw>;
	Sun, 16 Jun 2002 14:22:52 -0400
Date: Sun, 16 Jun 2002 19:22:53 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] Remove SCSI_BH
Message-ID: <20020616192253.Q9435@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Linus.  This patch switches SCSI from a bottom half to a tasklet.
It's been reviewed, tested & approved by Andrew Morton, James Bottomley &
Doug Gilbert.  Please apply.

--- linux-2.5.21/drivers/scsi/scsi.c	Sun Jun  2 18:44:50 2002
+++ linux-2.5.21-flock/drivers/scsi/scsi.c	Sat Jun 15 19:45:45 2002
@@ -1090,6 +1090,9 @@
 	SCSI_LOG_MLQUEUE(3, printk("Leaving scsi_do_cmd()\n"));
 }
 
+void scsi_tasklet_func(unsigned long);
+static DECLARE_TASKLET(scsi_tasklet, scsi_tasklet_func, 0);
+
 /*
  * This function is the mid-level interrupt routine, which decides how
  *  to handle error conditions.  Each invocation of this function must
@@ -1187,7 +1190,7 @@
 	/*
 	 * Mark the bottom half handler to be run.
 	 */
-	mark_bh(SCSI_BH);
+	tasklet_hi_schedule(&scsi_tasklet);
 }
 
 /*
@@ -1213,7 +1216,7 @@
  * half queue.  Thus the only time we hold the lock here is when
  * we wish to atomically remove the contents of the queue.
  */
-void scsi_bottom_half_handler(void)
+void scsi_tasklet_func(unsigned long ignore)
 {
 	Scsi_Cmnd *SCpnt;
 	Scsi_Cmnd *SCnext;
@@ -2545,11 +2548,6 @@
         if (scsihosts)
 		printk(KERN_INFO "scsi: host order: %s\n", scsihosts);	
 	scsi_host_no_init (scsihosts);
-	/*
-	 * This is where the processing takes place for most everything
-	 * when commands are completed.
-	 */
-	init_bh(SCSI_BH, scsi_bottom_half_handler);
 
 	return 0;
 }
@@ -2559,7 +2557,7 @@
 	Scsi_Host_Name *shn, *shn2 = NULL;
 	int i;
 
-	remove_bh(SCSI_BH);
+	tasklet_kill(&scsi_tasklet);
 
         devfs_unregister (scsi_devfs_handle);
         for (shn = scsi_host_no_list;shn;shn = shn->next) {

-- 
Revolutions do not require corporate support.
