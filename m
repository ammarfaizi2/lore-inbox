Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbVKDAyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbVKDAyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbVKDAxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:53:52 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:13716
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1030582AbVKDAxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:53:37 -0500
Date: Thu, 3 Nov 2005 18:53:36 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 27/42]: SCSI: add PCI error recovery to IPR dev driver
Message-ID: <20051104005336.GA27057@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

27-pci-error-recovery_IPR-driver.patch

Subject: PCI Error Recovery:  IPR SCSI device driver

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the IPR SCSI device driver.
The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Brian King <brking@us.ibm.com>

--
Index: linux-2.6.14-git3/drivers/scsi/ipr.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/scsi/ipr.c	2005-11-02 14:28:53.284922999 -0600
+++ linux-2.6.14-git3/drivers/scsi/ipr.c	2005-11-02 14:43:52.782806465 -0600
@@ -5328,6 +5328,94 @@
 				shutdown_type);
 }
 
+/* --------------- PCI Error Recovery infrastructure ----------- */
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
+
+/* ------------- end of PCI Error Recovery suport ----------- */
+
 /**
  * ipr_probe_ioa_part2 - Initializes IOAs found in ipr_probe_ioa(..)
  * @ioa_cfg:	ioa cfg struct
@@ -6065,12 +6153,18 @@
 };
 MODULE_DEVICE_TABLE(pci, ipr_pci_table);
 
+static struct pci_error_handlers ipr_err_handler = {
+	.error_detected = ipr_eeh_error_detected,
+	.slot_reset = ipr_eeh_slot_reset,
+};
+
 static struct pci_driver ipr_driver = {
 	.name = IPR_NAME,
 	.id_table = ipr_pci_table,
 	.probe = ipr_probe,
 	.remove = ipr_remove,
 	.shutdown = ipr_shutdown,
+	.err_handler = &ipr_err_handler,
 };
 
 /**
