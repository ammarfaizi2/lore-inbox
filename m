Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUE0Miv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUE0Miv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUE0Mip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:38:45 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:6028 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263626AbUE0Mh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:37:58 -0400
Date: Thu, 27 May 2004 21:39:12 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <1CC443CDA50AF2indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <1FC443E79D3948indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <1CC443CDA50AF2indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for aic7xxx driver.

Best Regards,
Takao Indoh

diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-05-20 08:58:47.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-05-27 11:06:13.000000000 +0900
@@ -774,6 +774,8 @@
 static int	   ahc_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahc_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahc_linux_abort(Scsi_Cmnd *);
+static int	   ahc_linux_sanity_check(Scsi_Device *);
+static void	   ahc_linux_poll(Scsi_Device *);
 
 /*
  * Calculate a safe value for AHC_NSEG (as expressed through ahc_linux_nseg).
@@ -1294,6 +1296,11 @@
 	return SUCCESS;
 }
 
+static struct scsi_dump_ops ahc_dump_ops = {
+	.sanity_check   = ahc_linux_sanity_check,
+	.poll           = ahc_linux_poll,
+};
+
 Scsi_Host_Template aic7xxx_driver_template = {
 	.module			= THIS_MODULE,
 	.name			= "aic7xxx",
@@ -1313,6 +1320,7 @@
 	.slave_alloc		= ahc_linux_slave_alloc,
 	.slave_configure	= ahc_linux_slave_configure,
 	.slave_destroy		= ahc_linux_slave_destroy,
+	.dump_ops		= &ahc_dump_ops,
 };
 
 /**************************** Tasklet Handler *********************************/
@@ -3863,6 +3871,41 @@
 	return IRQ_RETVAL(ours);
 }
 
+static int
+ahc_linux_sanity_check(Scsi_Device *device)
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
+ahc_linux_poll(Scsi_Device *device)
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
diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.h linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-05-20 08:58:47.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.h	2004-05-27 10:58:39.000000000 +0900
@@ -67,6 +67,7 @@
 #include <linux/smp_lock.h>
 #include <linux/version.h>
 #include <linux/module.h>
+#include <linux/diskdumplib.h>
 #include <asm/byteorder.h>
 #include <asm/io.h>
 
@@ -87,6 +88,8 @@
 #include "scsi.h"
 #include "hosts.h"
 
+#include "scsi_dump.h"
+
 /* Name space conflict with BSD queue macros */
 #ifdef LIST_HEAD
 #undef LIST_HEAD
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
 

