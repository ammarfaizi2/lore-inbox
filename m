Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265370AbUGDDDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUGDDDw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 23:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUGDDDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 23:03:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63909 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265356AbUGDDC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 23:02:57 -0400
Message-ID: <40E77352.5090703@pobox.com>
Date: Sat, 03 Jul 2004 23:02:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       cova@ferrara.linux.it, Erik Andersen <andersen@codepoet.org>
Subject: [PATCH,RFT] SATA interrupt handling
Content-Type: multipart/mixed;
 boundary="------------090502010000070802030302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502010000070802030302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Attached is the latest SATA patch (and BK info).

When I turned on the PATA support in libata to do some ATAPI development 
on my ICH5, I reproduced the behavior that Fabio Coatti was seeing on 
his box.  This patch fixed my PATA interface, here's hoping it fixes 
Fabio's problem as well.

Tech info for Bart:  The ATA_DMA_INTR bit in ATA_DMA_STATUS is 
apparently set whenever the INTRQ line (emulated under SATA) indicates 
an interrupt...  even for non-DMA commands.  I did not expect this, at 
least :)

Judging from some of the ICH-related bug reports, I'm willing to bet 
that the IDE driver needs to do what libata is now going, WRT interrupt 
acknowledgement.  Also...  for the case in combined mode, where IDE 
driver and libata driver share the hardware, the IDE driver needs to 
talk to the BMDMA registers that it is not allowed to access.

IMO once ATAPI is working (very soon), the easiest thing to do would be 
to let libata handle PATA for the combined mode case.  This would 
eliminate all the nasty ____request_resource stuff (which Marcelo 
rightly objected to), and should allow for a clean fix to this 
sharing-hardware problem.

In theory, it is always an ugly situation when two drivers talk to a 
single PCI device simultaneously...

	Jeff




--------------090502010000070802030302
Content-Type: text/plain;
 name="linus.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linus.txt"

BK users, do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ata_piix.c     |    6 ++++++
 drivers/scsi/libata-core.c  |   43 ++++++++++++++++++++++---------------------
 drivers/scsi/libata-scsi.c  |   20 ++++++++++++++++++++
 drivers/scsi/sata_nv.c      |    2 ++
 drivers/scsi/sata_promise.c |   11 +++++++++++
 drivers/scsi/sata_sil.c     |    3 +++
 drivers/scsi/sata_sis.c     |    2 ++
 drivers/scsi/sata_svw.c     |    2 ++
 drivers/scsi/sata_sx4.c     |   13 +++++++++++++
 drivers/scsi/sata_via.c     |    3 +++
 drivers/scsi/sata_vsc.c     |    2 ++
 include/linux/ata.h         |   10 +++++++++-
 include/linux/libata.h      |   18 +++++++++++++++---
 13 files changed, 110 insertions(+), 25 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/07/03 1.1789)
   [ata] add ata_ok() inlined helper, and ATA_{DRDY,DF} bit to linux/ata.h

<jgarzik@pobox.com> (04/07/03 1.1788)
   [libata] create, and use, ->irq_clear hook
   
   This is more conservative in general, and so applies to multiple
   controllers.  Specifically it attempts to address irq-related issues
   on the Intel ICH5/6 hardware.  On Intel ICH5/6, the BMDMA 'interrupt'
   status bit will be set even on non-DMA commands, which software
   (and I) did not expect.
   
   This change clears pending interrupts once upon initialization,
   and then each time ata_irq_on() is called.

<jfbeam@bluetronic.net> (04/07/03 1.1787)
   [libata sata_sil] add drive to mod15write quirk list

<jgarzik@pobox.com> (04/07/03 1.1786)
   [libata] add ata_queued_cmd completion hook

<jgarzik@pobox.com> (04/07/03 1.1785)
   [libata] add ->qc_issue hook
   
   This hook is used when an ATA controller wishes to use
   hardware-specific methods of taskfile delivery, rather
   than the standard method of bitbanging the ATA shadow
   registers.

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-07-03 22:51:36 -04:00
@@ -138,9 +138,12 @@
 	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -161,9 +164,12 @@
 	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/libata-core.c	2004-07-03 22:51:36 -04:00
@@ -55,7 +55,6 @@
 static void ata_dev_set_pio(struct ata_port *ap, unsigned int device);
 static void ata_dev_set_udma(struct ata_port *ap, unsigned int device);
 static void ata_set_mode(struct ata_port *ap);
-static int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -2294,8 +2293,8 @@
 void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	struct ata_port *ap = qc->ap;
-	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int tag, do_clear = 0;
+	int rc;
 
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
@@ -2303,18 +2302,14 @@
 	if (likely(qc->flags & ATA_QCFLAG_SG))
 		ata_sg_clean(qc);
 
