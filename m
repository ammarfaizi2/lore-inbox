Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267581AbUGWKAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267581AbUGWKAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 06:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267579AbUGWJ7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 05:59:49 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:58029 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267581AbUGWJyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 05:54:03 -0400
Date: Fri, 23 Jul 2004 18:55:21 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 3/5][Diskdump] IPF(IA64) support
In-reply-to: <14C4709A99D341indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Message-id: <17C4709B2AEF41indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <14C4709A99D341indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic7xxx driver.


diff -Nur linux-2.6.7.org/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.7/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.7.org/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-06-22 10:27:49.000000000 +0900
+++ linux-2.6.7/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-07-23 15:10:53.132006928 +0900
@@ -774,6 +774,8 @@
 static int	   ahc_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahc_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahc_linux_abort(Scsi_Cmnd *);
+static int	   ahc_linux_sanity_check(struct scsi_device *);
+static void	   ahc_linux_poll(struct scsi_device *);
 
 /*
  * Calculate a safe value for AHC_NSEG (as expressed through ahc_linux_nseg).
@@ -1315,6 +1317,8 @@
 	.slave_alloc		= ahc_linux_slave_alloc,
 	.slave_configure	= ahc_linux_slave_configure,
 	.slave_destroy		= ahc_linux_slave_destroy,
+	.dump_sanity_check	= ahc_linux_sanity_check,
+	.dump_poll		= ahc_linux_poll,
 };
 
 /**************************** Tasklet Handler *********************************/
@@ -3868,6 +3872,41 @@
 	return IRQ_RETVAL(ours);
 }
 
+static int
+ahc_linux_sanity_check(struct scsi_device *device)
+{
+	struct ahc_softc *ahc;
+	struct ahc_linux_device *dev;
+
+	ahc = *(struct ahc_softc **)device->host->hostdata;
+	dev = ahc_linux_get_device(ahc, device->channel,
+				   device->id, device->lun,
+					   /*alloc*/FALSE);
+	if (dev == NULL)
+		return -ENXIO;
+	if (ahc->platform_data->qfrozen || dev->qfrozen)
+		return -EBUSY;
+	if (spin_is_locked(&ahc->platform_data->spin_lock))
+		return -EBUSY;
+	return 0;
+}
+
+static void
+ahc_linux_poll(struct scsi_device *device)
+{
+	struct ahc_softc *ahc;
+	struct ahc_linux_device *dev;
+
+	ahc = *(struct ahc_softc **)device->host->hostdata;
+	ahc_intr(ahc);
+	while ((dev = ahc_linux_next_device_to_run(ahc)) != NULL) {
+		TAILQ_REMOVE(&ahc->platform_data->device_runq, dev, links);
+		dev->flags &= ~AHC_DEV_ON_RUN_LIST;
+		ahc_linux_check_device_queue(ahc, dev);
+	}
+	ahc_linux_run_complete_queue(ahc);
+}
+
 void
 ahc_platform_flushwork(struct ahc_softc *ahc)
 {
