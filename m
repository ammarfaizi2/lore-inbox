Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263939AbUE0MmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUE0MmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUE0Mlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:41:51 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:16275 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262114AbUE0MjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:39:25 -0400
Date: Thu, 27 May 2004 21:40:37 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [4/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <1CC443CDA50AF2indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <20C443E7CF7A59indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <1CC443CDA50AF2indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic79xx driver.


diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-05-20 08:58:47.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-05-27 11:23:29.000000000 +0900
@@ -786,6 +786,10 @@
 static int	   ahd_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahd_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahd_linux_abort(Scsi_Cmnd *);
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+static int	   ahd_linux_sanity_check(Scsi_Device *);
+static void	   ahd_linux_poll(Scsi_Device *);
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
+ahd_linux_sanity_check(Scsi_Device *device)
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
+ahd_linux_poll(Scsi_Device *device)
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
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic79xx_osm.h	2004-05-20 08:58:47.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.h	2004-05-27 11:25:06.000000000 +0900
@@ -50,6 +50,9 @@
 #include <linux/smp_lock.h>
 #include <linux/version.h>
 #include <linux/module.h>
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+#include <linux/diskdumplib.h>
+#endif
 #include <asm/byteorder.h>
 #include <asm/io.h>
 
@@ -70,6 +73,10 @@
 #include "scsi.h"
 #include "hosts.h"
 
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+#include "scsi_dump.h"
+#endif
+
 /* Name space conflict with BSD queue macros */
 #ifdef LIST_HEAD
 #undef LIST_HEAD
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
