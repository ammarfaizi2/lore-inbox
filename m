Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbUK2KuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbUK2KuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUK2KtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:49:13 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:8608 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261669AbUK2Knw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:43:52 -0500
Date: Mon, 29 Nov 2004 19:45:23 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [ANNOUNCE 5/7] Diskdump 1.0 Release
In-reply-to: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
Message-id: <3FC4D600876552indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.71
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for Fusion-MPT scsi driver.


diff -Nur linux-2.6.9.org/drivers/message/fusion/mptbase.c linux-2.6.9/drivers/message/fusion/mptbase.c
--- linux-2.6.9.org/drivers/message/fusion/mptbase.c	2004-10-19 06:55:36.000000000 +0900
+++ linux-2.6.9/drivers/message/fusion/mptbase.c	2004-11-24 17:09:56.332831949 +0900
@@ -3164,7 +3164,7 @@
 		 *
 		 */
 		CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val | MPI_DIAG_DISABLE_ARM);
-		mdelay (1);
+		MPT_MDELAY (1);
 
 		/*
 		 * Now hit the reset bit in the Diagnostic register
@@ -5928,6 +5928,23 @@
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
+
+/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 EXPORT_SYMBOL(ioc_list);
 EXPORT_SYMBOL(mpt_proc_root_dir);
 EXPORT_SYMBOL(DmpService);
@@ -6047,6 +6064,7 @@
 #endif
 }
 
+EXPORT_SYMBOL_GPL(mpt_poll_interrupt);
 
 module_init(fusion_init);
 module_exit(fusion_exit);
diff -Nur linux-2.6.9.org/drivers/message/fusion/mptbase.h linux-2.6.9/drivers/message/fusion/mptbase.h
--- linux-2.6.9.org/drivers/message/fusion/mptbase.h	2004-10-19 06:53:22.000000000 +0900
+++ linux-2.6.9/drivers/message/fusion/mptbase.h	2004-11-24 17:09:56.336738199 +0900
@@ -1113,6 +1113,7 @@
 extern void	 mpt_free_fw_memory(MPT_ADAPTER *ioc);
 extern int	 mpt_findImVolumes(MPT_ADAPTER *ioc);
 extern int	 mpt_read_ioc_pg_3(MPT_ADAPTER *ioc);
+extern void	 mpt_poll_interrupt(MPT_ADAPTER *ioc);
 
 /*
  *  Public data decl's...
@@ -1124,6 +1125,29 @@
 extern int		  mpt_lan_index;	/* needed by mptlan.c */
 extern int		  mpt_stm_index;	/* needed by mptstm.c */
 
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
+#define MPT_MDELAY(n)				\
+	if (crashdump_mode())			\
+		diskdump_mdelay(n);		\
+	else					\
+		mdelay(n);
+
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 #endif		/* } __KERNEL__ */
 
diff -Nur linux-2.6.9.org/drivers/message/fusion/mptscsih.c linux-2.6.9/drivers/message/fusion/mptscsih.c
--- linux-2.6.9.org/drivers/message/fusion/mptscsih.c	2004-10-19 06:55:36.000000000 +0900
+++ linux-2.6.9/drivers/message/fusion/mptscsih.c	2004-11-24 17:09:56.339667887 +0900
@@ -2578,7 +2578,7 @@
 	/*  If our attempts to reset the host failed, then return a failed
 	 *  status.  The host will be taken off line by the SCSI mid-layer.
 	 */
-	spin_unlock_irq(host_lock);
+	MPT_HOST_UNLOCK(host_lock);
 	if (mpt_HardResetHandler(hd->ioc, CAN_SLEEP) < 0){
 		status = FAILED;
 	} else {
@@ -2588,7 +2588,7 @@
 		hd->tmPending = 0;
 		hd->tmState = TM_STATE_NONE;
 	}
-	spin_lock_irq(host_lock);
+	MPT_HOST_LOCK(host_lock);
 
 
 	dtmprintk( ( KERN_WARNING MYNAM ": mptscsih_host_reset: "
@@ -2973,6 +2973,49 @@
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
@@ -3322,6 +3365,8 @@
 	.max_sectors			= 8192,
 	.cmd_per_lun			= 7,
 	.use_clustering			= ENABLE_CLUSTERING,
+	.dump_sanity_check		= mptscsih_sanity_check,
+	.dump_poll			= mptscsih_poll,
 };
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
@@ -4770,6 +4815,9 @@
 	}
 	spin_unlock_irqrestore(&dvtaskQ_lock, flags);
 
+	if (crashdump_mode())
+		return;
+
 	/* For this ioc, loop through all devices and do dv to each device.
 	 * When complete with this ioc, search through the ioc list, and
 	 * for each scsi ioc found, do dv for all devices. Exit when no
