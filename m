Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUGWKDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUGWKDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 06:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267590AbUGWKBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 06:01:44 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:37040 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263159AbUGWJ5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 05:57:32 -0400
Date: Fri, 23 Jul 2004 18:58:50 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 5/5][Diskdump] IPF(IA64) support
In-reply-to: <14C4709A99D341indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Message-id: <19C4709BA75270indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <14C4709A99D341indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for Fusion-MPT scsi driver.


diff -Nur linux-2.6.7.org/drivers/message/fusion/linux_compat.h linux-2.6.7/drivers/message/fusion/linux_compat.h
--- linux-2.6.7.org/drivers/message/fusion/linux_compat.h	2004-06-22 10:27:55.000000000 +0900
+++ linux-2.6.7/drivers/message/fusion/linux_compat.h	2004-07-23 15:10:53.110010272 +0900
@@ -192,6 +192,18 @@
 #define MPT_INIT_WORK(_task, _func, _data) INIT_WORK(_task, _func, _data)
 #define mpt_sync_irq(_irq) synchronize_irq(_irq)
 
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
 /*}-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 #endif /* _LINUX_COMPAT_H */
 
diff -Nur linux-2.6.7.org/drivers/message/fusion/mptbase.c linux-2.6.7/drivers/message/fusion/mptbase.c
--- linux-2.6.7.org/drivers/message/fusion/mptbase.c	2004-06-22 10:27:55.000000000 +0900
+++ linux-2.6.7/drivers/message/fusion/mptbase.c	2004-07-23 15:10:53.114009664 +0900
@@ -6292,6 +6292,17 @@
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
+void
+mpt_poll_interrupt(MPT_ADAPTER *ioc)
+{
+	u32 intstat;
+
+	intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+
+	if(intstat & MPI_HIS_REPLY_MESSAGE_INTERRUPT)
+		mpt_interrupt(0, (void *)ioc, (struct pt_regs *)NULL);
+}
+/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 
 EXPORT_SYMBOL(mpt_adapters);
 EXPORT_SYMBOL(mpt_proc_root_dir);
@@ -6332,6 +6343,7 @@
 EXPORT_SYMBOL(mpt_ASCQ_TableSz);
 EXPORT_SYMBOL(mpt_ScsiOpcodesPtr);
 
+EXPORT_SYMBOL(mpt_poll_interrupt);
 
 static struct pci_driver mptbase_driver = {
 	.name		= "mptbase",
diff -Nur linux-2.6.7.org/drivers/message/fusion/mptbase.h linux-2.6.7/drivers/message/fusion/mptbase.h
--- linux-2.6.7.org/drivers/message/fusion/mptbase.h	2004-06-22 10:27:55.000000000 +0900
+++ linux-2.6.7/drivers/message/fusion/mptbase.h	2004-07-23 15:10:53.115009512 +0900
@@ -1066,6 +1066,8 @@
 extern int	 mpt_findImVolumes(MPT_ADAPTER *ioc);
 extern int	 mpt_read_ioc_pg_3(MPT_ADAPTER *ioc);
 
+extern void	 mpt_poll_interrupt(MPT_ADAPTER *ioc);
+
 /*
  *  Public data decl's...
  */
diff -Nur linux-2.6.7.org/drivers/message/fusion/mptscsih.c linux-2.6.7/drivers/message/fusion/mptscsih.c
--- linux-2.6.7.org/drivers/message/fusion/mptscsih.c	2004-06-22 10:27:55.000000000 +0900
+++ linux-2.6.7/drivers/message/fusion/mptscsih.c	2004-07-23 15:10:53.119008904 +0900
@@ -273,6 +273,8 @@
 	.max_sectors			= MPT_SCSI_MAX_SECTORS,
 	.cmd_per_lun			= MPT_SCSI_CMD_PER_LUN,
 	.use_clustering			= ENABLE_CLUSTERING,
+	.dump_sanity_check		= x_scsi_sanity_check,
+	.dump_poll			= x_scsi_poll,
 };
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
@@ -3053,7 +3055,7 @@
 	/*  If our attempts to reset the host failed, then return a failed
 	 *  status.  The host will be taken off line by the SCSI mid-layer.
 	 */
-	spin_unlock_irq(host_lock);
+	MPT_HOST_UNLOCK(host_lock);
 	if (mpt_HardResetHandler(hd->ioc, CAN_SLEEP) < 0){
 		status = FAILED;
 	} else {
@@ -3063,7 +3065,7 @@
 		hd->tmPending = 0;
 		hd->tmState = TM_STATE_NONE;
 	}
-	spin_lock_irq(host_lock);
+	MPT_HOST_LOCK(host_lock)
 
 
 	dtmprintk( ( KERN_WARNING MYNAM ": mptscsih_host_reset: "
@@ -7272,6 +7274,38 @@
 }
 #endif
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
+int
+mptscsih_sanity_check(struct scsi_device *sdev)
+{
+	MPT_ADAPTER    *ioc;
+	MPT_SCSI_HOST  *hd;
+
+	hd = (MPT_SCSI_HOST *)sdev->host->hostdata;
+	if(!hd)
+		return -ENXIO;
+	ioc = hd->ioc;
+
+	/* message frame freeQ is busy */
+	if(spin_is_locked(&ioc->FreeQlock)) {
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+void
+mptscsih_poll(struct scsi_device *sdev)
+{
+	MPT_SCSI_HOST  *hd;
+
+	hd = (MPT_SCSI_HOST *)sdev->host->hostdata;
+	if(!hd)
+		return;
+
+	/* check interrupt pending */
+	mpt_poll_interrupt(hd->ioc);
+}
+/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 
 
 module_init(mptscsih_init);
diff -Nur linux-2.6.7.org/drivers/message/fusion/mptscsih.h linux-2.6.7/drivers/message/fusion/mptscsih.h
--- linux-2.6.7.org/drivers/message/fusion/mptscsih.h	2004-06-22 10:27:55.000000000 +0900
+++ linux-2.6.7/drivers/message/fusion/mptscsih.h	2004-07-23 15:10:53.120008752 +0900
@@ -143,6 +143,9 @@
 #define x_scsi_slave_destroy	mptscsih_slave_destroy
 #define x_scsi_proc_info	mptscsih_proc_info
 
+#define x_scsi_sanity_check	mptscsih_sanity_check
+#define x_scsi_poll		mptscsih_poll
+
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*
  *	MPT SCSI Host / Initiator decls...
@@ -160,6 +163,9 @@
 extern	void		 x_scsi_slave_destroy(Scsi_Device *);
 extern	int		 x_scsi_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);
 
+extern	int		 x_scsi_sanity_check(struct scsi_device *);
+extern	void		 x_scsi_poll(struct scsi_device *);
+
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 
 /*  include/scsi/scsi.h may not be quite complete...  */
