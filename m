Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264424AbRFSQ7N>; Tue, 19 Jun 2001 12:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264426AbRFSQ7D>; Tue, 19 Jun 2001 12:59:03 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:54028 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S264424AbRFSQ6p>; Tue, 19 Jun 2001 12:58:45 -0400
Message-Id: <200106191658.f5JGwMU29894@aslan.scsiguy.com>
To: "Bulent Abali" <abali@us.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] aic7xxx driver panics under heavy swap. 
In-Reply-To: Your message of "Tue, 19 Jun 2001 11:46:02 EDT."
             <OFFC1B2C1B.7F406B4A-ON85256A70.00564265@pok.ibm.com> 
Date: Tue, 19 Jun 2001 10:58:22 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Justin,
>When free memory is low, I get a series of aic7xxx messages followed by
>panic.  It appears to be a race condition in the code.

Its actually a logic error, not a race condition.  You should never
enter ahc_linux_run_device_queue() while the device is still on the
run queue.  The real issue is that ahc_linux_queue bypasses the
round-robin device scheduler by calling ahc_linux_run_device_queue()
directly.  The code should look like this (the LIST macro calls
where switched to TAILQ calls a bit ago to ensure round-robin, but
that change came just after 6.1.13).  I haven't tested this yet...

Thanks for the bug report.  If you can verify that this works under
memeory pressure, the printf can go away.

--
Justin

==== //depot/src/linux/drivers/scsi/aic7xxx/aic7xxx_linux.c#67 - /usr/src/linux/drivers/scsi/aic7xxx/aic7xxx_linux.c ====
--- /tmp/tmp.3288.0	Tue Jun 19 11:07:32 2001
+++ /usr/src/linux/drivers/scsi/aic7xxx/aic7xxx_linux.c	Tue Jun 19 11:02:54 2001
@@ -1514,7 +1514,11 @@
 	}
 	cmd->result = CAM_REQ_INPROG << 16;
 	TAILQ_INSERT_TAIL(&dev->busyq, (struct ahc_cmd *)cmd, acmd_links.tqe);
-	ahc_linux_run_device_queue(ahc, dev);
+	if ((dev->flags & AHC_DEV_ON_RUN_LIST) == 0) {
+		TAILQ_INSERT_TAIL(&ahc->platform_data->device_runq, dev, links);
+		dev->flags |= AHC_DEV_ON_RUN_LIST;
+		ahc_linux_run_device_queues(ahc);
+	}
 	ahc_unlock(ahc, &flags);
 	return (0);
 }
@@ -1530,6 +1534,9 @@
 	struct	 ahc_tmode_tstate *tstate;
 	uint16_t mask;
 
+	if ((dev->flags & AHC_DEV_ON_RUN_LIST) != 0)
+		panic("running device on run list");
+
 	while ((acmd = TAILQ_FIRST(&dev->busyq)) != NULL
 	    && dev->openings > 0 && dev->qfrozen == 0) {
 
@@ -1538,8 +1545,6 @@
 		 * running is because the whole controller Q is frozen.
 		 */
 		if (ahc->platform_data->qfrozen != 0) {
-			if ((dev->flags & AHC_DEV_ON_RUN_LIST) != 0)
-				return;
 
 			TAILQ_INSERT_TAIL(&ahc->platform_data->device_runq,
 					  dev, links);
@@ -1550,8 +1555,6 @@
 		 * Get an scb to use.
 		 */
 		if ((scb = ahc_get_scb(ahc)) == NULL) {
-			if ((dev->flags & AHC_DEV_ON_RUN_LIST) != 0)
-				panic("running device on run list");
 			TAILQ_INSERT_TAIL(&ahc->platform_data->device_runq,
 					 dev, links);
 			dev->flags |= AHC_DEV_ON_RUN_LIST;
