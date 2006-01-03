Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWACQnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWACQnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWACQnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:43:22 -0500
Received: from havoc.gtf.org ([69.61.125.42]:31874 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751463AbWACQnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:43:20 -0500
Date: Tue, 3 Jan 2006 11:43:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata updates
Message-ID: <20060103164319.GA402@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 Documentation/kernel-parameters.txt |    8 
 drivers/pci/quirks.c                |   30 ++
 drivers/scsi/ahci.c                 |   14 -
 drivers/scsi/ata_piix.c             |  127 +++++++++---
 drivers/scsi/libata-core.c          |  364 ++++++++++++++++++++----------------
 drivers/scsi/libata-scsi.c          |   24 +-
 drivers/scsi/libata.h               |    1 
 drivers/scsi/pdc_adma.c             |   11 -
 drivers/scsi/sata_mv.c              |   11 -
 drivers/scsi/sata_promise.c         |   20 +
 drivers/scsi/sata_qstor.c           |    9 
 drivers/scsi/sata_sil.c             |    2 
 drivers/scsi/sata_sil24.c           |   15 -
 drivers/scsi/sata_sx4.c             |   17 +
 include/linux/libata.h              |   13 -
 15 files changed, 413 insertions(+), 253 deletions(-)

Alan Cox:
      libata: add ata_piix notes
      libata: ata_piix 450NX errata

Albert Lee:
      libata: minor patch before moving err_mask
      libata: move err_mask to ata_queued_cmd
      libata: determine the err_mask when the error is found
      libata: determine the err_mask directly in atapi_packet_task()
      libata: err_mask misc fix

Arjan van de Ven:
      mark several libata datastructures const

Jeff Garzik:
      [libata] remove two unused fields from struct ata_port
      [libata ata_piix] cleanup: remove duplicate ata_port_info records
      [libata] Print out SATA speed, if link is up
      [libata sata_promise] minor whitespace cleanup

Jesse Barnes:
      add boot option to control Intel SATA/PATA combined mode

Tejun Heo:
      libata: implement ata_exec_internal()
      libata: use ata_exec_internal()
      libata: remove unused functions
      libata: remove unused qc->waiting

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5dffcfe..61a56b1 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -633,6 +633,14 @@ running once the system is up.
 	inport.irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
 			Format: <irq>
 
+	combined_mode=	[HW] control which driver uses IDE ports in combined
+			mode: legacy IDE driver, libata, or both
+			(in the libata case, libata.atapi_enabled=1 may be
+			useful as well).  Note that using the ide or libata
+			options may affect your device naming (e.g. by
+			changing hdc to sdb).
+			Format: combined (default), ide, or libata
+
 	inttest=	[IA64]
 
 	io7=		[HW] IO7 for Marvel based alpha systems
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3a4f49f..f28ebdd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1098,6 +1098,23 @@ static void __init quirk_alder_ioapic(st
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic );
 #endif
 
+enum ide_combined_type { COMBINED = 0, IDE = 1, LIBATA = 2 };
+/* Defaults to combined */
+static enum ide_combined_type combined_mode;
+
+static int __init combined_setup(char *str)
+{
+	if (!strncmp(str, "ide", 3))
+		combined_mode = IDE;
+	else if (!strncmp(str, "libata", 6))
+		combined_mode = LIBATA;
+	else /* "combined" or anything else defaults to old behavior */
+		combined_mode = COMBINED;
+
+	return 1;
+}
+__setup("combined_mode=", combined_setup);
+
 #ifdef CONFIG_SCSI_SATA_INTEL_COMBINED
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
@@ -1164,6 +1181,19 @@ static void __devinit quirk_intel_ide_co
 	if (prog & comb)
 		return;
 
+	/* Don't reserve any so the IDE driver can get them (but only if
+	 * combined_mode=ide).
+	 */
+	if (combined_mode == IDE)
+		return;
+
+	/* Grab them both for libata if combined_mode=libata. */
+	if (combined_mode == LIBATA) {
+		request_region(0x1f0, 8, "libata");	/* port 0 */
+		request_region(0x170, 8, "libata");	/* port 1 */
+		return;
+	}
+
 	/* SATA port is in legacy mode.  Reserve port so that
 	 * IDE driver does not attempt to use it.  If request_region
 	 * fails, it will be obvious at boot time, so we don't bother
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 83467a0..887eaa2 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -243,7 +243,7 @@ static const struct ata_port_operations 
 	.port_stop		= ahci_port_stop,
 };
 
-static struct ata_port_info ahci_port_info[] = {
+static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
 		.sht		= &ahci_sht,
@@ -643,7 +643,8 @@ static void ahci_eng_timeout(struct ata_
 	 	 * not being called from the SCSI EH.
 	 	 */
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, AC_ERR_OTHER);
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
@@ -664,7 +665,8 @@ static inline int ahci_host_intr(struct 
 	ci = readl(port_mmio + PORT_CMD_ISSUE);
 	if (likely((ci & 0x1) == 0)) {
 		if (qc) {
-			ata_qc_complete(qc, 0);
+			assert(qc->err_mask == 0);
+			ata_qc_complete(qc);
 			qc = NULL;
 		}
 	}
@@ -681,8 +683,10 @@ static inline int ahci_host_intr(struct 
 		/* command processing has stopped due to error; restart */
 		ahci_restart_port(ap, status);
 
-		if (qc)
-			ata_qc_complete(qc, err_mask);
+		if (qc) {
+			qc->err_mask |= AC_ERR_OTHER;
+			ata_qc_complete(qc);
+		}
 	}
 
 	return 1;
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 333d69d..0ea2787 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -37,6 +37,49 @@
  *
  *  Hardware documentation available at http://developer.intel.com/
  *
+ * Documentation
+ *	Publically available from Intel web site. Errata documentation
+ * is also publically available. As an aide to anyone hacking on this
+ * driver the list of errata that are relevant is below.going back to
+ * PIIX4. Older device documentation is now a bit tricky to find.
+ *
+ * The chipsets all follow very much the same design. The orginal Triton
+ * series chipsets do _not_ support independant device timings, but this
+ * is fixed in Triton II. With the odd mobile exception the chips then
+ * change little except in gaining more modes until SATA arrives. This
+ * driver supports only the chips with independant timing (that is those
+ * with SITRE and the 0x44 timing register). See pata_oldpiix and pata_mpiix
+ * for the early chip drivers.
+ *
+ * Errata of note:
+ *
+ * Unfixable
+ *	PIIX4    errata #9	- Only on ultra obscure hw
+ *	ICH3	 errata #13     - Not observed to affect real hw
+ *				  by Intel
+ *
+ * Things we must deal with
+ *	PIIX4	errata #10	- BM IDE hang with non UDMA
+ *				  (must stop/start dma to recover)
+ *	440MX   errata #15	- As PIIX4 errata #10
+ *	PIIX4	errata #15	- Must not read control registers
+ * 				  during a PIO transfer
+ *	440MX   errata #13	- As PIIX4 errata #15
+ *	ICH2	errata #21	- DMA mode 0 doesn't work right
+ *	ICH0/1  errata #55	- As ICH2 errata #21
+ *	ICH2	spec c #9	- Extra operations needed to handle
+ *				  drive hotswap [NOT YET SUPPORTED]
+ *	ICH2    spec c #20	- IDE PRD must not cross a 64K boundary
+ *				  and must be dword aligned
+ *	ICH2    spec c #24	- UDMA mode 4,5 t85/86 should be 6ns not 3.3
+ *
+ * Should have been BIOS fixed:
+ *	450NX:	errata #19	- DMA hangs on old 450NX
+ *	450NX:  errata #20	- DMA hangs on old 450NX
+ *	450NX:  errata #25	- Corruption with DMA on old 450NX
+ *	ICH3    errata #15      - IDE deadlock under high load
+ *				  (BIOS must set dev 31 fn 0 bit 23)
+ *	ICH3	errata #18	- Don't use native mode
  */
 
 #include <linux/kernel.h>
@@ -78,9 +121,7 @@ enum {
 	ich5_sata		= 1,
 	piix4_pata		= 2,
 	ich6_sata		= 3,
-	ich6_sata_rm		= 4,
-	ich7_sata		= 5,
-	esb2_sata		= 6,
+	ich6_sata_ahci		= 4,
 
 	PIIX_AHCI_DEVICE	= 6,
 };
@@ -111,11 +152,11 @@ static const struct pci_device_id piix_p
 	{ 0x8086, 0x25a3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
 	{ 0x8086, 0x25b0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
 	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
-	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
-	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
-	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
-	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
-	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb2_sata },
+	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 
 	{ }	/* terminate list */
 };
@@ -258,31 +299,7 @@ static struct ata_port_info piix_port_in
 		.port_ops	= &piix_sata_ops,
 	},
 
