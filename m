Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUFPMtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUFPMtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266276AbUFPMs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:48:58 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14317 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266275AbUFPMrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:47:31 -0400
Date: Wed, 16 Jun 2004 21:48:48 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 3/4][Diskdump]Update patches
In-reply-to: <BEC4539EF0098Dindou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <C1C453A0446F8Aindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <BEC4539EF0098Dindou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic7xxx driver.


diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-06-04 21:22:20.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-06-16 19:34:16.000000000 +0900
@@ -774,6 +774,10 @@
 static int	   ahc_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahc_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahc_linux_abort(Scsi_Cmnd *);
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+static int	   ahc_linux_sanity_check(struct scsi_device *);
+static void	   ahc_linux_poll(struct scsi_device *);
+#endif
 
 /*
  * Calculate a safe value for AHC_NSEG (as expressed through ahc_linux_nseg).
@@ -1313,6 +1317,10 @@
 	.slave_alloc		= ahc_linux_slave_alloc,
 	.slave_configure	= ahc_linux_slave_configure,
 	.slave_destroy		= ahc_linux_slave_destroy,
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+	.dump_sanity_check	= ahc_linux_sanity_check,
+	.dump_poll		= ahc_linux_poll,
+#endif
 };
 
 /**************************** Tasklet Handler *********************************/
@@ -3863,6 +3871,42 @@
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
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
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
@@ -3870,6 +3914,7 @@
 	while (ahc_linux_run_complete_queue(ahc) != NULL)
 		;
 }
+#endif
 
 static struct ahc_linux_target*
 ahc_linux_alloc_target(struct ahc_softc *ahc, u_int channel, u_int target)
diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.h linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-06-04 21:22:20.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-06-16 19:34:16.000000000 +0900
@@ -67,6 +67,7 @@
 #include <linux/smp_lock.h>
 #include <linux/version.h>
 #include <linux/module.h>
+#include <linux/diskdumplib.h>
 #include <asm/byteorder.h>
 #include <asm/io.h>
 
@@ -82,6 +83,8 @@
 #include <linux/malloc.h>
 #endif
 
+#include <scsi/scsi_dump.h>
+
 /* Core SCSI definitions */
 #define AIC_LIB_PREFIX ahc
 #include "scsi.h"
@@ -253,6 +256,22 @@
  */
 #define ahc_dmamap_sync(ahc, dma_tag, dmamap, offset, len, op)
 
+
+/******************************** Disk dump ***********************************/
+#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
+#undef  add_timer
+#define add_timer       diskdump_add_timer
+#undef  del_timer_sync
+#define del_timer_sync  diskdump_del_timer
+#undef  del_timer
+#define del_timer       diskdump_del_timer
+#undef  mod_timer
+#define mod_timer       diskdump_mod_timer
+
+#define tasklet_schedule        diskdump_tasklet_schedule
+#endif
+
+
 /************************** Timer DataStructures ******************************/
 typedef struct timer_list ahc_timer_t;
 
