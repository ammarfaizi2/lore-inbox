Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUH1KRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUH1KRm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUH1JvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:51:14 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38856 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267399AbUH1Jpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:45:40 -0400
Date: Sat, 28 Aug 2004 18:47:01 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 3/4][diskdump] x86-64 support
In-reply-to: <89C48CE36A27FFindou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <8CC48CE3F7ABB3indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <89C48CE36A27FFindou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic7xxx/aic79xx driver.


diff -Nur linux-2.6.8.1.org/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.8.1/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.8.1.org/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-08-25 15:55:50.458167279 +0900
+++ linux-2.6.8.1/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-08-25 18:56:51.525417043 +0900
@@ -786,6 +786,8 @@
 static int	   ahd_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahd_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahd_linux_abort(Scsi_Cmnd *);
+static int	   ahd_linux_sanity_check(struct scsi_device *);
+static void	   ahd_linux_poll(struct scsi_device *);
 
 /*
  * Calculate a safe value for AHD_NSEG (as expressed through ahd_linux_nseg).
@@ -1684,6 +1686,8 @@
 	.slave_alloc		= ahd_linux_slave_alloc,
 	.slave_configure	= ahd_linux_slave_configure,
 	.slave_destroy		= ahd_linux_slave_destroy,
+	.dump_sanity_check	= ahd_linux_sanity_check,
+	.dump_poll		= ahd_linux_poll,
 };
 
 /**************************** Tasklet Handler *********************************/
@@ -4191,6 +4195,39 @@
 	return IRQ_RETVAL(ours);
 }
 
+static int
+ahd_linux_sanity_check(struct scsi_device *device)
+{
+	struct ahd_softc *ahd;
+	struct ahd_linux_device *dev;
+
+	ahd = *(struct ahd_softc **)device->host->hostdata;
+	dev = ahd_linux_get_device(ahd, device->channel,
+				   device->id, device->lun,
+				   /*alloc*/FALSE);
+
+	if (dev == NULL)
+		return -ENXIO;
+	if (ahd->platform_data->qfrozen || dev->qfrozen)
+		return -EBUSY;
+	if (spin_is_locked(&ahd->platform_data->spin_lock))
+		return -EBUSY;
+	return 0;
+}
+
+static void
+ahd_linux_poll(struct scsi_device *device)
+{
+	struct ahd_softc *ahd;
+	int ours;
+
+	ahd = *(struct ahd_softc **)device->host->hostdata;
+	ours = ahd_intr(ahd);
+	if (ahd_linux_next_device_to_run(ahd) != NULL)
+		ahd_schedule_runq(ahd);
+	ahd_linux_run_complete_queue(ahd);
+}
+
 void
 ahd_platform_flushwork(struct ahd_softc *ahd)
 {
diff -Nur linux-2.6.8.1.org/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.8.1/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.8.1.org/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-08-25 15:55:50.463050091 +0900
+++ linux-2.6.8.1/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-08-25 18:56:51.528346731 +0900
@@ -774,6 +774,8 @@
 static int	   ahc_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahc_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahc_linux_abort(Scsi_Cmnd *);
+static int	   ahc_linux_sanity_check(struct scsi_device *);
+static void	   ahc_linux_poll(struct scsi_device *);
 
 /*
  * Calculate a safe value for AHC_NSEG (as expressed through ahc_linux_nseg).
@@ -1310,6 +1312,8 @@
 	.slave_alloc		= ahc_linux_slave_alloc,
 	.slave_configure	= ahc_linux_slave_configure,
 	.slave_destroy		= ahc_linux_slave_destroy,
+	.dump_sanity_check	= ahc_linux_sanity_check,
+	.dump_poll		= ahc_linux_poll,
 };
 
 /**************************** Tasklet Handler *********************************/
@@ -3863,6 +3867,41 @@
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
