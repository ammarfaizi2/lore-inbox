Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbVKDBBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbVKDBBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbVKDAxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:53:50 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:15252
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1030583AbVKDAxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:53:46 -0500
Date: Thu, 3 Nov 2005 18:53:46 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 28/42]: SCSI: add PCI error recovery to Symbios dev driver
Message-ID: <20051104005346.GA27066@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various PCI bus errors can be signaled by newer PCI controllers.  This
patch adds the PCI error recovery callbacks to the Symbios SCSI device driver.
The patch has been tested, and appears to work well.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
Index: linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_glue.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-11-02 14:28:52.512031337 -0600
+++ linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-11-02 14:43:56.084343457 -0600
@@ -686,6 +686,10 @@
 
 	if (DEBUG_FLAGS & DEBUG_TINY) printf_debug ("[");
 
+	/* Avoid spinloop trying to handle interrupts on frozen device */
+	if (np->s.io_state != pci_channel_io_normal)
+		return IRQ_HANDLED;
+
 	spin_lock_irqsave(np->s.host->host_lock, flags);
 	sym_interrupt(np);
 	spin_unlock_irqrestore(np->s.host->host_lock, flags);
@@ -759,6 +763,25 @@
  */
 static void sym_eh_timeout(u_long p) { __sym_eh_done((struct scsi_cmnd *)p, 1); }
 
+static void sym_eeh_timeout(u_long p)
+{
+	struct sym_eh_wait *ep = (struct sym_eh_wait *) p;
+	if (!ep)
+		return;
+	complete(&ep->done);
+}
+
+static void sym_eeh_done(struct sym_eh_wait *ep)
+{
+	if (!ep)
+		return;
+	ep->timed_out = 0;
+	if (!del_timer(&ep->timer))
+		return;
+
+	complete(&ep->done);
+}
+
 /*
  *  Generic method for our eh processing.
  *  The 'op' argument tells what we have to do.
@@ -799,6 +822,35 @@
 
 	/* Try to proceed the operation we have been asked for */
 	sts = -1;
+
+	/* We may be in an error condition because the PCI bus
+	 * went down. In this case, we need to wait until the
+	 * PCI bus is reset, the card is reset, and only then
+	 * proceed with the scsi error recovery.  We'll wait
+	 * for 15 seconds for this to happen.
+	 */
+#define WAIT_FOR_PCI_RECOVERY	15
+	if (np->s.io_state != pci_channel_io_normal) {
+		struct sym_eh_wait eeh, *eep = &eeh;
+		np->s.io_reset_wait = eep;
+		init_completion(&eep->done);
+		init_timer(&eep->timer);
+		eep->to_do = SYM_EH_DO_WAIT;
+		eep->timer.expires = jiffies + (WAIT_FOR_PCI_RECOVERY*HZ);
+		eep->timer.function = sym_eeh_timeout;
+		eep->timer.data = (u_long)eep;
+		eep->timed_out = 1;	/* Be pessimistic for once :) */
+		add_timer(&eep->timer);
+		spin_unlock_irq(np->s.host->host_lock);
+		wait_for_completion(&eep->done);
+		spin_lock_irq(np->s.host->host_lock);
+		if (eep->timed_out) {
+			printk (KERN_ERR "%s: Timed out waiting for PCI reset\n",
+			       sym_name(np));
+		}
+		np->s.io_reset_wait = NULL;
+	}
+
 	switch(op) {
 	case SYM_EH_ABORT:
 		sts = sym_abort_scsiio(np, cmd, 1);
@@ -1584,6 +1636,8 @@
 	np->maxoffs	= dev->chip.offset_max;
 	np->maxburst	= dev->chip.burst_max;
 	np->myaddr	= dev->host_id;
+	np->s.io_state = pci_channel_io_normal;
+	np->s.io_reset_wait = NULL;
 
 	/*
 	 *  Edit its name.
@@ -1916,6 +1970,58 @@
 	return 1;
 }
 
+/* ------------- PCI Error Recovery infrastructure -------------- */
+/** sym2_io_error_detected() is called when PCI error is detected */
+static int sym2_io_error_detected (struct pci_dev *pdev, enum pci_channel_state state)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+
+	np->s.io_state = state;
+	// XXX If slot is permanently frozen, then what?
+	// Should we scsi_remove_host() maybe ??
+
+	/* Request a slot slot reset. */
+	return PCIERR_RESULT_NEED_RESET;
+}
+
+/** sym2_io_slot_reset is called when the pci bus has been reset.
+ *  Restart the card from scratch. */
+static int sym2_io_slot_reset (struct pci_dev *pdev)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+
+	printk (KERN_INFO "%s: recovering from a PCI slot reset\n",
+	    sym_name(np));
+
+	if (pci_enable_device(pdev))
+		printk (KERN_ERR "%s: device setup failed most egregiously\n",
+			    sym_name(np));
+
+	pci_set_master(pdev);
+	enable_irq (pdev->irq);
+
+	/* Perform host reset only on one instance of the card */
+	if (0 == PCI_FUNC (pdev->devfn))
+		sym_reset_scsi_bus(np, 0);
+
+	return PCIERR_RESULT_RECOVERED;
+}
+
+/** sym2_io_resume is called when the error recovery driver
+ *  tells us that its OK to resume normal operation.
+ */
+static void sym2_io_resume (struct pci_dev *pdev)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+
+	/* Perform device startup only once for this card. */
+	if (0 == PCI_FUNC (pdev->devfn))
+		sym_start_up (np, 1);
+
+	np->s.io_state = pci_channel_io_normal;
+	sym_eeh_done (np->s.io_reset_wait);
+}
+
 /*
  * Driver host template.
  */