-	/* ich6_sata_rm */
-	{
-		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
-				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
-		.port_ops	= &piix_sata_ops,
-	},
-
-	/* ich7_sata */
-	{
-		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
-				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
-		.port_ops	= &piix_sata_ops,
-	},
-
-	/* esb2_sata */
+	/* ich6_sata_ahci */
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
@@ -603,6 +620,40 @@ static int piix_disable_ahci(struct pci_
 }
 
 /**
+ *	piix_check_450nx_errata	-	Check for problem 450NX setup
+ *	
+ *	Check for the present of 450NX errata #19 and errata #25. If
+ *	they are found return an error code so we can turn off DMA
+ */
+
+static int __devinit piix_check_450nx_errata(struct pci_dev *ata_dev)
+{
+	struct pci_dev *pdev = NULL;
+	u16 cfg;
+	u8 rev;
+	int no_piix_dma = 0;
+	
+	while((pdev = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev)) != NULL)
+	{
+		/* Look for 450NX PXB. Check for problem configurations
+		   A PCI quirk checks bit 6 already */
+		pci_read_config_byte(pdev, PCI_REVISION_ID, &rev);
+		pci_read_config_word(pdev, 0x41, &cfg);
+		/* Only on the original revision: IDE DMA can hang */
+		if(rev == 0x00)
+			no_piix_dma = 1;
+		/* On all revisions below 5 PXB bus lock must be disabled for IDE */
+		else if(cfg & (1<<14) && rev < 5)
+			no_piix_dma = 2;
+	}
+	if(no_piix_dma)
+		dev_printk(KERN_WARNING, &ata_dev->dev, "450NX errata present, disabling IDE DMA.\n");
+	if(no_piix_dma == 2)
+		dev_printk(KERN_WARNING, &ata_dev->dev, "A BIOS update may resolve this.\n");
+	return no_piix_dma;
+}		
+
+/**
  *	piix_init_one - Register PIIX ATA PCI device with kernel services
  *	@pdev: PCI device to register
  *	@ent: Entry in piix_pci_tbl matching with @pdev
@@ -676,7 +727,15 @@ static int piix_init_one (struct pci_dev
 			   "combined mode detected (p=%u, s=%u)\n",
 			   pata_chan, sata_chan);
 	}
-
+	if (piix_check_450nx_errata(pdev)) {
+		/* This writes into the master table but it does not
+		   really matter for this errata as we will apply it to
+		   all the PIIX devices on the board */
+		port_info[0]->mwdma_mask = 0;
+		port_info[0]->udma_mask = 0;
+		port_info[1]->mwdma_mask = 0;
+		port_info[1]->udma_mask = 0;
+	}
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d0a0fdb..9ea1025 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -605,7 +605,7 @@ void ata_rwcmd_protocol(struct ata_queue
 	tf->command = ata_rw_cmds[index + lba48 + write];
 }
 
