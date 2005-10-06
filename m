Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVJFXzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVJFXzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVJFXzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:55:46 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:62601 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932084AbVJFXzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:55:45 -0400
Date: Thu, 6 Oct 2005 18:55:42 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 18/22] PCI Error Recovery:  IPR SCSI device driver
Message-ID: <20051006235542.GS29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI Error Recovery:  IPR SCSI device driver

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the IPR SCSI device driver.
The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Brian King <brking@us.ibm.com>

--
 arch/ppc64/configs/pSeries_defconfig |    1 
 drivers/scsi/Kconfig                 |    8 +++
 drivers/scsi/ipr.c                   |   93 +++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

Index: linux-2.6.14-rc2-git6/drivers/scsi/Kconfig
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/scsi/Kconfig	2005-10-06 17:50:21.443154534 -0500
+++ linux-2.6.14-rc2-git6/drivers/scsi/Kconfig	2005-10-06 17:56:53.965079951 -0500
@@ -1087,6 +1087,14 @@
 	  If you enable this support, the iprdump daemon can be used
 	  to capture adapter failure analysis information.
 
+config SCSI_IPR_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on SCSI_IPR && PPC_PSERIES
+	help
+		If you say Y here, the driver will be able to recover from
+		PCI bus errors on many PowerPC platforms. IBM pSeries users
+		should answer Y.
+
 config SCSI_ZALON
 	tristate "Zalon SCSI support"
 	depends on GSC && SCSI
Index: linux-2.6.14-rc2-git6/drivers/scsi/ipr.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/scsi/ipr.c	2005-10-06 17:50:21.444154394 -0500
+++ linux-2.6.14-rc2-git6/drivers/scsi/ipr.c	2005-10-06 17:56:53.972078969 -0500
@@ -5326,6 +5326,94 @@
 				shutdown_type);
 }
 
+#ifdef CONFIG_SCSI_IPR_EEH_RECOVERY
+
+/** If the PCI slot is frozen, hold off all i/o
+ *  activity; then, as soon as the slot is available again,
+ *  initiate an adapter reset.
+ */
+static int ipr_reset_freeze(struct ipr_cmnd *ipr_cmd)
+{
+	/* Disallow new interrupts, avoid loop */
+	ipr_cmd->ioa_cfg->allow_interrupts = 0;
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->ioa_cfg->pending_q);
+	ipr_cmd->done = ipr_reset_ioa_job;
+	return IPR_RC_JOB_RETURN;
+}
+
+/** ipr_eeh_frozen -- called when slot has experience PCI bus error.
+ *  This routine is called to tell us that the PCI bus is down.
+ *  Can't do anything here, except put the device driver into a
+ *  holding pattern, waiting for the PCI bus to come back.
+ */
+static void ipr_eeh_frozen (struct pci_dev *pdev)
+{
+	unsigned long flags = 0;
+	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
+	_ipr_initiate_ioa_reset(ioa_cfg, ipr_reset_freeze, IPR_SHUTDOWN_NONE);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
+}
+
+/** ipr_eeh_slot_reset - called when pci slot has been reset.
+ *
+ * This routine is called by the pci error recovery recovery
+ * code after the PCI slot has been reset, just before we
+ * should resume normal operations.
+ */
+static int ipr_eeh_slot_reset(struct pci_dev *pdev)
+{
+	unsigned long flags = 0;
+	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
+
+	// pci_enable_device(pdev);
+	// pci_set_master(pdev);
+	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
+	_ipr_initiate_ioa_reset(ioa_cfg, ipr_reset_restore_cfg_space,
+	                                 IPR_SHUTDOWN_NONE);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** This routine is called when the PCI bus has permanently
+ *  failed.  This routine should purge all pending I/O and
+ *  shut down the device driver (close and unload).
+ */
+static void ipr_eeh_perm_failure(struct pci_dev *pdev)
+{
+	unsigned long flags = 0;
+	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
+
+	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
+	if (ioa_cfg->sdt_state == WAIT_FOR_DUMP)
+		ioa_cfg->sdt_state = ABORT_DUMP;
+	ioa_cfg->reset_retries = IPR_NUM_RESET_RELOAD_RETRIES;
+	ioa_cfg->in_ioa_bringdown = 1;
+	ipr_initiate_ioa_reset(ioa_cfg, IPR_SHUTDOWN_NONE);
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
+}
+
+static int ipr_eeh_error_detected(struct pci_dev *pdev,
+                                enum pci_channel_state state)
+{
+	switch (state) {
+		case pci_channel_io_frozen:
+			ipr_eeh_frozen (pdev);
+			return PCIERR_RESULT_NEED_RESET;
+
+		case pci_channel_io_perm_failure:
+			ipr_eeh_perm_failure (pdev);
+			return PCIERR_RESULT_DISCONNECT;
+			break;
+		default:
+			break;
+	}
+	return PCIERR_RESULT_NEED_RESET;
+}
+#endif
+
 /**
  * ipr_probe_ioa_part2 - Initializes IOAs found in ipr_probe_ioa(..)
  * @ioa_cfg:	ioa cfg struct
@@ -6063,12 +6151,23 @@
 };
 MODULE_DEVICE_TABLE(pci, ipr_pci_table);
 
+
+#ifdef CONFIG_SCSI_IPR_EEH_RECOVERY
+static struct pci_error_handlers ipr_err_handler = {
+	.error_detected = ipr_eeh_error_detected,
+	.slot_reset = ipr_eeh_slot_reset,
+};
+#endif /* CONFIG_SCSI_IPR_EEH_RECOVERY */
+
 static struct pci_driver ipr_driver = {
 	.name = IPR_NAME,
 	.id_table = ipr_pci_table,
 	.probe = ipr_probe,
 	.remove = ipr_remove,
 	.shutdown = ipr_shutdown,
+#ifdef CONFIG_SCSI_IPR_EEH_RECOVERY
+	.err_handler = &ipr_err_handler,
+#endif /* CONFIG_SCSI_IPR_EEH_RECOVERY */
 };
 
 /**
Index: linux-2.6.14-rc2-git6/arch/ppc64/configs/pSeries_defconfig
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/configs/pSeries_defconfig	2005-10-06 17:50:21.444154394 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/configs/pSeries_defconfig	2005-10-06 17:56:53.974078688 -0500
@@ -476,6 +476,7 @@
 CONFIG_SCSI_IPR=y
 CONFIG_SCSI_IPR_TRACE=y
 CONFIG_SCSI_IPR_DUMP=y
+CONFIG_SCSI_IPR_EEH_RECOVERY=y
 # CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 CONFIG_SCSI_QLA2XXX=y
