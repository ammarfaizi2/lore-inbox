Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbSJYWYe>; Fri, 25 Oct 2002 18:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSJYWW1>; Fri, 25 Oct 2002 18:22:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11174 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261666AbSJYWRz>; Fri, 25 Oct 2002 18:17:55 -0400
Date: Fri, 25 Oct 2002 15:24:06 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 5/6 2.5.44 scsi multi-path IO - qla driver changes
Message-ID: <20021025152406.F17527@eng2.beaverton.ibm.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20021025152116.A17462@eng2.beaverton.ibm.com> <20021025152149.A17527@eng2.beaverton.ibm.com> <20021025152208.B17527@eng2.beaverton.ibm.com> <20021025152226.C17527@eng2.beaverton.ibm.com> <20021025152252.D17527@eng2.beaverton.ibm.com> <20021025152330.E17527@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021025152330.E17527@eng2.beaverton.ibm.com>; from patman on Fri, Oct 25, 2002 at 03:23:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

multi-path IO and 2.5.x changes for the qla 6.03.00 Beta 7 driver.

Apply this on top of the driver found at:

http://download.qlogic.com/drivers/6443/qla2x00-v6.03.00b7-dist.tgz

 Makefile        |    9 ++++++
 qla2x00.c       |   74 ++++++++++++++++++++------------------------------------
 qla2x00.h       |    7 ++---
 qla2x00_ioctl.c |    4 ++-
 qla_settings.h  |    2 -
 5 files changed, 43 insertions(+), 53 deletions(-)

diff -urN -X /home/patman/dontdiff qla2x00src-v6.03.00b7/Makefile qla2x00src-v6.03.00b7-mpath/Makefile
--- qla2x00src-v6.03.00b7/Makefile	Wed Dec 31 16:00:00 1969
+++ qla2x00src-v6.03.00b7-mpath/Makefile	Wed Oct 23 13:01:45 2002
@@ -0,0 +1,9 @@
+# andmike's condensed makefile
+# To use cd to kernel source and type the following.
+# make SUBDIRS=/path/to/your/module modules
+
+CFLAGS_qla2200.o = -I$(TOPDIR)/drivers/scsi
+CFLAGS_qla2300.o = -I$(TOPDIR)/drivers/scsi
+obj-m	:= qla2200.o qla2300.o
+
+include	$(TOPDIR)/Rules.make
diff -urN -X /home/patman/dontdiff qla2x00src-v6.03.00b7/qla2x00.c qla2x00src-v6.03.00b7-mpath/qla2x00.c
--- qla2x00src-v6.03.00b7/qla2x00.c	Mon Oct 14 06:15:26 2002
+++ qla2x00src-v6.03.00b7-mpath/qla2x00.c	Wed Oct 23 13:15:06 2002
@@ -77,7 +77,6 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/blk.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
@@ -228,7 +227,7 @@
 STATIC uint8_t qla2x00_register_with_Linux(scsi_qla_host_t *ha,
 			uint8_t maxchannels);
 STATIC int qla2x00_done(scsi_qla_host_t *);
-STATIC void qla2x00_select_queue_depth(struct Scsi_Host *, Scsi_Device *);
+STATIC int qla2x00_slave_attach(Scsi_Device *);
 
 STATIC void qla2x00_timer(scsi_qla_host_t *);
 
@@ -2227,7 +2226,6 @@
 
 	host->can_queue = max_srbs;  /* default value:-MAX_SRBS(4096)  */
 	host->cmd_per_lun = 1;
-	host->select_queue_depths = qla2x00_select_queue_depth;
 	host->n_io_port = 0xFF;
 
 #if MEMORY_MAPPED_IO
@@ -3690,11 +3688,11 @@
 
 	heads = 64;
 	sectors = 32;
