Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVF2BAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVF2BAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVF2A74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:59:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3982 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262333AbVF1X7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:59:35 -0400
Date: Tue, 28 Jun 2005 18:59:19 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 7/13]: PCI Err: Symbios SCSI  driver recovery
Message-ID: <20050628235919.GA6415@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-7-symbios.patch

Adds PCI Error recoervy callbacks to the Symbios Sym53c8xx driver.
Tested, seems to work well under i/o stress to one disk. Not
stress tested under heavy i/o to multiple scsi devices.

Note the check of the pci error state flag inside an infinite
loop inside the interrupt handler. Without this check, the 
device can spin forever, locking up hard, long before the 
asynchronous error event (and callbacks) are ever called. 

Signed-off-by: Linas Vepstas <linas@linas.org>

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-7-symbios.patch"

--- linux-2.6.12-git10/drivers/scsi/sym53c8xx_2/sym_glue.c.linas-orig	2005-06-22 15:26:17.000000000 -0500
+++ linux-2.6.12-git10/drivers/scsi/sym53c8xx_2/sym_glue.c	2005-06-22 17:17:00.000000000 -0500
@@ -685,6 +685,10 @@ static irqreturn_t sym53c8xx_intr(int ir
 	struct sym_hcb *np = (struct sym_hcb *)dev_id;
 
 	if (DEBUG_FLAGS & DEBUG_TINY) printf_debug ("[");
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+	if (np->s.io_state != pci_channel_io_normal)
+		return IRQ_HANDLED;
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
 
 	spin_lock_irqsave(np->s.host->host_lock, flags);
 	sym_interrupt(np);
@@ -759,6 +763,27 @@ static void sym_eh_done(struct scsi_cmnd
  */
 static void sym_eh_timeout(u_long p) { __sym_eh_done((struct scsi_cmnd *)p, 1); }
 
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
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
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+
 /*
  *  Generic method for our eh processing.
  *  The 'op' argument tells what we have to do.
@@ -799,6 +824,37 @@ prepare:
 
 	/* Try to proceed the operation we have been asked for */
 	sts = -1;
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
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
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+
 	switch(op) {
 	case SYM_EH_ABORT:
 		sts = sym_abort_scsiio(np, cmd, 1);
@@ -1584,6 +1640,10 @@ static struct Scsi_Host * __devinit sym_
 	np->maxoffs	= dev->chip.offset_max;
 	np->maxburst	= dev->chip.burst_max;
 	np->myaddr	= dev->host_id;
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+	np->s.io_state = pci_channel_io_normal;
+	np->s.io_reset_wait = NULL;
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
 
 	/*
 	 *  Edit its name.
@@ -1916,6 +1976,59 @@ static int sym_detach(struct sym_hcb *np
 	return 1;
 }
 
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
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
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
+
 /*
  * Driver host template.
  */
@@ -2174,6 +2287,13 @@ static struct pci_driver sym2_driver = {
 	.id_table	= sym2_id_table,
 	.probe		= sym2_probe,
 	.remove		= __devexit_p(sym2_remove),
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+	.err_handler = {
+		.error_detected = sym2_io_error_detected,
+		.slot_reset = sym2_io_slot_reset,
+		.resume = sym2_io_resume,
+	},
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
 };
 
 static int __init sym2_init(void)
--- linux-2.6.12-git10/drivers/scsi/sym53c8xx_2/sym_glue.h.linas-orig	2005-06-22 15:26:17.000000000 -0500
+++ linux-2.6.12-git10/drivers/scsi/sym53c8xx_2/sym_glue.h	2005-06-22 15:28:29.000000000 -0500
@@ -181,6 +181,10 @@ struct sym_shcb {
 	char		chip_name[8];
 	struct pci_dev	*device;
 
+	/* pci bus i/o state; waiter for clearing of i/o state */
+	enum pci_channel_state io_state;
+	struct sym_eh_wait *io_reset_wait;
+
 	struct Scsi_Host *host;
 
 	void __iomem *	ioaddr;		/* MMIO kernel io address	*/
--- linux-2.6.12-git10/drivers/scsi/sym53c8xx_2/sym_hipd.c.linas-orig	2005-06-22 15:26:17.000000000 -0500
+++ linux-2.6.12-git10/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-06-22 15:28:29.000000000 -0500
@@ -2806,6 +2806,7 @@ void sym_interrupt (struct sym_hcb *np)
 	u_char	istat, istatc;
 	u_char	dstat;
 	u_short	sist;
+	u_int    icnt;
 
 	/*
 	 *  interrupt on the fly ?
@@ -2847,6 +2848,7 @@ void sym_interrupt (struct sym_hcb *np)
 	sist	= 0;
 	dstat	= 0;
 	istatc	= istat;
+	icnt = 0;
 	do {
 		if (istatc & SIP)
 			sist  |= INW(np, nc_sist);
@@ -2854,6 +2856,14 @@ void sym_interrupt (struct sym_hcb *np)
 			dstat |= INB(np, nc_dstat);
 		istatc = INB(np, nc_istat);
 		istat |= istatc;
+#ifdef CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY
+		/* Prevent deadlock waiting on a condition that may never clear. */
+		icnt ++;
+		if (100 < icnt) {
+			if (np->s.device->driver->err_handler.error_state != pci_channel_io_normal)
+				return;
+		}
+#endif /* CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY */
 	} while (istatc & (SIP|DIP));
 
 	if (DEBUG_FLAGS & DEBUG_TINY)
--- linux-2.6.12-git10/drivers/scsi/Kconfig.linas-orig	2005-06-22 15:26:14.000000000 -0500
+++ linux-2.6.12-git10/drivers/scsi/Kconfig	2005-06-22 15:28:29.000000000 -0500
@@ -1040,6 +1040,14 @@ config SCSI_SYM53C8XX_IOMAPPED
 	  the card.  This is significantly slower then using memory
 	  mapped IO.  Most people should answer N.
 
+config SCSI_SYM53C8XX_EEH_RECOVERY
+	bool "Enable PCI bus error recovery"
+	depends on SCSI_SYM53C8XX_2 && PPC_PSERIES
+	help
+		If you say Y here, the driver will be able to recover from
+		PCI bus errors on many PowerPC platforms. IBM pSeries users
+		should answer Y.
+
 config SCSI_IPR
 	tristate "IBM Power Linux RAID adapter support"
 	depends on PCI && SCSI
--- linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/arch/ppc64/configs/pSeries_defconfig	2005-06-22 15:30:33.000000000 -0500
@@ -311,6 +311,7 @@ CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MOD
 CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
 CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
 # CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
+CONFIG_SCSI_SYM53C8XX_EEH_RECOVERY=y
 CONFIG_SCSI_IPR=y
 CONFIG_SCSI_IPR_TRACE=y
 CONFIG_SCSI_IPR_DUMP=y

--cWoXeonUoKmBZSoM--
