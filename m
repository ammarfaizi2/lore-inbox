Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264880AbRFTN4l>; Wed, 20 Jun 2001 09:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264879AbRFTN4a>; Wed, 20 Jun 2001 09:56:30 -0400
Received: from [32.97.182.101] ([32.97.182.101]:31713 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264614AbRFTN4V>;
	Wed, 20 Jun 2001 09:56:21 -0400
Importance: Normal
Subject: Re: [RFQ] aic7xxx driver panics under heavy swap.
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFADEE406A.252C680F-ON85256A71.004A4502@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Wed, 20 Jun 2001 09:56:54 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Build V508_06042001 |June 4, 2001) at
 06/20/2001 09:55:54 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Justin,
Your patch works for me.  printk "Temporary Resource Shortage"
has to go, or may be you can make it a debug option.

Here is the cleaned up patch for 2.4.5-ac15 with TAILQ
macros replaced with LIST macros.  Thanks for the help.
Bulent



--- aic7xxx_linux.c.save Mon Jun 18 20:25:35 2001
+++ aic7xxx_linux.c Tue Jun 19 17:35:55 2001
@@ -1516,7 +1516,11 @@
     }
     cmd->result = CAM_REQ_INPROG << 16;
     TAILQ_INSERT_TAIL(&dev->busyq, (struct ahc_cmd *)cmd, acmd_links.tqe);
-    ahc_linux_run_device_queue(ahc, dev);
+    if ((dev->flags & AHC_DEV_ON_RUN_LIST) == 0) {
+         LIST_INSERT_HEAD(&ahc->platform_data->device_runq, dev, links);
+         dev->flags |= AHC_DEV_ON_RUN_LIST;
+         ahc_linux_run_device_queues(ahc);
+    }
     ahc_unlock(ahc, &flags);
     return (0);
 }
@@ -1532,6 +1536,9 @@
     struct     ahc_tmode_tstate *tstate;
     uint16_t mask;

+    if ((dev->flags & AHC_DEV_ON_RUN_LIST) != 0)
+         panic("running device on run list");
+
     while ((acmd = TAILQ_FIRST(&dev->busyq)) != NULL
         && dev->openings > 0 && dev->qfrozen == 0) {

@@ -1540,8 +1547,6 @@
           * running is because the whole controller Q is frozen.
           */
          if (ahc->platform_data->qfrozen != 0) {
-              if ((dev->flags & AHC_DEV_ON_RUN_LIST) != 0)
-                   return;

               LIST_INSERT_HEAD(&ahc->platform_data->device_runq,
                          dev, links);
@@ -1552,8 +1557,6 @@
           * Get an scb to use.
           */
          if ((scb = ahc_get_scb(ahc)) == NULL) {
-              if ((dev->flags & AHC_DEV_ON_RUN_LIST) != 0)
-                   panic("running device on run list");
               LIST_INSERT_HEAD(&ahc->platform_data->device_runq,
                          dev, links);
               dev->flags |= AHC_DEV_ON_RUN_LIST;