@@ -2169,11 +2275,18 @@
 
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
+	.err_handler = &sym2_err_handler,
 };
 
 static int __init sym2_init(void)
Index: linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_glue.h
===================================================================
--- linux-2.6.14-git3.orig/drivers/scsi/sym53c8xx_2/sym_glue.h	2005-11-02 14:28:52.513031197 -0600
+++ linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_glue.h	2005-11-02 14:43:56.089342756 -0600
@@ -181,6 +181,10 @@
 	char		chip_name[8];
 	struct pci_dev	*device;
 
+	/* pci bus i/o state; waiter for clearing of i/o state */
+	enum pci_channel_state io_state;
+	struct sym_eh_wait *io_reset_wait;
+
 	struct Scsi_Host *host;
 
 	void __iomem *	ioaddr;		/* MMIO kernel io address	*/
Index: linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_hipd.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-11-02 14:28:52.513031197 -0600
+++ linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-11-02 14:43:56.141335464 -0600
@@ -2809,6 +2809,7 @@
 	u_char	istat, istatc;
 	u_char	dstat;
 	u_short	sist;
+	u_int    icnt;
 
 	/*
 	 *  interrupt on the fly ?
@@ -2850,6 +2851,7 @@
 	sist	= 0;
 	dstat	= 0;
 	istatc	= istat;
+	icnt = 0;
 	do {
 		if (istatc & SIP)
 			sist  |= INW(np, nc_sist);
@@ -2857,6 +2859,19 @@
 			dstat |= INB(np, nc_dstat);
 		istatc = INB(np, nc_istat);
 		istat |= istatc;
+		
+		/* Prevent deadlock waiting on a condition that may never clear. */
+		/* XXX this is a temporary kludge; the correct to detect
+		 * a PCI bus error would be to use the io_check interfaces
+		 * proposed by Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+		 * Problem with polling like that is the state flag might not
+		 * be set.
+		 */
+		icnt ++;
+		if (100 < icnt) {
+			if (np->s.device->error_state != pci_channel_io_normal)
+				return;
+		}
 	} while (istatc & (SIP|DIP));
 
 	if (DEBUG_FLAGS & DEBUG_TINY)
