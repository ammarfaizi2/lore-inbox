Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992554AbWJTSFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992554AbWJTSFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992560AbWJTSFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:05:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:1944 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S2992554AbWJTSFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:05:12 -0400
Date: Fri, 20 Oct 2006 13:05:10 -0500
To: matthew@wil.cx
Cc: linux-scsi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20061020180510.GN6537@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew, 

Please apply and forward upstream. This patch is nearly identical
to the one from a month earlier, except that it fixes some 
indentation problems, and shortens a few over-length lines.
This patch has been in an -mm tree since 29 Sept, and a variant
of it has been shipping for over a year in Novell SLES9, where
it has not received any complaints/defects/fixes/etc.

You had previously mentioned some objections to this patch, 
I assume these were about the bad indentation? Are there other 
concerns?

--linas


Various PCI bus errors can be signaled by newer PCI controllers.  
This patch adds the PCI error recovery callbacks to the Symbios 
SCSI device driver.  The patch has been tested, and appears to 
work well.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
 drivers/scsi/sym53c8xx_2/sym_glue.c |   99 ++++++++++++++++++++++++++++++++++++
 drivers/scsi/sym53c8xx_2/sym_glue.h |    4 +
 drivers/scsi/sym53c8xx_2/sym_hipd.c |   10 +++
 3 files changed, 113 insertions(+)

