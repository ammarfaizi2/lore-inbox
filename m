Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266284AbUFPMwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266284AbUFPMwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266279AbUFPMuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:50:10 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:3758 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266274AbUFPMs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:48:56 -0400
Date: Wed, 16 Jun 2004 21:50:12 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 4/4][Diskdump]Update patches
In-reply-to: <BEC4539EF0098Dindou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <C2C453A076C873indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <BEC4539EF0098Dindou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic79xx driver.


diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-06-04 21:22:20.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-06-16 19:34:16.000000000 +0900
@@ -786,6 +786,10 @@
 static int	   ahd_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahd_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahd_linux_abort(Scsi_Cmnd *);
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+static int         ahd_linux_sanity_check(struct scsi_device *);
+static void        ahd_linux_poll(struct scsi_device *);
+#endif
 
 /*
  * Calculate a safe value for AHD_NSEG (as expressed through ahd_linux_nseg).
@@ -1684,6 +1688,10 @@
 	.slave_alloc		= ahd_linux_slave_alloc,
 	.slave_configure	= ahd_linux_slave_configure,
 	.slave_destroy		= ahd_linux_slave_destroy,
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+	.dump_sanity_check	= ahd_linux_sanity_check,
+	.dump_poll		= ahd_linux_poll,
+#endif
 };
 
 /**************************** Tasklet Handler *********************************/
@@ -4190,6 +4198,41 @@
 	return IRQ_RETVAL(ours);
 }
 
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
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
+#endif
+
 void
 ahd_platform_flushwork(struct ahd_softc *ahd)
 {
diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.h linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.h
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.h	2004-06-04 21:22:20.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.h	2004-06-16 19:34:16.000000000 +0900
@@ -50,6 +50,9 @@
 #include <linux/smp_lock.h>
 #include <linux/version.h>
 #include <linux/module.h>
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+#include <linux/diskdumplib.h>
+#endif
 #include <asm/byteorder.h>
 #include <asm/io.h>
 
@@ -65,6 +68,10 @@
 #include <linux/malloc.h>
 #endif
 
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+#include <scsi/scsi_dump.h>
+#endif
+
 /* Core SCSI definitions */
 #define AIC_LIB_PREFIX ahd
 #include "scsi.h"
@@ -96,6 +103,20 @@
 /* No debugging code. */
 #endif
 
+/********************************** Disk Dump *********************************/
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+#undef	add_timer
+#define	add_timer		diskdump_add_timer
+#undef	del_timer_sync
+#define	del_timer_sync		diskdump_del_timer
+#undef	del_timer
+#define	del_timer		diskdump_del_timer
+#undef	mod_timer
+#define	mod_timer		diskdump_mod_timer
+
+#define	tasklet_schedule	diskdump_tasklet_schedule
+#endif
+
 /********************************** Misc Macros *******************************/
 #define	roundup(x, y)   ((((x)+((y)-1))/(y))*(y))
 #define	powerof2(x)	((((x)-1)&(x))==0)
