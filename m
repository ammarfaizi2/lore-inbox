Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263828AbUFVOFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUFVOFA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUFVOFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:05:00 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:29387 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263828AbUFVOAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:00:07 -0400
Date: Tue, 22 Jun 2004 23:01:23 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 3/4][Diskdump]Update patches
In-reply-to: <E4C4585F67CAA4indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <E7C45861670822indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <E4C4585F67CAA4indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic7xxx driver.


diff -Nur linux-2.6.7.org/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.7/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.7.org/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-06-22 10:27:49.000000000 +0900
+++ linux-2.6.7/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-06-22 22:26:39.257361552 +0900
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