-	cylinders = disk->capacity / (heads * sectors);
+	cylinders = sector_div(disk->capacity, heads * sectors);
 	if (cylinders > 1024) {
 		heads = 255;
 		sectors = 63;
-		cylinders = disk->capacity / (heads * sectors);
+		cylinders = sector_div(disk->capacity, heads * sectors);
 	}
 
 	geom[0] = heads;
@@ -4318,7 +4316,7 @@
 }
 
 /**************************************************************************
-* qla2x00_device_queue_depth
+* qla2x00_slave_attach
 *   Determines the queue depth for a given device.  There are two ways
 *   a queue depth can be obtained for a tagged queueing device.  One
 *   way is the default queue depth which is determined by whether
@@ -4326,54 +4324,25 @@
 *   as the default queue depth.  Otherwise, we use either 4 or 8 as the
 *   default queue depth (dependent on the number of hardware SCBs).
 **************************************************************************/
-void
-qla2x00_device_queue_depth(scsi_qla_host_t *p, Scsi_Device *device)
+STATIC int
+qla2x00_slave_attach(Scsi_Device *device)
 {
-	int default_depth = 16;
+	int queue_depth = 16;
 
-	device->queue_depth = default_depth;
 	if (device->tagged_supported) {
 		device->tagged_queue = 1;
 		device->current_tag = 0;
 #if defined(MODULE)
 		if (!(ql2xmaxqdepth == 0 || ql2xmaxqdepth > 256))
-			device->queue_depth = ql2xmaxqdepth;
+			queue_depth = ql2xmaxqdepth;
 #endif
-
-		printk(KERN_INFO
-			"scsi(%d:%d:%d:%d): Enabled tagged queuing, "
-			"queue depth %d.\n",
-			(int)p->host_no,
-			device->channel,
-			device->id,
-			device->lun, 
-			device->queue_depth);
-	}
-
-}
-
-/**************************************************************************
-*   qla2x00_select_queue_depth
-*
-* Description:
-*   Sets the queue depth for each SCSI device hanging off the input
-*   host adapter.  We use a queue depth of 2 for devices that do not
-*   support tagged queueing.
-**************************************************************************/
-STATIC void
-qla2x00_select_queue_depth(struct Scsi_Host *host, Scsi_Device *scsi_devs)
-{
-	Scsi_Device *device;
-	scsi_qla_host_t  *p = (scsi_qla_host_t *) host->hostdata;
-
-	ENTER("qla2x00_select_queue_depth");
-
-	for (device = scsi_devs; device != NULL; device = device->next) {
-		if (device->host == host)
-			qla2x00_device_queue_depth(p, device);
+		printk(KERN_INFO "Enabled tagged queuing, queue depth %d for ",
+			queue_depth);
+		scsi_paths_printk(device, " ", "<%d:%d:%d:%d>");
+		printk("\n");
 	}
-
-	LEAVE("qla2x00_select_queue_depth");
+	scsi_adjust_queue_depth(device, MSG_ORDERED_TAG, queue_depth);
+	return 0;
 }
 
 /**************************************************************************
@@ -5793,7 +5762,9 @@
 	pci_set_master(ha->pdev);
 	pci_read_config_word(ha->pdev,OFFSET(creg->revision_id), &buf_wd);
 	ha->revision = buf_wd;
+#if (MEMORY_MAPPED_IO == 0)
 	if (!ha->iobase) {
+#endif
 		/* Get command register. */
 		if (pci_read_config_word(
 				ha->pdev,OFFSET(creg->command), 
@@ -5872,7 +5843,9 @@
 				}
 			}
 		}
+#if (MEMORY_MAPPED_IO == 0)
 	} else
+#endif
 		status = 0;
 
 
