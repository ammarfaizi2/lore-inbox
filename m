Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUH1JyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUH1JyK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUH1JxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:53:08 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:22729 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267400AbUH1Jqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:46:48 -0400
Date: Sat, 28 Aug 2004 18:48:11 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 4/4][diskdump] x86-64 support
In-reply-to: <89C48CE36A27FFindou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org
Message-id: <8DC48CE421568Cindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <89C48CE36A27FFindou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for Fusion-MPT scsi driver.


diff -Nur linux-2.6.8.1.org/drivers/message/fusion/mptbase.c linux-2.6.8.1/drivers/message/fusion/mptbase.c
--- linux-2.6.8.1.org/drivers/message/fusion/mptbase.c	2004-08-25 15:55:50.548987590 +0900
+++ linux-2.6.8.1/drivers/message/fusion/mptbase.c	2004-08-25 19:02:34.647483153 +0900
@@ -5950,6 +5950,22 @@
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
+/**
+ *	mpt_poll_interrupt - Check the status of interrupt and if any interrupt
+ *	are triggered, call interrupt handler.
+ *	@ioc: Pointer to MPT_ADAPTER structure
+ */
+void
+mpt_poll_interrupt(MPT_ADAPTER *ioc)
+{
+	u32 intstat;
+
+	intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+
+	if (intstat & MPI_HIS_REPLY_MESSAGE_INTERRUPT)
+		mpt_interrupt(0, ioc, NULL);
+}
+/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 
 EXPORT_SYMBOL(ioc_list);
 EXPORT_SYMBOL(mpt_proc_root_dir);
@@ -5988,6 +6004,7 @@
 EXPORT_SYMBOL(mpt_ASCQ_TableSz);
 EXPORT_SYMBOL(mpt_ScsiOpcodesPtr);
 
+EXPORT_SYMBOL(mpt_poll_interrupt);
 
 static struct pci_driver mptbase_driver = {
 	.name		= "mptbase",
diff -Nur linux-2.6.8.1.org/drivers/message/fusion/mptbase.h linux-2.6.8.1/drivers/message/fusion/mptbase.h
--- linux-2.6.8.1.org/drivers/message/fusion/mptbase.h	2004-08-25 15:55:50.546057903 +0900
+++ linux-2.6.8.1/drivers/message/fusion/mptbase.h	2004-08-25 19:03:35.213888661 +0900
@@ -1075,6 +1075,7 @@
 extern void	 mpt_free_fw_memory(MPT_ADAPTER *ioc);
 extern int	 mpt_findImVolumes(MPT_ADAPTER *ioc);
 extern int	 mpt_read_ioc_pg_3(MPT_ADAPTER *ioc);
+extern void	 mpt_poll_interrupt(MPT_ADAPTER *ioc);
 
 /*
  *  Public data decl's...
@@ -1090,6 +1091,23 @@
 extern const char	**mpt_ScsiOpcodesPtr;
 extern int		  mpt_ASCQ_TableSz;
 
+/*
+ *  Dump stuff...
+ */
+#include <linux/diskdump.h>
+
+#define MPT_HOST_LOCK(host_lock)		\
+	if (crashdump_mode()) 			\
+		spin_lock(host_lock);		\
+	else					\
+		spin_lock_irq(host_lock);
+
+#define MPT_HOST_UNLOCK(host_lock)		\
+	if (crashdump_mode())			\
+		spin_unlock(host_lock);		\
+	else					\
+		spin_unlock_irq(host_lock);
+
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 #endif		/* } __KERNEL__ */
 
diff -Nur linux-2.6.8.1.org/drivers/message/fusion/mptscsih.c linux-2.6.8.1/drivers/message/fusion/mptscsih.c
--- linux-2.6.8.1.org/drivers/message/fusion/mptscsih.c	2004-08-25 15:55:50.548987590 +0900
+++ linux-2.6.8.1/drivers/message/fusion/mptscsih.c	2004-08-25 19:02:34.652365965 +0900
@@ -2892,7 +2892,7 @@
 	/*  If our attempts to reset the host failed, then return a failed
 	 *  status.  The host will be taken off line by the SCSI mid-layer.
 	 */
-	spin_unlock_irq(host_lock);
+	MPT_HOST_UNLOCK(host_lock);
 	if (mpt_HardResetHandler(hd->ioc, CAN_SLEEP) < 0){
 		status = FAILED;
 	} else {
@@ -2902,7 +2902,7 @@
 		hd->tmPending = 0;
 		hd->tmState = TM_STATE_NONE;
 	}
-	spin_lock_irq(host_lock);
+	MPT_HOST_LOCK(host_lock);
 
 
 	dtmprintk( ( KERN_WARNING MYNAM ": mptscsih_host_reset: "
@@ -3284,6 +3284,49 @@
 	return 0;
 }
 
+/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
+/*
+ *	OS entry point to check whether the host drivier is sane enough
+ *	to be used for saving crash dump. Called once when system crash
+ *	occurs.
+ */
+int
+mptscsih_sanity_check(struct scsi_device *sdev)
+{
+	MPT_ADAPTER    *ioc;
+	MPT_SCSI_HOST  *hd;
+
+	hd = (MPT_SCSI_HOST *) sdev->host->hostdata;
+	if (!hd)
+		return -ENXIO;
+	ioc = hd->ioc;
+
+	/* message frame freeQ is busy */
+	if (spin_is_locked(&ioc->FreeQlock))
+		return -EBUSY;
+
+	return 0;
+}
+
+/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
+/*
+ *	OS entry point to poll whether the adapter issue the interrupts.
+ *	Called repeatedly after I/O commands are issued to this adapter.
+ */
+void
+mptscsih_poll(struct scsi_device *sdev)
+{
+	MPT_SCSI_HOST  *hd;
+
+	hd = (MPT_SCSI_HOST *) sdev->host->hostdata;
+	if (!hd)
+		return;
+
+	/* check interrupt pending */
+	mpt_poll_interrupt(hd->ioc);
+}
+/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
+
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*
@@ -3764,6 +3807,8 @@
 	.max_sectors			= 8192,
 	.cmd_per_lun			= 7,
 	.use_clustering			= ENABLE_CLUSTERING,
+	.dump_sanity_check		= mptscsih_sanity_check,
+	.dump_poll			= mptscsih_poll,
 };
 
 
@@ -5580,6 +5625,9 @@
 	}
 	spin_unlock_irqrestore(&dvtaskQ_lock, flags);
 
+	if (crashdump_mode())
+		return;
+
 	/* For this ioc, loop through all devices and do dv to each device.
 	 * When complete with this ioc, search through the ioc list, and
 	 * for each scsi ioc found, do dv for all devices. Exit when no
