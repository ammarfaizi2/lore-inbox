Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUFKLpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUFKLpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 07:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbUFKLnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 07:43:16 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:9606 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263827AbUFKLmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 07:42:21 -0400
Date: Fri, 11 Jun 2004 20:43:35 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 4/4]Diskdump Update
In-reply-to: <A0C44FA7FE6022indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <A4C44FA95464F9indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <A0C44FA7FE6022indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic79xx driver.


diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-05-10 11:32:38.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-06-07 16:09:10.000000000 +0900
@@ -786,6 +786,10 @@
 static int	   ahd_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahd_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahd_linux_abort(Scsi_Cmnd *);
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+static int	   ahd_linux_sanity_check(struct scsi_device *);
+static void	   ahd_linux_poll(struct scsi_device *);
+#endif
 
 /*
  * Calculate a safe value for AHD_NSEG (as expressed through ahd_linux_nseg).
@@ -1665,6 +1669,13 @@
 	return (SUCCESS);
 }
 
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+static struct scsi_dump_ops ahd_dump_ops = {
+	.sanity_check	= ahd_linux_sanity_check,
+	.poll		= ahd_linux_poll,
+};
+#endif	/* CONFIG_SCSI_DUMP || CONFIG_SCSI_DUMP_MODULE */
+
 Scsi_Host_Template aic79xx_driver_template = {
 	.module			= THIS_MODULE,
 	.name			= "aic79xx",
@@ -1684,6 +1695,9 @@
 	.slave_alloc		= ahd_linux_slave_alloc,
 	.slave_configure	= ahd_linux_slave_configure,
 	.slave_destroy		= ahd_linux_slave_destroy,
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+	.dump_ops		= &ahd_dump_ops,
+#endif	/* CONFIG_SCSI_DUMP || CONFIG_SCSI_DUMP_MODULE */
 };
 
 /**************************** Tasklet Handler *********************************/
@@ -4190,6 +4204,41 @@
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
+	if(dev == NULL)
+		return -ENXIO;
+	if(ahd->platform_data->qfrozen || dev->qfrozen)
+		return -EBUSY;
+	if(spin_is_locked(&ahd->platform_data->spin_lock))
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
+	if(ahd_linux_next_device_to_run(ahd) != NULL)
+		ahd_schedule_runq(ahd);
+	ahd_linux_run_complete_queue(ahd);
+}
+#endif	/* CONFIG_SCSI_DUMP || CONFIG_SCSI_DUMP_MODULE */
+
 void
 ahd_platform_flushwork(struct ahd_softc *ahd)
 {
diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.h linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.h
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.h	2004-05-10 11:32:52.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.h	2004-06-07 16:09:59.000000000 +0900
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