-static const char * xfer_mode_str[] = {
+static const char * const xfer_mode_str[] = {
 	"UDMA/16",
 	"UDMA/25",
 	"UDMA/33",
@@ -1046,28 +1046,103 @@ static unsigned int ata_pio_modes(const 
 	return modes;
 }
 
-static int ata_qc_wait_err(struct ata_queued_cmd *qc,
-			   struct completion *wait)
+struct ata_exec_internal_arg {
+	unsigned int err_mask;
+	struct ata_taskfile *tf;
+	struct completion *waiting;
+};
+
+int ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
-	int rc = 0;
+	struct ata_exec_internal_arg *arg = qc->private_data;
+	struct completion *waiting = arg->waiting;
 
-	if (wait_for_completion_timeout(wait, 30 * HZ) < 1) {
-		/* timeout handling */
-		unsigned int err_mask = ac_err_mask(ata_chk_status(qc->ap));
-
-		if (!err_mask) {
-			printk(KERN_WARNING "ata%u: slow completion (cmd %x)\n",
-			       qc->ap->id, qc->tf.command);
-		} else {
-			printk(KERN_WARNING "ata%u: qc timeout (cmd %x)\n",
-			       qc->ap->id, qc->tf.command);
-			rc = -EIO;
+	if (!(qc->err_mask & ~AC_ERR_DEV))
+		qc->ap->ops->tf_read(qc->ap, arg->tf);
+	arg->err_mask = qc->err_mask;
+	arg->waiting = NULL;
+	complete(waiting);
+
+	return 0;
+}
+
+/**
+ *	ata_exec_internal - execute libata internal command
+ *	@ap: Port to which the command is sent
+ *	@dev: Device to which the command is sent
+ *	@tf: Taskfile registers for the command and the result
+ *	@dma_dir: Data tranfer direction of the command
+ *	@buf: Data buffer of the command
+ *	@buflen: Length of data buffer
+ *
+ *	Executes libata internal command with timeout.  @tf contains
+ *	command on entry and result on return.  Timeout and error
+ *	conditions are reported via return value.  No recovery action
+ *	is taken after a command times out.  It's caller's duty to
+ *	clean up after timeout.
+ *
+ *	LOCKING:
+ *	None.  Should be called with kernel context, might sleep.
+ */
+
+static unsigned
+ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
+		  struct ata_taskfile *tf,
+		  int dma_dir, void *buf, unsigned int buflen)
+{
+	u8 command = tf->command;
+	struct ata_queued_cmd *qc;
+	DECLARE_COMPLETION(wait);
+	unsigned long flags;
+	struct ata_exec_internal_arg arg;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
+
+	qc->tf = *tf;
+	qc->dma_dir = dma_dir;
+	if (dma_dir != DMA_NONE) {
+		ata_sg_init_one(qc, buf, buflen);
+		qc->nsect = buflen / ATA_SECT_SIZE;
+	}
+
+	arg.waiting = &wait;
+	arg.tf = tf;
+	qc->private_data = &arg;
+	qc->complete_fn = ata_qc_complete_internal;
+
+	if (ata_qc_issue(qc))
+		goto issue_fail;
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (!wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL)) {
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+
+		/* We're racing with irq here.  If we lose, the
+		 * following test prevents us from completing the qc
+		 * again.  If completion irq occurs after here but
+		 * before the caller cleans up, it will result in a
+		 * spurious interrupt.  We can live with that.
+		 */
+		if (arg.waiting) {
+			qc->err_mask = AC_ERR_OTHER;
+			ata_qc_complete(qc);
+			printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
+			       ap->id, command);
 		}
 
-		ata_qc_complete(qc, err_mask);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 
-	return rc;
+	return arg.err_mask;
+
+ issue_fail:
+	ata_qc_free(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	return AC_ERR_OTHER;
 }
 
 /**
@@ -1099,9 +1174,8 @@ static void ata_dev_identify(struct ata_
 	u16 tmp;
 	unsigned long xfer_modes;
 	unsigned int using_edd;
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
+	struct ata_taskfile tf;
+	unsigned int err_mask;
 	int rc;
 
 	if (!ata_dev_present(dev)) {
@@ -1122,40 +1196,26 @@ static void ata_dev_identify(struct ata_
 
 	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
-
-	ata_sg_init_one(qc, dev->id, sizeof(dev->id));
-	qc->dma_dir = DMA_FROM_DEVICE;
-	qc->tf.protocol = ATA_PROT_PIO;
-	qc->nsect = 1;
-
 retry:
+	ata_tf_init(ap, &tf, device);
+
 	if (dev->class == ATA_DEV_ATA) {
-		qc->tf.command = ATA_CMD_ID_ATA;
+		tf.command = ATA_CMD_ID_ATA;
 		DPRINTK("do ATA identify\n");
 	} else {
-		qc->tf.command = ATA_CMD_ID_ATAPI;
+		tf.command = ATA_CMD_ID_ATAPI;
 		DPRINTK("do ATAPI identify\n");
 	}
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
+	tf.protocol = ATA_PROT_PIO;
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	err_mask = ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
+				     dev->id, sizeof(dev->id));
 
-	if (rc)
-		goto err_out;
-	else
-		ata_qc_wait_err(qc, &wait);
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->ops->tf_read(ap, &qc->tf);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	if (err_mask) {
+		if (err_mask & ~AC_ERR_DEV)
+			goto err_out;
 
-	if (qc->tf.command & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
 		 * the ATA signature for some ATAPI devices.  Until the
@@ -1168,13 +1228,9 @@ retry:
 		 * to have this problem.
 		 */
 		if ((using_edd) && (dev->class == ATA_DEV_ATA)) {
-			u8 err = qc->tf.feature;
+			u8 err = tf.feature;
 			if (err & ATA_ABORTED) {
 				dev->class = ATA_DEV_ATAPI;
-				qc->cursg = 0;
-				qc->cursg_ofs = 0;
-				qc->cursect = 0;
-				qc->nsect = 1;
 				goto retry;
 			}
 		}
@@ -1444,11 +1500,23 @@ void __sata_phy_reset(struct ata_port *a
 	} while (time_before(jiffies, timeout));
 
 	/* TODO: phy layer with polling, timeouts, etc. */
-	if (sata_dev_present(ap))
+	sstatus = scr_read(ap, SCR_STATUS);
+	if (sata_dev_present(ap)) {
+		const char *speed;
+		u32 tmp;
+
+		tmp = (sstatus >> 4) & 0xf;
+		if (tmp & (1 << 0))
+			speed = "1.5";
+		else if (tmp & (1 << 1))
+			speed = "3.0";
+		else
+			speed = "<unknown>";
+		printk(KERN_INFO "ata%u: SATA link up %s Gbps (SStatus %X)\n",
+		       ap->id, speed, sstatus);
 		ata_port_probe(ap);
-	else {
-		sstatus = scr_read(ap, SCR_STATUS);
-		printk(KERN_INFO "ata%u: no device found (phy stat %08x)\n",
+	} else {
+		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
 		       ap->id, sstatus);
 		ata_port_disable(ap);
 	}
@@ -2071,7 +2139,7 @@ static void ata_pr_blacklisted(const str
 		ap->id, dev->devno);
 }
 
-static const char * ata_dma_blacklist [] = {
+static const char * const ata_dma_blacklist [] = {
 	"WDC AC11000H",
 	"WDC AC22100H",
 	"WDC AC32500H",
@@ -2266,34 +2334,23 @@ static int ata_choose_xfer_mode(const st
 
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	int rc;
-	unsigned long flags;
+	struct ata_taskfile tf;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
-
-	qc->tf.command = ATA_CMD_SET_FEATURES;
-	qc->tf.feature = SETFEATURES_XFER;
-	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	qc->tf.protocol = ATA_PROT_NODATA;
-	qc->tf.nsect = dev->xfer_mode;
-
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	ata_tf_init(ap, &tf, dev->devno);
+	tf.command = ATA_CMD_SET_FEATURES;
+	tf.feature = SETFEATURES_XFER;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.nsect = dev->xfer_mode;
 
-	if (rc)
+	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
+		printk(KERN_ERR "ata%u: failed to set xfermode, disabled\n",
+		       ap->id);
 		ata_port_disable(ap);
-	else
-		ata_qc_wait_err(qc, &wait);
+	}
 
 	DPRINTK("EXIT\n");
 }
@@ -2308,41 +2365,25 @@ static void ata_dev_set_xfermode(struct 
 
 static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
-	int rc;
-
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
+	struct ata_taskfile tf;
 
-	ata_sg_init_one(qc, dev->id, sizeof(dev->id));
-	qc->dma_dir = DMA_FROM_DEVICE;
+	ata_tf_init(ap, &tf, dev->devno);
 
 	if (dev->class == ATA_DEV_ATA) {
-		qc->tf.command = ATA_CMD_ID_ATA;
+		tf.command = ATA_CMD_ID_ATA;
 		DPRINTK("do ATA identify\n");
 	} else {
-		qc->tf.command = ATA_CMD_ID_ATAPI;
+		tf.command = ATA_CMD_ID_ATAPI;
 		DPRINTK("do ATAPI identify\n");
 	}
 
-	qc->tf.flags |= ATA_TFLAG_DEVICE;
-	qc->tf.protocol = ATA_PROT_PIO;
-	qc->nsect = 1;
-
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	tf.flags |= ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_PIO;
 
-	if (rc)
+	if (ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
+			      dev->id, sizeof(dev->id)))
 		goto err_out;
 
-	ata_qc_wait_err(qc, &wait);
-
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
 	ata_dump_id(dev);
@@ -2351,6 +2392,7 @@ static void ata_dev_reread_id(struct ata
 
 	return;
 err_out:
+	printk(KERN_ERR "ata%u: failed to reread ID, disabled\n", ap->id);
 	ata_port_disable(ap);
 }
 
@@ -2364,10 +2406,7 @@ err_out:
 
 static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	int rc;
-	unsigned long flags;
+	struct ata_taskfile tf;
 	u16 sectors = dev->id[6];
 	u16 heads   = dev->id[3];
 
@@ -2378,26 +2417,18 @@ static void ata_dev_init_params(struct a
 	/* set up init dev params taskfile */
 	DPRINTK("init dev params \n");
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
-
-	qc->tf.command = ATA_CMD_INIT_DEV_PARAMS;
-	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	qc->tf.protocol = ATA_PROT_NODATA;
-	qc->tf.nsect = sectors;
-	qc->tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
-
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	ata_tf_init(ap, &tf, dev->devno);
+	tf.command = ATA_CMD_INIT_DEV_PARAMS;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.nsect = sectors;
+	tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
-	if (rc)
+	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
+		printk(KERN_ERR "ata%u: failed to init parameters, disabled\n",
+		       ap->id);
 		ata_port_disable(ap);
-	else
-		ata_qc_wait_err(qc, &wait);
+	}
 
 	DPRINTK("EXIT\n");
 }
@@ -2765,7 +2796,7 @@ skip_map:
  *	None.  (grabs host lock)
  */
 
-void ata_poll_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+void ata_poll_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
@@ -2773,7 +2804,7 @@ void ata_poll_qc_complete(struct ata_que
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	ap->flags &= ~ATA_FLAG_NOINTR;
 	ata_irq_on(ap);
-	ata_qc_complete(qc, err_mask);
+	ata_qc_complete(qc);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
 
@@ -2790,10 +2821,14 @@ void ata_poll_qc_complete(struct ata_que
 
 static unsigned long ata_pio_poll(struct ata_port *ap)
 {
+	struct ata_queued_cmd *qc;
 	u8 status;
 	unsigned int poll_state = HSM_ST_UNKNOWN;
 	unsigned int reg_state = HSM_ST_UNKNOWN;
 
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
+
 	switch (ap->hsm_task_state) {
 	case HSM_ST:
 	case HSM_ST_POLL:
@@ -2813,6 +2848,7 @@ static unsigned long ata_pio_poll(struct
 	status = ata_chk_status(ap);
 	if (status & ATA_BUSY) {
 		if (time_after(jiffies, ap->pio_task_timeout)) {
+			qc->err_mask |= AC_ERR_ATA_BUS;
 			ap->hsm_task_state = HSM_ST_TMOUT;
 			return 0;
 		}
@@ -2847,29 +2883,31 @@ static int ata_pio_complete (struct ata_
 	 * msecs, then chk-status again.  If still busy, fall back to
 	 * HSM_ST_POLL state.
 	 */
-	drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
-	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+	drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
+	if (drv_stat & ATA_BUSY) {
 		msleep(2);
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
-		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+		drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
+		if (drv_stat & ATA_BUSY) {
 			ap->hsm_task_state = HSM_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
 			return 0;
 		}
 	}
 
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
+
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
+		qc->err_mask |= __ac_err_mask(drv_stat);
 		ap->hsm_task_state = HSM_ST_ERR;
 		return 0;
 	}
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
-
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, 0);
+	assert(qc->err_mask == 0);
+	ata_poll_qc_complete(qc);
 
 	/* another command may start at this point */
 
@@ -3177,6 +3215,7 @@ static void atapi_pio_bytes(struct ata_q
 err_out:
 	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
 	      ap->id, dev->devno);
+	qc->err_mask |= AC_ERR_ATA_BUS;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
 
@@ -3215,8 +3254,16 @@ static void ata_pio_block(struct ata_por
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
+	/* check error */
+	if (status & (ATA_ERR | ATA_DF)) {
+		qc->err_mask |= AC_ERR_DEV;
+		ap->hsm_task_state = HSM_ST_ERR;
+		return;
+	}
+
+	/* transfer data if any */
 	if (is_atapi_taskfile(&qc->tf)) {
-		/* no more data to transfer or unsupported ATAPI command */
+		/* DRQ=0 means no more data to transfer */
 		if ((status & ATA_DRQ) == 0) {
 			ap->hsm_task_state = HSM_ST_LAST;
 			return;
@@ -3226,6 +3273,7 @@ static void ata_pio_block(struct ata_por
 	} else {
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
+			qc->err_mask |= AC_ERR_ATA_BUS;
 			ap->hsm_task_state = HSM_ST_ERR;
 			return;
 		}
@@ -3243,9 +3291,14 @@ static void ata_pio_error(struct ata_por
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
+	/* make sure qc->err_mask is available to 
+	 * know what's wrong and recover
+	 */
+	assert(qc->err_mask);
+
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	ata_poll_qc_complete(qc, AC_ERR_ATA_BUS);
+	ata_poll_qc_complete(qc);
 }
 
 static void ata_pio_task(void *_data)
@@ -3347,7 +3400,8 @@ static void ata_qc_timeout(struct ata_qu
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, ac_err_mask(drv_stat));
+		qc->err_mask |= ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 	}
 
@@ -3446,15 +3500,10 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask)
-{
-	return 0;
-}
-
 static void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int tag, do_clear = 0;
+	unsigned int tag;
 
 	qc->flags = 0;
 	tag = qc->tag;
@@ -3462,17 +3511,8 @@ static void __ata_qc_complete(struct ata
 		if (tag == ap->active_tag)
 			ap->active_tag = ATA_TAG_POISON;
 		qc->tag = ATA_TAG_POISON;
-		do_clear = 1;
-	}
-
-	if (qc->waiting) {
-		struct completion *waiting = qc->waiting;
-		qc->waiting = NULL;
-		complete(waiting);
-	}
-
-	if (likely(do_clear))
 		clear_bit(tag, &ap->qactive);
+	}
 }
 
 /**
@@ -3488,7 +3528,6 @@ static void __ata_qc_complete(struct ata
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
-	assert(qc->waiting == NULL);	/* nothing should be waiting */
 
 	__ata_qc_complete(qc);
 }
@@ -3505,7 +3544,7 @@ void ata_qc_free(struct ata_queued_cmd *
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+void ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	int rc;
 
@@ -3522,7 +3561,7 @@ void ata_qc_complete(struct ata_queued_c
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc, err_mask);
+	rc = qc->complete_fn(qc);
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3960,7 +3999,8 @@ inline unsigned int ata_host_intr (struc
 		ap->ops->irq_clear(ap);
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc, ac_err_mask(status));
+		qc->err_mask |= ac_err_mask(status);
+		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -4054,13 +4094,17 @@ static void atapi_packet_task(void *_dat
 
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
-	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
-		goto err_out_status;
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
+		qc->err_mask |= AC_ERR_ATA_BUS;
+		goto err_out;
+	}
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
-	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
+	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
+		qc->err_mask |= AC_ERR_ATA_BUS;
 		goto err_out;
+	}
 
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
@@ -4092,10 +4136,8 @@ static void atapi_packet_task(void *_dat
 
 	return;
 
-err_out_status:
-	status = ata_chk_status(ap);
 err_out:
-	ata_poll_qc_complete(qc, __ac_err_mask(status));
+	ata_poll_qc_complete(qc);
 }
 
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 2282c04..e0439be 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -418,7 +418,7 @@ void ata_to_sense_error(unsigned id, u8 
 	int i;
 
 	/* Based on the 3ware driver translation table */
-	static unsigned char sense_table[][4] = {
+	static const unsigned char sense_table[][4] = {
 		/* BBD|ECC|ID|MAR */
 		{0xd1, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Device busy                  Aborted command
 		/* BBD|ECC|ID */
@@ -449,7 +449,7 @@ void ata_to_sense_error(unsigned id, u8 
 		{0x80, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Block marked bad		  Medium error, unrecovered read error
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
-	static unsigned char stat_table[][4] = {
+	static const unsigned char stat_table[][4] = {
 		/* Must be first because BUSY means no other bits valid */
 		{0x80, 		ABORTED_COMMAND, 0x47, 0x00},	// Busy, fake parity for now
 		{0x20, 		HARDWARE_ERROR,  0x00, 0x00}, 	// Device fault
@@ -1203,12 +1203,11 @@ nothing_to_do:
 	return 1;
 }
 
-static int ata_scsi_qc_complete(struct ata_queued_cmd *qc,
-				unsigned int err_mask)
+static int ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
- 	int need_sense = (err_mask != 0);
+ 	int need_sense = (qc->err_mask != 0);
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
@@ -1532,7 +1531,7 @@ unsigned int ata_scsiop_inq_80(struct at
 	return 0;
 }
 
-static const char *inq_83_str = "Linux ATA-SCSI simulator";
+static const char * const inq_83_str = "Linux ATA-SCSI simulator";
 
 /**
  *	ata_scsiop_inq_83 - Simulate INQUIRY EVPD page 83, device identity
@@ -1955,9 +1954,9 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	done(cmd);
 }
 
-static int atapi_sense_complete(struct ata_queued_cmd *qc,unsigned int err_mask)
+static int atapi_sense_complete(struct ata_queued_cmd *qc)
 {
-	if (err_mask && ((err_mask & AC_ERR_DEV) == 0))
+	if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0))
 		/* FIXME: not quite right; we don't want the
 		 * translation of taskfile registers into
 		 * a sense descriptors, since that's only
@@ -2015,15 +2014,18 @@ static void atapi_request_sense(struct a
 
 	qc->complete_fn = atapi_sense_complete;
 
-	if (ata_qc_issue(qc))
-		ata_qc_complete(qc, AC_ERR_OTHER);
+	if (ata_qc_issue(qc)) {
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
+	}
 
 	DPRINTK("EXIT\n");
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+static int atapi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	unsigned int err_mask = qc->err_mask;
 
 	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 8ebaa69..251e53b 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -39,7 +39,6 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
-extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index f557f17..e8df0c9 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -464,14 +464,12 @@ static inline unsigned int adma_intr_pkt
 			continue;
 		qc = ata_qc_from_tag(ap, ap->active_tag);
 		if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
-			unsigned int err_mask = 0;
-
 			if ((status & (aPERR | aPSD | aUIRQ)))
-				err_mask = AC_ERR_OTHER;
+				qc->err_mask |= AC_ERR_OTHER;
 			else if (pp->pkt[0] != cDONE)
-				err_mask = AC_ERR_OTHER;
+				qc->err_mask |= AC_ERR_OTHER;
 
-			ata_qc_complete(qc, err_mask);
+			ata_qc_complete(qc);
 		}
 	}
 	return handled;
@@ -501,7 +499,8 @@ static inline unsigned int adma_intr_mmi
 		
 				/* complete taskfile transaction */
 				pp->state = adma_state_idle;
-				ata_qc_complete(qc, ac_err_mask(status));
+				qc->err_mask |= ac_err_mask(status);
+				ata_qc_complete(qc);
 				handled = 1;
 			}
 		}
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 9321cdf..b2bf16a 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -431,7 +431,7 @@ static const struct ata_port_operations 
 	.host_stop		= mv_host_stop,
 };
 
-static struct ata_port_info mv_port_info[] = {
+static const struct ata_port_info mv_port_info[] = {
 	{  /* chip_504x */
 		.sht		= &mv_sht,
 		.host_flags	= MV_COMMON_FLAGS,
@@ -1243,8 +1243,10 @@ static void mv_host_intr(struct ata_host
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
-				if (!(qc->tf.ctl & ATA_NIEN))
-					ata_qc_complete(qc, err_mask);
+				if (!(qc->tf.ctl & ATA_NIEN)) {
+					qc->err_mask |= err_mask;
+					ata_qc_complete(qc);
+				}
 			}
 		}
 	}
@@ -1865,7 +1867,8 @@ static void mv_eng_timeout(struct ata_po
 	 	 */
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, AC_ERR_OTHER);
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 }
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 2691625..da7fa04 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -161,7 +161,7 @@ static const struct ata_port_operations 
 	.host_stop		= ata_pci_host_stop,
 };
 
-static struct ata_port_info pdc_port_info[] = {
+static const struct ata_port_info pdc_port_info[] = {
 	/* board_2037x */
 	{
 		.sht		= &pdc_ata_sht,
@@ -401,7 +401,8 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 		drv_stat = ata_wait_idle(ap);
-		ata_qc_complete(qc, __ac_err_mask(drv_stat));
+		qc->err_mask |= __ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -410,7 +411,8 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, ac_err_mask(drv_stat));
+		qc->err_mask |= ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 	}
 
@@ -422,21 +424,21 @@ out:
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
                                           struct ata_queued_cmd *qc)
 {
-	unsigned int handled = 0, err_mask = 0;
+	unsigned int handled = 0;
 	u32 tmp;
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_GLOBAL_CTL;
 
 	tmp = readl(mmio);
 	if (tmp & PDC_ERR_MASK) {
-		err_mask = AC_ERR_DEV;
+		qc->err_mask |= AC_ERR_DEV;
 		pdc_reset_port(ap);
 	}
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
-		err_mask |= ac_err_mask(ata_wait_idle(ap));
-		ata_qc_complete(qc, err_mask);
+		qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
+		ata_qc_complete(qc);
 		handled = 1;
 		break;
 
@@ -703,7 +705,7 @@ static int pdc_ata_init_one (struct pci_
 		probe_ent->port[3].scr_addr = base + 0x700;
 		break;
 	case board_2037x:
-       		probe_ent->n_ports = 2;
+		probe_ent->n_ports = 2;
 		break;
 	case board_20619:
 		probe_ent->n_ports = 4;
@@ -713,7 +715,7 @@ static int pdc_ata_init_one (struct pci_
 
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
-                break;
+		break;
 	default:
 		BUG();
 		break;
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index a8987f5..de05e28 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -170,7 +170,7 @@ static const struct ata_port_operations 
 	.bmdma_status		= qs_bmdma_status,
 };
 
-static struct ata_port_info qs_port_info[] = {
+static const struct ata_port_info qs_port_info[] = {
 	/* board_2068_idx */
 	{
 		.sht		= &qs_ata_sht,
@@ -409,8 +409,8 @@ static inline unsigned int qs_intr_pkt(s
 					case 3: /* device error */
 						pp->state = qs_state_idle;
 						qs_enter_reg_mode(qc->ap);
-						ata_qc_complete(qc,
-							ac_err_mask(sDST));
+						qc->err_mask |= ac_err_mask(sDST);
+						ata_qc_complete(qc);
 						break;
 					default:
 						break;
@@ -447,7 +447,8 @@ static inline unsigned int qs_intr_mmio(
 
 				/* complete taskfile transaction */
 				pp->state = qs_state_idle;
-				ata_qc_complete(qc, ac_err_mask(status));
+				qc->err_mask |= ac_err_mask(status);
+				ata_qc_complete(qc);
 				handled = 1;
 			}
 		}
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 3609186..d205348 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -176,7 +176,7 @@ static const struct ata_port_operations 
 	.host_stop		= ata_pci_host_stop,
 };
 
-static struct ata_port_info sil_port_info[] = {
+static const struct ata_port_info sil_port_info[] = {
 	/* sil_3112 */
 	{
 		.sht		= &sil_sht,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index e0d6f19..a0ad3ed 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -654,7 +654,8 @@ static void sil24_eng_timeout(struct ata
 	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 	qc->scsidone = scsi_finish_command;
-	ata_qc_complete(qc, AC_ERR_OTHER);
+	qc->err_mask |= AC_ERR_OTHER;
+	ata_qc_complete(qc);
 
 	sil24_reset_controller(ap);
 }
@@ -711,8 +712,10 @@ static void sil24_error_intr(struct ata_
 		sil24_reset_controller(ap);
 	}
 
-	if (qc)
-		ata_qc_complete(qc, err_mask);
+	if (qc) {
+		qc->err_mask |= err_mask;
+		ata_qc_complete(qc);
+	}
 }
 
 static inline void sil24_host_intr(struct ata_port *ap)
@@ -734,8 +737,10 @@ static inline void sil24_host_intr(struc
 		 */
 		sil24_update_tf(ap);
 
-		if (qc)
-			ata_qc_complete(qc, ac_err_mask(pp->tf.command));
+		if (qc) {
+			qc->err_mask |= ac_err_mask(pp->tf.command);
+			ata_qc_complete(qc);
+		}
 	} else
 		sil24_error_intr(ap, slot_stat);
 }
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index ac7b0d8..94b253b 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -215,7 +215,7 @@ static const struct ata_port_operations 
 	.host_stop		= pdc20621_host_stop,
 };
 
-static struct ata_port_info pdc_port_info[] = {
+static const struct ata_port_info pdc_port_info[] = {
 	/* board_20621 */
 	{
 		.sht		= &pdc_sata_sht,
@@ -719,7 +719,8 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ac_err_mask(ata_wait_idle(ap)));
+			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
+			ata_qc_complete(qc);
 			pdc20621_pop_hdma(qc);
 		}
 
@@ -757,7 +758,8 @@ static inline unsigned int pdc20621_host
 			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->id,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
-			ata_qc_complete(qc, ac_err_mask(ata_wait_idle(ap)));
+			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
+			ata_qc_complete(qc);
 			pdc20621_pop_hdma(qc);
 		}
 		handled = 1;
@@ -767,7 +769,8 @@ static inline unsigned int pdc20621_host
 
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, ac_err_mask(status));
+		qc->err_mask |= ac_err_mask(status);
+		ata_qc_complete(qc);
 		handled = 1;
 
 	} else {
@@ -882,7 +885,8 @@ static void pdc_eng_timeout(struct ata_p
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-		ata_qc_complete(qc, __ac_err_mask(ata_wait_idle(ap)));
+		qc->err_mask |= __ac_err_mask(ata_wait_idle(ap));
+		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -891,7 +895,8 @@ static void pdc_eng_timeout(struct ata_p
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, ac_err_mask(drv_stat));
+		qc->err_mask |= ac_err_mask(drv_stat);
+		ata_qc_complete(qc);
 		break;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 41ea7db..e828e17 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -136,6 +136,8 @@ enum {
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* hueristic */
 	ATA_TMOUT_CDB		= 30 * HZ,
 	ATA_TMOUT_CDB_QUICK	= 5 * HZ,
+	ATA_TMOUT_INTERNAL	= 30 * HZ,
+	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
@@ -195,7 +197,7 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc, unsigned int err_mask);
+typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -280,9 +282,9 @@ struct ata_queued_cmd {
 	/* DO NOT iterate over __sg manually, use ata_for_each_sg() */
 	struct scatterlist	*__sg;
 
-	ata_qc_cb_t		complete_fn;
+	unsigned int		err_mask;
 
-	struct completion	*waiting;
+	ata_qc_cb_t		complete_fn;
 
 	void			*private_data;
 };
@@ -331,8 +333,6 @@ struct ata_port {
 
 	u8			ctl;	/* cache of ATA control register */
 	u8			last_ctl;	/* Cache last written value */
-	unsigned int		bus_state;
-	unsigned int		port_state;
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
@@ -478,7 +478,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask);
+extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
@@ -670,6 +670,7 @@ static inline void ata_qc_reinit(struct 
 	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 	qc->nsect = 0;
 	qc->nbytes = qc->curbytes = 0;
+	qc->err_mask = 0;
 
 	ata_tf_init(qc->ap, &qc->tf, qc->dev->devno);
 }