Index: linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_glue.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-10-20 12:25:11.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-10-20 12:41:15.000000000 -0500
@@ -659,6 +659,11 @@ static irqreturn_t sym53c8xx_intr(int ir
 
 	if (DEBUG_FLAGS & DEBUG_TINY) printf_debug ("[");
 
+	/* Avoid spinloop trying to handle interrupts on frozen device */
+	if ((np->s.device->error_state != pci_channel_io_normal) &&
+	    (np->s.device->error_state != 0))
+		return IRQ_HANDLED;
+
 	spin_lock_irqsave(np->s.host->host_lock, flags);
 	sym_interrupt(np);
 	spin_unlock_irqrestore(np->s.host->host_lock, flags);
@@ -726,6 +731,19 @@ static int sym_eh_handler(int op, char *
 
 	dev_warn(&cmd->device->sdev_gendev, "%s operation started.\n", opname);
 
+	/* We may be in an error condition because the PCI bus
+	 * went down. In this case, we need to wait until the
+	 * PCI bus is reset, the card is reset, and only then
+	 * proceed with the scsi error recovery.  There's no
+	 * point in hurrying; take a leisurely wait.
+	 */
+#define WAIT_FOR_PCI_RECOVERY	35
+	if ((np->s.device->error_state != pci_channel_io_normal) &&
+	    (np->s.device->error_state != 0) &&
+	    (wait_for_completion_timeout(&np->s.io_reset_wait,
+		                         WAIT_FOR_PCI_RECOVERY*HZ) == 0))
+			return SCSI_FAILED;
+
 	spin_lock_irq(host->host_lock);
 	/* This one is queued in some place -> to wait for completion */
 	FOR_EACH_QUEUED_ELEMENT(&np->busy_ccbq, qp) {
@@ -1510,6 +1528,7 @@ static struct Scsi_Host * __devinit sym_
 	np->maxoffs	= dev->chip.offset_max;
 	np->maxburst	= dev->chip.burst_max;
 	np->myaddr	= dev->host_id;
+	init_completion(&np->s.io_reset_wait);
 
 	/*
 	 *  Edit its name.
@@ -1948,6 +1967,79 @@ static void __devexit sym2_remove(struct
 	attach_count--;
 }
 
+/**
+ * sym2_io_error_detected() -- called when PCI error is detected
+ * @pdev: pointer to PCI device
+ * @state: current state of the PCI slot
+ */
+static pci_ers_result_t sym2_io_error_detected (struct pci_dev *pdev,
+                                         enum pci_channel_state state)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+
+	/* If slot is permanently frozen, turn everything off */
+	if (state == pci_channel_io_perm_failure) {
+		sym2_remove(pdev);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	init_completion(&np->s.io_reset_wait);
+	disable_irq(pdev->irq);
+	pci_disable_device(pdev);
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * sym2_io_slot_reset() -- called when the pci bus has been reset.
+ * @pdev: pointer to PCI device
+ *
+ * Restart the card from scratch.
+ */
+static pci_ers_result_t sym2_io_slot_reset (struct pci_dev *pdev)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+
+	printk(KERN_INFO "%s: recovering from a PCI slot reset\n",
+	          sym_name(np));
+
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "%s: Unable to enable afer PCI reset\n",
+		        sym_name(np));
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_set_master(pdev);
+	enable_irq(pdev->irq);
+
+	/* Perform host reset only on one instance of the card */
+	if (PCI_FUNC (pdev->devfn) == 0) {
+		if (sym_reset_scsi_bus(np, 0)) {
+			printk(KERN_ERR "%s: Unable to reset scsi host\n",
+			        sym_name(np));
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
+		sym_start_up(np, 1);
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * sym2_io_resume() -- resume normal ops after PCI reset
+ * @pdev: pointer to PCI device
+ *
+ * Called when the error recovery driver tells us that its
+ * OK to resume normal operation. Use completion to allow
+ * halted scsi ops to resume.
+ */
+static void sym2_io_resume (struct pci_dev *pdev)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+	complete_all(&np->s.io_reset_wait);
+}
+
 static void sym2_get_signalling(struct Scsi_Host *shost)
 {
 	struct sym_hcb *np = sym_get_hcb(shost);
@@ -2110,11 +2202,18 @@ static struct pci_device_id sym2_id_tabl
 
 MODULE_DEVICE_TABLE(pci, sym2_id_table);
 
+static struct pci_error_handlers sym2_err_handler = {
+	.error_detected = sym2_io_error_detected,
+	.slot_reset = sym2_io_slot_reset,
+	.resume = sym2_io_resume,
+};
+
 static struct pci_driver sym2_driver = {
 	.name		= NAME53C8XX,
 	.id_table	= sym2_id_table,
 	.probe		= sym2_probe,
 	.remove		= __devexit_p(sym2_remove),
+	.err_handler 	= &sym2_err_handler,
 };
 
 static int __init sym2_init(void)
Index: linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_glue.h
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/scsi/sym53c8xx_2/sym_glue.h	2006-10-20 12:25:11.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_glue.h	2006-10-20 12:41:16.000000000 -0500
@@ -40,6 +40,7 @@
 #ifndef SYM_GLUE_H
 #define SYM_GLUE_H
 
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
@@ -179,6 +180,9 @@ struct sym_shcb {
 	char		chip_name[8];
 	struct pci_dev	*device;
 
+	/* Waiter for clearing of frozen PCI bus */
+	struct completion io_reset_wait;
+
 	struct Scsi_Host *host;
 
 	void __iomem *	ioaddr;		/* MMIO kernel io address	*/
Index: linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_hipd.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/drivers/scsi/sym53c8xx_2/sym_hipd.c	2006-10-20 12:25:11.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_hipd.c	2006-10-20 12:41:16.000000000 -0500
@@ -2761,6 +2761,7 @@ void sym_interrupt (struct sym_hcb *np)
 	u_char	istat, istatc;
 	u_char	dstat;
 	u_short	sist;
+	u_int    icnt;
 
 	/*
 	 *  interrupt on the fly ?
@@ -2802,6 +2803,7 @@ void sym_interrupt (struct sym_hcb *np)
 	sist	= 0;
 	dstat	= 0;
 	istatc	= istat;
+	icnt = 0;
 	do {
 		if (istatc & SIP)
 			sist  |= INW(np, nc_sist);
@@ -2809,6 +2811,14 @@ void sym_interrupt (struct sym_hcb *np)
 			dstat |= INB(np, nc_dstat);
 		istatc = INB(np, nc_istat);
 		istat |= istatc;
+
+		/* Prevent deadlock waiting on a condition that may never clear. */
+		icnt ++;
+		if (icnt > 100) {
+			if ((np->s.device->error_state != pci_channel_io_normal)
+			   && (np->s.device->error_state != 0))
+				return;
+		}
 	} while (istatc & (SIP|DIP));
 
 	if (DEBUG_FLAGS & DEBUG_TINY)