-	if (cmd) {
-		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
-			if (is_atapi_taskfile(&qc->tf))
-				cmd->result = SAM_STAT_CHECK_CONDITION;
-			else
-				ata_to_sense_error(qc);
-		} else {
-			cmd->result = SAM_STAT_GOOD;
-		}
+	/* call completion callback */
+	rc = qc->complete_fn(qc, drv_stat);
 
-		qc->scsidone(cmd);
-	}
+	/* if callback indicates not to complete command (non-zero),
+	 * return immediately
+	 */
+	if (rc != 0)
+		return;
 
 	qc->flags = 0;
 	tag = qc->tag;
@@ -2369,7 +2364,7 @@
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
-	return ata_qc_issue_prot(qc);
+	return ap->ops->qc_issue(qc);
 
 err_out:
 	return -1;
@@ -2391,7 +2386,7 @@
  *	Zero on success, negative on error.
  */
 
-static int ata_qc_issue_prot(struct ata_queued_cmd *qc)
+int ata_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
@@ -2542,6 +2537,11 @@
 	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
 
+void ata_bmdma_irq_clear(struct ata_port *ap)
+{
+	ata_bmdma_ack_irq(ap);
+}
+
 /**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
@@ -2884,6 +2884,7 @@
 	host_set->irq = ent->irq;
 	host_set->mmio_base = ent->mmio_base;
 	host_set->private_data = ent->private_data;
+	host_set->ops = ent->port_ops;
 
 	/* register each port bound to this device */
 	for (i = 0; i < ent->n_ports; i++) {
@@ -2906,6 +2907,8 @@
 	       		ap->ioaddr.bmdma_addr,
 	       		ent->irq);
 
+		ata_chk_status(ap);
+		host_set->ops->irq_clear(ap);
 		count++;
 	}
 
@@ -2914,10 +2917,6 @@
 		return 0;
 	}
 
-	/* TODO: ack irq here, to ensure it won't scream
-	 * when we enable it?
-	 */
-
 	/* obtain irq, that is shared between channels */
 	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
 			DRV_NAME, host_set))
@@ -3243,8 +3242,8 @@
 	free_irq(host_set->irq, host_set);
 	if (host_set->mmio_base)
 		iounmap(host_set->mmio_base);
-	if (host_set->ports[0]->ops->host_stop)
-		host_set->ports[0]->ops->host_stop(host_set);
+	if (host_set->ops->host_stop)
+		host_set->ops->host_stop(host_set);
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
@@ -3348,6 +3347,7 @@
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
+EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_tf_load_pio);
 EXPORT_SYMBOL_GPL(ata_tf_load_mmio);
@@ -3367,6 +3367,7 @@
 EXPORT_SYMBOL_GPL(ata_bmdma_start_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup_mmio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_mmio);
+EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-07-03 22:51:36 -04:00
@@ -335,6 +335,24 @@
 	return 1;
 }
 