@@ -15903,9 +15876,16 @@
 		unsigned int cmd, unsigned long arg) 
 {
 	Scsi_Device fake_scsi_device;
-	fake_scsi_device.host = apidev_host;
+	int ret;
 
-	return (qla2x00_ioctl(&fake_scsi_device, (int)cmd, (void*)arg));
+	if (scsi_add_path(&fake_scsi_device, apidev_host, 0,
+		apidev_host->this_id, 0))
+		return -ENODEV;
+	ret = qla2x00_ioctl(&fake_scsi_device, (int)cmd, (void*)arg);
+	scsi_remove_path(&fake_scsi_device, SCSI_FIND_ALL_HOST_NO,
+			 SCSI_FIND_ALL_CHANNEL, SCSI_FIND_ALL_ID,
+			 SCSI_FIND_ALL_LUN);
+	return ret;
 }
 
 static struct file_operations apidev_fops = {
diff -urN -X /home/patman/dontdiff qla2x00src-v6.03.00b7/qla2x00.h qla2x00src-v6.03.00b7-mpath/qla2x00.h
--- qla2x00src-v6.03.00b7/qla2x00.h	Mon Oct 14 06:15:26 2002
+++ qla2x00src-v6.03.00b7-mpath/qla2x00.h	Wed Oct 23 13:12:42 2002
@@ -129,8 +129,8 @@
 /*
  * I/O register
 */
-/* #define MEMORY_MAPPED_IO  */    /* Enable memory mapped I/O */
-#undef MEMORY_MAPPED_IO            /* Disable memory mapped I/O */
+#define MEMORY_MAPPED_IO  1	/* Enable memory mapped I/O */
+/* #undef MEMORY_MAPPED_IO            Disable memory mapped I/O */
 
 #if defined(MEMORY_MAPPED_IO)
 #define RD_REG_BYTE(addr)         readb(addr)
@@ -2710,7 +2710,6 @@
 
 
 #define QLA2100_LINUX_TEMPLATE {				\
-        next:   NULL,						\
 	module: NULL,						\
 	proc_dir: NULL,						\
 	proc_info: qla2x00_proc_info,	                        \
@@ -2728,7 +2727,7 @@
 	eh_host_reset_handler: qla2xxx_eh_host_reset,		\
 	abort: NULL,						\
 	reset: NULL,						\
-	slave_attach: NULL,					\
+	slave_attach: qla2x00_slave_attach,			\
 	bios_param: QLA2100_BIOSPARAM,				\
 	can_queue: 255,		/* max simultaneous cmds      */\
 	this_id: -1,		/* scsi id of host adapter    */\
diff -urN -X /home/patman/dontdiff qla2x00src-v6.03.00b7/qla2x00_ioctl.c qla2x00src-v6.03.00b7-mpath/qla2x00_ioctl.c
--- qla2x00src-v6.03.00b7/qla2x00_ioctl.c	Mon Oct 14 06:15:26 2002
+++ qla2x00src-v6.03.00b7-mpath/qla2x00_ioctl.c	Wed Oct 23 13:01:02 2002
@@ -240,7 +240,9 @@
 		return (-EINVAL);
 	}
 
-	host = dev->host;
+	host = scsi_get_host(dev);
+	if (!host)
+		return(-EINVAL);
 	ha = (scsi_qla_host_t *) host->hostdata; /* midlayer chosen instance */
 
 	ret = verify_area(VERIFY_READ, (void *)arg, sizeof(EXT_IOCTL));
diff -urN -X /home/patman/dontdiff qla2x00src-v6.03.00b7/qla_settings.h qla2x00src-v6.03.00b7-mpath/qla_settings.h
--- qla2x00src-v6.03.00b7/qla_settings.h	Mon Oct 14 06:15:26 2002
+++ qla2x00src-v6.03.00b7-mpath/qla_settings.h	Wed Oct 23 13:11:58 2002
@@ -65,7 +65,7 @@
  * - a tasklet to process the done queue and send requests back to 
  *  the OS.
  */
-#define	QLA2X_PERFORMANCE		1 
+#define	QLA2X_PERFORMANCE		0 
 
 /* The following WORD_FW_LOAD is defined in Makefile for ia-64 builds
    and can also be decommented here for Word by Word confirmation of
