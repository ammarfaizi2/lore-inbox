Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUFVOIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUFVOIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUFVOHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:07:30 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60619 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263806AbUFVOAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:00:53 -0400
Date: Tue, 22 Jun 2004 23:02:07 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 4/4][Diskdump]Update patches
In-reply-to: <E4C4585F67CAA4indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <E8C458618165C4indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <E4C4585F67CAA4indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic79xx driver.


diff -Nur linux-2.6.7.org/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.7/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.7.org/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-06-22 10:27:49.000000000 +0900
+++ linux-2.6.7/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-06-22 22:26:39.254362008 +0900
@@ -786,6 +786,8 @@
 static int	   ahd_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahd_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahd_linux_abort(Scsi_Cmnd *);
+static int         ahd_linux_sanity_check(struct scsi_device *);
+static void        ahd_linux_poll(struct scsi_device *);
 
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
