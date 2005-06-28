Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVF2CWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVF2CWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVF2CU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 22:20:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:36501 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262301AbVF1X6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:58:47 -0400
Date: Tue, 28 Jun 2005 18:58:39 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 3/13]: PCI Err: IPR scsi device driver recovery
Message-ID: <20050628235839.GA6362@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-3-ipr.patch

Adds PCI error recovery callbacks to the IPR SCSI controller
driver. Tested, seems to work well, a variant of this ships
already in the Novell/SUSE SLES9 SP2 kernel.

Signed-off-by: Linas Vepstas <linas@linas.org>

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-3-ipr.patch"

--- linux-2.6.12-git10/drivers/scsi/ipr.c.linas-orig	2005-06-22 15:26:14.000000000 -0500
+++ linux-2.6.12-git10/drivers/scsi/ipr.c	2005-06-22 17:05:14.000000000 -0500
@@ -5326,6 +5326,88 @@ static void ipr_initiate_ioa_reset(struc
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
+static int ipr_eeh_slot_reset (struct pci_dev *pdev)
+{
+	unsigned long flags = 0;
+	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
+
+	pci_enable_device(pdev);
+	pci_set_master(pdev);
+	enable_irq (pdev->irq);
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
+ *  XXX Needs to be implemented.
+ */
+static void ipr_eeh_perm_failure (struct pci_dev *pdev)
+{
+#if 0  // XXXXXXXXXXXXXXXXXXXXXXX
+	ipr_cmd->job_step = ipr_reset_shutdown_ioa;
+	rc = IPR_RC_JOB_CONTINUE;
+#endif
+}
+
+static int ipr_eeh_error_detected (struct pci_dev *pdev,
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
@@ -6068,6 +6150,10 @@ static struct pci_driver ipr_driver = {
 	.id_table = ipr_pci_table,
 	.probe = ipr_probe,
 	.remove = ipr_remove,
+	.err_handler = {
+		.error_detected = ipr_eeh_error_detected,
+		.slot_reset = ipr_eeh_slot_reset,
+	},
 	.driver = {
 		.shutdown = ipr_shutdown,
 	},
--- linux-2.6.12-git10/drivers/scsi/Kconfig.linas-orig	2005-06-22 15:26:14.000000000 -0500
+++ linux-2.6.12-git10/drivers/scsi/Kconfig	2005-06-22 15:28:29.000000000 -0500
@@ -1065,6 +1065,14 @@ config SCSI_IPR_DUMP
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
--- linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig	2005-06-22 15:30:33.000000000 -0500
@@ -314,6 +314,7 @@ CONFIG_SCSI_IPR
 CONFIG_SCSI_IPR=y
 CONFIG_SCSI_IPR_TRACE=y
 CONFIG_SCSI_IPR_DUMP=y
+CONFIG_SCSI_IPR_EEH_RECOVERY=y
 # CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 CONFIG_SCSI_QLA2XXX=y

--FL5UXtIhxfXey3p5--
