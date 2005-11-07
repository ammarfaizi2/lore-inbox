Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVKGVaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVKGVaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVKGVaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:30:09 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45709 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965143AbVKGVaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:30:06 -0500
Date: Mon, 7 Nov 2005 15:30:03 -0600
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Brian King <brking@us.ibm.com>
Subject: [PATCH 2/7]: Revised [PATCH 27/42]: SCSI: add PCI error recovery to IPR dev driver
Message-ID: <20051107213003.GI19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107195727.GF19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107195727.GF19593@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:57:27PM -0600, linas was heard to remark:
> On Mon, Nov 07, 2005 at 10:27:27AM -0800, Greg KH was heard to remark:
> > 3) realy strong typing that sparse can detect.

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the IPR SCSI device driver.
The patch has been tested, and appears to work well.

Please apply.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Brian King <brking@us.ibm.com>

--
Index: linux-2.6.14-mm1/drivers/scsi/ipr.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/scsi/ipr.c	2005-11-07 13:55:27.986920072 -0600
+++ linux-2.6.14-mm1/drivers/scsi/ipr.c	2005-11-07 15:02:00.639392946 -0600
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
+static pers_result_t ipr_eeh_slot_reset(struct pci_dev *pdev)
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
+	return PERS_RESULT_RECOVERED;
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
+static pers_result_t ipr_eeh_error_detected(struct pci_dev *pdev,
+                                pci_channel_state_t state)
+{
+	switch (state) {
+		case pci_channel_io_frozen:
+			ipr_eeh_frozen (pdev);
+			return PERS_RESULT_NEED_RESET;
+
+		case pci_channel_io_perm_failure:
+			ipr_eeh_perm_failure (pdev);
+			return PERS_RESULT_DISCONNECT;
+			break;
+		default:
+			break;
+	}
+	return PERS_RESULT_NEED_RESET;
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
