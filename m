Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271750AbTHNXbi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 19:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271808AbTHNXbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 19:31:37 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:945 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S271750AbTHNXbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 19:31:32 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: jes@wildopensource.com
Date: Fri, 15 Aug 2003 09:30:09 +1000
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Problems building drivers/scsi/qla1280.c in BK current
Message-ID: <20030814233009.GH5518@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

When building I got a failure :

drivers/scsi/qla1280.c: In function `qla1280_done':
drivers/scsi/qla1280.c:1833: warning: implicit declaration of function `qla1280_get_target_options'
drivers/scsi/qla1280.c: At top level:
drivers/scsi/qla1280.c:4506: warning: type mismatch with previous implicit declaration
drivers/scsi/qla1280.c:1833: warning: previous implicit declaration of `qla1280_get_target_options'
drivers/scsi/qla1280.c:4506: warning: `qla1280_get_target_options' was previously implicitly declared to return `int'
drivers/scsi/qla1280.c:4830: warning: initialization from incompatible pointer type
drivers/scsi/qla1280.c:4830: error: unknown field `command' specified in initializer
drivers/scsi/sym53c8xx_2/sym_glue.c: In function `sym53c8xx_pci_init':
drivers/scsi/sym53c8xx_2/sym_glue.c:2323: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
make[2]: *** [drivers/scsi/qla1280.o] Error 1

qla1280.c seems to use LINUX_KERNEL_VERSION where I think it really
wants LINUX_VERSION_CODE.  While I was there I changed the other
checks to use the KERNEL_VERSION macro.  

I also changed the blk.h include because it says :
In file included from drivers/scsi/qla1280.c:299:
include/linux/blk.h:1:2: warning: #warning this file is obsolete, please use linux/blkdev.h instead

Also I required the attached change to qla1280.h

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au
--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qla1280.c.diff"

===== qla1280.c 1.43 vs edited =====
--- 1.43/drivers/scsi/qla1280.c	Sun Aug  3 06:33:43 2003
+++ edited/qla1280.c	Fri Aug 15 09:12:39 2003
@@ -296,7 +296,7 @@
 #include <linux/sched.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
-#include <linux/blk.h>
+#include <linux/blkdev.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
@@ -311,13 +311,13 @@
 #include <asm/types.h>
 #include <asm/system.h>
 
-#if LINUX_VERSION_CODE < 0x020545
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,45)
 #include "sd.h"
 #endif
 #include "scsi.h"
 #include "hosts.h"
 
-#if LINUX_VERSION_CODE < 0x020407
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,7)
 #error "Kernels older than 2.4.7 are no longer supported"
 #endif
 
@@ -385,7 +385,7 @@
 
 #define NVRAM_DELAY()			udelay(500)	/* 2 microseconds */
 
-#if LINUX_VERSION_CODE < 0x020500
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 #define HOST_LOCK			&io_request_lock
 #define irqreturn_t			void
 #define IRQ_RETVAL(foo)
@@ -412,7 +412,7 @@
 static void qla1280_done(struct scsi_qla_host *, struct srb **, struct srb **);
 static void qla1280_done_q_put(struct srb *, struct srb **, struct srb **);
 static int qla1280_slave_configure(Scsi_Device *);
-#if LINUX_VERSION_CODE < 0x020545
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,45)
 static void qla1280_select_queue_depth(struct Scsi_Host *, Scsi_Device *);
 void qla1280_get_target_options(struct scsi_cmnd *, struct scsi_qla_host *);
 #endif
@@ -546,7 +546,7 @@
 #define	CMD_SNSLEN(Cmnd)	sizeof(Cmnd->sense_buffer)
 #define	CMD_RESULT(Cmnd)	Cmnd->result
 #define	CMD_HANDLE(Cmnd)	Cmnd->host_scribble
-#if LINUX_VERSION_CODE < 0x020545
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,45)
 #define	CMD_HOST(Cmnd)		Cmnd->host
 #define CMD_REQUEST(Cmnd)	Cmnd->request.cmd
 #define SCSI_BUS_32(Cmnd)	Cmnd->channel
@@ -866,7 +866,7 @@
 	printk(KERN_INFO "qla1280: %s found on PCI bus %i, dev %i\n",
 	       bdp->name, pdev->bus->number, PCI_SLOT(pdev->devfn));
 
-#if LINUX_VERSION_CODE >= 0x020545
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,45)
 	template->slave_configure = qla1280_slave_configure;
 #endif
 	host = scsi_register(template, sizeof(struct scsi_qla_host));
