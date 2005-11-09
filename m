Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbVKIGyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVKIGyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 01:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKIGyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 01:54:31 -0500
Received: from havoc.gtf.org ([69.61.125.42]:47503 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965171AbVKIGya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 01:54:30 -0500
Date: Wed, 9 Nov 2005 01:54:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata updates
Message-ID: <20051109065429.GA16794@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following minor updates, and a fix:

 drivers/scsi/ahci.c         |    4 ++--
 drivers/scsi/ata_piix.c     |    3 +--
 drivers/scsi/libata-core.c  |   11 +++++------
 drivers/scsi/libata-scsi.c  |    9 +++++----
 drivers/scsi/pdc_adma.c     |    3 +--
 drivers/scsi/sata_mv.c      |    4 ++--
 drivers/scsi/sata_nv.c      |    3 +--
 drivers/scsi/sata_promise.c |    4 ++--
 drivers/scsi/sata_qstor.c   |    3 +--
 drivers/scsi/sata_sil.c     |    3 +--
 drivers/scsi/sata_sil24.c   |    4 ++--
 drivers/scsi/sata_sis.c     |    3 +--
 drivers/scsi/sata_svw.c     |    3 +--
 drivers/scsi/sata_sx4.c     |    4 ++--
 drivers/scsi/sata_uli.c     |    3 +--
 drivers/scsi/sata_via.c     |    3 +--
 drivers/scsi/sata_vsc.c     |    3 +--
 include/linux/libata.h      |    6 +++---
 18 files changed, 33 insertions(+), 43 deletions(-)

Albert Lee:
      libata: if condition fix for ata_dev_identify()

Jeff Garzik:
      [libata] eliminate use of drivers/scsi/scsi.h compatibility header/defines
      Merge branch 'master'

Randy Dunlap:
      libata kernel-doc fixes

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 4612312..10c470e 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -42,8 +42,8 @@
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <asm/io.h>
 
@@ -196,7 +196,7 @@ static u8 ahci_check_status(struct ata_p
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 static void ahci_remove_one (struct pci_dev *pdev);
 
-static Scsi_Host_Template ahci_sht = {
+static struct scsi_host_template ahci_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 7f8aa1b..a1bd8d9 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -46,7 +46,6 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
@@ -128,7 +127,7 @@ static struct pci_driver piix_pci_driver
 	.remove			= ata_pci_remove_one,
 };
 
-static Scsi_Host_Template piix_sht = {
+static struct scsi_host_template piix_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1c1a7ca..a74b407 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -51,8 +51,8 @@
 #include <linux/jiffies.h>
 #include <linux/scatterlist.h>
 #include <scsi/scsi.h>
-#include "scsi.h"
 #include "scsi_priv.h"
+#include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 #include <asm/io.h>
@@ -1144,7 +1144,7 @@ retry:
 		 * ATA software reset (SRST, the default) does not appear
 		 * to have this problem.
 		 */
-		if ((using_edd) && (qc->tf.command == ATA_CMD_ID_ATA)) {
+		if ((using_edd) && (dev->class == ATA_DEV_ATA)) {
 			u8 err = qc->tf.feature;
 			if (err & ATA_ABORTED) {
 				dev->class = ATA_DEV_ATAPI;
@@ -2713,7 +2713,7 @@ static int ata_sg_setup(struct ata_queue
 /**
  *	ata_poll_qc_complete - turn irq back on and finish qc
  *	@qc: Command to complete
- *	@drv_stat: ATA status register content
+ *	@err_mask: ATA status register content
  *
  *	LOCKING:
  *	None.  (grabs host lock)
@@ -2747,7 +2747,6 @@ static unsigned long ata_pio_poll(struct
 	u8 status;
 	unsigned int poll_state = HSM_ST_UNKNOWN;
 	unsigned int reg_state = HSM_ST_UNKNOWN;
-	const unsigned int tmout_state = HSM_ST_TMOUT;
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST:
@@ -2768,7 +2767,7 @@ static unsigned long ata_pio_poll(struct
 	status = ata_chk_status(ap);
 	if (status & ATA_BUSY) {
 		if (time_after(jiffies, ap->pio_task_timeout)) {
-			ap->hsm_task_state = tmout_state;
+			ap->hsm_task_state = HSM_ST_TMOUT;
 			return 0;
 		}
 		ap->hsm_task_state = poll_state;
@@ -3478,7 +3477,7 @@ void ata_qc_free(struct ata_queued_cmd *
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
- *	@drv_stat: ATA Status register contents
+ *	@err_mask: ATA Status register contents
  *
  *	Indicate to the mid and upper layers that an ATA
  *	command has completed, with either an ok or not-ok status.
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index eb604b0..bb30fcd 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -37,9 +37,9 @@
 #include <linux/blkdev.h>
 #include <linux/spinlock.h>
 #include <scsi/scsi.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
+#include <scsi/scsi_request.h>
 #include <linux/libata.h>
 #include <linux/hdreg.h>
 #include <asm/uaccess.h>
@@ -131,7 +131,7 @@ int ata_std_bios_param(struct scsi_devic
 
 /**
  *	ata_cmd_ioctl - Handler for HDIO_DRIVE_CMD ioctl
- *	@dev: Device to whom we are issuing command
+ *	@scsidev: Device to which we are issuing command
  *	@arg: User provided data for issuing command
  *
  *	LOCKING:
@@ -217,7 +217,7 @@ error:
 
 /**
  *	ata_task_ioctl - Handler for HDIO_DRIVE_TASK ioctl
- *	@dev: Device to whom we are issuing command
+ *	@scsidev: Device to which we are issuing command
  *	@arg: User provided data for issuing command
  *
  *	LOCKING:
@@ -416,6 +416,7 @@ void ata_dump_status(unsigned id, struct
 
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
+ *	@id: ATA device number
  *	@drv_stat: value contained in ATA status register
  *	@drv_err: value contained in ATA error register
  *	@sk: the sense key we'll fill out
@@ -2231,7 +2232,7 @@ ata_scsi_map_proto(u8 byte1)
 /**
  *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
  *	@qc: command structure to be initialized
- *	@cmd: SCSI command to convert
+ *	@scsicmd: SCSI command to convert
  *
  *	Handles either 12 or 16-byte versions of the CDB.
  *
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index a50588c..78b4ff1 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -41,7 +41,6 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <asm/io.h>
 #include <linux/libata.h>
@@ -139,7 +138,7 @@ static u8 adma_bmdma_status(struct ata_p
 static void adma_irq_clear(struct ata_port *ap);
 static void adma_eng_timeout(struct ata_port *ap);
 
-static Scsi_Host_Template adma_ata_sht = {
+static struct scsi_host_template adma_ata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 0f469e3..93d5523 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -30,8 +30,8 @@
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <asm/io.h>
 
@@ -270,7 +270,7 @@ static irqreturn_t mv_interrupt(int irq,
 static void mv_eng_timeout(struct ata_port *ap);
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 
-static Scsi_Host_Template mv_sht = {
+static struct scsi_host_template mv_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index d573888..37a4fae 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -62,7 +62,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
@@ -219,7 +218,7 @@ static struct pci_driver nv_pci_driver =
 	.remove			= ata_pci_remove_one,
 };
 
-static Scsi_Host_Template nv_sht = {
+static struct scsi_host_template nv_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index b41c977..9edc9d9 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -39,8 +39,8 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <asm/io.h>
 #include "sata_promise.h"
@@ -94,7 +94,7 @@ static void pdc_irq_clear(struct ata_por
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 
 
-static Scsi_Host_Template pdc_ata_sht = {
+static struct scsi_host_template pdc_ata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 65502c1..d274ab2 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -36,7 +36,6 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <asm/io.h>
 #include <linux/libata.h>
@@ -128,7 +127,7 @@ static u8 qs_bmdma_status(struct ata_por
 static void qs_irq_clear(struct ata_port *ap);
 static void qs_eng_timeout(struct ata_port *ap);
 
-static Scsi_Host_Template qs_ata_sht = {
+static struct scsi_host_template qs_ata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 435f7e0..d0e3c3c 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -42,7 +42,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
@@ -131,7 +130,7 @@ static struct pci_driver sil_pci_driver 
 	.remove			= ata_pci_remove_one,
 };
 
-static Scsi_Host_Template sil_sht = {
+static struct scsi_host_template sil_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index e6c8e89..4682a50 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -37,7 +37,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
-#include "scsi.h"
+#include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <asm/io.h>
 
@@ -255,7 +255,7 @@ static struct pci_driver sil24_pci_drive
 	.remove			= ata_pci_remove_one, /* safe? */
 };
 
-static Scsi_Host_Template sil24_sht = {
+static struct scsi_host_template sil24_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 42288be..42d7c4e 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -39,7 +39,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
@@ -83,7 +82,7 @@ static struct pci_driver sis_pci_driver 
 	.remove			= ata_pci_remove_one,
 };
 
-static Scsi_Host_Template sis_sht = {
+static struct scsi_host_template sis_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index db615ff..9895d1c 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -45,7 +45,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
@@ -284,7 +283,7 @@ static int k2_sata_proc_info(struct Scsi
 #endif /* CONFIG_PPC_OF */
 
 
-static Scsi_Host_Template k2_sata_sht = {
+static struct scsi_host_template k2_sata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index f859bbd..d5a3878 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -39,8 +39,8 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <asm/io.h>
 #include "sata_promise.h"
@@ -177,7 +177,7 @@ static void pdc20621_irq_clear(struct at
 static int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
 
 
-static Scsi_Host_Template pdc_sata_sht = {
+static struct scsi_host_template pdc_sata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index a5e245c..cf0baaa 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -33,7 +33,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
@@ -71,7 +70,7 @@ static struct pci_driver uli_pci_driver 
 	.remove			= ata_pci_remove_one,
 };
 
-static Scsi_Host_Template uli_sht = {
+static struct scsi_host_template uli_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index b3ecdbe..ab19d2b 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -42,7 +42,6 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 #include <asm/io.h>
@@ -90,7 +89,7 @@ static struct pci_driver svia_pci_driver
 	.remove			= ata_pci_remove_one,
 };
 
-static Scsi_Host_Template svia_sht = {
+static struct scsi_host_template svia_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index bb84ba0..ce8a2fd 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -43,7 +43,6 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
-#include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
@@ -219,7 +218,7 @@ static irqreturn_t vsc_sata_interrupt (i
 }
 
 
-static Scsi_Host_Template vsc_sata_sht = {
+static struct scsi_host_template vsc_sata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index dcd17e7..6f07522 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -214,7 +214,7 @@ struct ata_probe_ent {
 	struct list_head	node;
 	struct device 		*dev;
 	const struct ata_port_operations *port_ops;
-	Scsi_Host_Template	*sht;
+	struct scsi_host_template *sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
 	unsigned int		hard_port_no;
@@ -398,7 +398,7 @@ struct ata_port_operations {
 };
 
 struct ata_port_info {
-	Scsi_Host_Template	*sht;
+	struct scsi_host_template *sht;
 	unsigned long		host_flags;
 	unsigned long		pio_mask;
 	unsigned long		mwdma_mask;
@@ -433,7 +433,7 @@ extern void ata_pci_remove_one (struct p
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_set_remove(struct ata_host_set *host_set);
-extern int ata_scsi_detect(Scsi_Host_Template *sht);
+extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_error(struct Scsi_Host *host);
