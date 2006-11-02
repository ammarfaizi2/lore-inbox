Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945936AbWKBBTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945936AbWKBBTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 20:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423120AbWKBBTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 20:19:44 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:480 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423105AbWKBBTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 20:19:43 -0500
Date: Wed, 1 Nov 2006 19:19:37 -0600
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-scsi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [PATCH v4]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20061102011935.GZ6360@austin.ibm.com>
References: <20061020180510.GN6537@austin.ibm.com> <20061031185506.GE26964@parisc-linux.org> <20061031231334.GR6360@austin.ibm.com> <20061102000745.GX6360@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102000745.GX6360@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 06:07:46PM -0600, Linas Vepstas wrote:
[...]


Matthew,

You seem to always see me at my dullest. Here's another attempt.

This patch depends on 
   [PATCH 1/2 v2]: Renumber PCI error enums to start at zero
 
which I just mailed out to GregKH, to add a small 
pci_channel_offline() utility.

--linas


Various PCI bus errors can be signaled by newer PCI controllers.  
This patch adds the PCI error recovery callbacks to the Symbios 
SCSI device driver.  The patch has been tested, and appears to 
work well.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
 drivers/scsi/sym53c8xx_2/sym_glue.c |  100 ++++++++++++++++++++++++++++++++++++
 drivers/scsi/sym53c8xx_2/sym_glue.h |    4 +
 drivers/scsi/sym53c8xx_2/sym_hipd.c |    6 ++
 3 files changed, 110 insertions(+)

Index: linux-2.6.19-rc4-git3/drivers/scsi/sym53c8xx_2/sym_glue.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-11-01 19:13:15.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-11-01 19:14:11.000000000 -0600
@@ -657,6 +657,10 @@ static irqreturn_t sym53c8xx_intr(int ir
 	unsigned long flags;
 	struct sym_hcb *np = (struct sym_hcb *)dev_id;
 
+	/* Avoid spinloop trying to handle interrupts on frozen device */
+	if (pci_channel_offline(np->s.device))
+		return IRQ_HANDLED;
+
 	if (DEBUG_FLAGS & DEBUG_TINY) printf_debug ("[");
 
 	spin_lock_irqsave(np->s.host->host_lock, flags);
@@ -726,6 +730,21 @@ static int sym_eh_handler(int op, char *
 
 	dev_warn(&cmd->device->sdev_gendev, "%s operation started.\n", opname);
 
+	/* We may be in an error condition because the PCI bus
+	 * went down. In this case, we need to wait until the
+	 * PCI bus is reset, the card is reset, and only then
+	 * proceed with the scsi error recovery.  There's no
+	 * point in hurrying; take a leisurely wait.
+	 */
+#define WAIT_FOR_PCI_RECOVERY	35
+	if (pci_channel_offline(np->s.device))
+	{
+		int finished_reset = wait_for_completion_timeout(
+			&np->s.io_reset_wait, WAIT_FOR_PCI_RECOVERY*HZ);
+		if (!finished_reset)
+			return SCSI_FAILED;
+	}
+
 	spin_lock_irq(host->host_lock);
 	/* This one is queued in some place -> to wait for completion */
 	FOR_EACH_QUEUED_ELEMENT(&np->busy_ccbq, qp) {
@@ -1510,6 +1529,7 @@ static struct Scsi_Host * __devinit sym_
 	np->maxoffs	= dev->chip.offset_max;
 	np->maxburst	= dev->chip.burst_max;
 	np->myaddr	= dev->host_id;
+	init_completion(&np->s.io_reset_wait);
 
 	/*
 	 *  Edit its name.
@@ -1948,6 +1968,79 @@ static void __devexit sym2_remove(struct
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
@@ -2110,11 +2203,18 @@ static struct pci_device_id sym2_id_tabl
 
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
Index: linux-2.6.19-rc4-git3/drivers/scsi/sym53c8xx_2/sym_glue.h
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/scsi/sym53c8xx_2/sym_glue.h	2006-11-01 19:13:15.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/scsi/sym53c8xx_2/sym_glue.h	2006-11-01 19:13:19.000000000 -0600
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
Index: linux-2.6.19-rc4-git3/drivers/scsi/sym53c8xx_2/sym_hipd.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/scsi/sym53c8xx_2/sym_hipd.c	2006-11-01 19:13:15.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/scsi/sym53c8xx_2/sym_hipd.c	2006-11-01 19:13:19.000000000 -0600
@@ -2809,6 +2809,12 @@ void sym_interrupt (struct sym_hcb *np)
 			dstat |= INB(np, nc_dstat);
 		istatc = INB(np, nc_istat);
 		istat |= istatc;
+
+		/* Prevent deadlock waiting on a condition that may never clear. */
+		if (unlikely(sist == 0xffff && dstat == 0xff)) {
+			if (unlikely(pci_channel_offline(np->s.device)))
+				return;
+		}
 	} while (istatc & (SIP|DIP));
 
 	if (DEBUG_FLAGS & DEBUG_TINY)