+static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+
+	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
+		if (is_atapi_taskfile(&qc->tf))
+			cmd->result = SAM_STAT_CHECK_CONDITION;
+		else
+			ata_to_sense_error(qc);
+	} else {
+		cmd->result = SAM_STAT_GOOD;
+	}
+
+	qc->scsidone(cmd);
+
+	return 0;
+}
+
 /**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@ap: ATA port to which the command is addressed
@@ -378,6 +396,8 @@
 
 		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
 	}
+
+	qc->complete_fn = ata_scsi_qc_complete;
 
 	if (xlat_func(qc, scsicmd))
 		goto err_out;
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-07-03 22:51:36 -04:00
@@ -139,8 +139,10 @@
 	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= nv_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-07-03 22:51:36 -04:00
@@ -86,6 +86,7 @@
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static inline void pdc_dma_complete (struct ata_port *ap,
                                      struct ata_queued_cmd *qc, int have_err);
+static void pdc_irq_clear(struct ata_port *ap);
 
 static Scsi_Host_Template pdc_sata_sht = {
 	.module			= THIS_MODULE,
@@ -115,8 +116,10 @@
 	.bmdma_setup            = pdc_dma_setup,
 	.bmdma_start            = pdc_dma_start,
 	.qc_prep		= pdc_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc_interrupt,
+	.irq_clear		= pdc_irq_clear,
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
@@ -376,6 +379,14 @@
         }
 
         return handled;
+}
+
+static void pdc_irq_clear(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	void *mmio = host_set->mmio_base;
+
+	readl(mmio + PDC_INT_SEQMASK);
 }
 
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-07-03 22:51:36 -04:00
@@ -86,6 +86,7 @@
 	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
@@ -132,8 +133,10 @@
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-07-03 22:51:36 -04:00
@@ -101,8 +101,10 @@
 	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sis_scr_read,
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-07-03 22:51:36 -04:00
@@ -234,8 +234,10 @@
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= k2_sata_scr_read,
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-07-03 22:51:36 -04:00
@@ -171,6 +171,7 @@
 #endif
 static void pdc20621_put_to_dimm(struct ata_probe_ent *pe, 
 				 void *psource, u32 offset, u32 size);
+static void pdc20621_irq_clear(struct ata_port *ap);
 
 
 static Scsi_Host_Template pdc_sata_sht = {
@@ -201,8 +202,10 @@
 	.bmdma_setup            = pdc20621_dma_setup,
 	.bmdma_start            = pdc20621_dma_start,
 	.qc_prep		= pdc20621_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc20621_interrupt,
+	.irq_clear		= pdc20621_irq_clear,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
 	.host_stop		= pdc20621_host_stop,
@@ -700,6 +703,16 @@
 	}
 
 	return handled;
+}
+
+static void pdc20621_irq_clear(struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	void *mmio = host_set->mmio_base;
+
+	mmio += PDC_CHIP0_OFS;
+
+	readl(mmio + PDC_20621_SEQMASK);
 }
 
 static irqreturn_t pdc20621_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/sata_via.c	2004-07-03 22:51:36 -04:00
@@ -109,9 +109,12 @@
 	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-07-03 22:51:36 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-07-03 22:51:36 -04:00
@@ -216,8 +216,10 @@
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= vsc_sata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-07-03 22:51:36 -04:00
+++ b/include/linux/ata.h	2004-07-03 22:51:36 -04:00
@@ -78,9 +78,11 @@
 	ATA_NIEN		= (1 << 1),	/* disable-irq flag */
 	ATA_LBA			= (1 << 6),	/* LBA28 selector */
 	ATA_DEV1		= (1 << 4),	/* Select Device 1 (slave) */
-	ATA_BUSY		= (1 << 7),	/* BSY status bit */
 	ATA_DEVICE_OBS		= (1 << 7) | (1 << 5), /* obs bits in dev reg */
 	ATA_DEVCTL_OBS		= (1 << 3),	/* obsolete bit in devctl reg */
+	ATA_BUSY		= (1 << 7),	/* BSY status bit */
+	ATA_DRDY		= (1 << 6),	/* device ready */
+	ATA_DF			= (1 << 5),	/* device fault */
 	ATA_DRQ			= (1 << 3),	/* data request i/o */
 	ATA_ERR			= (1 << 0),	/* have an error */
 	ATA_SRST		= (1 << 2),	/* software reset */
@@ -222,6 +224,12 @@
 {
 	return (tf->protocol == ATA_PROT_ATAPI) ||
 	       (tf->protocol == ATA_PROT_ATAPI_DMA);
+}
+
+static inline int ata_ok(u8 status)
+{
+	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
+			== ATA_DRDY);
 }
 
 #endif /* __LINUX_ATA_H__ */
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-07-03 22:51:36 -04:00
+++ b/include/linux/libata.h	2004-07-03 22:51:36 -04:00
@@ -158,7 +158,7 @@
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc, unsigned int flags);
+typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, u8 drv_stat);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -202,6 +202,7 @@
 	void			*mmio_base;
 	unsigned int		n_ports;
 	void			*private_data;
+	struct ata_port_operations *ops;
 	struct ata_port *	ports[0];
 };
 
@@ -224,7 +225,7 @@
 
 	struct scatterlist	*sg;
 
-	ata_qc_cb_t		callback;
+	ata_qc_cb_t		complete_fn;
 
 	struct completion	*waiting;
 
@@ -311,10 +312,14 @@
 
 	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
+
 	void (*qc_prep) (struct ata_queued_cmd *qc);
+	int (*qc_issue) (struct ata_queued_cmd *qc);
+
 	void (*eng_timeout) (struct ata_port *ap);
 
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
+	void (*irq_clear) (struct ata_port *);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
@@ -372,12 +377,14 @@
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
+extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
 extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_setup_pio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_pio (struct ata_queued_cmd *qc);
+extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
 extern void ata_eng_timeout(struct ata_port *ap);
@@ -480,6 +487,7 @@
 static inline u8 ata_irq_on(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 tmp;
 
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
@@ -488,7 +496,11 @@
 		writeb(ap->ctl, ioaddr->ctl_addr);
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
-	return ata_wait_idle(ap);
+	tmp = ata_wait_idle(ap);
+
+	ap->ops->irq_clear(ap);
+
+	return tmp;
 }
 
 static inline u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq)

--------------090502010000070802030302--
