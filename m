Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVJaO2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVJaO2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVJaO2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:28:40 -0500
Received: from havoc.gtf.org ([69.61.125.42]:17823 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751276AbVJaO2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:28:38 -0500
Date: Mon, 31 Oct 2005 09:28:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata fixes, cleanup
Message-ID: <20051031142835.GA30792@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the following locking rewrite (deadlock fix), and minor cleanups.

 drivers/scsi/libata-core.c |   59 +++++++--------------------------------------
 drivers/scsi/libata-scsi.c |    9 ++++++
 drivers/scsi/libata.h      |    1 
 3 files changed, 18 insertions(+), 51 deletions(-)

commit 005a5a06a6dd13a0ca3f2c6a0218e8d94ed36d8a
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Sun Oct 30 23:31:48 2005 -0500

    [libata] locking rewrite (== fix)
    
    A lot of power packed into a little patch.
    
    This change eliminates the sharing between our controller-wide spinlock
    and the SCSI core's Scsi_Host lock.  As the locking in libata was
    already highly compartmentalized, always referencing our own lock, and
    never scsi_host::host_lock.
    
    As a side effect, this change eliminates a deadlock from calling
    scsi_finish_command() while inside our spinlock.

commit e533825447dcb60a82b7cc9d73d06423c849b9a2
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Sun Oct 30 21:37:17 2005 -0500

    [libata] ata_tf_to_host cleanups
    
    Integrate ata_exec() and ata_tf_to_host() into their only caller,
    ata_bus_edd().
    
    Rename ata_tf_to_host_nolock() to ata_tf_to_host().
    
    This makes locking a bit easier to review, and may help pave the way for
    future changes.

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8be7dc0..ff18fa7 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -295,28 +295,6 @@ void ata_exec_command(struct ata_port *a
 }
 
 /**
- *	ata_exec - issue ATA command to host controller
- *	@ap: port to which command is being issued
- *	@tf: ATA taskfile register set
- *
- *	Issues PIO/MMIO write to ATA command register, with proper
- *	synchronization with interrupt handler / other threads.
- *
- *	LOCKING:
- *	Obtains host_set lock.
- */
-
-static inline void ata_exec(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	unsigned long flags;
-
-	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->ops->exec_command(ap, tf);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-}
-
-/**
  *	ata_tf_to_host - issue ATA taskfile to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
@@ -326,30 +304,11 @@ static inline void ata_exec(struct ata_p
  *	other threads.
  *
  *	LOCKING:
- *	Obtains host_set lock.
- */
-
-static void ata_tf_to_host(struct ata_port *ap, const struct ata_taskfile *tf)
-{
-	ap->ops->tf_load(ap, tf);
-
-	ata_exec(ap, tf);
-}
-
-/**
- *	ata_tf_to_host_nolock - issue ATA taskfile to host controller
- *	@ap: port to which command is being issued
- *	@tf: ATA taskfile register set
- *
- *	Issues ATA taskfile register set to ATA host controller,
- *	with proper synchronization with interrupt handler and
- *	other threads.
- *
- *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_tf_to_host_nolock(struct ata_port *ap, const struct ata_taskfile *tf)
+static inline void ata_tf_to_host(struct ata_port *ap,
+				  const struct ata_taskfile *tf)
 {
 	ap->ops->tf_load(ap, tf);
 	ap->ops->exec_command(ap, tf);
@@ -1912,12 +1871,14 @@ static void ata_bus_post_reset(struct at
  *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
+ *	Obtains host_set lock.
  *
  */
 
 static unsigned int ata_bus_edd(struct ata_port *ap)
 {
 	struct ata_taskfile tf;
+	unsigned long flags;
 
 	/* set up execute-device-diag (bus reset) taskfile */
 	/* also, take interrupts to a known state (disabled) */
@@ -1928,7 +1889,9 @@ static unsigned int ata_bus_edd(struct a
 	tf.protocol = ATA_PROT_NODATA;
 
 	/* do bus reset */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
 	ata_tf_to_host(ap, &tf);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	/* spec says at least 2ms.  but who knows with those
 	 * crazy ATAPI devices...
@@ -3555,7 +3518,7 @@ int ata_qc_issue_prot(struct ata_queued_
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NODATA:
-		ata_tf_to_host_nolock(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf);
 		break;
 
 	case ATA_PROT_DMA:
@@ -3566,20 +3529,20 @@ int ata_qc_issue_prot(struct ata_queued_
 
 	case ATA_PROT_PIO: /* load tf registers, initiate polling pio */
 		ata_qc_set_polling(qc);
-		ata_tf_to_host_nolock(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf);
 		ap->hsm_task_state = HSM_ST;
 		queue_work(ata_wq, &ap->pio_task);
 		break;
 
 	case ATA_PROT_ATAPI:
 		ata_qc_set_polling(qc);
-		ata_tf_to_host_nolock(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf);
 		queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
 		ap->flags |= ATA_FLAG_NOINTR;
-		ata_tf_to_host_nolock(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf);
 		queue_work(ata_wq, &ap->packet_task);
 		break;
 
@@ -4126,8 +4089,6 @@ static void ata_host_init(struct ata_por
 	host->unique_id = ata_unique_id++;
 	host->max_cmd_len = 12;
 
-	scsi_assign_lock(host, &host_set->lock);
-
 	ap->flags = ATA_FLAG_PORT_DISABLED;
 	ap->id = host->unique_id;
 	ap->host = host;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 1e3792f..248baae 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -39,6 +39,7 @@
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 #include <linux/hdreg.h>
 #include <asm/uaccess.h>
@@ -2405,8 +2406,12 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 	struct ata_port *ap;
 	struct ata_device *dev;
 	struct scsi_device *scsidev = cmd->device;
+	struct Scsi_Host *shost = scsidev->host;
 
-	ap = (struct ata_port *) &scsidev->host->hostdata[0];
+	ap = (struct ata_port *) &shost->hostdata[0];
+
+	spin_unlock(shost->host_lock);
+	spin_lock(&ap->host_set->lock);
 
 	ata_scsi_dump_cdb(ap, cmd);
 
@@ -2429,6 +2434,8 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
 out_unlock:
+	spin_unlock(&ap->host_set->lock);
+	spin_lock(shost->host_lock);
 	return 0;
 }
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 10ecd9e..fad051c 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -48,7 +48,6 @@ extern int ata_qc_issue(struct ata_queue
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
-extern void ata_tf_to_host_nolock(struct ata_port *ap, const struct ata_taskfile *tf);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
