Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbUK2KuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUK2KuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUK2KuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:50:05 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:8345 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261659AbUK2KrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:47:07 -0500
Date: Mon, 29 Nov 2004 19:48:41 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [ANNOUNCE 7/7] Diskdump 1.0 Release
In-reply-to: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
Message-id: <41C4D600FD8FDFindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.71
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for IBM Power Linux RAID driver.


diff -Nur linux-2.6.9.org/drivers/scsi/ipr.c linux-2.6.9/drivers/scsi/ipr.c
--- linux-2.6.9.org/drivers/scsi/ipr.c	2004-10-19 06:55:36.000000000 +0900
+++ linux-2.6.9/drivers/scsi/ipr.c	2004-11-24 19:20:56.889376282 +0900
@@ -71,6 +71,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/diskdump.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/processor.h>
@@ -1264,7 +1265,13 @@
 		ipr_initiate_ioa_reset(ioa_cfg, shutdown_type);
 
 	spin_unlock_irq(ioa_cfg->host->host_lock);
-	wait_event(ioa_cfg->reset_wait_q, !ioa_cfg->in_reset_reload);
+	if (crashdump_mode()) {
+		while (ioa_cfg->in_reset_reload) {
+			diskdump_update();
+			diskdump_mdelay(1);
+		}
+	} else
+		wait_event(ioa_cfg->reset_wait_q, !ioa_cfg->in_reset_reload);
 	spin_lock_irq(ioa_cfg->host->host_lock);
 
 	/* If we got hit with a host reset while we were already resetting
@@ -3288,6 +3295,80 @@
 }
 
 /**
+ * ipr_poll - Check for command completion
+ * @sdev:	the SCSI device to which the command was queued
+ *
+ * This function is called after the diskdump subsystem has queued an
+ * I/O command to the indicated device.  Since interrupts are disabled,
+ * this function is called periodically to detect command completion.
+ * To report completion, ipr_cmd->done() sets a value that our caller
+ * can monitor.
+ **/
+static void ipr_poll(struct scsi_device *sdev)
+{
+	struct ipr_ioa_cfg *ioa_cfg =
+		(struct ipr_ioa_cfg *) sdev->host->hostdata;
+	u16 cmd_index;
+	struct ipr_cmnd *ipr_cmd;
+	unsigned long lock_flags = 0;
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+
+	while ((be32_to_cpu(*ioa_cfg->hrrq_curr) & IPR_HRRQ_TOGGLE_BIT) ==
+	       ioa_cfg->toggle_bit) {
+		cmd_index = (be32_to_cpu(*ioa_cfg->hrrq_curr) &
+			IPR_HRRQ_REQ_RESP_HANDLE_MASK) >> IPR_HRRQ_REQ_RESP_HANDLE_SHIFT;
+
+		if (unlikely(cmd_index >= IPR_NUM_CMD_BLKS)) {
+			/* FIXME: Need to abort the diskdump. */
+			panic("Command index %u out of range in %s\n",
+				cmd_index, __FUNCTION__);
+			/*NOTREACHED*/
+		}
+
+		ipr_cmd = ioa_cfg->ipr_cmnd_list[cmd_index];
+		list_del(&ipr_cmd->queue);
+		del_timer(&ipr_cmd->timer);
+		ipr_cmd->done(ipr_cmd);
+
+		if (ioa_cfg->hrrq_curr < ioa_cfg->hrrq_end) {
+			ioa_cfg->hrrq_curr++;
+		} else {
+			ioa_cfg->hrrq_curr = ioa_cfg->hrrq_start;
+			ioa_cfg->toggle_bit ^= 1u;
+		}
+	}
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+}
+
+/**
+ * ipr_sanity_check - Verify that SCSI device can receive dump
+ * @sdev:	the SCSI device
+ *
+ * Called by mid-layer diskdump sanity-check function to determine
+ * whether the indicated device is operational.  Caller has already
+ * verified that scsi_device_online(device) is true.
+ *
+ * Return value:
+ *	0 for a good device, < 0 for a bad one
+ */
+static int ipr_sanity_check(struct scsi_device *sdev)
+{
+	struct ipr_ioa_cfg *ioa_cfg;
+	if (!sdev->host) {
+		return -ENXIO;
+	}
+	ioa_cfg = (struct ipr_ioa_cfg *) sdev->host->hostdata;
+	if (!ioa_cfg) {
+		return -ENXIO;
+	}
+	if (ioa_cfg->ioa_is_dead) {
+		return -EIO;
+	}
+	return 0;
+}
+
+/**
  * ipr_build_ioadl - Build a scatter/gather list and map the buffer
  * @ioa_cfg:	ioa config struct
  * @ipr_cmd:	ipr command struct
@@ -3967,7 +4048,9 @@
 	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = ipr_ioa_attrs,
 	.sdev_attrs = ipr_dev_attrs,
-	.proc_name = IPR_NAME
+	.proc_name = IPR_NAME,
+	.dump_sanity_check = ipr_sanity_check,
+	.dump_poll = ipr_poll
 };
 
 #ifdef CONFIG_PPC_PSERIES
