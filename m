Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUGIH0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUGIH0C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 03:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGIHXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 03:23:52 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:57259 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264524AbUGIHVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 03:21:13 -0400
Date: Fri, 09 Jul 2004 16:22:31 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 4/4][Diskdump]Update patches
In-reply-to: <19C465847542EBindou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <1DC465857F29CFindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <19C465847542EBindou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic79xx driver.


diff -Nur linux-2.6.7.org/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.7/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.7.org/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-06-22 10:27:49.000000000 +0900
+++ linux-2.6.7/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-07-09 15:35:35.270902072 +0900
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