@@ -876,7 +876,7 @@
 		goto error;
 	}
 
-#if LINUX_VERSION_CODE < 0x020545
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,45)
 	scsi_set_pci_device(host, pdev);
 #else
 	scsi_set_device(host, &pdev->dev);
@@ -909,7 +909,7 @@
 	host->max_lun = MAX_LUNS - 1;
 	host->max_id = MAX_TARGETS;
 	host->max_sectors = 1024;
-#if LINUX_VERSION_CODE < 0x020545
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,45)
 	host->select_queue_depths = qla1280_select_queue_depth;
 #endif
 
@@ -1508,7 +1508,7 @@
  *   Return the disk geometry for the given SCSI device.
  **************************************************************************/
 int
-#if LINUX_VERSION_CODE < 0x020545
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,45)
 qla1280_biosparam(Disk * disk, kdev_t dev, int geom[])
 #else
 qla1280_biosparam(struct scsi_device *sdev, struct block_device *bdev,
@@ -1516,7 +1516,7 @@
 #endif
 {
 	int heads, sectors, cylinders;
-#if LINUX_VERSION_CODE < 0x020545
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,45)
 	unsigned long capacity = disk->capacity;
 #endif
 
@@ -1676,7 +1676,7 @@
 	int target = device->id;
 	int status = 0;
 	struct nvram *nv;
-#if LINUX_VERSION_CODE < 0x020500
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	unsigned long flags;
 #endif
 
@@ -1694,7 +1694,7 @@
 		scsi_adjust_queue_depth(device, 0, default_depth);
 	}
 
-#if LINUX_VERSION_CODE > 0x020500
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0)
 	nv->bus[bus].target[target].parameter.f.enable_sync = device->sdtr;
 	nv->bus[bus].target[target].parameter.f.enable_wide = device->wdtr;
 	nv->bus[bus].target[target].ppr_1x160.flags.enable_ppr = device->ppr;
@@ -1716,7 +1716,7 @@
 			nv->bus[bus].target[target].ppr_1x160.flags.enable_ppr = 0;
 	}
 
-#if LINUX_VERSION_CODE < 0x020500
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	spin_lock_irqsave(HOST_LOCK, flags);
 #endif
 	if (nv->bus[bus].target[target].parameter.f.enable_sync) {
@@ -1724,13 +1724,13 @@
 	}
 
 	qla12160_get_target_parameters(ha, device);
-#if LINUX_VERSION_CODE < 0x020500
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	spin_unlock_irqrestore(HOST_LOCK, flags);
 #endif
 	return status;
 }
 
-#if LINUX_VERSION_CODE < 0x020545
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,45)
 /**************************************************************************
  *   qla1280_select_queue_depth
  *
@@ -1828,7 +1828,7 @@
 		CMD_HANDLE(sp->cmd) = (unsigned char *)INVALID_HANDLE;
 		ha->actthreads--;
 
-#if LINUX_KERNEL_VERSION < 0x020500
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 		if (cmd->cmnd[0] == INQUIRY)
 			qla1280_get_target_options(cmd, ha);
 #endif
@@ -3211,7 +3211,7 @@
 	timer.function = qla1280_mailbox_timeout;
 	add_timer(&timer);
 
-#if LINUX_VERSION_CODE < 0x020500
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	spin_unlock_irq(HOST_LOCK);
 #endif
 	WRT_REG_WORD(&reg->host_cmd, HC_SET_HOST_INT);
@@ -3220,7 +3220,7 @@
 	wait_for_completion(&wait);
 	del_timer_sync(&timer);
 
-#if LINUX_VERSION_CODE < 0x020500
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	spin_lock_irq(HOST_LOCK);
 #endif
 
@@ -4497,7 +4497,7 @@
 }
 
 
-#if LINUX_KERNEL_VERSION < 0x020500
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 /*
  *
  */

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qla1280.h.diff"

===== qla1280.h 1.20 vs edited =====
--- 1.20/drivers/scsi/qla1280.h	Wed Jul 23 19:12:03 2003
+++ edited/qla1280.h	Fri Aug 15 09:15:06 2003
@@ -1148,7 +1148,6 @@
 	.release = qla1280_release,				\
 	.info = qla1280_info,					\
 	.ioctl = NULL,						\
-	.command = NULL,					\
 	.queuecommand = qla1280_queuecommand,			\
 	.eh_strategy_handler = NULL,				\
 	.eh_abort_handler = qla1280_eh_abort,			\

--MW5yreqqjyrRcusr--
